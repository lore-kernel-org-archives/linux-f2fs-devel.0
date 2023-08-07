Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D747C04A94
	for <linux-f2fs-devel@archiver.kernel.org>; Mon,  7 Aug 2023 11:17:31 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1qSyEt-0008Oq-Dn;
	Mon, 07 Aug 2023 11:17:30 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <zhengqi.arch@bytedance.com>) id 1qSyEs-0008OZ-SU
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 07 Aug 2023 11:17:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=48waxWZGd1WUnLYaDrTSxvJywKXLcopaiUkWgt7j5Rg=; b=HBNQ+Exbop3jIHervZKIllPz9u
 DK3cCgk73TTqR8RTbZPTtTxRCOeM0wu0x2WAt4D5ds8w+La1+AhjJZWhEagk7R89po7zJwtM9yuoE
 VNA8znI7kInbp7Dmqsq4rcRcO0uWb1setZivb1We+kmw3SAV4D2LDwARle1k5Z/7nQXg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=48waxWZGd1WUnLYaDrTSxvJywKXLcopaiUkWgt7j5Rg=; b=OVyrM8RRqY/mPW8mrbGP8s9upz
 yHdvVUmpBgMpoLFpI3pa9w6dqnR9BpL+vJcseOXFJCGxskQ5kO8/U48YcdAiy12P6ZH54HqpyRKWv
 zCGBWDQmspvy1ZSxrz595Au33+b2H/7SuIFVId7DGZp+AmBc4oSY5L6uN0HGqlI/92cI=;
Received: from mail-pg1-f169.google.com ([209.85.215.169])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1qSyEo-0007wm-P7 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 07 Aug 2023 11:17:28 +0000
Received: by mail-pg1-f169.google.com with SMTP id
 41be03b00d2f7-55badd6d6feso572156a12.1
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 07 Aug 2023 04:17:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1691407033; x=1692011833;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=48waxWZGd1WUnLYaDrTSxvJywKXLcopaiUkWgt7j5Rg=;
 b=IF5FMf6vfUKWXKquwpCQEDXlMw21VPTq0vQh30bzDQAe43NcnPpm7+3Lc8a3CIJRpA
 3D5+DTGp/GVVz7K0qnRkJHp3ElWCuX/V5mJLE2CMMPVLrH696jMkWhUZV5knoMheDkE7
 LNxcBFVMjsAliYNw3/qsjltVAMCexO3SFZuMneEunxblALcqU49wFlwUCGkH4chcrTm+
 Mu+nFly5hda7TWhSn6s/LaVQ5cZernQQxFJBPj8H2QEyQDfBEaIAKgcH8kpChkzLsY8n
 h49b3nM+GUF7t0uuu7NHoFu5rdBXy5wqqQ2n0YE+hiJT0Y6kOYKfZmJPFvsrDsGv9xrG
 NHZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691407033; x=1692011833;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=48waxWZGd1WUnLYaDrTSxvJywKXLcopaiUkWgt7j5Rg=;
 b=B5TZ+V2b7oBZQQi59RWJJy7gm54YAxSq8Nz4jX0Tgq/CaDPjCBaYaQha5IhMHGAJpn
 nR6X1rNsHScxBQmIYDyoHpzlT29c/RrqhhS+TE34V6l7nO/jJB1Aq6NMVe17fPhPIe/H
 K/koYSlDrXLuVsYAe4819dNWUBo0GhMEVQSR/HkFCsEGZU4o772Bh21hABBFpMThJbcB
 mmzfDc/c820iX6fnrNeWvanveV1eyUIr3E1Igly5AR5EcvTyrjrQUNegj1nQRSsMKvT8
 PghQjQvaPQyrmeLB5/+ufQznckfrhcleV0mIG3hg/K57C81yvSGIoA3PkKJCgOuMw3DU
 Ph0w==
X-Gm-Message-State: ABy/qLbLY9daWHRmisOiUicIuncs3MOQ2CKWWb5U3up4BEezbT6LNoA6
 1HyycEokdJThMqDf/tb035gCbw==
X-Google-Smtp-Source: APBJJlHbn14CvO5TR8loNSEkHloCg3xrbjPIwtza5v7TtzUnsc09AI3fvHMVCyYd3DTpdbD1pcNBzw==
X-Received: by 2002:a17:90a:4104:b0:25c:1ad3:a4a1 with SMTP id
 u4-20020a17090a410400b0025c1ad3a4a1mr24600948pjf.1.1691407032801; 
 Mon, 07 Aug 2023 04:17:12 -0700 (PDT)
Received: from C02DW0BEMD6R.bytedance.net ([203.208.167.146])
 by smtp.gmail.com with ESMTPSA id
 y13-20020a17090aca8d00b0025be7b69d73sm5861191pjt.12.2023.08.07.04.17.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Aug 2023 04:17:12 -0700 (PDT)
To: akpm@linux-foundation.org, david@fromorbit.com, tkhai@ya.ru,
 vbabka@suse.cz, roman.gushchin@linux.dev, djwong@kernel.org,
 brauner@kernel.org, paulmck@kernel.org, tytso@mit.edu,
 steven.price@arm.com, cel@kernel.org, senozhatsky@chromium.org,
 yujie.liu@intel.com, gregkh@linuxfoundation.org, muchun.song@linux.dev,
 simon.horman@corigine.com, dlemoal@kernel.org
