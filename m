Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DBB0C27C53
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 12 Jun 2024 19:38:51 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1sHTo2-0001Ia-6p;
	Wed, 12 Jun 2024 19:38:49 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <jaegeuk@kernel.org>) id 1sHTny-0001IP-3r
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 12 Jun 2024 19:38:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=X0UH1PNNbMxYJZoiip95yI6EQB1bPuPhH3bLQTwKvZY=; b=KMrpNtKJyJF20z0l1flqHWQ+oJ
 nEaRGImU5VMrEl0287o1kJsi7kQmONr+kmIB+aC7MnFX7H7anroBm0s4lzVBCP54/uchcUNiM8WW0
 TNd7W9+TN8mXJAuXBWG8tzgZDSjj179j/WACx9i+/ewPC00QOzoXc7liLav7LVYdtRRE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=X0UH1PNNbMxYJZoiip95yI6EQB1bPuPhH3bLQTwKvZY=; b=c
 7Zp0gMJycSHA+wnGJEVnYzziwBBuUfTPJntxnM3Spy6e6fzVfHB25AyQe+tGQrpg0H5PDlqU4olOb
 aq69MOuNKrCx+pOIB87ncVzuk/5GWtrKbnVnLyRg7DHS1u2fA1IDXURS5RbF9oseJLLuHG/SIuP7z
 pTSlP5nDkdxf4zNQ=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1sHTnx-0003yg-GN for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 12 Jun 2024 19:38:45 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 5C065608D4
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed, 12 Jun 2024 19:38:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F17D6C4AF48;
 Wed, 12 Jun 2024 19:38:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1718221114;
 bh=3O2VXIYtm+77i6RAmyE/iB05l4/QfxPoP/92pVes7fo=;
 h=From:To:Cc:Subject:Date:From;
 b=sgyBIKp54VFxMG+medder41hKEsUF9I96Q7lJMnDAIgEa2Z90m9udgd5uLeLkl+uR
 TWza8FdFCTK54XAb/CvhGGNfJ+FJsQI+CfjiFqGjeFS1ZecS1puBZC57agbfXef47z
 bLXwfQKlaT9Lpv/9KVc8q2hyzWgnYuPSEoNqr0xTNVbOkBs/5KOsgAQyjlWstvPTNX
 vQbSv7EkvxIM4wxwQbW+gPD9heSDvL9zY2DeLh4m79x5igjJO3QfxCHRef1mKuINww
 49t/yHwvW3iT4rnhK2lgZ7ADKWaM6BcYarZ7MvHH005hqIboFvDpxGruZ6E4hH+S52
 41BigPna414eA==
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: linux-kernel@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net
Date: Wed, 12 Jun 2024 19:38:31 +0000
Message-ID: <20240612193831.106524-1-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.45.2.505.gda0bf45e8d-goog
MIME-Version: 1.0
X-Headers-End: 1sHTnx-0003yg-GN
Subject: [f2fs-dev] [PATCH] f2fs: clean up set REQ_RAHEAD given rac
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

Let's set REQ_RAHEAD per rac by single source.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/compress.c |  2 +-
 fs/f2fs/data.c     | 17 +++++++++++------
 fs/f2fs/f2fs.h     |  2 +-
 3 files changed, 13 insertions(+), 8 deletions(-)

diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
index 1ef82a546391..990b93689b46 100644
--- a/fs/f2fs/compress.c
+++ b/fs/f2fs/compress.c
@@ -1100,7 +1100,7 @@ static int prepare_compress_overwrite(struct compress_ctx *cc,
 		struct bio *bio = NULL;
 
 		ret = f2fs_read_multi_pages(cc, &bio, cc->cluster_size,
-					&last_block_in_bio, false, true);
+					&last_block_in_bio, NULL, true);
 		f2fs_put_rpages(cc);
 		f2fs_destroy_compress_ctx(cc, true);
 		if (ret)
diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index b9b0debc6b3d..b6dcb3bcaef7 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -2067,12 +2067,17 @@ static inline loff_t f2fs_readpage_limit(struct inode *inode)
 	return i_size_read(inode);
 }
 
+static inline blk_opf_t f2fs_ra_op_flags(struct readahead_control *rac)
+{
+	return rac ? REQ_RAHEAD : 0;
+}
+
 static int f2fs_read_single_page(struct inode *inode, struct folio *folio,
 					unsigned nr_pages,
 					struct f2fs_map_blocks *map,
 					struct bio **bio_ret,
 					sector_t *last_block_in_bio,
-					bool is_readahead)
+					struct readahead_control *rac)
 {
 	struct bio *bio = *bio_ret;
 	const unsigned blocksize = blks_to_bytes(inode, 1);
@@ -2148,7 +2153,7 @@ static int f2fs_read_single_page(struct inode *inode, struct folio *folio,
 	}
 	if (bio == NULL) {
 		bio = f2fs_grab_read_bio(inode, block_nr, nr_pages,
-				is_readahead ? REQ_RAHEAD : 0, index,
+				f2fs_ra_op_flags(rac), index,
 				false);
 		if (IS_ERR(bio)) {
 			ret = PTR_ERR(bio);
@@ -2178,7 +2183,7 @@ static int f2fs_read_single_page(struct inode *inode, struct folio *folio,
 #ifdef CONFIG_F2FS_FS_COMPRESSION
 int f2fs_read_multi_pages(struct compress_ctx *cc, struct bio **bio_ret,
 				unsigned nr_pages, sector_t *last_block_in_bio,
-				bool is_readahead, bool for_write)
+				struct readahead_control *rac, bool for_write)
 {
 	struct dnode_of_data dn;
 	struct inode *inode = cc->inode;
@@ -2301,7 +2306,7 @@ int f2fs_read_multi_pages(struct compress_ctx *cc, struct bio **bio_ret,
 
 		if (!bio) {
 			bio = f2fs_grab_read_bio(inode, blkaddr, nr_pages,
-					is_readahead ? REQ_RAHEAD : 0,
+					f2fs_ra_op_flags(rac),
 					page->index, for_write);
 			if (IS_ERR(bio)) {
 				ret = PTR_ERR(bio);
@@ -2399,7 +2404,7 @@ static int f2fs_mpage_readpages(struct inode *inode,
 			ret = f2fs_read_multi_pages(&cc, &bio,
 						max_nr_pages,
 						&last_block_in_bio,
-						rac != NULL, false);
+						rac, false);
 			f2fs_destroy_compress_ctx(&cc, false);
 			if (ret)
 				goto set_error_page;
@@ -2449,7 +2454,7 @@ static int f2fs_mpage_readpages(struct inode *inode,
 				ret = f2fs_read_multi_pages(&cc, &bio,
 							max_nr_pages,
 							&last_block_in_bio,
-							rac != NULL, false);
+							rac, false);
 				f2fs_destroy_compress_ctx(&cc, false);
 			}
 		}
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 9688df332147..95d12e025786 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -4297,7 +4297,7 @@ void f2fs_update_read_extent_tree_range_compressed(struct inode *inode,
 				unsigned int llen, unsigned int c_len);
 int f2fs_read_multi_pages(struct compress_ctx *cc, struct bio **bio_ret,
 				unsigned nr_pages, sector_t *last_block_in_bio,
-				bool is_readahead, bool for_write);
+				struct readahead_control *rac, bool for_write);
 struct decompress_io_ctx *f2fs_alloc_dic(struct compress_ctx *cc);
 void f2fs_decompress_end_io(struct decompress_io_ctx *dic, bool failed,
 				bool in_task);
-- 
2.45.2.505.gda0bf45e8d-goog



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
