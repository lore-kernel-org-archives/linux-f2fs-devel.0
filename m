From: Chao Yu <chao@kernel.org>
Subject: [PATCH] f2fs-tools: fix to check return value of {c,
 m}alloc()
Date: Mon, 26 Nov 2018 21:36:00 +0800
Message-ID: <20181126133600.7508-1-chao@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <chao@kernel.org>) id 1gRH3v-0007AE-5C
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 26 Nov 2018 13:36:31 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1gRH3d-004HbT-VX
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 26 Nov 2018 13:36:31 +0000
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net

From: Chao Yu <yuchao0@huawei.com>

It needs to fix to handle error case of {c,m}alloc().

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fsck/dump.c      |  4 ++++
 fsck/fsck.c      |  2 ++
 fsck/mount.c     | 13 +++++++++++++
 lib/libf2fs.c    |  4 ++++
 lib/libf2fs_io.c |  4 ++++
 5 files changed, 27 insertions(+)

diff --git a/fsck/dump.c b/fsck/dump.c
index 8cf431c..d0e3355 100644
--- a/fsck/dump.c
+++ b/fsck/dump.c
@@ -277,6 +277,8 @@ static void dump_node_blk(struct f2fs_sb_info *sbi, int ntype,
 	get_node_info(sbi, nid, &ni);
 
 	node_blk = calloc(BLOCK_SZ, 1);
+	ASSERT(node_blk);
+
 	dev_read_block(node_blk, ni.blk_addr);
 
 	for (i = 0; i < idx; i++, (*ofs)++) {
@@ -475,6 +477,8 @@ void dump_node(struct f2fs_sb_info *sbi, nid_t nid, int force)
 	get_node_info(sbi, nid, &ni);
 
 	node_blk = calloc(BLOCK_SZ, 1);
+	ASSERT(node_blk);
+
 	dev_read_block(node_blk, ni.blk_addr);
 
 	DBG(1, "Node ID               [0x%x]\n", nid);
diff --git a/fsck/fsck.c b/fsck/fsck.c
index 366ba13..970d150 100644
--- a/fsck/fsck.c
+++ b/fsck/fsck.c
@@ -1420,6 +1420,8 @@ static int __chk_dentries(struct f2fs_sb_info *sbi, struct child_info *child,
 			continue;
 		}
 		name = calloc(name_len + 1, 1);
+		ASSERT(name);
+
 		memcpy(name, filenames[i], name_len);
 		slots = (name_len + F2FS_SLOT_LEN - 1) / F2FS_SLOT_LEN;
 
diff --git a/fsck/mount.c b/fsck/mount.c
index 861e5fb..d853fcf 100644
--- a/fsck/mount.c
+++ b/fsck/mount.c
@@ -664,6 +664,8 @@ int validate_super_block(struct f2fs_sb_info *sbi, enum SB_ADDR sb_addr)
 	char buf[F2FS_BLKSIZE];
 
 	sbi->raw_super = malloc(sizeof(struct f2fs_super_block));
+	if (!sbi->raw_super)
+		return -ENOMEM;
 
 	if (dev_read_block(buf, sb_addr))
 		return -1;
@@ -779,6 +781,8 @@ void *validate_checkpoint(struct f2fs_sb_info *sbi, block_t cp_addr,
 
 	/* Read the 1st cp block in this CP pack */
 	cp_page_1 = malloc(PAGE_SIZE);
+	ASSERT(cp_page_1);
+
 	if (dev_read_block(cp_page_1, cp_addr) < 0)
 		goto invalid_cp1;
 
@@ -798,6 +802,8 @@ void *validate_checkpoint(struct f2fs_sb_info *sbi, block_t cp_addr,
 
 	/* Read the 2nd cp block in this CP pack */
 	cp_page_2 = malloc(PAGE_SIZE);
+	ASSERT(cp_page_2);
+
 	cp_addr += get_cp(cp_pack_total_block_count) - 1;
 
 	if (dev_read_block(cp_page_2, cp_addr) < 0)
@@ -1320,6 +1326,9 @@ int build_sit_info(struct f2fs_sb_info *sbi)
 	src_bitmap = __bitmap_ptr(sbi, SIT_BITMAP);
 
 	dst_bitmap = malloc(bitmap_size);
+	if (!dst_bitmap)
+		return -ENOMEM;
+
 	memcpy(dst_bitmap, src_bitmap, bitmap_size);
 
 	sit_i->sit_base_addr = get_sb(sit_blkaddr);
@@ -1361,6 +1370,8 @@ static void read_compacted_summaries(struct f2fs_sb_info *sbi)
 	start = start_sum_block(sbi);
 
 	kaddr = (char *)malloc(PAGE_SIZE);
+	ASSERT(kaddr);
+
 	ret = dev_read_block(kaddr, start++);
 	ASSERT(ret >= 0);
 
@@ -1452,6 +1463,8 @@ static void read_normal_summaries(struct f2fs_sb_info *sbi, int type)
 	}
 
 	sum_blk = (struct f2fs_summary_block *)malloc(PAGE_SIZE);
+	ASSERT(sum_blk);
+
 	ret = dev_read_block(sum_blk, blk_addr);
 	ASSERT(ret >= 0);
 
diff --git a/lib/libf2fs.c b/lib/libf2fs.c
index 498f6c0..c692bf2 100644
--- a/lib/libf2fs.c
+++ b/lib/libf2fs.c
@@ -566,6 +566,8 @@ char *get_rootdev()
 	}
 
 	uevent = malloc(ret + 1);
+	ASSERT(uevent);
+
 	uevent[ret] = '\0';
 
 	ret = read(fd, uevent, ret);
@@ -709,6 +711,8 @@ int f2fs_dev_is_umounted(char *path)
 	 * the file system. In this case, we should not format.
 	 */
 	st_buf = malloc(sizeof(struct stat));
+	ASSERT(st_buf);
+
 	if (stat(path, st_buf) == 0 && S_ISBLK(st_buf->st_mode)) {
 		int fd = open(path, O_RDONLY | O_EXCL);
 
diff --git a/lib/libf2fs_io.c b/lib/libf2fs_io.c
index 47917ab..b40c3d2 100644
--- a/lib/libf2fs_io.c
+++ b/lib/libf2fs_io.c
@@ -302,6 +302,10 @@ int f2fs_init_sparse_file(void)
 	}
 	blocks_count = c.device_size / F2FS_BLKSIZE;
 	blocks = calloc(blocks_count, sizeof(char *));
+	if (!blocks) {
+		MSG(0, "\tError: Calloc Failed for blocks!!!\n");
+		return -1;
+	}
 
 	return sparse_file_foreach_chunk(f2fs_sparse_file, true, false,
 				sparse_import_segment, NULL);
-- 
2.18.0
