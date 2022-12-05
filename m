Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA7A9C47089
	for <linux-f2fs-devel@archiver.kernel.org>; Mon,  5 Dec 2022 18:55:06 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1p2GcM-00071x-8w;
	Mon, 05 Dec 2022 18:55:06 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <jaegeuk@kernel.org>) id 1p2GcJ-00071l-QO
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 05 Dec 2022 18:55:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=QEohlLP3wSThxITbi61W4S3BNYgw99sAQGnTOMCStts=; b=LxfrgDEr8LmOgF2tWDrb/nOUaf
 x4+BDRJtpRmVoPFxEhNyRwyOMWdFiYC6SEnnLv2M5wtrsB1t2Smq7qusCb3KpLQECqhpxZMu8lBAH
 LUiuXJ2//9QjjeGA74y8rq6gqFRm7HCE0cS+3isMTcEYA70MNtb511DjGQ1AyCMEHlwo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=QEohlLP3wSThxITbi61W4S3BNYgw99sAQGnTOMCStts=; b=hvJ9M6c13+ngclyT9mkzJxv4Kl
 YZUQ2Boy0ObbN+w0IpMv5h/k+gIEQryHm8u8nzJr3RUW5aWRG8CM9Q9KGBVF8eflCW70ZxydgBGDQ
 bW5W9bVv7gbDsbn1BtbQogSnJy3pUud+v5RYisk8/pmEXqKuixb0xbsLXeiRfc9FtvK4=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1p2GcD-00076m-Qt for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 05 Dec 2022 18:55:03 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 0049F612FC
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon,  5 Dec 2022 18:54:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56943C433B5;
 Mon,  5 Dec 2022 18:54:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1670266491;
 bh=fMxo9Pxt/+eOWzK6Fcoy958VZcVnlQSUEaPKF5uGEAQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=gZdpIlaifDi264JqIhfee++q1eEVwJxU0McwmHRefkSjBeqP5qJsVJbS1qHTHPYxh
 pdDR58Dl5wcnSgDmOVkBUj4KMuGZDJLR2Ypo56Qm/UaDB2srETKx6SVzXOckbPZ5qD
 nTbBY1oiHOzhNqrqnc244Aol3HCJaJw3MFKaJI66glujl8TwNh7IHgFZm5sIUA/LqC
 XivtIAQSlfrjfQPpQ1UCYsHgwuTB2JNWjrqb5J8xB/Dcmi45EX42ZUhk2pLIJZ/fYu
 uiDFUQcYxJWBlnYqfQ+SvXYvxgpnSFIVrgdZXVOAlZzk2f6snVg6yd76840X2ULINV
 Wa5+CIX+o7J5w==
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: linux-kernel@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net
Date: Mon,  5 Dec 2022 10:54:30 -0800
Message-Id: <20221205185433.3479699-3-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.39.0.rc0.267.gcb52ba06e7-goog
In-Reply-To: <20221205185433.3479699-1-jaegeuk@kernel.org>
References: <20221205185433.3479699-1-jaegeuk@kernel.org>
MIME-Version: 1.0
X-Headers-End: 1p2GcD-00076m-Qt
Subject: [f2fs-dev] [PATCH 3/6] f2fs: remove unnecessary __init_extent_tree
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

Added into the caller.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/extent_cache.c | 21 +++++----------------
 1 file changed, 5 insertions(+), 16 deletions(-)

diff --git a/fs/f2fs/extent_cache.c b/fs/f2fs/extent_cache.c
index 2a8e31e6d518..c6810347e205 100644
--- a/fs/f2fs/extent_cache.c
+++ b/fs/f2fs/extent_cache.c
@@ -386,21 +386,6 @@ static struct extent_tree *__grab_extent_tree(struct inode *inode)
 	return et;
 }
 
-static struct extent_node *__init_extent_tree(struct f2fs_sb_info *sbi,
-				struct extent_tree *et, struct extent_info *ei)
-{
-	struct rb_node **p = &et->root.rb_root.rb_node;
-	struct extent_node *en;
-
-	en = __attach_extent_node(sbi, et, ei, NULL, p, true);
-	if (!en)
-		return NULL;
-
-	et->largest = en->ei;
-	et->cached_en = en;
-	return en;
-}
-
 static unsigned int __free_extent_tree(struct f2fs_sb_info *sbi,
 					struct extent_tree *et)
 {
@@ -460,8 +445,12 @@ static void __f2fs_init_extent_tree(struct inode *inode, struct page *ipage)
 	if (atomic_read(&et->node_cnt))
 		goto out;
 
-	en = __init_extent_tree(sbi, et, &ei);
+	en = __attach_extent_node(sbi, et, &ei, NULL,
+				&et->root.rb_root.rb_node, true);
 	if (en) {
+		et->largest = en->ei;
+		et->cached_en = en;
+
 		spin_lock(&sbi->extent_lock);
 		list_add_tail(&en->list, &sbi->extent_list);
 		spin_unlock(&sbi->extent_lock);
-- 
2.39.0.rc0.267.gcb52ba06e7-goog



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
