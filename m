Return-Path: <SRS0=Klf2=NC=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2DCDC4338F
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 11 Aug 2021 13:11:40 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9648060FC0;
	Wed, 11 Aug 2021 13:11:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 9648060FC0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1mDo1D-0003yK-Cx; Wed, 11 Aug 2021 13:11:39 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <chao@kernel.org>) id 1mDo1B-0003y5-TY
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 11 Aug 2021 13:11:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:Reply-To:Cc:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Bv9tnqWEKXDM36RjsKhahEPRYyUpz7d0v2lTmJkm3Ak=; b=KZJ7o3jnTzzTdGbyMQGRbkfvjY
 StgJboLcULWCzr+4/qTL9/RTafqQiyZcTrqfxrnVyEsdaxpwvbEks0mOiho4JspGV4P5moDhJCQUf
 NBnDo/S/5YysmAGPwXpPiWPp8+bo8cn2uqlIcf6WdYX59gw+6Minl5cEhqEgh21n4sa8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:
 Message-ID:From:References:To:Subject:Sender:Reply-To:Cc:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=Bv9tnqWEKXDM36RjsKhahEPRYyUpz7d0v2lTmJkm3Ak=; b=mQLX1QKNDt+ssrak4GIMZv0L1w
 lowT3tV8SrgX6FnyYlQk/E6gd9C3qDAau+SYLTaI0K3NdhWOHzev71GJdp1W18fw5fPkRkWqVYmpZ
 NilADmXmEkV3eCavtg7170HbaW8hAD8+kZ+wB4zZjJVjnf6v6iGgJ3K/3+43vcKZRxCs=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.3)
 id 1mDo18-000678-HN
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 11 Aug 2021 13:11:37 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 53F3E60FC0;
 Wed, 11 Aug 2021 13:11:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1628687489;
 bh=arErSeTxKFOKmwmjY+5nHKiAkbqWd/NLbxTkOpTguIc=;
 h=Subject:To:References:From:Date:In-Reply-To:From;
 b=K/olm6rL23rLY0KTbOPjD9jNPmkoKdXzchCdaLg0gizmhfJIrae7ttIUbDldKjiZK
 spxeyqVtU8lALgGTwFYj0gYgDy0b2NV+3MbZvIs0ybMmrRxsGVPVUyprUV5xLduNFg
 T8gx8L3OTyIHoNgoblRX7xPNOkSO9awieSHUBWfcvvvJPj6R79TBnEo0bQjh9PP9PF
 rEmPN2w63p1l7A0SKy9vN3w2BYzIw6YQnH9kvdhBV6miFMNj1uorTaD2T8XyvjwVOi
 VQf6/GBb2QoKOUkb/8YLu26SvRCpBEXEubDDqTVMwq3NzjWHo/11MOht951q7E0uMe
 L6xk1HtpVgXLw==
To: Fengnan Chang <changfengnan@vivo.com>, jaegeuk@kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
References: <20210811084004.3664-1-changfengnan@vivo.com>
From: Chao Yu <chao@kernel.org>
Message-ID: <05eb345f-96cf-51ee-24cb-335f8d0e6a27@kernel.org>
Date: Wed, 11 Aug 2021 21:11:26 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210811084004.3664-1-changfengnan@vivo.com>
Content-Language: en-US
X-Headers-End: 1mDo18-000678-HN
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: compress: avoid duplicate counting
 of valid blocks when read compressed file
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2021/8/11 16:40, Fengnan Chang wrote:
> Since cluster is basic unit of compression, one cluster is compressed or
> not, so we can calculate valid blocks only for first page in cluster,
> the other pages just skip.
> 
> Signed-off-by: Fengnan Chang <changfengnan@vivo.com>
> ---
>   fs/f2fs/compress.c |  1 +
>   fs/f2fs/data.c     | 21 ++++++++++++++++-----
>   fs/f2fs/f2fs.h     |  1 +
>   3 files changed, 18 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
> index 7dbfd6965b97..71768f15752a 100644
> --- a/fs/f2fs/compress.c
> +++ b/fs/f2fs/compress.c
> @@ -152,6 +152,7 @@ void f2fs_destroy_compress_ctx(struct compress_ctx *cc, bool reuse)
>   	cc->rpages = NULL;
>   	cc->nr_rpages = 0;
>   	cc->nr_cpages = 0;
> +	cc->nc_cluster_idx = NULL_CLUSTER;
>   	if (!reuse)
>   		cc->cluster_idx = NULL_CLUSTER;
>   }
> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> index df5e8d8c654e..3ee1a88d8400 100644
> --- a/fs/f2fs/data.c
> +++ b/fs/f2fs/data.c
> @@ -2294,6 +2294,7 @@ static int f2fs_mpage_readpages(struct inode *inode,
>   		.log_cluster_size = F2FS_I(inode)->i_log_cluster_size,
>   		.cluster_size = F2FS_I(inode)->i_cluster_size,
>   		.cluster_idx = NULL_CLUSTER,
> +		.nc_cluster_idx = NULL_CLUSTER,
>   		.rpages = NULL,
>   		.cpages = NULL,
>   		.nr_rpages = 0,

pgoff_t nc_cluster_idx = NULL_CLUSTER;

> @@ -2331,12 +2332,22 @@ static int f2fs_mpage_readpages(struct inode *inode,
>   				if (ret)
>   					goto set_error_page;
>   			}
> -			ret = f2fs_is_compressed_cluster(inode, page->index);
> -			if (ret < 0)
> -				goto set_error_page;
> -			else if (!ret)
> -				goto read_single_page;
> +			if (cc.cluster_idx == NULL_CLUSTER) {
> +				if (cc.nc_cluster_idx != NULL_CLUSTER &&
> +					cc.nc_cluster_idx == page->index >> cc.log_cluster_size) {

				 if (nc_cluster_idx ==
					page->index >> cc.log_cluster_size)

> +					goto read_single_page;
> +				}
> +
> +				ret = f2fs_is_compressed_cluster(inode, page->index);
> +				if (ret < 0)
> +					goto set_error_page;
> +				else if (!ret) {
> +					cc.nc_cluster_idx = page->index >> cc.log_cluster_size;

					nc_cluster_idx =
						page->index >> cc.log_cluster_size;

> +					goto read_single_page;
> +				}
>   
> +				cc.nc_cluster_idx = NULL_CLUSTER;
> +			}
>   			ret = f2fs_init_compress_ctx(&cc);
>   			if (ret)
>   				goto set_error_page;
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index e97b4d8c5efc..e9b6890a3f19 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -1471,6 +1471,7 @@ struct compress_data {
>   struct compress_ctx {
>   	struct inode *inode;		/* inode the context belong to */
>   	pgoff_t cluster_idx;		/* cluster index number */
> +	pgoff_t nc_cluster_idx;		/* cluster index number for non-compressed cluster use*/

We only use this field in read flow, please add a local variable to record
last cluster index number of non-compressed cluster.

Thanks,

>   	unsigned int cluster_size;	/* page count in cluster */
>   	unsigned int log_cluster_size;	/* log of cluster size */
>   	struct page **rpages;		/* pages store raw data in cluster */
> 


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
