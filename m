Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7F4FC48BF6
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 26 Feb 2024 23:14:44 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1rekBH-0006X2-Kk;
	Mon, 26 Feb 2024 23:14:43 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <jaegeuk@kernel.org>) id 1rekBF-0006Ww-Rj
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 26 Feb 2024 23:14:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:To:From:Date:Sender:Reply-To:Cc:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=aamj8ctSz1OFnKSnlFsCtXZ1B9hJrIyHzwm8GGhvKHg=; b=ORbMDKWrvHY4NmCFkds3VxLSpd
 o2GFqB1Tx4o1B8y5ukj+L9FFlqYnV7ypYMinhzyx/Hmplcq1SyVeYrNkjT2ME89JhR/+lqMgmIyMc
 4xzpa7HY7XHZ1JFHmHNkl1nAeZq/sqmhVLsTPOibA3gpotE33TVBI5GN5EC5byiDAOqQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:To:
 From:Date:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=aamj8ctSz1OFnKSnlFsCtXZ1B9hJrIyHzwm8GGhvKHg=; b=clJVgXi75dMzcgWEPQFg+VGsSX
 pksCE2p7IzcivQArYYT6zMYHe2UPAPz1EvKdvChY4smf86/g/IA2lt7X3uuAC1pdZNiBgcgKfculc
 BXkRAD5orYm1g4UgqyFqdzbcCdFtHevZJ4bHdU9nyzSE9CA5NLmdp2O+uUt6/mrK6kwY=;
Received: from sin.source.kernel.org ([145.40.73.55])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1rekBF-0003CI-1F for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 26 Feb 2024 23:14:41 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id 47848CE0176
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 26 Feb 2024 23:14:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74CFEC433C7;
 Mon, 26 Feb 2024 23:14:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1708989268;
 bh=O2m22R0yZCGVUk6cDrklmfyRKcLTlO8eSyTHoowZsEA=;
 h=Date:From:To:Subject:References:In-Reply-To:From;
 b=FDaQrFRrmymL+JYoAdRI13bV7T8F3WAJ2guVlW5g1VaWiWm34V7JVBM2RkJIUoRlb
 D2DqI89d/OcyH04NS0dbUQsfQ/Yu8e5e0gi5SmVH48vQNItQtDQ4UDprXuW7oiMr9R
 WdG6HCdA7CgIdOy8GMkEB0an5bBFAX+AIJij5pjmwCgenVeLmaSZ4x87686VCLvyzB
 30xoADnGNJZKRdQXQrWn5Zg2tknISMO2IqhcvZS2iNO8HrAoZ4CSRtycFKwV8pp/tu
 emD7F5qixKWTCBp2U3W8uE2F+WXn4B5m+Yyp52DS8L/LwbinKgIVAxHbLpxhuqHvfo
 fTzv21yohbATg==
Date: Mon, 26 Feb 2024 15:14:26 -0800
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Message-ID: <Zd0bUnFCWmPtwK2u@google.com>
References: <20240223205535.307307-1-jaegeuk@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240223205535.307307-1-jaegeuk@kernel.org>
X-Headers-End: 1rekBF-0003CI-1F
Subject: Re: [f2fs-dev] [PATCH 1/5 v2] f2fs: check number of blocks in a
 current section
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

In cfd66bb715fd ("f2fs: fix deadloop in foreground GC"), we needed to check
the number of blocks in a section instead of the segment.

Fixes: cfd66bb715fd ("f2fs: fix deadloop in foreground GC")
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---

 from v1:
  - check current node block space to deal with the worst case
  - TODO: need to fine tuning on node temperature

 fs/f2fs/segment.h | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h
index 3edd3809b6b5..335fc6285fa5 100644
--- a/fs/f2fs/segment.h
+++ b/fs/f2fs/segment.h
@@ -561,23 +561,22 @@ static inline bool has_curseg_enough_space(struct f2fs_sb_info *sbi,
 			unsigned int node_blocks, unsigned int dent_blocks)
 {
 
-	unsigned int segno, left_blocks;
+	unsigned segno, left_blocks;
 	int i;
 
-	/* check current node segment */
+	/* check current node sections in the worst case. */
 	for (i = CURSEG_HOT_NODE; i <= CURSEG_COLD_NODE; i++) {
 		segno = CURSEG_I(sbi, i)->segno;
-		left_blocks = f2fs_usable_blks_in_seg(sbi, segno) -
-				get_seg_entry(sbi, segno)->ckpt_valid_blocks;
-
+		left_blocks = CAP_BLKS_PER_SEC(sbi) -
+				get_ckpt_valid_blocks(sbi, segno, true);
 		if (node_blocks > left_blocks)
 			return false;
 	}
 
-	/* check current data segment */
+	/* check current data section for dentry blocks. */
 	segno = CURSEG_I(sbi, CURSEG_HOT_DATA)->segno;
-	left_blocks = f2fs_usable_blks_in_seg(sbi, segno) -
-			get_seg_entry(sbi, segno)->ckpt_valid_blocks;
+	left_blocks = CAP_BLKS_PER_SEC(sbi) -
+			get_ckpt_valid_blocks(sbi, segno, true);
 	if (dent_blocks > left_blocks)
 		return false;
 	return true;
@@ -626,7 +625,7 @@ static inline bool has_not_enough_free_secs(struct f2fs_sb_info *sbi,
 
 	if (free_secs > upper_secs)
 		return false;
-	else if (free_secs <= lower_secs)
+	if (free_secs <= lower_secs)
 		return true;
 	return !curseg_space;
 }
-- 
2.44.0.rc1.240.g4c46232300-goog



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
