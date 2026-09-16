Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF6B0C88E77
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 16 Sep 2026 01:55:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-ID:Date:To:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=R5jgBSfyznX6LK/MN38gyPGKSrGApUN2fw179GAkzG4=; b=CsFUHcW+4vzV5J1QCHiz9vtqI4
	5rj+k2dZPPEmOcdjwkbw/vOWEZM2+XlfzwGJIk1EZdGMehHUNNlFkusluPlFWlu+qq24WjxZ5Ujam
	ES7Lpx2NDTISZkTl1XWftu0lWrov4crTc+R87+E0gsUop5nqs2LTUHrEFSTPOLN4axpo=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1x6erb-0004nO-Kc;
	Wed, 16 Sep 2026 01:55:08 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1x6erY-0004mj-T9
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 16 Sep 2026 01:55:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=8iezvk0aqFV3s8RKr5k1FFGYRRAyKBJ6p1J4i3PzFb4=; b=LoKJ0uW4xGsedOUg+fLW4OBvh5
 U/GSA/vhBRyv/tTKJ22ren8IcpxdA7K19igMoMnKydSzwM4vt2iDlUhh6C4cJ1SzN9NR6WzO2Av9k
 PjFZ+CP2qnCWnP+OSg/Fgv4aRlWTqaGhs0NbRyAJo9OkGh55aDxe0qq6+RCuPBIPy38k=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=8iezvk0aqFV3s8RKr5k1FFGYRRAyKBJ6p1J4i3PzFb4=; b=JRSQR5mIsRWG28LopJYAZcctR0
 6YY+bAcOjC0Qf9+oQ1mB0q9dFhYhy+ooVzVWHSO9pg9MlH0KFkhTUDRjfL90LxIA3tbeOQTpVYk3+
 oglUy08XGJ+eXUD1YQdjUQuTi13E7xXcQEwLo83YaKiNmEnh/pIgLRY/lb0BDuvkRH7Y=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1x6erY-00011j-Si for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 16 Sep 2026 01:55:05 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 9946743EC0
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed, 16 Sep 2026 01:54:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B0781F0089D;
 Wed, 16 Sep 2026 01:54:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789523699;
 bh=8iezvk0aqFV3s8RKr5k1FFGYRRAyKBJ6p1J4i3PzFb4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=m3lt3mmY050HLOdMF8pHwwYX1xwtKZ3DaXpLyIsviecf7WVF7KVZ5HkYSvvihRV7t
 yqYXD+BilXH7pw5kkv9v26OatyeBQCWq2nMv50u7bvukrqusGpXW1O60j1Vu6uWz9E
 XzsEYc6xsbdCKCf3AIijITypyf6NrjFe3G7Xg/DG414XGFxfH/Xt0rvGw290rmwLso
 HAn6CPqkoOKmEMfVvHkWknvwz6eceAUbAiTxmTLRbYtV3p7weh/M9TA3fKqUr/XzLJ
 CGS61+FzU07sdq1vrktn02BzLDQbNCC0rGg/GvwlbqNPeY/4WyOBMv/qz5NEXGTS20
 ZIKiB3eDZgL7A==
To: jaegeuk@kernel.org
Date: Wed, 16 Sep 2026 09:54:38 +0800
Message-ID: <20260916015440.2232938-11-chao@kernel.org>
X-Mailer: git-send-email 2.55.0.1032.g73a4cd73de-goog
In-Reply-To: <20260916015440.2232938-1-chao@kernel.org>
References: <20260916015440.2232938-1-chao@kernel.org>
MIME-Version: 1.0
X-Headers-End: 1x6erY-00011j-Si
Subject: [f2fs-dev] [PATCH v8 10/12] f2fs: cache: support fault injection
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
- it integrates entry allocations with FAULT_KMALLOC

Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/cache.c | 24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/fs/f2fs/cache.c b/fs/f2fs/cache.c
index 3e6a198ef3b3..27624b6799a9 100644
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
