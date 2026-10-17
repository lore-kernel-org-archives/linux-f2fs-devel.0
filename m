Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4C8BCCA490
	for <linux-f2fs-devel@archiver.kernel.org>; Sat, 17 Oct 2026 02:16:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Content-Transfer-Encoding:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6Ry9gpsmiDCPxIqtrOqRUeStBsxpotQgyyx0WsfNu/M=; b=OpKaQxKpAMhm6ofde3JX0qOjDc
	bhVjVXoFGB8FB5ux6dy6KVRSlpBUdETAZvT5BEsl3+SvU3wy5zhGWPrOyptl3kaXr+lzSUNrfOC7s
	6H1N66VayeFvRrD5QDbHLvQR/OsVa8QD12cTGRGuQhKw9STzSouVX0Wjnxl+Wl1eymEc=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xHtyG-00074C-DX;
	Sat, 17 Oct 2026 02:16:25 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1xHtyE-000746-Ol
 for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 17 Oct 2026 02:16:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=mPp3gA7twIWDucSp89vhBxyAtajzqE7/m7Bf+k28Q+4=; b=FOKwLT348/rPTJ63oo4mS51rjv
 TDBmkxGxiFVZ6BpXj4Tpmt/rfukrVRjVp3E3f39x1Wscchras5wcVJumFpIPo2vj2HAvas3CviKmB
 NIS/g0fGu8YkLTYhD0dvXTD33bkg3mV7bjcSC68vL10m8Zs0I/Ia76INSaqFttD7xkSE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=mPp3gA7twIWDucSp89vhBxyAtajzqE7/m7Bf+k28Q+4=; b=DPkoVf/91Gxwr6QvS+KdZYbvV8
 ozAPXb9fujtBPDS3bG0uCM19oVWjVdwuxToSGVnO+wGGr1pW9xuWVnG5BxNlEWSH66kHIUtXbEP8/
 vaBAvoVX8uqlaT6pPm16mDVBW373XHvW+DmCHYKRlo2k/hHMhVn9hmiBIH7ZrjFSJ9go=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1xHtyA-0005lu-Q5 for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 17 Oct 2026 02:16:24 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 2F44160230
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Sat, 17 Oct 2026 02:16:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 238DE1F000C5;
 Sat, 17 Oct 2026 02:16:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792203376;
 bh=mPp3gA7twIWDucSp89vhBxyAtajzqE7/m7Bf+k28Q+4=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To;
 b=ZLvpJSD0emMtl1FHrsOSS+lOuar7YQsRtm9DzlhQ090GT4DiMELjgAt2JYha+zJkz
 Zk2cpthQtlikPaWITxG+QJc2n1CBE/VJhRKoiqBTIxOUta5hZvuUxcGE9OZqunPkmL
 yVXxhIig36W+fVnJJfLlsSneZV7Eabh8/lnsUAK9Gf35y/o4CKvHiyjbiNzTghzBwE
 Qwr/X0W6G4B2xAh8wDFcV04Cs3rNb+n6Dm1CLiUyS3t4CQDX1assWyQEAYP7Q+XTvq
 9e4WPqkHPtmPmTdgKqJmlygU2aH/WEiapSewglxtNo9jBe2DTlOi1kj+AwTbzmGUql
 7dhnMrAORpamw==
Message-ID: <abeed257-b8d2-4c1d-9ee9-5e93f628348e@kernel.org>
Date: Sat, 17 Oct 2026 10:16:14 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: jaegeuk@kernel.org
References: <20261007114949.2428048-1-chao@kernel.org>
 <20261007114949.2428048-5-chao@kernel.org>
Content-Language: en-US
In-Reply-To: <20261007114949.2428048-5-chao@kernel.org>
X-Headers-End: 1xHtyA-0005lu-Q5
Subject: Re: [f2fs-dev] [PATCH 5/5] f2fs: introduce
 max_atc_write_bio_entry_cnt
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

As discussed offline, we can drop this sysfs version patch, and use below two
patches instead:

[PATCH 1/2] f2fs: introduce max_write_bio_{folio,entry}_cnt module parameters
[PATCH 2/2] f2fs: remove max_atc_write_bio_size

Jaegeuk, fyi, these two patches can be applied right after "f2fs: cache: support
asynchronous write_end_io".

Thanks,

