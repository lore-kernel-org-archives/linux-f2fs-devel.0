Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8A6AC88E72
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 17 Sep 2026 03:48:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9pu1eJvMfv3r3cZtua3AdZgvgS8XpAGD1i1maYJgAGY=; b=gvRh1ELI7IWbHl3xB+63ZIp2fk
	B493Bcq3dTCvud7XB4CwAmOuy+U5YQAjvVWfY1xQC7bhUQXzu+oLI6nESHFsM/SEb69uacBaKGHGn
	MkAdsWSNrSplAbJfWZ8q8cbl7pxsJ+qex4A90rXM4SyHBxBP5ECfEH+8+8mgy4HC9gbU=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1x736s-0003EJ-Lh;
	Thu, 17 Sep 2026 03:48:28 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1x736r-0003EC-Ka
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 17 Sep 2026 03:48:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=zLF4Mbja4GIAFTmgG4HWop4gipA814DbSqZRFGDxUT0=; b=DVJTa3amm2YuiA9sd0Uf3yrUvE
 rPs/c4EQ2naRnjW30S7mBQngiT1H5PZSe1IlCSckqprbfVI+CUCF541bbqurYeiYtV1FF9sZNshXL
 l0V27OfFJlLbP0j7N4Fz53thKp4fpZWGwcMhys4o3vEBY+LUKmmIlHaXgruFsJhaYnRw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=zLF4Mbja4GIAFTmgG4HWop4gipA814DbSqZRFGDxUT0=; b=HvdTPST85BFW7N0Z1SHMjwlgMm
 Bdqk+ls0+2BzgxKa3MbBo58GlU0kRBlSUJk8TUKNhh9jEykUFrwRIlLi4LFyt+ypyR/r0lj+nDeAO
 6bKMHx+m562S678mGtlZyU0H6rrAUaBL308G5pWBDVFKJS/1ju/1oF2WAZfasucKp/Xs=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1x736n-0008TD-Sk for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 17 Sep 2026 03:48:27 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 23EDE601EF;
 Thu, 17 Sep 2026 03:48:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AADF1F000FF;
 Thu, 17 Sep 2026 03:48:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789616899;
 bh=zLF4Mbja4GIAFTmgG4HWop4gipA814DbSqZRFGDxUT0=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To;
 b=HTIWUuLd4PcCTwQdo75OlpBTUo74RSK+L7nFLuW+eLMyzvlDJ9xFQO2VQdm9Uxyve
 Xba/KzddJ1qj9JFee37VjHAv+Y3JB615+t25SyJ+rm/iOi50jKwTAKNaCsXGDqDEUJ
 vEJw/DZx3+q6DFzCso/dY4DL/NYNEiTI8Ao0lhuKJAFXj0N1s7DkPDCXYIGNSeIN9H
 PbOqF4YKclz9uUlZ2w4q31dsvDJXtG3fZ29jfPms5xfInbVds0z+SCJi9THwPoEYJl
 vmc25/Bap7ZfRnUgDb4Znk1pWkkOtjPvFkevapiXO5Og7ZhcuNpfg/XfV5eofiPzJ3
 8RQ/g9wXwhn1g==
Message-ID: <2c9b0602-88af-4759-b253-d1db87e52499@kernel.org>
Date: Thu, 17 Sep 2026 11:48:15 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Nanzhe Zhao <zhaonanzhe@xiaomi.com>,
 linux-f2fs-devel@lists.sourceforge.net, Jaegeuk Kim <jaegeuk@kernel.org>
References: <20260915041909.2903887-1-zhaonanzhe@xiaomi.com>
 <20260915041909.2903887-6-zhaonanzhe@xiaomi.com>
