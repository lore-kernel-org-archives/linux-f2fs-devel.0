Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A589F8E497
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 17 Apr 2026 02:17:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Content-Transfer-Encoding:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XlDGh1tQr91+tcRBtTzXxZSCDFIbO6flfDzDT49P3j0=; b=Hj0NINIdtg7C8GTWlAU+TXVjyI
	3H7B8R2BhLobYi60zsSWwjY6hAMDQ4NncXjJZ6B6GbGTEpvpJKrfXLrbmbZIMDNgY7jewZ7lGO6dC
	Ebw2NguRipm5E+GRnftPbjBHzxasAXZJ/Gk9MwghilRBVQKJ01M3Z6HAQqP1HCKFhgSA=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wDYlj-0004pF-8G;
	Fri, 17 Apr 2026 02:17:19 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1wDYlh-0004p8-6l
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 17 Apr 2026 02:17:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=prlh7a28xyw3HAFEc1RWCBrI71ovPo3HJWqDHZN/8bU=; b=d0tpgw/Ov09ip9X+9lTSjJlVEQ
 5FD1N1o6sCAXUiddBIVL1mB7XDValw5MqaA2sVGFEMOLexb8/pS6A3HE67Z28pdbAOhdQhofEPcbm
 VtdECSFu0Sq8yWvsed537lVN/At1Fzu1TmKTA3sXL3/k5uvJ+zu+9xdQ+TCYi3gIeThY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=prlh7a28xyw3HAFEc1RWCBrI71ovPo3HJWqDHZN/8bU=; b=mOKqRulmbIkyVDBIY0lel9rBGo
 O05CBnJSmOWTItQboKRSgoEqcKEMYMxmuI6bHdcot5tFyYHA+QIrgigIdvy47sQ1J4xeIhjWH+6Ah
 +8Kg4pO9r2Rbi/kpeW7s4WPo8ds4o5Wyil2/nAllH6IZ3V3L8mQWdXv0P2B0gX6gSqjY=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wDYlg-0004Ox-HR for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 17 Apr 2026 02:17:17 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id D6D9660128;
 Fri, 17 Apr 2026 02:17:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB3ECC2BCAF;
 Fri, 17 Apr 2026 02:17:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1776392225;
 bh=KIpUTke7ygpWmUQZYIHp7ogFqhg8A3dVs9R5X8zNhoA=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
 b=KFZkdUQTJo5BcwtsOdHtcq+LU1bNstTgfKuoBYwBZQ3WqOY8GPFJ2YftKHuMG02b7
 ONbHBPT7c1zPtYM+zBV/tUDDp/P8VmLNBOXtLu3hTBl8jaC+N9cg5NfbIneShm+d4o
 vxXDvrVp05NC5fcAGxgWe2xImt6O2cjilJS1oPr6+cBtpp1GvX0zhzNaPW5hJrSOnR
 6yNFpZC4+pXNU9MQVW0KyHbB9wSnp8bpe2iVpdStflCnAEcdoP8JNdZTycTRtS+b3/
 LkKlw8jKOjVnyEUYQ8kTfCah8Ig3R+wzlAzEu2lzyEmi39K2zuuPwLHhLTQ0WCKzwx
 CFFXkw/cVYilA==
Message-ID: <930d444c-d71e-4712-9d24-2c7bfe57b18d@kernel.org>
Date: Fri, 17 Apr 2026 10:17:02 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Wenjie Qi <qwjhust@gmail.com>, jaegeuk@kernel.org
References: <20260415081451.2333535-1-qiwenjie@xiaomi.com>
Content-Language: en-US
In-Reply-To: <20260415081451.2333535-1-qiwenjie@xiaomi.com>
X-Headers-End: 1wDYlg-0004Ox-HR
Subject: Re: [f2fs-dev] [RFC PATCH v1] f2fs: map data writes to FDP streams
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
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 4/15/2026 4:14 PM, Wenjie Qi wrote:
> From: Wenjie Qi <qwjhust@gmail.com>
> 
> From: Wenjie Qi <qiwenjie@xiaomi.com>
> 
> F2FS already classifies DATA writes using its existing hot, warm and cold
> temperature policy, but it only passes that intent down as a write hint.
> That hint alone is not sufficient for NVMe FDP placement, because the
> current NVMe command path consumes `bio->bi_write_stream` rather than
> `bio->bi_write_hint` when selecting a placement ID.
> 
> When the target block device exposes write streams, map the existing F2FS
> DATA temperature classes onto stream IDs and set `bio->bi_write_stream`
> for both buffered and direct writes. If the device exposes no write
> streams, keep the current behavior by leaving the stream unset.
> 
> The stream mapping is evaluated against the target block device of each
> bio, so the existing per-device fallback behavior stays unchanged for
> multi-device filesystems. Existing blkzoned restrictions also remain in
> place.
> 
> The mapping is intentionally small and deterministic:
> 
> - 1 stream: hot, warm and cold all use stream 1
> - 2 streams: hot/warm use 1, cold uses 2
> - 3+ streams: hot uses 1, warm uses 2, cold uses 3

