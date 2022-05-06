Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75A7AC433F5
	for <linux-f2fs-devel@archiver.kernel.org>; Fri,  6 May 2022 08:01:55 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.94.2)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1nmsuN-0002P6-SR; Fri, 06 May 2022 08:01:52 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <chao@kernel.org>) id 1nmsuM-0002OX-PL
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 06 May 2022 08:01:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=wgGb/JFK09+GItDE90xES64x75Q9KI4e3kNt4hhHLF4=; b=CAq8hKSfEDmYr3GTRqHiIGVoZ8
 nxibnzO9QDmRwVBRd+0QuYB09TtoPNEk+LMf00wsUf+8DLpibN0Ude//1bqkdnCKKzmkQKcYpxJXS
 ZCBnIK0Ntbf7a7063jZumFA6IGBwTg0tONNuaJYRkXeGkmqmKCUBU8/Lp31Hs26IgrlY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=wgGb/JFK09+GItDE90xES64x75Q9KI4e3kNt4hhHLF4=; b=deQoKUcPUu7pENrvoZ1Qfco6+7
 91zVMjxw2bYf4wYghmLyf1iGZl5q8Uxhh8qGEc8VnLAUbapwE9RAqREd3zKSi0L3r+H2uVnNdG3Fp
 rvrIoW2/n6aqm8ADjo9tPAe7QY4BujOWETvtMSBOii3dL3PJMQZ55XFDv9uJww1NNBL0=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.94.2)
 id 1nmsuI-0002Xl-PE
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 06 May 2022 08:01:50 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 8F51261FE4;
 Fri,  6 May 2022 08:01:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 158B4C385AA;
 Fri,  6 May 2022 08:01:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1651824092;
 bh=JAt1TTtTjt58YN5LbbkT53VYtZTsM21jyKg0UAliY/0=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=ae6FUXVDqSrNrqVi184MURHdi0aaM3gl/g+uBemYv3kpJqTc9ZJK6iLwEjb007OVa
 P3KrrTrR7esDbZ+7aro0P8k16/XbWxbh+7V2pYNKeuZPs3Mv0fdiegq/edgnyrgF/f
 8XL3IsTKOUfiitBo1QJNo3gz0QF0qsiVY/DvUQfovyW/Ayr6LvILIhhRoHc9oexTiC
 Ogxvjcb2Z810VK0+ezhdweB4Gx9rUA38goCE+Br1Drr1JHcF7eF9QZXgfiuy/jX94F
 mTRvVwFz2CeJfpUqb/ptRJOp14M5BhoJO381rkWeGugY0A1qpOfgA7FO8p+dRFjXwr
 w5DsbPu+BqZcA==
Message-ID: <0721375f-89cb-2603-18c3-f151e1c6e735@kernel.org>
Date: Fri, 6 May 2022 16:01:28 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Content-Language: en-US
To: Fengnan Chang <changfengnan@vivo.com>, jaegeuk@kernel.org
References: <20220429065446.208019-1-changfengnan@vivo.com>
 <20220429065446.208019-2-changfengnan@vivo.com>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20220429065446.208019-2-changfengnan@vivo.com>
X-Headers-End: 1nmsuI-0002Xl-PE
Subject: Re: [f2fs-dev] [PATCH 1/3] f2fs: intorduce
 f2fs_all_cluster_page_uptodate
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
Cc: linux-f2fs-devel@lists.sourceforge.net
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2022/4/29 14:54, Fengnan Chang wrote:
> Intorduce f2fs_all_cluster_page_uptodate, try to reduce call
> f2fs_prepare_compress_overwrite.

Hmm... it's better to describe in which case newly introduced
function can improve performance...

> 
> Signed-off-by: Fengnan Chang <changfengnan@vivo.com>
> ---
>   fs/f2fs/compress.c | 23 ++++++++++++++++++++++-
>   fs/f2fs/data.c     |  5 +++++
>   fs/f2fs/f2fs.h     |  2 ++
>   3 files changed, 29 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
> index 12a56f9e1572..11499fd3dd6b 100644
> --- a/fs/f2fs/compress.c
> +++ b/fs/f2fs/compress.c
> @@ -871,6 +871,28 @@ bool f2fs_cluster_can_merge_page(struct compress_ctx *cc, pgoff_t index)
>   	return is_page_in_cluster(cc, index);
>   }
>   
> +bool f2fs_all_cluster_page_uptodate(struct compress_ctx *cc, struct pagevec *pvec,
> +				int index, int nr_pages)

Is it possible to merge f2fs_all_cluster_page_uptodate and
f2fs_all_cluster_page_loaded() into a common function, something like:
f2fs_all_cluster_page_ready(bool update)?

Thanks,

> +{
> +	unsigned long pgidx;
> +	int i;
> +
> +	pgidx = pvec->pages[index]->index;
> +	if (pgidx % cc->cluster_size)
> +		return false;
> +
> +	if (nr_pages - index < cc->cluster_size)
> +		return false;
> +
> +	for (i = 0; i < cc->cluster_size; i++) {
> +		if (pvec->pages[index + i]->index != pgidx + i)
> +			return false;
> +		if (!PageUptodate(pvec->pages[index + i]))
> +			return false;
> +	}
> +
> +	return true;
> +}
>   bool f2fs_all_cluster_page_loaded(struct compress_ctx *cc, struct pagevec *pvec,
>   				int index, int nr_pages)
>   {
> @@ -881,7 +903,6 @@ bool f2fs_all_cluster_page_loaded(struct compress_ctx *cc, struct pagevec *pvec,
>   		return false;
>   
>   	pgidx = pvec->pages[index]->index;
> -
>   	for (i = 1; i < cc->cluster_size; i++) {
>   		if (pvec->pages[index + i]->index != pgidx + i)
>   			return false;
> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> index 9a1a526f2092..b8204d91fed4 100644
> --- a/fs/f2fs/data.c
> +++ b/fs/f2fs/data.c
> @@ -2967,6 +2967,11 @@ static int f2fs_write_cache_pages(struct address_space *mapping,
>   				if (!f2fs_cluster_is_empty(&cc))
>   					goto lock_page;
>   
> +				if (f2fs_all_cluster_page_uptodate(&cc,
> +					&pvec, i, nr_pages)) {
> +					goto lock_page;
> +				}
> +
>   				ret2 = f2fs_prepare_compress_overwrite(
>   							inode, &pagep,
>   							page->index, &fsdata);
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index 38cbed0f544e..b4bed1e983bb 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -4180,6 +4180,8 @@ bool f2fs_cluster_can_merge_page(struct compress_ctx *cc, pgoff_t index);
>   bool f2fs_all_cluster_page_loaded(struct compress_ctx *cc, struct pagevec *pvec,
>   				int index, int nr_pages);
>   bool f2fs_sanity_check_cluster(struct dnode_of_data *dn);
> +bool f2fs_all_cluster_page_uptodate(struct compress_ctx *cc, struct pagevec *pvec,
> +				int index, int nr_pages);
>   void f2fs_compress_ctx_add_page(struct compress_ctx *cc, struct page *page);
>   int f2fs_write_multi_pages(struct compress_ctx *cc,
>   						int *submitted,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
