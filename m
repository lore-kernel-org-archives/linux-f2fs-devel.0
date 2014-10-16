From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 3/4] fsck.f2fs: support inline_dentry
Date: Wed, 15 Oct 2014 20:59:10 -0700
Message-ID: <1413431951-27137-3-git-send-email-jaegeuk@kernel.org>
References: <1413431951-27137-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1XecDl-0003wC-R0
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 16 Oct 2014 03:59:25 +0000
Received: from mail.kernel.org ([198.145.19.201])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1XecDk-0006fi-EB for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 16 Oct 2014 03:59:25 +0000
In-Reply-To: <1413431951-27137-1-git-send-email-jaegeuk@kernel.org>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>

This patch implements inline_dentry feature.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fsck/f2fs.h       |   5 +++
 fsck/fsck.c       | 123 ++++++++++++++++++++++++++++++++++++------------------
 fsck/fsck.h       |   2 +
 include/f2fs_fs.h |  20 +++++++++
 4 files changed, 109 insertions(+), 41 deletions(-)

diff --git a/fsck/f2fs.h b/fsck/f2fs.h
index cdd61b8..47f785d 100644
--- a/fsck/f2fs.h
+++ b/fsck/f2fs.h
@@ -191,6 +191,11 @@ static inline struct sit_info *SIT_I(struct f2fs_sb_info *sbi)
 	return (struct sit_info *)(SM_I(sbi)->sit_info);
 }
 
