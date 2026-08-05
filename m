Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11BB0C56203
	for <linux-f2fs-devel@archiver.kernel.org>; Wed,  5 Aug 2026 12:21:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:Message-ID:Date:To:Sender:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=t7lRBg2mcjKjPDmKPdatAbbXji8+dl9xGlH/3yZYVlg=; b=bM5pbCpEG7xY3ku5nm3wENDmeB
	IdBAktYHV29Q9u2yqjQZOElhgGwPssSyJIgKsXSfmsK2D7E2U5TjL3TGtuAINE0xUOXyEHnNm0WvI
	zZUl8xup8UnnUcjn+UiqHwe61QhUCwE1w54shkqL+OYZ8BNPt/oF/RXHTlIfPf+aYJls=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wracG-0007Fz-TX;
	Wed, 05 Aug 2026 12:21:01 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1wracG-0007Fs-6I
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 05 Aug 2026 12:21:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=WNxh06U8c10UoW/QQJLEF2gawLBuvh3FT0mFlT+rOco=; b=UzBcJQfElNPRxFU8VA/2MUZlkO
 ajrMzBhSJyGPykV6C14LhAnOqt/q0gpZWCmhfGO9oOoVBZHcFeAOe4cQQEo92Z9b9IsAVMG+7lSAQ
 xJ8LSmDyis+OMPHEXiJEclif7Ks+Lv36AiYh2mJPPTZPitzWK3JB5S6d4OAlUEo82MCM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=WNxh06U8c10UoW/QQJLEF2gawLBuvh3FT0mFlT+rOco=; b=a
 ZaGPrEarz+mAOGEl1jk1Gy4bQv2ZsUQDkT/cixcyd/1GsID2EZJ4yXQV5pB1d7qfsIAxEVmqnhp/1
 6dxwELU4S8tC1ClJd2ooZ+kKVLBtwHrmfy07yKn58+zRZ2SU8ib1kaKKVVjaABzXfRUTrFWn45MU3
 s1hxaK0dD09hE1vE=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wracF-0000OW-3s for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 05 Aug 2026 12:21:00 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id B7BB0407EE
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed,  5 Aug 2026 12:20:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCD521F00A3F;
 Wed,  5 Aug 2026 12:20:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785932453;
 bh=WNxh06U8c10UoW/QQJLEF2gawLBuvh3FT0mFlT+rOco=;
 h=From:To:Cc:Subject:Date;
 b=gZoKY76/4inKUQi+f/1m/MQ9N9fphbn5hPiveoQo067GMkff+vCrMfJDeY5zhN+up
 DyzgwLjTBBVNozMg2SLLVNjgLRIkmYFWp46A6Jzzlujz3vbxEr5Alys/FrcfrUgb8j
 mxGSXb/ppk71635pfyJ7iFJSmBAUffY8QGRJN6FnW71aWN5CytAASogrYILTHPBEkE
 Km6rzZKm6xV2Mx+AczRnHUudeWPUkFFBkuQZ1vVJ30kOI3aoM0MxqyO06Nx8ybET00
 A7LknB2K6XsfmCUhxyHEsTMuOfzD88RiDdG2OiBFShuiZQnsmFu/urtZfsel/v/9BT
 nHY8ppLu1ng8Q==
To: jaegeuk@kernel.org
Date: Wed,  5 Aug 2026 12:20:50 +0000
Message-ID: <20260805122050.665256-1-chao@kernel.org>
X-Mailer: git-send-email 2.55.0.654.g21b8a5bc05-goog
MIME-Version: 1.0
X-Headers-End: 1wracF-0000OW-3s
Subject: [f2fs-dev] [PATCH] f2fs: avoid unnecessary shrink in
 f2fs_shrink_scan()
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

In f2fs_shrink_scan(), let's check if we have already shrinked enough
number of memory before calling f2fs_shrink_read_extent_tree().

Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/shrinker.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/shrinker.c b/fs/f2fs/shrinker.c
index b88babcf6ab4..4f6bf5926de4 100644
--- a/fs/f2fs/shrinker.c
+++ b/fs/f2fs/shrinker.c
@@ -109,7 +109,8 @@ unsigned long f2fs_shrink_scan(struct shrinker *shrink,
 		freed += f2fs_shrink_age_extent_tree(sbi, nr >> 2);
 
 		/* shrink read extent cache entries */
-		freed += f2fs_shrink_read_extent_tree(sbi, nr >> 2);
+		if (freed < nr)
+			freed += f2fs_shrink_read_extent_tree(sbi, nr >> 2);
 
 		/* shrink clean nat cache entries */
 		if (freed < nr)
-- 
2.49.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
