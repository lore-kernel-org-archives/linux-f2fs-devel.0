Return-Path: <SRS0=taWa=KS=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67CA3C47080
	for <linux-f2fs-devel@archiver.kernel.org>; Sun, 23 May 2021 22:43:06 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0890D61076;
	Sun, 23 May 2021 22:43:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0890D61076
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1lkwoI-0005sh-2f; Sun, 23 May 2021 22:43:02 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <jaegeuk@kernel.org>) id 1lkwoG-0005sR-AR
 for linux-f2fs-devel@lists.sourceforge.net; Sun, 23 May 2021 22:43:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=1yzY4hg+VpG5wgzk+UIRX7NwceifSkyxw2yAt7JMZ44=; b=L3Lz03ajsJFZGADFRonEqn4bTK
 pNnyV3UfvdQMmILtk11jOKf/Tez0FDgxcTAI+mV325fXTtEN2SZKkB8olk7v8kmfYHQedXv5fOagy
 hTO7/T0Bl86QTGvZo6YpU+WKXFTXIukgVD/ZKAezjlw9lp5HmwDMKIZzV7PExMURjM8U=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=1yzY4hg+VpG5wgzk+UIRX7NwceifSkyxw2yAt7JMZ44=; b=T
 YoqkdrSULau1DrG2SzIotNESRrJCSIpbBJsHe7LmLNeQ40y+7KGnAUZt3oxR/Sx+8ZSjmjV1qpagO
 Iqr421VV3ezkWwOKR5OD/2GoG8/usrF/HrBGtvOqEwVVSSdzHzTSOyfdowDNDi0C8an9/xe0tDL2p
 /n90uH2FMe/KCgg8=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.3)
 id 1lkwo9-0005nF-AG
 for linux-f2fs-devel@lists.sourceforge.net; Sun, 23 May 2021 22:43:01 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id EEE9161076;
 Sun, 23 May 2021 22:42:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1621809764;
 bh=aMGl910E+TtRb84+RLrcBFzeDJ8WA4PP6+dZlUT94ek=;
 h=From:To:Cc:Subject:Date:From;
 b=WZDsNmVzUY2QrKH05meyud+Nqp9IaWnR3BZikOGIlpYKJ0wpENBIvns7K68PBJgjQ
 XFU9fH3Fkh84JkDpI5C512pLcVm814J7zv4pHrc/XLy++eYmHOkLvEYD6eDXg5zfAc
 kp1XD2VlO4WwZffzTeRZViA2CkcgPf4TsP2Qndn5ydjDjUGTTNgT+FziIgf4ExDST6
 3inAjb2dpSebtOWQPVG2sAbyrFOxcYfIAF63hOgGLIi9POSo8l5NhsAxF6MBPEn9Y+
 RLXW8WTCJ/FWHldvuFPYNh2A801IsYuxS9ZAD96Qy07/a3SkgtBN/Lu6eo3zgONCzl
 O0osSjOtwgjYg==
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: linux-f2fs-devel@lists.sourceforge.net
Date: Sun, 23 May 2021 15:42:42 -0700
Message-Id: <20210523224242.1568092-1-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.31.1.818.g46aad6cb9e-goog
MIME-Version: 1.0
X-Headers-End: 1lkwo9-0005nF-AG
Subject: [f2fs-dev] [PATCH] fsck.f2fs: add "-l" to show the layout
 information
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
Cc: Jaegeuk Kim <jaegeuk@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

This patch add an option to print out superblock and checkpoint only.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fsck/main.c       |  6 +++++-
 fsck/mount.c      | 15 ++++++++++++---
 include/f2fs_fs.h | 30 ++++++++++++++++++++++++------
 3 files changed, 41 insertions(+), 10 deletions(-)

diff --git a/fsck/main.c b/fsck/main.c
index 392a68710566..3e34f716eb7b 100644
--- a/fsck/main.c
+++ b/fsck/main.c
@@ -71,6 +71,7 @@ void fsck_usage()
 	MSG(0, "  -d debug level [default:0]\n");
 	MSG(0, "  -f check/fix entire partition\n");
 	MSG(0, "  -g add default options\n");
+	MSG(0, "  -l show superblock/checkpoint\n");
 	MSG(0, "  -O feature1[feature2,feature3,...] e.g. \"encrypt\"\n");
 	MSG(0, "  -p preen mode [default:0 the same as -a [0|1]]\n");
 	MSG(0, "  -S sparse_mode\n");
