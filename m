Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCD86C282C6
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 28 Feb 2025 19:09:25 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1to5jg-0002Cr-Ti;
	Fri, 28 Feb 2025 19:09:25 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <jaegeuk@kernel.org>) id 1to5jd-0002Cj-Ej
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 28 Feb 2025 19:09:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=/PV55AuDjJ7aLitYs7A41Vp5Z2gf/V85SSKBlRI4+Ws=; b=jctUcQ1ttvnhW1iGYCpA7bcMvT
 0nxBqyeFA75qP5AZFe+2O6mCI63HOm0noR2bqNPY5LzWSyF89hMWZTNb7h63gu85vu1QkWZVLF7Qw
 igy3f2zKmbKULY0ryR5U2jzLrb8a24LcQhgSQHLN/E8kR5TFGXFwnkM0Z50dtLJLhQnQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=/PV55AuDjJ7aLitYs7A41Vp5Z2gf/V85SSKBlRI4+Ws=; b=F
 eWpqgxND0kC2zMKbww5WhzzFmsVdZL2qs1bYmUl11eJC/hgZAckrg81diQBNg+guAztD2N0h5jRUo
 24KIO8jGon4XyHpKt05ND7OgMN2alyrSMbx6oy2zKm/watEYT1DJrZqWkU3MEELZUdUw7umZq9Nvl
 GsLYEGCZvIOScoQQ=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1to5jT-0000ZY-9U for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 28 Feb 2025 19:09:21 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 086326116A
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri, 28 Feb 2025 19:08:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36FE3C4CED6;
 Fri, 28 Feb 2025 19:09:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1740769740;
 bh=1lUwhCUY4nLHnSKMSlYvh4CkH3xii91IdeHXolzqTFU=;
 h=From:To:Cc:Subject:Date:From;
 b=LZwB/ZNFHFf2jXqnSwtXIByQ8c98aMhVtfc0rKUJeqiTax26Ivjjmhy9x31NuESoP
 c+XLO7IVAW+w7pvxxWSYA/k/+KR3TCbskunwxB/57sQLaA4SEwRNegLeN+C3lIVj7o
 K34ifzyhxAaYQVJJvgFUadmR4wlBed+ZJLqBiuFiyLR30aEFYixy2VwscIswqHSMj6
 7F/TpZFWHa7lab2TzFycJkS5zWEIVOw+lcF1T5nC/3Kuch5DZo2rz1J9tV9PZL5JkX
 Vd+OFXA0gvgcGFPsz8p09lBv6u6VtVFtKzWCCDozTb1Pn8q+3i0+bqLrI3LQZOFRbY
 mP5GIP87D2LyQ==
To: linux-f2fs-devel@lists.sourceforge.net
Date: Fri, 28 Feb 2025 19:08:53 +0000
Message-ID: <20250228190854.422890-1-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.48.1.711.g2feabab25a-goog
MIME-Version: 1.0
X-Headers-End: 1to5jT-0000ZY-9U
Subject: [f2fs-dev] [PATCH 1/2] f2fs_io: support fadvise dontneed, random,
 and noreuse
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
From: Jaegeuk Kim via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: Jaegeuk Kim <jaegeuk@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 man/f2fs_io.8           | 3 ++-
 tools/f2fs_io/f2fs_io.c | 9 +++++++++
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/man/f2fs_io.8 b/man/f2fs_io.8
index 97a893b26114..5def508e494f 100644
--- a/man/f2fs_io.8
+++ b/man/f2fs_io.8
@@ -54,7 +54,8 @@ going down with fsck mark
 Get or set the pinning status on a file.
 .TP
 \fBfadvise\fR \fI[advice] [offset] [length] [file]\fR
-Pass an advice to the specified file. The advice can be willneed and sequential.
+Pass an advice to the specified file. The advice can be willneed, dontneed,
+noreuse, sequential, random.
 .TP
 \fBfallocate\fR \fI[-c] [-i] [-p] [-z] [keep_size] [offset] [length] [file]\fR
 Request that space be allocated on a file.  The
diff --git a/tools/f2fs_io/f2fs_io.c b/tools/f2fs_io/f2fs_io.c
index 92345d2dd2d2..05126c8b44a6 100644
--- a/tools/f2fs_io/f2fs_io.c
+++ b/tools/f2fs_io/f2fs_io.c
@@ -454,7 +454,10 @@ static void do_shutdown(int argc, char **argv, const struct cmd_desc *cmd)
 "fadvice given the file\n"					\
 "advice can be\n"						\
 " willneed\n"							\
+" dontneed\n"							\
+" noreuse\n"							\
 " sequential\n"							\
+" random\n"							\
 
 static void do_fadvise(int argc, char **argv, const struct cmd_desc *cmd)
 {
@@ -471,8 +474,14 @@ static void do_fadvise(int argc, char **argv, const struct cmd_desc *cmd)
 
 	if (!strcmp(argv[1], "willneed")) {
 		advice = POSIX_FADV_WILLNEED;
+	} else if (!strcmp(argv[1], "dontneed")) {
+		advice = POSIX_FADV_DONTNEED;
+	} else if (!strcmp(argv[1], "noreuse")) {
+		advice = POSIX_FADV_NOREUSE;
 	} else if (!strcmp(argv[1], "sequential")) {
 		advice = POSIX_FADV_SEQUENTIAL;
+	} else if (!strcmp(argv[1], "random")) {
+		advice = POSIX_FADV_RANDOM;
 	} else {
 		fputs("Wrong advice\n\n", stderr);
 		fputs(cmd->cmd_help, stderr);
-- 
2.48.1.711.g2feabab25a-goog



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