+static inline void *inline_data_addr(struct f2fs_node *node_blk)
+{
+	return (void *)&(node_blk->i.i_addr[1]);
+}
+
 static inline unsigned long __bitmap_size(struct f2fs_sb_info *sbi, int flag)
 {
 	struct f2fs_checkpoint *ckpt = F2FS_CKPT(sbi);
diff --git a/fsck/fsck.c b/fsck/fsck.c
index d0819c4..8e3ecc8 100644
--- a/fsck/fsck.c
+++ b/fsck/fsck.c
@@ -397,6 +397,12 @@ void fsck_chk_inode_blk(struct f2fs_sb_info *sbi, u32 nid,
 		DBG(3, "ino[0x%x] has inline data!\n", nid);
 		goto check;
 	}
+	if((node_blk->i.i_inline & F2FS_INLINE_DENTRY)){
+		DBG(3, "ino[0x%x] has inline dentry!\n", nid);
+		ret = fsck_chk_inline_dentries(sbi, node_blk,
+					&child_cnt, &child_files);
+		goto check;
+	}
 
 	/* check data blocks in inode */
 	for (idx = 0; idx < ADDRS_PER_INODE(&node_blk->i); idx++) {
@@ -546,7 +552,9 @@ int fsck_chk_didnode_blk(struct f2fs_sb_info *sbi, struct f2fs_inode *inode,
 }
 
 static void print_dentry(__u32 depth, __u8 *name,
-		struct f2fs_dentry_block *de_blk, int idx, int last_blk)
+		unsigned long *bitmap,
+		struct f2fs_dir_entry *dentry,
+		int max, int idx, int last_blk)
 {
 	int last_de = 0;
 	int next_idx = 0;
@@ -557,12 +565,11 @@ static void print_dentry(__u32 depth, __u8 *name,
 	if (config.dbg_lv != -1)
 		return;
 
-	name_len = le16_to_cpu(de_blk->dentry[idx].name_len);
+	name_len = le16_to_cpu(dentry[idx].name_len);
 	next_idx = idx + (name_len + F2FS_SLOT_LEN - 1) / F2FS_SLOT_LEN;
 
-	bit_offset = find_next_bit((unsigned long *)de_blk->dentry_bitmap,
-			NR_DENTRY_IN_BLOCK, next_idx);
-	if (bit_offset >= NR_DENTRY_IN_BLOCK && last_blk)
+	bit_offset = find_next_bit(bitmap, max, next_idx);
+	if (bit_offset >= max && last_blk)
 		last_de = 1;
 
 	if (tree_mark_size <= depth) {
@@ -582,47 +589,41 @@ static void print_dentry(__u32 depth, __u8 *name,
 	for (i = 1; i < depth; i++)
 		printf("%c   ", tree_mark[i]);
 	printf("%c-- %s 0x%x\n", last_de ? '`' : '|',
-				name, le32_to_cpu(de_blk->dentry[idx].ino));
+				name, le32_to_cpu(dentry[idx].ino));
 }
 
-int fsck_chk_dentry_blk(struct f2fs_sb_info *sbi, u32 blk_addr,
-		u32 *child_cnt, u32 *child_files, int last_blk)
+static int __chk_dentries(struct f2fs_sb_info *sbi, u32 *child_cnt,
+			u32* child_files,
+			unsigned long *bitmap,
+			struct f2fs_dir_entry *dentry,
+			__u8 (*filenames)[F2FS_SLOT_LEN],
+			int max, int last_blk)
 {
 	struct f2fs_fsck *fsck = F2FS_FSCK(sbi);
-	int i;
-	int ret = 0;
+	enum FILE_TYPE ftype;
 	int dentries = 0;
+	u32 blk_cnt;
 	u8 *name;
 	u32 hash_code;
-	u32 blk_cnt;
 	u16 name_len;;
+	int ret = 0;
+	int i;
 
-	enum FILE_TYPE ftype;
-	struct f2fs_dentry_block *de_blk;
-
-	de_blk = (struct f2fs_dentry_block *)calloc(BLOCK_SZ, 1);
-	ASSERT(de_blk != NULL);
-
-	ret = dev_read_block(de_blk, blk_addr);
-	ASSERT(ret >= 0);
-
-	fsck->dentry_depth++;
-
-	for (i = 0; i < NR_DENTRY_IN_BLOCK;) {
-		if (test_bit(i, (unsigned long *)de_blk->dentry_bitmap) == 0) {
+	for (i = 0; i < max;) {
+		if (test_bit(i, bitmap) == 0) {
 			i++;
 			continue;
 		}
 
-		name_len = le16_to_cpu(de_blk->dentry[i].name_len);
+		name_len = le16_to_cpu(dentry[i].name_len);
 		name = calloc(name_len + 1, 1);
-		memcpy(name, de_blk->filename[i], name_len);
+		memcpy(name, filenames[i], name_len);
 		hash_code = f2fs_dentry_hash((const unsigned char *)name,
 								name_len);
 
-		ASSERT(le32_to_cpu(de_blk->dentry[i].hash_code) == hash_code);
+		ASSERT(le32_to_cpu(dentry[i].hash_code) == hash_code);
 
-		ftype = de_blk->dentry[i].file_type;
+		ftype = dentry[i].file_type;
 
 		/* Becareful. 'dentry.file_type' is not imode. */
 		if (ftype == F2FS_FT_DIR) {
@@ -638,30 +639,27 @@ int fsck_chk_dentry_blk(struct f2fs_sb_info *sbi, u32 blk_addr,
 
 		DBG(1, "[%3u]-[0x%x] name[%s] len[0x%x] ino[0x%x] type[0x%x]\n",
 				fsck->dentry_depth, i, name, name_len,
-				le32_to_cpu(de_blk->dentry[i].ino),
-				de_blk->dentry[i].file_type);
+				le32_to_cpu(dentry[i].ino),
+				dentry[i].file_type);
 
-		print_dentry(fsck->dentry_depth, name, de_blk, i, last_blk);
+		print_dentry(fsck->dentry_depth, name, bitmap,
+						dentry, max, i, 1);
 
 		blk_cnt = 1;
 		ret = fsck_chk_node_blk(sbi,
-				NULL,
-				le32_to_cpu(de_blk->dentry[i].ino),
-				ftype,
-				TYPE_INODE,
-				&blk_cnt);
+				NULL, le32_to_cpu(dentry[i].ino),
+				ftype, TYPE_INODE, &blk_cnt);
 
 		if (ret && config.fix_on) {
 			int j;
 			int slots = (name_len + F2FS_SLOT_LEN - 1) /
 				F2FS_SLOT_LEN;
 			for (j = 0; j < slots; j++)
-				clear_bit(i + j,
-					(unsigned long *)de_blk->dentry_bitmap);
+				clear_bit(i + j, bitmap);
 			FIX_MSG("Unlink [0x%x] - %s len[0x%x], type[0x%x]",
-					le32_to_cpu(de_blk->dentry[i].ino),
+					le32_to_cpu(dentry[i].ino),
 					name, name_len,
-					de_blk->dentry[i].file_type);
+					dentry[i].file_type);
 			i += slots;
 			free(name);
 			continue;
@@ -672,13 +670,56 @@ int fsck_chk_dentry_blk(struct f2fs_sb_info *sbi, u32 blk_addr,
 		*child_files = *child_files + 1;
 		free(name);
 	}
+	return dentries;
+}
+
+int fsck_chk_inline_dentries(struct f2fs_sb_info *sbi,
+		struct f2fs_node *node_blk, u32 *child_cnt, u32 *child_files)
+{
+	struct f2fs_fsck *fsck = F2FS_FSCK(sbi);
+	struct f2fs_inline_dentry *de_blk;
+	int dentries;
+
+	de_blk = inline_data_addr(node_blk);
+	ASSERT(de_blk != NULL);
+
+	fsck->dentry_depth++;
+	dentries = __chk_dentries(sbi, child_cnt, child_files,
+			(unsigned long *)de_blk->dentry_bitmap,
+			de_blk->dentry, de_blk->filename,
+			NR_INLINE_DENTRY, 1);
+	DBG(1, "[%3d] Inline Dentry Block Done : "
+				"dentries:%d in %d slots (len:%d)\n\n",
+			fsck->dentry_depth, dentries,
+			(int)NR_INLINE_DENTRY, F2FS_NAME_LEN);
+	fsck->dentry_depth--;
+	return 0;
+}
+
+int fsck_chk_dentry_blk(struct f2fs_sb_info *sbi, u32 blk_addr,
+		u32 *child_cnt, u32 *child_files, int last_blk)
+{
+	struct f2fs_fsck *fsck = F2FS_FSCK(sbi);
+	struct f2fs_dentry_block *de_blk;
+	int dentries, ret;
+
+	de_blk = (struct f2fs_dentry_block *)calloc(BLOCK_SZ, 1);
+	ASSERT(de_blk != NULL);
+
+	ret = dev_read_block(de_blk, blk_addr);
+	ASSERT(ret >= 0);
+
+	fsck->dentry_depth++;
+	dentries = __chk_dentries(sbi, child_cnt, child_files,
+			(unsigned long *)de_blk->dentry_bitmap,
+			de_blk->dentry, de_blk->filename,
+			NR_DENTRY_IN_BLOCK, last_blk);
 
 	DBG(1, "[%3d] Dentry Block [0x%x] Done : "
 				"dentries:%d in %d slots (len:%d)\n\n",
 			fsck->dentry_depth, blk_addr, dentries,
 			NR_DENTRY_IN_BLOCK, F2FS_NAME_LEN);
 	fsck->dentry_depth--;
-
 	free(de_blk);
 	return 0;
 }
diff --git a/fsck/fsck.h b/fsck/fsck.h
index 64b9984..49d6d1d 100644
--- a/fsck/fsck.h
+++ b/fsck/fsck.h
@@ -93,6 +93,8 @@ extern int fsck_chk_didnode_blk(struct f2fs_sb_info *, struct f2fs_inode *,
 extern int fsck_chk_data_blk(struct f2fs_sb_info *sbi, u32, u32 *, u32 *,
 		int, enum FILE_TYPE, u32, u16, u8);
 extern int fsck_chk_dentry_blk(struct f2fs_sb_info *, u32, u32 *, u32 *, int);
+int fsck_chk_inline_dentries(struct f2fs_sb_info *, struct f2fs_node *,
+		u32 *, u32 *);
 
 extern void print_node_info(struct f2fs_node *);
 extern void print_inode_info(struct f2fs_inode *);
diff --git a/include/f2fs_fs.h b/include/f2fs_fs.h
index df37cdf..ed4abb1 100644
--- a/include/f2fs_fs.h
+++ b/include/f2fs_fs.h
@@ -425,6 +425,8 @@ struct f2fs_extent {
 
 #define F2FS_INLINE_XATTR	0x01	/* file inline xattr flag */
 #define F2FS_INLINE_DATA	0x02	/* file inline data flag */
+#define F2FS_INLINE_DENTRY	0x04	/* file inline dentry flag */
+
 #define MAX_INLINE_DATA		(sizeof(__le32) * (DEF_ADDRS_PER_INODE - \
 						F2FS_INLINE_XATTR_ADDRS - 1))
 
@@ -697,6 +699,24 @@ struct f2fs_dentry_block {
 	__u8 filename[NR_DENTRY_IN_BLOCK][F2FS_SLOT_LEN];
 } __attribute__((packed));
 
+/* for inline dir */
+#define NR_INLINE_DENTRY	(MAX_INLINE_DATA * BITS_PER_BYTE / \
+				((SIZE_OF_DIR_ENTRY + F2FS_SLOT_LEN) * \
+				BITS_PER_BYTE + 1))
+#define INLINE_DENTRY_BITMAP_SIZE	((NR_INLINE_DENTRY + \
+					BITS_PER_BYTE - 1) / BITS_PER_BYTE)
+#define INLINE_RESERVED_SIZE	(MAX_INLINE_DATA - \
+				((SIZE_OF_DIR_ENTRY + F2FS_SLOT_LEN) * \
+				NR_INLINE_DENTRY + INLINE_DENTRY_BITMAP_SIZE))
+
+/* inline directory entry structure */
+struct f2fs_inline_dentry {
+	__u8 dentry_bitmap[INLINE_DENTRY_BITMAP_SIZE];
+	__u8 reserved[INLINE_RESERVED_SIZE];
+	struct f2fs_dir_entry dentry[NR_INLINE_DENTRY];
+	__u8 filename[NR_INLINE_DENTRY][F2FS_SLOT_LEN];
+} __packed;
+
 /* file types used in inode_info->flags */
 enum FILE_TYPE {
 	F2FS_FT_UNKNOWN,
-- 
2.1.1


------------------------------------------------------------------------------
Comprehensive Server Monitoring with Site24x7.
Monitor 10 servers for $9/Month.
Get alerted through email, SMS, voice calls or mobile push notifications.
Take corrective actions from your mobile device.
http://p.sf.net/sfu/Zoho
