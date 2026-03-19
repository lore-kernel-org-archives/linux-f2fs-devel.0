Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 043961090257
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 19 Mar 2026 17:03:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-ID:Date:To:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5jofPfqLVTI0GpPF6a3DfbucqfnEcyxUyMHYvQP6oyE=; b=OFWBaivbKvHObhXt8a/9B0vLAt
	ZAljV4qFQT9kskrpzDYB/1C/BI1JlL8gv5jl3m+t98ZnHWQHlKZDb1MUj6o2fkrZJzxgPSsy/BQVg
	Iugmojyj8ejKv4OW0r+p8t1PhfMO+I3xTo+D/NTpZj4HB8UdVqycZN5cbqpS9WAHFSoo=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1w3GmE-0002Fr-Cv;
	Thu, 19 Mar 2026 17:03:18 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <aalbersh@kernel.org>) id 1w3GmD-0002Fi-EA
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 19 Mar 2026 17:03:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=7dFWEVsWI+F9WDe9EYASEbfBB41+EmG8etd3GTLl7FE=; b=YTiNXadV/zVAQdUzzlIPlPBVI9
 APIFqnhCMr5gTC6GhgPFixGRp5GSSQEBY1qBVW9JAf0x+CNvnZ0NNSH+0aHOO1Oy72viYM2OJ15/Y
 wbg04v1w/Ud5DRqHNJ243oBiWFVbYmVpHDkt/EN2gFayZs0mp+2q/ux7G4pwaftksX70=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=7dFWEVsWI+F9WDe9EYASEbfBB41+EmG8etd3GTLl7FE=; b=BoUNYGpNhvrKYJ/eYOFpsBqb8f
 Ks/j8EmfDjaSZhNezpgz4BOwlxSKfuYrlJE83Gb4hslIPV/grXrrhSQmcSzR+F1UM1uzno01w7OTz
 ID0p5djKCLbze8RgfrI+WHu/nvipUxzT2MTlkVsQZoaFkhkL+kzzjpqX8qFB7ob3jZjU=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1w3GmC-0005fB-U3 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 19 Mar 2026 17:03:17 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 9EDBD44582;
 Thu, 19 Mar 2026 17:03:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 589BEC2BCB4;
 Thu, 19 Mar 2026 17:03:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1773939786;
 bh=wb9TCQfS9dYD8aO/1WIxU3NagUd8em7TfZ/Z9g/HUGY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=R/kyijL01+bT7P78/nKKO81dWGtTBW5OQQAt/Za0V5MQ9TKeNlbXKMq3xamqhimSX
 q13IJcwJWRh1j8hv6bbOgIw6uEtq3KtdfmkSDLDUonYw8JzBNjNs/m6+5ki9GV4ATo
 GWYIYY5m7sQHhiF5OLYv/M2MsPkbVPpGpHAWEaUd3gvH9c4xuyh0gnCm79SvZP82mR
 mDh0i5EhkRES0mGIyIU7xFfewcl/fN6eM6tnTVeTCM0cRYLA6bjtbKhSfCzcaM1EBK
 ZAN5VDW2z39tFtqlta/UOkzQx4XaAbOy49DPQSZI31eAvOYCXNKR3LVoiHfdT2Qnr/
 drN9FLFdrrBrA==
To: linux-xfs@vger.kernel.org, fsverity@lists.linux.dev,
 linux-fsdevel@vger.kernel.org, ebiggers@kernel.org
Date: Thu, 19 Mar 2026 18:01:57 +0100
Message-ID: <20260319170231.1455553-11-aalbersh@kernel.org>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20260319170231.1455553-1-aalbersh@kernel.org>
References: <20260319170231.1455553-1-aalbersh@kernel.org>
MIME-Version: 1.0
X-Headers-End: 1w3GmC-0005fB-U3
Subject: [f2fs-dev] [PATCH v5 10/25] iomap: teach iomap to handle fsverity
 holes and verify data holes
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
 linux-f2fs-devel@lists.sourceforge.net, linux-ext4@vger.kernel.org, hch@lst.de,
 linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

fsverity metadata has two kinds of holes - ones in merkle tree and one
after fsverity descriptor.

Merkle tree holes are blocks full of hashes of zeroed data blocks. These
are not stored on the disk but synthesized on the fly. This saves a bit
of space for sparse files. Due to this iomap also need to lookup
fsverity_info for folios with fsverity metadata. ->vi has a hash of the
zeroed data block which will be used to fill the merkle tree block. This
patch extends lookup of fsverity_info from just for file data but also
for all fsverity metadata.

The hole past descriptor is interpreted as end of metadata region. As we
don't have EOF here we use this hole as an indication that rest of the
folio is empty. This patch marks rest of the folio beyond fsverity
descriptor as uptodate.

For file data, fsverity needs to verify consistency of the whole file
against the root hash, hashes of holes are included in the merkle tree.
Verify them too.

Signed-off-by: Andrey Albershteyn <aalbersh@kernel.org>
---
 fs/iomap/buffered-io.c | 40 ++++++++++++++++++++++++++++++++--------
 1 file changed, 32 insertions(+), 8 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index a11e54975df8..fce748dfb2cf 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -551,9 +551,27 @@ static int iomap_read_folio_iter(struct iomap_iter *iter,
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
+				fsverity_folio_zero_hash(folio, poff, plen,
+							 ctx->vi);
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
@@ -600,9 +618,12 @@ void iomap_read_folio(const struct iomap_ops *ops,
 
 	trace_iomap_readpage(iter.inode, 1);
 
-	if (iter.pos < i_size_read(iter.inode))
-		ctx->vi = fsverity_get_info(iter.inode);
-	if (ctx->vi)
+	/*
+	 * Fetch fsverity_info for both data and fsverity metadata, as iomap
+	 * needs zeroed hash for merkle tree block synthesis
+	 */
+	ctx->vi = fsverity_get_info(iter.inode);
+	if (ctx->vi && iter.pos < i_size_read(iter.inode))
 		fsverity_readahead(ctx->vi, folio->index,
 				   folio_nr_pages(folio));
 
@@ -673,9 +694,12 @@ void iomap_readahead(const struct iomap_ops *ops,
 
 	trace_iomap_readahead(rac->mapping->host, readahead_count(rac));
 
-	if (iter.pos < i_size_read(iter.inode))
-		ctx->vi = fsverity_get_info(iter.inode);
-	if (ctx->vi)
+	/*
+	 * Fetch fsverity_info for both data and fsverity metadata, as iomap
+	 * needs zeroed hash for merkle tree block synthesis
+	 */
+	ctx->vi = fsverity_get_info(iter.inode);
+	if (ctx->vi && iter.pos < i_size_read(iter.inode))
 		fsverity_readahead(ctx->vi, readahead_index(rac),
 				readahead_count(rac));
 
-- 
2.51.2



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
