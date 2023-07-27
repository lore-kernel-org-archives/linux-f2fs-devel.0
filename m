Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A46A6C001E0
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 27 Jul 2023 09:07:28 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1qOwxy-0000T6-Fi;
	Thu, 27 Jul 2023 09:07:26 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <zhengqi.arch@bytedance.com>) id 1qOwxu-0000Sz-3i
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 27 Jul 2023 09:07:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=UKiGuCYavgdrONYSlKU+hjlx/AzCB2LKMORbFgw7HEo=; b=OM0KK+NPV1hSU/WXVf3E/Av8Sk
 DwxuYyXUUjRuBz8WInff72AN1f2HnOwQvtMBit2tTC7q2AZ1aHl2nRMk/G+Ad/3oxpPkuRfSkNixG
 uA+ShzsW9l1Z+6GdbOC18k001x7RcZoHtvMv1or6LaCszmmUSwtCye0wVjjY5KPFdtoU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=UKiGuCYavgdrONYSlKU+hjlx/AzCB2LKMORbFgw7HEo=; b=RK2HHx28QS2BevYzWjr/UhdaUC
 kwajFJzrmeu4IpIeVwSYHYOs99zl6IYFRsesMb8KX6mBen6iMa2qFpLgNJZOSqVHK9GnKzYoclQXH
 SmL+xR9HNEhOYMpEu97CfgKSputNXgNn3YGKsIpf+sfjxTkbNDUX1o8xl6F9k/DOKq/U=;
Received: from mail-pg1-f177.google.com ([209.85.215.177])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1qOwxq-0007eD-HR for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 27 Jul 2023 09:07:22 +0000
Received: by mail-pg1-f177.google.com with SMTP id
 41be03b00d2f7-5576ad1b7e7so72524a12.1
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu, 27 Jul 2023 02:07:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1690448833; x=1691053633;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=UKiGuCYavgdrONYSlKU+hjlx/AzCB2LKMORbFgw7HEo=;
 b=DjrROq91sf6Va+7++jhnZLLfMfZ3NpR+vs103Gffs3+O08HW6byjEgnIqMIjx7XVVU
 6Esw8LCCRNx5FIzgZD2yLlNtiJ3fWUXbMzLdc62rKZLebfjHSG7L7jgEMl0D1hE7ZoNg
 HZ2c9Q9i+LL0tt0iImhvHFOK+Hduw2G0dP+6wK+guSG8W2Nz3BegBODQY1lmNQJ14Dz4
 uuXi2h/k5/64PvGOHou6Defqpklm1cGUHs8RqpArf+xI1YmvbpRswY34ry3JAORO90Jx
 4NSzh0j5w+vqWxK/Ia35MiibA4wNxyya8QHOgB3QIdRRJ50Wt48gZu09EVgownqRkh1E
 f6DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690448833; x=1691053633;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=UKiGuCYavgdrONYSlKU+hjlx/AzCB2LKMORbFgw7HEo=;
 b=jg5z7i+omzDDZdg6nLEqx5YjWMv0jN7tsdTfYSL/wR7mnBkPQEwSLLCopXUpGQFMJ/
 aWW2IUA1Qa7jhl81LKwRtXMnhqC0mv2E6SSkTmQB4OZFo5dW4jlfs69qek/S9H94J4ML
 Ag1NQ+5iAqn43zMhN49CRzUYCwfRuWvrm4cuiiZfPXhV8PJL+FnEDEOSfUbHKGDfM07U
 wVX2EkCnKSzbV2PddJRAWD/ArbH9XsoBbG3t0Rvf86y+UxyVMtilZ2vdP4MgAM63beUo
 m8YDnjMi5VFeCYc3aBiNWOHHIp1lrGhAxZ3gUC+oRTa0nD2OPRvggaxNo4hf2y5Q9knk
 8jiA==
X-Gm-Message-State: ABy/qLZVM8TH9V7h800LHQjKAgVeymzOimrA6U0ErSgtxSFSrX3sQ4nf
 BMWRgHYns2qWW/Bpwp3WXoTTsA==
X-Google-Smtp-Source: APBJJlEquEzidizjgrmS1e55j2UU3CMKKyxPnlaVqAXQYQ+ePfvdxx8A4f9JU/BbmCjGKzVhoGuchQ==
X-Received: by 2002:a17:90a:128e:b0:263:25f9:65b2 with SMTP id
 g14-20020a17090a128e00b0026325f965b2mr4139877pja.4.1690448832920; 
 Thu, 27 Jul 2023 02:07:12 -0700 (PDT)
Received: from [10.70.252.135] ([203.208.167.147])
 by smtp.gmail.com with ESMTPSA id
 a11-20020a170902ee8b00b001b7e63cfa19sm1063627pld.234.2023.07.27.02.07.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 Jul 2023 02:07:12 -0700 (PDT)
Message-ID: <19461737-db63-2ab5-110b-e65035881ae2@bytedance.com>
Date: Thu, 27 Jul 2023 17:06:57 +0800
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
 <20230727080502.77895-16-zhengqi.arch@bytedance.com>
In-Reply-To: <20230727080502.77895-16-zhengqi.arch@bytedance.com>
X-Headers-End: 1qOwxq-0007eD-HR
Subject: Re: [f2fs-dev] [PATCH v3 15/49] nfs: dynamically allocate the
 nfs-acl shrinker
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
> Use new APIs to dynamically allocate the nfs-acl shrinker.
> 
> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
> Reviewed-by: Muchun Song <songmuchun@bytedance.com>
> ---
>   fs/nfs/super.c | 20 ++++++++++++--------
>   1 file changed, 12 insertions(+), 8 deletions(-)
> 
> diff --git a/fs/nfs/super.c b/fs/nfs/super.c
> index 2284f749d892..072d82e1be06 100644
> --- a/fs/nfs/super.c
> +++ b/fs/nfs/super.c
> @@ -129,11 +129,7 @@ static void nfs_ssc_unregister_ops(void)
>   }
>   #endif /* CONFIG_NFS_V4_2 */
>   
> -static struct shrinker acl_shrinker = {
> -	.count_objects	= nfs_access_cache_count,
> -	.scan_objects	= nfs_access_cache_scan,
> -	.seeks		= DEFAULT_SEEKS,
> -};
> +static struct shrinker *acl_shrinker;
>   
>   /*
>    * Register the NFS filesystems
> @@ -153,9 +149,17 @@ int __init register_nfs_fs(void)
>   	ret = nfs_register_sysctl();
>   	if (ret < 0)
>   		goto error_2;
> -	ret = register_shrinker(&acl_shrinker, "nfs-acl");
> -	if (ret < 0)
> +
> +	acl_shrinker = shrinker_alloc(0, "nfs-acl");
> +	if (!acl_shrinker)
>   		goto error_3;

Here should set ret to -ENOMEM, will fix.

> +
> +	acl_shrinker->count_objects = nfs_access_cache_count;
> +	acl_shrinker->scan_objects = nfs_access_cache_scan;
> +	acl_shrinker->seeks = DEFAULT_SEEKS;
> +
> +	shrinker_register(acl_shrinker);
> +
>   #ifdef CONFIG_NFS_V4_2
>   	nfs_ssc_register_ops();
>   #endif
> @@ -175,7 +179,7 @@ int __init register_nfs_fs(void)
>    */
>   void __exit unregister_nfs_fs(void)
>   {
> -	unregister_shrinker(&acl_shrinker);
> +	shrinker_free(acl_shrinker);
>   	nfs_unregister_sysctl();
>   	unregister_nfs4_fs();
>   #ifdef CONFIG_NFS_V4_2


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
