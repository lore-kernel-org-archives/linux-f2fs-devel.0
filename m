Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9270C0015E
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 27 Jul 2023 08:09:27 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1qOw3q-0006uE-Lv;
	Thu, 27 Jul 2023 08:09:27 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <zhengqi.arch@bytedance.com>) id 1qOw3m-0006u3-Mb
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 27 Jul 2023 08:09:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=1//FAyntSoVVhHGcFkYF5rOUv8OYZDaOr/FI52lXs1g=; b=euHXNcFqLrKIR0kGQohZXzJs/m
 WyqsvcEr9WzO8dU0B73kj44W78VrOJwrAGAPlIOrLgqGdEcqqi5T8PzAytTYYnAK8Ow7e/8pLrQ/s
 2MyYYbNFpz/A/F45eOeMTWRsW0KL+2csq8EFLr3kcqgnEsF9MUoufNWg8xuvAXnw42UI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=1//FAyntSoVVhHGcFkYF5rOUv8OYZDaOr/FI52lXs1g=; b=V2lA0NoUEXLINY8iH3m8Iqe9pB
 lPGS9+bdMSWtwsM2gZ6V3XKbnPp4xbwYYxpG7McD73DN5InsOahieictB+u8qKw/C0LuHdsOohHsC
 stZjMb9eeRBfxJuyHSNiQfulij4ByWp0+e6tRKlHHL7vkoeWrLYVzzfFLtYcSXXzo+Ek=;
Received: from mail-pf1-f173.google.com ([209.85.210.173])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1qOw3m-004LWA-Bm for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 27 Jul 2023 08:09:23 +0000
Received: by mail-pf1-f173.google.com with SMTP id
 d2e1a72fcca58-682eef7d752so203895b3a.0
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu, 27 Jul 2023 01:09:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1690445357; x=1691050157;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1//FAyntSoVVhHGcFkYF5rOUv8OYZDaOr/FI52lXs1g=;
 b=WprFfHhwxvgCbIOGEhvz/77THpnE+uaWMbMuLLIIDpVeL3Jz2616v8wLFkzo7HZvSd
 TNFFTtJffBxh3fLTgZ0hA52iTzwFJ1lb7YC8GT96AcRGLEmRK6UnsPg5TF0WeT/gBbXI
 n3D8mngVfbe3MYXC32UZAJFJiGuaHBVIWM9CunOWIYu990kGDPAj43N4rpm3m8rpgsHd
 02xW2JacWcelFq3TAnDCLUfDJo66VYYZvDcSFvyxJpg5YwEtAXcJf/FphGWJu7IrCr2v
 NhF0NyS2ftTWJJ0Gd6+a6tHW0SZpG4hIgkFC42XLIYM9ZEOFnWGm8ZzCwBndTMQ8KaY8
 M1zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690445357; x=1691050157;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1//FAyntSoVVhHGcFkYF5rOUv8OYZDaOr/FI52lXs1g=;
 b=gdfFtCYrfSrByhW1CsFfb/rMrkM8kCZy9tIc+syoA5neXLcv6yyJDqQBnuQkxmON9E
 DZ0vDr3gndYjywYdBWP2A/Hwl8GCRu7A8nl2cIpvIw6aqIMqeJa/X0LbkEuoQFEzyHe9
 I8AlAS+r49DjDy+qdVbrPXJfK1aJqLbRqoIN8mSe+9bBILnuhKxP9Tp5f5kgP+duCghT
 feuMQOYWAh2W0NlO/Qs4EBwQ5bEu7R39tqaKqmVmLH6f/dklTj9fVADQjYZOgPQpVbo1
 JNJ3QEKh3RQlju8txt1VBmwNy1ynt9P1gxlXu0PguNUNmONVed9TpiN0U1z/h9xx0stN
 /kwg==
X-Gm-Message-State: ABy/qLbusAtdeKDGSbw/+1lntsMKapgYv7NhmX4wzxD2W/Fxc4dTv6+y
 PKj2UzDDEAzrBsO/1tHKYFpLUg==
