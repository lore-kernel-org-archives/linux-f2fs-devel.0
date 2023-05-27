Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD5ACC77B7C
	for <linux-f2fs-devel@archiver.kernel.org>; Sat, 27 May 2023 00:01:42 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1q2hNN-0000r9-FY;
	Sat, 27 May 2023 00:01:41 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1q2hNL-0000r3-GE
 for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 27 May 2023 00:01:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=lrIzLAXuX7mIPcHLNGzD5NBDPc2k0HVRuCtee6uEuDs=; b=IHQwUGyZ8tvJ9YCLl+fcMSS2Zf
 Ch27En6hVrXtGCIZdgtMAR1WPMvRxjFWHQbOnkT8ytbVtJ4vlKK4CV1vnjSaLNSrzS0ya88Bcj58s
 SfUPgBOyPMP29bQUJxZffIhpWPWte5wahJ2tdVFTE5u883OyyiEYHxnKb8U5HBZBVexk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=lrIzLAXuX7mIPcHLNGzD5NBDPc2k0HVRuCtee6uEuDs=; b=RM8MwkmgPsdLZzIhkzAIBHUtCt
 o4WrahjA1R+vr6UCFQUo0mTnwdTU8wE61vCz5ztL/P+mxRCv8w4ZYBx1KyvoE3iyH0kWOpKHiS8Pa
 XrjGEZnqwLjzhioZSdOfbZkf0rWopek4tQGb2VFglJNQjGRYKh1WNL7cLBQFd3bv+1x8=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1q2hNL-0006Tz-80 for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 27 May 2023 00:01:39 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id D37BC653F4
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Sat, 27 May 2023 00:01:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 480E9C433EF;
 Sat, 27 May 2023 00:01:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1685145693;
 bh=kWqKwdrOXdMa/Y28gH47Kk23aJbDLSmA56Soc7KWzZM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=W4P3OVGjA6GIobCGSBguIwYyfdJ0Gzla6hhJt5DaWzZBRt7piEhlIyIfcIwwOcjS0
 ta8UajNZKfwEJ2bZaOGJkcKFo6r7QsMn2mGNBWQY/VpsaNXyCTZsuP6A16f8hVnoS/
 Q8ecm8vxoPGQmiuIVdc6bTIndTvGpQR7Tbkiu9Z7f+IKzILyQS9ENB1CCVdHyTkwJK
 MZnh0FBKru34N0rB1EyVJ5VSL8kcFouWTqPrpul7zTrvjwowOEk1UauJwe1HzpXG2V
 suYYPySpYDduRFZcIQSjBHx3xfBki5gbSAwtFr6MHA5g87szz95ga0E/A6a3cJKND6
 OxjBh3UlgfgHw==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Date: Sat, 27 May 2023 08:01:26 +0800
Message-Id: <20230527000126.3595875-2-chao@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230527000126.3595875-1-chao@kernel.org>
References: <20230527000126.3595875-1-chao@kernel.org>
MIME-Version: 1.0
X-Headers-End: 1q2hNL-0006Tz-80
Subject: [f2fs-dev] [PATCH v4 2/2] f2fs-tools: reuse feature_table to clean
 up print_sb_state()
X-BeenThere: linux-f2fs-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

reuse feature_table in print_sb_state() for cleanup.

Signed-off-by: Chao Yu <chao@kernel.org>
---
v4:
- use MAX_NR_FEATURE instead of constant
 fsck/mount.c      | 56 +++++++++++++----------------------------------
 include/f2fs_fs.h | 54 +++++++++++++++++++++++++++++++--------------
 2 files changed, 52 insertions(+), 58 deletions(-)

diff --git a/fsck/mount.c b/fsck/mount.c
index 0b953f4..f1fb525 100644
--- a/fsck/mount.c
+++ b/fsck/mount.c
@@ -599,54 +599,28 @@ void print_cp_state(u32 flag)
 	MSG(0, "\n");
 }
 