Hi Wenjie,

Can we add doc to describe the default config?

> 
> Signed-off-by: Wenjie Qi <qwjhust@gmail.com>
> 
> ---
> RFC notes:
> - Scope is intentionally limited to DATA writes only.
> - Validation used stock QEMU 8.2.2 NVMe FDP emulation with a 16G
>    namespace.
> - FDP enabled: buffered and direct writes each produced 3 dominant
>    NVMe placement tuples.
> - FDP disabled: buffered and direct writes each collapsed to 1
>    dominant tuple.
> 
>   fs/f2fs/data.c    |  2 ++
>   fs/f2fs/f2fs.h    |  2 ++
>   fs/f2fs/file.c    |  2 ++
>   fs/f2fs/segment.c | 24 ++++++++++++++++++++++++
>   4 files changed, 30 insertions(+)
> 
> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> index 338df7a2a..df9f4a230 100644
> --- a/fs/f2fs/data.c
> +++ b/fs/f2fs/data.c
> @@ -508,6 +508,8 @@ static struct bio *__bio_alloc(struct f2fs_io_info *fio, int npages)
>   		bio->bi_private = sbi;
>   		bio->bi_write_hint = f2fs_io_type_to_rw_hint(sbi,
>   						fio->type, fio->temp);
> +		bio->bi_write_stream = f2fs_io_type_to_write_stream(bdev, fio->type,
> +								    fio->temp);
>   	}
>   	iostat_alloc_and_bind_ctx(sbi, bio, NULL);
>   
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index bb34e864d..2f0777478 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -4056,6 +4056,8 @@ void f2fs_destroy_segment_manager_caches(void);
>   int f2fs_rw_hint_to_seg_type(struct f2fs_sb_info *sbi, enum rw_hint hint);
>   enum rw_hint f2fs_io_type_to_rw_hint(struct f2fs_sb_info *sbi,
>   			enum page_type type, enum temp_type temp);
> +u8 f2fs_io_type_to_write_stream(struct block_device *bdev,
> +				enum page_type type, enum temp_type temp);
>   unsigned int f2fs_usable_segs_in_sec(struct f2fs_sb_info *sbi);
>   unsigned int f2fs_usable_blks_in_seg(struct f2fs_sb_info *sbi,
>   			unsigned int segno);
> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> index c8a2f17a8..a3186cfc9 100644
> --- a/fs/f2fs/file.c
> +++ b/fs/f2fs/file.c
> @@ -5064,6 +5064,8 @@ static void f2fs_dio_write_submit_io(const struct iomap_iter *iter,
>   	enum temp_type temp = f2fs_get_segment_temp(sbi, type);
>   
>   	bio->bi_write_hint = f2fs_io_type_to_rw_hint(sbi, DATA, temp);
> +	bio->bi_write_stream =
> +		f2fs_io_type_to_write_stream(bio->bi_bdev, DATA, temp);
>   	blk_crypto_submit_bio(bio);
>   }
>   
> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> index 6a97fe767..ef8a3ac55 100644
> --- a/fs/f2fs/segment.c
> +++ b/fs/f2fs/segment.c
> @@ -3626,6 +3626,30 @@ enum rw_hint f2fs_io_type_to_rw_hint(struct f2fs_sb_info *sbi,
>   	}
>   }
>   
> +u8 f2fs_io_type_to_write_stream(struct block_device *bdev,
> +				enum page_type type, enum temp_type temp)
> +{
> +	unsigned short nr = bdev_max_write_streams(bdev);
> +
> +	if (type != DATA || !nr)
> +		return 0;
> +	if (nr == 1)
> +		return 1;
> +	if (nr == 2)
> +		return temp == COLD ? 2 : 1;
> +
> +	switch (temp) {
> +	case HOT:
> +		return 1;
> +	case WARM:
> +		return 2;
> +	case COLD:
> +		return 3;
> +	default:
> +		return 0;

How about using existing macros if there is instead magic numbers?

Thanks,

> +	}
> +}
> +
>   static int __get_segment_type_2(struct f2fs_io_info *fio)
>   {
>   	if (fio->type == DATA)



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
