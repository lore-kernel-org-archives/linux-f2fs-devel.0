Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE8F6C433FE
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 28 Nov 2022 09:16:19 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1ozaFP-0005WE-AL;
	Mon, 28 Nov 2022 09:16:19 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95) (envelope-from
 <BATV+7f5f7765a4bd65a1d96c+7036+infradead.org+hch@bombadil.srs.infradead.org>)
 id 1ozaFK-0005UP-TC for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 28 Nov 2022 09:16:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=2mCuzvSTOc5V2zWs1Uovav5yXqHWfftDq2PPTWi+vOM=; b=lC1mC0zJECTk795HtyiD07Rcnu
 a+Y5l5mPiKP2aJxiQUXPcgVjI4mdvdLS3aSjAmNoYB2QsGhZ0GQpcjC2JCBkyWHLb3oHG7QwpELiz
 SSots1OFLaJfecsqaDOKeQVrtkq/p2d6neS9LTQj4EkSmwU5505uaYLKUy95RFDeRSa4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=2mCuzvSTOc5V2zWs1Uovav5yXqHWfftDq2PPTWi+vOM=; b=Y56pFtZyTLr5mfGInnH4Gg+MuP
 Zk2FwyBjmvHT+1OFyZQ2+k2z6YliAAPoZFaJwL8JyUX51DUgVBFQt4kTqX/9nkKth0URGyTxoJJJs
 YPbZr87K+Eae/9VbKlzBFt3qgtPNmVLbbaqU541EI6Fa+lj0y9DnX3jChsIYvikGsUO0=;
Received: from bombadil.infradead.org ([198.137.202.133])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1ozaFK-00GRT9-6j for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 28 Nov 2022 09:16:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-Type:Content-ID:Content-Description;
 bh=2mCuzvSTOc5V2zWs1Uovav5yXqHWfftDq2PPTWi+vOM=; b=RuHVgf6B7sTnCIPWA8wZfeW9hB
 Qffj2uHKC0UJmt6O/9Qp0jUL1TLyu5bwUg/llU4X3ctDVB0zISi0/gbuXAjRlOwkxFnt/lgFFr82Y
 ioXfJ+UZHRnRhClBF5lSU8uibjTxu+6s2rcycAq017EjPJAnYLHZ8gMnlx7qvaGTlrRV8UQPL80tb
 5O4Efrh3xqmd5Pb57NSugSUabBSB7oLhO4eaW+e5T/6FiXSXDj/YXr3l67AI0+sj3nOOIEh8Kr2jv
 umxJdiVg5CoDqyCS0HVK9oCWI8tZ5+tKyUSv5fAJVUTZT0/FwzI793bAbypBmCwiD2EeR9y1ySv/H
 Ls2CNClg==;
