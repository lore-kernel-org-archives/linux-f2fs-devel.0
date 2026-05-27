Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA512CD5BD0
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 27 May 2026 14:02:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:In-Reply-To:From:References:To:MIME-Version:Date:Message-ID:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GyzmN37LciitmknuQh9AzCDqmauMejGVod4oOzP9gNc=; b=Gv2BX3tl7I1LiV2vMtwwIr4xjk
	qTItcGlcI11GlbIF/aokjyvzgXZTva145uM64/OdbfKtebqUH69N1qa/NOaaF21TkJepX0M1P/2+x
	fnqhXWOcTL5Un68y4Xw7aF/Nl03nFlazbEZaoMzAgcdRu3S7FwfOGVnXRCpX7iuLrkeA=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wSEqB-0007Rm-5v;
	Wed, 27 May 2026 14:02:35 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <monty_pavel@sina.com>) id 1wSEpt-0007RT-Gj
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 27 May 2026 14:02:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=gZ2cZAa3qsYv2bi3Gm/IDhB9pcQHr57/fM8cDrL7NEs=; b=ifEvjJccpBVKfwRnvVktBzJDit
 MrlKSVzZleCh7j2qrco3OUCFKCF4md523qvJu6APYEz4LemuVRLnvasj46AVDkU0hWX2cfuw89wKO
 TgwP/3MQUCczHUMqKPnHodcF/g8TEzGhyLgGRlvrLIudT6sLCgm2HndvXNI/Z2mYnguA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=gZ2cZAa3qsYv2bi3Gm/IDhB9pcQHr57/fM8cDrL7NEs=; b=BAAq5Hux/S5b1y1CehutXNDLyV
 MlNrBMTGwuFvHNv4LZeEDNbi7SQZTjcmyum01iDKMUGCYPZU+BNAngtx+psabQg+tNL8ct6scdIkk
 3sKi390W6TopDVO6xlbIOvjlk8S2sabP7yVyrv9bV7Yr9neJVd5qd92AetI0g9FRwsOk=;
Received: from smtp153-165.sina.com.cn ([61.135.153.165])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wSEpr-0003Ds-N7 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 27 May 2026 14:02:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208;
 t=1779890536; bh=gZ2cZAa3qsYv2bi3Gm/IDhB9pcQHr57/fM8cDrL7NEs=;
 h=Message-ID:Date:Subject:From;
 b=zE9z/iB7xGtALuVcFxmAYlGBjUs1zTMUFeQJj5EhSWxpEPfz7A+um65I+jxSC79AW
 ECfNBPBZP6CO9RjjLI8h8g1PoqFQoPIQthIfb9BO/g8vAtQt+dZ76log+vL4HtLO6S
 gUOmSJ8n4P/dzJBJQ2piRLbE3jhtAgekhP6deEmE=
X-SMAIL-HELO: [10.189.138.37]
Received: from unknown (HELO [10.189.138.37])([114.247.175.249])
 by sina.com (10.54.253.32) with ESMTP
 id 6A16F95C000051AE; Wed, 27 May 2026 22:02:06 +0800 (CST)
X-Sender: monty_pavel@sina.com
X-Auth-ID: monty_pavel@sina.com
Authentication-Results: sina.com; spf=none smtp.mailfrom=monty_pavel@sina.com;
 dkim=none header.i=none;
 dmarc=none action=none header.from=monty_pavel@sina.com
X-SMAIL-MID: 9131724456643
X-SMAIL-UIID: 94FBB82B6B4A4BD4B0BE192E748C5013-20260527-220206-1
Message-ID: <e5f8972c-0a34-49ce-9d85-0a63af487599@sina.com>
Date: Wed, 27 May 2026 22:02:04 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Chao Yu <chao@kernel.org>, Jaegeuk Kim <jaegeuk@kernel.org>
References: <20260522082013.3716237-2-monty_pavel@sina.com>
Content-Language: en-US
From: Yongpeng Yang <monty_pavel@sina.com>
In-Reply-To: <20260522082013.3716237-2-monty_pavel@sina.com>
X-Headers-End: 1wSEpr-0003Ds-N7
Subject: Re: [f2fs-dev] [PATCH 1/5] f2fs: fix extent merge failure when
 largest extent is not in rb-tree
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
Cc: Yongpeng Yang <yangyongpeng@xiaomi.com>,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 5/22/26 16:20, Yongpeng Yang wrote:
> From: Yongpeng Yang <yangyongpeng@xiaomi.com>
> 
> The following scenario can cause fiemap to report incorrect extents:
> 
> $ mkfs.f2fs /dev/vdb -f
> $ mount -o mode=lfs /dev/vdb /mnt/f2fs/
> $ dd if=/dev/urandom of=data bs=4K count=874 conv=notrunc
> $ f2fs_io fiemap 0 1000000 data 1
> $ shrink all extent
> $ dd if=/dev/urandom of=data bs=4K count=150 seek=874 conv=notrunc
> $ f2fs_io fiemap 0 1000000 data 1
> Fiemap: offset = 0 len = 1000000
>         logical addr.    physical addr.   length           flags
> 0       0000000000000000 00000002868d4000 000000000036a000 00001000
> 1       000000000036a000 0000000286c3e000 0000000000096000 00001001
> 
> The root cause is that when the largest extent is not in the extent
> tree, mergeable extents are not merged, causing f2fs_map_blocks to
> misjudge and output an incorrect extent list.
> 
> Fix this by allowing the extent being inserted to merge with the largest
> extent. When updating the extent tree range, if the new extent can be
> front-merged or back-merged with the largest extent and the largest
> extent is not in the rb-tree, merge them before the normal lookup.
> 
> Fixes: 429511cdf8b3 ("f2fs: add core functions for rb-tree extent cache")
> Signed-off-by: Yongpeng Yang <yangyongpeng@xiaomi.com>
> ---
>  fs/f2fs/extent_cache.c | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
> 
> diff --git a/fs/f2fs/extent_cache.c b/fs/f2fs/extent_cache.c
> index 61f6b9714366..aa368a01b035 100644
> --- a/fs/f2fs/extent_cache.c
> +++ b/fs/f2fs/extent_cache.c
> @@ -702,6 +702,27 @@ static void __update_extent_tree_range(struct inode *inode,
>  		__drop_largest_extent(et, fofs, len);
>  	}
>  
> +	if (et->largest.len != 0 &&
> +			(__is_front_mergeable(tei, &et->largest, type) ||
> +			 __is_back_mergeable(tei, &et->largest, type))) {
> +		/* 0. try to merge with largest extent. */
> +		en = __lookup_extent_node_ret(&et->root,
> +				et->cached_en, et->largest.fofs,
> +				&prev_en, &next_en,
> +				&insert_p, &insert_parent,
> +				&leftmost);
> +		if (!en) {
> +			if (__is_back_mergeable(tei, &et->largest, type)) {
> +				tei->fofs = et->largest.fofs;
> +				tei->blk = et->largest.blk;
> +				fofs = tei->fofs;
> +			}
> +			tei->len += et->largest.len;
> +			len = tei->len;
> +			end = fofs + len;
> +		}
> +	}
> +
>  	/* 1. lookup first extent node in range [fofs, fofs + len - 1] */
>  	en = __lookup_extent_node_ret(&et->root,
>  					et->cached_en, fofs,

ping



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
