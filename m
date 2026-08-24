Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0EBCC5DF81
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 24 Aug 2026 13:48:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-ID:Date:To:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=e062LVMET3HkTf9TJ0GPdBLANKggxxii1dlBo18+Sns=; b=R/fipIuItZAurMbRMl20Gdxtzr
	HVMn0GLEGcwoI5Hj5D20uBoLyPfq+LE3d5o4vFbi4qFPIY3eeFO8hK9vE8xYOkPs3GOeQv6Y1/6mE
	Uu8+/Qyzc1MpxwXxZF2ksDIh7p1/XZj+mUYil430ISVEmJIJDBI5POE3uT1hpAE35itU=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wyV22-0004zg-66;
	Mon, 24 Aug 2026 13:48:07 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1wyV1y-0004zQ-NJ
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 24 Aug 2026 13:48:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=AuBQ7SzUhmbIpKh6rJqhmzk4+eaWZE2juoVfuGuipNM=; b=ml/tmd0YLPdVEQiXbmdJWmC4qH
 3jS2BeZk3ODhDl/+EwH8YU+UJH5tqoNfTt+0pSqLhkZY5fXHsw+WtuW4dc3bZRSeHpP4NNw9sPKkw
 wCBzNZod1hSghAm8o7ZF2vLewUR9oshfqlZod3TfDsp5pr0R+muCux7JLpV1v6W7+tpE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=AuBQ7SzUhmbIpKh6rJqhmzk4+eaWZE2juoVfuGuipNM=; b=lPEk223EzGWfM1Hk6SP8IjmcJc
 YZVd0D27AHA+56cTCEwzrvduYITvBatZw03euDnU0zv0BUZ0EVOluLKzWvQb8yrUfz+alGZFJ4opX
 Ht6F0GVQqFUo5XoXZOEdTp5numqjjNhm/Mup3Zd1fOjnp019bfnYxCpyUOd9BLHUfRts=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wyV1v-0003S5-OB for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 24 Aug 2026 13:48:04 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 3741A60A5D
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 24 Aug 2026 13:47:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA1EB1F00A3E;
 Mon, 24 Aug 2026 13:47:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787579277;
 bh=AuBQ7SzUhmbIpKh6rJqhmzk4+eaWZE2juoVfuGuipNM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=NRyb33YFulkboG+pVU6wkOECYWEm8g6wPsXhWujBiLnmyWb4b5yBztj5UGWOrxzuN
 JFEzTQog2rcDPWp/ovu+se3n1LnxDFCXZfWWQ07J5dXN+wZAs4wmWulaz9Ump6KID5
 3p8RbhXaE++/QhR0Gg/7+GstqI/iSlErDAM6/U3u8YSD4uRUNsULx81GFzfUqwQwXI
 LoIG3x1YparSLpQjHmv8YFIT4jmDMOrgjgdCH30ptk7Ho8nTuJoRRdWeaVaftoknME
 4vuGBdIDHGNsJvis39H/v7SALEaVhzcFaTQPCITXpUj/x8MvLug9nUxL6Wlhcb9hEk
 y3an1yuHNdO3Q==
To: jaegeuk@kernel.org
Date: Mon, 24 Aug 2026 21:47:29 +0800
Message-ID: <20260824134731.3704352-11-chao@kernel.org>
X-Mailer: git-send-email 2.55.0.766.g2966f0265a-goog
In-Reply-To: <20260824134731.3704352-1-chao@kernel.org>
References: <20260824134731.3704352-1-chao@kernel.org>
MIME-Version: 1.0
X-Headers-End: 1wyV1v-0003S5-OB
Subject: [f2fs-dev] [PATCH v2 10/12] f2fs: cache: support fault injection
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
index 77b40a98380c..9a9d62283ae0 100644
--- a/fs/f2fs/cache.c
+++ b/fs/f2fs/cache.c
@@ -176,20 +176,24 @@ static struct f2fs_cached_block *f2fs_create_cache(
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
-	entry->data = kmalloc(cache->sbi->blocksize, flags);
-	if (!entry->data) {
-		kfree(entry);
-		return ERR_PTR(-ENOMEM);
+		entry = kzalloc_obj(*entry, flags);
+		entry->data = kmalloc(sbi->blocksize, flags);
+	} else {
+		entry = f2fs_kzalloc(sbi, sizeof(*entry), flags);
+		if (!entry)
+			return ERR_PTR(-ENOMEM);
+
+		entry->data = f2fs_kmalloc(sbi, sbi->blocksize, flags);
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
