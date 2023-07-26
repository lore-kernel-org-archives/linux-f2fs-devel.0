Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C34C2C001E0
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 26 Jul 2023 06:49:30 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1qOYKw-0002ky-3P;
	Wed, 26 Jul 2023 06:49:29 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <muchun.song@linux.dev>) id 1qOYKu-0002km-Mx
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 26 Jul 2023 06:49:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=07kRInGgcVMiksfMsun8p4HGvWms170mUSINrsZDIPU=; b=maMkCBUOLYOIjH+dKQSxOapz3x
 eZYzJ9bnPxzKKXoCQP8+xPDz1RA/4Z3mVCnHkD5CrTmHD1Ct//z/Ql/7BEJtkYEJIgyrGEU+BUK9H
 idXtzFxRDqmPQUvOdW49n7cLVZ2eXxTbNxUBN3T8GD+sCLLUrvX/4qzkuPm1vsDmMFAw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=07kRInGgcVMiksfMsun8p4HGvWms170mUSINrsZDIPU=; b=bpwTMoBLLO7Yd2aGHlvy31o9F1
 DEH9vf3Iard2k5azTnoizewA++c1Ry8+2VDApUkfnwmPcH9rBCcY5l+aq//mv4kEGb70+wd1qPwMx
 mdldooySWOhr7VaC94WUxu1EtZdAR+DGtv40xEdH7FE0LA6VDyyXlIY2Wf/biuhEDj4Y=;
Received: from out-20.mta0.migadu.com ([91.218.175.20])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1qOYKr-0006qI-Cn for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 26 Jul 2023 06:49:27 +0000
Message-ID: <e7204276-9de5-17eb-90ae-e51657d73ef4@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1690354158;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=07kRInGgcVMiksfMsun8p4HGvWms170mUSINrsZDIPU=;
 b=SItOX2s1O2xRbklfqsU1E20kPvGPKi6lNjfeuPsz787gwDukUtasKQC+RRJ78xAQZyjij6
 0JlhE8ny7YCW/WIa1zfjcf/R7sJjT11NiI0YLFw4BmC6xi+4P258FcCDYig5b0NazpkEtw
 pJl7w1nj4tDpMcmLDY8eVxmHbXISOTw=
Date: Wed, 26 Jul 2023 14:49:05 +0800
MIME-Version: 1.0
To: Qi Zheng <zhengqi.arch@bytedance.com>
References: <20230724094354.90817-1-zhengqi.arch@bytedance.com>
 <20230724094354.90817-12-zhengqi.arch@bytedance.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <20230724094354.90817-12-zhengqi.arch@bytedance.com>
X-Migadu-Flow: FLOW_OUT
X-Headers-End: 1qOYKr-0006qI-Cn
Subject: Re: [f2fs-dev] [PATCH v2 11/47] gfs2: dynamically allocate the
 gfs2-qd shrinker
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
Cc: kvm@vger.kernel.org, djwong@kernel.org, roman.gushchin@linux.dev,
 david@fromorbit.com, dri-devel@lists.freedesktop.org,
 virtualization@lists.linux-foundation.org, linux-mm@kvack.org,
 dm-devel@redhat.com, linux-mtd@lists.infradead.org, cel@kernel.org,
 x86@kernel.org, steven.price@arm.com, cluster-devel@redhat.com,
 xen-devel@lists.xenproject.org, linux-ext4@vger.kernel.org, paulmck@kernel.org,
 linux-arm-msm@vger.kernel.org, brauner@kernel.org, rcu@vger.kernel.org,
 linux-bcache@vger.kernel.org, yujie.liu@intel.com, vbabka@suse.cz,
 linux-raid@vger.kernel.org, linux-nfs@vger.kernel.org, tytso@mit.edu,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org,
 senozhatsky@chromium.org, gregkh@linuxfoundation.org,
 linux-fsdevel@vger.kernel.org, akpm@linux-foundation.org,
 linux-erofs@lists.ozlabs.org, linux-btrfs@vger.kernel.org, tkhai@ya.ru
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net