@@ -216,7 +217,7 @@ void f2fs_parse_options(int argc, char *argv[])
 	}
 
 	if (!strcmp("fsck.f2fs", prog)) {
-		const char *option_string = ":aC:c:m:d:fg:O:p:q:StyV";
+		const char *option_string = ":aC:c:m:d:fg:lO:p:q:StyV";
 		int opt = 0, val;
 		char *token;
 		struct option long_opt[] = {
@@ -263,6 +264,9 @@ void f2fs_parse_options(int argc, char *argv[])
 				if (!strcmp(optarg, "android"))
 					c.defset = CONF_ANDROID;
 				break;
+			case 'l':
+				c.layout = 1;
+				break;
 			case 'O':
 				if (parse_feature(feature_table, optarg))
 					fsck_usage();
diff --git a/fsck/mount.c b/fsck/mount.c
index 98262702687d..c6383be6621a 100644
--- a/fsck/mount.c
+++ b/fsck/mount.c
@@ -369,11 +369,16 @@ static void DISP_label(u_int16_t *name)
 	char buffer[MAX_VOLUME_NAME];
 
 	utf16_to_utf8(buffer, name, MAX_VOLUME_NAME, MAX_VOLUME_NAME);
-	printf("%-30s" "\t\t[%s]\n", "volum_name", buffer);
+	if (c.layout)
+		printf("%-30s %s\n", "Filesystem volume name:", buffer);
+	else
+		printf("%-30s" "\t\t[%s]\n", "volum_name", buffer);
 }
 
 void print_raw_sb_info(struct f2fs_super_block *sb)
 {
+	if (c.layout)
+		goto printout;
 	if (!c.dbg_lv)
 		return;
 
@@ -381,7 +386,7 @@ void print_raw_sb_info(struct f2fs_super_block *sb)
 	printf("+--------------------------------------------------------+\n");
 	printf("| Super block                                            |\n");
 	printf("+--------------------------------------------------------+\n");
-
+printout:
 	DISP_u32(sb, magic);
 	DISP_u32(sb, major_ver);
 
@@ -427,6 +432,8 @@ void print_ckpt_info(struct f2fs_sb_info *sbi)
 {
 	struct f2fs_checkpoint *cp = F2FS_CKPT(sbi);
 
+	if (c.layout)
+		goto printout;
 	if (!c.dbg_lv)
 		return;
 
@@ -434,7 +441,7 @@ void print_ckpt_info(struct f2fs_sb_info *sbi)
 	printf("+--------------------------------------------------------+\n");
 	printf("| Checkpoint                                             |\n");
 	printf("+--------------------------------------------------------+\n");
-
+printout:
 	DISP_u64(cp, checkpoint_ver);
 	DISP_u64(cp, user_block_count);
 	DISP_u64(cp, valid_block_count);
@@ -3549,6 +3556,8 @@ int f2fs_do_mount(struct f2fs_sb_info *sbi)
 		if (get_cp(ckpt_flags) & CP_QUOTA_NEED_FSCK_FLAG)
 			c.fix_on = 1;
 	}
+	if (c.layout)
+		return 1;
 
 	if (tune_sb_features(sbi))
 		return -1;
diff --git a/include/f2fs_fs.h b/include/f2fs_fs.h
index 580aa6846027..af867d29e009 100644
--- a/include/f2fs_fs.h
+++ b/include/f2fs_fs.h
@@ -239,14 +239,14 @@ static inline uint64_t bswap_64(uint64_t val)
 
 #define MSG(n, fmt, ...)						\
 	do {								\
-		if (c.dbg_lv >= n) {					\
+		if (c.dbg_lv >= n && !c.layout) {			\
 			printf(fmt, ##__VA_ARGS__);			\
 		}							\
 	} while (0)
 
 #define DBG(n, fmt, ...)						\
 	do {								\
-		if (c.dbg_lv >= n) {					\
+		if (c.dbg_lv >= n && !c.layout) {			\
 			printf("[%s:%4d] " fmt,				\
 				__func__, __LINE__, ##__VA_ARGS__);	\
 		}							\
@@ -261,7 +261,11 @@ static inline uint64_t bswap_64(uint64_t val)
 #define DISP_u16(ptr, member)						\
 	do {								\
 		assert(sizeof((ptr)->member) == 2);			\
-		printf("%-30s" "\t\t[0x%8x : %u]\n",			\
+		if (c.layout)						\
+			printf("%-30s %u\n",				\
+			#member":", le16_to_cpu(((ptr)->member)));	\
+		else							\
+			printf("%-30s" "\t\t[0x%8x : %u]\n",		\
 			#member, le16_to_cpu(((ptr)->member)),		\
 			le16_to_cpu(((ptr)->member)));			\
 	} while (0)
@@ -269,7 +273,11 @@ static inline uint64_t bswap_64(uint64_t val)
 #define DISP_u32(ptr, member)						\
 	do {								\
 		assert(sizeof((ptr)->member) <= 4);			\
-		printf("%-30s" "\t\t[0x%8x : %u]\n",			\
+		if (c.layout)						\
+			printf("%-30s %u\n",				\
+			#member":", le32_to_cpu(((ptr)->member)));	\
+		else							\
+			printf("%-30s" "\t\t[0x%8x : %u]\n",		\
 			#member, le32_to_cpu(((ptr)->member)),		\
 			le32_to_cpu(((ptr)->member)));			\
 	} while (0)
@@ -277,14 +285,23 @@ static inline uint64_t bswap_64(uint64_t val)
 #define DISP_u64(ptr, member)						\
 	do {								\
 		assert(sizeof((ptr)->member) == 8);			\
-		printf("%-30s" "\t\t[0x%8llx : %llu]\n",		\
+		if (c.layout)						\
+			printf("%-30s %llu\n",				\
+			#member":", le64_to_cpu(((ptr)->member)));	\
+		else							\
+			printf("%-30s" "\t\t[0x%8llx : %llu]\n",	\
 			#member, le64_to_cpu(((ptr)->member)),		\
 			le64_to_cpu(((ptr)->member)));			\
 	} while (0)
 
 #define DISP_utf(ptr, member)						\
 	do {								\
-		printf("%-30s" "\t\t[%s]\n", #member, ((ptr)->member)); \
+		if (c.layout)						\
+			printf("%-30s %s\n", #member":",		\
+					((ptr)->member)); 		\
+		else							\
+			printf("%-30s" "\t\t[%s]\n", #member,		\
+					((ptr)->member));		\
 	} while (0)
 
 /* Display to buffer */
@@ -471,6 +488,7 @@ struct f2fs_configuration {
 	int bug_nat_bits;
 	int alloc_failed;
 	int auto_fix;
+	int layout;
 	int quota_fix;
 	int preen_mode;
 	int ro;
-- 
2.31.1.818.g46aad6cb9e-goog



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
