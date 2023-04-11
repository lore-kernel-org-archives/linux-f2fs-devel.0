Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3F92C77B6F
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 11 Apr 2023 17:12:38 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1pmHXp-0003Fv-3m;
	Tue, 11 Apr 2023 17:12:38 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <jaegeuk@kernel.org>) id 1pmHXn-0003Fo-R0
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 11 Apr 2023 17:12:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=nS9ljUJSj5r19Y3dzxMEPyqGRW8BEEgvogt6KQK9FO4=; b=EQhn/+/KpdplPrU324SeXWjcva
 JICGYjnBo0pD9RWtaU6lZcyvMg2AP6IuQnXRuQGlHIbrltJSmiVXol8uLOOPj0LpmkhRHwLiytU1W
 nNnFrfzzYE1FY37FgnBycLtzLe3bGQ/w/1vZZ2agsRvYS40xVCqLDkbZ713LN2dlZUV0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=nS9ljUJSj5r19Y3dzxMEPyqGRW8BEEgvogt6KQK9FO4=; b=f
 MOrjCFQqAMk00ksrN+gmguVF3gtincHDDmPgh5mwdxPOwPv9vQutkCM6DyQ+7e+jBgHrPIWsxWVBX
 oKKwXw8QfkBmhAeeTAPdsjPse1hSngQwwfJ8l5jtIPSSaWjFF3hQbCydzZpcMclCiFuL27AlFx78b
 Sg4EbtvPygcCy0nY=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1pmHXj-0005h6-Ky for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 11 Apr 2023 17:12:33 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 4410060EFB
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 11 Apr 2023 17:12:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96CDCC433EF;
 Tue, 11 Apr 2023 17:12:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1681233145;
 bh=BHhHhMafY+ChDhXXfKIHSFSketrlxHsAFGse7Dsjxfw=;
 h=From:To:Cc:Subject:Date:From;
 b=bNK47Zj5TN49dRr3l/+hIfYopD5JlSEdm8TwksDJIS6V8RdKD7Q3/pRH/eLJ0ZAs9
 FC7xzwzMpdoHsFcEOHObwXDagKGVPr0i7mBGwOWuFVgAAFAzSdNLt8pI2u8Xvv+mI1
 nN8v/q8kqbgvwr0vpO2FLEMqpu9ipIlQqMYElLk4Im0yVhRgmVaDw5y7Bsa2GCFYac
 MnBLJyzvpYnms3J9q2To91+GR2HxcWwTXzzAXLS6gKZ/q9CThPyE0wf8lw8wmKBn8D
 QtHCOSXZ1lGCKebETa+AriG2hKCJm3x7QRtEeMY3UbRhKP8zvZfpYSUIJMifkx9KsA
 PidOt3Ne92Q9A==
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: linux-f2fs-devel@lists.sourceforge.net
Date: Tue, 11 Apr 2023 10:12:24 -0700
Message-Id: <20230411171224.838455-1-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.40.0.577.gac1e443424-goog
MIME-Version: 1.0
X-Headers-End: 1pmHXj-0005h6-Ky
Subject: [f2fs-dev] [PATCH] f2fs-tools: upgrade version 1.16.0
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

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 VERSION      | 4 ++--
 configure.ac | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/VERSION b/VERSION
index bb79667e50a8..bae2e2c9e202 100644
--- a/VERSION
+++ b/VERSION
@@ -1,2 +1,2 @@
-1.15.0
-2022-05-13
+1.16.0
+2023-04-11
diff --git a/configure.ac b/configure.ac
index 818ff37d2a41..efab8d8412b6 100644
--- a/configure.ac
+++ b/configure.ac
@@ -274,12 +274,12 @@ AC_CHECK_MEMBER([struct blk_zone.capacity],
 		]])
 
 # export library version info for mkfs/libf2fs_format_la
-AC_SUBST(FMT_CURRENT, 8)
+AC_SUBST(FMT_CURRENT, 9)
 AC_SUBST(FMT_REVISION, 0)
 AC_SUBST(FMT_AGE, 0)
 
 # export library version info for lib/libf2fs_la
-AC_SUBST(LIBF2FS_CURRENT, 9)
+AC_SUBST(LIBF2FS_CURRENT, 10)
 AC_SUBST(LIBF2FS_REVISION, 0)
 AC_SUBST(LIBF2FS_AGE, 0)
 
-- 
2.40.0.577.gac1e443424-goog



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
