Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A8A8C6FD1F
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 29 Mar 2024 10:26:12 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1rq9R3-00024N-Mi;
	Fri, 29 Mar 2024 10:26:10 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1rq9R2-00024H-3w
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 29 Mar 2024 10:26:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Gm8m3QUXMF+Gr9tQM7n3bQdGcZeYX0XKTz6mAmS1AQY=; b=RI9SdSd0f/KKYwu3Fjzbx+MAho
 q415h21MLK2MVSxwIQOUAQfqFgW/GHuL1s2GWY1coTiI3cbLG3MgIwHaZzpY06ItBzkS2pLFAlpQ+
 tSggC/4MLa1wCNnaP9zq00I7RhEt23AWKWhGaEcY2tkWv80nagSkT/g5OJvm0frYmUIQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=Gm8m3QUXMF+Gr9tQM7n3bQdGcZeYX0XKTz6mAmS1AQY=; b=k
 +9fqIpFz6EcjAMPw3rZswqZL74WRLNfyKIzM4zQf/qlJHV0zvN4yAyp42m4Rrs1r5bHl42KlXQKpn
 jnNKqEdxu4eLkYmV2O0wWeh6X9U9yZOwwLRZPQM7d3KsNHgy9mMX3a7l7cw8YEhEK2HaNusmYzP85
 XnBuwvCVJpnEUmH0=;
Received: from sin.source.kernel.org ([145.40.73.55])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1rq9Qw-0006vq-QR for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 29 Mar 2024 10:26:08 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id 67E87CE2F38
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri, 29 Mar 2024 10:25:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99BF9C433F1;
 Fri, 29 Mar 2024 10:25:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1711707950;
 bh=o3vZQEl8FjTuLdH2P7vzgThwFaQR/1zurRe5qN/v65s=;
 h=From:To:Cc:Subject:Date:From;
 b=e04CWucJsZha3h1bnKk3PyHfYhgfDMCGOb/CHXkWE18hfF3FPBAlkN5IEAMNtzhw+
 Qz37ZWKBtUgUkxFikXi3LdpKf1dBGzasdCpFZ6Hz8ZufX8Ten/bKOiKTOhQSr0Gbl8
 l77iDGlGk9E8QrdkZE6hp3yafoScpQEWraPNPzPblgpLLbmXCQeOj7e2cmtK4S2pVW
 IxnA1uKsmz9/UbyoZAgv2DFvuFMuEDiF8OCsO1R9rQsMnksHEr2WbSNhhW8qFb+9mH
 6WGfRx/9CK8A4jijlw7jirTRRgzs+8BqxIx3GmjX5EgGiLymT+u5YA4PFXuZAMy/3a
 PBPsj5tkiMVqA==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Date: Fri, 29 Mar 2024 18:25:42 +0800
Message-Id: <20240329102542.3577458-1-chao@kernel.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
X-Headers-End: 1rq9Qw-0006vq-QR
Subject: [f2fs-dev] [PATCH] f2fs_io: support unset subcommand for pinfile
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

This patch adds unset subcommand for pinfile command.

Usage: f2fs_io pinfile unset [target_file]

Signed-off-by: Chao Yu <chao@kernel.org>
---
 man/f2fs_io.8           |  2 +-
 tools/f2fs_io/f2fs_io.c | 11 +++++++++--
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/man/f2fs_io.8 b/man/f2fs_io.8
index f097bde..b9c9dc8 100644
--- a/man/f2fs_io.8
+++ b/man/f2fs_io.8
@@ -44,7 +44,7 @@ going down with metadata flush
 going down with fsck mark
 .RE
 .TP
-\fBpinfile\fR \fI[get|set] [file]\fR
+\fBpinfile\fR \fI[get|set|unset] [file]\fR
 Get or set the pinning status on a file.
 .TP
 \fBfadvise\fR \fI[advice] [offset] [length] [file]\fR
diff --git a/tools/f2fs_io/f2fs_io.c b/tools/f2fs_io/f2fs_io.c
index b8e4f02..a7b593a 100644
--- a/tools/f2fs_io/f2fs_io.c
+++ b/tools/f2fs_io/f2fs_io.c
@@ -442,7 +442,7 @@ static void do_fadvise(int argc, char **argv, const struct cmd_desc *cmd)
 
 #define pinfile_desc "pin file control"
 #define pinfile_help						\
-"f2fs_io pinfile [get|set] [file]\n\n"			\
+"f2fs_io pinfile [get|set|unset] [file]\n\n"			\
 "get/set pinning given the file\n"				\
 
 static void do_pinfile(int argc, char **argv, const struct cmd_desc *cmd)
@@ -464,7 +464,14 @@ static void do_pinfile(int argc, char **argv, const struct cmd_desc *cmd)
 		ret = ioctl(fd, F2FS_IOC_SET_PIN_FILE, &pin);
 		if (ret != 0)
 			die_errno("F2FS_IOC_SET_PIN_FILE failed");
-		printf("set_pin_file: %u blocks moved in %s\n", ret, argv[2]);
+		printf("%s pinfile: %u blocks moved in %s\n",
+					argv[1], ret, argv[2]);
+	} else if (!strcmp(argv[1], "unset")) {
+		pin = 0;
+		ret = ioctl(fd, F2FS_IOC_SET_PIN_FILE, &pin);
+		if (ret != 0)
+			die_errno("F2FS_IOC_SET_PIN_FILE failed");
+		printf("%s pinfile in %s\n", argv[1], argv[2]);
 	} else if (!strcmp(argv[1], "get")) {
 		unsigned int flags;
 
-- 
2.40.1



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
