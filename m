Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A585CC55162
	for <linux-f2fs-devel@archiver.kernel.org>; Mon,  3 Aug 2026 02:33:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Content-Transfer-Encoding:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=t7cYAvLwLwMg3uf0IwQCAZA2eeY9D1dNWnm5x5FQMBc=; b=A0nTcsqRZhUhw6bYo/Gsh7lhK7
	ep6nNSs+ny4GHEjozpVbWq2ycWcN0otAXWLpYF29A4D4TT3E/DBGk90VR8TlVnBTbDmEjJLwdYL1p
	FEBcOM60MIcSLHU4B4QODFt/2Vr/1xqh5Lh0//r5qh4y+LUTs9PhycWTFB+0IkcwDaHE=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wqiUE-00023L-Rx;
	Mon, 03 Aug 2026 02:33:07 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1wqiUD-00023D-Sf
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 03 Aug 2026 02:33:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=yUUdgUi+9aMNWWibyppTVdNTC32O/HmK8pKq6gK212Q=; b=K7SaeiIHioMQBCjTGRiQUKsquw
 8czrk0GodcLqSARja7rH+l+BanhiZii69cgoskjHLnwVSkNjp2VcEsYNgIG3bmg09spN+i/4sS/6J
 +z0dUnKhbo9QuiDM6vgXe0lQ13ViWu2PNpiJC1MJwjyA293ylhAjFYoUqE1cnL+nj168=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=yUUdgUi+9aMNWWibyppTVdNTC32O/HmK8pKq6gK212Q=; b=aWiQ/utEs+bkdMMKTncukaJTXi
 KtDlL3qlskh7mfwXwnlRnGD6nHt5+8uscT+DqPcqKE6tBZuUszvhjnJ9R5+YxMtmJuGP34rq7HHV+
 9HAYE6JLIGrYK4AARCgp/T9raBHXQUZRUB5Emrc6u93CLNiqWuaHedY5rCTJ5lGxNJZo=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wqiUH-00053q-Bb for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 03 Aug 2026 02:33:06 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 50F9E405C1;
 Mon,  3 Aug 2026 02:33:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEF341F000E9;
 Mon,  3 Aug 2026 02:32:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785724380;
 bh=yUUdgUi+9aMNWWibyppTVdNTC32O/HmK8pKq6gK212Q=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To;
 b=Ef3ViM9pSMIfreQIIEC9pPGLP+7/OPPV0udEOcit73/Uz+Yu9q3MVI9hR1sCX38A4
 w0T4VWfguB2A+1pn1YgyHp21hz21RgbYQxvKGz10v/upc3SGkfbDk/0F0BNzFWCB+8
 L2aXGLYSghrlEaCmAbD9Fb1L712TJnZgsBv7+MuSWD6ZmNzs9W5zRmTHQMK2FTvIGj
 rVbR2QUTgP/SfebomAOW0sSJUzwd9ZFIunpXru2vOTsKpWcdNXNCi8h0jRWsBx45wW
 1JiZVbN0QahgHkHMBwpfTUoLdkfxcit7GT4TG7jCUa3Kz/yx38Pi9pociVOmpI+QPf
 fEJAVVwzz1Q4g==
Message-ID: <4549a2d6-f512-4f34-a6bd-5e7324f037ad@kernel.org>
Date: Mon, 3 Aug 2026 10:32:56 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Wenjie Qi <qwjhust@gmail.com>, jaegeuk@kernel.org
References: <20260616125219.1396871-1-qiwenjie@xiaomi.com>
Content-Language: en-US
In-Reply-To: <20260616125219.1396871-1-qiwenjie@xiaomi.com>
X-Headers-End: 1wqiUH-00053q-Bb
Subject: Re: [f2fs-dev] [PATCH] f2fs: account compressed writeback by raw
 folio type
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
Cc: qiwenjie@xiaomi.com, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 6/16/26 20:52, Wenjie Qi wrote:
> Compressed writeback is always charged as F2FS_WB_CP_DATA today because
> WB_DATA_TYPE() is called with compressed_page set.  That is wrong for
> normal compressed file writeback; the CP guarantee belongs to the raw
> pagecache folio, not the compressed bounce page.

IIUC, I changed compressed writeback guaranteed by checkpoint to avoid
compressed cluster corruption when encountering power off recovery after
fsync/sync.

I didn't get why it's wrong to set F2FS_WB_CP_DATA for compressed page,
can you please explain more?

