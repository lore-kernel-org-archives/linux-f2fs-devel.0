Return-Path: <SRS0=dspS=M5=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45DD5C4338F
	for <linux-f2fs-devel@archiver.kernel.org>; Fri,  6 Aug 2021 00:06:11 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0436E60F43
	for <linux-f2fs-devel@archiver.kernel.org>; Fri,  6 Aug 2021 00:06:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 0436E60F43
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.92.3)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1mBnNK-0007WY-M3; Fri, 06 Aug 2021 00:06:10 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.3)
 (envelope-from <chao@kernel.org>) id 1mBnNJ-0007WR-61
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 06 Aug 2021 00:06:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=kwlykOWW6u6idA8VuWPWFgA7z2toMvomR4R1i9geCK8=; b=IZFyA2DBV32V36Z/psvtI+KP6K
 wxbVsmt7uAMQt3jKJ+gMlG545hI1R1Y7MFwzC/v7rKsp1Sd/QlcxLJ/97LHuY/Do/WrReXiGcK11V
 B31VWx3vcPa3QPr8bTkIBF4ORG85d9tjorE7x9b6VYnJVrLngEzfcTj3ADty8Gwa5wb0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=kwlykOWW6u6idA8VuWPWFgA7z2toMvomR4R1i9geCK8=; b=d
 ayxyEwfj8rsye3RxqL6gFqW6dWmx6Kgv4SAerCwlpbaIUboJU+2BR5KfLZzQE9CDXQ1n7jXkDjy6K
 TRCKfnQekJe/4Jlf77PodaPc5mQP7snkJO3Xtm7FGr8EhXxa3VKcdhzMLkpTIWk56N9U5CzSmrlHT
 bKkrSbUZg63WKkGo=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.3)
 id 1mBnNH-00Dwgg-Si
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 06 Aug 2021 00:06:09 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 388B3606A5;
 Fri,  6 Aug 2021 00:06:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1628208362;
 bh=ennyVryFxjJ44CHKwDR045QMMnx30QntbMpU60qL0wc=;
 h=From:To:Cc:Subject:Date:From;
 b=eJQRv5uf01Kz2UteAygihx3H8LSB615aI3AXXG1wGne8JUpQIanSXgVObEBfUzxrn
 ilb3QNB4o9c5OxshzVPi+BnjtSPrz8v2IzYvOOjv4qzRnYml/exn+koKm9lgdILQgC
 9TPKI2SZTNqEDdT3WKhrx9wuCnrx3Hiv4p6cJn395v8qJpECrSS1CGzzIN9BLdQeUu
 MS8y0f744fPo4uk7vopU80zrwTP7qfy1IPsDRGTkNNCUgO5VGE5ac74epDCxnNsnOq
 bG9bVxcNwq/MCIZNNgrIZKaRHr9R+MPe4KYpuwfrZ43LljzqMEQ1M6NWc7DHDTSmpS
 4kyv0MNZIsK+A==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Date: Fri,  6 Aug 2021 08:05:58 +0800
Message-Id: <20210806000558.40784-1-chao@kernel.org>
X-Mailer: git-send-email 2.22.1
MIME-Version: 1.0
X-Headers-End: 1mBnNH-00Dwgg-Si
Subject: [f2fs-dev] [PATCH] f2fs: avoid unneeded memory allocation in
 __add_ino_entry()
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
Cc: Chao Yu <chao.yu@linux.dev>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

__add_ino_entry() will allocate slab cache even if we have already
cached ino entry in radix tree, e.g. for case of multiple devices.

Let's check radix tree first under protection of rcu lock to see
whether we need to do slab allocation, it will mitigate memory
pressure from "f2fs_ino_entry" slab cache.

Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/checkpoint.c | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index 7f6745f4630e..5b6ddeae1107 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -465,16 +465,28 @@ static void __add_ino_entry(struct f2fs_sb_info *sbi, nid_t ino,
 						unsigned int devidx, int type)
 {
 	struct inode_management *im = &sbi->im[type];
-	struct ino_entry *e, *tmp;
+	struct ino_entry *e = NULL, *new = NULL;
+
+	if (type == FLUSH_INO) {
+		rcu_read_lock();
+		e = radix_tree_lookup(&im->ino_root, ino);
+		rcu_read_unlock();
+	}
 
-	tmp = f2fs_kmem_cache_alloc(ino_entry_slab, GFP_NOFS);
+retry:
+	if (!e)
+		new = f2fs_kmem_cache_alloc(ino_entry_slab, GFP_NOFS);
 
 	radix_tree_preload(GFP_NOFS | __GFP_NOFAIL);
 
 	spin_lock(&im->ino_lock);
 	e = radix_tree_lookup(&im->ino_root, ino);
 	if (!e) {
-		e = tmp;
+		if (!new) {
+			spin_unlock(&im->ino_lock);
+			goto retry;
+		}
+		e = new;
 		if (unlikely(radix_tree_insert(&im->ino_root, ino, e)))
 			f2fs_bug_on(sbi, 1);
 
@@ -492,8 +504,8 @@ static void __add_ino_entry(struct f2fs_sb_info *sbi, nid_t ino,
 	spin_unlock(&im->ino_lock);
 	radix_tree_preload_end();
 
-	if (e != tmp)
-		kmem_cache_free(ino_entry_slab, tmp);
+	if (new && e != new)
+		kmem_cache_free(ino_entry_slab, new);
 }
 
 static void __remove_ino_entry(struct f2fs_sb_info *sbi, nid_t ino, int type)
-- 
2.22.1



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
