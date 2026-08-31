Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DCEEC61DD3
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 31 Aug 2026 23:23:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Content-Transfer-Encoding:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=rZM7OSMzGqyKPcXVj9zCS5tDPqcbUs+yNHuPM93be8I=; b=HSQVARCfVjvRHJ5jYaWyO04F1Z
	jf7LHg/ZijMbvPgPWg4LcDO54WXdEyVOLiPpLztGPzBVZ1xHulUvSABK09hbNBj2SFgnLorpZeDHC
	u3EVeIHqvkEPtTD1Adiophqj4jGw1QSbKN6oOTkPnt7IVHgL4V3C3+7SxAovOB051GIo=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1x1BL7-0006xw-So;
	Mon, 31 Aug 2026 23:22:58 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1x1BL7-0006xq-16
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 31 Aug 2026 23:22:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=b0crU32oQYq0He/VQq4cZn+2RrawFTTcSZI7lulAOgw=; b=Q/rj2ujbRmdJzkrkCUbQ/Fw4ez
 FMi5rzn/k3c3hcS5dEH8vhJ9+d0cl7ABjx1I/dLf2JvaBH78SiHCPOHUr5fQ4GUN24oChDZeMBV6b
 Ktb33JHSstbD9IRbski0weIbAlEwQz3uqawDve32DZy+QWBEJ2cv7g3yiktrT1iV5huw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=b0crU32oQYq0He/VQq4cZn+2RrawFTTcSZI7lulAOgw=; b=QLQ3Mr40z2ZedeATbolIo4XAtl
 cAIxkZHGGIywTcIZ3uqVIpT9H0olT26KtUTFv4x+BrOtJWBmzeexI730rssgLkX/4d5medtg+C6nB
 CODRg3aDn5FReUhNv0w6KVAItQVl/t3WSowGBKAtN+qnGDvGwmJX5I+Sla9FI4OWzdWs=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1x1BL7-0001Tx-0l for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 31 Aug 2026 23:22:57 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 585CA601DE;
 Mon, 31 Aug 2026 23:22:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E16721F000E9;
 Mon, 31 Aug 2026 23:22:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788218571;
 bh=b0crU32oQYq0He/VQq4cZn+2RrawFTTcSZI7lulAOgw=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To;
 b=DlrcnXPjxBRgnRKdrAXyXDxZT99KhqASelhOnznvAClT5n2WSFgOnbGtjc585Zxs+
 hljNLydLacoDEZjONP+MPd27sZsYF0SNxV3OcJhexqhzgWRpjMJaMqvuy4b71Lt86U
 g3+YX98mElq/o0YYM/ao6bRwfgdUnsudopbZVRsrGURONa3K/WfMV7ztLOe/27dHND
 Ot+tu66uRyFj3+yg0srgf0cTlDy/gIoWQ1CICSBChWss+iscObJB+Qu3UCEZGf/++p
 S6cIr4T6L8sQ+sWj3W3QiTAhKowN73rTSmyGkTVgZbauKW5JFAs5WvbJQGQX9qkqu0
 w1x51S8mj0lpQ==
Message-ID: <9134210e-8ce6-4b74-bc25-af024aabeb75@kernel.org>
Date: Tue, 1 Sep 2026 07:22:46 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Xinping Zhang <zhangxp1998@gmail.com>,
 linux-f2fs-devel@lists.sourceforge.net
References: <CAH=xXfFVAwQ3r_NdUDtmXhtg6Lw8kDWoNTzGL5oy4mwHMsJLJw@mail.gmail.com>
 <CAH=xXfG2Hzc-kNAPqEUsTJ4hwrQ-gYEnFrXHGxL7qpYpggkLUQ@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAH=xXfG2Hzc-kNAPqEUsTJ4hwrQ-gYEnFrXHGxL7qpYpggkLUQ@mail.gmail.com>
X-Headers-End: 1x1BL7-0001Tx-0l
Subject: Re: [f2fs-dev] [PATCH 1/5] f2fs: avoid underflow when counting free
 NIDs
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
Cc: jaegeuk@kernel.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Kelvin,

This patch was wrapped, please resend it as well.

On 8/27/26 05:39, Xinping Zhang wrote:
> __count_free_nids() subtracts the retention threshold before checking
> whether the cached count exceeds it. The operands are unsigned, so a
> smaller cache wraps before the result is assigned to long.
> 
> The PAGE_SIZE-derived threshold happens to make this an unsigned long
> subtraction, whose wrapped result becomes negative when converted to
> long by supported toolchains. Do not rely on operand width or
> unsigned-to-signed conversion. Compare values before subtracting.
> 
> Signed-off-by: Kelvin Zhang <zhangxp1998@gmail.com>
> ---
>   fs/f2fs/shrinker.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/f2fs/shrinker.c b/fs/f2fs/shrinker.c
> index 4f6bf5926de4..1fd0ee4f89a9 100644
> --- a/fs/f2fs/shrinker.c
> +++ b/fs/f2fs/shrinker.c
> @@ -23,9 +23,10 @@ static unsigned long __count_nat_entries(struct
> f2fs_sb_info *sbi)
> 
>   static unsigned long __count_free_nids(struct f2fs_sb_info *sbi)
>   {
> -	long count = NM_I(sbi)->nid_cnt[FREE_NID] - MAX_FREE_NIDS;
> +	unsigned long count = NM_I(sbi)->nid_cnt[FREE_NID];
> +	unsigned long max = MAX_FREE_NIDS;
> 
> -	return count > 0 ? count : 0;
> +	return count > max ? count - max : 0;
>   }
> 
>   static unsigned long __count_extent_cache(struct f2fs_sb_info *sbi,



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
