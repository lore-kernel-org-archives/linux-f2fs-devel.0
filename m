From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH 1/2] dump.f2fs: support dump_file from image
Date: Tue, 26 Aug 2014 17:36:00 -0700
Message-ID: <20140827003600.GA18374@jaegeuk-mac02>
References: <1408486872-78010-1-git-send-email-jaegeuk@kernel.org>
	<CAKP4w2Rogn8HMmi3r32Y33EwxfaZN-ke692E5ZvU8z1Ki9-F6Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1XMRDs-0001KI-9G
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 27 Aug 2014 00:36:24 +0000
Received: from mail.kernel.org ([198.145.19.201])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1XMRDq-0006kR-Nc for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 27 Aug 2014 00:36:24 +0000
Content-Disposition: inline
In-Reply-To: <CAKP4w2Rogn8HMmi3r32Y33EwxfaZN-ke692E5ZvU8z1Ki9-F6Q@mail.gmail.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: JP Abgrall <jpa@google.com>
Cc: linux-f2fs-devel@lists.sourceforge.net

On Tue, Aug 26, 2014 at 04:36:58PM -0700, JP Abgrall wrote:
> > diff --git a/lib/libf2fs_io.c b/lib/libf2fs_io.c
> > index 5d9b68d..46b5484 100644
> > --- a/lib/libf2fs_io.c
> > +++ b/lib/libf2fs_io.c
> > @@ -28,11 +28,11 @@ struct f2fs_configuration config;
> >  /*
> >   * IO interfaces
> >   */
> > -int dev_read(void *buf, __u64 offset, size_t len)
> > +int dev_read(void *buf, __u64 offset, size_t len, int fd)
> 
> Don't add fd.
> This makes the wrong assumption that an FD is actually the underlying
> mechanism to read from the device. These IO routines are to be called
> without that assumption.
> Forcing it in the API here breaks the capability to read/write on
> devices that are not files.
> If you need to dev_read(), then setup the config appropriately.

Uhu, it is really ugly codes.
I'll rewrite this as your suggestion.

Change log from v1:
 o refactor codes without fd hacks.

This patch adds supporting dump_file, which can extract a file from image.

You can simply select [yes|no] when doing dump.f2fs -i [inode number] [img].

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fsck/dump.c       | 153 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 include/f2fs_fs.h |   2 +
 lib/libf2fs_io.c  |   9 ++++
 3 files changed, 164 insertions(+)

diff --git a/fsck/dump.c b/fsck/dump.c
index 880e78a..44d4105 100644
--- a/fsck/dump.c
+++ b/fsck/dump.c
@@ -115,6 +115,158 @@ void ssa_dump(struct f2fs_sb_info *sbi, int start_ssa, int end_ssa)
 	close(fd);
 }
 
