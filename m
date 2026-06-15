Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B1DCCD98C5
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 15 Jun 2026 13:08:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-ID:Date:To:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ReKnyWE0ggxjxTH2oWx4r/EOkWekXQhjKn7woBdl5KY=; b=UYX3SNZ+wLbBI4jgIg/K4C4aKd
	xpw+t4N4dd4qfAWisT+BJf6KyNjcGPY7hXntGHHuoiwX4u172KWXDd8AKpe4O66glajF3/7OKNQBU
	Khm0O/Asju12jqYA3LkX4J+yOeTiTw7FDtQt0NG9+Wyi/edMdLIRUvn5bzPg4pM7E3s0=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wZ73a-000661-3j;
	Mon, 15 Jun 2026 13:08:50 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1wZ73Y-00065v-PJ
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 15 Jun 2026 13:08:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=BsOCO8tlYY+K7uhKJ8DFhE469zC8yPfobELaUTKwtoc=; b=NwPVkbfR9AEHePlK+lAPmAzfWx
 3gg7qYLUojdgR5qEvMHMXbVyfO91hu7ig1klK9zvpra1ZFS+hayKMfGMa/s4i5cYhmTytcjF90N1n
 7+raxT9dBKIHWP+3ITuJJqF64SsaXY7p+7FFvPmKe8/YPtsP0EGhHnqSPeIA/PWSjPX8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=BsOCO8tlYY+K7uhKJ8DFhE469zC8yPfobELaUTKwtoc=; b=DoAMvMhEv10rKKKm7/6FOBMqgv
 WE0xC7NeOh5B3eyjjFuVEhdTllvSpdA2bGTWPvZTfd+m13l+nuo8fHqRxYw5oY3W62T7Ri8R3BVpY
 6WhrEPoJJqmdmY41vnjSzNMpD3PAVd7y3ftOWmR6YZmTtzUjVhnTGHl6182NwcTvfdVw=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wZ73X-0005xZ-T9 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 15 Jun 2026 13:08:48 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 21564445A5;
 Mon, 15 Jun 2026 13:08:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A73D61F00A3A;
 Mon, 15 Jun 2026 13:08:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781528918;
 bh=BsOCO8tlYY+K7uhKJ8DFhE469zC8yPfobELaUTKwtoc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=VikDKPeQ7SwVhZ36wTNJyXF4k+84Al8mJYFQ1JRkO1k1oRwARt3gq3/YdE2OcEaw3
 SAWDHk2S0SX9VMAkkRPHZGZSgvsNhn+xM1ZUhpaN1IiAdTY1+p5szTPDBXrO1QOxNi
 cYVw5rA5rNc1Yc7LvSd0z3CsvjzJYuze073RlA/O+xcYU3eSzs9EF8tOrc8vpj1gMU
 8czcVag9ge5RHOSrlAgjkbiIKWtAnwb0FGpO7LHtOnKm6Sn9TM+CmWJXxBtc+3eu6J
 tqSaoSk/L2PiIzKp4qcGzm+rB0MyUnzLDggtHxIIFAVc4hu+EjLEMtLMI5Pt4LGe7P
 ahdPiceWs6PbQ==
To: jaegeuk@kernel.org
Date: Mon, 15 Jun 2026 21:08:21 +0800
Message-ID: <20260615130822.2576088-5-chao@kernel.org>
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
In-Reply-To: <20260615130822.2576088-1-chao@kernel.org>
References: <20260615130822.2576088-1-chao@kernel.org>
MIME-Version: 1.0
X-Headers-End: 1wZ73X-0005xZ-T9
Subject: [f2fs-dev] [PATCH 5/6] f2fs: use fscrypt_finalize_bounce_page() for
 cleanup
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
From: Chao Yu via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Chao Yu <chao@kernel.org>
Cc: Eric Biggers <ebiggers@kernel.org>, linux-kernel@vger.kernel.org,
 Matthew Wilcox <willy@infradead.org>, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

No logic changes.

Cc: Matthew Wilcox <willy@infradead.org>
Cc: Eric Biggers <ebiggers@kernel.org>
Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/data.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 9c6440a7db0e..02d498d549b0 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -358,14 +358,11 @@ static void f2fs_write_end_io(struct bio *bio)
 
 	bio_for_each_folio_all(fi, bio) {
 		struct folio *folio = fi.folio;
+		struct page *page = &folio->page;
 		enum count_type type;
 
-		if (fscrypt_is_bounce_folio(folio)) {
-			struct folio *io_folio = folio;
-
-			folio = fscrypt_pagecache_folio(io_folio);
-			fscrypt_free_bounce_page(&io_folio->page);
-		}
+		fscrypt_finalize_bounce_page(&page);
+		folio = page_folio(page);
 
 #ifdef CONFIG_F2FS_FS_COMPRESSION
 		if (f2fs_is_compressed_page(folio)) {
-- 
2.49.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