Date: Mon,  7 Aug 2023 19:09:22 +0800
Message-Id: <20230807110936.21819-35-zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20230807110936.21819-1-zhengqi.arch@bytedance.com>
References: <20230807110936.21819-1-zhengqi.arch@bytedance.com>
MIME-Version: 1.0
X-Headers-End: 1qSyEo-0007wm-P7
Subject: [f2fs-dev] [PATCH v4 34/48] jbd2,
 ext4: dynamically allocate the jbd2-journal shrinker
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
From: Qi Zheng via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Qi Zheng <zhengqi.arch@bytedance.com>
Cc: kvm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 virtualization@lists.linux-foundation.org, linux-mm@kvack.org,
 dm-devel@redhat.com, linux-mtd@lists.infradead.org, x86@kernel.org,
 cluster-devel@redhat.com, xen-devel@lists.xenproject.org,
 linux-ext4@vger.kernel.org, linux-arm-msm@vger.kernel.org, rcu@vger.kernel.org,
 linux-bcache@vger.kernel.org, Qi Zheng <zhengqi.arch@bytedance.com>,
 Muchun Song <songmuchun@bytedance.com>, linux-raid@vger.kernel.org,
 linux-nfs@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-erofs@lists.ozlabs.org, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

In preparation for implementing lockless slab shrink, use new APIs to
dynamically allocate the jbd2-journal shrinker, so that it can be freed
asynchronously using kfree_rcu(). Then it doesn't need to wait for RCU
read-side critical section when releasing the struct journal_s.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
Reviewed-by: Muchun Song <songmuchun@bytedance.com>
---
 fs/jbd2/journal.c    | 27 +++++++++++++++++----------
 include/linux/jbd2.h |  2 +-
 2 files changed, 18 insertions(+), 11 deletions(-)

diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
index 1b5a45ab62b0..4c421da03fee 100644
--- a/fs/jbd2/journal.c
+++ b/fs/jbd2/journal.c
@@ -1298,7 +1298,7 @@ static int jbd2_min_tag_size(void)
 static unsigned long jbd2_journal_shrink_scan(struct shrinker *shrink,
 					      struct shrink_control *sc)
 {
-	journal_t *journal = container_of(shrink, journal_t, j_shrinker);
+	journal_t *journal = shrink->private_data;
 	unsigned long nr_to_scan = sc->nr_to_scan;
 	unsigned long nr_shrunk;
 	unsigned long count;
@@ -1324,7 +1324,7 @@ static unsigned long jbd2_journal_shrink_scan(struct shrinker *shrink,
 static unsigned long jbd2_journal_shrink_count(struct shrinker *shrink,
 					       struct shrink_control *sc)
 {
-	journal_t *journal = container_of(shrink, journal_t, j_shrinker);
+	journal_t *journal = shrink->private_data;
 	unsigned long count;
 
 	count = percpu_counter_read_positive(&journal->j_checkpoint_jh_count);
@@ -1412,19 +1412,26 @@ static journal_t *journal_init_common(struct block_device *bdev,
 	journal->j_superblock = (journal_superblock_t *)bh->b_data;
 
 	journal->j_shrink_transaction = NULL;
-	journal->j_shrinker.scan_objects = jbd2_journal_shrink_scan;
-	journal->j_shrinker.count_objects = jbd2_journal_shrink_count;
-	journal->j_shrinker.seeks = DEFAULT_SEEKS;
-	journal->j_shrinker.batch = journal->j_max_transaction_buffers;
 
 	if (percpu_counter_init(&journal->j_checkpoint_jh_count, 0, GFP_KERNEL))
 		goto err_cleanup;
 
-	if (register_shrinker(&journal->j_shrinker, "jbd2-journal:(%u:%u)",
-			      MAJOR(bdev->bd_dev), MINOR(bdev->bd_dev))) {
+	journal->j_shrinker = shrinker_alloc(0, "jbd2-journal:(%u:%u)",
+					     MAJOR(bdev->bd_dev),
+					     MINOR(bdev->bd_dev));
+	if (!journal->j_shrinker) {
 		percpu_counter_destroy(&journal->j_checkpoint_jh_count);
 		goto err_cleanup;
 	}
+
+	journal->j_shrinker->scan_objects = jbd2_journal_shrink_scan;
+	journal->j_shrinker->count_objects = jbd2_journal_shrink_count;
+	journal->j_shrinker->seeks = DEFAULT_SEEKS;
+	journal->j_shrinker->batch = journal->j_max_transaction_buffers;
+	journal->j_shrinker->private_data = journal;
+
+	shrinker_register(journal->j_shrinker);
+
 	return journal;
 
 err_cleanup:
@@ -2187,9 +2194,9 @@ int jbd2_journal_destroy(journal_t *journal)
 		brelse(journal->j_sb_buffer);
 	}
 
-	if (journal->j_shrinker.flags & SHRINKER_REGISTERED) {
+	if (journal->j_shrinker) {
 		percpu_counter_destroy(&journal->j_checkpoint_jh_count);
-		unregister_shrinker(&journal->j_shrinker);
+		shrinker_free(journal->j_shrinker);
 	}
 	if (journal->j_proc_entry)
 		jbd2_stats_proc_exit(journal);
diff --git a/include/linux/jbd2.h b/include/linux/jbd2.h
index 44c298aa58d4..beb4c4586320 100644
--- a/include/linux/jbd2.h
+++ b/include/linux/jbd2.h
@@ -891,7 +891,7 @@ struct journal_s
 	 * Journal head shrinker, reclaim buffer's journal head which
 	 * has been written back.
 	 */
-	struct shrinker		j_shrinker;
+	struct shrinker		*j_shrinker;
 
 	/**
 	 * @j_checkpoint_jh_count:
-- 
2.30.2



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
