Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 667E4CD8CB9
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 10 Jun 2026 12:15:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=J16X2ZtH7S/XOsOgsh18rUc/MxF8a+kRe6NkvJZtWSY=; b=eZUmzyOdn6aVXIXpDat/tN96jB
	wW2iEb5e4GpobbyqQfDlXp8XzwvAw+UwoPrJgnTZsIL22yf7DxXWNfkKjA7vGLdctZuOSzf6BVaMJ
	OQPucmxAcdrCqFZu7mYe1Ldl5TxY7ItY2diYyHoiqdFX5KrvqYuJYWIrn3VwvLc4Y6RM=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wXHqJ-0005mO-UL;
	Wed, 10 Jun 2026 12:15:36 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1wXHpq-0005lN-KC
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 10 Jun 2026 12:15:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=+t3zF2YWCcmzTj6l7PWHIbehNsICGNW+BG/Bajp023s=; b=ccWt5fIx0Cc9l5DZU5P2p1ZkqQ
 16T/TcK57XEHnba2tjLhvblcghBkazu9J4bEbMt2P4YvSbsvAKzKzS88X1abYzAd3JYcxNZnzz++I
 QmMDqnppmSiNHYoWFyR6XBxfNjw9g4D413Vkvnewl6NI18bv1xxe1iPlJeIS3sGXZYwk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=+t3zF2YWCcmzTj6l7PWHIbehNsICGNW+BG/Bajp023s=; b=Yp/KpnAX0MGqcj87sJ/Qq5uUj3
 yJSrIo7uyweYpFCP00j6cbQ0OgtMaCiyRPT1CHLyrm6giUqKthctHqauNmUd+oj9qg9xwJgGAFUja
 SF+fvOumt292rpeCSHNE4T4LBF3dHMDTZKLuoLTdexcQSNEXXA1lcmgBRe/cc9Lc5U08=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wXHpp-0004gP-1b for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 10 Jun 2026 12:15:06 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 4243943D9E;
 Wed, 10 Jun 2026 12:14:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 498751F00893;
 Wed, 10 Jun 2026 12:14:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781093695;
 bh=+t3zF2YWCcmzTj6l7PWHIbehNsICGNW+BG/Bajp023s=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To;
 b=fWvq7BRL017qVCczCNtp4gx4MZaMxCOyMuHq6QI0xLVb9aVsr/aU2F5WNMQXo3f+O
 LheJEpjUoM9CBzIHZKVh+VHVyQxN2fXkYYGbcI2tW28KiPm1ULjwurk8j4rbwhA1ez
 5AZlt231WU95oak+RK4ilentbjxxIjijM7jc83EKAHl9+LHPzRkJP2JCAhwCq3ERln
 IUAqhwpuHJWIiHmy9VE0/ND8IZyY/tYFaldeUfBjnylbcqNr5uDu21mMytKNC5bc5Y
 zA4iRa8KgiNEWi31l2SXFEKCL1ZISLOO5sdZYdKTg9Ik2RJ2Qeuv4dA77wxxx04t7r
 Xb+vgy73C5v1Q==
Message-ID: <a3431eb2-6224-401b-9aec-1c0abf840143@kernel.org>
Date: Wed, 10 Jun 2026 20:14:51 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Bart Van Assche <bvanassche@acm.org>, Jaegeuk Kim <jaegeuk@kernel.org>
References: <cover.1780003055.git.bvanassche@acm.org>
 <0e18152026cacd1e61fb5fb5483fc1d3c57bdc51.1780003055.git.bvanassche@acm.org>
