Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 384B8C369AB
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 31 Mar 2025 20:13:55 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1tzLW6-0004GN-Pj;
	Mon, 31 Mar 2025 20:13:54 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <willy@infradead.org>) id 1tzLVu-0003zD-2H
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 31 Mar 2025 20:13:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=eSDCP3xHKkkq/W+ivA4O9hVNrdM5hJrgVK9ieOQCrcQ=; b=MShahuiD8KPy5SII1oFWAQMdkD
 OeX8hPiq2e4+u7TNefoi89xuFZj7NUdFvcGP4jf8oWKZSiePEzxvnYtnWoNOQ3NMDPD3LuIje8H6S
 v4+ymMs4fkUN3+zJ9V53mMx4pgMU92Y7sJklJ9tyjevK/JM4IpTUk+MjpXBfO2mDJJ0Y=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=eSDCP3xHKkkq/W+ivA4O9hVNrdM5hJrgVK9ieOQCrcQ=; b=nVsAukX7z0wC0U/ZMx9tAbe9kS
 IxkBfmMhK7yif2xb7RnZoNmjBPLhos7QGsL76BeKcsMpZyfjuezghDkcTqw1bt9JWZQaYHAm1r6Sz
 ver+Zcsl5BP6ZrvYLZgMlrgDX2mPMR+nzu+irSaxMyNbSE8xl3bbgCgjlbt6FCZDzlXs=;
Received: from casper.infradead.org ([90.155.50.34])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1tzLVo-0003hs-EM for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 31 Mar 2025 20:13:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=eSDCP3xHKkkq/W+ivA4O9hVNrdM5hJrgVK9ieOQCrcQ=; b=GHjxu4pNvUHahKG7HggfMp7PMB
 gwghGIH238VJ7OrrOPihlmR1/SQjS0cJK+DKElw0Lmd/dfNywZBlx6+4d+rWay3Kra3E8wuzpGgLf
 DOKKUH38gYiu11P3jt9eMUCthe1FQI+22K5Q9CHkmDfs8sksVSTHP597uiO0K7JKQuGK3OglldJhm
 wK+mtHSurnmFawI0b2AQJgcMVTmMz+4peyikOIs/PSkZcP2NzgsRywv7p3TkNnH0TNPP5r4Sv69kI
 I8/9J3KUPABuS2UUo6zd+3HGgdLrJe8yyxh4vDNpgUx3GJPEIrp7vgG+JJkMkaE53t4Jf4ry5xhTC
 5B6ALtog==;
Received: from willy by casper.infradead.org with local (Exim 4.98.1 #2 (Red
 Hat Linux)) id 1tzLVd-00000004Sbs-0OT5;
 Mon, 31 Mar 2025 20:13:25 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Jaegeuk Kim <jaegeuk@kernel.org>,
	Chao Yu <chao@kernel.org>
Date: Mon, 31 Mar 2025 21:12:40 +0100
Message-ID: <20250331201256.1057782-141-willy@infradead.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250331201256.1057782-1-willy@infradead.org>
References: <20250331201256.1057782-1-willy@infradead.org>
MIME-Version: 1.0
X-Headers-End: 1tzLVo-0003hs-EM
Subject: [f2fs-dev] [PATCH 140/153] f2fs: Convert
 f2fs_load_compressed_page() to f2fs_load_compressed_folio()
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
Cc: "Matthew Wilcox \(Oracle\)" <willy@infradead.org>,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

The only caller already has a folio, so pass it in.  Copy the entire
size of the folio to support large block sizes.  Remove two calls to
compound_head().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/f2fs/compress.c | 16 ++++++++--------
 fs/f2fs/data.c     |  3 +--
 fs/f2fs/f2fs.h     |  6 +++---
 3 files changed, 12 insertions(+), 13 deletions(-)

diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
index 2f9c35d0abda..9da80914304f 100644
--- a/fs/f2fs/compress.c
+++ b/fs/f2fs/compress.c
@@ -1964,25 +1964,25 @@ void f2fs_cache_compressed_page(struct f2fs_sb_info *sbi, struct page *page,
 	f2fs_folio_put(cfolio, true);
 }
 
-bool f2fs_load_compressed_page(struct f2fs_sb_info *sbi, struct page *page,
+bool f2fs_load_compressed_folio(struct f2fs_sb_info *sbi, struct folio *folio,
 								block_t blkaddr)
 {
-	struct page *cpage;
+	struct folio *cfolio;
 	bool hitted = false;
 
 	if (!test_opt(sbi, COMPRESS_CACHE))
 		return false;
 
-	cpage = f2fs_pagecache_get_page(COMPRESS_MAPPING(sbi),
+	cfolio = f2fs_filemap_get_folio(COMPRESS_MAPPING(sbi),
 				blkaddr, FGP_LOCK | FGP_NOWAIT, GFP_NOFS);
-	if (cpage) {
-		if (PageUptodate(cpage)) {
+	if (!IS_ERR(cfolio)) {
+		if (folio_test_uptodate(cfolio)) {
 			atomic_inc(&sbi->compress_page_hit);
-			memcpy(page_address(page),
-				page_address(cpage), PAGE_SIZE);
+			memcpy(folio_address(folio),
+				folio_address(cfolio), folio_size(folio));
 			hitted = true;
 		}
-		f2fs_put_page(cpage, 1);
+		f2fs_folio_put(cfolio, true);
 	}
 
 	return hitted;
diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index d899341a04f8..8980b77bfdab 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -2287,8 +2287,7 @@ int f2fs_read_multi_pages(struct compress_ctx *cc, struct bio **bio_ret,
 
 		f2fs_wait_on_block_writeback(inode, blkaddr);
 
-		if (f2fs_load_compressed_page(sbi, folio_page(folio, 0),
-								blkaddr)) {
+		if (f2fs_load_compressed_folio(sbi, folio, blkaddr)) {
 			if (atomic_dec_and_test(&dic->remaining_pages)) {
 				f2fs_decompress_cluster(dic, true);
 				break;
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index af0420f76e98..e459558fc071 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -4465,7 +4465,7 @@ void f2fs_invalidate_compress_pages_range(struct f2fs_sb_info *sbi,
 					block_t blkaddr, unsigned int len);
 void f2fs_cache_compressed_page(struct f2fs_sb_info *sbi, struct page *page,
 						nid_t ino, block_t blkaddr);
-bool f2fs_load_compressed_page(struct f2fs_sb_info *sbi, struct page *page,
+bool f2fs_load_compressed_folio(struct f2fs_sb_info *sbi, struct folio *folio,
 								block_t blkaddr);
 void f2fs_invalidate_compress_pages(struct f2fs_sb_info *sbi, nid_t ino);
 #define inc_compr_inode_stat(inode)					\
@@ -4521,8 +4521,8 @@ static inline void f2fs_invalidate_compress_pages_range(struct f2fs_sb_info *sbi
 				block_t blkaddr, unsigned int len) { }
 static inline void f2fs_cache_compressed_page(struct f2fs_sb_info *sbi,
 				struct page *page, nid_t ino, block_t blkaddr) { }
-static inline bool f2fs_load_compressed_page(struct f2fs_sb_info *sbi,
-				struct page *page, block_t blkaddr) { return false; }
+static inline bool f2fs_load_compressed_folio(struct f2fs_sb_info *sbi,
+		struct folio *folio, block_t blkaddr) { return false; }
 static inline void f2fs_invalidate_compress_pages(struct f2fs_sb_info *sbi,
 							nid_t ino) { }
 #define inc_compr_inode_stat(inode)		do { } while (0)
-- 
2.47.2



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
