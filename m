From: Eric Biggers <ebiggers@kernel.org>
Subject: [PATCH] f2fs-tools: improve filename printing
Date: Wed, 24 Apr 2019 10:59:09 -0700
Message-ID: <20190424175909.71430-1-ebiggers@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <ebiggers@kernel.org>) id 1hJMAy-0006Ce-SC
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 24 Apr 2019 17:59:20 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1hJMAv-00B5qQ-W7
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 24 Apr 2019 17:59:20 +0000
Received: from ebiggers-linuxstation.mtv.corp.google.com (unknown
 [104.132.1.77])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 48BE520835
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed, 24 Apr 2019 17:59:12 +0000 (UTC)
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: linux-f2fs-devel@lists.sourceforge.net

From: Eric Biggers <ebiggers@google.com>

- Make buffers for pretty-printed filenames 341 bytes long, long enough
  for 255 (NAME_MAX) base64-encoded bytes.  Then print encrypted
  filenames in full, base64-encoded.  This will be useful for tests I'm
  writing which verify the correct ciphertext is stored on-disk.

- Rename convert_encrypted_name() to pretty_print_filename(), to make it
  clear that it handles unencrypted names too.  Also make the output
  'char' rather than 'unsigned char', as it's for printing; and remove
  the unnecessary return value.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 fsck/dump.c       | 12 ++++------
 fsck/fsck.c       | 58 ++++++++++++++++++++---------------------------
 fsck/fsck.h       |  3 ++-
 fsck/mount.c      | 10 ++++----
 include/f2fs_fs.h |  4 ++++
 5 files changed, 40 insertions(+), 47 deletions(-)

diff --git a/fsck/dump.c b/fsck/dump.c
index 07dc2fc..390361d 100644
--- a/fsck/dump.c
+++ b/fsck/dump.c
@@ -627,8 +627,8 @@ static void dump_dirent(u32 blk_addr, int is_inline, int enc_name)
 
 	while (i < d.max) {
 		struct f2fs_dir_entry *de;
-		unsigned char en[F2FS_NAME_LEN + 1];
-		u16 en_len, name_len;
+		char en[F2FS_PRINT_NAMELEN];
+		u16 name_len;
 		int enc;
 
 		if (!test_bit_le(i, d.bitmap)) {
@@ -654,18 +654,16 @@ static void dump_dirent(u32 blk_addr, int is_inline, int enc_name)
 			}
 		}
 
-		en_len = convert_encrypted_name(d.filename[i],
-				le16_to_cpu(de->name_len), en, enc);
-		en[en_len] = '\0';
+		pretty_print_filename(d.filename[i], name_len, en, enc);
 
 		DBG(1, "bitmap pos[0x%x] name[%s] len[0x%x] hash[0x%x] ino[0x%x] type[0x%x]\n",
 				i, en,
-				le16_to_cpu(de->name_len),
+				name_len,
 				le32_to_cpu(de->hash_code),
 				le32_to_cpu(de->ino),
 				de->file_type);
 
-		i += GET_DENTRY_SLOTS(le16_to_cpu(de->name_len));
+		i += GET_DENTRY_SLOTS(name_len);
 	}
 
 	free(blk);
diff --git a/fsck/fsck.c b/fsck/fsck.c
index a1791d4..e7b3fba 100644
--- a/fsck/fsck.c
+++ b/fsck/fsck.c
@@ -660,7 +660,7 @@ void fsck_chk_inode_blk(struct f2fs_sb_info *sbi, u32 nid,
 	u64 i_size = le64_to_cpu(node_blk->i.i_size);
 	u64 i_blocks = le64_to_cpu(node_blk->i.i_blocks);
 	int ofs;
-	unsigned char *en;
+	char *en;
 	u32 namelen;
 	unsigned int idx = 0;
 	unsigned short i_gc_failures;
@@ -907,7 +907,7 @@ check:
 		}
 	}
 skip_blkcnt_fix:
-	en = malloc(F2FS_NAME_LEN + 1);
+	en = malloc(F2FS_PRINT_NAMELEN);
 	ASSERT(en);
 
 	namelen = le32_to_cpu(node_blk->i.i_namelen);