Content-Language: en-US
In-Reply-To: <0e18152026cacd1e61fb5fb5483fc1d3c57bdc51.1780003055.git.bvanassche@acm.org>
X-Headers-End: 1wXHpp-0004gP-1b
Subject: Re: [f2fs-dev] [PATCH 4/4] f2fs: Run f2fs_write_end_io()
 asynchronously
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
Cc: linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 5/29/26 05:20, Bart Van Assche wrote:
> The bio_for_each_segment_all() loop can take more than 10 ms for a large
> bio on an ARM little core. This is too much for interrupt context. Hence
> perform the write bio completion work asynchronously if a bio is large and
> if f2fs_write_end_io() is called from atomic context. This patch reduces
> the time spent in f2fs_write_end_io() from about 10 ms to about 150
> microseconds on an Arm Cortex-A520 core.
> 
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---
>  fs/f2fs/data.c  | 21 ++++++++++++++++++++-
>  fs/f2fs/f2fs.h  |  2 ++
>  fs/f2fs/super.c |  5 +++++
>  fs/f2fs/sysfs.c |  2 ++
>  4 files changed, 29 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> index 48c004976c4e..6e169490c4cf 100644
> --- a/fs/f2fs/data.c
> +++ b/fs/f2fs/data.c
> @@ -409,11 +409,30 @@ static void f2fs_write_end_bio(struct bio *bio)
>  	bio_put(bio);
>  }
>  
> +static void f2fs_write_end_io_work(struct work_struct *work)
> +{
> +	struct bio *bio = &container_of(work, struct f2fs_bio, work)->bio;
> +
> +	f2fs_write_end_bio(bio);
> +}
> +
>  static void f2fs_write_end_io(struct bio *bio)
>  {
> +	struct f2fs_sb_info *sbi;
> +
>  	iostat_update_and_unbind_ctx(bio);
>  
> -	f2fs_write_end_bio(bio);
> +	sbi = bio->bi_private;
> +
> +	if (in_atomic() && bio->bi_iter.bi_size > sbi->max_atc_write_bio_size) {
> +		struct work_struct *w;
> +
> +		w = &container_of(bio, struct f2fs_bio, bio)->work;
> +		INIT_WORK(w, f2fs_write_end_io_work);
> +		queue_work(sbi->wq, w);
> +	} else {
> +		f2fs_write_end_bio(bio);
> +	}
>  }
>  
>  #ifdef CONFIG_BLK_DEV_ZONED
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index 30353c439d3c..a6a3e01122e1 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -1763,6 +1763,8 @@ struct f2fs_sb_info {
>  	struct f2fs_sm_info *sm_info;		/* segment manager */
>  
>  	/* for bio operations */
> +	/* Largest write bio size completed in atomic context (atc). */
> +	u32 max_atc_write_bio_size;
>  	struct f2fs_bio_info *write_io[NR_PAGE_TYPE];	/* for write bios */
>  	/* keep migration IO order for LFS mode */
>  	struct f2fs_rwsem io_order_lock;
> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> index 5a100f740b3f..1e822380edb3 100644
> --- a/fs/f2fs/super.c
> +++ b/fs/f2fs/super.c
> @@ -5007,6 +5007,11 @@ static int f2fs_fill_super(struct super_block *sb, struct fs_context *fc)
>  
>  	sb->s_fs_info = sbi;
>  	sbi->raw_super = raw_super;
> +	/*
> +	 * SZ_16K restricts the time spent on completing writes to about 150
> +	 * microseconds on an Arm Cortex-A520 core.
> +	 */
> +	sbi->max_atc_write_bio_size = SZ_16K;

Actually, I don't see this problem before, can we disable this by default, and
only enable for your case via sysfs?

>  
>  	INIT_WORK(&sbi->s_error_work, f2fs_record_error_work);
>  	memcpy(sbi->errors, raw_super->s_errors, MAX_F2FS_ERRORS);
> diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
> index 352e96ad5c3a..70b2e9be8f8b 100644
> --- a/fs/f2fs/sysfs.c
> +++ b/fs/f2fs/sysfs.c
> @@ -1266,6 +1266,7 @@ F2FS_SBI_RW_ATTR(gc_idle_interval, interval_time[GC_TIME]);
>  F2FS_SBI_RW_ATTR(umount_discard_timeout, interval_time[UMOUNT_DISCARD_TIMEOUT]);
>  F2FS_SBI_RW_ATTR(gc_pin_file_thresh, gc_pin_file_threshold);
>  F2FS_SBI_RW_ATTR(gc_reclaimed_segments, gc_reclaimed_segs);
> +F2FS_SBI_RW_ATTR(max_atc_write_bio_size, max_atc_write_bio_size);
>  F2FS_SBI_GENERAL_RW_ATTR(max_victim_search);
>  F2FS_SBI_GENERAL_RW_ATTR(migration_granularity);
>  F2FS_SBI_GENERAL_RW_ATTR(migration_window_granularity);
> @@ -1508,6 +1509,7 @@ static struct attribute *f2fs_attrs[] = {
>  	ATTR_LIST(seq_file_ra_mul),
>  	ATTR_LIST(gc_segment_mode),
>  	ATTR_LIST(gc_reclaimed_segments),
> +	ATTR_LIST(max_atc_write_bio_size),

We need to update Documentation/ABI/testing/sysfs-fs-f2fs as well.

Thanks,

>  	ATTR_LIST(max_fragment_chunk),
>  	ATTR_LIST(max_fragment_hole),
>  	ATTR_LIST(current_atomic_write),



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
