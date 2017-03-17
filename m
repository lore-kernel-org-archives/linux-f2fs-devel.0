From: Kinglong Mee <kinglongmee@gmail.com>
Subject: [PATCH 2/2] fsck.f2fs: check encrypted filename depends
 FADVISE_ENC_NAME_BIT
Date: Fri, 17 Mar 2017 21:56:19 +0800
Message-ID: <76b23f5e-34d8-d5d7-53f7-75a76accaa53@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <kinglongmee@gmail.com>) id 1cosMq-0005uF-40
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 17 Mar 2017 13:56:32 +0000
Received: from mail-it0-f68.google.com ([209.85.214.68])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1cosMo-0006nv-8p
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 17 Mar 2017 13:56:32 +0000
Received: by mail-it0-f68.google.com with SMTP id g138so4099651itb.0
	for <linux-f2fs-devel@lists.sourceforge.net>;
	Fri, 17 Mar 2017 06:56:30 -0700 (PDT)
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Jaegeuk Kim <jaegeuk@kernel.org>, linux-f2fs-devel@lists.sourceforge.net

An encrypted directory under an unencrypted directory, the filename isn't encrypted.

Signed-off-by: Kinglong Mee <kinglongmee@gmail.com>
---
 fsck/dump.c       |  4 ++--
 fsck/fsck.c       | 44 ++++++++++++++++++++++----------------------
 fsck/mount.c      |  6 +++---
 include/f2fs_fs.h |  2 ++
 4 files changed, 29 insertions(+), 27 deletions(-)

