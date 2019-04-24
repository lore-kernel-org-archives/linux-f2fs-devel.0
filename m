From: Eric Biggers <ebiggers@kernel.org>
Subject: [PATCH] f2fs-tools: improve xattr value printing
Date: Wed, 24 Apr 2019 10:57:30 -0700
Message-ID: <20190424175730.70979-1-ebiggers@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <ebiggers@kernel.org>) id 1hJMAq-0000VS-Dq
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 24 Apr 2019 17:59:12 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1hJMAo-00BUvD-By
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 24 Apr 2019 17:59:12 +0000
Received: from ebiggers-linuxstation.mtv.corp.google.com (unknown
 [104.132.1.77])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id B34D920685
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed, 24 Apr 2019 17:59:04 +0000 (UTC)
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

- Print the values of xattrs that have an unknown ->e_name_index, rather
  than ignoring them.

- Replace char with u8.  Otherwise xattr values containing bytes >= 0x80
  are printed incorrectly on platforms where char is signed.

- Only parse the encryption xattr if it has a known format number and
  size.  Otherwise print it as hex.

- Remove incorrect le16_to_cpu() on ->e_name_len which has type u8.

- Consolidate the code that prints the xattr value as hex.

- Constify pointers to the xattr entry.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 fsck/mount.c | 56 ++++++++++++++++++++++------------------------------
 fsck/xattr.h |  1 +
 2 files changed, 25 insertions(+), 32 deletions(-)

diff --git a/fsck/mount.c b/fsck/mount.c
index 843742e..c69226d 100644
--- a/fsck/mount.c
+++ b/fsck/mount.c
@@ -55,11 +55,11 @@ void update_free_segments(struct f2fs_sb_info *sbi)
 }
 
 #if defined(HAVE_LINUX_POSIX_ACL_H) || defined(HAVE_SYS_ACL_H)
-void print_acl(char *value, int size)
+static void print_acl(const u8 *value, int size)
 {
-	struct f2fs_acl_header *hdr = (struct f2fs_acl_header *)value;
-	struct f2fs_acl_entry *entry = (struct f2fs_acl_entry *)(hdr + 1);
-	const char *end = value + size;
+	const struct f2fs_acl_header *hdr = (struct f2fs_acl_header *)value;
+	const struct f2fs_acl_entry *entry = (struct f2fs_acl_entry *)(hdr + 1);
+	const u8 *end = value + size;
 	int i, count;
 
 	if (hdr->a_version != cpu_to_le32(F2FS_ACL_VERSION)) {
@@ -75,7 +75,7 @@ void print_acl(char *value, int size)
 	}
 
 	for (i = 0; i < count; i++) {
-		if ((char *)entry > end) {
+		if ((u8 *)entry > end) {
 			MSG(0, "Invalid ACL entries count %d\n", count);
 			return;
 		}
@@ -114,42 +114,33 @@ void print_acl(char *value, int size)
 		}
 	}
 }
-#else
-#define print_acl(value, size) do {		\
-	int i;					\
-	for (i = 0; i < size; i++)		\
-		MSG(0, "%02X", value[i]);	\
-	MSG(0, "\n");				\
-} while (0)
-#endif
+#endif /* HAVE_LINUX_POSIX_ACL_H || HAVE_SYS_ACL_H */
 
-void print_xattr_entry(struct f2fs_xattr_entry *ent)
+static void print_xattr_entry(const struct f2fs_xattr_entry *ent)
 {
-	char *value = (char *)(ent->e_name + le16_to_cpu(ent->e_name_len));
-	struct fscrypt_context *ctx;
+	const u8 *value = (const u8 *)&ent->e_name[ent->e_name_len];
+	const int size = le16_to_cpu(ent->e_value_size);
+	const struct fscrypt_context *ctx;
 	int i;
 
 	MSG(0, "\nxattr: e_name_index:%d e_name:", ent->e_name_index);
-	for (i = 0; i < le16_to_cpu(ent->e_name_len); i++)
+	for (i = 0; i < ent->e_name_len; i++)
 		MSG(0, "%c", ent->e_name[i]);
 	MSG(0, " e_name_len:%d e_value_size:%d e_value:\n",
-			ent->e_name_len, le16_to_cpu(ent->e_value_size));
+			ent->e_name_len, size);
 
 	switch (ent->e_name_index) {
+#if defined(HAVE_LINUX_POSIX_ACL_H) || defined(HAVE_SYS_ACL_H)
 	case F2FS_XATTR_INDEX_POSIX_ACL_ACCESS:
 	case F2FS_XATTR_INDEX_POSIX_ACL_DEFAULT:
-		print_acl(value, le16_to_cpu(ent->e_value_size));
-		break;
-	case F2FS_XATTR_INDEX_USER:
-	case F2FS_XATTR_INDEX_SECURITY:
-	case F2FS_XATTR_INDEX_TRUSTED:
-	case F2FS_XATTR_INDEX_LUSTRE:
-		for (i = 0; i < le16_to_cpu(ent->e_value_size); i++)
-			MSG(0, "%02X", value[i]);
-		MSG(0, "\n");
-		break;
+		print_acl(value, size);
+		return;
+#endif
 	case F2FS_XATTR_INDEX_ENCRYPTION:
-		ctx = (struct fscrypt_context *)value;
+		ctx = (const struct fscrypt_context *)value;
+		if (size != sizeof(*ctx) ||
+		    ctx->format != FS_ENCRYPTION_CONTEXT_FORMAT_V1)
+			break;
 		MSG(0, "format: %d\n", ctx->format);
 		MSG(0, "contents_encryption_mode: 0x%x\n", ctx->contents_encryption_mode);
 		MSG(0, "filenames_encryption_mode: 0x%x\n", ctx->filenames_encryption_mode);
@@ -161,10 +152,11 @@ void print_xattr_entry(struct f2fs_xattr_entry *ent)
 		for (i = 0; i < FS_KEY_DERIVATION_NONCE_SIZE; i++)
 			MSG(0, "%02X", ctx->nonce[i]);
 		MSG(0, "\n");
-		break;
-	default:
-		break;
+		return;
 	}
+	for (i = 0; i < size; i++)
+		MSG(0, "%02X", value[i]);
+	MSG(0, "\n");
 }
 
 void print_inode_info(struct f2fs_sb_info *sbi,
diff --git a/fsck/xattr.h b/fsck/xattr.h
index dc80faf..579ab6c 100644
--- a/fsck/xattr.h
+++ b/fsck/xattr.h
@@ -34,6 +34,7 @@ struct f2fs_xattr_entry {
 	char e_name[0];		/* attribute name */
 };
 
+#define FS_ENCRYPTION_CONTEXT_FORMAT_V1 1
 #define FS_KEY_DESCRIPTOR_SIZE 8
 #define FS_KEY_DERIVATION_NONCE_SIZE 16
 
-- 
2.21.0.593.g511ec345e18-goog
