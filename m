Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DC28C001B0
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 24 Jul 2023 10:15:57 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1qNsba-0005y6-UN;
	Mon, 24 Jul 2023 10:15:55 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <zhengqi.arch@bytedance.com>) id 1qNsbZ-0005y0-SN
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 24 Jul 2023 10:15:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=av+QDe1dYuRDqLy0LPAsVex0suGCyDNqgU4hNImbDOo=; b=kjCHtrqlHUSHqWW4TXolMNPc6+
 zcMXvv7/hkQs7Dy4Wl+Q+5BlSVvHN20HOfxQCYEL+H6TJD/H0+PtgRqMQEqL7/TqiWdnOkW8LzlUj
 u8SJMUww5ZVRcbY0AArU+Abfe3s1D78I6jWxDVdhd2xiHjI1oRxJmMyu2a9y1IbkAOEU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=av+QDe1dYuRDqLy0LPAsVex0suGCyDNqgU4hNImbDOo=; b=K/bJ+o7GR9govm7/WKY/1Ach/h
 IYre7ww0pD3dXzw7Kw2o1zuXcevAfmWHWJ4c8y1Bt1OWYUD6maozZZQ2w4CKOWk+/rJjlaXLEF2F9
 1GfRiJTuaNIUBbQ3+zsEsa/H4psAeM+Ny7w40NCnl05KY1KAh8qOR8YyGWx8VBz8bbek=;
Received: from mail-qt1-f171.google.com ([209.85.160.171])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1qNsba-000Pt1-9C for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 24 Jul 2023 10:15:54 +0000
Received: by mail-qt1-f171.google.com with SMTP id
 d75a77b69052e-4038cfd59c1so9990941cf.0
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 24 Jul 2023 03:15:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1690193748; x=1690798548;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=av+QDe1dYuRDqLy0LPAsVex0suGCyDNqgU4hNImbDOo=;
 b=GFndsHg8K/s8Hhy1jne8Ax0lMiD4LiEVxyiVxj/5XSv0xs/siS5PSqdEuAmVmFiNnc
 s6Nw9EeiueJuwrXwApb02SGi/rIug6SXMM8s/zEWUVR3pyzn5wlO3BjApQTlZl7LxoCu
 AeOXAagh+HGUxyDwyDKfDGNOHc2XWgl6pP0daiz4JmZ2hVT/BvysABzhqkoCXRpoSYO6
 6szDzII7QHgieh5G2XXFAgLyH5zHzZ7GbkFo0a/waUtjPrSttPbe4ngr4YkK9eBlF106
 4hijqNJaLbpcBwBDzqlt11Crdkh/3BmiLeD9vhAuxdn9bpP2rwQUEhPbsAAsYuJb/WRd
 CfdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690193748; x=1690798548;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=av+QDe1dYuRDqLy0LPAsVex0suGCyDNqgU4hNImbDOo=;
 b=U6lDCLInF7Rabv84qhv5d1FSlSgtlM4JLwo8exkfWqX1Mg647/X+gkywQ7UzU9cicp
 gYhwit+e6pVK2EFon5KiGvqkZbVwoqFnI6vMgQA3cDC82AWsEf5JSA/Rng9a94JvS072
 i3eC6JLIsFHwih0qmadL9Wd0dvQSMaGDdHCLLlNdnABW6h6CXWOWrsrcWlqM0R7aZoWN
 eUsmEG5A+zQ/VueIZwK09TlSd04ll6FpshZ1LZA4vepuSLr/OvbPLhVsm346HgIEfHjC
 PwkzB8EF5up785jhde/6futQY/VaNru/uQa19Xf9A2LDrOO3H1I7oNB3O9TPSuSgyF7t
 +XCA==
X-Gm-Message-State: ABy/qLajhOAQeZCO8NjCyP2qdouxaJnWKEd2SzcED/cwvaMt8AchLR6D
 uesWMG/ltDTOyG+89xnz60nGWHKSrswK0upLZhE=
X-Google-Smtp-Source: APBJJlGdal6NRof8mBJ7MOpqyhGdVFWorp9Fsw25TA7e6Zh0vfd9YbcVPo2ONhSqPJyVS7KwA30xww==
X-Received: by 2002:a17:902:ea01:b0:1bb:83ec:832 with SMTP id
 s1-20020a170902ea0100b001bb83ec0832mr8333588plg.2.1690192098526; 
 Mon, 24 Jul 2023 02:48:18 -0700 (PDT)
