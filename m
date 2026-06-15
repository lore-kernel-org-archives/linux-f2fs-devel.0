Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4EA0CD98CE
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 15 Jun 2026 22:14:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:References:
	Message-ID:To:Date:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=QISalx/uojhsrEfVX4kS0V2ZVjc0r6zg9ZqlmYn2dqw=; b=Qd+9po64FiGXqo2c0bVeX/wSwP
	x0xpvywSEyYNE5kGA/d6+mcoSX6CMbPfXaLMoGt20utSHKLVOFq8u0vo2ojnqAauY/FbTCcDcZKze
	TnYeblxdQLQKYtyoYq2xsE28BcW5hQycXGKbbm9q4XArdSVdUUrGxR/E3WVpP8PA0X70=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wZFZN-0002Rw-11;
	Mon, 15 Jun 2026 22:14:13 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <jaegeuk@kernel.org>) id 1wZFZL-0002Rp-Lg
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 15 Jun 2026 22:14:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=RLxFJdLIql7MbBrnK3QRzh9DIYIv+a6fxnlEY07UEvU=; b=NOfaFejYXaIfh0q26jrlA7E2+7
 s1h6dpwBKYjbp7N5PtZZRkPYLrxLLONBfOnne1wU9QeSL9SNErfAhJsNW3c9bKZ5BrrDsG8ZGP56W
 hkMoEeu48Pz6vU225VnKIMVyFv5L0IKkaqd27EHG9+yRN52o7A1/GxL2ZgHZMU/vRMWg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=RLxFJdLIql7MbBrnK3QRzh9DIYIv+a6fxnlEY07UEvU=; b=QMzSSgq74az82dV25DQV689iiu
 Co1xyhGZMwODT6sTqbq6l1C1OjK0/+TPPSt+CpYNVhV4QPYiueBbYVm+2kGBvYgLPU7wk4ws12hFW
 mWzAecfF7GQc24vuIooLrC/n8wDlNb0+avKKWWdqDYWsun9o2LPhZ7CenhUQaJbNSZWw=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wZFZK-0006yb-Ci for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 15 Jun 2026 22:14:12 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 443436008A
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 15 Jun 2026 22:14:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D252F1F000E9;
 Mon, 15 Jun 2026 22:14:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781561645;
 bh=RLxFJdLIql7MbBrnK3QRzh9DIYIv+a6fxnlEY07UEvU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=chJZr1+b9hEfSzbGrwa4Fal0zaO1PH2oEnOVg4PUWqCpYhnXaCfOz/GBVoesaK8vA
 rVCISAp1P5pg3NfgqHKcOCv5zWnYjbA3+zLAScJwK3PtEy9WEG9efALWC18lwQUfxG
 JgE+lZRtHDeAnKdyb6eVfnUY7EPWykXhbKfOv8LSUvZZxdwombQPj1UCdSjJadE1+R
 lOEpLiT1exgAA+mLzWNb3NR21/4m2v4d2KgELwU3p2cnBgehD+iAL6rgaSjim0HM/y
 MNeodVEAUSnrCO8N/HrIyxWkaG3UvANy5jib52yZ7Ss7+7UcWhgj4khc2kNQdqX6/D
 jh911HJS9EzEA==
Date: Mon, 15 Jun 2026 22:14:03 +0000
To: Chao Yu <chao@kernel.org>
Message-ID: <ajB5K8SPT3Jq9480@google.com>
References: <20260615130822.2576088-1-chao@kernel.org>
 <20260615130822.2576088-4-chao@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260615130822.2576088-4-chao@kernel.org>
X-Headers-End: 1wZFZK-0006yb-Ci
Subject: Re: [f2fs-dev] [PATCH 4/6] f2fs: avoid unnecessary
 fscrypt_finalize_bounce_page()
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
From: Jaegeuk Kim via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 06/15, Chao Yu via Linux-f2fs-devel wrote:
> fscrypt_finalize_bounce_page() should be called only if we use fs layer
> crypto, let's avoid unnecessary fscrypt_finalize_bounce_page() in error
> path of f2fs_write_compressed_pages().
> 
> BTW, fscrypt_finalize_bounce_page() will check mapping of bounced page
> before retrieving original page, so, previously it won't cause any issue
> w/ fscrypt_finalize_bounce_page(), but still we'd better avoid coupling
> w/ any logic inside fscrypt_finalize_bounce_page().
> 
> Signed-off-by: Chao Yu <chao@kernel.org>
> ---
>  fs/f2fs/compress.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
> index caf522d667d6..aaa0813eabcd 100644
> --- a/fs/f2fs/compress.c
> +++ b/fs/f2fs/compress.c
> @@ -1455,10 +1455,12 @@ static int f2fs_write_compressed_pages(struct compress_ctx *cc,
>  out_destroy_crypt:
>  	page_array_free(sbi, cic->rpages, cc->cluster_size);
>  
> -	for (--i; i >= 0; i--) {
> -		if (!cc->cpages[i])
> -			continue;
> -		fscrypt_finalize_bounce_page(&cc->cpages[i]);
> +	if (fio.encrypted) {
> +		for (--i; i >= 0; i--) {
> +			if (!cc->cpages[i])
> +				continue;
> +			fscrypt_finalize_bounce_page(&cc->cpages[i]);
> +		}

Applied as:

--- a/fs/f2fs/compress.c
+++ b/fs/f2fs/compress.c
@@ -1455,6 +1455,9 @@ static int f2fs_write_compressed_pages(struct compress_ctx *cc,
 out_destroy_crypt:
        page_array_free(sbi, cic->rpages, cc->cluster_size);

+       if (!fio.encrypted)
+               goto out_put_cic;
+
        for (--i; i >= 0; i--) {
                if (!cc->cpages[i])
                        continue;


>  	}
>  out_put_cic:
>  	kmem_cache_free(cic_entry_slab, cic);
> -- 
> 2.49.0
> 
> 
> 
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