On 10/7/26 19:49, Chao Yu wrote:
> From: Chao Yu <chao@kernel.org>
> 
> Commit 3de6b8094115 ("f2fs: Run f2fs_write_end_io() asynchronously")
> introduced max_atc_write_bio_size to offload write bio completion to a
> workqueue when f2fs_write_end_io() is called in atomic context.
> 
> However, using the bio byte size (bi_iter.bi_size) as the threshold has
> limitations once large folios or multi-page bvecs are involved:
> 
> 1. In f2fs_write_end_bio(), execution time is dominated by the
>     completion loop (bio_for_each_folio_all() for pagecache folios,
>     or while(entry) for cached metadata blocks), where per-entry
>     locking, status clearing, sanity checks, and writeback end are
>     performed. The CPU latency in atomic context scales with the number
>     of entries in the bio, not its byte size.
> 2. For large folios, a large bio (e.g. 1MB comprised of single large
>     folios) only iterates a few times through the loop. Throttling solely
>     by max_atc_write_bio_size unnecessarily offloads such low-latency
>     bios to the workqueue, adding context-switch overhead.
> 3. Conversely, relying on bio->bi_vcnt is insufficient because the block
>     layer (bvec_try_merge_page) merges physically consecutive pages/folios
>     into the same bio_vec segment. Thus, a bio with bi_vcnt == 1 could
>     still contain multiple entries and iterate many times in end_io.
> 
> To address this, track the exact number of entries (folios or cached
> blocks) queued to the write bio via entry_cnt in struct f2fs_bio, and
> introduce a sysfs attribute max_atc_write_bio_entry_cnt. This enables
> precise control over atomic context latency without penalizing large
> folios.
> 
> Signed-off-by: Chao Yu <chao@kernel.org>
> ---
>   Documentation/ABI/testing/sysfs-fs-f2fs | 11 +++++++++++
>   fs/f2fs/data.c                          |  7 ++++++-
>   fs/f2fs/f2fs.h                          |  3 +++
>   fs/f2fs/super.c                         |  1 +
>   fs/f2fs/sysfs.c                         |  2 ++
>   5 files changed, 23 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-fs-f2fs b/Documentation/ABI/testing/sysfs-fs-f2fs
> index f50739f90ae9..5ff693dd4bff 100644
> --- a/Documentation/ABI/testing/sysfs-fs-f2fs
> +++ b/Documentation/ABI/testing/sysfs-fs-f2fs
> @@ -1014,6 +1014,17 @@ Description:	Every time a write operation completes f2fs_write_end_io() is
>   		(atc) context. The default value for this attribute is UINT_MAX
>   		which means that this functionality is disabled by default.
>   
> +What:		/sys/fs/f2fs/<disk>/max_atc_write_bio_entry_cnt
> +Date:		October 2026
> +Contact:	Chao Yu <chao@kernel.org>
> +Description:	Every time a write operation completes f2fs_write_end_io() is
> +		called. This function may be called from an atomic context,
> +		e.g. from inside an interrupt handler. This attribute controls
> +		the maximum number of entries (folios or cached blocks) in a
> +		write bio that is completed in atomic (atc) context. The default
> +		value for this attribute is UINT_MAX which means that this
> +		functionality is disabled by default.
> +
>   What:		/sys/fs/f2fs/<disk>/pinned_area_max_secno
>   Date:		August 2026
>   Contact:	"Daeho Jeong" <daehojeong@google.com>
> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> index 0a6aa24caa07..395794d00194 100644
> --- a/fs/f2fs/data.c
> +++ b/fs/f2fs/data.c
> @@ -398,7 +398,8 @@ static void f2fs_write_end_io(struct bio *bio)
>   
>   	sbi = bio->bi_private;
>   
> -	if (in_atomic() && bio->bi_iter.bi_size > sbi->max_atc_write_bio_size) {
> +	if (in_atomic() && (bio->bi_iter.bi_size > sbi->max_atc_write_bio_size ||
> +			F2FS_BIO(bio)->entry_cnt > sbi->max_atc_write_bio_entry_cnt)) {
>   		struct work_struct *w;
>   
>   		w = &container_of(bio, struct f2fs_bio, bio)->work;
> @@ -551,6 +552,7 @@ static struct bio *__bio_alloc(struct f2fs_io_info *fio, int npages)
>   						fio->type, fio->temp);
>   		bio->bi_write_stream = f2fs_io_type_to_write_stream(bdev, fio->type,
>   								    fio->temp);
> +		F2FS_BIO(bio)->entry_cnt = 0;
>   	}
>   	iostat_alloc_and_bind_ctx(sbi, bio, NULL);
>   
> @@ -1218,6 +1220,8 @@ void f2fs_submit_page_write(struct f2fs_io_info *fio)
>   		goto alloc_new;
>   	}
>   
> +	F2FS_BIO(io->bio)->entry_cnt++;
> +
>   	if (fio->io_wbc)
>   		wbc_account_cgroup_owner(fio->io_wbc, fio->folio,
>   				folio_size(fio->folio));
> @@ -1324,6 +1328,7 @@ void f2fs_submit_cache_write(struct f2fs_io_info *fio)
>   	}
>   
>   	f2fs_bio_add_cache(fio, io->bio);
> +	F2FS_BIO(io->bio)->entry_cnt++;
>   
>   	io->last_block_in_bio = fio->new_blkaddr;
>   
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index 089a62c054ea..0acbc4d299af 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -1778,6 +1778,7 @@ struct f2fs_gc_kthread {
>   struct f2fs_bio {
>   	struct work_struct work;
>   	struct f2fs_cached_block *entry;
> +	unsigned int entry_cnt;
>   	struct bio bio;
>   };
>   
> @@ -1807,6 +1808,8 @@ struct f2fs_sb_info {
>   	/* for bio operations */
>   	/* Largest write bio size completed in atomic context (atc). */
>   	u32 max_atc_write_bio_size;
> +	/* Largest write bio entry count completed in atomic context (atc). */
> +	u32 max_atc_write_bio_entry_cnt;
>   	struct f2fs_bio_info *write_io[NR_PAGE_TYPE];	/* for write bios */
>   	/* keep migration IO order for LFS mode */
>   	struct f2fs_rwsem io_order_lock;
> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> index d683240040f0..9e55febe18f4 100644
> --- a/fs/f2fs/super.c
> +++ b/fs/f2fs/super.c
> @@ -5211,6 +5211,7 @@ static int f2fs_fill_super(struct super_block *sb, struct fs_context *fc)
>   		goto free_sb_buf;
>   	}
>   	sbi->max_atc_write_bio_size = UINT_MAX;
> +	sbi->max_atc_write_bio_entry_cnt = UINT_MAX;
>   
>   	INIT_WORK(&sbi->s_error_work, f2fs_record_error_work);
>   	memcpy(sbi->errors, raw_super->s_errors, MAX_F2FS_ERRORS);
> diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
> index 95f8dc0c4218..32dfd564094b 100644
> --- a/fs/f2fs/sysfs.c
> +++ b/fs/f2fs/sysfs.c
> @@ -1285,6 +1285,7 @@ F2FS_SBI_RW_ATTR(umount_discard_timeout, interval_time[UMOUNT_DISCARD_TIMEOUT]);
>   F2FS_SBI_RW_ATTR(gc_pin_file_thresh, gc_pin_file_threshold);
>   F2FS_SBI_RW_ATTR(gc_reclaimed_segments, gc_reclaimed_segs);
>   F2FS_SBI_RW_ATTR(max_atc_write_bio_size, max_atc_write_bio_size);
> +F2FS_SBI_RW_ATTR(max_atc_write_bio_entry_cnt, max_atc_write_bio_entry_cnt);
>   F2FS_SBI_GENERAL_RW_ATTR(max_victim_search);
>   F2FS_SBI_GENERAL_RW_ATTR(migration_granularity);
>   F2FS_SBI_GENERAL_RW_ATTR(migration_window_granularity);
> @@ -1536,6 +1537,7 @@ static struct attribute *f2fs_attrs[] = {
>   	ATTR_LIST(gc_segment_mode),
>   	ATTR_LIST(gc_reclaimed_segments),
>   	ATTR_LIST(max_atc_write_bio_size),
> +	ATTR_LIST(max_atc_write_bio_entry_cnt),
>   	ATTR_LIST(max_fragment_chunk),
>   	ATTR_LIST(max_fragment_hole),
>   	ATTR_LIST(current_atomic_write),



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
