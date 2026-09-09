Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89593C79FB9
	for <linux-f2fs-devel@archiver.kernel.org>; Wed,  9 Sep 2026 01:37:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-ID:Date:To:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pGEa/ck9Uuyfj3pXgIdCFMyt9oexyfmgBa+Wa91ihHY=; b=aAePjjweB7qQBUtU0V1i81RqSS
	Rgyuh2YBGgPfCINuKSWO05uCDRQ9FzJlrr3GqHtySdK6mn4BAVHlqdVdWkSHop4Gnbe1zj4bEGBRh
	pBCAda7PV/yKdDynv7MQ0xyfwbkTNZp+VNisUC0w0cVrw/8EtvGTftJ1mht1nDo8wCzw=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1x47FF-0002sm-DI;
	Wed, 09 Sep 2026 01:37:02 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1x47FD-0002rY-RE
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 09 Sep 2026 01:37:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=WGq8Em2086hbB+4h/5zhCJsDKNyBfoGes5sm4/+vj8k=; b=MVifoNOv++Hpmf6m9iz/OcmbF4
 jwyEomqiycFyG59YC0a1RBVjXjWyPtkczGFpDTlPb3Lnof3zPb/ywYBBFM1fUQ5Njs5eUhU3JTAqq
 Z3+x2N3geJ8y7t8R50QIjBrwvCSJrbEJj2FlLDyGh9v+1o+ce6ymKkgznZYSBfjjDDVs=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=WGq8Em2086hbB+4h/5zhCJsDKNyBfoGes5sm4/+vj8k=; b=kiOuDqPrQ/ciSKzzhtf40kP5XH
 NYUlO+gVd+ATILqP8L9p6LdEloTNiEgLbEK3kRy7uiTCYHcVgQGi5jS/M8N6TUJ7KNm9PfoyqKupC
 Yl8yJMDBAJjQCenLB9eE/jNzAiHnOSnseTH0Xg+tXMBR2bgyiSMHJ4yihBgbACVIftmQ=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1x47F3-0000XS-CJ for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 09 Sep 2026 01:36:49 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id CE6AC601FB
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed,  9 Sep 2026 01:36:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1CCD1F00A3D;
 Wed,  9 Sep 2026 01:36:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788917803;
 bh=WGq8Em2086hbB+4h/5zhCJsDKNyBfoGes5sm4/+vj8k=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=oL92ufMNFbHRxrjb2gs4Xop+snVaNGk5XREsb80RlQQMcCi4KRbjHqTc0SOngEXkI
 g99fdCO0AJWY13JKQ3+gCcoPIcuTvEPRN6XTDP2d53PldVUmT4lHYMHrYWLWKzvn3Q
 KXKW8KGiuqDCHl2HX981CTSRelGJYdIwPgLRF26Iht+fndDoBGbpYZ4WYw1swwhYTz
 zaks08siWO0Y7lZkD3Nx54Mvm7rT+dQ7MLJd8m9YfacAcwlCTw67WKJ1ouctqjr53t
 IwGzLgM65m79xuD0ZqZaQpOLKC2tcmEtOxIgM8vMbDmr9tldTLu7mWGnAZi4tTo696
 WglTq1IND45IA==
To: jaegeuk@kernel.org
Date: Wed,  9 Sep 2026 09:36:09 +0800
Message-ID: <20260909013611.3418568-11-chao@kernel.org>
X-Mailer: git-send-email 2.55.0.979.g7e5102b832-goog
In-Reply-To: <20260909013611.3418568-1-chao@kernel.org>
References: <20260909013611.3418568-1-chao@kernel.org>
MIME-Version: 1.0
X-Headers-End: 1x47F3-0000XS-CJ
Subject: [f2fs-dev] [PATCH v6 10/12] f2fs: cache: support fault injection
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

From: Chao Yu <chao@kernel.org>

This patch adds fault injection support for metadata cache allocations
to improve error-path test coverage.
- it integrates entry allocations with FAULT_KALLOC

Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/cache.c | 24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/fs/f2fs/cache.c b/fs/f2fs/cache.c
index e52e73d76700..01047528c21a 100644
--- a/fs/f2fs/cache.c
+++ b/fs/f2fs/cache.c
@@ -154,23 +154,27 @@ static struct f2fs_cached_block *f2fs_create_cache(
 		struct f2fs_cached_block_list *cache,
 		unsigned long index, bool nofail)
 {
+	struct f2fs_sb_info *sbi = cache->sbi;
 	struct f2fs_cached_block *entry;
 	unsigned int flags = GFP_NOFS;
 
 	if (index == ULONG_MAX)
 		return ERR_PTR(-ERANGE);
 
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
