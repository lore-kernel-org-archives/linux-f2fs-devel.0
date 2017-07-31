From: Chao Yu <yuchao0@huawei.com>
Subject: [PATCH v2] f2fs: support inode checksum
Date: Mon, 31 Jul 2017 20:19:09 +0800
Message-ID: <20170731121909.89539-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
 helo=mx.sourceforge.net)
 by sfs-ml-1.v29.ch3.sourceforge.com with esmtps (TLSv1:DHE-RSA-AES256-SHA:256)
 (Exim 4.89) (envelope-from <yuchao0@huawei.com>) id 1dc9fc-0001mW-RP
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 31 Jul 2017 12:19:36 +0000
Received: from szxga03-in.huawei.com ([45.249.212.189])
 by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
 (Exim 4.76) id 1dc9fZ-0004lM-Uc
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 31 Jul 2017 12:19:36 +0000
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
Cc: chao@kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

This patch adds to support inode checksum in f2fs.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
v2: add to print detail info if checksum failed.
 fs/f2fs/f2fs.h          | 31 +++++++++++++++++++++++
 fs/f2fs/inode.c         | 66 +++++++++++++++++++++++++++++++++++++++++++++++++
 fs/f2fs/node.c          |  2 ++
 fs/f2fs/segment.c       |  5 +++-
 fs/f2fs/super.c         |  5 ++++
 include/linux/f2fs_fs.h |  1 +
 6 files changed, 109 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index a1bfd0b9be44..d35621b8d739 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -116,6 +116,7 @@ struct f2fs_mount_info {
 #define F2FS_FEATURE_ATOMIC_WRITE	0x0004
 #define F2FS_FEATURE_EXTRA_ATTR		0x0008
 #define F2FS_FEATURE_PRJQUOTA		0x0010
+#define F2FS_FEATURE_INODE_CHKSUM	0x0020
 
 #define F2FS_HAS_FEATURE(sb, mask)					\
 	((F2FS_SB(sb)->raw_super->feature & cpu_to_le32(mask)) != 0)
@@ -1082,6 +1083,9 @@ struct f2fs_sb_info {
 	/* Reference to checksum algorithm driver via cryptoapi */
 	struct crypto_shash *s_chksum_driver;
 
+	/* Precomputed FS UUID checksum for seeding other checksums */
+	__u32 s_chksum_seed;
+
 	/* For fault injection */
 #ifdef CONFIG_F2FS_FAULT_INJECTION
 	struct f2fs_fault_info fault_info;
@@ -1173,6 +1177,27 @@ static inline bool f2fs_crc_valid(struct f2fs_sb_info *sbi, __u32 blk_crc,
 	return f2fs_crc32(sbi, buf, buf_size) == blk_crc;
 }
 
+static inline u32 f2fs_chksum(struct f2fs_sb_info *sbi, u32 crc,
+			      const void *address, unsigned int length)
+{
+	struct {
+		struct shash_desc shash;
+		char ctx[4];
+	} desc;
+	int err;
+
+	BUG_ON(crypto_shash_descsize(sbi->s_chksum_driver) != sizeof(desc.ctx));
+
+	desc.shash.tfm = sbi->s_chksum_driver;
+	desc.shash.flags = 0;
+	*(u32 *)desc.ctx = crc;
+
+	err = crypto_shash_update(&desc.shash, address, length);
+	BUG_ON(err);
+
+	return *(u32 *)desc.ctx;
+}
+
 static inline struct f2fs_inode_info *F2FS_I(struct inode *inode)
 {
 	return container_of(inode, struct f2fs_inode_info, vfs_inode);
@@ -2282,6 +2307,7 @@ long f2fs_compat_ioctl(struct file *file, unsigned int cmd, unsigned long arg);
  * inode.c
  */
 void f2fs_set_inode_flags(struct inode *inode);
+void f2fs_inode_chksum_set(struct f2fs_sb_info *sbi, struct f2fs_node *node);
 struct inode *f2fs_iget(struct super_block *sb, unsigned long ino);
 struct inode *f2fs_iget_retry(struct super_block *sb, unsigned long ino);
 int try_to_free_nats(struct f2fs_sb_info *sbi, int nr_shrink);
@@ -2865,6 +2891,11 @@ static inline int f2fs_sb_has_project_quota(struct super_block *sb)
 	return F2FS_HAS_FEATURE(sb, F2FS_FEATURE_PRJQUOTA);
 }
 
+static inline int f2fs_sb_has_inode_chksum(struct super_block *sb)
+{
+	return F2FS_HAS_FEATURE(sb, F2FS_FEATURE_INODE_CHKSUM);
+}
+
 #ifdef CONFIG_BLK_DEV_ZONED
 static inline int get_blkz_type(struct f2fs_sb_info *sbi,
 			struct block_device *bdev, block_t blkaddr)
diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
index f15e663a1a15..05c8aeb0101e 100644
--- a/fs/f2fs/inode.c
+++ b/fs/f2fs/inode.c
@@ -108,6 +108,64 @@ static void __recover_inline_status(struct inode *inode, struct page *ipage)
 	return;
 }
 
+static __u32 f2fs_inode_chksum(struct f2fs_sb_info *sbi,
+					struct f2fs_node *node)
+{
+	struct f2fs_inode *ri = &node->i;
+	__le32 ino = node->footer.ino;
+	__le32 gen = ri->i_generation;
+	__u32 chksum, chksum_seed;
+	__u32 dummy_cs = 0;
+	unsigned int offset = offsetof(struct f2fs_inode, i_inode_checksum);
+	unsigned int cs_size = sizeof(dummy_cs);
+
+	chksum = f2fs_chksum(sbi, sbi->s_chksum_seed, (__u8 *)&ino,
+							sizeof(ino));
+	chksum_seed = f2fs_chksum(sbi, chksum, (__u8 *)&gen, sizeof(gen));
+
+	chksum = f2fs_chksum(sbi, chksum_seed, (__u8 *)ri, offset);
+	chksum = f2fs_chksum(sbi, chksum, (__u8 *)&dummy_cs, cs_size);
+	offset += cs_size;
+	chksum = f2fs_chksum(sbi, chksum, (__u8 *)ri + offset,
+						F2FS_BLKSIZE - offset);
+	return chksum;
+}
+
+static bool f2fs_inode_chksum_verify(struct f2fs_sb_info *sbi,
+			struct f2fs_node *node, struct f2fs_inode_info *fi)
+{
+	struct f2fs_inode *ri = &node->i;
+	__u32 provided, calculated;
+
+	if (!f2fs_sb_has_inode_chksum(sbi->sb))
+		return true;
+
+	if (!F2FS_FITS_IN_INODE(ri, fi->i_extra_isize, i_inode_checksum))
+		return true;
+
+	provided = le32_to_cpu(ri->i_inode_checksum);
+	calculated = f2fs_inode_chksum(sbi, node);
+
+	return provided == calculated;
+}
+
+void f2fs_inode_chksum_set(struct f2fs_sb_info *sbi, struct f2fs_node *node)
+{
+	struct f2fs_inode *ri = &node->i;
+	int extra_isize = le32_to_cpu(ri->i_extra_isize);
+
+	if (!f2fs_sb_has_inode_chksum(sbi->sb))
+		return;
+
+	if (!RAW_IS_INODE(node) || !(ri->i_inline & F2FS_EXTRA_ATTR))
+		return;
+
+	if (!F2FS_FITS_IN_INODE(ri, extra_isize, i_inode_checksum))
+		return;
+
+	ri->i_inode_checksum = cpu_to_le32(f2fs_inode_chksum(sbi, node));
+}
+
 static int do_read_inode(struct inode *inode)
 {
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
@@ -161,6 +219,14 @@ static int do_read_inode(struct inode *inode)
 	fi->i_extra_isize = f2fs_has_extra_attr(inode) ?
 					le16_to_cpu(ri->i_extra_isize) : 0;
 
+	if (!f2fs_inode_chksum_verify(sbi, F2FS_NODE(node_page), fi)) {
+		f2fs_msg(sbi->sb, KERN_WARNING,
+			"checksum invalid, ino:%lu, on-disk:%u",
+			inode->i_ino, le32_to_cpu(ri->i_inode_checksum));
+		f2fs_put_page(node_page, 1);
+		return -EBADMSG;
+	}
+
 	/* check data exist */
 	if (f2fs_has_inline_data(inode) && !f2fs_exist_data(inode))
 		__recover_inline_status(inode, node_page);
diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 11e2d49203b3..f97792202ada 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -2271,6 +2271,8 @@ int recover_inode_page(struct f2fs_sb_info *sbi, struct page *page)
 			F2FS_FITS_IN_INODE(src, le16_to_cpu(src->i_extra_isize),
 								i_projid))
 			dst->i_projid = src->i_projid;
+
+		f2fs_inode_chksum_set(sbi, F2FS_NODE(ipage));
 	}
 
 	new_ni = old_ni;
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 2a5672a20a62..df1bb0c144f1 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -2214,9 +2214,12 @@ void allocate_data_block(struct f2fs_sb_info *sbi, struct page *page,
 
 	mutex_unlock(&sit_i->sentry_lock);
 
-	if (page && IS_NODESEG(type))
+	if (page && IS_NODESEG(type)) {
 		fill_node_footer_blkaddr(page, NEXT_FREE_BLKADDR(sbi, curseg));
 
+		f2fs_inode_chksum_set(sbi, F2FS_NODE(page));
+	}
+
 	if (add_list) {
 		struct f2fs_bio_info *io;
 
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index f44a09375e64..043908e1869c 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -1945,6 +1945,11 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
 	sb->s_fs_info = sbi;
 	sbi->raw_super = raw_super;
 
+	/* precompute checksum seed for metadata */
+	if (f2fs_sb_has_inode_chksum(sb))
+		sbi->s_chksum_seed = f2fs_chksum(sbi, ~0, raw_super->uuid,
+						sizeof(raw_super->uuid));
+
 	/*
 	 * The BLKZONED feature indicates that the drive was formatted with
 	 * zone alignment optimization. This is optional for host-aware
diff --git a/include/linux/f2fs_fs.h b/include/linux/f2fs_fs.h
index 50f176683676..2a0c453d7235 100644
--- a/include/linux/f2fs_fs.h
+++ b/include/linux/f2fs_fs.h
@@ -240,6 +240,7 @@ struct f2fs_inode {
 			__le16 i_extra_isize;	/* extra inode attribute size */
 			__le16 i_padding;	/* padding */
 			__le32 i_projid;	/* project id */
+			__le32 i_inode_checksum;/* inode meta checksum */
 			__le32 i_extra_end[0];	/* for attribute size calculation */
 		};
 		__le32 i_addr[DEF_ADDRS_PER_INODE];	/* Pointers to data blocks */
-- 
2.13.1.388.g69e6b9b4f4a9


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
