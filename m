From: Chao Yu <chao@kernel.org>
Subject: [PATCH] f2fs: support inode checksum
Date: Wed, 26 Jul 2017 22:57:47 +0800
Message-ID: <20170726145747.9535-1-chao@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, Chao Yu <yuchao0@huawei.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

From: Chao Yu <yuchao0@huawei.com>

This patch adds to support inode checksum in f2fs.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/f2fs.h          | 31 ++++++++++++++++++++++++
 fs/f2fs/inode.c         | 64 +++++++++++++++++++++++++++++++++++++++++++++++++
 fs/f2fs/node.c          |  2 ++
 fs/f2fs/segment.c       |  5 +++-
 fs/f2fs/super.c         |  5 ++++
 include/linux/f2fs_fs.h |  1 +
 6 files changed, 107 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index a6259660e401..5cfffd6f0209 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -122,6 +122,7 @@ struct f2fs_mount_info {
 #define F2FS_FEATURE_ATOMIC_WRITE	0x0004
 #define F2FS_FEATURE_EXTRA_ATTR		0x0008
 #define F2FS_FEATURE_PRJQUOTA		0x0010
+#define F2FS_FEATURE_INODE_CHKSUM	0x0020
 
 #define F2FS_HAS_FEATURE(sb, mask)					\
 	((F2FS_SB(sb)->raw_super->feature & cpu_to_le32(mask)) != 0)
@@ -1097,6 +1098,9 @@ struct f2fs_sb_info {
 	/* Reference to checksum algorithm driver via cryptoapi */
 	struct crypto_shash *s_chksum_driver;
 
+	/* Precomputed FS UUID checksum for seeding other checksums */
+	__u32 s_chksum_seed;
+
 	/* For fault injection */
 #ifdef CONFIG_F2FS_FAULT_INJECTION
 	struct f2fs_fault_info fault_info;
@@ -1194,6 +1198,27 @@ static inline bool f2fs_crc_valid(struct f2fs_sb_info *sbi, __u32 blk_crc,
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
@@ -2303,6 +2328,7 @@ long f2fs_compat_ioctl(struct file *file, unsigned int cmd, unsigned long arg);
  * inode.c
  */
 void f2fs_set_inode_flags(struct inode *inode);
+void f2fs_inode_chksum_set(struct f2fs_sb_info *sbi, struct f2fs_node *node);
 struct inode *f2fs_iget(struct super_block *sb, unsigned long ino);
 struct inode *f2fs_iget_retry(struct super_block *sb, unsigned long ino);
 int try_to_free_nats(struct f2fs_sb_info *sbi, int nr_shrink);
@@ -2889,6 +2915,11 @@ static inline int f2fs_sb_has_project_quota(struct super_block *sb)
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
index 6530c4f1743b..d81aaea6a832 100644
--- a/fs/f2fs/inode.c
+++ b/fs/f2fs/inode.c
@@ -114,6 +114,64 @@ static void __recover_inline_status(struct inode *inode, struct page *ipage)
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
@@ -167,6 +225,12 @@ static int do_read_inode(struct inode *inode)
 	fi->i_extra_isize = f2fs_has_extra_attr(inode) ?
 					le16_to_cpu(ri->i_extra_isize) : 0;
 
+	if (!f2fs_inode_chksum_verify(sbi, F2FS_NODE(node_page), fi)) {
+		f2fs_msg(sbi->sb, KERN_WARNING, "checksum invalid");
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
index d7c8f6bee446..99a62f340295 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -2284,6 +2284,11 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
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
2.13.0.90.g1eb437020
