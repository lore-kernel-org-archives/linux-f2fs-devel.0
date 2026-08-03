Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5830BC55162
	for <linux-f2fs-devel@archiver.kernel.org>; Mon,  3 Aug 2026 07:11:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Content-Transfer-Encoding:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=R3ZOeIuUMsvKDwPoKO2H5zm5Brc8Cr5stzFf7vE26x4=; b=ei6kr4u1c8bmlz4egRYqiVR+G3
	dMaYFq7w1QF6CSsielq36QnoJr8xowE0t0CPXS4Not7CXsPrVLpaoyuz3oW9/URyystwUs5+63RIY
	gnVkSJnTHMMvn+i/J6GxgrBJkNM5Yrz4glXcS1UAPaF7rCmSC9AY1HTt6JApfpllUgJA=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wqmpl-00068t-Kf;
	Mon, 03 Aug 2026 07:11:35 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1wqmpj-00068l-Vs
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 03 Aug 2026 07:11:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=NJ7nl8dcHY8k0ENQaf/dyHcHE+K3mSom6ovue7pM26Y=; b=bUzwTlwKhq1KwdV9tc6yvo9thu
 +RCUrKh/Ao9m4Yff9gpyKyd6HF0T6Hsn/W3yy9aJcqsbSMQnVe4iFjV10wRRWfWRs3iKEZbxfXaBy
 bfzyeLm0olC5PCx7Y/o/hs3sDui1AzE97MpqmKgcnfwOu8CQttzeJ/K3mUJN88F2ejeM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=NJ7nl8dcHY8k0ENQaf/dyHcHE+K3mSom6ovue7pM26Y=; b=h0c+Yb5tTzrs2hF6qXQh0/u6gV
 M3N0MuOx3jUu0bkNZs4x13XYshm4wOdUrXadi10JJuS7Z1MkNz35r0LxIzwP8s6zn+SlVJILwyxIm
 u4KH7lnjuXbIHXeTNADaghI43SIX3n+Zae6liH/tfFImcIaWmI+EfAme8WnC5pxhCGqY=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wqmpk-00068n-7o for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 03 Aug 2026 07:11:33 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 34DB9408B3;
 Mon,  3 Aug 2026 07:11:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D40301F000E9;
 Mon,  3 Aug 2026 07:11:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785741087;
 bh=NJ7nl8dcHY8k0ENQaf/dyHcHE+K3mSom6ovue7pM26Y=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To;
 b=VtqZi1tK5vwQPRPPU0glFH7m+l1CbHexHPIxPn/bKfOPKYHXbh9utHcAf9c79fcjl
 N71AtjDn897+J4gIuiBTcOwZkw1s7HPfg4TKivRkgjmeEHeff0IfES5eGV8gwG+LEd
 CpQl3SnbWsl0/hO8m22SdqbNGkhMCoXXbDLBmtwoi215uYLrhCF8aT9+vPj/4Nqiio
 cuFY7EUlBMokai2MZNbFYcX9J5kIcqjZ+PvA8CFmxuS7w7VqGdLq3nGea10jHUeARX
 Ha8XAvNxb9ZFFSfqCaDJ+YZollre7IVOr+fXPwX2SoAiBP12NK1X7FUcn/2Y8lcpsQ
 9dVw7lpicZkVA==
Message-ID: <a2f3ace1-73ba-4180-9004-859b14b14cb6@kernel.org>
Date: Mon, 3 Aug 2026 15:11:23 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Chen Changcheng <chenchangcheng@kylinos.cn>, jaegeuk@kernel.org
References: <20260722005447.10885-1-chenchangcheng@kylinos.cn>
Content-Language: en-US
In-Reply-To: <20260722005447.10885-1-chenchangcheng@kylinos.cn>
X-Headers-End: 1wqmpk-00068n-7o
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix valid block count leak on data
 block allocation failure
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
From: Chao Yu via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Chao Yu <chao@kernel.org>
Cc: ccc194101@163.com, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 7/22/26 08:54, Chen Changcheng wrote:
> In __allocate_data_block(), when allocating a new data block
> (dn->data_blkaddr == NULL_ADDR), inc_valid_block_count() is
> called first to increment total_valid_block_count and i_blocks.
> If the subsequent f2fs_allocate_data_block() fails, the function
> returns the error directly without rolling back the
> already-incremented block counts, causing a permanent leak.
> 
> Fix this by calling dec_valid_block_count() to undo the
> increment before returning the error. The condition
> old_blkaddr == NULL_ADDR precisely identifies the case where
> inc_valid_block_count() was called.
> 

Needs fixes and Cc stable line?

> Signed-off-by: Chen Changcheng <chenchangcheng@kylinos.cn>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

> ---
>   fs/f2fs/data.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> index a765fda71536..819631bb61ae 100644
> --- a/fs/f2fs/data.c
> +++ b/fs/f2fs/data.c
> @@ -1532,8 +1532,11 @@ static int __allocate_data_block(struct dnode_of_data *dn, int seg_type)
>   	old_blkaddr = dn->data_blkaddr;
>   	err = f2fs_allocate_data_block(sbi, NULL, old_blkaddr,
>   				&dn->data_blkaddr, &sum, seg_type, NULL);
> -	if (err)
> +	if (err) {
> +		if (old_blkaddr == NULL_ADDR)
> +			dec_valid_block_count(sbi, dn->inode, count);
>   		return err;
> +	}
>   
>   	if (GET_SEGNO(sbi, old_blkaddr) != NULL_SEGNO)
>   		f2fs_invalidate_internal_cache(sbi, old_blkaddr, 1);



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
