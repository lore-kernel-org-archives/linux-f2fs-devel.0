Return-Path: <SRS0=svdC=MO=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 052C6C63793
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 22 Jul 2021 13:47:58 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BFC9761289;
	Thu, 22 Jul 2021 13:47:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFC9761289
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1m6Z3N-00011y-A6; Thu, 22 Jul 2021 13:47:57 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <chao@kernel.org>) id 1m6Z3L-00011g-LG
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 22 Jul 2021 13:47:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:Reply-To:Cc:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=0GJCLLGGJjQPcG4yH+nB8HKX4qcRyq+JCEmTdZ7tbus=; b=fVkK76RjkZRSdvBBczX/yrywr4
 uamoV4OyuMBwJafgtGm8ldLM1CA2DvlVJEC+zAfX5oxhwJ8SBuq/lP3O5XJ9GTcedVabZtf3z8pIq
 qJBzOkd4oN67PLkYt+HZrpDJiSFTHM5jHKdIfRAHx2wIPTrMfIHgZ1OHx9UFys90GAEI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:
 Message-ID:From:References:To:Subject:Sender:Reply-To:Cc:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=0GJCLLGGJjQPcG4yH+nB8HKX4qcRyq+JCEmTdZ7tbus=; b=JJu8bHLZH4eSJTPmTKFEv/S1wF
 Utm7Yd1cyCepDyRiFPZVg7BhA1mIOcD+J3+j83/KYX775aLUK9VDefFsTlhSVIGs09sKh2NhSrU+r
 j0HAx3GeKMF/IZwrgfgTrSeCTiZKTn5iSAqHT1DHU0K+cTV0Nt/VTyAPFy/7e6yRWVHY=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.3)
 id 1m6Z3F-00GslC-F3
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 22 Jul 2021 13:47:55 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6779461289;
 Thu, 22 Jul 2021 13:47:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1626961664;
 bh=wvbLKx4nZnPU27RIBJ+pgeZXKoXE2qGCVC4sQCpera8=;
 h=Subject:To:References:From:Date:In-Reply-To:From;
 b=gv974Z7kGnntqRmw0Kgnevkc+KwLsZnb5EjawqOu0i2j63khE0ezpZ5KZ3NbpX+Gr
 uBOs2898Qb/9vSWvGrkbfyKPLyMPfbgzV9cc3uLV3bT5sHya6ZeITxFXvm6O9/8SMY
 mUIO8vqWwbfQkIFpZ94t1c2tQUqFf9SzglY0VFa5pLyqy7Y3Oju2aJQSxj/IxOUPEn
 Xg93QhOXKEpipNgKiOKmrYm7J5aNMC22a7k9LZhrlSHoBDSEIN3rRGawObagsP/lO2
 D/ypbtgbYud1XuzcNlWT7k9H08J39kH4318gmRQAv9KQ3XIIwhrJ5RswSB6mbdQATU
 OCrwM0C4Whxyg==
To: Fengnan Chang <changfengnan@vivo.com>, jaegeuk@kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
References: <20210722032536.150423-1-changfengnan@vivo.com>
From: Chao Yu <chao@kernel.org>
Message-ID: <b2ce8000-226e-6dfa-0052-36cb2faeaf3a@kernel.org>
Date: Thu, 22 Jul 2021 21:47:42 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210722032536.150423-1-changfengnan@vivo.com>
Content-Language: en-US
X-Headers-End: 1m6Z3F-00GslC-F3
Subject: Re: [f2fs-dev] [RFC PATCH] f2fs: compress: avoid duplicate counting
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

On 2021/7/22 11:25, Fengnan Chang wrote:
> Since cluster is basic unit of compression, one cluster is compressed or
> not, so we can calculate valid blocks only for first page in cluster, the
> other pages just skip.
> 
> Signed-off-by: Fengnan Chang <changfengnan@vivo.com>
> ---
>   fs/f2fs/data.c | 13 +++++++------
>   1 file changed, 7 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> index d2cf48c5a2e4..a0099d8329f0 100644
> --- a/fs/f2fs/data.c
> +++ b/fs/f2fs/data.c
> @@ -2304,12 +2304,13 @@ static int f2fs_mpage_readpages(struct inode *inode,
>   				if (ret)
>   					goto set_error_page;
>   			}
> -			ret = f2fs_is_compressed_cluster(inode, page->index);
> -			if (ret < 0)
> -				goto set_error_page;
> -			else if (!ret)
> -				goto read_single_page;

How about truncation races with read?

Thanks,

> -
> +			if (cc.cluster_idx == NULL_CLUSTER) {
> +				ret = f2fs_is_compressed_cluster(inode, page->index);
> +				if (ret < 0)
> +					goto set_error_page;
> +				else if (!ret)
> +					goto read_single_page;
> +			}
>   			ret = f2fs_init_compress_ctx(&cc);
>   			if (ret)
>   				goto set_error_page;
> 


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
