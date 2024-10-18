Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF99DD3C54C
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 18 Oct 2024 07:04:49 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1t1h2X-0001Ro-Az;
	Fri, 18 Oct 2024 07:04:48 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1t1h2V-0001Rc-8M
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 18 Oct 2024 07:04:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=YcMhjV6c5AwqwWve68zR2Lw3tR+bbC955hiCDfj6eBk=; b=NsrqdGPxGVdSnBEgcrFBL1jYfL
 NpFxWxg9GGaBdhFZfWHoBrkiDGjrRgeb1xahg7zdUTrTRY9IW4vTHPPGaXT44wYQoxCNWflhUs8op
 GMeLHG0rtoA043o1a3EirpV0xNnRk9nL7tnQHAnOGOIAFkjGMISeb3NOxiYqUVcVErhE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=YcMhjV6c5AwqwWve68zR2Lw3tR+bbC955hiCDfj6eBk=; b=V
 Mn/0pBgDGQHavjE3of866xKKETHvDtP6yAqGexJMQeZ8BJMMUHvcphnNwudJArJXruTW7sb7tiG/a
 n4o5G2MffckQ81vUbVhDLre3Q7SgPKRkt/G2iqsv4ZAuS+wUi92ABMb6sWdPZo5+cBhk0tjlSv5el
 AKPQb8Iy4PcoFRlA=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1t1h2T-00082K-W6 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 18 Oct 2024 07:04:46 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 2F96E5C5F38
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri, 18 Oct 2024 07:04:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44A13C4CEC3;
 Fri, 18 Oct 2024 07:04:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1729235075;
 bh=DhgpFYiaS3Co1uLXW1DXg95KgxLYHBtH2LoHRnI1nIY=;
 h=From:To:Cc:Subject:Date:From;
 b=DBMAXhxQ9jP99DaJjYIj5bYmAx/EwUMIDbBqprcBhHLX7nhsWB6lOKT+VRIJoOYMF
 FUO4+2IYBv23BiPsQbHiQKoPUVZtxTOlKH+iWnmXjlJQYe+pmFaE393dAE78wOUlBc
 21CGkkrAMhandYwOdmfeXAlsFhl+HMwtHU574nBmtruCzMMHjTy8BXbYOmNbgCpGgZ
 WuWiNX0MRsGchp/zMKU2VNCcGvUOJL90lHiO92DM7YGWL5FAD4o7XtvyKpMak1h3TV
 Q4Ltn1OiCiKQmLca5d+1X54qGPnaaD8ThTFxsmkJOr3IG4dSIt7T7sNJxe3PkobuhT
 XiwbGMhL5fdrg==
To: jaegeuk@kernel.org
Date: Fri, 18 Oct 2024 15:04:27 +0800
Message-Id: <20241018070428.2648420-1-chao@kernel.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
X-Headers-End: 1t1h2T-00082K-W6
Subject: [f2fs-dev] [PATCH 1/2] f2fs_io: {set,
 clear}flags: support immutable flag correctly
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

Hand over immutable flag clearing functionality from setflags to
clearflags, since the flag name is immutable rather than noimmutable.

And support setting functionality in subcommand setflags.

Signed-off-by: Chao Yu <chao@kernel.org>
---
 man/f2fs_io.8           | 6 +++---
 tools/f2fs_io/f2fs_io.c | 9 ++++++---
 2 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/man/f2fs_io.8 b/man/f2fs_io.8
index b9c9dc8..e58244c 100644
--- a/man/f2fs_io.8
+++ b/man/f2fs_io.8
@@ -16,11 +16,11 @@ Get the flags associated with the specified file.
 .TP
 \fBsetflags\fR \fI[flag] [file]\fR
 Set an f2fs file on specified file.  The flag can be casefold,
-compression, and nocompression.
+compression, nocompression, and immutable.
 .TP
 \fBclearflags\fR \fI[flag] [file]\fR
-Clear the specified flag on the target file, which can be compression
-and nocompression.
+Clear the specified flag on the target file, which can be compression,
+ nocompression and immutable.
 .TP
 \fBshutdown\fR \fIshutdown filesystem\fR
 Freeze and stop all IOs for the file system mounted on
diff --git a/tools/f2fs_io/f2fs_io.c b/tools/f2fs_io/f2fs_io.c
index a7b593a..00bfc7a 100644
--- a/tools/f2fs_io/f2fs_io.c
+++ b/tools/f2fs_io/f2fs_io.c
@@ -291,7 +291,7 @@ static void do_getflags(int argc, char **argv, const struct cmd_desc *cmd)
 "  casefold\n"							\
 "  compression\n"						\
 "  nocompression\n"						\
-"  noimmutable\n"
+"  immutable\n"
 
 static void do_setflags(int argc, char **argv, const struct cmd_desc *cmd)
 {
@@ -317,8 +317,8 @@ static void do_setflags(int argc, char **argv, const struct cmd_desc *cmd)
 		flag |= FS_COMPR_FL;
 	else if (!strcmp(argv[1], "nocompression"))
 		flag |= FS_NOCOMP_FL;
-	else if (!strcmp(argv[1], "noimmutable"))
-		flag &= ~FS_IMMUTABLE_FL;
+	else if (!strcmp(argv[1], "immutable"))
+		flag |= FS_IMMUTABLE_FL;
 
 	ret = ioctl(fd, F2FS_IOC_SETFLAGS, &flag);
 	printf("set a flag on %s ret=%d, flags=%s\n", argv[2], ret, argv[1]);
@@ -332,6 +332,7 @@ static void do_setflags(int argc, char **argv, const struct cmd_desc *cmd)
 "flag can be\n"							\
 "  compression\n"						\
 "  nocompression\n"						\
+"  immutable\n"
 
 static void do_clearflags(int argc, char **argv, const struct cmd_desc *cmd)
 {
@@ -355,6 +356,8 @@ static void do_clearflags(int argc, char **argv, const struct cmd_desc *cmd)
 		flag &= ~FS_COMPR_FL;
 	else if (!strcmp(argv[1], "nocompression"))
 		flag &= ~FS_NOCOMP_FL;
+	else if (!strcmp(argv[1], "immutable"))
+		flag &= ~FS_IMMUTABLE_FL;
 
 	ret = ioctl(fd, F2FS_IOC_SETFLAGS, &flag);
 	printf("clear a flag on %s ret=%d, flags=%s\n", argv[2], ret, argv[1]);
-- 
2.40.1



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
