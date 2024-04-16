Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60A17C04FF8
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 16 Apr 2024 07:23:46 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1rwdAP-0007Qv-EH;
	Tue, 16 Apr 2024 07:23:45 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1rwdAO-0007Qm-3r
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 16 Apr 2024 07:23:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=nebwr34inJA/ZYYAC9fSM7aQwvQVIq10txEmBjSfFYU=; b=d8kmxEkXkMeknywbF3YYUTTnih
 o3LTstmGBMbklpRXGd101pRTlhcnIbewumlEYyf9gYsQuUNxnqcyajpB0c4y5R5GszEX6wvSyUlPV
 Nmb7+x139/sxbV3u0V0Cm/rRW32cO68ONIeL0LXAcvLP+DOzkh7phz12Ek9RUD+vBBDY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=nebwr34inJA/ZYYAC9fSM7aQwvQVIq10txEmBjSfFYU=; b=Juvq0K/dVDGScqe5AuLsmWZ9yi
 a2HO7uqXQghf2IGjn+L1IgLapSb4Fs/9KMZ8HVCzDOV3wfqLqGtCi2nDof/KfMPjY85DLYQQ2az7L
 i+aMKA/H2KWEybxPpwirF0l0WGLZJ/1xojR5iLTLjeI3WoIFh1p4FA644mklQKDAhhJs=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1rwdAN-0002y0-S6 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 16 Apr 2024 07:23:44 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 5E8106109A
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 16 Apr 2024 07:23:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCED4C4AF07;
 Tue, 16 Apr 2024 07:23:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1713252213;
 bh=+rHA/TjA7B8eR6kxVZ+90vp2Y9xGqpF27dl9oDGOTCU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=FoxT+UxJEf+VaWlxWxF+lc6GlEDeXmwoSWwYq9YqLCgs+z6+8IJV+I34mp1l1k5QC
 I8Qf1H7YCeViM7zxMI3Rk4rsntyhRzjYyKLkmqqjYqlFYz5RBYUnXfaGZNE1Poz6Sk
 W/V5d+tyfya1T/tozU40xqeBgLUFOrnc8Z4OOBXiLcVFLBFuxmTRzm60gi9Rem3L9x
 FXJr81HS8fFpRn8C3RvBhTnlV/AIvMdize9pZQpdu0r604uTJyo6jq9JBYWM2ru8KZ
 8uB2OM8Y6m0GpH2diij3Xrx5aMZGateWpOZheqLPEx7ldeMX0uiiNC/7IqnARph3UV
 aXbjHwY1JKhqg==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Date: Tue, 16 Apr 2024 15:23:16 +0800
Message-Id: <20240416072318.6486-2-chao@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240416072318.6486-1-chao@kernel.org>
References: <20240416072318.6486-1-chao@kernel.org>
MIME-Version: 1.0
X-Headers-End: 1rwdAN-0002y0-S6
Subject: [f2fs-dev] [PATCH 2/4] f2fs: convert f2fs_read_single_page() to use
 folio
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

Convert f2fs_read_single_page() to use folio and related
functionality.

Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/data.c | 27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 14dcd621acaa..c35107657c97 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -2092,7 +2092,7 @@ static inline loff_t f2fs_readpage_limit(struct inode *inode)
 	return i_size_read(inode);
 }
 
-static int f2fs_read_single_page(struct inode *inode, struct page *page,
+static int f2fs_read_single_page(struct inode *inode, struct folio *folio,
 					unsigned nr_pages,
 					struct f2fs_map_blocks *map,
 					struct bio **bio_ret,
@@ -2105,9 +2105,10 @@ static int f2fs_read_single_page(struct inode *inode, struct page *page,
 	sector_t last_block;
 	sector_t last_block_in_file;
 	sector_t block_nr;
+	pgoff_t index = folio_index(folio);
 	int ret = 0;
 
-	block_in_file = (sector_t)page_index(page);
+	block_in_file = (sector_t)index;
 	last_block = block_in_file + nr_pages;
 	last_block_in_file = bytes_to_blks(inode,
 			f2fs_readpage_limit(inode) + blocksize - 1);
@@ -2138,7 +2139,7 @@ static int f2fs_read_single_page(struct inode *inode, struct page *page,
 got_it:
 	if ((map->m_flags & F2FS_MAP_MAPPED)) {
 		block_nr = map->m_pblk + block_in_file - map->m_lblk;
-		SetPageMappedToDisk(page);
+		folio_set_mappedtodisk(folio);
 
 		if (!f2fs_is_valid_blkaddr(F2FS_I_SB(inode), block_nr,
 						DATA_GENERIC_ENHANCE_READ)) {
@@ -2147,15 +2148,15 @@ static int f2fs_read_single_page(struct inode *inode, struct page *page,
 		}
 	} else {
 zero_out:
-		zero_user_segment(page, 0, PAGE_SIZE);
-		if (f2fs_need_verity(inode, page->index) &&
-		    !fsverity_verify_page(page)) {
+		folio_zero_segment(folio, 0, folio_size(folio));
+		if (f2fs_need_verity(inode, index) &&
+		    !fsverity_verify_folio(folio)) {
 			ret = -EIO;
 			goto out;
 		}
-		if (!PageUptodate(page))
-			SetPageUptodate(page);
-		unlock_page(page);
+		if (!folio_test_uptodate(folio))
+			folio_mark_uptodate(folio);
+		folio_unlock(folio);
 		goto out;
 	}
 
@@ -2165,14 +2166,14 @@ static int f2fs_read_single_page(struct inode *inode, struct page *page,
 	 */
 	if (bio && (!page_is_mergeable(F2FS_I_SB(inode), bio,
 				       *last_block_in_bio, block_nr) ||
-		    !f2fs_crypt_mergeable_bio(bio, inode, page->index, NULL))) {
+		    !f2fs_crypt_mergeable_bio(bio, inode, index, NULL))) {
 submit_and_realloc:
 		f2fs_submit_read_bio(F2FS_I_SB(inode), bio, DATA);
 		bio = NULL;
 	}
 	if (bio == NULL) {
 		bio = f2fs_grab_read_bio(inode, block_nr, nr_pages,
-				is_readahead ? REQ_RAHEAD : 0, page->index,
+				is_readahead ? REQ_RAHEAD : 0, index,
 				false);
 		if (IS_ERR(bio)) {
 			ret = PTR_ERR(bio);
@@ -2187,7 +2188,7 @@ static int f2fs_read_single_page(struct inode *inode, struct page *page,
 	 */
 	f2fs_wait_on_block_writeback(inode, block_nr);
 
-	if (bio_add_page(bio, page, blocksize, 0) < blocksize)
+	if (!bio_add_folio(bio, folio, blocksize, 0))
 		goto submit_and_realloc;
 
 	inc_page_count(F2FS_I_SB(inode), F2FS_RD_DATA);
@@ -2453,7 +2454,7 @@ static int f2fs_mpage_readpages(struct inode *inode,
 read_single_page:
 #endif
 
-		ret = f2fs_read_single_page(inode, &folio->page, max_nr_pages, &map,
+		ret = f2fs_read_single_page(inode, folio, max_nr_pages, &map,
 					&bio, &last_block_in_bio, rac);
 		if (ret) {
 #ifdef CONFIG_F2FS_FS_COMPRESSION
-- 
2.40.1



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