+extern struct feature feature_table[];
 void print_sb_state(struct f2fs_super_block *sb)
 {
 	unsigned int f = get_sb(feature);
+	char *name;
 	int i;
 
 	MSG(0, "Info: superblock features = %x : ", f);
-	if (f & F2FS_FEATURE_ENCRYPT) {
-		MSG(0, "%s", " encrypt");
-	}
-	if (f & F2FS_FEATURE_VERITY) {
-		MSG(0, "%s", " verity");
-	}
-	if (f & F2FS_FEATURE_BLKZONED) {
-		MSG(0, "%s", " blkzoned");
-	}
-	if (f & F2FS_FEATURE_EXTRA_ATTR) {
-		MSG(0, "%s", " extra_attr");
-	}
-	if (f & F2FS_FEATURE_PRJQUOTA) {
-		MSG(0, "%s", " project_quota");
-	}
-	if (f & F2FS_FEATURE_INODE_CHKSUM) {
-		MSG(0, "%s", " inode_checksum");
-	}
-	if (f & F2FS_FEATURE_FLEXIBLE_INLINE_XATTR) {
-		MSG(0, "%s", " flexible_inline_xattr");
-	}
-	if (f & F2FS_FEATURE_QUOTA_INO) {
-		MSG(0, "%s", " quota_ino");
-	}
-	if (f & F2FS_FEATURE_INODE_CRTIME) {
-		MSG(0, "%s", " inode_crtime");
-	}
-	if (f & F2FS_FEATURE_LOST_FOUND) {
-		MSG(0, "%s", " lost_found");
-	}
-	if (f & F2FS_FEATURE_SB_CHKSUM) {
-		MSG(0, "%s", " sb_checksum");
-	}
-	if (f & F2FS_FEATURE_CASEFOLD) {
-		MSG(0, "%s", " casefold");
-	}
-	if (f & F2FS_FEATURE_COMPRESSION) {
-		MSG(0, "%s", " compression");
-	}
-	if (f & F2FS_FEATURE_RO) {
-		MSG(0, "%s", " ro");
+
+	for (i = 0; i < MAX_NR_FEATURE; i++) {
+		unsigned int bit = 1 << i;
+
+		if (!(f & bit))
+			continue;
+
+		name = feature_name(feature_table, bit);
+		if (!name)
+			continue;
+
+		MSG(0, " %s", name);
 	}
+
 	MSG(0, "\n");
 	MSG(0, "Info: superblock encrypt level = %d, salt = ",
 					sb->encryption_level);
diff --git a/include/f2fs_fs.h b/include/f2fs_fs.h
index 9d35b42..385d373 100644
--- a/include/f2fs_fs.h
+++ b/include/f2fs_fs.h
@@ -684,6 +684,8 @@ enum {
 #define F2FS_FEATURE_COMPRESSION	0x2000
 #define F2FS_FEATURE_RO			0x4000
 
+#define MAX_NR_FEATURE			32
+
 #define MAX_VOLUME_NAME		512
 
 /*
@@ -1811,35 +1813,53 @@ static inline void f2fs_init_inode(struct f2fs_super_block *sb,
 
 struct feature {
 	char *name;
-	u32  mask;
+	u32 mask;
+	u32 settable;
 };
 
 #define INIT_FEATURE_TABLE						\
 struct feature feature_table[] = {					\
-	{ "encrypt",			F2FS_FEATURE_ENCRYPT },		\
-	{ "extra_attr",			F2FS_FEATURE_EXTRA_ATTR },	\
-	{ "project_quota",		F2FS_FEATURE_PRJQUOTA },	\
-	{ "inode_checksum",		F2FS_FEATURE_INODE_CHKSUM },	\
-	{ "flexible_inline_xattr",	F2FS_FEATURE_FLEXIBLE_INLINE_XATTR },\
-	{ "quota",			F2FS_FEATURE_QUOTA_INO },	\
-	{ "inode_crtime",		F2FS_FEATURE_INODE_CRTIME },	\
-	{ "lost_found",			F2FS_FEATURE_LOST_FOUND },	\
-	{ "verity",			F2FS_FEATURE_VERITY },	/* reserved */ \
-	{ "sb_checksum",		F2FS_FEATURE_SB_CHKSUM },	\
-	{ "casefold",			F2FS_FEATURE_CASEFOLD },	\
-	{ "compression",		F2FS_FEATURE_COMPRESSION },	\
-	{ "ro",				F2FS_FEATURE_RO},		\
-	{ NULL,				0x0},				\
+	{ "encrypt",			F2FS_FEATURE_ENCRYPT,		1}, \
+	{ "blkzoned",			F2FS_FEATURE_BLKZONED,		0}, \
+	{ "extra_attr",			F2FS_FEATURE_EXTRA_ATTR,	1}, \
+	{ "project_quota",		F2FS_FEATURE_PRJQUOTA,		1}, \
+	{ "inode_checksum",		F2FS_FEATURE_INODE_CHKSUM,	1}, \
+	{ "flexible_inline_xattr",	F2FS_FEATURE_FLEXIBLE_INLINE_XATTR,1}, \
+	{ "quota",			F2FS_FEATURE_QUOTA_INO,		1}, \
+	{ "inode_crtime",		F2FS_FEATURE_INODE_CRTIME,	1}, \
+	{ "lost_found",			F2FS_FEATURE_LOST_FOUND,	1}, \
+	{ "verity",			F2FS_FEATURE_VERITY,		1}, \
+	{ "sb_checksum",		F2FS_FEATURE_SB_CHKSUM,		1}, \
+	{ "casefold",			F2FS_FEATURE_CASEFOLD,		1}, \
+	{ "compression",		F2FS_FEATURE_COMPRESSION,	1}, \
+	{ "ro",				F2FS_FEATURE_RO,		1}, \
+	{ NULL,				0x0,				0}, \
 };
 
 static inline u32 feature_map(struct feature *table, char *feature)
 {
 	struct feature *p;
-	for (p = table; p->name && strcmp(p->name, feature); p++)
-		;
+	for (p = table; p->name; p++) {
+		if (!p->settable)
+			continue;
+		if (strcmp(p->name, feature))
+			continue;
+		break;
+	}
 	return p->mask;
 }
 
+static inline char *feature_name(struct feature *table, u32 mask)
+{
+	struct feature *p;
+	for (p = table; p->name; p++) {
+		if (p->mask != mask)
+			continue;
+		break;
+	}
+	return p->name;
+}
+
 static inline int set_feature_bits(struct feature *table, char *features)
 {
 	u32 mask = feature_map(table, features);
-- 
2.40.1



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
