Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7362ACD37AC
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 11 May 2026 12:35:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:Message-Id:Date:To:Sender:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=FsLnM5T6JrQL8kTOZfdymJJ8GqwEdjSm7RJTfqR6Yz4=; b=Opeal7MUjnZ+R8+oRcYCOO8Pzi
	R/YMJI7kPvSCmtLWB0TCVAuAU+62gFEbzqjj2fANADceaAAnSsfdJVBzO78Hax423UG2PlYmOajZG
	FwovsdaSamyLXJ7r3CZiEd6xFGoKEmwXmyUCmvx6v0tO0AF6xormh8Y3pyh0bZ9rJ+G0=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wMPrO-0001Ij-NE;
	Mon, 11 May 2026 12:35:47 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1wMPrN-0001IZ-BR
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 11 May 2026 12:35:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=xYjNZjPF6a17izc+RHjOhh8yUZscwUXPxdYkZ5eulAw=; b=PeNzjKHBrGzQfMb7qhxheVYXxD
 HCvgUlkNQfY1C8PIy831rCTqbiQvUsUIT13mPRe9bmWYvN/SKBTxkZ7Qpr5TkOXX7FQZkG6dh+q8f
 qO732zZAhTOLi+PZl70Wk5CEa8epOBveENlDLYod6hjA8x+d+xHOjMHd07HugDsPIBcw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=xYjNZjPF6a17izc+RHjOhh8yUZscwUXPxdYkZ5eulAw=; b=I
 Puh8jFCsl52UsnjQElaVzAFaINhApJeq6C9hXsQFd6l1/I8+Y8DcWIyBaftM2qWdNUy4/ZrkYvw2K
 LVhWqqoYgPaNHbjF/C4AvxzGTwxioFtFcNL1nBWa+c4EVcFhRbYiy7jaAm1k7UYgbCDXZQPn1oXYW
 +m+v7TMITwfhHgBw=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wMPrL-0000S5-J8 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 11 May 2026 12:35:46 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 0899443719
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 11 May 2026 12:35:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CDE9C2BCB0;
 Mon, 11 May 2026 12:35:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1778502937;
 bh=6QQ8kukKTniNrv8iEXjF2oJj+F2CfiOmyUs5yoiLiuY=;
 h=From:To:Cc:Subject:Date:From;
 b=hcssOW9mtodYvCuhRk1oOi05aTqumSbfc6gtsGJUECBkpNzue2gCCO03Wm+shJ6mh
 nlX3n0Bm6EUcxUfvOgcHXa7RHC/4IWT5e6YgrlcYxYdYoXRZ8qFGueAjx34F8WUa1g
 inWKqPZc+ZJwSNz++/z8wwNLKQ/7X8vntDcK/i8rjmmmy0ONeE+OQ3EQiUtUbbAE60
 +aaz3SQZxXY9B30dOLjIKsJnj640fvbmSPLMuBcCucCt7B+f5kctEJXiUdKgglXoqB
 YtApZZquDYCOAyXrOnPuDDz7ayprUfOlGV8EZCsEMNVRYbmhAlyRWV25v9EjitJuMC
 0vSUtFVOgrrvA==
To: jaegeuk@kernel.org
Date: Mon, 11 May 2026 00:30:33 +0800
Message-Id: <20260510163033.12148-1-chao@kernel.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
X-Headers-End: 1wMPrL-0000S5-J8
Subject: [f2fs-dev] [PATCH] f2fs: add logs in f2fs_disable_checkpoint()
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

In order to troubleshoot in which step we may block on during
mount w/ checkpoint_disable mount option.

Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/super.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index c6afdbd6e1cd..ebd93047ebe9 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -2640,6 +2640,9 @@ static int f2fs_disable_checkpoint(struct f2fs_sb_info *sbi)
 
 	/* check if we need more GC first */
 	unusable = f2fs_get_unusable_blocks(sbi);
+
+	f2fs_info(sbi, "%s starts, unusable: %u", __func__, unusable);
+
 	if (!f2fs_disable_cp_again(sbi, unusable))
 		goto skip_gc;
 
@@ -2647,6 +2650,8 @@ static int f2fs_disable_checkpoint(struct f2fs_sb_info *sbi)
 
 	sbi->gc_mode = GC_URGENT_HIGH;
 
+	f2fs_info(sbi, "%s: run f2fs_gc() to migrate blocks", __func__);
+
 	while (!f2fs_time_over(sbi, DISABLE_TIME)) {
 		struct f2fs_gc_control gc_control = {
 			.victim_segno = NULL_SEGNO,
@@ -2667,6 +2672,12 @@ static int f2fs_disable_checkpoint(struct f2fs_sb_info *sbi)
 			break;
 	}
 
+	f2fs_info(sbi, "%s: call sync_filesystem() to persist meta: %lld, node: %lld, data: %lld",
+			__func__,
+			get_pages(sbi, F2FS_DIRTY_META),
+			get_pages(sbi, F2FS_DIRTY_NODES),
+			get_pages(sbi, F2FS_DIRTY_DATA));
+
 	ret = sync_filesystem(sbi->sb);
 	if (ret || err) {
 		err = ret ? ret : err;
@@ -2680,6 +2691,12 @@ static int f2fs_disable_checkpoint(struct f2fs_sb_info *sbi)
 	}
 
 skip_gc:
+	f2fs_info(sbi, "%s: call f2fs_write_checkpoint(), meta: %lld, node: %lld, data: %lld",
+			__func__,
+			get_pages(sbi, F2FS_DIRTY_META),
+			get_pages(sbi, F2FS_DIRTY_NODES),
+			get_pages(sbi, F2FS_DIRTY_DATA));
+
 	f2fs_down_write_trace(&sbi->gc_lock, &lc);
 	cpc.reason = CP_PAUSE;
 	set_sbi_flag(sbi, SBI_CP_DISABLED);
@@ -2697,7 +2714,7 @@ static int f2fs_disable_checkpoint(struct f2fs_sb_info *sbi)
 restore_flag:
 	sbi->gc_mode = gc_mode;
 	sbi->sb->s_flags = s_flags;	/* Restore SB_RDONLY status */
-	f2fs_info(sbi, "f2fs_disable_checkpoint() finish, err:%d", err);
+	f2fs_info(sbi, "%s finishes, err:%d", __func__, err);
 	return err;
 }
 
-- 
2.40.1



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
