Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C52EC88E53
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 11 Sep 2026 23:24:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-ID:Date:To:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vsJzfFnKh7bcV4mTc9srjxiCskqBeb3eQ8bqe9+8igM=; b=CUeWtjisxD0rc0DrkHh4ftBJOR
	mMhvAqc8ha6EnywbPUVtRmwS2EvFPvx2rC4FoQzgUBxNQC7EEbpJU1z1KQ7AbrZ+6EK0i6KdE9puK
	G615DzOaQnM88PyymB/APTBvqXriI5oy2BXrCUafy5X5LSvQkcAjHokqqUc/rsigPhT4=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1x5Abk-0000Pj-PE;
	Fri, 11 Sep 2026 23:24:36 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1x5Abh-0000PV-FJ
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 11 Sep 2026 23:24:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=NSBS8ZRpS+SWgzWKF9sDzzykDP2ZBx41vKFFWX58pcw=; b=FVhVtlmsnqBdl86endV30peaap
 sMNQTjaeCOopGvg1dOCPq8/ETAeFGMoRo/IUEMT0QKaAx6GUltJeE7mEouv3w+Hb5aasiItDozJiC
 1sgki9/hYzH9tXKX7hezaGjbfzfn6Wqlwvr1MI9lkpAwZqYjzNH5ccvneJ+Bz88XqmWw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=NSBS8ZRpS+SWgzWKF9sDzzykDP2ZBx41vKFFWX58pcw=; b=dxfZh3YLg3d+LTt+uNfhosQpRy
 KR0hY23ZHU0i2eDq4vips67hgJPNjMFvCPIa9U/+T4ywH/xgSPDNOa+19eJnv9bfWW+vT50mmjmzq
 YMPmXyPwd12q3bh8v+Gw2o1gaIqmNcTzucuIxIZVFveemX/1Q1GQs47nc9UgMfV65ydY=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1x5Abg-0005Th-Nb for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 11 Sep 2026 23:24:33 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 2BC3E600AA
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri, 11 Sep 2026 23:24:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B5C61F00899;
 Fri, 11 Sep 2026 23:24:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789169067;
 bh=NSBS8ZRpS+SWgzWKF9sDzzykDP2ZBx41vKFFWX58pcw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=GCPzfOXZ0HEiommtYml1fn8h3BF/0W9ZU8uay4lbb6NKj49YzNTwspaDBqY0LHu+b
 DUhcnnQkIR7SXoJb/WQdGuFHn+K/4Lfluq9NsEGg97oqfwXP5VAXeJglpD+kW9GHpY
 5p+N1Xsu9YgPvpXkp9xb6TKTdl2+tCYIYwca15WYoas5D6OEgnA0xFUyoHW5043sAi
 cvwk8vfU/wIGKsIEIxsmuqeU1LFWw+xM+v/ssG1SNP/3sZp/UgwSOXhn3oVpAkVWw5
 ZIyyglXuDCSs+eVLC5r3ppTiOGw/eMX9d5U4z00SET25ydH9Ei/IFZdzA7FL/hwZIB
 93tBJstgLzODQ==
To: jaegeuk@kernel.org
Date: Sat, 12 Sep 2026 07:24:03 +0800
Message-ID: <20260911232405.1815804-11-chao@kernel.org>
X-Mailer: git-send-email 2.55.0.1007.g17ff1f9808-goog
In-Reply-To: <20260911232405.1815804-1-chao@kernel.org>
References: <20260911232405.1815804-1-chao@kernel.org>
MIME-Version: 1.0
X-Headers-End: 1x5Abg-0005Th-Nb
Subject: [f2fs-dev] [PATCH v7 10/12] f2fs: cache: support fault injection
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
index 7260c157654b..dcab0f321730 100644
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
