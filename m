Return-Path: <SRS0=DjvX=EP=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE608C388F7
	for <linux-f2fs-devel@archiver.kernel.org>; Mon,  9 Nov 2020 17:00:38 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A60B20789;
	Mon,  9 Nov 2020 17:00:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="cVShu+sa";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="C+p1dZjM";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="kP5DkISn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A60B20789
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1kcAWz-00059T-NP; Mon, 09 Nov 2020 17:00:37 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <jaegeuk@kernel.org>) id 1kcAWy-00059F-UR
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 09 Nov 2020 17:00:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=7JE4QSsK9QrrB2lOOAUjCi2qEBkw9gZsyDIAx0aolVE=; b=cVShu+sab/J8f/Oen9lzviHifi
 1/i5bK1MGNMT9J3/c6yTD8NICdOD/i4sIGJPW3LJfg6JcEFve2qnFNNcw4mpE13G8oo5JrRyN9urz
 C3ZXFEZ5jm3t0wSknPvxVsq56b6L3cV0IPo3u6d1BWeAeDmf8LktUeRV9hCG2Z4//GwA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=7JE4QSsK9QrrB2lOOAUjCi2qEBkw9gZsyDIAx0aolVE=; b=C
 +p1dZjM6PhQzUzRVWZVJXg66urFTcCFgsTqZrVuEEAnygRxQM2fyVouwKENBEXpEUPwIgpzX4hLRW
 2e4ahM1GhIqsqYF1BqdnTlLGhZ+EpIUBx9KCr5CQ6cvlSToohE1yC5v02/pTy1snCO2yggDiuDPe3
 YJR14Y7hrwizSagQ=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1kcAWi-005pee-0O
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 09 Nov 2020 17:00:36 +0000
Received: from localhost (unknown [104.132.1.66])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 692ED20789;
 Mon,  9 Nov 2020 17:00:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1604941214;
 bh=e1fR8c3/u8ILpeETIXysn5Lg1umCymg7KmWhq+/rSak=;
 h=From:To:Cc:Subject:Date:From;
 b=kP5DkISnxV6x/qbDaYiMpCPbZTtX1cYBuTloAuAHYN0cKWH+492W5UCRq8ENlkNr3
 49ktkkiX8+QvRgbRi8zIBpxEJ+NAfzdFZA9BgT6zpzeVwRyyKk7vFi+8Wq7jzk3N22
 iHN7yeslNZv0kO/6KHWWyFgtWbChLvIEe7te+jdo=
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 kernel-team@android.com
Date: Mon,  9 Nov 2020 09:00:12 -0800
Message-Id: <20201109170012.2129411-1-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8-goog
MIME-Version: 1.0
X-Headers-End: 1kcAWi-005pee-0O
Subject: [f2fs-dev] [PATCH] f2fs: avoid race condition for shinker count
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
Cc: Jaegeuk Kim <jaegeuk@kernel.org>, Light Hsieh <Light.Hsieh@mediatek.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Light reported sometimes shinker gets nat_cnt < dirty_nat_cnt resulting in
wrong do_shinker work. Basically the two counts should not happen like that.

So, I suspect this race condtion where:
- f2fs_try_to_free_nats            __flush_nat_entry_set
 nat_cnt=2, dirty_nat_cnt=2
                                   __clear_nat_cache_dirty
                                    spin_lock(nat_list_lock)
                                    list_move()
                                    spin_unlock(nat_list_lock)
 spin_lock(nat_list_lock)
 list_del()
 spin_unlock(nat_list_lock)
 nat_cnt=1, dirty_nat_cnt=2
                                   nat_cnt=1, dirty_nat_cnt=1

Reported-by: Light Hsieh <Light.Hsieh@mediatek.com>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/node.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 42394de6c7eb..e8ec65e40f06 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -269,11 +269,10 @@ static void __clear_nat_cache_dirty(struct f2fs_nm_info *nm_i,
 {
 	spin_lock(&nm_i->nat_list_lock);
 	list_move_tail(&ne->list, &nm_i->nat_entries);
-	spin_unlock(&nm_i->nat_list_lock);
-
 	set_nat_flag(ne, IS_DIRTY, false);
 	set->entry_cnt--;
 	nm_i->dirty_nat_cnt--;
+	spin_unlock(&nm_i->nat_list_lock);
 }
 
 static unsigned int __gang_lookup_nat_set(struct f2fs_nm_info *nm_i,
-- 
2.29.2.222.g5d2a92d10f8-goog



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