diff --git a/fsck/dump.c b/fsck/dump.c
index 8cbeda1..22e2265 100644
--- a/fsck/dump.c
+++ b/fsck/dump.c
@@ -356,7 +356,7 @@ static void dump_file(struct f2fs_sb_info *sbi, struct node_info *ni,
 	unsigned char name[F2FS_NAME_LEN + 1] = {0};
 	char path[1024] = {0};
 	char ans[255] = {0};
-	int is_encrypt = file_is_encrypt(inode);
+	int enc_name = file_enc_name(inode);
 	int ret;
 
 	if (!S_ISREG(imode) || namelen == 0 || namelen > F2FS_NAME_LEN) {
@@ -377,7 +377,7 @@ dump:
 
 		/* make a file */
 		namelen = convert_encrypted_name(inode->i_name, namelen,
-							name, is_encrypt);
+							name, enc_name);
 		name[namelen] = 0;
 		sprintf(path, "./lost_found/%s", name);
 
diff --git a/fsck/fsck.c b/fsck/fsck.c
index 1c23199..cbd29cc 100644
--- a/fsck/fsck.c
+++ b/fsck/fsck.c
@@ -720,7 +720,7 @@ void fsck_chk_inode_blk(struct f2fs_sb_info *sbi, u32 nid,
 					blkaddr,
 					&child, (i_blocks == *blk_cnt),
 					ftype, nid, idx, ni->version,
-					file_is_encrypt(&node_blk->i));
+					file_enc_name(&node_blk->i));
 			if (!ret) {
 				*blk_cnt = *blk_cnt + 1;
 			} else if (c.fix_on) {
@@ -793,7 +793,7 @@ check:
 skip_blkcnt_fix:
 	namelen = convert_encrypted_name(node_blk->i.i_name,
 					le32_to_cpu(node_blk->i.i_namelen),
-					en, file_is_encrypt(&node_blk->i));
+					en, file_enc_name(&node_blk->i));
 	en[namelen] = '\0';
 	if (ftype == F2FS_FT_ORPHAN)
 		DBG(1, "Orphan Inode: 0x%x [%s] i_blocks: %u\n\n",
@@ -878,7 +878,7 @@ int fsck_chk_dnode_blk(struct f2fs_sb_info *sbi, struct f2fs_inode *inode,
 			blkaddr, child,
 			le64_to_cpu(inode->i_blocks) == *blk_cnt, ftype,
 			nid, idx, ni->version,
-			file_is_encrypt(inode));
+			file_enc_name(inode));
 		if (!ret) {
 			*blk_cnt = *blk_cnt + 1;
 		} else if (c.fix_on) {
@@ -1005,9 +1005,9 @@ static int digest_encode(const char *src, int len, char *dst)
 }
 
 int convert_encrypted_name(unsigned char *name, int len,
-				unsigned char *new, int encrypted)
+				unsigned char *new, int enc_name)
 {
-	if (!encrypted) {
+	if (!enc_name) {
 		memcpy(new, name, len);
 		new[len] = 0;
 		return len;
@@ -1019,7 +1019,7 @@ int convert_encrypted_name(unsigned char *name, int len,
 
 static void print_dentry(__u32 depth, __u8 *name,
 		u8 *bitmap, struct f2fs_dir_entry *dentry,
-		int max, int idx, int last_blk, int encrypted)
+		int max, int idx, int last_blk, int enc_name)
 {
 	int last_de = 0;
 	int next_idx = 0;
@@ -1056,16 +1056,16 @@ static void print_dentry(__u32 depth, __u8 *name,
 	for (i = 1; i < depth; i++)
 		printf("%c   ", tree_mark[i]);
 
-	convert_encrypted_name(name, name_len, new, encrypted);
+	convert_encrypted_name(name, name_len, new, enc_name);
 
 	printf("%c-- %s <ino = 0x%x>, <encrypted (%d)>\n",
 			last_de ? '`' : '|',
 			new, le32_to_cpu(dentry[idx].ino),
-			encrypted);
+			enc_name);
 }
 
 static int f2fs_check_hash_code(struct f2fs_dir_entry *dentry,
-			const unsigned char *name, u32 len, int encrypted)
+			const unsigned char *name, u32 len, int enc_name)
 {
 	f2fs_hash_t hash_code = f2fs_dentry_hash(name, len);
 
@@ -1074,7 +1074,7 @@ static int f2fs_check_hash_code(struct f2fs_dir_entry *dentry,
 		unsigned char new[F2FS_NAME_LEN + 1];
 
 		convert_encrypted_name((unsigned char *)name, len,
-							new, encrypted);
+							new, enc_name);
 		FIX_MSG("Mismatch hash_code for \"%s\" [%x:%x]",
 				new, le32_to_cpu(dentry->hash_code),
 				hash_code);
@@ -1156,7 +1156,7 @@ static int __chk_dots_dentries(struct f2fs_sb_info *sbi,
 			       struct child_info *child,
 			       u8 *name, int len,
 			       __u8 (*filename)[F2FS_SLOT_LEN],
-			       int encrypted)
+			       int enc_name)
 {
 	int fixed = 0;
 
@@ -1185,7 +1185,7 @@ static int __chk_dots_dentries(struct f2fs_sb_info *sbi,
 		}
 	}
 
-	if (f2fs_check_hash_code(dentry, name, len, encrypted))
+	if (f2fs_check_hash_code(dentry, name, len, enc_name))
 		fixed = 1;
 
 	if (name[len] != '\0') {
@@ -1208,7 +1208,7 @@ static void nullify_dentry(struct f2fs_dir_entry *dentry, int offs,
 static int __chk_dentries(struct f2fs_sb_info *sbi, struct child_info *child,
 			u8 *bitmap, struct f2fs_dir_entry *dentry,
 			__u8 (*filenames)[F2FS_SLOT_LEN],
-			int max, int last_blk, int encrypted)
+			int max, int last_blk, int enc_name)
 {
 	struct f2fs_fsck *fsck = F2FS_FSCK(sbi);
 	enum FILE_TYPE ftype;
@@ -1298,7 +1298,7 @@ static int __chk_dentries(struct f2fs_sb_info *sbi, struct child_info *child,
 							name_len == 2)) {
 				ret = __chk_dots_dentries(sbi, &dentry[i],
 					child, name, name_len, &filenames[i],
-					encrypted);
+					enc_name);
 				switch (ret) {
 				case 1:
 					fixed = 1;
@@ -1321,7 +1321,7 @@ static int __chk_dentries(struct f2fs_sb_info *sbi, struct child_info *child,
 			}
 		}
 
-		if (f2fs_check_hash_code(dentry + i, name, name_len, encrypted))
+		if (f2fs_check_hash_code(dentry + i, name, name_len, enc_name))
 			fixed = 1;
 
 		if (max == NR_DENTRY_IN_BLOCK) {
@@ -1340,7 +1340,7 @@ static int __chk_dentries(struct f2fs_sb_info *sbi, struct child_info *child,
 			}
 		}
 
-		en_len = convert_encrypted_name(name, name_len, en, encrypted);
+		en_len = convert_encrypted_name(name, name_len, en, enc_name);
 		en[en_len] = '\0';
 		DBG(1, "[%3u]-[0x%x] name[%s] len[0x%x] ino[0x%x] type[0x%x]\n",
 				fsck->dentry_depth, i, en, name_len,
@@ -1348,7 +1348,7 @@ static int __chk_dentries(struct f2fs_sb_info *sbi, struct child_info *child,
 				dentry[i].file_type);
 
 		print_dentry(fsck->dentry_depth, name, bitmap,
-				dentry, max, i, last_blk, encrypted);
+				dentry, max, i, last_blk, enc_name);
 
 		blk_cnt = 1;
 		ret = fsck_chk_node_blk(sbi,
@@ -1393,7 +1393,7 @@ int fsck_chk_inline_dentries(struct f2fs_sb_info *sbi,
 			de_blk->dentry_bitmap,
 			de_blk->dentry, de_blk->filename,
 			NR_INLINE_DENTRY, 1,
-			file_is_encrypt(&node_blk->i));
+			file_enc_name(&node_blk->i));
 	if (dentries < 0) {
 		DBG(1, "[%3d] Inline Dentry Block Fixed hash_codes\n\n",
 			fsck->dentry_depth);
@@ -1408,7 +1408,7 @@ int fsck_chk_inline_dentries(struct f2fs_sb_info *sbi,
 }
 
 int fsck_chk_dentry_blk(struct f2fs_sb_info *sbi, u32 blk_addr,
-		struct child_info *child, int last_blk, int encrypted)
+		struct child_info *child, int last_blk, int enc_name)
 {
 	struct f2fs_fsck *fsck = F2FS_FSCK(sbi);
 	struct f2fs_dentry_block *de_blk;
@@ -1424,7 +1424,7 @@ int fsck_chk_dentry_blk(struct f2fs_sb_info *sbi, u32 blk_addr,
 	dentries = __chk_dentries(sbi, child,
 			de_blk->dentry_bitmap,
 			de_blk->dentry, de_blk->filename,
-			NR_DENTRY_IN_BLOCK, last_blk, encrypted);
+			NR_DENTRY_IN_BLOCK, last_blk, enc_name);
 
 	if (dentries < 0 && !c.ro) {
 		ret = dev_write_block(de_blk, blk_addr);
@@ -1445,7 +1445,7 @@ int fsck_chk_dentry_blk(struct f2fs_sb_info *sbi, u32 blk_addr,
 int fsck_chk_data_blk(struct f2fs_sb_info *sbi, u32 blk_addr,
 		struct child_info *child, int last_blk,
 		enum FILE_TYPE ftype, u32 parent_nid, u16 idx_in_node, u8 ver,
-		int encrypted)
+		int enc_name)
 {
 	struct f2fs_fsck *fsck = F2FS_FSCK(sbi);
 
@@ -1479,7 +1479,7 @@ int fsck_chk_data_blk(struct f2fs_sb_info *sbi, u32 blk_addr,
 	if (ftype == F2FS_FT_DIR) {
 		f2fs_set_main_bitmap(sbi, blk_addr, CURSEG_HOT_DATA);
 		return fsck_chk_dentry_blk(sbi, blk_addr, child,
-						last_blk, encrypted);
+						last_blk, enc_name);
 	} else {
 		f2fs_set_main_bitmap(sbi, blk_addr, CURSEG_WARM_DATA);
 	}
diff --git a/fsck/mount.c b/fsck/mount.c
index 7bc016b..3ced1e2 100644
--- a/fsck/mount.c
+++ b/fsck/mount.c
@@ -40,14 +40,14 @@ void print_inode_info(struct f2fs_inode *inode, int name)
 	unsigned char en[F2FS_NAME_LEN + 1];
 	unsigned int i = 0;
 	int namelen = le32_to_cpu(inode->i_namelen);
-	int is_encrypt = file_is_encrypt(inode);
+	int enc_name = file_enc_name(inode);
 
-	namelen = convert_encrypted_name(inode->i_name, namelen, en, is_encrypt);
+	namelen = convert_encrypted_name(inode->i_name, namelen, en, enc_name);
 	en[namelen] = '\0';
 	if (name && namelen) {
 		inode->i_name[namelen] = '\0';
 		MSG(0, " - File name         : %s%s\n", en,
-				is_encrypt ? " <encrypted>" : "");
+				enc_name ? " <encrypted>" : "");
 		setlocale(LC_ALL, "");
 		MSG(0, " - File size         : %'llu (bytes)\n",
 				le64_to_cpu(inode->i_size));
diff --git a/include/f2fs_fs.h b/include/f2fs_fs.h
index 8e5c2f8..fa9d536 100644
--- a/include/f2fs_fs.h
+++ b/include/f2fs_fs.h
@@ -613,8 +613,10 @@ struct f2fs_extent {
 #define FADVISE_COLD_BIT       0x01
 #define FADVISE_LOST_PINO_BIT  0x02
 #define FADVISE_ENCRYPT_BIT    0x04
+#define FADVISE_ENC_NAME_BIT   0x08
 
 #define file_is_encrypt(fi)      ((fi)->i_advise & FADVISE_ENCRYPT_BIT)
+#define file_enc_name(fi)        ((fi)->i_advise & FADVISE_ENC_NAME_BIT)
 
 struct f2fs_inode {
 	__le16 i_mode;			/* file mode */
-- 
2.9.3


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
