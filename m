Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F603C4451C
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 21 Jul 2026 18:44:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-ID:Date:To:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2+JK9DpORubPjZJOtSVORn8ItFccgbvKEdXOQEk7pT8=; b=JAd5wFDhigaua5N3kONHJM4DN+
	m5u8fAP7gDCQEn4ykacjfwNMaqs75QltX4wJudodyrXtoaTSxzrFWyPmrnfvWG7sfpwVyCj0jKAPl
	Z8gsXPDSGWnkvppt5veoqKs8tVDXTJ79VCQd1IL/v14+kuPoR5vn/RwJXgwH9/CPVq5I=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wmFS6-0001cs-0j;
	Tue, 21 Jul 2026 18:44:26 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <aalbersh@kernel.org>) id 1wmFS3-0001cR-LD
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 21 Jul 2026 18:44:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=o9yINbcuiiybi8O3LP5dR8y/qvFNadlQFmrpMBfoyMQ=; b=G/l0sWyafuuKnpI7ZuN6CoKBsy
 KrAq/FjWgHuas47Ao49rvFBiazCXH8oyN4xaz1U0oJBKeLoAsBb39bE4WrGirnSu4VolajQ/kVx3g
 8yTZRnAzYw/ZNPfrH6n5qPt8WC5L40sYMZdxrKQ9A1WlWOQ3+rR/Xf1jheneUN8BbG50=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=o9yINbcuiiybi8O3LP5dR8y/qvFNadlQFmrpMBfoyMQ=; b=BdTtYxkOMeAIr8wqiWw+MkfY+3
 wNxHl5zlWJOAg73Vpz+y2okxdWKrjrR1kHCqkb8TLSPvgKDKL2+nbk6AjRRekdvzm/8p5g67PoRil
 kV2hWkHS5SYr1yQMpuHgAEbZnbRR9vm0BARJiwtJn8JRk8LaLnAs5WyAKrd2c4924Ccs=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wmFS0-00030a-Ks for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 21 Jul 2026 18:44:24 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 1722960A67;
 Tue, 21 Jul 2026 18:44:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DCC41F00A3E;
 Tue, 21 Jul 2026 18:44:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784659449;
 bh=o9yINbcuiiybi8O3LP5dR8y/qvFNadlQFmrpMBfoyMQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=fSj+A8thaY94a8iuY+JDh+LoPKx340k86jg2tC+sJdB9HB9863X+QFL5nXUfXml2Z
 p3JIakyKGoM3haTusZHHQr90T+wyK1MR7X2gbsHGCyMESLR84Ut+qxSS1sNoK2UXTp
 I+HWQQXNgWit/unYoPC8QULB6r5U6JSTvcQaZ3vrUj0GjXQthZibLIwiPo2Vqe4yzR
 CyssNBI3NXux+D+YuoyqTlD4gwRwT+dCErBJgjUSTT4FVkgn8YTKn+4wUtS3xknJAK
 A7RSwviYa+KEMa1e3InWJ6oyUavFQnNwq6aaxqpT4QPzUP91QUUyoYyzh5tj6ZVl4+
 JhDXlFF3J07zw==
To: linux-xfs@vger.kernel.org, fsverity@lists.linux.dev,
 linux-fsdevel@vger.kernel.org, ebiggers@kernel.org
Date: Tue, 21 Jul 2026 20:40:42 +0200
Message-ID: <20260721184346.416657-6-aalbersh@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260721184346.416657-1-aalbersh@kernel.org>
References: <20260721184346.416657-1-aalbersh@kernel.org>
MIME-Version: 1.0
X-Headers-End: 1wmFS0-00030a-Ks
Subject: [f2fs-dev] [PATCH v13 05/23] fsverity: improve flushing performance
 of fsverity_fill_zerohash
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

The current version calls flush_dcache_folio(), in memcpy_to_folio(), to
flush whole folio on every digest (which is 128 for 4k). Open code folio
mapping and flushing to copy all digests at once.

Reported-by: Eric Biggers <ebiggers@kernel.org>
Link: https://lore.kernel.org/linux-fsdevel/20260401222717.GH2466@quark/
Signed-off-by: Andrey Albershteyn <aalbersh@kernel.org>
---
 fs/verity/pagecache.c | 24 +++++++++++++++++++++---
 1 file changed, 21 insertions(+), 3 deletions(-)

diff --git a/fs/verity/pagecache.c b/fs/verity/pagecache.c
index 9d82e6b74ba1..270abd652e48 100644
--- a/fs/verity/pagecache.c
+++ b/fs/verity/pagecache.c
@@ -68,14 +68,32 @@ EXPORT_SYMBOL_GPL(generic_readahead_merkle_tree);
 void fsverity_fill_zerohash(struct folio *folio, size_t offset, size_t len,
 			      struct fsverity_info *vi)
 {
-	size_t off = offset;
+	void *vaddr;
+	void *to;
+	size_t chunk;
 
 	WARN_ON_ONCE(!IS_ALIGNED(offset, vi->tree_params.digest_size));
 	WARN_ON_ONCE(!IS_ALIGNED(len, vi->tree_params.digest_size));
+	WARN_ON_ONCE(offset + len > folio_size(folio));
 
-	for (; off < (offset + len); off += vi->tree_params.digest_size)
-		memcpy_to_folio(folio, off, vi->tree_params.zero_digest,
+	do {
+		vaddr = kmap_local_folio(folio, offset);
+		chunk = len;
+		to = vaddr;
+
+		if (folio_test_partial_kmap(folio) &&
+		    chunk > PAGE_SIZE - offset_in_page(offset))
+			chunk = PAGE_SIZE - offset_in_page(offset);
+		for (; to < (vaddr + chunk); to += vi->tree_params.digest_size)
+			memcpy(to, vi->tree_params.zero_digest,
 				vi->tree_params.digest_size);
+		kunmap_local(vaddr);
+
+		offset += chunk;
+		len -= chunk;
+	} while (len > 0);
+
+	flush_dcache_folio(folio);
 }
 EXPORT_SYMBOL_GPL(fsverity_fill_zerohash);
 
-- 
2.54.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
