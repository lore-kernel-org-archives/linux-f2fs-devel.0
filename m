Return-Path: <SRS0=P3m+=NO=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4058DC4338F
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 23 Aug 2021 17:17:33 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 07A5961528;
	Mon, 23 Aug 2021 17:17:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 07A5961528
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1mIDZk-0000jh-7g; Mon, 23 Aug 2021 17:17:32 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <jaegeuk@kernel.org>) id 1mIDZi-0000ja-5N
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 23 Aug 2021 17:17:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=4Tgc+gsOVG5xS2Hkq2/5EYB3SHvtOrvfFfSGsvolWFk=; b=Si1+u+JHcEw36z+s6B3mjjpfg9
 kfukeFaGY08Vp0ERrqSpc4fNP2cBmXDK1+tf+NCX9q3QqvGgDZT9RZ3+luTHc45jVpFXwlPSOF919
 /Y6Ke7zrotRJxrfDVjjBO4nVdAOyja1u98GQzF4S7ddvpxLvylc+yFCwsDM/fufckqs8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=4Tgc+gsOVG5xS2Hkq2/5EYB3SHvtOrvfFfSGsvolWFk=; b=P
 d0ZDf1F23c0BYyQ4kKGo9KlJSf20hYEBkxaXtyB2syiaVatnbLDV8Q1LPxpjYKjMTIazD5LxGjnPQ
 neE72cWQwclPbOKcwlYUh9gNSYkl+nITX0tsCXqJCvHOcVZxpK9LHigjxMoqKiy/sjNX4o6v7nQgt
 KPk9GzN+267K6gEc=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.3)
 id 1mIDZh-00G03L-LF
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 23 Aug 2021 17:17:30 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0F31261528;
 Mon, 23 Aug 2021 17:17:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1629739044;
 bh=pYsR1v3Um7gfFwSwneYYIi7cUXXoZP4ItIFE8SPt3gY=;
 h=From:To:Cc:Subject:Date:From;
 b=jq3fion41bukBXHPTuIB6IE03anPoKWBKOAC56IdrF2A58ATSFSR/TYiic6q9A7nj
 s94DikhjF37ARPMfc14xqsf8YWe/jvm9p+cSBrF03nZLsAFHZ+HuaDkJ/UooxnsiV2
 T16bT1rbLdT79I3Q9tSkBhaMwPwbys3bOlBOkjxDHKwHzth3QJ5t8ikpiWPLlaN/6E
 5L281I9CIRY/gfu7hwetHkd8RexvnVkt6x7ppcqF144C8plG8AzUr4RKecYUgKArkO
 nXtSTnPmczlnhIN8ytEdw1B1/hHxdDfbEWjczeRFJOihSzRk6uUiEHAVncVDKwxytN
 6cB7kqENDZvgQ==
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: linux-f2fs-devel@lists.sourceforge.net
Date: Mon, 23 Aug 2021 10:17:22 -0700
Message-Id: <20210823171722.1705378-1-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.33.0.rc2.250.ged5fa647cd-goog
MIME-Version: 1.0
X-Headers-End: 1mIDZh-00G03L-LF
Subject: [f2fs-dev] [PATCH] f2fs_io: add rename w/ fsync option
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
Cc: Jaegeuk Kim <jaegeuk@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

From: Jaegeuk Kim <jaegeuk@google.com>

e.g., f2fs_io rename source dest 1
      1. open(source)
      2. rename(source, dest)
      3. fsync(source)
      4. close(source)

Signed-off-by: Jaegeuk Kim <jaegeuk@google.com>
---
 tools/f2fs_io/f2fs_io.c | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/tools/f2fs_io/f2fs_io.c b/tools/f2fs_io/f2fs_io.c
index 42dbd60c513a..caa77d344f85 100644
--- a/tools/f2fs_io/f2fs_io.c
+++ b/tools/f2fs_io/f2fs_io.c
@@ -1169,6 +1169,41 @@ static void do_get_filename_encrypt_mode (int argc, char **argv,
 	exit(0);
 }
 
+#define rename_desc "rename source to target file with fsync option"
+#define rename_help							\
+"f2fs_io rename [src_path] [target_path] [fsync_after_rename]\n\n"	\
+"e.g., f2fs_io rename source dest 1\n"					\
+"      1. open(source)\n"						\
+"      2. rename(source, dest)\n"					\
+"      3. fsync(source)\n"						\
+"      4. close(source)\n"
+
+static void do_rename(int argc, char **argv, const struct cmd_desc *cmd)
+{
+	int fd = -1;
+	int ret;
+
+	if (argc != 4) {
+		fputs("Excess arguments\n\n", stderr);
+		fputs(cmd->cmd_help, stderr);
+		exit(1);
+	}
+
+	if (atoi(argv[3]))
+		fd = xopen(argv[1], O_WRONLY, 0);
+
+	ret = rename(argv[1], argv[2]);
+	if (ret < 0)
+		die_errno("rename failed");
+
+	if (fd >= 0) {
+		if (fsync(fd) != 0)
+			die_errno("fsync failed: %s", argv[1]);
+		close(fd);
+	}
+	exit(0);
+}
+
 #define CMD_HIDDEN 	0x0001
 #define CMD(name) { #name, do_##name, name##_desc, name##_help, 0 }
 #define _CMD(name) { #name, do_##name, NULL, NULL, CMD_HIDDEN }
@@ -1199,6 +1234,7 @@ const struct cmd_desc cmd_list[] = {
 	CMD(decompress),
 	CMD(compress),
 	CMD(get_filename_encrypt_mode),
+	CMD(rename),
 	{ NULL, NULL, NULL, NULL, 0 }
 };
 
-- 
2.33.0.rc2.250.ged5fa647cd-goog



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
