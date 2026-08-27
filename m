Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF20FC61DD3
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 27 Aug 2026 12:26:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-ID:Date:To:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=d0N1W8IpJMLRjK4lfSxVfW4her3DEQniJ8xTDueOCAc=; b=YiPByC5INX+H2GVgj2p1zwdKAx
	2U59i+WPFQPv3eSx6JRve2Ss1AyUARxqmTlrxFnoxLN5eRbYRcchNd177UptuLPEdRrX7A2BzmRqD
	Og7QRskcdU1/nRRfNiowQAR3ah7QrkX6znKZbdkL6W9BaX2AIAef7+4pv46SPgx0u6xQ=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wzZBM-0003xm-UO;
	Thu, 27 Aug 2026 12:26:12 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1wzZBJ-0003xB-TT
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 27 Aug 2026 12:26:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Ne8r8t10oFzf7ekM8lvrFV9qzNHGrX+xn9Nrur3onVU=; b=kKCIq5h6iwb5nFnviNSmAqEfdW
 jn5XgEgdI+VaLq7gpZWutcGcYRxtrf4Lp8I59xeOtZPuZ/OPu8Rj36sxMMVaEVywq4l7dR5njHFOB
 VKl9m6snABzRFIi17p+0brbGrRzMpYbVepq2gCeOIro6kizjyP7+a2EjHC/MDY3m8VHk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=Ne8r8t10oFzf7ekM8lvrFV9qzNHGrX+xn9Nrur3onVU=; b=eHciJnjR8bb3cwXKNrjQphyveg
 fVE9bWblcIyqu9o+aiGPtf12lncZ/96owvHV+79ROgmNdga5NSsUroKzbUULU+njbb+vu/0zdoIb7
 nw/6YAVYmoMSbcAHpYJ4hLuHMZh7uSt3A5co/3bTan6U6O6lDm5p1F8pRQcfBfNoblsI=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wzZBH-0006Dn-2E for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 27 Aug 2026 12:26:09 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id B5B3842DF7
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu, 27 Aug 2026 12:26:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B70BF1F00AC4;
 Thu, 27 Aug 2026 12:26:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787833561;
 bh=Ne8r8t10oFzf7ekM8lvrFV9qzNHGrX+xn9Nrur3onVU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=Kw1gFfS68+nEwIlMvu9/lOMKf+4u95cJg9Iw74C7sGr2z2ZRoEOLWJjyZj6fS8w0G
 RZ537bSpBR+M0LAaCcp+jq7dPkZhtd0dCWNASXQQTeS47htitkVeE16Nm6gMoX4xrM
 gIoI4vaNxvBqkx0z3bYZsLoHlo+Acegqor9mLQWOlDuUKccPCniCFIheM1IG1BA9lE
 iRkF3eNiH+EwrDLIgLnSpOmII3hPE1Y4EnV+AfMCIym4kBU5m4BWVfqdsAANIB+/jB
 YXaMHjI8d0oA/jA35s/wjizIUkv41aKt7hiQSuEiW7cStID2S6n9fTjzcqArgGnuvx
 kMT5FAcm3yH/w==
To: jaegeuk@kernel.org
Date: Thu, 27 Aug 2026 20:25:38 +0800
Message-ID: <20260827122541.19967-11-chao@kernel.org>
X-Mailer: git-send-email 2.55.0.887.g758fc8c411-goog
In-Reply-To: <20260827122541.19967-1-chao@kernel.org>
References: <20260827122541.19967-1-chao@kernel.org>
MIME-Version: 1.0
X-Headers-End: 1wzZBH-0006Dn-2E
Subject: [f2fs-dev] [PATCH v4 10/12] f2fs: cache: support fault injection
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
index 058e62c44152..2a98479bb3db 100644
--- a/fs/f2fs/cache.c
+++ b/fs/f2fs/cache.c
@@ -176,23 +176,27 @@ static struct f2fs_cached_block *f2fs_create_cache(
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
