Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9F13C4708D
	for <linux-f2fs-devel@archiver.kernel.org>; Sat, 17 Dec 2022 00:47:18 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1p6LMD-0008Ri-Rk;
	Sat, 17 Dec 2022 00:47:17 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <jaegeuk@kernel.org>) id 1p6LMC-0008Rb-7g
 for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 17 Dec 2022 00:47:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=5d4nHECykwON0hPPvyXf1dMNYfQwP39CXcvkhJ1tw8o=; b=dDDuz5emrZ6MFN6lJ2ngKgW0wq
 DaAB4yCxvVQRk4FZLHfckwYxqCxKcCid4yVXgCoUm8svYDQHSIQksHuTGOqhcPEcc45MGLk8g1qSO
 +q0loPHCIIwMDetsdJVjmkXVp6xlxCGjXdBYsClMi/bD2QJHxlhNQKApj4jKEGOJQbqg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=5d4nHECykwON0hPPvyXf1dMNYfQwP39CXcvkhJ1tw8o=; b=cQsE8vAcNkgE8tzbTiTmkprjJA
 F4q9u1XHvFLu1oEy1hAccj0loOOS02E1sITna67rvLrpVpN+rwi47YBSS1mhyp5PI761ehdKH7BxL
 KR51szVCoJdXFCePLgBBaOnDPrB81vGZxYxhYjLJ6LsphgUYCM6ZdJkZ5LRx+/GqdnWk=;
Received: from ams.source.kernel.org ([145.40.68.75])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1p6LMA-0000lv-Le for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 17 Dec 2022 00:47:16 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 5FC5BB81E53
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Sat, 17 Dec 2022 00:47:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5D72C433EF;
 Sat, 17 Dec 2022 00:47:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1671238027;
 bh=J6kSiIexbLuWJ6COT0xoCdZpCwCFQaT/pl5/3mg1XvE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Lpz+tm1Q3l+aJ0nZ1Wla3h/KYYx2TsmkCxMIB49F06gZEzeZwNLqm7EGSNAYXtPh6
 Oft7043k5Wg1twT6hxG5TWkglUUB9T4mdnL5wHunomWhOzwHGWRPvW8K/LHtqoHRTN
 6OCn6hHqk9mbdCF9RiKg4YChqS7nFITzsmRMFMKDCNodC/ysncynBP75QqOnrYXoYU
 boYVwGBzFEanx7TZeGpgHrwkb7bSdRUSCKisn60EyQ0lfglYRE6FKxwDeSfh27Ab3B
 wp+7R2wTMODHahUGKdvBRBSLD1Tofnqjr6lbqDMigSwUuDlA2/G56qDjeKs3JiQald
 XgBQ1Z8kHR9Kg==
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: linux-kernel@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net
Date: Fri, 16 Dec 2022 16:46:58 -0800
Message-Id: <20221217004659.2092427-3-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
In-Reply-To: <20221217004659.2092427-1-jaegeuk@kernel.org>
References: <20221217004659.2092427-1-jaegeuk@kernel.org>
MIME-Version: 1.0
X-Headers-End: 1p6LMA-0000lv-Le
Subject: [f2fs-dev] [PATCH 2/3] f2fs: don't mix to use union values in
 extent_info
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

Let's explicitly use the defined values in block_age case only.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/extent_cache.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/fs/f2fs/extent_cache.c b/fs/f2fs/extent_cache.c
index 749209005644..7bd1e1832412 100644
--- a/fs/f2fs/extent_cache.c
+++ b/fs/f2fs/extent_cache.c
@@ -881,7 +881,8 @@ static unsigned long long __calculate_block_age(unsigned long long new,
 }
 
 /* This returns a new age and allocated blocks in ei */
-static int __get_new_block_age(struct inode *inode, struct extent_info *ei)
+static int __get_new_block_age(struct inode *inode, struct extent_info *ei,
+						block_t blkaddr)
 {
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
 	loff_t f_size = i_size_read(inode);
@@ -894,7 +895,7 @@ static int __get_new_block_age(struct inode *inode, struct extent_info *ei)
 	 * block here.
 	 */
 	if ((f_size >> PAGE_SHIFT) == ei->fofs && f_size & (PAGE_SIZE - 1) &&
-			ei->blk == NEW_ADDR)
+			blkaddr == NEW_ADDR)
 		return -EINVAL;
 
 	if (__lookup_extent_tree(inode, ei->fofs, ei, EX_BLOCK_AGE)) {
@@ -915,14 +916,14 @@ static int __get_new_block_age(struct inode *inode, struct extent_info *ei)
 		return 0;
 	}
 
-	f2fs_bug_on(sbi, ei->blk == NULL_ADDR);
+	f2fs_bug_on(sbi, blkaddr == NULL_ADDR);
 
 	/* the data block was allocated for the first time */
-	if (ei->blk == NEW_ADDR)
+	if (blkaddr == NEW_ADDR)
 		goto out;
 
-	if (__is_valid_data_blkaddr(ei->blk) &&
-			!f2fs_is_valid_blkaddr(sbi, ei->blk, DATA_GENERIC_ENHANCE)) {
+	if (__is_valid_data_blkaddr(blkaddr) &&
+	    !f2fs_is_valid_blkaddr(sbi, blkaddr, DATA_GENERIC_ENHANCE)) {
 		f2fs_bug_on(sbi, 1);
 		return -EINVAL;
 	}
@@ -953,8 +954,7 @@ static void __update_extent_cache(struct dnode_of_data *dn, enum extent_type typ
 		else
 			ei.blk = dn->data_blkaddr;
 	} else if (type == EX_BLOCK_AGE) {
-		ei.blk = dn->data_blkaddr;
-		if (__get_new_block_age(dn->inode, &ei))
+		if (__get_new_block_age(dn->inode, &ei, dn->data_blkaddr))
 			return;
 	}
 	__update_extent_tree_range(dn->inode, &ei, type);
-- 
2.39.0.314.g84b9a713c41-goog



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
