Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24789C04E69
	for <linux-f2fs-devel@archiver.kernel.org>; Mon,  7 Aug 2023 11:15:45 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1qSyDB-0008Ec-Ip;
	Mon, 07 Aug 2023 11:15:44 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <zhengqi.arch@bytedance.com>) id 1qSyD3-0008Dy-Vr
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 07 Aug 2023 11:15:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=8Rfav5Nxe+GtybemfHCRLQWJ1Wm1Jr8phC3oTaQ6f/s=; b=BgOpGIOYCK7xtbm/fQi36VWkM+
 FnzV8NaH9oCZghIi2fmzx8FXMrBUorx/b2zRRxatPMCztXdEa9at5JgmTUYVwdx/fHREJegzLyisA
 cwBOZTSl2GAXTEls4U8NXAvaN13Q6g6L7MEUTpOMAJQWNa9rf/p1ujtTLWEomhP1Rv+U=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=8Rfav5Nxe+GtybemfHCRLQWJ1Wm1Jr8phC3oTaQ6f/s=; b=O3lGUwEcqTu3j9wJoAm8dQZUkY
 VH5ESt7OgTfeC5cWsswCAWMSGoyb+50YPc4hI+XNfRyNM6ybDkzqkxYICci6/N6EBmpXxGruZWBuw
 QgeFVs7oURJLZOQmTd2R/NxwesL+hloB338F4lrxxuLmHORi7ZlmXkFEoVQGF/n6mQCE=;
Received: from mail-io1-f42.google.com ([209.85.166.42])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1qSyD2-00Frlb-Az for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 07 Aug 2023 11:15:36 +0000
Received: by mail-io1-f42.google.com with SMTP id
 ca18e2360f4ac-77dcff76e35so48629039f.1
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 07 Aug 2023 04:15:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1691406930; x=1692011730;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8Rfav5Nxe+GtybemfHCRLQWJ1Wm1Jr8phC3oTaQ6f/s=;
 b=RhTNRytlTa20t4Y4eQDAbFdSU2B3iJZ1UGQvbDrNgMxM2lZyl06oD16eY7UnwOu7/z
 lhfBO1aEb+iaxXm7zjPBY7hPV/HGsazWxYGeChIQ5BZqNHrYc42N83Qpez7ydwipu9EJ
 dl8ebrZJyA2dXTCWIRLJ5KrUEadehbntFp8yZr0t1mcATZxSPZjFq4Ii0bOe708GiDDw
 sbmlI1kieYrCzo2Qbsl1zLM+PYAlt09SHmpbPtNn98Tc607U0WsJTYx77KWhrtfG5gTM
 J9JKFlnKyLN5gCahSDRWLwC9lXHkDS1fNn6g8aIOpZaiEnR0eJG9fj8gxoamq0eWdy8p
 EjpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691406930; x=1692011730;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8Rfav5Nxe+GtybemfHCRLQWJ1Wm1Jr8phC3oTaQ6f/s=;
 b=DHYMdjKY/84f0LxxWq3EbtxI6Jq1fIAB/LTDfiDy7t4J9Imudtry/lzKAio6AUYQ85
 Tqv4eUKwzZjHRq7g7so5a/Vx8CSdjmFItb9V/9XyysZYGVylwo0A49M0lscSX0BsxL2b
 uRia2i7vn6OlxCuq0iPft3aZsjghLJUPArmI6iftiy8yh7+r4DttdEMQxPNthCn68HWx
 RhJ3XJRqQACUI9oF1jU+KOJEIIx42HOd6QWhdg00Dxk2UAHvXUE4ZsloQQvHcmJ1XQ5h
 Gl9Hi9Q8UAMqYbYEB+TaV7c6UiqGoDvW87YnOUgVafg7EdRpjoQlR+tpeC2eFd8GsoLj
 I1+g==
X-Gm-Message-State: AOJu0YwRIlCxw1XkwqpV5Wb2naRY7LcqZDHVAKYEaD6z0jnLmtLLgWoQ
 MG3WLMjWLE0woQvU935pfU7dng==
X-Google-Smtp-Source: AGHT+IFWvaKty2qg3Zp4xukmaRzjC+XhBT002dXZP422OqSqCh0qrR2HTT2eLu1rJ18Y9R5+7t84vA==
X-Received: by 2002:a92:6408:0:b0:349:5c87:e712 with SMTP id
 y8-20020a926408000000b003495c87e712mr5356429ilb.1.1691406930655; 
 Mon, 07 Aug 2023 04:15:30 -0700 (PDT)
Received: from C02DW0BEMD6R.bytedance.net ([203.208.167.146])
 by smtp.gmail.com with ESMTPSA id
 y13-20020a17090aca8d00b0025be7b69d73sm5861191pjt.12.2023.08.07.04.15.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Aug 2023 04:15:30 -0700 (PDT)
