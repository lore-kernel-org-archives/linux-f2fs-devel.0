Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6326ED3C551
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 18 Oct 2024 07:04:50 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1t1h2Y-0007XA-2G;
	Fri, 18 Oct 2024 07:04:50 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1t1h2W-0007X1-Cf
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 18 Oct 2024 07:04:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=wsYp4f8NFlo1nRWWWWtfLC+hFyq6vEkENwr67vUEf9c=; b=k4TBlxNeDpR+ThWHY4C5QOSPU4
 KZSGxY1unjKTtubccnMbC/RoN7/DFtjmbGP+Pex4+UhBzZG0gGeFnV9Ltl7vn0XLVs7MVRQ3JUYz5
 zRiVWvFmthyl0TwQLTU//qn/qT1xBLZy+e/D8n4Rmq7P2TEkkuKF4ionZ3odgG9qS8vs=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=wsYp4f8NFlo1nRWWWWtfLC+hFyq6vEkENwr67vUEf9c=; b=Yj+2A7As/Xla7oSabN7jkhdCqv
 7XEskZxvhxD25u6A2XaKSp0z2wKRkxc1NPbeEMWMMX5fRseBgZQuTg2oAAwfrz+8eINZqEMPcCGQC
 Jdz54m06pA/0bBPKcYTV+XefIsiYB5HWBGIya1Gd5/ezixtk26ehxqdsH+21v0NRymQ8=;
Received: from nyc.source.kernel.org ([147.75.193.91])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1t1h2V-00082O-LS for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 18 Oct 2024 07:04:48 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id EC06BA44767
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri, 18 Oct 2024 07:04:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B274FC4CED0;
 Fri, 18 Oct 2024 07:04:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1729235076;
 bh=0QWLlCzThp3+I7JOHpwc9maqU0x61MpZZ3VAwp+3+So=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=bBmiILz3NBRrvSa5hWckTh+4u7fEJbRfZk+4fbsjF4jr4pO5rAISSinXRPZA88bdd
 m82kl1+DoChYLe9nwl+Slx8BZKZvIeQ3xeUL26yiQ7pHnhqb8TCagFpyHX/AP7IC90
 rFLigdFSZn1B1Xc+DPiv46UcnAh9mpa/rLRMCoRvUKBMNRq7KipxJoD4X6FaHqpcdD
 rBIWH99krmstbYSnVwmaYvFU4BMvtjXmWDAwTFaYP4xmsfGBTJ+2aABO9ysHUoyWAC
 vjTgn09ugVzU2KDA9ejDXr1x+V28shCSzPwiZaZoavqlK+BUTGBX772pdNjmWDLnZ0
 4pKNrI2UXZrCw==
To: jaegeuk@kernel.org
Date: Fri, 18 Oct 2024 15:04:28 +0800
Message-Id: <20241018070428.2648420-2-chao@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20241018070428.2648420-1-chao@kernel.org>
References: <20241018070428.2648420-1-chao@kernel.org>
MIME-Version: 1.0
X-Headers-End: 1t1h2V-00082O-LS
Subject: [f2fs-dev] [PATCH 2/2] f2fs_io: {set,
 clear}flags: support nocow flag
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
From: Chao Yu via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Chao Yu <chao@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

This patch supports to set or clear nocow flag in f2fs_io

Signed-off-by: Chao Yu <chao@kernel.org>
---
 man/f2fs_io.8           |  4 ++--
 tools/f2fs_io/f2fs_io.c | 10 ++++++++--
 2 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/man/f2fs_io.8 b/man/f2fs_io.8
index e58244c..5041c1b 100644
--- a/man/f2fs_io.8
+++ b/man/f2fs_io.8
@@ -16,11 +16,11 @@ Get the flags associated with the specified file.
 .TP
 \fBsetflags\fR \fI[flag] [file]\fR
 Set an f2fs file on specified file.  The flag can be casefold,
-compression, nocompression, and immutable.
+compression, nocompression, immutable, and nocow.
 .TP
 \fBclearflags\fR \fI[flag] [file]\fR
 Clear the specified flag on the target file, which can be compression,
- nocompression and immutable.
+ nocompression, immutable, and nocow.
 .TP
 \fBshutdown\fR \fIshutdown filesystem\fR
 Freeze and stop all IOs for the file system mounted on
diff --git a/tools/f2fs_io/f2fs_io.c b/tools/f2fs_io/f2fs_io.c
index 00bfc7a..76f8e84 100644
--- a/tools/f2fs_io/f2fs_io.c
+++ b/tools/f2fs_io/f2fs_io.c
@@ -291,7 +291,8 @@ static void do_getflags(int argc, char **argv, const struct cmd_desc *cmd)
 "  casefold\n"							\
 "  compression\n"						\
 "  nocompression\n"						\
-"  immutable\n"
+"  immutable\n"							\
+"  nocow\n"
 
 static void do_setflags(int argc, char **argv, const struct cmd_desc *cmd)
 {
@@ -319,6 +320,8 @@ static void do_setflags(int argc, char **argv, const struct cmd_desc *cmd)
 		flag |= FS_NOCOMP_FL;
 	else if (!strcmp(argv[1], "immutable"))
 		flag |= FS_IMMUTABLE_FL;
+	else if (!strcmp(argv[1], "nocow"))
+		flag |= FS_NOCOW_FL;
 
 	ret = ioctl(fd, F2FS_IOC_SETFLAGS, &flag);
 	printf("set a flag on %s ret=%d, flags=%s\n", argv[2], ret, argv[1]);
@@ -332,7 +335,8 @@ static void do_setflags(int argc, char **argv, const struct cmd_desc *cmd)
 "flag can be\n"							\
 "  compression\n"						\
 "  nocompression\n"						\
-"  immutable\n"
+"  immutable\n"							\
+"  nocow\n"
 
 static void do_clearflags(int argc, char **argv, const struct cmd_desc *cmd)
 {
@@ -358,6 +362,8 @@ static void do_clearflags(int argc, char **argv, const struct cmd_desc *cmd)
 		flag &= ~FS_NOCOMP_FL;
 	else if (!strcmp(argv[1], "immutable"))
 		flag &= ~FS_IMMUTABLE_FL;
+	else if (!strcmp(argv[1], "nocow"))
+		flag &= ~FS_NOCOW_FL;
 
 	ret = ioctl(fd, F2FS_IOC_SETFLAGS, &flag);
 	printf("clear a flag on %s ret=%d, flags=%s\n", argv[2], ret, argv[1]);
-- 
2.40.1



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