@@ -926,9 +926,8 @@ skip_blkcnt_fix:
 		} else
 			namelen = F2FS_NAME_LEN;
 	}
-	namelen = convert_encrypted_name(node_blk->i.i_name, namelen,
-					en, file_enc_name(&node_blk->i));
-	en[namelen] = '\0';
+	pretty_print_filename(node_blk->i.i_name, namelen, en,
+			      file_enc_name(&node_blk->i));
 	if (ftype == F2FS_FT_ORPHAN)
 		DBG(1, "Orphan Inode: 0x%x [%s] i_blocks: %u\n\n",
 				le32_to_cpu(node_blk->footer.ino),
@@ -1168,45 +1167,40 @@ static const char *lookup_table =
         "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+,";
 
 /**
- * digest_encode() -
+ * base64_encode() -
  *
- * Encodes the input digest using characters from the set [a-zA-Z0-9_+].
+ * Encodes the input string using characters from the set [A-Za-z0-9+,].
  * The encoded string is roughly 4/3 times the size of the input string.
  */
-static int digest_encode(const char *src, int len, char *dst)
+static int base64_encode(const u8 *src, int len, char *dst)
 {
-	int i = 0, bits = 0, ac = 0;
+	int i, bits = 0, ac = 0;
 	char *cp = dst;
 
-	while (i < len && i < 24) {
-		ac += (((unsigned char) src[i]) << bits);
+	for (i = 0; i < len; i++) {
+		ac += src[i] << bits;
 		bits += 8;
 		do {
 			*cp++ = lookup_table[ac & 0x3f];
 			ac >>= 6;
 			bits -= 6;
 		} while (bits >= 6);
-		i++;
 	}
 	if (bits)
 		*cp++ = lookup_table[ac & 0x3f];
-	*cp = 0;
 	return cp - dst;
 }
 
-int convert_encrypted_name(unsigned char *name, u32 len,
-				unsigned char *new, int enc_name)
+void pretty_print_filename(const u8 *raw_name, u32 len,
+			   char out[F2FS_PRINT_NAMELEN], int enc_name)
 {
-	if (!enc_name) {
-		if (len > F2FS_NAME_LEN)
-			len = F2FS_NAME_LEN;
-		memcpy(new, name, len);
-		new[len] = 0;
-		return len;
-	}
+	len = min(len, (u32)F2FS_NAME_LEN);
 
-	*new = '_';
-	return digest_encode((const char *)name, len, (char *)new + 1);
+	if (enc_name)
+		len = base64_encode(raw_name, len, out);
+	else
+		memcpy(out, raw_name, len);
+	out[len] = 0;
 }
 
 static void print_dentry(__u32 depth, __u8 *name,
@@ -1218,7 +1212,7 @@ static void print_dentry(__u32 depth, __u8 *name,
 	u32 name_len;
 	unsigned int i;
 	int bit_offset;
-	unsigned char new[F2FS_NAME_LEN + 1];
+	char new[F2FS_PRINT_NAMELEN];
 
 	if (!c.show_dentry)
 		return;
@@ -1248,7 +1242,7 @@ static void print_dentry(__u32 depth, __u8 *name,
 	for (i = 1; i < depth; i++)
 		printf("%c   ", tree_mark[i]);
 
-	convert_encrypted_name(name, name_len, new, enc_name);
+	pretty_print_filename(name, name_len, new, enc_name);
 
 	printf("%c-- %s <ino = 0x%x>, <encrypted (%d)>\n",
 			last_de ? '`' : '|',
@@ -1263,10 +1257,9 @@ static int f2fs_check_hash_code(struct f2fs_dir_entry *dentry,
 
 	/* fix hash_code made by old buggy code */
 	if (dentry->hash_code != hash_code) {
-		unsigned char new[F2FS_NAME_LEN + 1];
+		char new[F2FS_PRINT_NAMELEN];
 
-		convert_encrypted_name((unsigned char *)name, len,
-							new, enc_name);
+		pretty_print_filename(name, len, new, enc_name);
 		FIX_MSG("Mismatch hash_code for \"%s\" [%x:%x]",
 				new, le32_to_cpu(dentry->hash_code),
 				hash_code);
@@ -1380,8 +1373,8 @@ static int __chk_dentries(struct f2fs_sb_info *sbi, struct child_info *child,
 	int dentries = 0;
 	u32 blk_cnt;
 	u8 *name;
-	unsigned char en[F2FS_NAME_LEN + 1];
-	u16 name_len, en_len;
+	char en[F2FS_PRINT_NAMELEN];
+	u16 name_len;
 	int ret = 0;
 	int fixed = 0;
 	int i, slots;
@@ -1507,8 +1500,7 @@ static int __chk_dentries(struct f2fs_sb_info *sbi, struct child_info *child,
 			}
 		}
 
-		en_len = convert_encrypted_name(name, name_len, en, enc_name);
-		en[en_len] = '\0';
+		pretty_print_filename(name, name_len, en, enc_name);
 		DBG(1, "[%3u]-[0x%x] name[%s] len[0x%x] ino[0x%x] type[0x%x]\n",
 				fsck->dentry_depth, i, en, name_len,
 				le32_to_cpu(dentry[i].ino),
diff --git a/fsck/fsck.h b/fsck/fsck.h
index c8802b0..4991a63 100644
--- a/fsck/fsck.h
+++ b/fsck/fsck.h
@@ -157,7 +157,8 @@ int fsck_chk_inline_dentries(struct f2fs_sb_info *, struct f2fs_node *,
 void fsck_chk_checkpoint(struct f2fs_sb_info *sbi);
 int fsck_chk_meta(struct f2fs_sb_info *sbi);
 int fsck_chk_curseg_info(struct f2fs_sb_info *);
-int convert_encrypted_name(unsigned char *, u32, unsigned char *, int);
+void pretty_print_filename(const u8 *raw_name, u32 len,
+			   char out[F2FS_PRINT_NAMELEN], int enc_name);
 
 extern void update_free_segments(struct f2fs_sb_info *);
 void print_cp_state(u32);
diff --git a/fsck/mount.c b/fsck/mount.c
index c69226d..4800d26 100644
--- a/fsck/mount.c
+++ b/fsck/mount.c
@@ -165,16 +165,14 @@ void print_inode_info(struct f2fs_sb_info *sbi,
 	struct f2fs_inode *inode = &node->i;
 	void *xattr_addr;
 	struct f2fs_xattr_entry *ent;
-	unsigned char en[F2FS_NAME_LEN + 1];
+	char en[F2FS_PRINT_NAMELEN];
 	unsigned int i = 0;
 	u32 namelen = le32_to_cpu(inode->i_namelen);
 	int enc_name = file_enc_name(inode);
 	int ofs = __get_extra_isize(inode);
 
-	namelen = convert_encrypted_name(inode->i_name, namelen, en, enc_name);
-	en[namelen] = '\0';
-	if (name && namelen) {
-		inode->i_name[namelen] = '\0';
+	pretty_print_filename(inode->i_name, namelen, en, enc_name);
+	if (name && en[0]) {
 		MSG(0, " - File name         : %s%s\n", en,
 				enc_name ? " <encrypted>" : "");
 		setlocale(LC_ALL, "");
@@ -206,7 +204,7 @@ void print_inode_info(struct f2fs_sb_info *sbi,
 	DISP_u32(inode, i_pino);
 	DISP_u32(inode, i_dir_level);
 
-	if (namelen) {
+	if (en[0]) {
 		DISP_u32(inode, i_namelen);
 		printf("%-30s\t\t[%s]\n", "i_name", en);
 	}
diff --git a/include/f2fs_fs.h b/include/f2fs_fs.h
index 9f76795..f0a558e 100644
--- a/include/f2fs_fs.h
+++ b/include/f2fs_fs.h
@@ -726,6 +726,10 @@ struct f2fs_extent {
 } __attribute__((packed));
 
 #define F2FS_NAME_LEN		255
+
+/* max output length of pretty_print_filename() including null terminator */
+#define F2FS_PRINT_NAMELEN	(4 * ((F2FS_NAME_LEN + 2) / 3) + 1)
+
 /* 200 bytes for inline xattrs by default */
 #define DEFAULT_INLINE_XATTR_ADDRS	50
 #define DEF_ADDRS_PER_INODE	923	/* Address Pointers in an Inode */
-- 
2.21.0.593.g511ec345e18-goog
