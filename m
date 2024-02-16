Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B869C4829E
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 16 Feb 2024 00:17:29 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1raluw-0006zc-SU;
	Fri, 16 Feb 2024 00:17:27 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <jaegeuk@kernel.org>) id 1raluv-0006zO-4X
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 16 Feb 2024 00:17:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=r3g4yo7gkuTGAWScLtzlvipQ1D3UgyisuLo3mMkaSLQ=; b=T39mxs+f9+fDHTBhxaWQOMm7U7
 ILFg26vwkzLtmP8xyQeuETSFRrpXr5fA/15YrNRCOaAlbJAQDr6ToQw6wB3vZi/0cTng1O2JnfNGS
 ksLeaqEeXGHUsx0USt8ISV7CZslAUh2pTnKGXvA+lry0nr0MHIQwgDgWab7ZnTuGJ8Dw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=r3g4yo7gkuTGAWScLtzlvipQ1D3UgyisuLo3mMkaSLQ=; b=A
 z+6cDwDoX1cfikjQmvtLDh1djbojbUKg5ZAyMvFXw97Ih3Dv3U7lfdxQzn9Lj0dxLZhtkA9GlO3E3
 jRSnNl/o77BLKh823VdevjYc8yzm5SyZRuYpNpyJWNxgbZN+3I7Z5wCXbq9B46Oz8Yrz3K3aHfk/F
 FS/CV4dcbdiuyLJA=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1ralut-0003Ib-77 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 16 Feb 2024 00:17:25 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 4E48061E37;
 Fri, 16 Feb 2024 00:17:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD050C433C7;
 Fri, 16 Feb 2024 00:17:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1708042633;
 bh=t1Mg/+HzacDM5xdrUssbBFS2zTsl/yLITQlumxvXG2w=;
 h=From:To:Cc:Subject:Date:From;
 b=gMA+nHaIolb7nOgvNCyLAGl9IEJ0K6b4eqdHPtPCZ8TzOCcpBcsvDKS1RGIuAYAxY
 p7ec57JLhK4j6EEesO9kgz+8AmeB9la5Dtr+w6V/gyWAtpmkZCBwSKf2kmrJuAkNvu
 BZ1NMO35aP3qZaD4Kg3X2e3Pfv3uX9LBgSGVeEdV+ZvneXYD538pj+kwDG2+cfqzok
 o6h6gtVjA12TpvLQrC+7tJNPfz/oXTtKwEmaIMzZAuZe5guV2IHb0A222HzaHmDu7V
 PCSjc3fQX2K+91Zpo9QsCFHve7z6N5ogGHY7hYxwnaQTrsrS94pVQb8XZrgy1Sl7NR
 oiMclHlEaAyiw==
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: linux-f2fs-devel@lists.sourceforge.net
Date: Thu, 15 Feb 2024 16:17:10 -0800
Message-ID: <20240216001711.2492906-1-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.44.0.rc0.258.g7320e95886-goog
MIME-Version: 1.0
X-Headers-End: 1ralut-0003Ib-77
Subject: [f2fs-dev] [PATCH] f2fs_io: override setxattr value for
 system.advise
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
Cc: Jaegeuk Kim <jaegeuk@kernel.org>, Konstantin Vyshetsky <vkon@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

From: Konstantin Vyshetsky <vkon@google.com>

Adjust behavior to match kernel.

Signed-off-by: Konstantin Vyshetsky <vkon@google.com>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 tools/f2fs_io/f2fs_io.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/tools/f2fs_io/f2fs_io.c b/tools/f2fs_io/f2fs_io.c
index a5e151d06b10..1df9034acdd9 100644
--- a/tools/f2fs_io/f2fs_io.c
+++ b/tools/f2fs_io/f2fs_io.c
@@ -1588,10 +1588,13 @@ static void do_listxattr(int argc, char **argv, const struct cmd_desc *cmd)
 
 #define setxattr_desc "setxattr"
 #define setxattr_help "f2fs_io setxattr [name] [value] [file_path]\n\n"
+#define F2FS_SYSTEM_ADVISE_NAME	"system.advise"
 
 static void do_setxattr(int argc, char **argv, const struct cmd_desc *cmd)
 {
 	int ret;
+	char *value;
+	unsigned char tmp;
 
 	if (argc != 4) {
 		fputs("Excess arguments\n\n", stderr);
@@ -1599,11 +1602,18 @@ static void do_setxattr(int argc, char **argv, const struct cmd_desc *cmd)
 		exit(1);
 	}
 
-	ret = setxattr(argv[3], argv[1], argv[2], strlen(argv[2]), XATTR_CREATE);
+	if (!strcmp(argv[1], F2FS_SYSTEM_ADVISE_NAME)) {
+		tmp = strtoul(argv[2], NULL, 0);
+		value = (char *)&tmp;
+	} else {
+		value = argv[2];
+	}
+
+	ret = setxattr(argv[3], argv[1], value, strlen(argv[2]), XATTR_CREATE);
 	printf("setxattr %s CREATE: name: %s, value: %s: ret=%d\n",
 			argv[3], argv[1], argv[2], ret);
 	if (ret < 0 && errno == EEXIST) {
-		ret = setxattr(argv[3], argv[1], argv[2], strlen(argv[2]), XATTR_REPLACE);
+		ret = setxattr(argv[3], argv[1], value, strlen(argv[2]), XATTR_REPLACE);
 		printf("setxattr %s REPLACE: name: %s, value: %s: ret=%d\n",
 				argv[3], argv[1], argv[2], ret);
 	}
-- 
2.44.0.rc0.258.g7320e95886-goog



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
