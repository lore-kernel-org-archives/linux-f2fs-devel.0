Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDBAEC7EE23
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 26 May 2023 14:47:22 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1q2Yiu-0004wo-9H;
	Fri, 26 May 2023 14:47:20 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1q2THU-0002Mc-Ty
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 26 May 2023 08:58:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=GrfyfVOE5OV5ZL8Wswx9+m14xy/ywsK2MKASdvA/bGM=; b=isl0ohCRZTELvOz3VmISjjegmy
 fnY7L1+lXvfpRCQqfEQtToVjmhOtbZt0Sop4Is8U6Sq70ZNwrPsJqBFo9Bfu1/paqI6tBeOV+gjKP
 icIozmH1sUUzVyPpdmGKtaDjvpLKXialEaHluYVkXOKXbUAQARJwo0wuBO12DQMVugKQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=GrfyfVOE5OV5ZL8Wswx9+m14xy/ywsK2MKASdvA/bGM=; b=f
 nXgnd7SER8J2S8KWvQ8+R1PIA/q9pYR2OVM/LtOs2/FpOw+DTW0uRpFv6jn4q3C8BCqNqPmcgv+MD
 4DABDAEArLj/WHkZDxU8S6TXIgE0n4RZoaeXwH9E0humhWrjN16bZVGPZ39zH1ZjrYz0N/r24TKqR
 VN/I7YqEmewQT544=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1q2THT-0037OE-GN for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 26 May 2023 08:58:41 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 18E4264CF6
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri, 26 May 2023 08:58:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51ED7C433D2;
 Fri, 26 May 2023 08:58:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1685091513;
 bh=aWshqpSyTaKXNMhCURcUPX9BJKvcaA3mrkJ1WKdkOwQ=;
 h=From:To:Cc:Subject:Date:From;
 b=Y8fBKlQbOJpmS0DHTSp2YzRxBqjtzZk6ulJC/lhfbBYvpPzMLnqitky2gpGcKPaOk
 4WqVpNbT+J8ygU5JAn8EEnunkZ5YiEk7Y1yfwjYCKihgH3+OfTuNb7s/ey9VGvzDwb
 gNO7skSC4VvDcLlDZs5wP2zLuM0xwf1nCm+zhNUBcdgr5gIb98z3VpVSbJEQ6FbC46
 kMJ4dXlqDuh1g//PA/iqV7dk58F5JoIwXzyayL08MdZYlnnde8MxnM9NRipgQE1WRH
 MuaboyL1L8r+LB1hzg02lqHwAv5KYiTSAa30clIVhbx7+HrTg2qvaH8aU8m9GnUUR7
 Mxu5PaHHjA7xA==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Date: Fri, 26 May 2023 16:58:27 +0800
Message-Id: <20230526085827.3113644-1-chao@kernel.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
X-Headers-End: 1q2THT-0037OE-GN
Subject: [f2fs-dev] [PATCH v3 2/2] f2fs-tools: reuse feature_table to clean
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
v3:
- fix a bug in feature_map()
 fsck/mount.c      | 56 +++++++++++++----------------------------------
 include/f2fs_fs.h | 52 +++++++++++++++++++++++++++++--------------
 2 files changed, 50 insertions(+), 58 deletions(-)

diff --git a/fsck/mount.c b/fsck/mount.c
index ea38b14..18c5e2b 100644
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
+	for (i = 0; i < 32; i++) {
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
index 9d35b42..229b2aa 100644
--- a/include/f2fs_fs.h
+++ b/include/f2fs_fs.h
@@ -1811,35 +1811,53 @@ static inline void f2fs_init_inode(struct f2fs_super_block *sb,
 
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
