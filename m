Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43620C0015E
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 27 Jul 2023 09:16:10 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1qOx6P-0000ZH-NJ;
	Thu, 27 Jul 2023 09:16:09 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <zhengqi.arch@bytedance.com>) id 1qOx6O-0000ZB-6s
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 27 Jul 2023 09:16:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=pSf6nVkdhsvxhtXxVh7cgsa4dxLg7VE+dk8AIIS4uIA=; b=asGlBHI3pXurcFyBKg06o7VkcN
 u5H7RusrF/UZPVVmWqXRXU8DcDQMRxqIKYCU3t15PC2R4tL9CkTnrino3uiznxujlsTeDSxPnjWoG
 rcIPEOLaxOYMr6u9QIt7kBOuqb2TGkXQpmhqPbITiY2HBWAzw0ydXlZcZH2esWhsTMyU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=pSf6nVkdhsvxhtXxVh7cgsa4dxLg7VE+dk8AIIS4uIA=; b=QE98KVDhQ4JFWWdtW0Q1de0UVm
 Q7MCBo/zqGjfnAY3rjDIdhQgYt8laQsK4knlNQezoGCJ0JOsUrLB3OkJ6ftD6SSnKNZ3ZbmoAP/WJ
 ZLMbN/8ltu3whaKNgOEtstjrJM2FS+3qLwOdnkpNZhvKtZpSjQ07fs+J6s0gtGVTb3so=;
Received: from mail-pj1-f53.google.com ([209.85.216.53])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1qOx6K-0007sW-Kr for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 27 Jul 2023 09:16:08 +0000
Received: by mail-pj1-f53.google.com with SMTP id
 98e67ed59e1d1-2659b1113c2so146144a91.1
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu, 27 Jul 2023 02:16:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1690449359; x=1691054159;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=pSf6nVkdhsvxhtXxVh7cgsa4dxLg7VE+dk8AIIS4uIA=;
 b=gs/PU4tG46kQg+lGivKEpQm67BWRBr/3B5K5J0ZjcDJiH4VmN/xAYLr567/KvCeKyO
 Sxv9KoDe1Fgjt2T5xGL5ntjIo2URj6N4iyAFFdnIg9R3abku7q3pHpjtx5uyfVGaAvYO
 XtiYYOqXBfNiFu1rjUbVMMYVt5QxVT4/F43UKIFaCuAs9bCstLLngxCL3ODWliEci9Sz
 ElL4V2hOOxLgo9+060cMLFPSS0lDlqR1ZhVgYCnGDkIpUHSxXftLLIhthhd9SgFzYboG
 fvp5YOTqEFeGRzV75GGLb7yIHnFGlXJ5ArnypIHw3PlhSwR6sQo5O1DaMDPfX3YeBn9C
 fAww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690449359; x=1691054159;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=pSf6nVkdhsvxhtXxVh7cgsa4dxLg7VE+dk8AIIS4uIA=;
 b=Ejr++qhbC7NAMZk99MOA5ks6ah5yjId5v9WyjYXiYosiGOUIHV44ZtYYF3Bt3i1o+7
 Oy4xT++avj2z6FJucqcHlQTfnrT+F60hN/zXzTTxzE0j3nBIx8M9XFMJvrLiiCuvRaxq
 nSh/xDF5g+6RC4KxWUmbYwGiqxKT1Qs7AimeM3jZ2n5r3M4ELzbe78v7+/MgxQuJVt1W
 gpHaC2mYU8BWO5icg56NkxZVNyhFu/XLpBZcxMjb76MOu0ndn/iaUX4gienEDWs/+l1m
 Ck187hxjRRpz3POntDV1P0EbfApPnEe9Wu/RhhV1D+RK/qWGnU6CWCYCh92j9t67zbBt
 /z4A==
X-Gm-Message-State: ABy/qLaidbRs9sa6dGdyiZbwHmIas0wRy02IDQxZfCWXkv+dYM//Kq5q
 vzuloU/j23ywIWrtUREn/UK6DA==
X-Google-Smtp-Source: APBJJlFWNasuQyGNPy0hcIGkgu46yCpujoddgwDeBo2nmYNJTDqcdO/STO03uju2nKSJGm9+FY3b7g==
X-Received: by 2002:a17:90a:7c48:b0:268:38a7:842e with SMTP id
 e8-20020a17090a7c4800b0026838a7842emr4155117pjl.2.1690449358970; 
 Thu, 27 Jul 2023 02:15:58 -0700 (PDT)
Received: from [10.70.252.135] ([203.208.167.147])
 by smtp.gmail.com with ESMTPSA id
 bv21-20020a17090af19500b0026596b8f33asm2403500pjb.40.2023.07.27.02.15.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 Jul 2023 02:15:58 -0700 (PDT)
Message-ID: <8f8aa0d6-8f5c-958d-096d-d4c6d3e71e7a@bytedance.com>
Date: Thu, 27 Jul 2023 17:15:44 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Content-Language: en-US
To: akpm@linux-foundation.org, david@fromorbit.com, tkhai@ya.ru,
 vbabka@suse.cz, roman.gushchin@linux.dev, djwong@kernel.org,
 brauner@kernel.org, paulmck@kernel.org, tytso@mit.edu, steven.price@arm.com,
 cel@kernel.org, senozhatsky@chromium.org, yujie.liu@intel.com,
 gregkh@linuxfoundation.org, muchun.song@linux.dev