Received: from C02DW0BEMD6R.bytedance.net ([203.208.167.147])
 by smtp.gmail.com with ESMTPSA id
 d5-20020a170902c18500b001bb20380bf2sm8467233pld.13.2023.07.24.02.48.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Jul 2023 02:48:18 -0700 (PDT)
To: akpm@linux-foundation.org, david@fromorbit.com, tkhai@ya.ru,
 vbabka@suse.cz, roman.gushchin@linux.dev, djwong@kernel.org,
 brauner@kernel.org, paulmck@kernel.org, tytso@mit.edu,
 steven.price@arm.com, cel@kernel.org, senozhatsky@chromium.org,
 yujie.liu@intel.com, gregkh@linuxfoundation.org, muchun.song@linux.dev
Date: Mon, 24 Jul 2023 17:43:23 +0800
Message-Id: <20230724094354.90817-17-zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20230724094354.90817-1-zhengqi.arch@bytedance.com>
References: <20230724094354.90817-1-zhengqi.arch@bytedance.com>
MIME-Version: 1.0
X-Headers-End: 1qNsba-000Pt1-9C
Subject: [f2fs-dev] [PATCH v2 16/47] ubifs: dynamically allocate the
 ubifs-slab shrinker
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

Use new APIs to dynamically allocate the ubifs-slab shrinker.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
---
 fs/ubifs/super.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/fs/ubifs/super.c b/fs/ubifs/super.c
index 32cb14759796..f2a3a58f7860 100644
--- a/fs/ubifs/super.c
+++ b/fs/ubifs/super.c
@@ -54,11 +54,7 @@ module_param_cb(default_version, &ubifs_default_version_ops, &ubifs_default_vers
 static struct kmem_cache *ubifs_inode_slab;
 
 /* UBIFS TNC shrinker description */
-static struct shrinker ubifs_shrinker_info = {
-	.scan_objects = ubifs_shrink_scan,
-	.count_objects = ubifs_shrink_count,
-	.seeks = DEFAULT_SEEKS,
-};
+static struct shrinker *ubifs_shrinker_info;
 
 /**
  * validate_inode - validate inode.
@@ -2373,7 +2369,7 @@ static void inode_slab_ctor(void *obj)
 
 static int __init ubifs_init(void)
 {
-	int err;
+	int err = -ENOMEM;
 
 	BUILD_BUG_ON(sizeof(struct ubifs_ch) != 24);
 
@@ -2439,10 +2435,16 @@ static int __init ubifs_init(void)
 	if (!ubifs_inode_slab)
 		return -ENOMEM;
 
-	err = register_shrinker(&ubifs_shrinker_info, "ubifs-slab");
-	if (err)
+	ubifs_shrinker_info = shrinker_alloc(0, "ubifs-slab");
+	if (!ubifs_shrinker_info)
 		goto out_slab;
 
+	ubifs_shrinker_info->count_objects = ubifs_shrink_count;
+	ubifs_shrinker_info->scan_objects = ubifs_shrink_scan;
+	ubifs_shrinker_info->seeks = DEFAULT_SEEKS;
+
+	shrinker_register(ubifs_shrinker_info);
+
 	err = ubifs_compressors_init();
 	if (err)
 		goto out_shrinker;
@@ -2467,7 +2469,7 @@ static int __init ubifs_init(void)
 	dbg_debugfs_exit();
 	ubifs_compressors_exit();
 out_shrinker:
-	unregister_shrinker(&ubifs_shrinker_info);
+	shrinker_unregister(ubifs_shrinker_info);
 out_slab:
 	kmem_cache_destroy(ubifs_inode_slab);
 	return err;
@@ -2483,7 +2485,7 @@ static void __exit ubifs_exit(void)
 	dbg_debugfs_exit();
 	ubifs_sysfs_exit();
 	ubifs_compressors_exit();
-	unregister_shrinker(&ubifs_shrinker_info);
+	shrinker_unregister(ubifs_shrinker_info);
 
 	/*
 	 * Make sure all delayed rcu free inodes are flushed before we
-- 
2.30.2



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