X-Google-Smtp-Source: APBJJlHvmYnqUEfQMupLlQUSLLnEPxVICkIYSDMBUwnFYoQAuRxCEO7ekKLA8kJr4NX0LnRrY6UJ3A==
X-Received: by 2002:a05:6a00:13a3:b0:676:2a5c:7bc5 with SMTP id
 t35-20020a056a0013a300b006762a5c7bc5mr5229938pfg.1.1690445356761; 
 Thu, 27 Jul 2023 01:09:16 -0700 (PDT)
Received: from C02DW0BEMD6R.bytedance.net ([203.208.167.147])
 by smtp.gmail.com with ESMTPSA id
 j8-20020aa78d08000000b006828e49c04csm885872pfe.75.2023.07.27.01.09.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Jul 2023 01:09:16 -0700 (PDT)
To: akpm@linux-foundation.org, david@fromorbit.com, tkhai@ya.ru,
 vbabka@suse.cz, roman.gushchin@linux.dev, djwong@kernel.org,
 brauner@kernel.org, paulmck@kernel.org, tytso@mit.edu,
 steven.price@arm.com, cel@kernel.org, senozhatsky@chromium.org,
 yujie.liu@intel.com, gregkh@linuxfoundation.org, muchun.song@linux.dev
Date: Thu, 27 Jul 2023 16:04:30 +0800
Message-Id: <20230727080502.77895-18-zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20230727080502.77895-1-zhengqi.arch@bytedance.com>
References: <20230727080502.77895-1-zhengqi.arch@bytedance.com>
MIME-Version: 1.0
X-Headers-End: 1qOw3m-004LWA-Bm
Subject: [f2fs-dev] [PATCH v3 17/49] quota: dynamically allocate the
 dquota-cache shrinker
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

Use new APIs to dynamically allocate the dquota-cache shrinker.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
Reviewed-by: Muchun Song <songmuchun@bytedance.com>
---
 fs/quota/dquot.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/fs/quota/dquot.c b/fs/quota/dquot.c
index e8232242dd34..8883e6992f7c 100644
--- a/fs/quota/dquot.c
+++ b/fs/quota/dquot.c
@@ -791,12 +791,6 @@ dqcache_shrink_count(struct shrinker *shrink, struct shrink_control *sc)
 	percpu_counter_read_positive(&dqstats.counter[DQST_FREE_DQUOTS]));
 }
 
-static struct shrinker dqcache_shrinker = {
-	.count_objects = dqcache_shrink_count,
-	.scan_objects = dqcache_shrink_scan,
-	.seeks = DEFAULT_SEEKS,
-};
-
 /*
  * Safely release dquot and put reference to dquot.
  */
@@ -2957,6 +2951,7 @@ static int __init dquot_init(void)
 {
 	int i, ret;
 	unsigned long nr_hash, order;
+	struct shrinker *dqcache_shrinker;
 
 	printk(KERN_NOTICE "VFS: Disk quotas %s\n", __DQUOT_VERSION__);
 
@@ -2991,8 +2986,15 @@ static int __init dquot_init(void)
 	pr_info("VFS: Dquot-cache hash table entries: %ld (order %ld,"
 		" %ld bytes)\n", nr_hash, order, (PAGE_SIZE << order));
 
-	if (register_shrinker(&dqcache_shrinker, "dquota-cache"))
-		panic("Cannot register dquot shrinker");
+	dqcache_shrinker = shrinker_alloc(0, "dquota-cache");
+	if (!dqcache_shrinker)
+		panic("Cannot allocate dquot shrinker");
+
+	dqcache_shrinker->count_objects = dqcache_shrink_count;
+	dqcache_shrinker->scan_objects = dqcache_shrink_scan;
+	dqcache_shrinker->seeks = DEFAULT_SEEKS;
+
+	shrinker_register(dqcache_shrinker);
 
 	return 0;
 }
-- 
2.30.2



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
