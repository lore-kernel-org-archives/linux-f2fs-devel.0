From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH] mkfs.f2fs: fix storing volume label correctly in
	utf16
Date: Mon, 14 Dec 2015 16:35:53 -0800
Message-ID: <1450139753-56845-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1a8db2-00024w-6M
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 15 Dec 2015 00:36:04 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1a8db1-0001p9-0y for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 15 Dec 2015 00:36:04 +0000
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

This patch fixes to store volume label as utf16 correctly.

Many conversion codes are copied from exfat-tools.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fsck/mount.c       |  11 ++++
 include/f2fs_fs.h  |   7 ++-
 lib/libf2fs.c      | 177 ++++++++++++++++++++++++++++++++++++++++++++++++++---
 mkfs/f2fs_format.c |   4 +-
 4 files changed, 186 insertions(+), 13 deletions(-)

diff --git a/fsck/mount.c b/fsck/mount.c
index e773471..d34c704 100644
--- a/fsck/mount.c
+++ b/fsck/mount.c
@@ -99,6 +99,14 @@ void print_node_info(struct f2fs_node *node_block)
 	}
 }
 
+static void DISP_label(u_int16_t *name)
+{
+	char buffer[MAX_VOLUME_NAME];
+
+	utf16_to_utf8(buffer, name, MAX_VOLUME_NAME, MAX_VOLUME_NAME);
+	printf("%-30s" "\t\t[%s]\n", "volum_name", buffer);
+}
+
 void print_raw_sb_info(struct f2fs_super_block *sb)
 {
 	if (!config.dbg_lv)
@@ -111,6 +119,9 @@ void print_raw_sb_info(struct f2fs_super_block *sb)
 
 	DISP_u32(sb, magic);
 	DISP_u32(sb, major_ver);
+
+	DISP_label(sb->volume_name);
+
 	DISP_u32(sb, minor_ver);
 	DISP_u32(sb, log_sectorsize);
 	DISP_u32(sb, log_sectors_per_block);
diff --git a/include/f2fs_fs.h b/include/f2fs_fs.h
index 29ff9fe..4927d24 100644
--- a/include/f2fs_fs.h
+++ b/include/f2fs_fs.h
@@ -398,6 +398,8 @@ enum {
 
 #define F2FS_FEATURE_ENCRYPT	0x0001
 
+#define MAX_VOLUME_NAME		512
+
 /*
  * For superblock
  */
@@ -430,7 +432,7 @@ struct f2fs_super_block {
 	__le32 node_ino;		/* node inode number */
 	__le32 meta_ino;		/* meta inode number */
 	__u8 uuid[16];			/* 128-bit uuid for volume */
-	__le16 volume_name[512];	/* volume name */
+	__le16 volume_name[MAX_VOLUME_NAME];	/* volume name */
 	__le32 extension_count;		/* # of extensions below */
 	__u8 extension_list[F2FS_MAX_EXTENSION][8];	/* extension array */
 	__le32 cp_payload;
@@ -847,7 +849,8 @@ enum {
 	SSR
 };
 
-extern void ASCIIToUNICODE(u_int16_t *, u_int8_t *);
+extern int utf8_to_utf16(u_int16_t *, const char *, size_t, size_t);
+extern int utf16_to_utf8(char *, const u_int16_t *, size_t, size_t);
 extern int log_base_2(u_int32_t);
 extern unsigned int addrs_per_inode(struct f2fs_inode *);
 
diff --git a/lib/libf2fs.c b/lib/libf2fs.c
index 307ad56..1802d9c 100644
--- a/lib/libf2fs.c
+++ b/lib/libf2fs.c
@@ -23,18 +23,177 @@
 
 #include <f2fs_fs.h>
 
-void ASCIIToUNICODE(u_int16_t *out_buf, u_int8_t *in_buf)
+/*
+ * UTF conversion codes are Copied from exfat tools.
+ */
+static const char *utf8_to_wchar(const char *input, wchar_t *wc,
+		size_t insize)
+{
+	if ((input[0] & 0x80) == 0 && insize >= 1) {
+		*wc = (wchar_t) input[0];
+		return input + 1;
+	}
+	if ((input[0] & 0xe0) == 0xc0 && insize >= 2) {
+		*wc = (((wchar_t) input[0] & 0x1f) << 6) |
+		       ((wchar_t) input[1] & 0x3f);
+		return input + 2;
+	}
+	if ((input[0] & 0xf0) == 0xe0 && insize >= 3) {
+		*wc = (((wchar_t) input[0] & 0x0f) << 12) |
+		      (((wchar_t) input[1] & 0x3f) << 6) |
+		       ((wchar_t) input[2] & 0x3f);
+		return input + 3;
+	}
+	if ((input[0] & 0xf8) == 0xf0 && insize >= 4) {
+		*wc = (((wchar_t) input[0] & 0x07) << 18) |
+		      (((wchar_t) input[1] & 0x3f) << 12) |
+		      (((wchar_t) input[2] & 0x3f) << 6) |
+		       ((wchar_t) input[3] & 0x3f);
+		return input + 4;
+	}
+	if ((input[0] & 0xfc) == 0xf8 && insize >= 5) {
+		*wc = (((wchar_t) input[0] & 0x03) << 24) |
+		      (((wchar_t) input[1] & 0x3f) << 18) |
+		      (((wchar_t) input[2] & 0x3f) << 12) |
+		      (((wchar_t) input[3] & 0x3f) << 6) |
+		       ((wchar_t) input[4] & 0x3f);
+		return input + 5;
+	}
+	if ((input[0] & 0xfe) == 0xfc && insize >= 6) {
+		*wc = (((wchar_t) input[0] & 0x01) << 30) |
+		      (((wchar_t) input[1] & 0x3f) << 24) |
+		      (((wchar_t) input[2] & 0x3f) << 18) |
+		      (((wchar_t) input[3] & 0x3f) << 12) |
+		      (((wchar_t) input[4] & 0x3f) << 6) |
+		       ((wchar_t) input[5] & 0x3f);
+		return input + 6;
+	}
+	return NULL;
+}
+
+static u_int16_t *wchar_to_utf16(u_int16_t *output, wchar_t wc, size_t outsize)
+{
+	if (wc <= 0xffff) {
+		if (outsize == 0)
+			return NULL;
+		output[0] = cpu_to_le16(wc);
+		return output + 1;
+	}
+	if (outsize < 2)
+		return NULL;
+	wc -= 0x10000;
+	output[0] = cpu_to_le16(0xd800 | ((wc >> 10) & 0x3ff));
+	output[1] = cpu_to_le16(0xdc00 | (wc & 0x3ff));
+	return output + 2;
+}
+
+int utf8_to_utf16(u_int16_t *output, const char *input, size_t outsize,
+		size_t insize)
+{
+	const char *inp = input;
+	u_int16_t *outp = output;
+	wchar_t wc;
+
+	while (inp - input < insize && *inp) {
+		inp = utf8_to_wchar(inp, &wc, insize - (inp - input));
+		if (inp == NULL) {
+			DBG(0, "illegal UTF-8 sequence\n");
+			return -EILSEQ;
+		}
+		outp = wchar_to_utf16(outp, wc, outsize - (outp - output));
+		if (outp == NULL) {
+			DBG(0, "name is too long\n");
+			return -ENAMETOOLONG;
+		}
+	}
+	*outp = cpu_to_le16(0);
+	return 0;
+}
+
+static const u_int16_t *utf16_to_wchar(const u_int16_t *input, wchar_t *wc,
+		size_t insize)
+{
+	if ((le16_to_cpu(input[0]) & 0xfc00) == 0xd800) {
+		if (insize < 2 || (le16_to_cpu(input[1]) & 0xfc00) != 0xdc00)
+			return NULL;
+		*wc = ((wchar_t) (le16_to_cpu(input[0]) & 0x3ff) << 10);
+		*wc |= (le16_to_cpu(input[1]) & 0x3ff);
+		*wc += 0x10000;
+		return input + 2;
+	} else {
+		*wc = le16_to_cpu(*input);
+		return input + 1;
+	}
+}
+
+static char *wchar_to_utf8(char *output, wchar_t wc, size_t outsize)
 {
-	u_int8_t *pchTempPtr = in_buf;
-	u_int16_t *pwTempPtr = out_buf;
+	if (wc <= 0x7f) {
+		if (outsize < 1)
+			return NULL;
+		*output++ = (char) wc;
+	} else if (wc <= 0x7ff) {
+		if (outsize < 2)
+			return NULL;
+		*output++ = 0xc0 | (wc >> 6);
+		*output++ = 0x80 | (wc & 0x3f);
+	} else if (wc <= 0xffff) {
+		if (outsize < 3)
+			return NULL;
+		*output++ = 0xe0 | (wc >> 12);
+		*output++ = 0x80 | ((wc >> 6) & 0x3f);
+		*output++ = 0x80 | (wc & 0x3f);
+	} else if (wc <= 0x1fffff) {
+		if (outsize < 4)
+			return NULL;
+		*output++ = 0xf0 | (wc >> 18);
+		*output++ = 0x80 | ((wc >> 12) & 0x3f);
+		*output++ = 0x80 | ((wc >> 6) & 0x3f);
+		*output++ = 0x80 | (wc & 0x3f);
+	} else if (wc <= 0x3ffffff) {
+		if (outsize < 5)
+			return NULL;
+		*output++ = 0xf8 | (wc >> 24);
+		*output++ = 0x80 | ((wc >> 18) & 0x3f);
+		*output++ = 0x80 | ((wc >> 12) & 0x3f);
+		*output++ = 0x80 | ((wc >> 6) & 0x3f);
+		*output++ = 0x80 | (wc & 0x3f);
+	} else if (wc <= 0x7fffffff) {
+		if (outsize < 6)
+			return NULL;
+		*output++ = 0xfc | (wc >> 30);
+		*output++ = 0x80 | ((wc >> 24) & 0x3f);
+		*output++ = 0x80 | ((wc >> 18) & 0x3f);
+		*output++ = 0x80 | ((wc >> 12) & 0x3f);
+		*output++ = 0x80 | ((wc >> 6) & 0x3f);
+		*output++ = 0x80 | (wc & 0x3f);
+	} else
+		return NULL;
+
+	return output;
+}
 
-	while (*pchTempPtr != '\0') {
-		*pwTempPtr = (u_int16_t)*pchTempPtr;
-		pchTempPtr++;
-		pwTempPtr++;
+int utf16_to_utf8(char *output, const u_int16_t *input, size_t outsize,
+		size_t insize)
+{
+	const u_int16_t *inp = input;
+	char *outp = output;
+	wchar_t wc;
+
+	while (inp - input < insize && le16_to_cpu(*inp)) {
+		inp = utf16_to_wchar(inp, &wc, insize - (inp - input));
+		if (inp == NULL) {
+			DBG(0, "illegal UTF-16 sequence\n");
+			return -EILSEQ;
+		}
+		outp = wchar_to_utf8(outp, wc, outsize - (outp - output));
+		if (outp == NULL) {
+			DBG(0, "name is too long\n");
+			return -ENAMETOOLONG;
+		}
 	}
-	*pwTempPtr = '\0';
-	return;
+	*outp = '\0';
+	return 0;
 }
 
 int log_base_2(u_int32_t num)
diff --git a/mkfs/f2fs_format.c b/mkfs/f2fs_format.c
index a2f33f9..fff74a9 100644
--- a/mkfs/f2fs_format.c
+++ b/mkfs/f2fs_format.c
@@ -291,8 +291,8 @@ static int f2fs_prepare_super_block(void)
 
 	uuid_generate(sb->uuid);
 
-	ASCIIToUNICODE(sb->volume_name, (u_int8_t *)config.vol_label);
-
+	utf8_to_utf16(sb->volume_name, (const char *)config.vol_label,
+				MAX_VOLUME_NAME, strlen(config.vol_label));
 	set_sb(node_ino, 1);
 	set_sb(meta_ino, 2);
 	set_sb(root_ino, 3);
-- 
2.5.4 (Apple Git-61)


------------------------------------------------------------------------------
