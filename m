Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63E76C61DBE
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 25 Aug 2026 13:02:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-ID:Date:To:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vc4blVkNKK1BDfZYg4u9rl4xuRRShHdrqZzojw1jmrw=; b=FG9jbc/PaTC0n2xHg3C4Ke+NY5
	TQDoaiZ22SFx9soiELz0jrfRRI/evqwi8Xt5Hm+vsCEJbwVomRdN+BQuNobb1pTWqfvhO/Rs+CPSE
	N6UX35jK6rDMnUx8F0nFUvS3mL0vBuDlw3xR2bi2Z2y70STINCS6U5hqlmBe1eIZstnY=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wyqn4-0002jq-BW;
	Tue, 25 Aug 2026 13:02:11 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1wyqn3-0002jY-0E
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 25 Aug 2026 13:02:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=woi8uMQ7S42OB583LusLSO/YvHwGV7JGGq/jwY/otO4=; b=O2k8rshkzYs1qYAyGD/1nXVYXH
 zWUx9/lRqesoPr8zxJIsBsTjO/PA0BO3iJGuhh/RjwX2LDbUSpN5ZyrlRBXCF/IcZFYqZynEVZve1
 dV1KwXt47sKV4XeHadGdVCCYOLb3RJ9ak8WUUmJHvRUzd3uO5VqcC6PeXDGrpaQ4OWxI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=woi8uMQ7S42OB583LusLSO/YvHwGV7JGGq/jwY/otO4=; b=LyFKTpdxih6XIG5wlbO4rFYOYB
 x/cj5M/xvZb9LBaja07IYTCrDZ2U/TtlPbAP3sgg04XjNiQeOwNXxfL8ldUygK7TcusfjFIv+at7L
 K3cBBN8Zt85PdZsVZxEJOLt/9jpNRDYY719IlavMPxMCYbcGm6caBGfSSP77sYynDmI8=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wyqn0-0005m9-5d for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 25 Aug 2026 13:02:09 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 9FE9860A5D
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 25 Aug 2026 13:02:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74C9B1F00A3A;
 Tue, 25 Aug 2026 13:01:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787662920;
 bh=woi8uMQ7S42OB583LusLSO/YvHwGV7JGGq/jwY/otO4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=BZ2niHR7tNqstR5qOh/xtKAi8jrturxm7wso4l+A2WKXDpAXjpTSrEIMbJQQq3IkO
 6ZMM1iZxXmTG3rrPjfSz8hXNcYTAo1TTWKk1rjNsk0Fe9SjNKN/kdvA9aRv91TQ8BD
 3bn2l6LRSKkOu4iX/0ZFqckFEpiQbUFhnoY/SKCGxK5qkFngaBnDOk6EixoUqEWepq
 tgaI3S0w3tR/uCcobKSPZkWH8m9zipvvXhgOaUfoUpDPdyYpwYZnwNLhqz/gJReyU0
 FM5l8bVWCUqVvsjB55FIPSB/7FTdWN7fSSlGWIj4oT/T9DqPDdy1XXPueY3X04Dfow
 /pKubFwfida+A==
To: jaegeuk@kernel.org
Date: Tue, 25 Aug 2026 21:01:24 +0800
Message-ID: <20260825130126.2078627-11-chao@kernel.org>
X-Mailer: git-send-email 2.55.0.887.g758fc8c411-goog
In-Reply-To: <20260825130126.2078627-1-chao@kernel.org>
References: <20260825130126.2078627-1-chao@kernel.org>
MIME-Version: 1.0
X-Headers-End: 1wyqn0-0005m9-5d
Subject: [f2fs-dev] [PATCH v3 10/12] f2fs: cache: support fault injection
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
index 5b9055ad49b9..013433ce96dc 100644
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
