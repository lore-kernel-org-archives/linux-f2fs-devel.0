Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D36BC52D6F
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 22 Aug 2024 01:30:10 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1sgweQ-0002KB-H1;
	Thu, 22 Aug 2024 01:30:09 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <lizetao1@huawei.com>) id 1sgwe8-0002II-1k
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 22 Aug 2024 01:29:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :References:In-Reply-To:Message-ID:Date:Subject:CC:To:From:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Q2uN2YMyyao7HVWLJfPRI4CbrKzCdi0GCgy5Ghe+qTw=; b=Eaz7l7Tge3JnT1XJ7kUdiGE5Yv
 d4/G4w9AwL1pViSPFKvnwypMSYbTcKIuBK+aJ+o/seP9Zna/ludXsbA9G0l4tXzfY2sOP9tXVwX9D
 5NJcsT6p4oB+J5LhV24VUc+3yG9nesuVfWx5y5O8TFAhpmsPBSiWKyx8MQBden+P4Hv8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:CC:To:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=Q2uN2YMyyao7HVWLJfPRI4CbrKzCdi0GCgy5Ghe+qTw=; b=nWeisbyCyDr2NSIlUwPPwaaFGc
 21yLpQkS66WTtFYfVUzuRE84I89XV0tfS183ZOKvFMd+Y3MzdgS+JMLNX9JICM/Df6QqRkQWbqKHF
 UrcCEcFArgr7REVkNEa0dL8rL6OLLX8liPFVOPJZROWAD3uCme8jYD6/lmfovcU2ZX94=;
Received: from szxga06-in.huawei.com ([45.249.212.32])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1sgwe5-0006bu-UU for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 22 Aug 2024 01:29:51 +0000
Received: from mail.maildlp.com (unknown [172.19.163.44])
 by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4Wq5DN1KN8z1xvkQ;
 Thu, 22 Aug 2024 09:27:48 +0800 (CST)