Content-Language: en-US
In-Reply-To: <20260915041909.2903887-6-zhaonanzhe@xiaomi.com>
X-Headers-End: 1x736n-0008TD-Sk
Subject: Re: [f2fs-dev] [PATCH v2 05/14] f2fs: support large folio writeback
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
Cc: Barry Song <baohua@kernel.org>, Juan Yescas <jyescas@google.com>,
 Dev Jain <Dev.Jain@arm.com>, linux-kernel@vger.kernel.org,
 David Hildenbrand <David.Hildenbrand@arm.com>, Bo Zhang <zhangbo56@xiaomi.com>,
 Kalesh Singh <kaleshsingh@google.com>, Nanzhe Zhao <nzzhao@126.com>,
 Pengfei Li <lipengfei28@xiaomi.com>, Ryan Roberts <Ryan.Roberts@arm.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 9/15/26 12:19, Nanzhe Zhao wrote:
> Large folio can contain multiple dirty ranges.
> Add a folio-based writeback path for large-folio mapping files
> and keep the legacy f2fs_write_cache_pages() path unchanged for
> non large-folio mapping files.
> 
> Signed-off-by: Nanzhe Zhao <zhaonanzhe@xiaomi.com>
> ---
>  fs/f2fs/data.c | 412 ++++++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 407 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> index eb5fb8e52851..1f9c99689f38 100644
> --- a/fs/f2fs/data.c
> +++ b/fs/f2fs/data.c
> @@ -355,7 +355,9 @@ static void f2fs_write_end_bio(struct bio *bio)
>  
>  	bio_for_each_folio_all(fi, bio) {
>  		struct folio *folio = fi.folio;
> +		unsigned int nr_pages = fi.length >> PAGE_SHIFT;
>  		enum count_type type;
> +		bool finished = true;
>  
>  #ifdef CONFIG_F2FS_FS_COMPRESSION
>  		if (f2fs_is_compressed_page(folio)) {
> @@ -379,10 +381,19 @@ static void f2fs_write_end_bio(struct bio *bio)
>  				folio->index, NODE_TYPE_REGULAR, true);
>  			f2fs_bug_on(sbi, folio->index != nid_of_node(sbi, folio));
>  		}
> +		if (f2fs_folio_has_ffs(folio)) {
> +			struct f2fs_folio_state *ffs =
> +				(struct f2fs_folio_state *)folio->private;
> +
> +			finished = atomic_sub_and_test(nr_pages,
> +					&ffs->write_pages_pending);
> +		}
> +
>  		if (f2fs_in_warm_node_list(sbi, folio))
>  			f2fs_del_fsync_node_entry(sbi, folio);
>  
> -		dec_page_count(sbi, type);
> +		while (nr_pages--)
> +			dec_page_count(sbi, type);
>  
>  		/*
>  		 * we should access sbi before folio_end_writeback() to
> @@ -392,8 +403,10 @@ static void f2fs_write_end_bio(struct bio *bio)
>  				wq_has_sleeper(&sbi->cp_wait))
>  			wake_up(&sbi->cp_wait);
>  
> -		folio_clear_f2fs_gcing(folio);
> -		folio_end_writeback(folio);
> +		if (finished) {
> +			folio_clear_f2fs_gcing(folio);
> +			folio_end_writeback(folio);
> +		}
>  	}
>  
>  	bio_put(bio);
> @@ -2654,7 +2667,7 @@ static void f2fs_ffs_mark_subrange_uptodate(struct folio *folio, size_t offset,
>  		folio_mark_uptodate(folio);
>  }
>  
> -static void f2fs_ffs_mark_subrange_dirty(struct folio *folio,
> +void f2fs_ffs_mark_subrange_dirty(struct folio *folio,
>  				    size_t offset, size_t len)
>  {
>  	struct f2fs_folio_state *ffs;
> @@ -2677,6 +2690,99 @@ static void f2fs_ffs_mark_subrange_dirty(struct folio *folio,
>  	spin_unlock_irqrestore(&ffs->state_lock, flags);
>  }
>  
> +static bool __ffs_clear_subrange_dirty(struct folio *folio,
> +			struct f2fs_folio_state *ffs, size_t offset, size_t len)
> +{
> +	unsigned int nr_subpages = folio_nr_pages(folio);
> +	unsigned int start, end;
> +
> +	start = offset >> PAGE_SHIFT;
> +	end = (offset + len + PAGE_SIZE - 1) >> PAGE_SHIFT;
> +	end = min(end, nr_subpages);
> +
> +	bitmap_clear(ffs->state, nr_subpages + start, end - start);
> +	return find_next_bit(ffs->state, 2 * nr_subpages, nr_subpages) <
> +			2 * nr_subpages;
> +}
> +
> +/**
> + * f2fs_ffs_clear_subrange_dirty_and_test - clear dirty bits and test remaining
> + * @folio: the large folio
> + * @offset: start byte offset within the folio
> + * @len: byte length of the subrange
> + *
> + * Clear the dirty bits of the 4K subpages covered by [offset, offset + len),
> + * and return whether the folio still has any dirty subpage left.
> + */
> +bool f2fs_ffs_clear_subrange_dirty_and_test(struct folio *folio, size_t offset,
> +					    size_t len)
> +{
> +	struct f2fs_folio_state *ffs;
> +	unsigned long flags;
> +	bool dirty;
> +
> +	if (!f2fs_folio_has_ffs(folio))
> +		return false;
> +
> +	ffs = (struct f2fs_folio_state *)folio->private;
> +	spin_lock_irqsave(&ffs->state_lock, flags);
> +	dirty = __ffs_clear_subrange_dirty(folio, ffs, offset, len);
> +	spin_unlock_irqrestore(&ffs->state_lock, flags);
> +
> +	return dirty;
> +}
> +
> +static unsigned int ffs_next_dirty_subpage(struct f2fs_folio_state *ffs,
> +			const struct folio *folio, unsigned int start,
> +			unsigned int end)
> +{
> +	unsigned int nr_subpages = folio_nr_pages(folio);
> +
> +	return find_next_bit(ffs->state, nr_subpages + end + 1,
> +			nr_subpages + start) - nr_subpages;
> +}
> +
> +static unsigned int ffs_next_clean_subpage(struct f2fs_folio_state *ffs,
> +			const struct folio *folio, unsigned int start,
> +			unsigned int end)
> +{
> +	unsigned int nr_subpages = folio_nr_pages(folio);
> +
> +	return find_next_zero_bit(ffs->state, nr_subpages + end + 1,
> +			nr_subpages + start) - nr_subpages;
> +}
> +
> +static unsigned int ffs_find_dirty_range(struct folio *folio,
> +					u64 *range_start, u64 range_end)
> +{
> +	struct f2fs_folio_state *ffs;
> +	unsigned int start, end, nr_pages;
> +
> +	if (*range_start >= range_end)
> +		return 0;
> +
> +	if (!f2fs_folio_has_ffs(folio))
> +		return range_end - *range_start;
> +
> +	ffs = (struct f2fs_folio_state *)folio->private;
> +	start = offset_in_folio(folio, *range_start) >> PAGE_SHIFT;
> +	end = DIV_ROUND_UP(min_not_zero(offset_in_folio(folio, range_end),
> +					folio_size(folio)), PAGE_SIZE) - 1;
> +
> +	start = ffs_next_dirty_subpage(ffs, folio, start, end);
> +	if (start > end)
> +		return 0;
> +
> +	if (start == end)
> +		nr_pages = 1;
> +	else
> +		nr_pages = ffs_next_clean_subpage(ffs, folio,
> +						 start + 1, end) - start;
> +
> +	*range_start = folio_pos(folio) + ((u64)start << PAGE_SHIFT);
> +	return (u64)nr_pages << PAGE_SHIFT;
> +}
> +
>  static bool find_next_valid_block(const struct folio *folio,
>  				  size_t orig_off, size_t *need_off,
>  				  size_t len)
> @@ -3256,6 +3362,133 @@ int f2fs_do_write_data_page(struct f2fs_io_info *fio)
>  	return err;
>  }
>  
> +static int f2fs_write_single_data_folio(struct folio *folio, int *submitted,
> +					struct writeback_control *wbc,
> +					enum iostat_type io_type,
> +					u64 *pos, u64 len)
> +{
> +	struct inode *inode = folio->mapping->host;
> +	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
> +	bool atomic_commit = f2fs_is_atomic_file(inode) &&
> +				folio_test_f2fs_atomic(folio);
> +	struct inode *dn_inode = atomic_commit ?
> +				F2FS_I(inode)->cow_inode : inode;
> +	struct f2fs_folio_state *ffs = NULL;
> +	u64 folio_start = folio_pos(folio);
> +	pgoff_t start_idx = (*pos - folio_start) >> PAGE_SHIFT;
> +	pgoff_t end_idx = (*pos - folio_start + len - 1) >> PAGE_SHIFT;
> +	int err = 0;
> +
> +	for (pgoff_t i = start_idx; i <= end_idx && !err; i++) {
> +		struct dnode_of_data dn;
> +		struct node_info ni;
> +		pgoff_t data_idx = folio->index + i;
> +		bool ipu_force = false;
> +		bool dn_held = false;
> +		bool submitted_blk = false;
> +		struct f2fs_io_info fio = {
> +			.sbi = sbi,
> +			.ino = inode->i_ino,
> +			.type = DATA,
> +			.op = REQ_OP_WRITE,
> +			.op_flags = wbc_to_write_flags(wbc),
> +			.old_blkaddr = NULL_ADDR,
> +			.folio = folio,
> +			.folio_offset = i,
> +			.folio_blkcnt = 1,
> +			.encrypted_page = NULL,
> +			.submitted = 0,
> +			.need_lock = LOCK_DONE,
> +			.meta_gc = f2fs_meta_inode_gc_required(inode) ? 1 : 0,
> +			.io_type = io_type,
> +			.io_wbc = wbc,
> +		};
> +
> +		if (f2fs_folio_has_ffs(folio)) {
> +			ffs = (struct f2fs_folio_state *)folio->private;
> +			atomic_inc(&ffs->write_pages_pending);
> +		}
> +
> +		set_new_dnode(&dn, dn_inode, NULL, NULL, 0);
> +
> +		if (need_inplace_update(&fio) &&
> +		    f2fs_lookup_read_extent_cache_block(inode, data_idx,
> +							&fio.old_blkaddr)) {
> +			if (!f2fs_is_valid_blkaddr(sbi, fio.old_blkaddr,
> +						   DATA_GENERIC_ENHANCE)) {
> +				err = -EFSCORRUPTED;
> +				goto block_done;
> +			}
> +			ipu_force = true;
> +			goto got_it;
> +		}
> +
> +		err = f2fs_get_dnode_of_data(&dn, data_idx, LOOKUP_NODE);
> +		if (err)
> +			goto block_done;
> +		dn_held = true;
> +
> +		fio.old_blkaddr = dn.data_blkaddr;
> +
> +got_it:
> +		if (__is_valid_data_blkaddr(fio.old_blkaddr) &&
> +		    !f2fs_is_valid_blkaddr(sbi, fio.old_blkaddr,
> +					   DATA_GENERIC_ENHANCE)) {
> +			err = -EFSCORRUPTED;
> +			goto block_done;
> +		}
> +
> +		if (fio.meta_gc)
> +			f2fs_wait_on_block_writeback(inode, fio.old_blkaddr);
> +
> +		if (ipu_force ||
> +		    (__is_valid_data_blkaddr(fio.old_blkaddr) &&
> +					    need_inplace_update(&fio))) {
> +			f2fs_put_dnode(&dn);

dn_held = false;

> +			err = f2fs_inplace_write_data(&fio);
> +			trace_f2fs_do_write_data_page(folio, IPU);
> +			if (err)
> +				goto block_done;
> +
> +			if (submitted)
> +				(*submitted)++;
> +			submitted_blk = true;
> +			set_inode_flag(inode, FI_UPDATE_WRITE);
> +			goto block_done;
> +		}
> +
> +		err = f2fs_get_node_info(sbi, dn.nid, &ni, false);
> +		if (err)
> +			goto block_done;
> +
> +		fio.version = ni.version;
> +
> +		f2fs_outplace_write_data(&dn, &fio);
> +		if (submitted)
> +			(*submitted)++;
> +		submitted_blk = true;
> +		set_inode_flag(inode, FI_APPEND_WRITE);
> +		trace_f2fs_do_write_data_page(folio, OPU);
> +		goto block_done;

Redundant "goto block_done;"?

> +block_done:
> +		if (dn_held)
> +			f2fs_put_dnode(&dn);
> +		if (!submitted_blk && ffs)
> +			atomic_dec(&ffs->write_pages_pending);
> +		if (!err) {
> +			*pos = (data_idx + 1) << PAGE_SHIFT;
> +			spin_lock(&F2FS_I(inode)->i_size_lock);
> +			if (F2FS_I(inode)->last_disk_size < *pos)
> +				F2FS_I(inode)->last_disk_size = *pos;
> +			spin_unlock(&F2FS_I(inode)->i_size_lock);
> +		} else {
> +			file_set_keep_isize(inode);
> +		}
> +	}
> +
> +	return err;
> +}
> +
>  int f2fs_write_single_data_page(struct folio *folio, int *submitted,
>  				struct bio **bio,
>  				sector_t *last_block,
> @@ -3705,6 +3938,172 @@ static int f2fs_write_cache_pages(struct address_space *mapping,
>  	return ret;
>  }
>  
> +static int f2fs_write_cache_folios(struct address_space *mapping,
> +				   struct writeback_control *wbc,
> +				   enum iostat_type io_type)
> +{
> +	struct folio *folio = NULL;
> +	struct inode *inode = mapping->host;
> +	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
> +	struct f2fs_lock_context lc;
> +	u64 pos = 0;
> +	u64 end_pos = 0;
> +	u32 r_len = 0;
> +	int err = 0;
> +	int submitted = 0;
> +	int nwritten = 0;
> +	bool op_locked = false;
> +	bool next = false;
> +	bool retry = false;
> +
> +	if (get_dirty_pages(inode) <= SM_I(sbi)->min_hot_blocks)
> +		set_inode_flag(inode, FI_HOT_DATA);
> +	else
> +		clear_inode_flag(inode, FI_HOT_DATA);
> +
> +	while ((folio = writeback_iter(mapping, wbc, folio, &err))) {
> +		struct f2fs_folio_state *ffs = NULL;
> +		u64 isize;
> +		size_t poff;
> +		pgoff_t end_index;
> +		bool verity_in_progress;
> +		int folio_submitted = 0;
> +		bool bias_added = false;
> +
> +		submitted = 0;
> +		next = true;
> +		retry = false;
> +
> +		if (atomic_read(&sbi->wb_sync_req[DATA]) &&
> +		    wbc->sync_mode == WB_SYNC_NONE) {
> +			folio_redirty_for_writepage(wbc, folio);
> +			next = false;
> +			goto retry_out;
> +		}
> +retry:
> +		pos = folio_pos(folio);
> +		end_pos = pos + folio_size(folio);
> +		isize = i_size_read(inode);
> +		verity_in_progress = f2fs_verity_in_progress(inode);
> +		poff = 0;
> +		end_index = 0;
> +
> +		if (retry) {
> +
> +			if (unlikely(folio->mapping != mapping))
> +				goto retry_out;
> +
> +			if (!folio_test_dirty(folio))
> +				goto retry_out;
> +
> +			if (folio_test_writeback(folio)) {
> +				if (wbc->sync_mode == WB_SYNC_NONE)
> +					goto retry_out;
> +				f2fs_folio_wait_writeback(folio, DATA, true, true);
> +			}
> +
> +			if (!folio_clear_dirty_for_io(folio))
> +				goto retry_out;
> +		}
> +
> +		/* To avoid dealing with the complexity for one subrange is in bio
> +		 * while we trylock_op failed before writing another subrange.
> +		 * Try to lock_op before any subrange write for the folio.
> +		 */
> +		if (!op_locked) {
> +			if (!f2fs_trylock_op(sbi, &lc)) {
> +				folio_redirty_for_writepage(wbc, folio);
> +				err = 0;
> +				if (wbc->sync_mode != WB_SYNC_ALL)
> +					goto retry_out;
> +
> +				retry = true;
> +				folio_unlock(folio);
> +				f2fs_io_schedule_timeout(DEFAULT_SCHEDULE_TIMEOUT);
> +				folio_lock(folio);
> +				goto retry;
> +			}
> +			op_locked = true;
> +		}
> +
> +		if (!verity_in_progress) {
> +			poff = offset_in_folio(folio, isize);
> +			end_index = isize >> PAGE_SHIFT;
> +
> +			if (folio->index > end_index ||
> +			    (folio->index == end_index && poff == 0))
> +				goto out;
> +
> +			if (end_pos > isize) {
> +				folio_zero_segment(folio, poff, folio_size(folio));
> +				end_pos = isize;
> +			}
> +		}
> +
> +		folio_start_writeback(folio);
> +
> +		if (!bias_added && f2fs_folio_has_ffs(folio)) {
> +			ffs = (struct f2fs_folio_state *)folio->private;
> +			WARN_ON_ONCE(atomic_read(&ffs->write_pages_pending) != 0);
> +			atomic_inc(&ffs->write_pages_pending);
> +			bias_added = true;
> +		}
> +
> +		while ((r_len = ffs_find_dirty_range(folio, &pos, end_pos))) {
> +			err = f2fs_write_single_data_folio(folio, &submitted,
> +					wbc, io_type, &pos, r_len);
> +			folio_submitted += submitted;
> +			if (err)
> +				goto out;
> +
> +			nwritten += submitted;
> +		}
> +
> +		if (!err && folio_submitted &&
> +		    f2fs_is_atomic_file(inode) &&
> +		    folio_test_f2fs_atomic(folio))
> +			folio_clear_f2fs_atomic(folio);
> +
> +out:
> +		/*
> +		 * Clear the dirty state of the subranges that were written back.
> +		 * If some subranges are still dirty (e.g. the folio was only
> +		 * partially written back), the folio must stay dirty so that
> +		 * the remaining subranges are written back later.
> +		 */
> +		if (f2fs_ffs_clear_subrange_dirty_and_test(folio, 0,
> +					(err ? pos : end_pos) - folio_pos(folio)))
> +			folio_redirty_for_writepage(wbc, folio);
> +		else
> +			inode_dec_dirty_pages(inode);
> +
> +		if (bias_added) {
> +			if (atomic_dec_and_test(&ffs->write_pages_pending))
> +				folio_end_writeback(folio);
> +		} else if (!folio_submitted && folio_test_writeback(folio)) {
> +			folio_end_writeback(folio);
> +		}
> +
> +retry_out:
> +		if (folio_test_locked(folio))

Any case the folio is unlocked?

> +			folio_unlock(folio);
> +
> +		if (op_locked) {
> +			f2fs_unlock_op(sbi, &lc);
> +			op_locked = false;
> +		}
> +
> +		if (err || !next)
> +			break;

We can not break writeback_iter() loop directly? it may cause reference leak on folio?
IIUC, the right way is pass err to writeback_iter() to break the loop?

Thanks,

> +	}
> +
> +	if (nwritten)
> +		f2fs_submit_merged_write_cond(F2FS_M_SB(mapping), mapping->host,
> +					       NULL, 0, DATA);
> +
> +	return err;
> +}
> +
>  static inline bool __should_serialize_io(struct inode *inode,
>  					struct writeback_control *wbc)
>  {
> @@ -3799,7 +4198,10 @@ static int __f2fs_write_data_pages(struct address_space *mapping,
>  	account_writeback(inode, true);
>  
>  	blk_start_plug(&plug);
> -	ret = f2fs_write_cache_pages(mapping, wbc, io_type);
> +	if (mapping_large_folio_support(inode->i_mapping))
> +		ret = f2fs_write_cache_folios(mapping, wbc, io_type);
> +	else
> +		ret = f2fs_write_cache_pages(mapping, wbc, io_type);
>  	blk_finish_plug(&plug);
>  
>  	account_writeback(inode, false);



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
