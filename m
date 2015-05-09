From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 5/5] fsck.f2fs: add hash conversion for encrypted
	dentries
Date: Fri,  8 May 2015 21:24:41 -0700
Message-ID: <1431145481-2184-5-git-send-email-jaegeuk@kernel.org>
References: <1431145481-2184-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1YqwKB-0005AA-SO
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 09 May 2015 04:25:15 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1YqwKA-0007pD-Ln for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 09 May 2015 04:25:15 +0000
In-Reply-To: <1431145481-2184-1-git-send-email-jaegeuk@kernel.org>
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

If dentry is encrypted, we should convert its hash value.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fsck/fsck.c       | 91 ++++++++++++++++++++++++++++++++++++++++---------------
 fsck/fsck.h       |  7 +++--
 include/f2fs_fs.h |  9 ++++++
 3 files changed, 80 insertions(+), 27 deletions(-)

diff --git a/fsck/fsck.c b/fsck/fsck.c
index f3fbdfa..b15edbe 100644
--- a/fsck/fsck.c
+++ b/fsck/fsck.c
@@ -583,7 +583,8 @@ void fsck_chk_inode_blk(struct f2fs_sb_info *sbi, u32 nid,
 			ret = fsck_chk_data_blk(sbi,
 					le32_to_cpu(node_blk->i.i_addr[idx]),
 					&child, (i_blocks == *blk_cnt),
-					ftype, nid, idx, ni->version);
+					ftype, nid, idx, ni->version,
+					file_is_encrypt(node_blk->i.i_advise));
 			if (!ret) {
 				*blk_cnt = *blk_cnt + 1;
 			} else if (config.fix_on) {
@@ -695,7 +696,8 @@ int fsck_chk_dnode_blk(struct f2fs_sb_info *sbi, struct f2fs_inode *inode,
 		ret = fsck_chk_data_blk(sbi,
 			le32_to_cpu(node_blk->dn.addr[idx]),
 			child, le64_to_cpu(inode->i_blocks) == *blk_cnt, ftype,
-			nid, idx, ni->version);
+			nid, idx, ni->version,
+			file_is_encrypt(inode->i_advise));
 		if (!ret) {
 			*blk_cnt = *blk_cnt + 1;
 		} else if (config.fix_on) {
@@ -753,16 +755,37 @@ int fsck_chk_didnode_blk(struct f2fs_sb_info *sbi, struct f2fs_inode *inode,
 	return 0;
 }
 
+static void convert_encrypted_name(unsigned char *name, int len,
+				unsigned char *new, int encrypted)
+{
+	if (!encrypted) {
+		memcpy(new, name, len);
+		new[len] = 0;
+		return;
+	}
+
+	while (len--) {
+		*new = *name++;
+		if (*new > 128)
+			*new -= 128;
+		if (*new < 32 || *new == 0x7f)
+			*new ^= 0x40;	/* ^@, ^A, ^B; ^? for DEL */
+		new++;
+	}
+	*new = 0;
+}
+
 static void print_dentry(__u32 depth, __u8 *name,
 		unsigned long *bitmap,
 		struct f2fs_dir_entry *dentry,
-		int max, int idx, int last_blk)
+		int max, int idx, int last_blk, int encrypted)
 {
 	int last_de = 0;
 	int next_idx = 0;
 	int name_len;
 	unsigned int i;
 	int bit_offset;
+	unsigned char new[F2FS_NAME_LEN + 1];
 
 	if (config.dbg_lv != -1)
 		return;
@@ -787,25 +810,49 @@ static void print_dentry(__u32 depth, __u8 *name,
 	if (tree_mark[depth - 1] == '`')
 		tree_mark[depth - 1] = ' ';
 
-
 	for (i = 1; i < depth; i++)
 		printf("%c   ", tree_mark[i]);
-	printf("%c-- %s 0x%x\n", last_de ? '`' : '|',
-				name, le32_to_cpu(dentry[idx].ino));
+
+	convert_encrypted_name(name, name_len, new, encrypted);
+
+	printf("%c-- %s <ino = 0x%x>, <encrypted (%d)>\n",
+			last_de ? '`' : '|',
+			new, le32_to_cpu(dentry[idx].ino),
+			encrypted);
+}
+
+static int f2fs_check_hash_code(struct f2fs_dir_entry *dentry,
+			const unsigned char *name, u32 len, int encrypted)
+{
+	f2fs_hash_t hash_code = f2fs_dentry_hash(name, len);
+
+	/* fix hash_code made by old buggy code */
+	if (dentry->hash_code != hash_code) {
+		unsigned char new[F2FS_NAME_LEN + 1];
+
+		convert_encrypted_name((unsigned char *)name, len,
+							new, encrypted);
+		FIX_MSG("Mismatch hash_code for \"%s\" [%x:%x]",
+				new, le32_to_cpu(dentry->hash_code),
+				hash_code);
+		dentry->hash_code = cpu_to_le32(hash_code);
+		return 1;
+	}
+	return 0;
 }
 
 static int __chk_dentries(struct f2fs_sb_info *sbi, struct child_info *child,
 			unsigned long *bitmap,
 			struct f2fs_dir_entry *dentry,
 			__u8 (*filenames)[F2FS_SLOT_LEN],
-			int max, int last_blk)
+			int max, int last_blk, int encrypted)
 {
 	struct f2fs_fsck *fsck = F2FS_FSCK(sbi);
 	enum FILE_TYPE ftype;
 	int dentries = 0;
 	u32 blk_cnt;
 	u8 *name;
-	u32 hash_code, ino;
+	u32 ino;
 	u16 name_len;;
 	int ret = 0;
 	int fixed = 0;
@@ -875,20 +922,10 @@ static int __chk_dentries(struct f2fs_sb_info *sbi, struct child_info *child,
 			i++;
 			continue;
 		}
-
 		name = calloc(name_len + 1, 1);
 		memcpy(name, filenames[i], name_len);
-		hash_code = f2fs_dentry_hash((const unsigned char *)name,
-								name_len);
 		slots = (name_len + F2FS_SLOT_LEN - 1) / F2FS_SLOT_LEN;
 
-		/* fix hash_code made by old buggy code */
-		if (le32_to_cpu(dentry[i].hash_code) != hash_code) {
-			dentry[i].hash_code = hash_code;
-			fixed = 1;
-			FIX_MSG("hash_code[%d] of %s", i, name);
-		}
-
 		/* Becareful. 'dentry.file_type' is not imode. */
 		if (ftype == F2FS_FT_DIR) {
 			if ((name[0] == '.' && name_len == 1) ||
@@ -901,13 +938,16 @@ static int __chk_dentries(struct f2fs_sb_info *sbi, struct child_info *child,
 			}
 		}
 
+		if (f2fs_check_hash_code(dentry + i, name, name_len, encrypted))
+			fixed = 1;
+
 		DBG(1, "[%3u]-[0x%x] name[%s] len[0x%x] ino[0x%x] type[0x%x]\n",
 				fsck->dentry_depth, i, name, name_len,
 				le32_to_cpu(dentry[i].ino),
 				dentry[i].file_type);
 
 		print_dentry(fsck->dentry_depth, name, bitmap,
-						dentry, max, i, last_blk);
+				dentry, max, i, last_blk, encrypted);
 
 		blk_cnt = 1;
 		ret = fsck_chk_node_blk(sbi,
@@ -951,7 +991,8 @@ int fsck_chk_inline_dentries(struct f2fs_sb_info *sbi,
 	dentries = __chk_dentries(sbi, child,
 			(unsigned long *)de_blk->dentry_bitmap,
 			de_blk->dentry, de_blk->filename,
-			NR_INLINE_DENTRY, 1);
+			NR_INLINE_DENTRY, 1,
+			file_is_encrypt(node_blk->i.i_advise));
 	if (dentries < 0) {
 		DBG(1, "[%3d] Inline Dentry Block Fixed hash_codes\n\n",
 			fsck->dentry_depth);
@@ -966,7 +1007,7 @@ int fsck_chk_inline_dentries(struct f2fs_sb_info *sbi,
 }
 
 int fsck_chk_dentry_blk(struct f2fs_sb_info *sbi, u32 blk_addr,
-		struct child_info *child, int last_blk)
+		struct child_info *child, int last_blk, int encrypted)
 {
 	struct f2fs_fsck *fsck = F2FS_FSCK(sbi);
 	struct f2fs_dentry_block *de_blk;
@@ -982,7 +1023,7 @@ int fsck_chk_dentry_blk(struct f2fs_sb_info *sbi, u32 blk_addr,
 	dentries = __chk_dentries(sbi, child,
 			(unsigned long *)de_blk->dentry_bitmap,
 			de_blk->dentry, de_blk->filename,
-			NR_DENTRY_IN_BLOCK, last_blk);
+			NR_DENTRY_IN_BLOCK, last_blk, encrypted);
 
 	if (dentries < 0) {
 		ret = dev_write_block(de_blk, blk_addr);
@@ -1002,7 +1043,8 @@ int fsck_chk_dentry_blk(struct f2fs_sb_info *sbi, u32 blk_addr,
 
 int fsck_chk_data_blk(struct f2fs_sb_info *sbi, u32 blk_addr,
 		struct child_info *child, int last_blk,
-		enum FILE_TYPE ftype, u32 parent_nid, u16 idx_in_node, u8 ver)
+		enum FILE_TYPE ftype, u32 parent_nid, u16 idx_in_node, u8 ver,
+		int encrypted)
 {
 	struct f2fs_fsck *fsck = F2FS_FSCK(sbi);
 
@@ -1035,7 +1077,8 @@ int fsck_chk_data_blk(struct f2fs_sb_info *sbi, u32 blk_addr,
 
 	if (ftype == F2FS_FT_DIR) {
 		f2fs_set_main_bitmap(sbi, blk_addr, CURSEG_HOT_DATA);
-		return fsck_chk_dentry_blk(sbi, blk_addr, child, last_blk);
+		return fsck_chk_dentry_blk(sbi, blk_addr, child,
+						last_blk, encrypted);
 	} else {
 		f2fs_set_main_bitmap(sbi, blk_addr, CURSEG_WARM_DATA);
 	}
diff --git a/fsck/fsck.h b/fsck/fsck.h
index 5eac45c..37a25ba 100644
--- a/fsck/fsck.h
+++ b/fsck/fsck.h
@@ -87,7 +87,8 @@ enum seg_type {
 
 extern void fsck_chk_orphan_node(struct f2fs_sb_info *);
 extern int fsck_chk_node_blk(struct f2fs_sb_info *, struct f2fs_inode *, u32,
-		u8 *, enum FILE_TYPE, enum NODE_TYPE, u32 *, struct child_info *);
+		u8 *, enum FILE_TYPE, enum NODE_TYPE, u32 *,
+		struct child_info *);
 extern void fsck_chk_inode_blk(struct f2fs_sb_info *, u32, enum FILE_TYPE,
 		struct f2fs_node *, u32 *, struct node_info *);
 extern int fsck_chk_dnode_blk(struct f2fs_sb_info *, struct f2fs_inode *,
@@ -98,9 +99,9 @@ extern int fsck_chk_idnode_blk(struct f2fs_sb_info *, struct f2fs_inode *,
 extern int fsck_chk_didnode_blk(struct f2fs_sb_info *, struct f2fs_inode *,
 		enum FILE_TYPE, struct f2fs_node *, u32 *, struct child_info *);
 extern int fsck_chk_data_blk(struct f2fs_sb_info *sbi, u32, struct child_info *,
-		int, enum FILE_TYPE, u32, u16, u8);
+		int, enum FILE_TYPE, u32, u16, u8, int);
 extern int fsck_chk_dentry_blk(struct f2fs_sb_info *, u32, struct child_info *,
-		int);
+		int, int);
 int fsck_chk_inline_dentries(struct f2fs_sb_info *, struct f2fs_node *,
 		struct child_info *);
 
diff --git a/include/f2fs_fs.h b/include/f2fs_fs.h
index 6aefa5d..59cc0d1 100644
--- a/include/f2fs_fs.h
+++ b/include/f2fs_fs.h
@@ -453,6 +453,15 @@ struct f2fs_extent {
 
 #define DEF_DIR_LEVEL		0
 
+/*
+ * i_advise uses FADVISE_XXX_BIT. We can add additional hints later.
+ */
+#define FADVISE_COLD_BIT       0x01
+#define FADVISE_LOST_PINO_BIT  0x02
+#define FADVISE_ENCRYPT_BIT    0x04
+
+#define file_is_encrypt(i_advise)      ((i_advise) & FADVISE_ENCRYPT_BIT)
+
 struct f2fs_inode {
 	__le16 i_mode;			/* file mode */
 	__u8 i_advise;			/* file hints */
-- 
2.1.1


------------------------------------------------------------------------------
One dashboard for servers and applications across Physical-Virtual-Cloud 
Widest out-of-the-box monitoring support with 50+ applications
Performance metrics, stats and reports that give you Actionable Insights
Deep dive visibility with transaction tracing using APM Insight.
http://ad.doubleclick.net/ddm/clk/290420510;117567292;y