Thanks,

> 
> Use the raw folio for the writeback count type.  Also keep one raw page
> under writeback until the compressed end_io callback is done using sbi,
> as normal compressed writeback is no longer protected by the CP-data
> counter.
 > > Signed-off-by: Wenjie Qi <qiwenjie@xiaomi.com>
> ---
> QEMU/KASAN tested with compress_mode=fs and compress_mode=user, using
> concurrent 1MiB compressed writes and a background sync loop.  The user
> mode case also ran F2FS_IOC_COMPRESS_FILE and fsync.  No dmesg splat was
> reported and fsck.f2fs passed after unmount.
> 
>   fs/f2fs/compress.c | 34 +++++++++++++++++++++++++++-------
>   fs/f2fs/data.c     |  2 +-
>   2 files changed, 28 insertions(+), 8 deletions(-)
> 
> diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
> index 91855d91bbdd..be9483b9a401 100644
> --- a/fs/f2fs/compress.c
> +++ b/fs/f2fs/compress.c
> @@ -1487,9 +1487,19 @@ void f2fs_compress_write_end_io(struct bio *bio, struct folio *folio)
>   	struct page *page = &folio->page;
>   	struct f2fs_sb_info *sbi = bio->bi_private;
>   	struct compress_io_ctx *cic = folio->private;
> -	enum count_type type = WB_DATA_TYPE(folio, true);
> +	unsigned int offset = folio->index & (cic->nr_rpages - 1);
> +	struct page *last_page = NULL;
> +	enum count_type type;
>   	int i;
>   
> +	if (unlikely(!offset || offset >= cic->nr_rpages ||
> +		     !cic->rpages[offset])) {
> +		f2fs_bug_on(sbi, 1);
> +		type = F2FS_WB_CP_DATA;
> +	} else {
> +		type = WB_DATA_TYPE(page_folio(cic->rpages[offset]), false);
> +	}
> +
>   	if (unlikely(bio->bi_status != BLK_STS_OK))
>   		mapping_set_error(cic->inode->i_mapping, -EIO);
>   
> @@ -1501,21 +1511,31 @@ void f2fs_compress_write_end_io(struct bio *bio, struct folio *folio)
>   	}
>   
>   	for (i = 0; i < cic->nr_rpages; i++) {
> -		WARN_ON(!cic->rpages[i]);
> +		if (WARN_ON(!cic->rpages[i]))
> +			continue;
> +		last_page = cic->rpages[i];
> +	}
> +
> +	for (i = 0; i < cic->nr_rpages; i++) {
> +		if (!cic->rpages[i])
> +			continue;
>   		clear_page_private_gcing(cic->rpages[i]);
> -		end_page_writeback(cic->rpages[i]);
> +
> +		if (cic->rpages[i] != last_page)
> +			end_page_writeback(cic->rpages[i]);
>   	}
>   
>   	page_array_free(sbi, cic->rpages, cic->nr_rpages);
>   	kmem_cache_free(cic_entry_slab, cic);
>   
>   	/*
> -	 * Make sure dec_page_count() is the last access to sbi.
> -	 * Once it drops the F2FS_WB_CP_DATA counter to zero, the
> -	 * unmount thread can proceed to destroy sbi and
> -	 * sbi->page_array_slab.
> +	 * Keep all sbi accesses before the last raw page writeback is
> +	 * released, so an unmount thread cannot free sbi while this callback
> +	 * is still using it.
>   	 */
>   	dec_page_count(sbi, type);
> +	if (last_page)
> +		end_page_writeback(last_page);
>   }
>   
>   static int f2fs_write_raw_pages(struct compress_ctx *cc,
> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> index a765fda71536..1466a7825dc5 100644
> --- a/fs/f2fs/data.c
> +++ b/fs/f2fs/data.c
> @@ -1092,7 +1092,7 @@ void f2fs_submit_page_write(struct f2fs_io_info *fio)
>   	/* set submitted = true as a return value */
>   	fio->submitted = 1;
>   
> -	type = WB_DATA_TYPE(bio_folio, fio->compressed_page);
> +	type = WB_DATA_TYPE(fio->compressed_page ? fio->folio : bio_folio, false);
>   	inc_page_count(sbi, type);
>   
>   	if (io->bio &&
> 
> base-commit: 7cc48ead1a8a96f2dd1eabd87c2f22947dc84cdf



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
