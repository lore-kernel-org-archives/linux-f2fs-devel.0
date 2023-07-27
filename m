Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08F26C001E0
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 27 Jul 2023 08:10:01 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1qOw4O-0006ww-7R;
	Thu, 27 Jul 2023 08:10:00 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <zhengqi.arch@bytedance.com>) id 1qOw4N-0006wo-7v
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 27 Jul 2023 08:09:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=YHU8OaKZwBmHAPsd+ulZSL5GxfVyMtJ49ZlHBntG+/k=; b=fzrpkhfa5/Zo1dTc0iyNk2gxfK
 sszC6mThYBUela3sxZAQDGlyK3nSXy2OuvFDuU4JVOPvBupuvwddQ8m1SXeaOHdScQteknLSx+v15
 K0j5TPhWKF0T4x4AJf6CjpaeeJDLut5DwgsTHcVSa4SVZ2b561+fn8tas4cDGl64z7DU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=YHU8OaKZwBmHAPsd+ulZSL5GxfVyMtJ49ZlHBntG+/k=; b=DF2PGqRgCvy/S0EfV2V57gdJb5
 4m6K6RYBPmWZSdP6BKJvTY3ur8pSSTEkdLJSvfAlEP+j/d0ZAFqmL8R49+OpIIsVqSOht8+Ur+wmH
 NyCxOoiusMCTDkxf6DI44dzLwUR8CPPHo3ln0CEaHGZJujtF3+//BGqHFBJcuor25BXM=;
Received: from mail-pf1-f178.google.com ([209.85.210.178])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1qOw4N-004LY7-23 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 27 Jul 2023 08:09:59 +0000
Received: by mail-pf1-f178.google.com with SMTP id
 d2e1a72fcca58-682eef7d752so204029b3a.0
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu, 27 Jul 2023 01:09:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1690445393; x=1691050193;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YHU8OaKZwBmHAPsd+ulZSL5GxfVyMtJ49ZlHBntG+/k=;
 b=Ws66ywmifmcLi+WS7kmIq1OGsH1BFTj57lSknLEKHfbjZoq0FCk32P7hFix2O77y/C
 4VExY7boGbko1TLXa8rf04m6+c8ScNg+Ye07GBCAr/bT75kG0yI8bdxHraEPkF+rcUYR
 8BmftTtO1b4i7ZeslsgPT7KHdxn3xY8ziOGXEmWj+FzniwFS8tNvAxdGJbvq/4djXF38
 gQDVTQD96XEDgWvn9v9d4yLEL0qbZzBxPnvHBbbs4StP2CGFCs0AHk/pzAfhLwFN3LYv
 MATNwQY8c4ti2yb34XlOR1fjl5eoQUN5qPDBlkMol6h4RrCuQdh3qGqhSkTUZQAnG9Jo
 zXhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690445393; x=1691050193;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YHU8OaKZwBmHAPsd+ulZSL5GxfVyMtJ49ZlHBntG+/k=;
 b=lLeRbBpYXUpwsP4b9NQtpNqoL7QMQy2kN0IgmNn3aSI8kqFQnJV7gI30RL/5Xi/yJ2
 d5VaYIP/lawUZ3RqlbqhZYFdMvdQXG0sDF0mJMojCSLKfB9uu467cY1OiIjdgIfkF01G
 U/GRk3Px6bYLROtrFltouwjhAUbE8b7fnqLed/jWZTgcuGErRPOeEWWVfhqWPEvobX1c
 xxKcPZOAZnQth5hZSzCifuVlx5cuqMmVELChG7Q+yv9g6aNZ1z7IZkSjbpok0mwburHh
 ZCwNyrzoUpRFPKnN2BqCzAo5au07JPqcaL/M6hJKBQmyFDCs77utvh4i7xOW6ByXS7WK
 1Hmg==
X-Gm-Message-State: ABy/qLbmP4/Q6SJMOuBQZnMYgDVwq/rZz0G4fpDUEFzmDvKTW2OyRILf
 8gOen9GJjd5PqHHsKnUlvg7H/g==
