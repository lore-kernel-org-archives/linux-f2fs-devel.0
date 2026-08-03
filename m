Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57A9EC55175
	for <linux-f2fs-devel@archiver.kernel.org>; Mon,  3 Aug 2026 09:20:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Content-Transfer-Encoding:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7TefPR3fi+y5cJoAeirmLJH8MtKuOZCPcg0nNW7fH+g=; b=ZNAiLyyqErik/pzVikIr30pVA7
	3V1cQtcHRPGbJc/4gCUVCdjFtZn68H7W3r3tb8kYfH2kj5CY0clxid7w5Vw1OOqIjbdJPdiNvvIZk
	M2OHnA76jtrDKipXudlAjK/53oTj4Jg0MLXygU1OvI5IX4bxUttZVZce6o0YUQyhKyfY=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wqopx-0008NK-BE;
	Mon, 03 Aug 2026 09:19:58 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1wqopw-0008N9-9x
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 03 Aug 2026 09:19:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=KwXIXw2qkjkZNUaN+4Dbicz+x33k75CB0KDpo8YzxpY=; b=GX8Ykd1r4srqN1yugQkjFIi7tP
 UW+NCnzXw+j+w87Wl+Q8uxfZThiiKjs1XL2XrE0QZ4kRh9qkU/kM7V+pPDdZc98FX60/npNO3sYGf
 rlo80Q+NsK4c9fQd3/3CreQ1Og2Ax+meegbCU80Wac/W6vLwJdeCsKxcUIRYivLYo1iU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=KwXIXw2qkjkZNUaN+4Dbicz+x33k75CB0KDpo8YzxpY=; b=mpo9yGxwcBPQn1AUJszAVmcgMk
 NLdMjCC1OdUhZOQxYs93ZgOBwYdUordcllT/vdPu871hNnnD+MgT0lDo48FHOPsISasTP/xDQN+R1
 kaGgudArnviuIflh9p/gnXX5NJWwT/NDR7KuXJ1aT6dWn4NVSXbQt9jFsDnQW031Iil0=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wqopz-0003cO-63 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 03 Aug 2026 09:19:57 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 4FC9141997;
 Mon,  3 Aug 2026 09:19:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F39DA1F000E9;
 Mon,  3 Aug 2026 09:19:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785748790;
 bh=KwXIXw2qkjkZNUaN+4Dbicz+x33k75CB0KDpo8YzxpY=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To;
 b=GaILqNVxIPawLhPsn9AOc8ATRErvqG9nJvn0ePpLGx/WprxrAcsdsE2SplRJzAE6s
 58OxV12OWzOwNrQLVkwnnYdsbCRjV2zD+nJEgsLEowmA4TdZse1mFIS+zr+0NxmmUX
 rGL7RBab6jo4ezZfN+wX6MUpcOvRLleFXbgTNKNHBn5io/4Z2qFD7RzCJ5Tw5kn77X
 ORJQ1KsZmHDbKaiV+CFk1z9RZ+9D/B47KIvJ4K+SGZOOzHIf8jsYacVPXLsLiPDPzh
 IRQ+/nYRwA3HIT1eLNTsN64MBUP8UOphSJovv1I0PcJ1LkiYyjbzvWJWzO/WaUWxmO
 h+CJLGlc7X3gA==
Message-ID: <649f13de-4ef1-4c41-9be2-04f06fb9bfe3@kernel.org>
Date: Mon, 3 Aug 2026 17:19:46 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: liujinbao1 <jinbaoliu365@gmail.com>, jaegeuk@kernel.org
References: <20260731112954.1023817-1-jinbaoliu365@gmail.com>
Content-Language: en-US
In-Reply-To: <20260731112954.1023817-1-jinbaoliu365@gmail.com>
X-Headers-End: 1wqopz-0003cO-63
Subject: Re: [f2fs-dev] [PATCH] f2fs: adjust iostat tracepoints
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
Cc: liujinbao1 <liujinbao1@xiaomi.com>, linux-f2fs-devel@lists.sourceforge.net
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 7/31/26 19:29, liujinbao1 wrote:
> From: liujinbao1 <liujinbao1@xiaomi.com>
> 
> Move trace_f2fs_submit_read_bio() and trace_f2fs_submit_write_bio()

Why? can you please explain more?

