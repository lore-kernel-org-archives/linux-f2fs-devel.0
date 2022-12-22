Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1D35C4332F
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 22 Dec 2022 23:55:10 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1p8VP2-0006Yu-62;
	Thu, 22 Dec 2022 23:55:08 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <jaegeuk@kernel.org>) id 1p8VP0-0006Yn-EM
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 22 Dec 2022 23:55:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=EoSKRfP95tMCCyXGT6oqGYtq4T4xh5ZQBFdSKAqMbOA=; b=gibEhM837tskoXibiPtCNN4fFn
 doUR+aa3MYrJV6azMKi50yY2tW4HK6ZC7Qs/U+dQIOynkMAP5IR+vrL3WJJok197uI5+jiX+SjkL1
 8hXAcU2b+K/G98cPZw8PQP4hlHjp1J/nFqZ+e21LVeOl69Ur9bukOLbdh1GWDSQCZnIY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=EoSKRfP95tMCCyXGT6oqGYtq4T4xh5ZQBFdSKAqMbOA=; b=Q
 dHdzGOU5P6QZs4rJQOLno+/YO+rMmifE7jwv/YW7lWvS8IXjBQ4gxPeXScXewJlbFr7KMGJ8c8sKi
 kjMCYrF488W1zd06svARe5VnSeyCYRWN3z3QggL76kBNUqpeVAZsunjjxJXCfJze3cKNwpvz9WE2M
 Yg9vBz+XaFcMkerc=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1p8VOz-008OvR-Po for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 22 Dec 2022 23:55:06 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 9717B61DDA
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu, 22 Dec 2022 23:54:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 592CFC433D2;
 Thu, 22 Dec 2022 23:54:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1671753299;
 bh=S0IfmelM7yN+udGca+1KPF5Wdz0l5L6Avlts03bXzCo=;
 h=From:To:Cc:Subject:Date:From;
 b=K5NW/mys7QToKUfmyLIQwokRF4s8EDDmQDlS180rqsBQFMkxJVUlZHkoE90AHE6pd
 TusZw5Uy6lcMLW60VQdPlVIAZ7+PKGokMJOkn2jLnP+iv66glZn8D0gQELk4+5J8pi
 QyUIhjQOXIU3E9GqlwL/cbv2cZOREkaK90AiO8M1YexBbcWZ+0Zr80ZwVH1dKuL9K6
 zHKt+fq0Scu8X44nfkmi4tPTun1aVyHfNaoh5xN2fTGsWIpjWwA9oj9MOQKxwzM2SS
 u9/31kgjEKIjPbBp9JL7V5C/RJnybSQnwqxlIlCQ2Ddfeb0eys3mjOo/5EJvo/dxEO
 TMfv3TnFGtbXw==
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: linux-kernel@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net
Date: Thu, 22 Dec 2022 15:54:58 -0800
Message-Id: <20221222235458.957816-1-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
MIME-Version: 1.0
X-Headers-End: 1p8VOz-008OvR-Po
Subject: [f2fs-dev] [PATCH] f2fs: let's avoid panic if extent_tree is not
 created
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

This patch avoids the below panic.

pc : __lookup_extent_tree+0xd8/0x760
lr : f2fs_do_write_data_page+0x104/0x87c
sp : ffffffc010cbb3c0
x29: ffffffc010cbb3e0 x28: 0000000000000000
x27: ffffff8803e7f020 x26: ffffff8803e7ed40
x25: ffffff8803e7f020 x24: ffffffc010cbb460
x23: ffffffc010cbb480 x22: 0000000000000000
x21: 0000000000000000 x20: ffffffff22e90900
x19: 0000000000000000 x18: ffffffc010c5d080
x17: 0000000000000000 x16: 0000000000000020
x15: ffffffdb1acdbb88 x14: ffffff888759e2b0
x13: 0000000000000000 x12: ffffff802da49000
x11: 000000000a001200 x10: ffffff8803e7ed40
x9 : ffffff8023195800 x8 : ffffff802da49078
x7 : 0000000000000001 x6 : 0000000000000000
x5 : 0000000000000006 x4 : ffffffc010cbba28
x3 : 0000000000000000 x2 : ffffffc010cbb480
x1 : 0000000000000000 x0 : ffffff8803e7ed40
Call trace:
 __lookup_extent_tree+0xd8/0x760
 f2fs_do_write_data_page+0x104/0x87c
 f2fs_write_single_data_page+0x420/0xb60
 f2fs_write_cache_pages+0x418/0xb1c
 __f2fs_write_data_pages+0x428/0x58c
 f2fs_write_data_pages+0x30/0x40
 do_writepages+0x88/0x190
 __writeback_single_inode+0x48/0x448
 writeback_sb_inodes+0x468/0x9e8
 __writeback_inodes_wb+0xb8/0x2a4
 wb_writeback+0x33c/0x740
 wb_do_writeback+0x2b4/0x400
 wb_workfn+0xe4/0x34c
 process_one_work+0x24c/0x5bc
 worker_thread+0x3e8/0xa50
 kthread+0x150/0x1b4

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/extent_cache.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/extent_cache.c b/fs/f2fs/extent_cache.c
index a510fa57a823..1daf8c88c09b 100644
--- a/fs/f2fs/extent_cache.c
+++ b/fs/f2fs/extent_cache.c
@@ -546,7 +546,8 @@ static bool __lookup_extent_tree(struct inode *inode, pgoff_t pgofs,
 	struct extent_node *en;
 	bool ret = false;
 
-	f2fs_bug_on(sbi, !et);
+	if (!et)
+		return false;
 
 	trace_f2fs_lookup_extent_tree_start(inode, pgofs, type);
 
-- 
2.39.0.314.g84b9a713c41-goog



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
