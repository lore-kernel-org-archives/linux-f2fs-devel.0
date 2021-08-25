Return-Path: <SRS0=OJBd=NQ=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F839C4338F
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 25 Aug 2021 11:34:49 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 025046113C
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 25 Aug 2021 11:34:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 025046113C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.92.3)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1mIrB9-00076J-Fz; Wed, 25 Aug 2021 11:34:47 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.3)
 (envelope-from <chao@kernel.org>) id 1mIrB7-000767-5B
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 25 Aug 2021 11:34:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Ew6i7szHpKvGHYgQxevb4CQ8f+7flsNNAYUqIu0B9Ks=; b=X8v7viv/hGnyrSsFLszRqeDiiu
 wGgftEz+iZpBoeXJhYlrbHUlFirCJWHt7M3kN78oWBqfj1hPZVJzAief9T9vh1AU05vpIaVgxbvGU
 A8txCU6TYSOC00yCXcJ5HLHYozQuitKmLCaCBo1f6ZoFmMyZ7q8NcnK2WOEd6LGDRItM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=Ew6i7szHpKvGHYgQxevb4CQ8f+7flsNNAYUqIu0B9Ks=; b=S
 9wg+3tP7O/5dq7c8GU7k+Ib/wf3baBdK8uH3jkXzxtuejPo76c9veEJFG/bDecsdcZH7rSq1M1xsh
 gb/JQhtymogEcRRDDwCnHgP6ZV+XSTrRAiFlHE97zCTND0dWofa8yFk9I9k/emZsGN51TYXUDjH3m
 5DZT1wg2f3fgUe+E=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.3)
 id 1mIrB3-000YhG-UX
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 25 Aug 2021 11:34:45 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id EEBA46113C;
 Wed, 25 Aug 2021 11:34:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1629891270;
 bh=6hoWY3WQkLX2sswImTRTA9ZnKWT/Ne5C9i57x+tLmDU=;
 h=From:To:Cc:Subject:Date:From;
 b=WK5mZjfeNnEPTo8w+meCKT8nmz+qK/b4a1XySxdnsAQrDSh0NABTzFKtUrjMM55hj
 9KkUVnlOCoXKkSKF5dlTTfZ0kzys0fxAvY+AXkmywnYrUplagsnVug42VQ3MYyMy1i
 YsNSeQk6kVQJbhCfavIOtNiHlwLrZ77seoWseiRzrFaxEIfh6QQPHFkv8PJa0zoeuG
 X16MrgRPEMWpl3uVEnoiK3+VNj1iMl3+EyG9K+H5XCOMbBugBAnDjiIWXV5Sor9xaJ
 AjbDotUDyb/rWb5TCH0bqgHWPjwAlyngM3RIQi0HYMsytvzIlXp6mbmLaEvQxFl+pu
 0SP9utR/6F9cw==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Date: Wed, 25 Aug 2021 19:34:19 +0800
Message-Id: <20210825113419.8645-1-chao@kernel.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
X-Headers-End: 1mIrB3-000YhG-UX
Subject: [f2fs-dev] [PATCH] f2fs: fix to unmap pages from userspace process
 in punch_hole()
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
Cc: Chao Yu <chao.yu@linux.dev>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

We need to unmap pages from userspace process before removing pagecache
in punch_hole() like we did in f2fs_setattr().

Similar change:
commit 5e44f8c374dc ("ext4: hole-punch use truncate_pagecache_range")

Fixes: fbfa2cc58d53 ("f2fs: add file operations")
Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/file.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 3330efb41f22..f30b841d4e5a 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -1106,7 +1106,6 @@ static int punch_hole(struct inode *inode, loff_t offset, loff_t len)
 		}
 
 		if (pg_start < pg_end) {
-			struct address_space *mapping = inode->i_mapping;
 			loff_t blk_start, blk_end;
 			struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
 
@@ -1118,8 +1117,7 @@ static int punch_hole(struct inode *inode, loff_t offset, loff_t len)
 			down_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
 			down_write(&F2FS_I(inode)->i_mmap_sem);
 
-			truncate_inode_pages_range(mapping, blk_start,
-					blk_end - 1);
+			truncate_pagecache_range(inode, blk_start, blk_end - 1);
 
 			f2fs_lock_op(sbi);
 			ret = f2fs_truncate_hole(inode, pg_start, pg_end);
-- 
2.32.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
