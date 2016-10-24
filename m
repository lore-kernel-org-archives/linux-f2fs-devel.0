From: Sheng Yong <shengyong1@huawei.com>
Subject: [PATCH 1/2] dump/fsck: convert encrypted file name
Date: Mon, 24 Oct 2016 10:16:03 +0800
Message-ID: <20161024021604.5218-1-shengyong1@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <shengyong1@huawei.com>) id 1byUx6-0003TN-RI
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 24 Oct 2016 02:25:28 +0000
Received: from szxga03-in.huawei.com ([119.145.14.66])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1byUx1-0005nS-Vj
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 24 Oct 2016 02:25:28 +0000
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: linux-f2fs-devel@lists.sourceforge.net, jaegeuk@kernel.org, yuchao0@huawei.com

If fscrypt is enabled, we need to convert the encrypted file name before
printing it. So let's export convert_encrypted_name for other functions,
and make it returns the length of converted string.
This patch also changes the parameter of file_is_encrypt to f2fs_inode.

Signed-off-by: Sheng Yong <shengyong1@huawei.com>
---
 fsck/dump.c       |  6 ++++--
 fsck/fsck.c       | 46 ++++++++++++++++++++++++++++++++--------------
 fsck/fsck.h       |  1 +
 fsck/mount.c      | 10 +++++++---
 include/f2fs_fs.h |  2 +-
 5 files changed, 45 insertions(+), 20 deletions(-)

