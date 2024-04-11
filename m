Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35765CD128A
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 11 Apr 2024 09:05:25 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1ruqN2-0005Vc-2j;
	Thu, 11 Apr 2024 09:05:24 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1ruqMz-0005VL-Gk
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 11 Apr 2024 09:05:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Cc:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=XQZmTIiStEon0CnpXiktaKE6Ut6+CU7KkMOtYyxaHgM=; b=dOE8flcV056e3MAf+DYgxZaulQ
 KoP2AK6ciTV0PUFQmAQkCOOCqVW+7qPmYx8YA1lvjXiUf7zrDtMit9El6IWio9hBD6C8sgggCZCUQ
 Et76Ld7IpdmPbMEhHXA2w0XQFI3NytevQS9sqifUGRjPW6AiWr4OcotYg6JXPaAS/aok=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Cc:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=XQZmTIiStEon0CnpXiktaKE6Ut6+CU7KkMOtYyxaHgM=; b=PaQrZinwMABS0HPVYEbCEL5K8f
 Qp4RRU6h+XX9VIBgo5wBUAsh83Z13TLfbvSzeXRpnCo3EndyDirpa5wwUNXiTXOZfMxUeZMFg+GLT
 vsR5PfEeyZKoJoe4AS3U7ZRKz1TT2UcxyVk2IDKqtJciK0Bl1dgq1o7OL+QqZCjzc9pw=;
Received: from sin.source.kernel.org ([145.40.73.55])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1ruqMz-0008UT-2d for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 11 Apr 2024 09:05:22 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id 99248CE2F9D
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu, 11 Apr 2024 09:05:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 078E6C433F1;
 Thu, 11 Apr 2024 09:05:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1712826313;
 bh=kMvhQuZC30TP4MfIzzmEHSrl3gDxXwvdJvDmpU7NQxk=;
 h=Date:Subject:To:References:From:In-Reply-To:From;
 b=PD62E+FEblbbBz7OCHJPMaWWym+ESOgLHoVMpc4GgJqQ7M2yIgiCPstpZ6hems4lm
 Nhy3CGAiGKrSioCgdmHfFgssfuOJ2+BKog0Ihtlu4ds4Qkxfjy8wd/W7GPsWjGvlJp
 VUhHStomiR5R8z6HyNhDCWS2smUx5zF6nqreamLWUrMMCWhS02XV1CY89RP42Co5HR
 xsR4zw1h2F8lIeK/HFQZd4x7QybXLgCdfLbkb4HmoMj6GY0th29FWgjPMvPYjrIwvb
 dQwQol3rQfel1e6iO/035uIaGHdRwdFZkEwisz0vqkQaqYTU023fHs7mBuziJqUTSj
 AGCMnzL/0cIVw==
Message-ID: <59414941-a15f-4eb0-8574-3b2a27d8ae69@kernel.org>
Date: Thu, 11 Apr 2024 17:05:10 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
References: <20240409203411.1885121-1-jaegeuk@kernel.org>
 <20240409203411.1885121-2-jaegeuk@kernel.org>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20240409203411.1885121-2-jaegeuk@kernel.org>
X-Headers-End: 1ruqMz-0008UT-2d
Subject: Re: [f2fs-dev] [PATCH 2/3] f2fs: clear writeback when compression
 failed
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

On 2024/4/10 4:34, Jaegeuk Kim wrote:
> Let's stop issuing compressed writes and clear their writeback flags.
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> ---
>   fs/f2fs/compress.c | 33 +++++++++++++++++++++++++++++++--
>   1 file changed, 31 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
> index d67c471ab5df..3a8ecc6aee84 100644
> --- a/fs/f2fs/compress.c
> +++ b/fs/f2fs/compress.c
> @@ -1031,6 +1031,25 @@ static void set_cluster_writeback(struct compress_ctx *cc)
>   	}
>   }
>   
> +static void cancel_cluster_writeback(struct compress_ctx *cc, int submitted)
> +{
> +	int i;
> +
> +	for (i = 0; i < cc->cluster_size; i++) {
> +		if (!cc->rpages[i])
> +			continue;
> +		if (i < submitted) {
> +			if (i)
> +				f2fs_wait_on_page_writeback(cc->rpages[i],
> +						DATA, true, true);
> +			inode_inc_dirty_pages(cc->inode);
> +			lock_page(cc->rpages[i]);
> +		}
> +		clear_page_private_gcing(cc->rpages[i]);
> +		end_page_writeback(cc->rpages[i]);
> +	}
> +}
> +
>   static void set_cluster_dirty(struct compress_ctx *cc)
>   {
>   	int i;
> @@ -1232,7 +1251,6 @@ static int f2fs_write_compressed_pages(struct compress_ctx *cc,
>   		.page = NULL,
>   		.encrypted_page = NULL,
>   		.compressed_page = NULL,
> -		.submitted = 0,
>   		.io_type = io_type,
>   		.io_wbc = wbc,
>   		.encrypted = fscrypt_inode_uses_fs_layer_crypto(cc->inode) ?
> @@ -1358,7 +1376,15 @@ static int f2fs_write_compressed_pages(struct compress_ctx *cc,
>   			fio.compressed_page = cc->cpages[i - 1];
>   
>   		cc->cpages[i - 1] = NULL;
> +		fio.submitted = 0;
>   		f2fs_outplace_write_data(&dn, &fio);
> +		if (unlikely(!fio.submitted)) {
> +			cancel_cluster_writeback(cc, i);
> +
> +			/* To call fscrypt_finalize_bounce_page */
> +			i = cc->valid_nr_cpages;

*submitted = 0; ?

Thanks,

> +			goto out_destroy_crypt;
> +		}
>   		(*submitted)++;
>   unlock_continue:
>   		inode_dec_dirty_pages(cc->inode);
> @@ -1392,8 +1418,11 @@ static int f2fs_write_compressed_pages(struct compress_ctx *cc,
>   out_destroy_crypt:
>   	page_array_free(cc->inode, cic->rpages, cc->cluster_size);
>   
> -	for (--i; i >= 0; i--)
> +	for (--i; i >= 0; i--) {
> +		if (!cc->cpages[i])
> +			continue;
>   		fscrypt_finalize_bounce_page(&cc->cpages[i]);
> +	}
>   out_put_cic:
>   	kmem_cache_free(cic_entry_slab, cic);
>   out_put_dnode:


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