+static void dump_data_blk(__u64 offset, u32 blkaddr)
+{
+	char buf[F2FS_BLKSIZE];
+
+	if (blkaddr == NULL_ADDR)
+		return;
+
+	/* get data */
+	if (blkaddr == NEW_ADDR) {
+		memset(buf, 0, F2FS_BLKSIZE);
+	} else {
+		int ret;
+		ret = dev_read_block(buf, blkaddr);
+		ASSERT(ret >= 0);
+	}
+
+	/* write blkaddr */
+	dev_write_dump(buf, offset, F2FS_BLKSIZE);
+}
+
+static void dump_node_blk(struct f2fs_sb_info *sbi, int ntype,
+						u32 nid, u64 *ofs)
+{
+	struct node_info ni;
+	struct f2fs_node *node_blk;
+	int i, ret;
+	u32 idx, skip;
+
+	switch (ntype) {
+	case TYPE_DIRECT_NODE:
+		skip = idx = ADDRS_PER_BLOCK;
+		break;
+	case TYPE_INDIRECT_NODE:
+		idx = NIDS_PER_BLOCK;
+		skip = idx * ADDRS_PER_BLOCK;
+		break;
+	case TYPE_DOUBLE_INDIRECT_NODE:
+		skip = 0;
+		idx = NIDS_PER_BLOCK;
+		break;
+	}
+
+	if (nid == 0) {
+		*ofs += skip;
+		return;
+	}
+
+	ret = get_node_info(sbi, nid, &ni);
+	ASSERT(ret >= 0);
+
+	node_blk = calloc(BLOCK_SZ, 1);
+	dev_read_block(node_blk, ni.blk_addr);
+
+	for (i = 0; i < idx; i++, (*ofs)++) {
+		switch (ntype) {
+		case TYPE_DIRECT_NODE:
+			dump_data_blk(*ofs * F2FS_BLKSIZE,
+					le32_to_cpu(node_blk->dn.addr[i]));
+			break;
+		case TYPE_INDIRECT_NODE:
+			dump_node_blk(sbi, TYPE_DIRECT_NODE,
+					le32_to_cpu(node_blk->in.nid[i]), ofs);
+			break;
+		case TYPE_DOUBLE_INDIRECT_NODE:
+			dump_node_blk(sbi, TYPE_INDIRECT_NODE,
+					le32_to_cpu(node_blk->in.nid[i]), ofs);
+			break;
+		}
+	}
+	free(node_blk);
+}
+
+static void dump_inode_blk(struct f2fs_sb_info *sbi, u32 nid,
+					struct f2fs_node *node_blk)
+{
+	u32 i = 0;
+	u64 ofs = 0;
+
+	/* TODO: need to dump xattr */
+
+	if((node_blk->i.i_inline & F2FS_INLINE_DATA)){
+		DBG(3, "ino[0x%x] has inline data!\n", nid);
+		/* recover from inline data */
+		dev_write_dump(((unsigned char *)node_blk) + INLINE_DATA_OFFSET,
+							0, MAX_INLINE_DATA);
+		return;
+	}
+
+	/* check data blocks in inode */
+	for (i = 0; i < ADDRS_PER_INODE(&node_blk->i); i++, ofs++)
+		dump_data_blk(ofs * F2FS_BLKSIZE,
+				le32_to_cpu(node_blk->i.i_addr[i]));
+
+	/* check node blocks in inode */
+	for (i = 0; i < 5; i++) {
+		if (i == 0 || i == 1)
+			dump_node_blk(sbi, TYPE_DIRECT_NODE,
+					node_blk->i.i_nid[i], &ofs);
+		else if (i == 2 || i == 3)
+			dump_node_blk(sbi, TYPE_INDIRECT_NODE,
+					node_blk->i.i_nid[i], &ofs);
+		else if (i == 4)
+			dump_node_blk(sbi, TYPE_DOUBLE_INDIRECT_NODE,
+					node_blk->i.i_nid[i], &ofs);
+		else
+			ASSERT(0);
+	}
+}
+
+void dump_file(struct f2fs_sb_info *sbi, struct node_info *ni,
+					struct f2fs_node *node_blk)
+{
+	struct f2fs_inode *inode = &node_blk->i;
+	u32 imode = le32_to_cpu(inode->i_mode);
+	char name[255] = {0};
+	char path[1024] = {0};
+	char ans[255] = {0};
+	int ret;
+
+	if (!S_ISREG(imode)) {
+		MSG(0, "Not a regular file\n\n");
+		return;
+	}
+
+	printf("Do you want to dump this file into ./lost_found/? [Y/N] ");
+	ret = scanf("%s", ans);
+	ASSERT(ret >= 0);
+
+	if (!strcasecmp(ans, "y")) {
+		ret = system("mkdir -p ./lost_found");
+		ASSERT(ret >= 0);
+
+		/* make a file */
+		strncpy(name, (const char *)inode->i_name,
+					le32_to_cpu(inode->i_namelen));
+		name[le32_to_cpu(inode->i_namelen)] = 0;
+		sprintf(path, "./lost_found/%s", name);
+
+		config.dump_fd = open(path, O_TRUNC|O_CREAT|O_RDWR, 0666);
+		ASSERT(config.dump_fd >= 0);
+
+		/* dump file's data */
+		dump_inode_blk(sbi, ni->ino, node_blk);
+
+		/* adjust file size */
+		ret = ftruncate(config.dump_fd, le32_to_cpu(inode->i_size));
+		ASSERT(ret >= 0);
+
+		close(config.dump_fd);
+	}
+}
+
 int dump_node(struct f2fs_sb_info *sbi, nid_t nid)
 {
 	struct node_info ni;
@@ -142,6 +294,7 @@ int dump_node(struct f2fs_sb_info *sbi, nid_t nid)
 	if (le32_to_cpu(node_blk->footer.ino) == ni.ino &&
 			le32_to_cpu(node_blk->footer.nid) == ni.nid) {
 		print_node_info(node_blk);
+		dump_file(sbi, &ni, node_blk);
 	} else {
 		MSG(0, "Invalid node block\n\n");
 	}
diff --git a/include/f2fs_fs.h b/include/f2fs_fs.h
index 80ce918..9ade334 100644
--- a/include/f2fs_fs.h
+++ b/include/f2fs_fs.h
@@ -173,6 +173,7 @@ struct f2fs_configuration {
 	char *vol_label;
 	int heap;
 	int32_t fd;
+	int32_t dump_fd;
 	char *device_name;
 	char *extension_list;
 	int dbg_lv;
@@ -671,6 +672,7 @@ extern void f2fs_finalize_device(struct f2fs_configuration *);
 
 extern int dev_read(void *, __u64, size_t);
 extern int dev_write(void *, __u64, size_t);
+extern int dev_write_dump(void *, __u64, size_t);
 /* All bytes in the buffer must be 0 use dev_fill(). */
 extern int dev_fill(void *, __u64, size_t);
 
diff --git a/lib/libf2fs_io.c b/lib/libf2fs_io.c
index 5d9b68d..d5ced53 100644
--- a/lib/libf2fs_io.c
+++ b/lib/libf2fs_io.c
@@ -46,6 +46,15 @@ int dev_write(void *buf, __u64 offset, size_t len)
 	return 0;
 }
 
+int dev_write_dump(void *buf, __u64 offset, size_t len)
+{
+	if (lseek64(config.dump_fd, (off64_t)offset, SEEK_SET) < 0)
+		return -1;
+	if (write(config.dump_fd, buf, len) < 0)
+		return -1;
+	return 0;
+}
+
 int dev_fill(void *buf, __u64 offset, size_t len)
 {
 	/* Only allow fill to zero */
-- 
1.8.5.2 (Apple Git-48)


------------------------------------------------------------------------------
Slashdot TV.  
Video for Nerds.  Stuff that matters.
http://tv.slashdot.org/
