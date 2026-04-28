Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84913FF886D
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 28 Apr 2026 08:34:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-ID:Date:To:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4dugK+kos9cauDpyUUXvrjGPcPGWF1Cg1cujtKINmpQ=; b=Ah5nQ1i5wNq/J4oWNDshkPooZQ
	cJMQc2LW7SclnAVdhgjfdY5vhCwMaH+2nOh+6VzY4xKEJrbTeCZlCX9PrXcgx78yZo6RGCEkqbvcd
	AUfaBi7r+cGUxf9SFuTzXIfVSL+yUl1HC/BHwUv+9kK/jj687yfLERqQ6yLAZQJmHVZo=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wHdtj-00010y-7S;
	Tue, 28 Apr 2026 08:34:27 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <aalbersh@kernel.org>) id 1wHdth-00010g-Cp
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 28 Apr 2026 08:34:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=yoyh3UlA9TZ7k4TARLbtf9/vHDIlY0ClXxGrXy/3jMQ=; b=NvLsue5ysBRSbVjsxfjytreVVO
 wK0Q4jOPy/6skWx85Pg+86BrJGDT0X1CPYoE0XvuFLumtrIrb5ypAoaC65FRenE6mknh/hfExlp5d
 CBytKHqJoOaW5RIx288uZ7fi1J3w6hXqqccLHJZlSZUghCVQYQbINEJbvqPTSkv6P1n0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=yoyh3UlA9TZ7k4TARLbtf9/vHDIlY0ClXxGrXy/3jMQ=; b=f6BEIYTr+ukAuRSQ73BHLS/YbY
 9S0GP0WBk4XKbBJGW4Qqspl4IqdymQMkaOxv6Ct42dYLtcc8paQVpM0IBDCopHAW1aWNUzt9Zxuzx
 MrF5NNVgDI17ogLLB6n7ywQYxwKo9/PNdPl/uU9MN/9OwdRnOOLF8kSOqodAEBVyzjJk=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wHdtg-0004ew-L9 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 28 Apr 2026 08:34:25 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 0D0DB448A7;
 Tue, 28 Apr 2026 08:34:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D12BC2BCAF;
 Tue, 28 Apr 2026 08:34:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1777365258;
 bh=828QqygZ+rCpf7T6T6f7PIgnPBQ8F12tnt1TM4pNE9M=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=qztfHPJzo/MLQdDjtR16P6crBt5njgdIbw4lZkIi4A4rbK7rPdI6bbPhRtOk8XMs7
 nwSdlihXabb6DfDKVBtWKGLyMeAeXvyNcZPS3P/WyenIBq0BaIO/NrpH3/9WXFMhl4
 Eqq9CIBvEDRQ59svdzORlXj6Ot+0Y8mj6uVi6pA9MmDDEZAAbtaEDjx7NPMoCrX1b9
 SbW8YEVvvnWXEaz+oQvXVBws7a3xKkJs40PF3gs8OOVYkL9AA0VZHrQfFreVIk22Ew
 MLwkVUKXpmei9MV6a+ahHNAaT3OAGDeyw+8R4rm2LHFGvQOiC9f+iyLPIDJ5pGnpBg
 qDTUvucGlOuzQ==
To: linux-xfs@vger.kernel.org, fsverity@lists.linux.dev,
 linux-fsdevel@vger.kernel.org, ebiggers@kernel.org
Date: Tue, 28 Apr 2026 10:33:14 +0200
Message-ID: <20260428083332.768693-9-aalbersh@kernel.org>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20260428083332.768693-1-aalbersh@kernel.org>
References: <20260428083332.768693-1-aalbersh@kernel.org>
MIME-Version: 1.0
X-Headers-End: 1wHdtg-0004ew-L9
Subject: [f2fs-dev] [PATCH v9 08/22] iomap: teach iomap to read files with
 fsverity
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
From: Andrey Albershteyn via Linux-f2fs-devel
 <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Andrey Albershteyn <aalbersh@kernel.org>
Cc: Andrey Albershteyn <aalbersh@kernel.org>, djwong@kernel.org,
 linux-unionfs@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-ext4@vger.kernel.org, hch@lst.de, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Obtain fsverity info for folios with file data and fsverity metadata.
Filesystem can pass vi down to ioend and then to fsverity for
verification. This is different from other filesystems ext4, f2fs, btrfs
supporting fsverity, these filesystems don't need fsverity_info for
reading fsverity metadata. While reading merkle tree iomap requires
fsverity info to synthesize hashes for zeroed data block.

fsverity metadata has two kinds of holes - ones in merkle tree and one
after fsverity descriptor.

Merkle tree holes are blocks full of hashes of zeroed data blocks. These
are not stored on the disk but synthesized on the fly. This saves a bit
of space for sparse files. Due to this iomap also need to lookup
fsverity_info for folios with fsverity metadata. ->vi has a hash of the
zeroed data block which will be used to fill the merkle tree block.

