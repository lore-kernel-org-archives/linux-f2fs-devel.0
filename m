Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90E32C5DF8B
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 20 Aug 2026 03:18:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-ID:Date:To:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=U2ECZ8MRmg7A3rqDfn3c5DqK0du1c7Qraap5EBofKcM=; b=ku9wIeI+t+Mk2GW69GyYO0u/Kj
	Q9QqBUhGZPiCqrrJ1JpqhiJN4NKWHNbmRACyCqPHgab5ApWs9XGcwjyf18IUNyIka1Kd3cTOcjFuO
	eaHotz1vKKehmLAavEUxbLZ8tpfvTawr2w03vU3HTU4D2RqTorGyiqoJ9ZcFGCgpbnrM=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wwtIE-0000Nh-6g;
	Thu, 20 Aug 2026 03:18:14 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1wwtHm-0000Mm-77
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 20 Aug 2026 03:17:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=oTqEd0voYGtT537IzPkiJFfZHAD1HJt51CGNpbeKdN4=; b=LfrkrE4HNXZzPgHLWxcOXCIrO0
 1H3FteVNpAn7C2MJ/QF+5z+N2tarDP+4iHPraDL9eZ+ZOC4+oJHTfYdZJ3a2FmDfVohmCK8m/v1AV
 tln4rhxl84rhwuIJKcX3OfbQI/WxPpdgILUor4bvraGthmPOF6tq8L598NDAQY/SiI/g=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=oTqEd0voYGtT537IzPkiJFfZHAD1HJt51CGNpbeKdN4=; b=AV2zUgJjssBjXBJmB9JKjEeFX5
 SK8V+sF3Oh/NJbT3TtIB5X9DJ5fiTawajTh8B3lxf1sU0udGjVHiXXN7/akXNQxoILD6Fl+cBR15p
 gkl96LDTOwvvXEFWQQdp/HsSivSngPLssxry1HexIsBgJDYbdvKOM45vntco/hcIDQyw=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wwtHk-0000xZ-St for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 20 Aug 2026 03:17:46 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 9807340441
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu, 20 Aug 2026 03:17:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6A891F00AC4;
 Thu, 20 Aug 2026 03:17:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787195859;
 bh=oTqEd0voYGtT537IzPkiJFfZHAD1HJt51CGNpbeKdN4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=NagxIGbrtBC/whT6VatfwuM4FXpXHgah3pR8/26tT6Iqek5SPo/yf+z2Fsu5imu3l
 sNI1iJ7++gfqeLF1jiDvb+IZIm7XzeubUIBQP1blDiOvoG6VmkC5i8x6mMeqfa6aLx
 xVbDzcDxPuCC7Gdfmp10oSOybIC7jo0E90o2TVC9mEm/UiBNfX/v5BKDdvnrXujnwN
 bx4SMfquAhNxiSoLvhfIn8Mw8VKfq1ej9FT41VwSHKhx8hX7D9PRIA7dfyXBxIOhyI
 /tgy2a9VU3M02nTNsHW2VN8Z5UwIRPAkscpTfOvIUms8uvn8htmxNIWjJrha4q7ZHM
 kpvOBrSLIdl0A==
To: jaegeuk@kernel.org
Date: Thu, 20 Aug 2026 11:17:19 +0800
Message-ID: <20260820031721.12218-11-chao@kernel.org>
X-Mailer: git-send-email 2.55.0.737.g08866a6d13-goog
In-Reply-To: <20260820031721.12218-1-chao@kernel.org>
References: <20260820031721.12218-1-chao@kernel.org>
MIME-Version: 1.0
X-Headers-End: 1wwtHk-0000xZ-St
Subject: [f2fs-dev] [PATCH v1 10/12] f2fs: cache: support fault injection
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
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

This patch adds fault injection support for metadata cache allocations
to improve error-path test coverage.
- it integrates entry allocations with FAULT_KALLOC

Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/cache.c | 24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/fs/f2fs/cache.c b/fs/f2fs/cache.c
index 173bbf3aa94c..c1e5c945391f 100644
--- a/fs/f2fs/cache.c
+++ b/fs/f2fs/cache.c
@@ -175,20 +175,24 @@ static struct f2fs_cached_block *f2fs_create_cache(
 		struct f2fs_cached_block_list *cache,
 		unsigned long index, bool nofail)
 {
+	struct f2fs_sb_info *sbi = cache->sbi;
 	struct f2fs_cached_block *entry;
 	unsigned int flags = GFP_NOFS;
 
-	if (nofail)
+	if (nofail) {
 		flags |= __GFP_NOFAIL;
-
-	entry = kzalloc_obj(*entry, flags);
-	if (!entry)
-		return ERR_PTR(-ENOMEM);
-
-	entry->data = kzalloc(cache->sbi->blocksize, flags);
-	if (!entry->data) {
-		kfree(entry);
-		return ERR_PTR(-ENOMEM);
+		entry = kzalloc_obj(*entry, flags);
+		entry->data = kzalloc(sbi->blocksize, flags);
+	} else {
+		entry = f2fs_kzalloc(sbi, sizeof(*entry), flags);
+		if (!entry)
+			return ERR_PTR(-ENOMEM);
+
+		entry->data = f2fs_kzalloc(sbi, sbi->blocksize, flags);
+		if (!entry->data) {
+			kfree(entry);
+			return ERR_PTR(-ENOMEM);
+		}
 	}
 
 	entry->index = index;
-- 
2.49.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