On 2023/7/24 17:43, Qi Zheng wrote:
> Use new APIs to dynamically allocate the gfs2-qd shrinker.
>
> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
> ---
>   fs/gfs2/main.c  |  6 +++---
>   fs/gfs2/quota.c | 26 ++++++++++++++++++++------
>   fs/gfs2/quota.h |  3 ++-
>   3 files changed, 25 insertions(+), 10 deletions(-)
>
> diff --git a/fs/gfs2/main.c b/fs/gfs2/main.c
> index afcb32854f14..e47b1cc79f59 100644
> --- a/fs/gfs2/main.c
> +++ b/fs/gfs2/main.c
> @@ -147,7 +147,7 @@ static int __init init_gfs2_fs(void)
>   	if (!gfs2_trans_cachep)
>   		goto fail_cachep8;
>   
> -	error = register_shrinker(&gfs2_qd_shrinker, "gfs2-qd");
> +	error = gfs2_qd_shrinker_init();
>   	if (error)
>   		goto fail_shrinker;
>   
> @@ -196,7 +196,7 @@ static int __init init_gfs2_fs(void)
>   fail_wq2:
>   	destroy_workqueue(gfs_recovery_wq);
>   fail_wq1:
> -	unregister_shrinker(&gfs2_qd_shrinker);
> +	gfs2_qd_shrinker_exit();
>   fail_shrinker:
>   	kmem_cache_destroy(gfs2_trans_cachep);
>   fail_cachep8:
> @@ -229,7 +229,7 @@ static int __init init_gfs2_fs(void)
>   
>   static void __exit exit_gfs2_fs(void)
>   {
> -	unregister_shrinker(&gfs2_qd_shrinker);
> +	gfs2_qd_shrinker_exit();
>   	gfs2_glock_exit();
>   	gfs2_unregister_debugfs();
>   	unregister_filesystem(&gfs2_fs_type);
> diff --git a/fs/gfs2/quota.c b/fs/gfs2/quota.c
> index 704192b73605..bc9883cea847 100644
> --- a/fs/gfs2/quota.c
> +++ b/fs/gfs2/quota.c
> @@ -186,13 +186,27 @@ static unsigned long gfs2_qd_shrink_count(struct shrinker *shrink,
>   	return vfs_pressure_ratio(list_lru_shrink_count(&gfs2_qd_lru, sc));
>   }
>   
> -struct shrinker gfs2_qd_shrinker = {
> -	.count_objects = gfs2_qd_shrink_count,
> -	.scan_objects = gfs2_qd_shrink_scan,
> -	.seeks = DEFAULT_SEEKS,
> -	.flags = SHRINKER_NUMA_AWARE,
> -};
> +static struct shrinker *gfs2_qd_shrinker;
> +
> +int gfs2_qd_shrinker_init(void)

It's better to declare this as __init.

> +{
> +	gfs2_qd_shrinker = shrinker_alloc(SHRINKER_NUMA_AWARE, "gfs2-qd");
> +	if (!gfs2_qd_shrinker)
> +		return -ENOMEM;
> +
> +	gfs2_qd_shrinker->count_objects = gfs2_qd_shrink_count;
> +	gfs2_qd_shrinker->scan_objects = gfs2_qd_shrink_scan;
> +	gfs2_qd_shrinker->seeks = DEFAULT_SEEKS;
> +
> +	shrinker_register(gfs2_qd_shrinker);
>   
> +	return 0;
> +}
> +
> +void gfs2_qd_shrinker_exit(void)
> +{
> +	shrinker_unregister(gfs2_qd_shrinker);
> +}
>   
>   static u64 qd2index(struct gfs2_quota_data *qd)
>   {
> diff --git a/fs/gfs2/quota.h b/fs/gfs2/quota.h
> index 21ada332d555..f9cb863373f7 100644
> --- a/fs/gfs2/quota.h
> +++ b/fs/gfs2/quota.h
> @@ -59,7 +59,8 @@ static inline int gfs2_quota_lock_check(struct gfs2_inode *ip,
>   }
>   
>   extern const struct quotactl_ops gfs2_quotactl_ops;
> -extern struct shrinker gfs2_qd_shrinker;
> +int gfs2_qd_shrinker_init(void);
> +void gfs2_qd_shrinker_exit(void);
>   extern struct list_lru gfs2_qd_lru;
>   extern void __init gfs2_quota_hash_init(void);
>   



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