diff --git a/fsck/dump.c b/fsck/dump.c
index befffd7..8e7c85c 100644
--- a/fsck/dump.c
+++ b/fsck/dump.c
@@ -353,9 +353,10 @@ static void dump_file(struct f2fs_sb_info *sbi, struct node_info *ni,
 	struct f2fs_inode *inode = &node_blk->i;
 	u32 imode = le32_to_cpu(inode->i_mode);
 	u32 namelen = le32_to_cpu(inode->i_namelen);
-	char name[255] = {0};
+	unsigned char name[F2FS_NAME_LEN + 1] = {0};
 	char path[1024] = {0};
 	char ans[255] = {0};
+	int is_encrypt = file_is_encrypt(inode);
 	int ret;
 
 	if (!S_ISREG(imode) || namelen == 0 || namelen > F2FS_NAME_LEN) {
@@ -375,7 +376,8 @@ dump:
 		ASSERT(ret >= 0);
 
 		/* make a file */
-		strncpy(name, (const char *)inode->i_name, namelen);
+		namelen = convert_encrypted_name(inode->i_name, namelen,
+							name, is_encrypt);
 		name[namelen] = 0;
 		sprintf(path, "./lost_found/%s", name);
 
diff --git a/fsck/fsck.c b/fsck/fsck.c
index 7dd311f..d0392c3 100644
--- a/fsck/fsck.c
+++ b/fsck/fsck.c
@@ -426,8 +426,19 @@ static int sanity_check_nid(struct f2fs_sb_info *sbi, u32 nid,
 	if (ntype == TYPE_INODE && ftype == F2FS_FT_DIR) {
 		u32 len = le32_to_cpu(node_blk->i.i_namelen);
 		if (name && memcmp(name, node_blk->i.i_name, len)) {
-			ASSERT_MSG("mismatch name [0x%x] [%s vs. %s]",
-					nid, name, node_blk->i.i_name);
+			int is_encrypt = file_is_encrypt(&node_blk->i);
+			unsigned char en1[F2FS_NAME_LEN + 1];
+			unsigned char en2[F2FS_NAME_LEN + 1];
+			/* if file is encrypted, its parent must be encrypted */
+			int len1 = convert_encrypted_name(name, len, en1,
+							is_encrypt);
+			int len2 = convert_encrypted_name(node_blk->i.i_name,
+							len, en2, is_encrypt);
+			en1[len1] = '\0';
+			en2[len2] = '\0';
+			ASSERT_MSG("mismatch name [0x%x] [%s vs. %s]%s",
+					nid, en1, en2,
+					is_encrypt ? " <encrypted>" : "");
 			return -EINVAL;
 		}
 	}
@@ -607,6 +618,8 @@ void fsck_chk_inode_blk(struct f2fs_sb_info *sbi, u32 nid,
 	u32 i_links = le32_to_cpu(node_blk->i.i_links);
 	u64 i_size = le64_to_cpu(node_blk->i.i_size);
 	u64 i_blocks = le64_to_cpu(node_blk->i.i_blocks);
+	unsigned char en[F2FS_NAME_LEN + 1];
+	int namelen;
 	unsigned int idx = 0;
 	int need_fix = 0;
 	int ret;
@@ -727,7 +740,7 @@ void fsck_chk_inode_blk(struct f2fs_sb_info *sbi, u32 nid,
 					blkaddr,
 					&child, (i_blocks == *blk_cnt),
 					ftype, nid, idx, ni->version,
-					file_is_encrypt(node_blk->i.i_advise));
+					file_is_encrypt(&node_blk->i));
 			if (!ret) {
 				*blk_cnt = *blk_cnt + 1;
 			} else if (c.fix_on) {
@@ -798,16 +811,18 @@ check:
 		}
 	}
 skip_blkcnt_fix:
+	namelen = convert_encrypted_name(node_blk->i.i_name,
+					le32_to_cpu(node_blk->i.i_namelen),
+					en, file_is_encrypt(&node_blk->i));
+	en[namelen] = '\0';
 	if (ftype == F2FS_FT_ORPHAN)
 		DBG(1, "Orphan Inode: 0x%x [%s] i_blocks: %u\n\n",
 				le32_to_cpu(node_blk->footer.ino),
-				node_blk->i.i_name,
-				(u32)i_blocks);
+				en, (u32)i_blocks);
 
 	if (ftype == F2FS_FT_DIR) {
 		DBG(1, "Directory Inode: 0x%x [%s] depth: %d has %d files\n\n",
-				le32_to_cpu(node_blk->footer.ino),
-				node_blk->i.i_name,
+				le32_to_cpu(node_blk->footer.ino), en,
 				le32_to_cpu(node_blk->i.i_current_depth),
 				child.files);
 
@@ -883,7 +898,7 @@ int fsck_chk_dnode_blk(struct f2fs_sb_info *sbi, struct f2fs_inode *inode,
 			blkaddr, child,
 			le64_to_cpu(inode->i_blocks) == *blk_cnt, ftype,
 			nid, idx, ni->version,
-			file_is_encrypt(inode->i_advise));
+			file_is_encrypt(inode));
 		if (!ret) {
 			*blk_cnt = *blk_cnt + 1;
 		} else if (c.fix_on) {
@@ -1009,17 +1024,17 @@ static int digest_encode(const char *src, int len, char *dst)
 	return cp - dst;
 }
 
-static void convert_encrypted_name(unsigned char *name, int len,
+int convert_encrypted_name(unsigned char *name, int len,
 				unsigned char *new, int encrypted)
 {
 	if (!encrypted) {
 		memcpy(new, name, len);
 		new[len] = 0;
-		return;
+		return len;
 	}
 
 	*new = '_';
-	digest_encode((const char *)name, 24, (char *)new + 1);
+	return digest_encode((const char *)name, 24, (char *)new + 1);
 }
 
 static void print_dentry(__u32 depth, __u8 *name,
@@ -1220,7 +1235,8 @@ static int __chk_dentries(struct f2fs_sb_info *sbi, struct child_info *child,
 	int dentries = 0;
 	u32 blk_cnt;
 	u8 *name;
-	u16 name_len;;
+	unsigned char en[F2FS_NAME_LEN + 1];
+	u16 name_len, en_len;
 	int ret = 0;
 	int fixed = 0;
 	int i, slots;
@@ -1332,8 +1348,10 @@ static int __chk_dentries(struct f2fs_sb_info *sbi, struct child_info *child,
 			f2fs_check_dirent_position(name, name_len, child->pgofs,
 						child->dir_level, child->p_ino);
 
+		en_len = convert_encrypted_name(name, name_len, en, encrypted);
+		en[en_len] = '\0';
 		DBG(1, "[%3u]-[0x%x] name[%s] len[0x%x] ino[0x%x] type[0x%x]\n",
-				fsck->dentry_depth, i, name, name_len,
+				fsck->dentry_depth, i, en, name_len,
 				le32_to_cpu(dentry[i].ino),
 				dentry[i].file_type);
 
@@ -1383,7 +1401,7 @@ int fsck_chk_inline_dentries(struct f2fs_sb_info *sbi,
 			de_blk->dentry_bitmap,
 			de_blk->dentry, de_blk->filename,
 			NR_INLINE_DENTRY, 1,
-			file_is_encrypt(node_blk->i.i_advise));
+			file_is_encrypt(&node_blk->i));
 	if (dentries < 0) {
 		DBG(1, "[%3d] Inline Dentry Block Fixed hash_codes\n\n",
 			fsck->dentry_depth);
diff --git a/fsck/fsck.h b/fsck/fsck.h
index 438d29b..0aab55e 100644
--- a/fsck/fsck.h
+++ b/fsck/fsck.h
@@ -130,6 +130,7 @@ extern int fsck_chk_dentry_blk(struct f2fs_sb_info *, u32, struct child_info *,
 int fsck_chk_inline_dentries(struct f2fs_sb_info *, struct f2fs_node *,
 		struct child_info *);
 int fsck_chk_meta(struct f2fs_sb_info *sbi);
+int convert_encrypted_name(unsigned char *, int, unsigned char *, int);
 
 extern void update_free_segments(struct f2fs_sb_info *);
 void print_cp_state(u32);
diff --git a/fsck/mount.c b/fsck/mount.c
index f343718..ca7f6dd 100644
--- a/fsck/mount.c
+++ b/fsck/mount.c
@@ -37,12 +37,17 @@ void update_free_segments(struct f2fs_sb_info *sbi)
 
 void print_inode_info(struct f2fs_inode *inode, int name)
 {
+	unsigned char en[F2FS_NAME_LEN + 1];
 	unsigned int i = 0;
 	int namelen = le32_to_cpu(inode->i_namelen);
+	int is_encrypt = file_is_encrypt(inode);
 
+	namelen = convert_encrypted_name(inode->i_name, namelen, en, is_encrypt);
+	en[namelen] = '\0';
 	if (name && namelen) {
 		inode->i_name[namelen] = '\0';
-		MSG(0, " - File name         : %s\n", inode->i_name);
+		MSG(0, " - File name         : %s%s\n", en,
+				is_encrypt ? " <encrypted>" : "");
 		setlocale(LC_ALL, "");
 		MSG(0, " - File size         : %'llu (bytes)\n",
 				le64_to_cpu(inode->i_size));
@@ -74,8 +79,7 @@ void print_inode_info(struct f2fs_inode *inode, int name)
 
 	if (namelen) {
 		DISP_u32(inode, i_namelen);
-		inode->i_name[namelen] = '\0';
-		DISP_utf(inode, i_name);
+		printf("%-30s\t\t[%s]\n", "i_name", en);
 	}
 
 	printf("i_ext: fofs:%x blkaddr:%x len:%x\n",
diff --git a/include/f2fs_fs.h b/include/f2fs_fs.h
index bfe9b3f..56cdcab 100644
--- a/include/f2fs_fs.h
+++ b/include/f2fs_fs.h
@@ -606,7 +606,7 @@ struct f2fs_extent {
 #define FADVISE_LOST_PINO_BIT  0x02
 #define FADVISE_ENCRYPT_BIT    0x04
 
-#define file_is_encrypt(i_advise)      ((i_advise) & FADVISE_ENCRYPT_BIT)
+#define file_is_encrypt(fi)      ((fi)->i_advise & FADVISE_ENCRYPT_BIT)
 
 struct f2fs_inode {
 	__le16 i_mode;			/* file mode */
-- 
2.10.1


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most 
engaging tech sites, SlashDot.org! http://sdm.link/slashdot
