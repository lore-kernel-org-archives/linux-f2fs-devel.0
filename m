Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 636B3C433F5
	for <linux-f2fs-devel@archiver.kernel.org>; Wed,  4 May 2022 20:23:13 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.94.2)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1nmLWh-00028b-Pn; Wed, 04 May 2022 20:23:10 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <jaegeuk@kernel.org>) id 1nmLWg-00028V-8f
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 04 May 2022 20:23:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:To:From:Date:Sender:Reply-To:Cc:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=naxLxOVKAPm2Jaro+LEcbo24jZG+euVPOx89u+mrym8=; b=R0R19/zGtF3AsReA3/2F9kCjM5
 HSG9329iZyCjfZOpmf7gPYnqCFL1iEIHdhWX/x9PidXZGzTGCM2jy9XEGG4X3DtmccZd1baM+us2I
 MvZZon3y6QFmylq0SbEUSK3E1xubJoifm6Cmt42IPs4Es+GiIFe3TSxHKhkLD4p+i3BU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:To:
 From:Date:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=naxLxOVKAPm2Jaro+LEcbo24jZG+euVPOx89u+mrym8=; b=GU2eNxa/EuBcCVC0YD+RQ0aL3i
 rB6QlUkCmzQESQXtnIlXQm6cizPurCkTzwzgtp2wQLMVx4TfXMD4LCFBHH+jh6m1nOY+uotif/30u
 wTn/wYZtVT2yJdKpQaYBjjlGLAEk6b5bhZkPuHIVnC5luVCHlxSuOjqBm4S27XiHXZQM=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.94.2)
 id 1nmLWd-0000dh-QM
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 04 May 2022 20:23:08 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id D0B3C61728
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed,  4 May 2022 20:22:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 256CEC385A4;
 Wed,  4 May 2022 20:22:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1651695776;
 bh=Pvp/ayE3bEr1ThzltiOs0liNClPGDqGM57U4y3ZJCs4=;
 h=Date:From:To:Subject:References:In-Reply-To:From;
 b=Jb1H+umWfnfEpWqRV20Q4YhcGwRLYGWiL464vbh1AFJeLggogbh3DgfdhCRMeUThT
 XNv5jkVDb09twhYv4kQ1HPTEvqpD1A9rDMXWas6eF0Jch8V8bWocjrGjgjvTI+7mDE
 k7Y4wuNJ7sFd1PkbhH3cM6NHpPU1kH27+95u07THwk2LSvSKMFS64PEaeWAgBWwbUB
 /5eZqJHkZ1yfcpEKtZl1G8IndjStS3uqXjjaoyGrAFWo2Peiti6Tcqz7VBE9BDTxu8
 bqmYMdQzVyQ4v5wiU/pYIPJu5AEzmRtqdnpmupU4kAkDSIubdwgG8wWaPAPEOM0Vya
 PG1KYfPHXeaQg==
Date: Wed, 4 May 2022 13:22:54 -0700
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Message-ID: <YnLgnhiJtrutv8nw@google.com>
References: <20220503203040.365028-1-jaegeuk@kernel.org>
 <20220503203040.365028-2-jaegeuk@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220503203040.365028-2-jaegeuk@kernel.org>
X-Headers-End: 1nmLWd-0000dh-QM
Subject: Re: [f2fs-dev] [PATCH 2/2 v2] f2fs: avoid to select pinned section
 during checkpoint=disable
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

The f2fs_gc uses a bitmap to indicate pinned sections, but when disabling
chckpoint, we call f2fs_gc() with NULL_SEGNO which selects the same dirty
segment as a victim all the time, resulting in checkpoint=disable failure.
Let's pick another one, if we fail to collect it.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---

 Change log from v1:
  - keep sync condition to stop GC

 fs/f2fs/gc.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index 4d47723523c3..441190ab8593 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -1838,10 +1838,7 @@ int f2fs_gc(struct f2fs_sb_info *sbi, bool sync,
 	if (gc_type == FG_GC)
 		sbi->cur_victim_sec = NULL_SEGNO;
 
-	if (sync)
-		goto stop;
-
-	if (!has_not_enough_free_secs(sbi, sec_freed, 0))
+	if ((!has_not_enough_free_secs(sbi, sec_freed, 0) || sync) && seg_freed)
 		goto stop;
 
 	if (skipped_round <= MAX_SKIP_GC_COUNT || skipped_round * 2 < round) {
-- 
2.36.0.464.gb9c8b46e94-goog



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