> after iostat context initialization, and add trace_f2fs_iostat_update()
> so f2fs iostat can be adjusted through tracepoints.
> 
> Use ktime_get_ns() for more accurate iostat accounting.
> 
> Signed-off-by: liujinbao1 <liujinbao1@xiaomi.com>
> ---
>   fs/f2fs/data.c              |  4 ++--
>   fs/f2fs/iostat.c            |  5 ++++-
>   fs/f2fs/iostat.h            |  2 +-
>   include/trace/events/f2fs.h | 32 ++++++++++++++++++++++++++++++++
>   4 files changed, 39 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> index a765fda71536..0b6aab302f02 100644
> --- a/fs/f2fs/data.c
> +++ b/fs/f2fs/data.c
> @@ -568,9 +568,9 @@ void f2fs_submit_read_bio(struct f2fs_sb_info *sbi, struct bio *bio,
>   		return;
>   
>   	WARN_ON_ONCE(!is_read_io(bio_op(bio)));
> -	trace_f2fs_submit_read_bio(sbi->sb, type, bio);
>   
>   	iostat_update_submit_ctx(bio, type);
> +	trace_f2fs_submit_read_bio(sbi->sb, type, bio);
>   	blk_crypto_submit_bio(bio);
>   }
>   
> @@ -578,8 +578,8 @@ static void f2fs_submit_write_bio(struct f2fs_sb_info *sbi, struct bio *bio,
>   				  enum page_type type)
>   {
>   	WARN_ON_ONCE(is_read_io(bio_op(bio)));
> -	trace_f2fs_submit_write_bio(sbi->sb, type, bio);
>   	iostat_update_submit_ctx(bio, type);
> +	trace_f2fs_submit_write_bio(sbi->sb, type, bio);
>   	blk_crypto_submit_bio(bio);
>   }
>   
> diff --git a/fs/f2fs/iostat.c b/fs/f2fs/iostat.c
> index ae265e3e9b2c..73d810b3b7ff 100644
> --- a/fs/f2fs/iostat.c
> +++ b/fs/f2fs/iostat.c
> @@ -257,7 +257,7 @@ static inline void __update_iostat_latency(struct bio_iostat_ctx *iostat_ctx,
>   	if (!sbi->iostat_enable)
>   		return;
>   
> -	ts_diff = jiffies - iostat_ctx->submit_ts;
> +	ts_diff = ktime_get_ns() - iostat_ctx->submit_ts;

It missed to adjust below codes:

			iostat_lat[idx][io].peak_lat =
			   jiffies_to_msecs(io_lat->peak_lat[idx][io]);

                            ^^^^^^^^^^^^^^^^

			iostat_lat[idx][io].cnt = io_lat->bio_cnt[idx][io];
			iostat_lat[idx][io].avg_lat = iostat_lat[idx][io].cnt ?
			   jiffies_to_msecs(io_lat->sum_lat[idx][io]) / iostat_lat[idx][io].cnt : 0;

                            ^^^^^^^^^^^^^^^^

>   	if (page_type == META_FLUSH) {
>   		page_type = META;
>   	} else if (page_type >= NR_PAGE_TYPE) {
> @@ -278,6 +278,9 @@ void iostat_update_and_unbind_ctx(struct bio *bio)
>   	struct bio_iostat_ctx *iostat_ctx = bio->bi_private;
>   	enum iostat_lat_type lat_type;
>   
> +	trace_f2fs_iostat_update(iostat_ctx->sbi->sb, bio,
> +				 iostat_ctx->submit_ts);
> +
>   	if (op_is_write(bio_op(bio))) {
>   		lat_type = bio->bi_opf & REQ_SYNC ?
>   				WRITE_SYNC_IO : WRITE_ASYNC_IO;
> diff --git a/fs/f2fs/iostat.h b/fs/f2fs/iostat.h
> index 2025225b5bed..2e3e1e4ce8b3 100644
> --- a/fs/f2fs/iostat.h
> +++ b/fs/f2fs/iostat.h
> @@ -49,7 +49,7 @@ static inline void iostat_update_submit_ctx(struct bio *bio,
>   {
>   	struct bio_iostat_ctx *iostat_ctx = bio->bi_private;
>   
> -	iostat_ctx->submit_ts = jiffies;
> +	iostat_ctx->submit_ts = ktime_get_ns();

Hmm, it's in I/O path, can you please check how will this affect performance?

>   	iostat_ctx->type = type;
>   }
>   
> diff --git a/include/trace/events/f2fs.h b/include/trace/events/f2fs.h
> index 270c1a2c24c4..b97e0740d7ed 100644
> --- a/include/trace/events/f2fs.h
> +++ b/include/trace/events/f2fs.h
> @@ -2315,6 +2315,38 @@ TRACE_EVENT(f2fs_iostat_latency,
>   		__entry->n_wr_as_peak, __entry->n_wr_as_avg, __entry->n_wr_as_cnt,
>   		__entry->m_wr_as_peak, __entry->m_wr_as_avg, __entry->m_wr_as_cnt)
>   );
> +
> +TRACE_EVENT(f2fs_iostat_update,
> +
> +	TP_PROTO(struct super_block *sb, struct bio *bio,
> +		unsigned long submit_ts),
> +
> +	TP_ARGS(sb, bio, submit_ts),
> +
> +	TP_STRUCT__entry(
> +		__field(dev_t, dev)
> +		__field(enum req_op, op)
> +		__field(blk_opf_t, op_flags)
> +		__field(sector_t, sector)
> +		__field(unsigned int, size)
> +		__field(unsigned long, submit_ts)
> +	),
> +
> +	TP_fast_assign(
> +		__entry->dev = sb->s_dev;
> +		__entry->op = bio_op(bio);
> +		__entry->op_flags = bio->bi_opf;
> +		__entry->sector = bio->bi_iter.bi_sector;
> +		__entry->size = bio->bi_iter.bi_size;
> +		__entry->submit_ts = submit_ts;
> +	),
> +
> +	TP_printk("dev=(%d,%d), rw = %s(%s), sector = %llu, size = %u",
> +		show_dev(__entry->dev),
> +		show_bio_type(__entry->op, __entry->op_flags),
> +		(unsigned long long)__entry->sector,
> +		__entry->size)

Missed to print submit_ts?

Thanks,

> +);
>   #endif
>   
>   TRACE_EVENT(f2fs_bmap,



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
