Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28523C55182
	for <linux-f2fs-devel@archiver.kernel.org>; Mon,  3 Aug 2026 20:09:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-ID:Date:To:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UDDZuYgugXW89fvBmS6w0sCP3mztP3VpfD71AIVpfVI=; b=IgaNc8oyVZMET2VmOQzoVrVSTp
	TyniqYMrEMb/JPnKPm0rErFdc6OYySv2Ifx9nG0QWe54tzApZikIwA1vg2vCpqP2j7EGrvUmi2yPk
	2WgPfdsV+orLEkKXv/tA9VtGb7qLSVIANVx16N/WLbu0ZVHizr6VKSVVIvmeFCSEr9fQ=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wqyyW-0004D5-Th;
	Mon, 03 Aug 2026 20:09:29 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <aalbersh@kernel.org>) id 1wqyyV-0004Cj-5q
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 03 Aug 2026 20:09:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=1i5PkmN5JfVODQHHHlqnvp3yzz22XTSFm/6ynxgAmcw=; b=Q0/qzOYF+5c9Idi5BUwERQx9sI
 OKmOWo3/hTaJAr1J/QcoFcHLv31iEqv5CZSfAxnUKTTKYYEuR3VwCHOFEiz+JZ4WI6oC/abutHpuN
 S9r1gC4GRY7i3SqK7tuNfyEE6bA0JQsEetO82EGCfcI2iPcl2h5YNwpVj4fbznMEoIdc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=1i5PkmN5JfVODQHHHlqnvp3yzz22XTSFm/6ynxgAmcw=; b=RvBhfI800x2N7rxAZy5TNucE/o
 WTn0GQaMOzWB/AeEar+EdeBT/a9TYNqVidFQtHp8/1VOuUZr+gPzGBPKeo/aAzGPiwDcZIQPRNCZw
 j0mELqIzalWP/wYLQtJhn3QZWXiHs3umxedu1Cy44JNUxagNAIAlkmdS+lQQ2pR1yOCQ=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wqyyY-0000vJ-Vc for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 03 Aug 2026 20:09:27 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 86987439D3;
 Mon,  3 Aug 2026 20:09:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D857C1F00A3E;
 Mon,  3 Aug 2026 20:09:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785787760;
 bh=1i5PkmN5JfVODQHHHlqnvp3yzz22XTSFm/6ynxgAmcw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=X9RcboruTw2IJHtaxvhR10PRk1ivwDxJxgwv0N+FSASdMBEoiY9rL9eHwfZjRCyyv
 XCSWXvwIHQRPvTl9ChdpPWuxi3x2M4LdSXGowQrRtaCtam9GKVfeg6pJ5ReoMtB7w0
 H3I4zcCN2Z+yLIPv/9gncxf6GWL0cdTqL8bgJ0ZppzGa5MqIR9eco+VGdoz/ZeoYK6
 Qphx9pdWt2eHMwaWKK78ODOc5OQhG53xHHsPoYrnhen5JWgdbM8g6gbMADxeG8pKYy
 OtjgViViXYtZGEKEBOc1PzRQL3NiOBscsTcbZg6IzwsDAMZ2qpOpQ7Ahgp9MFzZMcf
 aK0G+P1zuu2Gw==
To: linux-xfs@vger.kernel.org, fsverity@lists.linux.dev,
 linux-fsdevel@vger.kernel.org, ebiggers@kernel.org
Date: Mon,  3 Aug 2026 22:07:55 +0200
Message-ID: <20260803200820.393203-6-aalbersh@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260803200820.393203-1-aalbersh@kernel.org>
References: <20260803200820.393203-1-aalbersh@kernel.org>
MIME-Version: 1.0
X-Headers-End: 1wqyyY-0000vJ-Vc
Subject: [f2fs-dev] [PATCH v14 05/21] fsverity: improve flushing performance
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
flush whole folio on every digest (which is 128 for 4k) on the HIGHMEM
systems. Open code folio mapping and flushing to copy all digests at
once.

Reported-by: Eric Biggers <ebiggers@kernel.org>
Link: https://lore.kernel.org/linux-fsdevel/20260401222717.GH2466@quark/
Signed-off-by: Andrey Albershteyn <aalbersh@kernel.org>
---
 fs/verity/pagecache.c | 28 ++++++++++++++++++++++++++--
 1 file changed, 26 insertions(+), 2 deletions(-)

diff --git a/fs/verity/pagecache.c b/fs/verity/pagecache.c
index 9d82e6b74ba1..911207dc0ef7 100644
--- a/fs/verity/pagecache.c
+++ b/fs/verity/pagecache.c
@@ -68,14 +68,38 @@ EXPORT_SYMBOL_GPL(generic_readahead_merkle_tree);
 void fsverity_fill_zerohash(struct folio *folio, size_t offset, size_t len,
 			      struct fsverity_info *vi)
 {
-	size_t off = offset;
+	size_t off;
 
 	WARN_ON_ONCE(!IS_ALIGNED(offset, vi->tree_params.digest_size));
 	WARN_ON_ONCE(!IS_ALIGNED(len, vi->tree_params.digest_size));
+#ifdef CONFIG_HIGHMEM
+	WARN_ON_ONCE(offset + len > folio_size(folio));
 
-	for (; off < (offset + len); off += vi->tree_params.digest_size)
+	do {
+		void *vaddr = kmap_local_folio(folio, offset);
+		void *to = vaddr;
+
+		off = len;
+
+		if (folio_test_partial_kmap(folio) &&
+		    off > PAGE_SIZE - offset_in_page(offset))
+			off = PAGE_SIZE - offset_in_page(offset);
+		for (; to < (vaddr + off); to += vi->tree_params.digest_size)
+			memcpy(to, vi->tree_params.zero_digest,
+				vi->tree_params.digest_size);
+		kunmap_local(vaddr);
+
+		offset += off;
+		len -= off;
+	} while (len > 0);
+
+	flush_dcache_folio(folio);
+#else
+	for (off = offset; off < (offset + len);
+			off += vi->tree_params.digest_size)
 		memcpy_to_folio(folio, off, vi->tree_params.zero_digest,
 				vi->tree_params.digest_size);
+#endif
 }
 EXPORT_SYMBOL_GPL(fsverity_fill_zerohash);
 
-- 
2.54.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