References: <20230727080502.77895-1-zhengqi.arch@bytedance.com>
 <20230727080502.77895-30-zhengqi.arch@bytedance.com>
In-Reply-To: <20230727080502.77895-30-zhengqi.arch@bytedance.com>
X-Headers-End: 1qOx6K-0007sW-Kr
Subject: Re: [f2fs-dev] [PATCH v3 29/49] md/raid5: dynamically allocate the
 md-raid5 shrinker
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
 linux-bcache@vger.kernel.org, Muchun Song <songmuchun@bytedance.com>,
 linux-raid@vger.kernel.org, linux-nfs@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-erofs@lists.ozlabs.org, linux-btrfs@vger.kernel.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net



On 2023/7/27 16:04, Qi Zheng wrote:
> In preparation for implementing lockless slab shrink, use new APIs to
> dynamically allocate the md-raid5 shrinker, so that it can be freed
> asynchronously using kfree_rcu(). Then it doesn't need to wait for RCU
> read-side critical section when releasing the struct r5conf.
> 
> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
> Reviewed-by: Muchun Song <songmuchun@bytedance.com>
> ---
>   drivers/md/raid5.c | 25 ++++++++++++++-----------
>   drivers/md/raid5.h |  2 +-
>   2 files changed, 15 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
> index 85b3004594e0..fbb4e6f5ff43 100644
> --- a/drivers/md/raid5.c
> +++ b/drivers/md/raid5.c
> @@ -7414,7 +7414,7 @@ static void free_conf(struct r5conf *conf)
>   
>   	log_exit(conf);
>   
> -	unregister_shrinker(&conf->shrinker);
> +	shrinker_free(conf->shrinker);
>   	free_thread_groups(conf);
>   	shrink_stripes(conf);
>   	raid5_free_percpu(conf);
> @@ -7462,7 +7462,7 @@ static int raid5_alloc_percpu(struct r5conf *conf)
>   static unsigned long raid5_cache_scan(struct shrinker *shrink,
>   				      struct shrink_control *sc)
>   {
> -	struct r5conf *conf = container_of(shrink, struct r5conf, shrinker);
> +	struct r5conf *conf = shrink->private_data;
>   	unsigned long ret = SHRINK_STOP;
>   
>   	if (mutex_trylock(&conf->cache_size_mutex)) {
> @@ -7483,7 +7483,7 @@ static unsigned long raid5_cache_scan(struct shrinker *shrink,
>   static unsigned long raid5_cache_count(struct shrinker *shrink,
>   				       struct shrink_control *sc)
>   {
> -	struct r5conf *conf = container_of(shrink, struct r5conf, shrinker);
> +	struct r5conf *conf = shrink->private_data;
>   
>   	if (conf->max_nr_stripes < conf->min_nr_stripes)
>   		/* unlikely, but not impossible */
> @@ -7718,18 +7718,21 @@ static struct r5conf *setup_conf(struct mddev *mddev)
>   	 * it reduces the queue depth and so can hurt throughput.
>   	 * So set it rather large, scaled by number of devices.
>   	 */
> -	conf->shrinker.seeks = DEFAULT_SEEKS * conf->raid_disks * 4;
> -	conf->shrinker.scan_objects = raid5_cache_scan;
> -	conf->shrinker.count_objects = raid5_cache_count;
> -	conf->shrinker.batch = 128;
> -	conf->shrinker.flags = 0;
> -	ret = register_shrinker(&conf->shrinker, "md-raid5:%s", mdname(mddev));
> -	if (ret) {
> -		pr_warn("md/raid:%s: couldn't register shrinker.\n",
> +	conf->shrinker = shrinker_alloc(0, "md-raid5:%s", mdname(mddev));
> +	if (!conf->shrinker) {

Here should set ret to -ENOMEM, will fix.

> +		pr_warn("md/raid:%s: couldn't allocate shrinker.\n",
>   			mdname(mddev));
>   		goto abort;
>   	}
>   
> +	conf->shrinker->seeks = DEFAULT_SEEKS * conf->raid_disks * 4;
> +	conf->shrinker->scan_objects = raid5_cache_scan;
> +	conf->shrinker->count_objects = raid5_cache_count;
> +	conf->shrinker->batch = 128;
> +	conf->shrinker->private_data = conf;
> +
> +	shrinker_register(conf->shrinker);
> +
>   	sprintf(pers_name, "raid%d", mddev->new_level);
>   	rcu_assign_pointer(conf->thread,
>   			   md_register_thread(raid5d, mddev, pers_name));
> diff --git a/drivers/md/raid5.h b/drivers/md/raid5.h
> index 97a795979a35..22bea20eccbd 100644
> --- a/drivers/md/raid5.h
> +++ b/drivers/md/raid5.h
> @@ -670,7 +670,7 @@ struct r5conf {
>   	wait_queue_head_t	wait_for_stripe;
>   	wait_queue_head_t	wait_for_overlap;
>   	unsigned long		cache_state;
> -	struct shrinker		shrinker;
> +	struct shrinker		*shrinker;
>   	int			pool_size; /* number of disks in stripeheads in pool */
>   	spinlock_t		device_lock;
>   	struct disk_info	*disks;


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