The hole past descriptor is interpreted as end of metadata region. As we
don't have EOF here we use this hole as an indication that rest of the
folio is empty. This patch marks rest of the folio beyond fsverity
descriptor as uptodate.

For file data, fsverity needs to verify consistency of the whole file
against the root hash, hashes of holes are included in the merkle tree.
Verify them too.

Issue reading of fsverity merkle tree on the fsverity inodes. This way
metadata will be available at I/O completion time.

Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Andrey Albershteyn <aalbersh@kernel.org>
---
 fs/iomap/buffered-io.c | 41 +++++++++++++++++++++++++++++++++++++++--
 include/linux/iomap.h  |  2 ++
 2 files changed, 41 insertions(+), 2 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 38c9592fba43..843314852663 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -9,6 +9,7 @@
 #include <linux/swap.h>
 #include <linux/migrate.h>
 #include <linux/fserror.h>
+#include <linux/fsverity.h>
 #include "internal.h"
 #include "trace.h"
 
@@ -561,9 +562,27 @@ static int iomap_read_folio_iter(struct iomap_iter *iter,
 		if (plen == 0)
 			return 0;
 
-		/* zero post-eof blocks as the page may be mapped */
-		if (iomap_block_needs_zeroing(iter, pos)) {
+		/*
+		 * Handling of fsverity "holes". We hit this for two case:
+		 *   1. No need to go further, the hole after fsverity
+		 *	descriptor is the end of the fsverity metadata.
+		 *
+		 *   2. This folio contains merkle tree blocks which need to be
+		 *	synthesized. If we already have fsverity info (ctx->vi)
+		 *	synthesize these blocks.
+		 */
+		if ((iomap->flags & IOMAP_F_FSVERITY) &&
+		    iomap->type == IOMAP_HOLE) {
+			if (ctx->vi)
+				fsverity_fill_zerohash(folio, poff, plen,
+						       ctx->vi);
+			iomap_set_range_uptodate(folio, poff, plen);
+		} else if (iomap_block_needs_zeroing(iter, pos)) {
+			/* zero post-eof blocks as the page may be mapped */
 			folio_zero_range(folio, poff, plen);
+			if (ctx->vi &&
+			    !fsverity_verify_blocks(ctx->vi, folio, plen, poff))
+				return -EIO;
 			iomap_set_range_uptodate(folio, poff, plen);
 		} else {
 			if (!*bytes_submitted)
@@ -614,6 +633,15 @@ void iomap_read_folio(const struct iomap_ops *ops,
 
 	trace_iomap_readpage(iter.inode, 1);
 
+	/*
+	 * Fetch fsverity_info for both data and fsverity metadata, as iomap
+	 * needs zeroed hash for merkle tree block synthesis
+	 */
+	ctx->vi = fsverity_get_info(iter.inode);
+	if (ctx->vi && iter.pos < i_size_read(iter.inode))
+		fsverity_readahead(ctx->vi, folio->index,
+				   folio_nr_pages(folio));
+
 	while ((ret = iomap_iter(&iter, ops)) > 0)
 		iter.status = iomap_read_folio_iter(&iter, ctx,
 				&bytes_submitted);
@@ -681,6 +709,15 @@ void iomap_readahead(const struct iomap_ops *ops,
 
 	trace_iomap_readahead(rac->mapping->host, readahead_count(rac));
 
+	/*
+	 * Fetch fsverity_info for both data and fsverity metadata, as iomap
+	 * needs zeroed hash for merkle tree block synthesis
+	 */
+	ctx->vi = fsverity_get_info(iter.inode);
+	if (ctx->vi && iter.pos < i_size_read(iter.inode))
+		fsverity_readahead(ctx->vi, readahead_index(rac),
+				readahead_count(rac));
+
 	while (iomap_iter(&iter, ops) > 0)
 		iter.status = iomap_readahead_iter(&iter, ctx,
 					&cur_bytes_submitted);
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index 4506a99d5285..4d9202cae29f 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -435,6 +435,7 @@ struct iomap_ioend {
 	loff_t			io_offset;	/* offset in the file */
 	sector_t		io_sector;	/* start sector of ioend */
 	void			*io_private;	/* file system private data */
+	struct fsverity_info	*io_vi;		/* fsverity info */
 	struct bio		io_bio;		/* MUST BE LAST! */
 };
 
@@ -509,6 +510,7 @@ struct iomap_read_folio_ctx {
 	struct readahead_control *rac;
 	void			*read_ctx;
 	loff_t			read_ctx_file_offset;
+	struct fsverity_info	*vi;
 };
 
 struct iomap_read_ops {
-- 
2.51.2



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