X-Google-Smtp-Source: APBJJlFl46sZLt7x9x1yarGXcrDY9BzfubiI/ML/2A4f5iYMwILGEdxBDjTGuKdYIeQS2k9MfMDqhg==
X-Received: by 2002:a05:6a00:4a0e:b0:677:3439:874a with SMTP id
 do14-20020a056a004a0e00b006773439874amr5199798pfb.3.1690445393467; 
 Thu, 27 Jul 2023 01:09:53 -0700 (PDT)
Received: from C02DW0BEMD6R.bytedance.net ([203.208.167.147])
 by smtp.gmail.com with ESMTPSA id
 j8-20020aa78d08000000b006828e49c04csm885872pfe.75.2023.07.27.01.09.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Jul 2023 01:09:53 -0700 (PDT)
To: akpm@linux-foundation.org, david@fromorbit.com, tkhai@ya.ru,
 vbabka@suse.cz, roman.gushchin@linux.dev, djwong@kernel.org,
 brauner@kernel.org, paulmck@kernel.org, tytso@mit.edu,
 steven.price@arm.com, cel@kernel.org, senozhatsky@chromium.org,
 yujie.liu@intel.com, gregkh@linuxfoundation.org, muchun.song@linux.dev
Date: Thu, 27 Jul 2023 16:04:33 +0800
Message-Id: <20230727080502.77895-21-zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20230727080502.77895-1-zhengqi.arch@bytedance.com>
References: <20230727080502.77895-1-zhengqi.arch@bytedance.com>
MIME-Version: 1.0
X-Headers-End: 1qOw4N-004LY7-23
Subject: [f2fs-dev] [PATCH v3 20/49] rcu: dynamically allocate the rcu-kfree
 shrinker
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
 linux-raid@vger.kernel.org, linux-nfs@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-erofs@lists.ozlabs.org, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Use new APIs to dynamically allocate the rcu-kfree shrinker.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
---
 kernel/rcu/tree.c | 22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index cb1caefa8bd0..6d2f82f79c65 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -3449,13 +3449,6 @@ kfree_rcu_shrink_scan(struct shrinker *shrink, struct shrink_control *sc)
 	return freed == 0 ? SHRINK_STOP : freed;
 }
 
-static struct shrinker kfree_rcu_shrinker = {
-	.count_objects = kfree_rcu_shrink_count,
-	.scan_objects = kfree_rcu_shrink_scan,
-	.batch = 0,
-	.seeks = DEFAULT_SEEKS,
-};
-
 void __init kfree_rcu_scheduler_running(void)
 {
 	int cpu;
@@ -4931,6 +4924,7 @@ static void __init kfree_rcu_batch_init(void)
 {
 	int cpu;
 	int i, j;
+	struct shrinker *kfree_rcu_shrinker;
 
 	/* Clamp it to [0:100] seconds interval. */
 	if (rcu_delay_page_cache_fill_msec < 0 ||
@@ -4962,8 +4956,18 @@ static void __init kfree_rcu_batch_init(void)
 		INIT_DELAYED_WORK(&krcp->page_cache_work, fill_page_cache_func);
 		krcp->initialized = true;
 	}
-	if (register_shrinker(&kfree_rcu_shrinker, "rcu-kfree"))
-		pr_err("Failed to register kfree_rcu() shrinker!\n");
+
+	kfree_rcu_shrinker = shrinker_alloc(0, "rcu-kfree");
+	if (!kfree_rcu_shrinker) {
+		pr_err("Failed to allocate kfree_rcu() shrinker!\n");
+		return;
+	}
+
+	kfree_rcu_shrinker->count_objects = kfree_rcu_shrink_count;
+	kfree_rcu_shrinker->scan_objects = kfree_rcu_shrink_scan;
+	kfree_rcu_shrinker->seeks = DEFAULT_SEEKS;
+
+	shrinker_register(kfree_rcu_shrinker);
 }
 
 void __init rcu_init(void)
-- 
2.30.2



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
