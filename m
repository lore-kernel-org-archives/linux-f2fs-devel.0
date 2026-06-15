Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAC7FCD98DA
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 15 Jun 2026 12:05:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=82LDzMdUeaNNOzoBEw2yKk/pEfTaLyMHf5inZOIe2iM=; b=DlKQcFh2RZaIKzkEO3FAd5/kBp
	/dAEp+eOMupmQo1EnGfG2RW7Y+7bWMrUk5Dh3Yte9b4Pob+bqRTWBv+CTwl846/g/l6JRH8RrjWfT
	RFUKhZ+Z4iZeRwLKMyEsVxnEbRYRkbjjCtKtPORMfhzMDxfBLBwYvcAorqC15cTeSQ3M=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wZ64V-00047o-Br;
	Mon, 15 Jun 2026 12:05:44 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1wZ64S-00047i-MC
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 15 Jun 2026 12:05:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=z6dVQCAzyOyljdyHrMfiJSrZaeghmRyqkLpWsGloaSk=; b=MCJclMvwLu4zInqjUCKW4517ah
 ebTiIWAWNnH7RFwhPZTQUrk6qYeu7CJRGmDljm3voFqj6eZDcpLwFV6BGOCahbQuhxCQT8tW4Z1D0
 vDXvJtMn4v0HMUnGWsgDKyz4yNjgzzWIs7DBao+quK1ZOE4RyvZqm+xpfOwGNpDNI/vg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=z6dVQCAzyOyljdyHrMfiJSrZaeghmRyqkLpWsGloaSk=; b=KctGzYuYaSD22qHZ9hNLi26jtN
 tCSoMGzydzHI0906ejfoU2w8Ve/Q4M0AO61RGT3VxyZL4MtkFvR/Je7K78GlesCjhND63aXHViMnQ
 PWWZDwy+GXOgPmtJkWynUqRTiiJ3UJ/0CPwC6nfAi8PtgS+0d2sQ22wECNnVbB3JiPkA=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wZ64R-0002kL-6l for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 15 Jun 2026 12:05:41 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 0A9E360154;
 Mon, 15 Jun 2026 12:05:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71AEB1F000E9;
 Mon, 15 Jun 2026 12:05:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781525128;
 bh=z6dVQCAzyOyljdyHrMfiJSrZaeghmRyqkLpWsGloaSk=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To;
 b=IXW27nCbTTG4r5wfiaSSFfv9NtzRhZRVVYyGPCvZRwIwhdv9AdR4AQ9W0boX4jW5l
 4VrQbKo608wkXaBcBvTDp812gtj5kgwc6p8pr5CdrAQTMrcQsAKptcRQ3VSmmqQ1wI
 KztdYuGxjG5pYsLGGpm6bozL/tU/aiP4mwZs8jXg2gJB4Mj8yQzKW/OxaGo8lWv76e
 W71wGyGTjOKjVTBRkgdgQ7QPVCXThczdqucx0RHBMGv4GJpkE7dfKWmK2G1uma8SSg
 YcMU0iOVidOy4FTOV6oCutsKF49olHnxaJJaMNCLMALVxF9OhthVS6/6aUkioKN0fA
 nAzgvO239kG2Q==
Message-ID: <b380cd69-66db-4ef1-8d33-92ed6c34d263@kernel.org>
Date: Mon, 15 Jun 2026 20:05:25 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Yongpeng Yang <yangyongpeng.storage@gmail.com>,
 Jaegeuk Kim <jaegeuk@kernel.org>
References: <20260612115839.2065903-2-yangyongpeng.storage@gmail.com>
 <20260612115839.2065903-4-yangyongpeng.storage@gmail.com>
Content-Language: en-US
In-Reply-To: <20260612115839.2065903-4-yangyongpeng.storage@gmail.com>
X-Headers-End: 1wZ64R-0002kL-6l
Subject: Re: [f2fs-dev] [PATCH RESEND 3/5] f2fs: punch largest extent
 instead of dropping it entirely on overlap
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
Cc: Yongpeng Yang <yangyongpeng@xiaomi.com>,
 Yongpeng Yang <monty_pavel@sina.com>, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 6/12/26 19:58, Yongpeng Yang wrote:
> From: Yongpeng Yang <yangyongpeng@xiaomi.com>
> 
> Previously, when an extent being inserted overlaps with the largest
> extent, the largest extent is dropped entirely. This was done to handle

Please correct me if I missed anything, I remember that we will add largest
extent in below path?

- __update_extent_tree_range
 - __insert_extent_tree
  - __try_update_largest_extent : update largest w/ right extent
 - __try_update_largest_extent : update largest w/ left extent

Thanks,

> the case where the largest extent is not in memory, avoiding
> inconsistency between the largest extent and the extent tree.
> 
> This patch changes the semantics of __drop_largest_extent (renamed to
> __punch_largest_extent): instead of discarding the entire largest
> extent when any overlap is detected, keep the larger remaining portion
> (left or right) after the punch. This preserves extent cache coverage
> for truncate and overwrite operations that only partially overlap the
> largest extent.
> 
> Signed-off-by: Yongpeng Yang <yangyongpeng@xiaomi.com>
> ---
>  fs/f2fs/extent_cache.c | 31 ++++++++++++++++++++++++-------
>  1 file changed, 24 insertions(+), 7 deletions(-)
> 
> diff --git a/fs/f2fs/extent_cache.c b/fs/f2fs/extent_cache.c
> index f8d94db60dc6..82d84c4e98b2 100644
> --- a/fs/f2fs/extent_cache.c
> +++ b/fs/f2fs/extent_cache.c
> @@ -397,14 +397,31 @@ static unsigned int __free_extent_tree(struct f2fs_sb_info *sbi,
>  	return count;
>  }
>  
> -static void __drop_largest_extent(struct extent_tree *et,
> +static void __punch_largest_extent(struct extent_tree *et,
>  					pgoff_t fofs, unsigned int len)
>  {
> -	if (fofs < (pgoff_t)et->largest.fofs + et->largest.len &&
> -			fofs + len > et->largest.fofs) {
> -		et->largest.len = 0;
> -		et->largest_updated = true;
> +	unsigned int largest_end, punch_end;
> +	unsigned int left_len, right_len;
> +
> +	if (fofs >= (pgoff_t)et->largest.fofs + et->largest.len ||
> +			fofs + len <= et->largest.fofs)
> +		return;
> +
> +	/* Punch [fofs, fofs + len) from largest extent. */
> +	largest_end = et->largest.fofs + et->largest.len;
> +	punch_end = fofs + len;
> +
> +	left_len = fofs > et->largest.fofs ? fofs - et->largest.fofs : 0;
> +	right_len = largest_end > punch_end ? largest_end - punch_end : 0;
> +
> +	if (left_len >= right_len) {
> +		et->largest.len = left_len;
> +	} else {
> +		et->largest.blk += punch_end - et->largest.fofs;
> +		et->largest.fofs = punch_end;
> +		et->largest.len = right_len;
>  	}
> +	et->largest_updated = true;
>  }
>  
>  void f2fs_init_read_extent_tree(struct inode *inode, struct folio *ifolio)
> @@ -680,10 +697,10 @@ static void __update_extent_tree_range(struct inode *inode,
>  		dei.len = 0;
>  
>  		/*
> -		 * drop largest extent before lookup, in case it's already
> +		 * punch largest extent before lookup, in case it's already
>  		 * been shrunk from extent tree
>  		 */
> -		__drop_largest_extent(et, fofs, len);
> +		__punch_largest_extent(et, fofs, len);
>  	}
>  
>  	if (et->largest.len != 0 &&



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