Received: from [2001:4bb8:192:26e7:4739:fc09:43a5:2665] (helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1ozaFE-000Z3y-Ab; Mon, 28 Nov 2022 09:16:08 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jaegeuk Kim <jaegeuk@kernel.org>,
	Chao Yu <chao@kernel.org>
Date: Mon, 28 Nov 2022 10:15:23 +0100
Message-Id: <20221128091523.1242584-16-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221128091523.1242584-1-hch@lst.de>
References: <20221128091523.1242584-1-hch@lst.de>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Headers-End: 1ozaFK-00GRT9-6j
Subject: [f2fs-dev] [PATCH 15/15] f2fs: refactor the hole reporting and
 allocation logic in f2fs_map_blocks
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
Cc: linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Add a is_hole local variable to figure out if the block number might need
allocation, and untangle to logic to report the hole or fill it with a
block allocation.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/f2fs/data.c | 113 ++++++++++++++++++++++++-------------------------
 1 file changed, 56 insertions(+), 57 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 3c802ce397de52..32e6823e1e9b1a 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -1524,6 +1524,7 @@ int f2fs_map_blocks(struct inode *inode, struct f2fs_map_blocks *map, int flag)
 	block_t blkaddr;
 	unsigned int start_pgofs;
 	int bidx = 0;
+	bool is_hole;
 
 	if (!maxblocks)
 		return 0;
@@ -1564,78 +1565,76 @@ int f2fs_map_blocks(struct inode *inode, struct f2fs_map_blocks *map, int flag)
 
 next_block:
 	blkaddr = f2fs_data_blkaddr(&dn);
-
-	if (__is_valid_data_blkaddr(blkaddr) &&
-		!f2fs_is_valid_blkaddr(sbi, blkaddr, DATA_GENERIC_ENHANCE)) {
+	is_hole = !__is_valid_data_blkaddr(blkaddr);
+	if (!is_hole &&
+	    !f2fs_is_valid_blkaddr(sbi, blkaddr, DATA_GENERIC_ENHANCE)) {
 		err = -EFSCORRUPTED;
 		f2fs_handle_error(sbi, ERROR_INVALID_BLKADDR);
 		goto sync_out;
 	}
 
-	if (__is_valid_data_blkaddr(blkaddr)) {
-		/* use out-place-update for driect IO under LFS mode */
-		if (f2fs_lfs_mode(sbi) && flag == F2FS_GET_BLOCK_DIO &&
-							map->m_may_create) {
+	/* use out-place-update for direct IO under LFS mode */
+	if (map->m_may_create &&
+	    (is_hole || (f2fs_lfs_mode(sbi) && flag == F2FS_GET_BLOCK_DIO))) {
+		if (unlikely(f2fs_cp_error(sbi))) {
+			err = -EIO;
+			goto sync_out;
+		}
+
+		switch (flag) {
+		case F2FS_GET_BLOCK_PRE_AIO:
+			if (blkaddr == NULL_ADDR) {
+				prealloc++;
+				last_ofs_in_node = dn.ofs_in_node;
+			}
+			break;
+		case F2FS_GET_BLOCK_PRE_DIO:
+		case F2FS_GET_BLOCK_DIO:
 			err = __allocate_data_block(&dn, map->m_seg_type);
 			if (err)
 				goto sync_out;
-			blkaddr = dn.data_blkaddr;
+			if (flag == F2FS_GET_BLOCK_PRE_DIO)
+				file_need_truncate(inode);
 			set_inode_flag(inode, FI_APPEND_WRITE);
+			break;
+		default:
+			WARN_ON_ONCE(1);
+			err = -EIO;
+			goto sync_out;
 		}
-	} else {
-		if (map->m_may_create) {
-			if (unlikely(f2fs_cp_error(sbi))) {
-				err = -EIO;
-				goto sync_out;
-			}
-			if (flag == F2FS_GET_BLOCK_PRE_AIO) {
-				if (blkaddr == NULL_ADDR) {
-					prealloc++;
-					last_ofs_in_node = dn.ofs_in_node;
-				}
-			} else {
-				WARN_ON(flag != F2FS_GET_BLOCK_PRE_DIO &&
-					flag != F2FS_GET_BLOCK_DIO);
-				err = __allocate_data_block(&dn,
-							map->m_seg_type);
-				if (!err) {
-					if (flag == F2FS_GET_BLOCK_PRE_DIO)
-						file_need_truncate(inode);
-					set_inode_flag(inode, FI_APPEND_WRITE);
-				}
-			}
-			if (err)
-				goto sync_out;
+
+		blkaddr = dn.data_blkaddr;
+	    	if (is_hole)
 			map->m_flags |= F2FS_MAP_NEW;
-			blkaddr = dn.data_blkaddr;
-		} else {
-			if (f2fs_compressed_file(inode) &&
-					f2fs_sanity_check_cluster(&dn) &&
-					(flag != F2FS_GET_BLOCK_FIEMAP ||
-					IS_ENABLED(CONFIG_F2FS_CHECK_FS))) {
-				err = -EFSCORRUPTED;
-				f2fs_handle_error(sbi,
-						ERROR_CORRUPTED_CLUSTER);
-				goto sync_out;
-			}
-			if (flag == F2FS_GET_BLOCK_BMAP) {
-				map->m_pblk = 0;
-				goto sync_out;
-			}
-			if (flag == F2FS_GET_BLOCK_PRECACHE)
-				goto sync_out;
-			if (flag == F2FS_GET_BLOCK_FIEMAP &&
-						blkaddr == NULL_ADDR) {
-				if (map->m_next_pgofs)
-					*map->m_next_pgofs = pgofs + 1;
-				goto sync_out;
-			}
-			if (flag != F2FS_GET_BLOCK_FIEMAP) {
-				/* for defragment case */
+	} else if (is_hole) {
+		if (f2fs_compressed_file(inode) &&
+		    f2fs_sanity_check_cluster(&dn) &&
+		    (flag != F2FS_GET_BLOCK_FIEMAP ||
+		     IS_ENABLED(CONFIG_F2FS_CHECK_FS))) {
+			err = -EFSCORRUPTED;
+			f2fs_handle_error(sbi,
+					ERROR_CORRUPTED_CLUSTER);
+			goto sync_out;
+		}
+
+		switch (flag) {
+		case F2FS_GET_BLOCK_PRECACHE:
+			goto sync_out;
+		case F2FS_GET_BLOCK_BMAP:
+			map->m_pblk = 0;
+			goto sync_out;
+		case F2FS_GET_BLOCK_FIEMAP:
+			if (blkaddr == NULL_ADDR) {
 				if (map->m_next_pgofs)
 					*map->m_next_pgofs = pgofs + 1;
 				goto sync_out;
 			}
+			break;
+		default:
+			/* for defragment case */
+			if (map->m_next_pgofs)
+				*map->m_next_pgofs = pgofs + 1;
+			goto sync_out;
 		}
 	}
 
-- 
2.30.2



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
