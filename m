Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00332C433EF
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 11 Jul 2022 09:24:59 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.94.2)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1oApew-00063M-RY; Mon, 11 Jul 2022 09:24:53 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <chao@kernel.org>) id 1oApew-00063G-2d
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 11 Jul 2022 09:24:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=HzCyzJ+nVKte7IK8x14kvYH00+yL+bVjEESrenCtLrI=; b=YEQxnTYK/ew1KLsTg2s2/+IIDh
 59t2vfeadOCjDlBbj16+VBxB7VcmoF5mdz2QetRiGVEoI8xKz4JqdSDBMjn/2eEDcV6MTWp+A5c6R
 nuYuIiNiAwusk5eOjNNqzX+D5l1RA2bQvwE+aZmV1aXAet4onZNG1SDorc/zFiiI1bP0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=HzCyzJ+nVKte7IK8x14kvYH00+yL+bVjEESrenCtLrI=; b=mEa6CyGbzIvOTJYTb41MVk3SBn
 4fW3Sbm9AcDvSqNoD/A0j5zn7kG15NbrtqcIXBlTrhX+gCTxtPG3gyXEWpPiXriRYtCqGrseuBQd2
 go1Y/MMnQQRchySvq89qSZg35XC7ZjaVIl83yRuaT8OwVEcwAhf13+CVB7J79+9J3Yuw=;
Received: from ams.source.kernel.org ([145.40.68.75])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.94.2)
 id 1oApet-0003s4-MX
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 11 Jul 2022 09:24:52 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 6C223B80D2C;
 Mon, 11 Jul 2022 09:24:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E3BFC341CB;
 Mon, 11 Jul 2022 09:24:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1657531484;
 bh=zkacY6vW0FF9XBE9iSa0Lxf5GkfEIRoGe/st9whmwCE=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=WGeeCMfWqgExmXafkvUruvEgFGH8RuwqCXWBiLwUc72pQ0wOaNPXV7aZ2JsgRNvF+
 1g1jxOOZP2WlKnlnencogVp6JPzDH4QOSLAh/7qOsSTTj5W76kzsyQBsaVV32B2fdf
 fMoNFJasxzxwH2jKS6nspptGdhpa3JnFnYCmXxVmnFHoAsupy9qm2EZPjXfEpTTj+H
 b9XkY/x+oTKseLc38TkPKtE+2+K599g5gjHZ4gUio9V+gn24NlUFNBtWy2+4SQrRYZ
 XLTMDSKmRY/DmOfRyAEHKWjtZVXVZKa5ajicRoQCmk2lsbkfWv0Skgb03aorJm9UfC
 HRmAStk0pOedQ==
Message-ID: <1d2c1281-58ab-5f73-d089-b221bbc5c03a@kernel.org>
Date: Mon, 11 Jul 2022 17:24:38 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Content-Language: en-US
To: Fengnan Chang <changfengnan@vivo.com>, jaegeuk@kernel.org
References: <20220507081710.117162-1-changfengnan@vivo.com>
 <20220507081710.117162-2-changfengnan@vivo.com>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20220507081710.117162-2-changfengnan@vivo.com>
X-Headers-End: 1oApet-0003s4-MX
Subject: Re: [f2fs-dev] [PATCH v2 1/3] f2fs: intorduce
 f2fs_all_cluster_page_ready
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

On 2022/5/7 16:17, Fengnan Chang wrote:
> When write total cluster, all pages is uptodate, there is not need to call
> f2fs_prepare_compress_overwrite, intorduce f2fs_all_cluster_page_ready
> to avoid this.
> 
> Signed-off-by: Fengnan Chang <changfengnan@vivo.com>
> ---
>   fs/f2fs/compress.c | 11 ++++++++---
>   fs/f2fs/data.c     |  9 +++++++--
>   fs/f2fs/f2fs.h     |  4 ++--
>   3 files changed, 17 insertions(+), 7 deletions(-)
> 
> diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
> index 12a56f9e1572..fd28844aa53f 100644
> --- a/fs/f2fs/compress.c
> +++ b/fs/f2fs/compress.c
> @@ -871,20 +871,25 @@ bool f2fs_cluster_can_merge_page(struct compress_ctx *cc, pgoff_t index)
>   	return is_page_in_cluster(cc, index);
>   }
>   
> -bool f2fs_all_cluster_page_loaded(struct compress_ctx *cc, struct pagevec *pvec,
> -				int index, int nr_pages)
> +bool f2fs_all_cluster_page_ready(struct compress_ctx *cc, struct pagevec *pvec,
> +				int index, int nr_pages, bool uptodate)
>   {
>   	unsigned long pgidx;
>   	int i;
>   
> +	if (uptodate && (pgidx % cc->cluster_size))
> +		return false;

How about adding comments here to describe the logic if @update is true.

> +
>   	if (nr_pages - index < cc->cluster_size)
>   		return false;
>   
>   	pgidx = pvec->pages[index]->index;
>   
> -	for (i = 1; i < cc->cluster_size; i++) {
> +	for (i = 0; i < cc->cluster_size; i++) {

@i should be assigned differently according to @update?

>   		if (pvec->pages[index + i]->index != pgidx + i)
>   			return false;
> +		if (uptodate && !PageUptodate(pvec->pages[index + i]))
> +			return false;
>   	}
>   
>   	return true;
> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> index 9a1a526f2092..77af65838a7c 100644
> --- a/fs/f2fs/data.c
> +++ b/fs/f2fs/data.c
> @@ -2967,6 +2967,11 @@ static int f2fs_write_cache_pages(struct address_space *mapping,
>   				if (!f2fs_cluster_is_empty(&cc))
>   					goto lock_page;
>   
> +				if (f2fs_all_cluster_page_ready(&cc,
> +					&pvec, i, nr_pages, true)) {
> +					goto lock_page;
> +				}

./scripts/checkpatch.pl mentioned that:

braces {} are not necessary for single statement blocks

Thanks,

> +
>   				ret2 = f2fs_prepare_compress_overwrite(
>   							inode, &pagep,
>   							page->index, &fsdata);
> @@ -2977,8 +2982,8 @@ static int f2fs_write_cache_pages(struct address_space *mapping,
>   				} else if (ret2 &&
>   					(!f2fs_compress_write_end(inode,
>   						fsdata, page->index, 1) ||
> -					 !f2fs_all_cluster_page_loaded(&cc,
> -						&pvec, i, nr_pages))) {
> +					 !f2fs_all_cluster_page_ready(&cc,
> +						&pvec, i, nr_pages, false))) {
>   					retry = 1;
>   					break;
>   				}
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index 38cbed0f544e..5a33f2d4aee8 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -4177,8 +4177,8 @@ void f2fs_end_read_compressed_page(struct page *page, bool failed,
>   							block_t blkaddr);
>   bool f2fs_cluster_is_empty(struct compress_ctx *cc);
>   bool f2fs_cluster_can_merge_page(struct compress_ctx *cc, pgoff_t index);
> -bool f2fs_all_cluster_page_loaded(struct compress_ctx *cc, struct pagevec *pvec,
> -				int index, int nr_pages);
> +bool f2fs_all_cluster_page_ready(struct compress_ctx *cc, struct pagevec *pvec,
> +				int index, int nr_pages, bool uptodate);
>   bool f2fs_sanity_check_cluster(struct dnode_of_data *dn);
>   void f2fs_compress_ctx_add_page(struct compress_ctx *cc, struct page *page);
>   int f2fs_write_multi_pages(struct compress_ctx *cc,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
