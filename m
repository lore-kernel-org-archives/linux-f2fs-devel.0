Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09BABC433F5
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 17 Mar 2022 08:33:44 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.94.2)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1nUlZp-0007Xd-Cf; Thu, 17 Mar 2022 08:33:43 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <chao@kernel.org>) id 1nUlZo-0007X3-G5
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 17 Mar 2022 08:33:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=3JuV3VsYc2luNX2O6xNYoXI1lRnbvoABPjAQu4zAxhw=; b=k2qWKIgxjNJdG8XV3XoJRYhzwA
 p+dY8o1Ub1s4+OeyXi4xbMPW8T+Jd4Ss6mNMMZgm4HeiaOHxdEEKlcn97+/sxYWRbqt6XGYzNUuG0
 faGAap0qaAJjVmaZoLMgADvCzR5aHHRdAAvrhKZOOsjCJb6mKpPhB5ztXbQUirz+Llxw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=3JuV3VsYc2luNX2O6xNYoXI1lRnbvoABPjAQu4zAxhw=; b=F
 QBWUCFh8aZEAJejOplusvZf22zUBlsXaVLlxfMJs6dME9EDwKfm/NyRC2JkqKsxjzw3Uo8jya4XJu
 7cJjK2xx/6vR/dN91//L/u6cLiA8aiZjuGoAS0t9gMmAqHZUJ+WRHlYIF2fU+fq9m551UH0EiT9om
 EK93VJs9AZltZoKU=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.94.2)
 id 1nUlZk-001ilL-Pi
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 17 Mar 2022 08:33:42 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 2AA326152B;
 Thu, 17 Mar 2022 08:33:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64A59C340E9;
 Thu, 17 Mar 2022 08:33:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1647506011;
 bh=q7Vevl95s1m0U8KAngYN2oMf3t0AsinbsCz5Gz67tfM=;
 h=From:To:Cc:Subject:Date:From;
 b=dZOX+BgtO8hmugGyMCIwQ8eHH4s9gxoQKH1210k5D1gxsPWWnL+3TokaTspzErZ1F
 d0W/HJcjGWif2cbZCwbPl7TFGJBVj/n+b7hCcE36aAYvRPBzJ+/R4bFC+7EQuq0en4
 bwgL+GIzDZwaIvaCBT1zkO+RsdqzLiEKWVPAueEgiSyIDwf0uMEnUoJ9h+sSrOxkYB
 DeeYAKZrHvGXDZbVPrcIy6ufvbI9wE73OS6YKrXg0i9VumW4WobzD7mI25dckiYaUV
 22vEBgh+nqQfj5i/3fWPn2PIypTwXvcPWz9yaZwG1/B8Z4sMPJYmlss9tAmxs2Q3f3
 ZRk6THfWfRF5g==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Date: Thu, 17 Mar 2022 16:33:15 +0800
Message-Id: <20220317083315.25974-1-chao@kernel.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
X-Headers-End: 1nUlZk-001ilL-Pi
Subject: [f2fs-dev] [PATCH] f2fs: initialize sbi->gc_mode explicitly
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
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

It needs to initialized sbi->gc_mode to GC_NORMAL explicitly.

Signed-off-by: Chao Yu <chao.yu@oppo.com>
---
 fs/f2fs/super.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 1207402f7683..08f384b0bd0d 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -3590,6 +3590,7 @@ static void init_sb_info(struct f2fs_sb_info *sbi)
 	F2FS_NODE_INO(sbi) = le32_to_cpu(raw_super->node_ino);
 	F2FS_META_INO(sbi) = le32_to_cpu(raw_super->meta_ino);
 	sbi->cur_victim_sec = NULL_SECNO;
+	sbi->gc_mode = GC_NORMAL;
 	sbi->next_victim_seg[BG_GC] = NULL_SEGNO;
 	sbi->next_victim_seg[FG_GC] = NULL_SEGNO;
 	sbi->max_victim_search = DEF_MAX_VICTIM_SEARCH;
-- 
2.32.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
