Return-Path: <SRS0=Ue33=ND=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9538BC4338F
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 12 Aug 2021 03:09:53 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4989160EB9
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 12 Aug 2021 03:09:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 4989160EB9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=vivo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.92.3)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1mE16O-0007ta-RP; Thu, 12 Aug 2021 03:09:52 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.3)
 (envelope-from <changfengnan@vivo.com>) id 1mE16N-0007tT-6x
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 12 Aug 2021 03:09:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:Reply-To:Cc:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=2UKlxuwVPTIb82038/wC01L6+hhIZbL2FzdjkBe3J8w=; b=LxABdoHcH5XDNUrI1UZnF74kud
 1PTpXsJYoSPS91AnzNwfyhwe0ACWVWlEBnifElzcs8KKlSVI6iIHkqEbnQpTdLZfdqsE4ybzBBDhZ
 pKlhvr4WRcwEt4JkbXIoq2aNMfTFeadLHnH3NoWh8zTmgHMCqaByevIkxWtiHxzvAig4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:
 Message-ID:From:References:To:Subject:Sender:Reply-To:Cc:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=2UKlxuwVPTIb82038/wC01L6+hhIZbL2FzdjkBe3J8w=; b=LsuU/AtypeypcYH4ANNtRnkKo5
 ZPYoEiGBAMNVUD0FGU+CpeSAnJ18yxbhPCQTdMPNHPE+zDYvy4UhD2qxHwIpiSolVHFJtxTPUgVdI
 ln9O6JOc1VuGc2idGWaq/Vlzpdo442ova6UxXslPl9ACn08lScDjQlYmv40GIYboKju0=;
Received: from mail-m17654.qiye.163.com ([59.111.176.54])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.3)
 id 1mE16K-00030W-EE
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 12 Aug 2021 03:09:51 +0000
Received: from [172.25.44.145] (unknown [58.251.74.232])
 by mail-m17654.qiye.163.com (Hmail) with ESMTPA id 3D4DF20144;
 Thu, 12 Aug 2021 11:09:40 +0800 (CST)
To: jaegeuk@kernel.org, chao@kernel.org, linux-f2fs-devel@lists.sourceforge.net
References: <20210812030540.259344-1-changfengnan@vivo.com>
From: Fengnan Chang <changfengnan@vivo.com>
Message-ID: <f70080dd-1764-0b36-9a2f-65fc1aa72a2a@vivo.com>
Date: Thu, 12 Aug 2021 11:09:39 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210812030540.259344-1-changfengnan@vivo.com>
Content-Language: en-US
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgPGg8OCBgUHx5ZQUlOS1dZCBgUCR5ZQVlLVUtZV1
 kWDxoPAgseWUFZKDYvK1lXWShZQUhPN1dZLVlBSVdZDwkaFQgSH1lBWRkeSRhWTRgZSkxCGEJNGU
 8fVRMBExYaEhckFA4PWVdZFhoPEhUdFFlBWU9LSFVKSktISkxVS1kG
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6PS46Ijo6Oj9LTCEzF08eCAtJ
 PygwC1FVSlVKTUlDTEhMTENLTE1KVTMWGhIXVRgTGhUcHR4VHBUaFTsNEg0UVRgUFkVZV1kSC1lB
 WU5DVUlOSlVMT1VJSElZV1kIAVlBSEhMSjcG
X-HM-Tid: 0a7b38563a95d9fdkuws3d4df20144
X-Headers-End: 1mE16K-00030W-EE
Subject: Re: [f2fs-dev] [PATCH v3] f2fs: compress: avoid duplicate counting
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

mistake, forget this...

On 2021/8/12 11:05, Fengnan Chang wrote:
> Since cluster is basic unit of compression, one cluster is compressed or
> not, so we can calculate valid blocks only for first page in cluster,
> the other pages just skip.
> 
> Signed-off-by: Fengnan Chang <changfengnan@vivo.com>
> ---
>   fs/f2fs/data.c | 23 ++++++++++++++++++-----
>   1 file changed, 18 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> index df5e8d8c654e..b06a0e5de1f1 100644
> --- a/fs/f2fs/data.c
> +++ b/fs/f2fs/data.c
> @@ -2299,6 +2299,7 @@ static int f2fs_mpage_readpages(struct inode *inode,
>   		.nr_rpages = 0,
>   		.nr_cpages = 0,
>   	};
> +	pgoff_t nc_cluster_idx = NULL_CLUSTER;
>   #endif
>   	unsigned nr_pages = rac ? readahead_count(rac) : 1;
>   	unsigned max_nr_pages = nr_pages;
> @@ -2328,15 +2329,26 @@ static int f2fs_mpage_readpages(struct inode *inode,
>   							&last_block_in_bio,
>   							rac != NULL, false);
>   				f2fs_destroy_compress_ctx(&cc, false);
> +				nc_cluster_idx = NULL_CLUSTER;
>   				if (ret)
>   					goto set_error_page;
>   			}
> -			ret = f2fs_is_compressed_cluster(inode, page->index);
> -			if (ret < 0)
> -				goto set_error_page;
> -			else if (!ret)
> -				goto read_single_page;
> +			if (cc.cluster_idx == NULL_CLUSTER) {
> +				if (nc_cluster_idx != NULL_CLUSTER &&
> +					nc_cluster_idx == page->index >> cc.log_cluster_size) {
> +					goto read_single_page;
> +				}
> +
> +				ret = f2fs_is_compressed_cluster(inode, page->index);
> +				if (ret < 0)
> +					goto set_error_page;
> +				else if (!ret) {
> +					nc_cluster_idx = page->index >> cc.log_cluster_size;
> +					goto read_single_page;
> +				}
>   
> +				nc_cluster_idx = NULL_CLUSTER;
> +			}
>   			ret = f2fs_init_compress_ctx(&cc);
>   			if (ret)
>   				goto set_error_page;
> @@ -2373,6 +2385,7 @@ static int f2fs_mpage_readpages(struct inode *inode,
>   							&last_block_in_bio,
>   							rac != NULL, false);
>   				f2fs_destroy_compress_ctx(&cc, false);
> +				nc_cluster_idx = NULL_CLUSTER;
>   			}
>   		}
>   #endif
> 


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
