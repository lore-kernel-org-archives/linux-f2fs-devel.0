Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1277C83F1D
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 15 Jul 2025 03:42:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:Message-ID:Date:To:Sender:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=r7V4HeR0FJ4ZJQjzWQdyhH+hWsoVo14dU/HY6nPlbdM=; b=mqDASLR3vlJSNe/+VJHWsW7a/f
	Sksr6vi36Nu/xlybAEE7oMm+K1tFAHYNtmu06FDgfnVA0F+vGLbxKcbP9reIZBW+DwLRkp5tJb40I
	gZfvsfB6Cvd6vBUcUIHCFZScPHWEm8rYRB6xSFL4f2fUIU9YcuCnmHZ/hit5EKubbAno=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1ubWZC-0007Bp-Cu;
	Tue, 15 Jul 2025 03:42:54 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1ubWZB-0007Bi-GR
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 15 Jul 2025 03:42:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=zWI9IB4JLNT01vw1itNPHUZHLczJlBN0DMwhuKZYnEc=; b=SH6H3rSgogp0OAQhKt9UcO2DV2
 gq0hmrCWVfmEgOyIMBpJk+e9BJtM6w9Bs8/5nXCnI/mZtxtcpYQyTHvrHbq88Q3AwXhnJ4HkMMXtt
 o7UPg5j8+Gmcd7m9f7FiUSefT/YncXzLc1KNfvCxpu9c2/nhxssu04+aD3UXmYPpY8q4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=zWI9IB4JLNT01vw1itNPHUZHLczJlBN0DMwhuKZYnEc=; b=H
 KY79yU1Izb5Ji3hHe5X9LjeNDXnFSYgZj/lYoTZbfDE3u1D2mF5M3JvAa/wCHzE31K0MA2CLq+rP9
 Ssj4ik8YwamwgYLhVXCe+56xZJbWK5lW3kzNJEuoShTug+aQ7uUMYRGdhtM/ugll7qSSkU1quPFAD
 JqXQd0snfhlDtfls=;
Received: from nyc.source.kernel.org ([147.75.193.91])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1ubWZ9-0002By-Uk for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 15 Jul 2025 03:42:53 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id 86687A531DD
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 15 Jul 2025 02:26:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C93FC4CEED;
 Tue, 15 Jul 2025 02:26:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1752546394;
 bh=LDF8ELnAISm2MY+yWCwH0B1RSYhTFfoVGF4gO7BZFuQ=;
 h=From:To:Cc:Subject:Date:From;
 b=WPir47qkdxmJERwcpkN40L8CweIOxH4yrHvniCI93JWbM288BdEhCoRNoLUtz/vZ0
 G/keyEKUZhwNdG1ElP40v0AF/siFjB1xlst1Mgq8bSbeM9KwSFhvdgcdB/7BWy0aw4
 o2dzo2ZcBDdjTqnfFMyH/URtAKR9eILSesr0DaCRTSk7OTGD2GF7dr4qjV+OB9uPq6
 SFWayFp/XYLOQSNLy0hfVS2G3WlYLFoXEdOzgwOWXxzndccn5UpXEr+akwX6hf98wO
 nYvqL8IvSfb5fFlrf8MSNGh+Of9qQQXUYPE+kYpWEnJx/eS3C6p5oZA+clekgcp1Du
 jEW+9ahY8oHIw==
To: jaegeuk@kernel.org
Date: Tue, 15 Jul 2025 10:26:29 +0800
Message-ID: <20250715022629.486521-1-chao@kernel.org>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
MIME-Version: 1.0
X-Headers-End: 1ubWZ9-0002By-Uk
Subject: [f2fs-dev] [PATCH] f2fs_io: fix doc of test_lookup_perf
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
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Change as below:
- add an entry for test_lookup_perf in manual
- fix wrong parameter in usage of test_lookup_perf

Signed-off-by: Chao Yu <chao@kernel.org>
---
 man/f2fs_io.8           | 3 +++
 tools/f2fs_io/f2fs_io.c | 2 +-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/man/f2fs_io.8 b/man/f2fs_io.8
index e0f659e..0d69b5f 100644
--- a/man/f2fs_io.8
+++ b/man/f2fs_io.8
@@ -184,6 +184,9 @@ Get i_advise value and info in file
 .TP
 \fBioprio\fR \fI[hint] [file]\fR
 Set ioprio to the file. The ioprio can be ioprio_write.
+.TP
+\fBtest_lookup_perf\fR \fI[-i] [-v] <dir> <num_files>\fR
+Measure readdir/stat speed
 .SH AUTHOR
 This version of
 .B f2fs_io
diff --git a/tools/f2fs_io/f2fs_io.c b/tools/f2fs_io/f2fs_io.c
index 8e81ba9..f282190 100644
--- a/tools/f2fs_io/f2fs_io.c
+++ b/tools/f2fs_io/f2fs_io.c
@@ -2241,7 +2241,7 @@ static void do_test_create_perf(int argc, char **argv, const struct cmd_desc *cm
 
 #define test_lookup_perf_desc "measure readdir/stat speed"
 #define test_lookup_perf_help						\
-"f2fs_io test_lookup_perf [-s] [-S] <dir> <num_files>\n\n"		\
+"f2fs_io test_lookup_perf [-i] [-v] <dir> <num_files>\n\n"		\
 "Measures readdir/stat performance.\n"				\
 "  <dir>          The target directory in where it will test on.\n"	\
 "  <num_files>    The total number of files the test will initialize or test.\n"\
-- 
2.49.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