To: akpm@linux-foundation.org, david@fromorbit.com, tkhai@ya.ru,
 vbabka@suse.cz, roman.gushchin@linux.dev, djwong@kernel.org,
 brauner@kernel.org, paulmck@kernel.org, tytso@mit.edu,
 steven.price@arm.com, cel@kernel.org, senozhatsky@chromium.org,
 yujie.liu@intel.com, gregkh@linuxfoundation.org, muchun.song@linux.dev,
 simon.horman@corigine.com, dlemoal@kernel.org
Date: Mon,  7 Aug 2023 19:09:14 +0800
Message-Id: <20230807110936.21819-27-zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20230807110936.21819-1-zhengqi.arch@bytedance.com>
References: <20230807110936.21819-1-zhengqi.arch@bytedance.com>
MIME-Version: 1.0
X-Headers-End: 1qSyD2-00Frlb-Az
Subject: [f2fs-dev] [PATCH v4 26/48] dm: dynamically allocate the dm-bufio
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
 Muchun Song <songmuchun@bytedance.com>, linux-raid@vger.kernel.org,
 linux-nfs@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-erofs@lists.ozlabs.org, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

In preparation for implementing lockless slab shrink, use new APIs to
dynamically allocate the dm-bufio shrinker, so that it can be freed
asynchronously using kfree_rcu(). Then it doesn't need to wait for RCU
read-side critical section when releasing the struct dm_bufio_client.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
Reviewed-by: Muchun Song <songmuchun@bytedance.com>
---
 drivers/md/dm-bufio.c | 28 +++++++++++++++++-----------
 1 file changed, 17 insertions(+), 11 deletions(-)

diff --git a/drivers/md/dm-bufio.c b/drivers/md/dm-bufio.c
index bc309e41d074..62eb27639c9b 100644
--- a/drivers/md/dm-bufio.c
+++ b/drivers/md/dm-bufio.c
@@ -963,7 +963,7 @@ struct dm_bufio_client {
 
 	sector_t start;
 
-	struct shrinker shrinker;
+	struct shrinker *shrinker;
 	struct work_struct shrink_work;
 	atomic_long_t need_shrink;
 
@@ -2368,7 +2368,7 @@ static unsigned long dm_bufio_shrink_scan(struct shrinker *shrink, struct shrink
 {
 	struct dm_bufio_client *c;
 
-	c = container_of(shrink, struct dm_bufio_client, shrinker);
+	c = shrink->private_data;
 	atomic_long_add(sc->nr_to_scan, &c->need_shrink);
 	queue_work(dm_bufio_wq, &c->shrink_work);
 
@@ -2377,7 +2377,7 @@ static unsigned long dm_bufio_shrink_scan(struct shrinker *shrink, struct shrink
 
 static unsigned long dm_bufio_shrink_count(struct shrinker *shrink, struct shrink_control *sc)
 {
-	struct dm_bufio_client *c = container_of(shrink, struct dm_bufio_client, shrinker);
+	struct dm_bufio_client *c = shrink->private_data;
 	unsigned long count = cache_total(&c->cache);
 	unsigned long retain_target = get_retain_buffers(c);
 	unsigned long queued_for_cleanup = atomic_long_read(&c->need_shrink);
@@ -2490,14 +2490,20 @@ struct dm_bufio_client *dm_bufio_client_create(struct block_device *bdev, unsign
 	INIT_WORK(&c->shrink_work, shrink_work);
 	atomic_long_set(&c->need_shrink, 0);
 
-	c->shrinker.count_objects = dm_bufio_shrink_count;
-	c->shrinker.scan_objects = dm_bufio_shrink_scan;
-	c->shrinker.seeks = 1;
-	c->shrinker.batch = 0;
-	r = register_shrinker(&c->shrinker, "dm-bufio:(%u:%u)",
-			      MAJOR(bdev->bd_dev), MINOR(bdev->bd_dev));
-	if (r)
+	c->shrinker = shrinker_alloc(0, "dm-bufio:(%u:%u)",
+				     MAJOR(bdev->bd_dev), MINOR(bdev->bd_dev));
+	if (!c->shrinker) {
+		r = -ENOMEM;
 		goto bad;
+	}
+
+	c->shrinker->count_objects = dm_bufio_shrink_count;
+	c->shrinker->scan_objects = dm_bufio_shrink_scan;
+	c->shrinker->seeks = 1;
+	c->shrinker->batch = 0;
+	c->shrinker->private_data = c;
+
+	shrinker_register(c->shrinker);
 
 	mutex_lock(&dm_bufio_clients_lock);
 	dm_bufio_client_count++;
@@ -2537,7 +2543,7 @@ void dm_bufio_client_destroy(struct dm_bufio_client *c)
 
 	drop_buffers(c);
 
-	unregister_shrinker(&c->shrinker);
+	shrinker_free(c->shrinker);
 	flush_work(&c->shrink_work);
 
 	mutex_lock(&dm_bufio_clients_lock);
-- 
2.30.2



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