Received: from kwepemd500012.china.huawei.com (unknown [7.221.188.25])
 by mail.maildlp.com (Postfix) with ESMTPS id F22A31400FD;
 Thu, 22 Aug 2024 09:29:42 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemd500012.china.huawei.com
 (7.221.188.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.34; Thu, 22 Aug
 2024 09:29:42 +0800
To: <clm@fb.com>, <josef@toxicpanda.com>, <dsterba@suse.com>, <terrelln@fb.com>
Date: Thu, 22 Aug 2024 09:37:10 +0800
Message-ID: <20240822013714.3278193-11-lizetao1@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240822013714.3278193-1-lizetao1@huawei.com>
References: <20240822013714.3278193-1-lizetao1@huawei.com>
MIME-Version: 1.0
X-Originating-IP: [10.90.53.73]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemd500012.china.huawei.com (7.221.188.25)
X-Headers-End: 1sgwe5-0006bu-UU
Subject: [f2fs-dev] [PATCH 10/14] btrfs: convert zlib_decompress() to take a
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
From: Li Zetao via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Li Zetao <lizetao1@huawei.com>
Cc: linux-btrfs@vger.kernel.org, willy@infradead.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

The old page API is being gradually replaced and converted to use folio
to improve code readability and avoid repeated conversion between page
and folio. And memcpy_to_page() can be replaced with memcpy_to_folio().
But there is no memzero_folio(), but it can be replaced equivalently by
folio_zero_range().

Signed-off-by: Li Zetao <lizetao1@huawei.com>
---
 fs/btrfs/compression.c |  2 +-
 fs/btrfs/compression.h |  2 +-
 fs/btrfs/zlib.c        | 14 +++++++-------
 3 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index 832ab8984c41..19d18f875563 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -142,7 +142,7 @@ static int compression_decompress(int type, struct list_head *ws,
 		unsigned long dest_pgoff, size_t srclen, size_t destlen)
 {
 	switch (type) {
-	case BTRFS_COMPRESS_ZLIB: return zlib_decompress(ws, data_in, dest_page,
+	case BTRFS_COMPRESS_ZLIB: return zlib_decompress(ws, data_in, page_folio(dest_page),
 						dest_pgoff, srclen, destlen);
 	case BTRFS_COMPRESS_LZO:  return lzo_decompress(ws, data_in, dest_page,
 						dest_pgoff, srclen, destlen);
diff --git a/fs/btrfs/compression.h b/fs/btrfs/compression.h
index 5d01f092ae13..f4f7a981cb90 100644
--- a/fs/btrfs/compression.h
+++ b/fs/btrfs/compression.h
@@ -162,7 +162,7 @@ int zlib_compress_folios(struct list_head *ws, struct address_space *mapping,
 		unsigned long *total_in, unsigned long *total_out);
 int zlib_decompress_bio(struct list_head *ws, struct compressed_bio *cb);
 int zlib_decompress(struct list_head *ws, const u8 *data_in,
-		struct page *dest_page, unsigned long dest_pgoff, size_t srclen,
+		struct folio *dest_folio, unsigned long dest_pgoff, size_t srclen,
 		size_t destlen);
 struct list_head *zlib_alloc_workspace(unsigned int level);
 void zlib_free_workspace(struct list_head *ws);
diff --git a/fs/btrfs/zlib.c b/fs/btrfs/zlib.c
index 8aa82ee1991e..4ca7ff38234c 100644
--- a/fs/btrfs/zlib.c
+++ b/fs/btrfs/zlib.c
@@ -393,7 +393,7 @@ int zlib_decompress_bio(struct list_head *ws, struct compressed_bio *cb)
 }
 
 int zlib_decompress(struct list_head *ws, const u8 *data_in,
-		struct page *dest_page, unsigned long dest_pgoff, size_t srclen,
+		struct folio *dest_folio, unsigned long dest_pgoff, size_t srclen,
 		size_t destlen)
 {
 	struct workspace *workspace = list_entry(ws, struct workspace, list);
@@ -421,12 +421,12 @@ int zlib_decompress(struct list_head *ws, const u8 *data_in,
 
 	ret = zlib_inflateInit2(&workspace->strm, wbits);
 	if (unlikely(ret != Z_OK)) {
-		struct btrfs_inode *inode = BTRFS_I(dest_page->mapping->host);
+		struct btrfs_inode *inode = folio_to_inode(dest_folio);
 
 		btrfs_err(inode->root->fs_info,
 		"zlib decompression init failed, error %d root %llu inode %llu offset %llu",
 			  ret, btrfs_root_id(inode->root), btrfs_ino(inode),
-			  page_offset(dest_page));
+			  folio_pos(dest_folio));
 		return -EIO;
 	}
 
@@ -439,16 +439,16 @@ int zlib_decompress(struct list_head *ws, const u8 *data_in,
 	if (ret != Z_STREAM_END)
 		goto out;
 
-	memcpy_to_page(dest_page, dest_pgoff, workspace->buf, to_copy);
+	memcpy_to_folio(dest_folio, dest_pgoff, workspace->buf, to_copy);
 
 out:
 	if (unlikely(to_copy != destlen)) {
-		struct btrfs_inode *inode = BTRFS_I(dest_page->mapping->host);
+		struct btrfs_inode *inode = folio_to_inode(dest_folio);
 
 		btrfs_err(inode->root->fs_info,
 "zlib decompression failed, error %d root %llu inode %llu offset %llu decompressed %lu expected %zu",
 			  ret, btrfs_root_id(inode->root), btrfs_ino(inode),
-			  page_offset(dest_page), to_copy, destlen);
+			  folio_pos(dest_folio), to_copy, destlen);
 		ret = -EIO;
 	} else {
 		ret = 0;
@@ -457,7 +457,7 @@ int zlib_decompress(struct list_head *ws, const u8 *data_in,
 	zlib_inflateEnd(&workspace->strm);
 
 	if (unlikely(to_copy < destlen))
-		memzero_page(dest_page, dest_pgoff + to_copy, destlen - to_copy);
+		folio_zero_range(dest_folio, dest_pgoff + to_copy, destlen - to_copy);
 	return ret;
 }
 
-- 
2.34.1



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
