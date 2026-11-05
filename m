Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EDC4606A328
	for <linux-f2fs-devel@archiver.kernel.org>; Thu,  5 Nov 2026 07:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=ZQ9X5voW;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=gvxY6f3e;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=c2qDypJj;
	dkim=neutral header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=i/9xxfAY
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=lNZP3Ijom+cHMNYo7yYFKuROs8BIs87ocmJwfPr6wA0=; b=ZQ9X5voWO/jjgZ
	zMHoJOKqvcHCnzgTco5UaBl96AZvf6XxVtLlXwwkS1ktK+TyyATk3feQFIxT/MJiuK+y3Z+LOwGru
	zdynI3LXK2bKN97Qxlx/+VBUkIEevJQsC4hFEAw/G2r8UYR4aydb4Ybede3MXDT9TwawjZri8itTi
	IzM=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xOsKN-000000001DZ-3wMA;
	Thu, 05 Nov 2026 07:56:07 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <chao@kernel.org>) id 1xOsKM-000000001DN-3Yjl
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 05 Nov 2026 07:56:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=1HAHFkd1aV3Mnv56LaOQg8ixZ7DHHPGAHu6Bzs3UD5Q=; b=gvxY6f3eEz2OUMaGDOAKjznn4g
 9lMF1Z5Atrd8A+KgikE1Pmuopa/RsG0Z7oMdTwwnpjmlxwZa9g7Bxp45XEDg0eSBIGM+j8Cz8inMl
 /EYQC4FMI+ctVZuh/udAYoVig2XYhhweHLDNmcYJ7UaKr98Ibeltktiz/k0l0sSwMOmk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=1HAHFkd1aV3Mnv56LaOQg8ixZ7DHHPGAHu6Bzs3UD5Q=; b=c2qDypJjulKW3JOpv7r3+rGwfg
 DVWkOOx8qu86msbT2dWZ29Ot0IJv2KpvD9ql7qaFTIb0QiqrlZFZCPofEYY0IeUogopphHCRVvn3A
 mBk8yXKQFuPe3FkqiKv1dL72mDUfxWjSC19kchPObBC4Stjlh+8HmU6dv8T+ftr5QHPk=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xOsKJ-000000000Un-3aBY
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 05 Nov 2026 07:56:06 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 7C2E340E89;
 Thu,  5 Nov 2026 07:55:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2ED6F1F000C1;
 Thu,  5 Nov 2026 07:55:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793865358;
 bh=1HAHFkd1aV3Mnv56LaOQg8ixZ7DHHPGAHu6Bzs3UD5Q=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To;
 b=i/9xxfAYFJgJ55H596Jza6+6WQ3WsSBI8FNExP8ro6BGDjhBCfa2puA/bPMDvG2o8
 i8wrHg+UukIPk/CkAW8gsWTCsBUAe15wimekl/8zebqzOxevX4vPINmWWayoITKDJz
 Ao1D+x0Xa3usZD/28BUr+fi2/54W/ch4WSdx4lQ4S3vOeVGYf60giad/OPmRlq2obL
 wXSPXYcwFryqXyK+u7ucBIUxGtvIQ/klLUuW3igswoEu7iVaxyGXin996zBx4P64rp
 G+ddnIuCbYWt4JbYJ0CSnTGONpxs0GIP58vyyIJ4QOUCtny/T/cqPjMlIZwyJzaaE6
 fiGwCpuhl34Og==
Message-ID: <174aaa28-ed48-4ad4-ba8a-ff1125d49796@kernel.org>
Date: Thu, 5 Nov 2026 15:55:55 +0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Daeho Jeong <daeho43@gmail.com>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
References: <20261102193952.3002018-1-daeho43@gmail.com>
 <20261102193952.3002018-7-daeho43@gmail.com>
Content-Language: en-US
In-Reply-To: <20261102193952.3002018-7-daeho43@gmail.com>
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xOsKJ-000000000Un-3aBY
Subject: Re: [f2fs-dev] [PATCH 06/20] f2fs: support subpage blocks in data
 read path and GC
X-BeenThere: linux-f2fs-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
From: Chao Yu via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Chao Yu <chao@kernel.org>
Cc: Daeho Jeong <daehojeong@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-17.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/3/26 03:39, Daeho Jeong wrote:
> From: Daeho Jeong <daehojeong@google.com>
> 
> With subpage blocks, a folio can be partially uptodate, so reads and GC
> have to work per block.
> 
> - Read only the non-uptodate blocks of a multi-block folio, and send
>   every inode to this path in subpage mode.
> - Do not use the folio state when a single bio reads the whole folio.
> - Implement ->is_partially_uptodate.
> - Convert block indices to folio indices in the data folio getters and
>   GC, and prefetch the whole folio in GC so that its blocks are read
>   together.
> - Fix error handling in f2fs_read_data_large_folio().
> - Zero the blocks past EOF in f2fs_read_data_large_folio() instead of
>   reading them, as f2fs_read_single_page() does. With subpage blocks,
>   they share a page with the last block of the file and can be seen
>   through mmap.
> - Test the per-block uptodate state in f2fs_find_data_folio() under the
>   folio lock, as ->release_folio can free the folio state otherwise. A
>   fully uptodate folio is still returned without the lock.
> - Get sbi from the folio in f2fs_finish_read_bio() only after the
>   compressed page check, as nothing pins the inode of a compressed page
>   once its cluster is unlocked.
> - Rename helpers that now take block indices, e.g.
>   f2fs_submit_page_read() to f2fs_submit_block_read().
> 
> The read changes also apply to large folios when the block size equals
> PAGE_SIZE.
> 
> Signed-off-by: Daeho Jeong <daehojeong@google.com>
> ---
>  fs/f2fs/data.c | 389 +++++++++++++++++++++++++++++--------------------
>  fs/f2fs/f2fs.h |  20 ++-
>  fs/f2fs/file.c |  22 +--
>  fs/f2fs/gc.c   |  82 ++++++++---
>  fs/f2fs/node.c |   6 +-
>  5 files changed, 319 insertions(+), 200 deletions(-)
> 
> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> index f2254e872a3d..07b7aeb94350 100644
> --- a/fs/f2fs/data.c
> +++ b/fs/f2fs/data.c
> @@ -145,13 +145,8 @@ static void f2fs_finish_read_bio(struct bio *bio, bool in_task)
>  
>  	bio_for_each_folio_all(fi, bio) {
>  		struct folio *folio = fi.folio;
> -		/*
> -		 * Cache sbi before the pending count is dropped: a sync reader
> -		 * may then release the folio while this bio is still in its
> -		 * end_io, so F2FS_F_SB(folio) is no longer safe to use below.
> -		 */
> -		struct f2fs_sb_info *sbi = F2FS_F_SB(folio);
> -		unsigned nr_pages = fi.length >> PAGE_SHIFT;
> +		struct f2fs_sb_info *sbi;
> +		unsigned int nr_blocks;
>  		bool finished = true;
>  		bool uptodate = bio->bi_status == BLK_STS_OK;
>  
> @@ -164,6 +159,10 @@ static void f2fs_finish_read_bio(struct bio *bio, bool in_task)
>  			continue;
>  		}
>  
> +		sbi = F2FS_F_SB(folio);
> +		nr_blocks = fi.length >> sbi->log_blocksize;

It's better to use F2FS_BYTES_TO_BLK() for cleanup.

> +		sub_cache_counts(sbi, F2FS_RD_DATA, nr_blocks);
> +
>  		if (f2fs_folio_has_ffs(folio)) {
>  			struct f2fs_folio_state *ffs =
>  				(struct f2fs_folio_state *)folio->private;
> @@ -172,14 +171,11 @@ static void f2fs_finish_read_bio(struct bio *bio, bool in_task)
>  			if (uptodate)
>  				uptodate = __ffs_mark_subrange_uptodate(folio, ffs,
>  						fi.offset, fi.length);
> -			ffs->read_blocks_pending -= nr_pages;
> +			ffs->read_blocks_pending -= nr_blocks;
>  			finished = !ffs->read_blocks_pending;
>  			spin_unlock_irqrestore(&ffs->state_lock, flags);
>  		}
>  
> -		while (nr_pages--)
> -			dec_cache_count(sbi, F2FS_RD_DATA);
> -
>  		if (finished)
>  			folio_end_read(folio, uptodate);
>  	}
> @@ -1477,7 +1473,7 @@ void f2fs_submit_cache_write(struct f2fs_io_info *fio)
>  
>  static struct bio *f2fs_grab_read_bio(struct inode *inode,
>  				      struct fsverity_info *vi, block_t blkaddr,
> -				      unsigned nr_pages, blk_opf_t op_flag,
> +				      unsigned int nr_blocks, blk_opf_t op_flag,
>  				      pgoff_t first_idx, bool for_write)
>  {
>  	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
> @@ -1487,7 +1483,7 @@ static struct bio *f2fs_grab_read_bio(struct inode *inode,
>  	sector_t sector;
>  	struct block_device *bdev = f2fs_target_device(sbi, blkaddr, &sector);
>  
> -	bio = bio_alloc_bioset(bdev, bio_max_segs(nr_pages),
> +	bio = bio_alloc_bioset(bdev, bio_max_segs(nr_blocks),
>  			       REQ_OP_READ | op_flag,
>  			       for_write ? GFP_NOIO : GFP_KERNEL, &f2fs_bioset);
>  	bio->bi_iter.bi_sector = sector;
> @@ -1521,27 +1517,29 @@ static struct bio *f2fs_grab_read_bio(struct inode *inode,
>  }
>  
>  /* This can handle encryption stuffs */
> -static void f2fs_submit_page_read(struct inode *inode, struct fsverity_info *vi,
> -				  struct folio *folio, pgoff_t index,
> -				  block_t blkaddr, blk_opf_t op_flags,
> -				  bool for_write)
> +static void f2fs_submit_block_read(struct inode *inode,
> +				   struct fsverity_info *vi,
> +				   struct folio *folio, pgoff_t bidx,
> +				   block_t blkaddr, blk_opf_t op_flags,
> +				   bool for_write)
>  {
>  	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
>  	struct bio *bio;
>  	size_t offset = 0;
>  
> -	if (f2fs_folio_has_ffs(folio)) {
> -		offset = offset_in_folio(folio, (loff_t)index << PAGE_SHIFT);
> +	if (f2fs_is_multiblock_folio(sbi, folio)) {
> +		f2fs_ffs_find_or_alloc(folio);
> +		offset = f2fs_folio_byte_offset(sbi, folio, bidx);
>  		f2fs_update_read_folio_pending(folio, 1);
>  	}
>  
> -	bio = f2fs_grab_read_bio(inode, vi, blkaddr, 1, op_flags, index,
> +	bio = f2fs_grab_read_bio(inode, vi, blkaddr, 1, op_flags, bidx,
>  				 for_write);
>  
>  	/* wait for GCed page writeback via generic cache */
>  	f2fs_wait_on_block_writeback(inode, blkaddr);
>  
> -	if (!bio_add_folio(bio, folio, PAGE_SIZE, offset))
> +	if (!bio_add_folio(bio, folio, F2FS_BLKSIZE(sbi), offset))
>  		f2fs_bug_on(sbi, 1);
>  
>  	inc_cache_count(sbi, F2FS_RD_DATA);
> @@ -1550,7 +1548,7 @@ static void f2fs_submit_page_read(struct inode *inode, struct fsverity_info *vi,
>  }
>  
>  /*
> - * Synchronously read a single 4K subpage by reusing f2fs_submit_page_read()
> + * Synchronously read a single block by reusing f2fs_submit_block_read()
>   * so that iostat, trace, blk-crypto and post-read handling are all preserved.
>   * The caller must have already allocated ffs for the folio.
>   */
> @@ -1567,8 +1565,8 @@ static int f2fs_submit_page_read_sync(struct inode *inode, struct folio *folio,
>  	 * We are holding the folio lock, so use GFP_NOIO for the bio
>  	 * allocation to avoid entering mm reclaim.
>  	 */
> -	f2fs_submit_page_read(inode, NULL, folio, index, blkaddr,
> -			      REQ_OP_READ, true);
> +	f2fs_submit_block_read(inode, NULL, folio, index, blkaddr,
> +			       REQ_OP_READ, true);
>  
>  	/* Wait until all bios have completed (pending drops back to our bias). */
>  	while (READ_ONCE(ffs->read_blocks_pending) != 1)
> @@ -1680,24 +1678,24 @@ static inline struct fsverity_info *f2fs_need_verity(const struct inode *inode,
>  	return NULL;
>  }
>  
> -struct folio *f2fs_get_read_data_folio(struct inode *inode, pgoff_t index,
> -		blk_opf_t op_flags, bool for_write, pgoff_t *next_pgofs)
> +struct folio *f2fs_get_read_data_folio(struct inode *inode, pgoff_t bidx,
> +		blk_opf_t op_flags, bool for_write, pgoff_t *next_blkofs)
>  {
> +	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
>  	struct address_space *mapping = inode->i_mapping;
> +	pgoff_t f_index = f2fs_has_subpage_blocks(sbi) ?
> +		f2fs_lblk_to_folio_index(sbi, bidx) : bidx;
>  	struct dnode_of_data dn;
>  	struct folio *folio;
>  	int err;
>  
> -	folio = f2fs_grab_cache_folio(mapping, index, for_write);
> +	folio = f2fs_grab_cache_folio(mapping, f_index, for_write);
>  	if (IS_ERR(folio))
>  		return folio;
>  
> -	if (folio_test_large(folio))
> -		f2fs_ffs_find_or_alloc(folio);
> -
> -	if (f2fs_lookup_read_extent_cache_block(inode, index,
> +	if (f2fs_lookup_read_extent_cache_block(inode, bidx,
>  						&dn.data_blkaddr)) {
> -		if (!f2fs_is_valid_blkaddr(F2FS_I_SB(inode), dn.data_blkaddr,
> +		if (!f2fs_is_valid_blkaddr(sbi, dn.data_blkaddr,
>  						DATA_GENERIC_ENHANCE_READ)) {
>  			err = -EFSCORRUPTED;
>  			goto put_err;
> @@ -1706,29 +1704,29 @@ struct folio *f2fs_get_read_data_folio(struct inode *inode, pgoff_t index,
>  	}
>  
>  	set_new_dnode(&dn, inode, NULL, NULL, 0);
> -	err = f2fs_get_dnode_of_data(&dn, index, LOOKUP_NODE);
> +	err = f2fs_get_dnode_of_data(&dn, bidx, LOOKUP_NODE);
>  	if (err) {
> -		if (err == -ENOENT && next_pgofs)
> -			*next_pgofs = f2fs_get_next_page_offset(&dn, index);
> +		if (err == -ENOENT && next_blkofs)
> +			*next_blkofs = f2fs_get_next_block_offset(&dn, bidx);
>  		goto put_err;
>  	}
>  	f2fs_put_dnode(&dn);
>  
>  	if (unlikely(dn.data_blkaddr == NULL_ADDR)) {
>  		err = -ENOENT;
> -		if (next_pgofs)
> -			*next_pgofs = index + 1;
> +		if (next_blkofs)
> +			*next_blkofs = bidx + 1;
>  		goto put_err;
>  	}
>  	if (dn.data_blkaddr != NEW_ADDR &&
> -			!f2fs_is_valid_blkaddr(F2FS_I_SB(inode),
> +			!f2fs_is_valid_blkaddr(sbi,
>  						dn.data_blkaddr,
>  						DATA_GENERIC_ENHANCE)) {
>  		err = -EFSCORRUPTED;
>  		goto put_err;
>  	}
>  got_it:
> -	if (f2fs_ffs_test_blk_uptodate(folio, index)) {
> +	if (f2fs_ffs_test_blk_uptodate(folio, bidx)) {
>  		folio_unlock(folio);
>  		return folio;
>  	}
> @@ -1741,17 +1739,17 @@ struct folio *f2fs_get_read_data_folio(struct inode *inode, pgoff_t index,
>  	 * f2fs_init_inode_metadata.
>  	 */
>  	if (dn.data_blkaddr == NEW_ADDR) {
> -		size_t offset = offset_in_folio(folio,
> -						(loff_t)index << PAGE_SHIFT);
> +		size_t offset = f2fs_folio_byte_offset(sbi, folio, bidx);
>  
> -		folio_zero_segment(folio, offset, offset + PAGE_SIZE);
> -		f2fs_ffs_mark_subrange_uptodate(folio, offset, PAGE_SIZE);
> +		folio_zero_segment(folio, offset, offset + F2FS_BLKSIZE(sbi));
> +		f2fs_ffs_mark_subrange_uptodate(folio, offset, F2FS_BLKSIZE(sbi));
>  		folio_unlock(folio);
>  		return folio;
>  	}
>  
> -	f2fs_submit_page_read(inode, f2fs_need_verity(inode, index),
> -			      folio, index, dn.data_blkaddr, op_flags, for_write);
> +	f2fs_submit_block_read(inode, f2fs_need_verity(inode, bidx),
> +			       folio, bidx, dn.data_blkaddr, op_flags,
> +			       for_write);
>  	return folio;
>  
>  put_err:
> @@ -1759,32 +1757,44 @@ struct folio *f2fs_get_read_data_folio(struct inode *inode, pgoff_t index,
>  	return ERR_PTR(err);
>  }
>  
> -struct folio *f2fs_find_data_folio(struct inode *inode, pgoff_t index,
> -					pgoff_t *next_pgofs)
> +struct folio *f2fs_find_data_folio(struct inode *inode, pgoff_t bidx,
> +					pgoff_t *next_blkofs)
>  {
> +	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
>  	struct address_space *mapping = inode->i_mapping;
> +	pgoff_t f_index = f2fs_has_subpage_blocks(sbi) ?
> +		f2fs_lblk_to_folio_index(sbi, bidx) : bidx;
>  	struct folio *folio;
>  
> -	folio = f2fs_filemap_get_folio(mapping, index, FGP_ACCESSED, 0);
> +	folio = f2fs_filemap_get_folio(mapping, f_index, FGP_ACCESSED, 0);
>  	if (IS_ERR(folio))
>  		goto read;
>  	if (folio_test_uptodate(folio))
>  		return folio;
> -	f2fs_folio_put(folio, false);
> +	/* The folio state is freed under the folio lock. */
> +	folio_lock(folio);
> +	if (folio->mapping == mapping &&
> +	    f2fs_ffs_test_blk_uptodate(folio, bidx)) {
> +		folio_unlock(folio);
> +		return folio;
> +	}
> +	f2fs_folio_put(folio, true);
>  
>  read:
> -	folio = f2fs_get_read_data_folio(inode, index, 0, false, next_pgofs);
> +	folio = f2fs_get_read_data_folio(inode, bidx, 0, false, next_blkofs);
>  	if (IS_ERR(folio))
>  		return folio;
>  
>  	if (folio_test_uptodate(folio))
>  		return folio;
>  
> -	folio_wait_locked(folio);
> -	if (unlikely(!folio_test_uptodate(folio))) {
> -		f2fs_folio_put(folio, false);
> +	folio_lock(folio);
> +	if (unlikely(folio->mapping != mapping ||
> +		     !f2fs_ffs_test_blk_uptodate(folio, bidx))) {
> +		f2fs_folio_put(folio, true);
>  		return ERR_PTR(-EIO);
>  	}
> +	folio_unlock(folio);
>  	return folio;
>  }
>  
> @@ -1793,13 +1803,13 @@ struct folio *f2fs_find_data_folio(struct inode *inode, pgoff_t index,
>   * Because, the callers, functions in dir.c and GC, should be able to know
>   * whether this page exists or not.
>   */
> -struct folio *f2fs_get_lock_data_folio(struct inode *inode, pgoff_t index,
> +struct folio *f2fs_get_lock_data_folio(struct inode *inode, pgoff_t bidx,
>  							bool for_write)
>  {
>  	struct address_space *mapping = inode->i_mapping;
>  	struct folio *folio;
>  
> -	folio = f2fs_get_read_data_folio(inode, index, 0, for_write, NULL);
> +	folio = f2fs_get_read_data_folio(inode, bidx, 0, for_write, NULL);
>  	if (IS_ERR(folio))
>  		return folio;
>  
> @@ -1819,7 +1829,7 @@ struct folio *f2fs_get_lock_data_folio(struct inode *inode, pgoff_t index,
>  	if (folio_test_large(folio) && !f2fs_folio_has_ffs(folio))
>  		f2fs_ffs_find_or_alloc(folio);
>  
> -	if (unlikely(!f2fs_ffs_test_blk_uptodate(folio, index))) {
> +	if (unlikely(!f2fs_ffs_test_blk_uptodate(folio, bidx))) {
>  		f2fs_folio_put(folio, true);
>  		return ERR_PTR(-EIO);
>  	}
> @@ -1838,12 +1848,15 @@ struct folio *f2fs_get_lock_data_folio(struct inode *inode, pgoff_t index,
>  struct folio *f2fs_get_new_data_folio(struct inode *inode,
>  		struct f2fs_cached_block *ientry, pgoff_t index, bool new_i_size)
>  {
> +	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
>  	struct address_space *mapping = inode->i_mapping;
> +	pgoff_t f_index = f2fs_has_subpage_blocks(sbi) ?
> +		f2fs_lblk_to_folio_index(sbi, index) : index;
>  	struct folio *folio;
>  	struct dnode_of_data dn;
>  	int err;
>  
> -	folio = f2fs_grab_cache_folio(mapping, index, true);
> +	folio = f2fs_grab_cache_folio(mapping, f_index, true);
>  	if (IS_ERR(folio)) {
>  		/*
>  		 * before exiting, we should make sure ientry will be released
> @@ -1869,25 +1882,24 @@ struct folio *f2fs_get_new_data_folio(struct inode *inode,
>  		goto got_it;
>  
>  	if (dn.data_blkaddr == NEW_ADDR) {
> -		size_t off = offset_in_folio(folio,
> -					(loff_t)index << PAGE_SHIFT);
> +		size_t off = f2fs_folio_byte_offset(sbi, folio, index);
>  
> -		folio_zero_segment(folio, off, off + PAGE_SIZE);
> -		f2fs_ffs_mark_subrange_uptodate(folio, off, PAGE_SIZE);
> +		folio_zero_segment(folio, off, off + F2FS_BLKSIZE(sbi));
> +		f2fs_ffs_mark_subrange_uptodate(folio, off, F2FS_BLKSIZE(sbi));
>  	} else {
>  		f2fs_folio_put(folio, true);
>  
>  		/* if ientry exists, blkaddr should be NEW_ADDR */
> -		f2fs_bug_on(F2FS_I_SB(inode), ientry);
> +		f2fs_bug_on(sbi, ientry);
>  		folio = f2fs_get_lock_data_folio(inode, index, true);
>  		if (IS_ERR(folio))
>  			return folio;
>  	}
>  got_it:
>  	if (new_i_size && i_size_read(inode) <
> -				F2FS_BLK_TO_BYTES(F2FS_I_SB(inode), index + 1))
> +				F2FS_BLK_TO_BYTES(sbi, index + 1))
>  		f2fs_i_size_write(inode,
> -				F2FS_BLK_TO_BYTES(F2FS_I_SB(inode), index + 1));
> +				F2FS_BLK_TO_BYTES(sbi, index + 1));
>  	return folio;
>  }
>  
> @@ -1968,7 +1980,7 @@ int f2fs_get_block_locked(struct dnode_of_data *dn, pgoff_t index)
>  
>  static int f2fs_map_no_dnode(struct inode *inode,
>  		struct f2fs_map_blocks *map, struct dnode_of_data *dn,
> -		pgoff_t pgoff)
> +		pgoff_t blkofs)
>  {
>  	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
>  
> @@ -1981,10 +1993,10 @@ static int f2fs_map_no_dnode(struct inode *inode,
>  	    (is_sbi_flag_set(sbi, SBI_IS_SHUTDOWN) || f2fs_cp_error(sbi)))
>  		return -EIO;
>  
> -	if (map->m_next_pgofs)
> -		*map->m_next_pgofs = f2fs_get_next_page_offset(dn, pgoff);
> +	if (map->m_next_blkofs)
> +		*map->m_next_blkofs = f2fs_get_next_block_offset(dn, blkofs);
>  	if (map->m_next_extent)
> -		*map->m_next_extent = f2fs_get_next_page_offset(dn, pgoff);
> +		*map->m_next_extent = f2fs_get_next_block_offset(dn, blkofs);
>  	return 0;
>  }
>  
> @@ -2191,19 +2203,19 @@ int f2fs_map_blocks(struct inode *inode, struct f2fs_map_blocks *map, int flag)
>  			goto sync_out;
>  		case F2FS_GET_BLOCK_FIEMAP:
>  			if (blkaddr == NULL_ADDR) {
> -				if (map->m_next_pgofs)
> -					*map->m_next_pgofs = pgofs + 1;
> +				if (map->m_next_blkofs)
> +					*map->m_next_blkofs = pgofs + 1;
>  				goto sync_out;
>  			}
>  			break;
>  		case F2FS_GET_BLOCK_DIO:
> -			if (map->m_next_pgofs)
> -				*map->m_next_pgofs = pgofs + 1;
> +			if (map->m_next_blkofs)
> +				*map->m_next_blkofs = pgofs + 1;
>  			break;
>  		default:
>  			/* for defragment case */
> -			if (map->m_next_pgofs)
> -				*map->m_next_pgofs = pgofs + 1;
> +			if (map->m_next_blkofs)
> +				*map->m_next_blkofs = pgofs + 1;
>  			goto sync_out;
>  		}
>  	}
> @@ -2344,7 +2356,7 @@ static bool __f2fs_overwrite_io(struct inode *inode, loff_t pos, size_t len,
>  		return false;
>  
>  	map.m_lblk = F2FS_BYTES_TO_BLK(F2FS_I_SB(inode), pos);
> -	map.m_next_pgofs = NULL;
> +	map.m_next_blkofs = NULL;
>  	map.m_next_extent = NULL;
>  	map.m_seg_type = NO_CHECK_TYPE;
>  	map.m_may_create = false;
> @@ -2447,7 +2459,7 @@ int f2fs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
>  	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
>  	struct f2fs_map_blocks map;
>  	sector_t start_blk, last_blk, blk_len, max_len;
> -	pgoff_t next_pgofs;
> +	pgoff_t next_blkofs;
>  	u64 logical = 0, phys = 0, size = 0;
>  	u32 flags = 0;
>  	int ret = 0;
> @@ -2497,7 +2509,7 @@ int f2fs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
>  	memset(&map, 0, sizeof(map));
>  	map.m_lblk = start_blk;
>  	map.m_len = blk_len;
> -	map.m_next_pgofs = &next_pgofs;
> +	map.m_next_blkofs = &next_blkofs;
>  	map.m_seg_type = NO_CHECK_TYPE;
>  
>  	if (compr_cluster) {
> @@ -2511,7 +2523,7 @@ int f2fs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
>  
>  	/* HOLE */
>  	if (!compr_cluster && !(map.m_flags & F2FS_MAP_FLAGS)) {
> -		start_blk = next_pgofs;
> +		start_blk = next_blkofs;
>  
>  		if (F2FS_BLK_TO_BYTES(sbi, start_blk) < maxbytes)
>  			goto prep_next;
> @@ -2647,7 +2659,7 @@ static int f2fs_read_single_page(struct inode *inode, struct fsverity_info *vi,
>  		if (block_in_file > map->m_lblk &&
>  			block_in_file < (map->m_lblk + map->m_len))
>  			goto got_it;
> -	} else if (block_in_file < *map->m_next_pgofs) {
> +	} else if (block_in_file < *map->m_next_blkofs) {
>  		goto got_it;
>  	}
>  
> @@ -3212,23 +3224,26 @@ static bool find_next_valid_block(const struct folio *folio,
>  				  size_t orig_off, size_t *need_off,
>  				  size_t len)
>  {
> +	struct f2fs_sb_info *sbi = F2FS_M_SB(folio->mapping);
>  	size_t start = orig_off;
>  	size_t end = start + len;
>  	size_t head, tail;
>  	pgoff_t index;
>  
> -	if (start & (PAGE_SIZE - 1)) {
> -		head = round_down(start, PAGE_SIZE);
> -		index = folio->index + (head >> PAGE_SHIFT);
> +	if (start & (F2FS_BLKSIZE(sbi) - 1)) {
> +		head = round_down(start, F2FS_BLKSIZE(sbi));
> +		index = f2fs_folio_lblk(sbi, folio) +
> +			F2FS_BYTES_TO_BLK(sbi, head);
>  		if (!f2fs_ffs_test_blk_uptodate(folio, index)) {
>  			*need_off = head;
>  			return true;
>  		}
>  	}
>  
> -	if (end & (PAGE_SIZE - 1)) {
> -		tail = round_down(end, PAGE_SIZE);
> -		index = folio->index + (tail >> PAGE_SHIFT);
> +	if (end & (F2FS_BLKSIZE(sbi) - 1)) {
> +		tail = round_down(end, F2FS_BLKSIZE(sbi));
> +		index = f2fs_folio_lblk(sbi, folio) +
> +			F2FS_BYTES_TO_BLK(sbi, tail);
>  		if (!f2fs_ffs_test_blk_uptodate(folio, index)) {
>  			*need_off = tail;
>  			return true;
> @@ -3251,26 +3266,34 @@ static unsigned int ffs_next_nonuptodate_subpage(struct f2fs_folio_state *ffs,
>  }
>  
>  static void f2fs_skip_fully_uptodate_front(struct folio *folio,
> -			pgoff_t *index, pgoff_t *offset, unsigned int *nrpages,
> -			unsigned int *max_nr_pages)
> +			pgoff_t *index, pgoff_t *offset, unsigned int *nr_blocks,
> +			unsigned int *max_nr_blocks)
>  {
>  	struct f2fs_folio_state *ffs;
>  	unsigned int next, skipped;
>  
> -	if (!f2fs_folio_has_ffs(folio) || !*nrpages)
> +	if (folio_test_uptodate(folio)) {
> +		*index += *nr_blocks;
> +		*offset += *nr_blocks;
> +		*max_nr_blocks -= *nr_blocks;
> +		*nr_blocks = 0;
> +		return;
> +	}
> +
> +	if (!f2fs_folio_has_ffs(folio) || !*nr_blocks)
>  		return;
>  
>  	ffs = (struct f2fs_folio_state *)folio->private;
>  	next = ffs_next_nonuptodate_subpage(ffs, *offset,
> -					    *offset + *nrpages - 1);
> +					    *offset + *nr_blocks - 1);
>  	skipped = next - *offset;
>  	if (!skipped)
>  		return;
>  
>  	*index += skipped;
>  	*offset += skipped;
> -	*nrpages -= skipped;
> -	*max_nr_pages -= skipped;
> +	*nr_blocks -= skipped;
> +	*max_nr_blocks -= skipped;
>  }
>  
>  static void f2fs_truncate_read_extent(struct inode *inode, struct folio *folio,
> @@ -3281,7 +3304,7 @@ static void f2fs_truncate_read_extent(struct inode *inode, struct folio *folio,
>  	struct f2fs_folio_state *ffs;
>  	unsigned int next, end;
>  
> -	if (!f2fs_folio_has_ffs(folio) || *len_blks <= 1)
> +	if (*len_blks <= 1)
>  		return;
>  
>  	if (f2fs_is_multi_device(sbi)) {
> @@ -3292,8 +3315,11 @@ static void f2fs_truncate_read_extent(struct inode *inode, struct folio *folio,
>  	}
>  	*len_blks = min_t(unsigned int, *len_blks,
>  			  (unsigned int)fscrypt_limit_io_blocks(inode,
> -							folio->index + offset,
> -							*len_blks));
> +					f2fs_folio_lblk(sbi, folio) + offset,
> +					*len_blks));
> +
> +	if (!f2fs_folio_has_ffs(folio) || *len_blks <= 1)
> +		return;
>  
>  	ffs = (struct f2fs_folio_state *)folio->private;
>  	end = offset + *len_blks - 1;
> @@ -3306,13 +3332,16 @@ static int f2fs_read_data_large_folio(struct inode *inode,
>  		struct fsverity_info *vi,
>  		struct readahead_control *rac, struct folio *folio)
>  {
> +	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
>  	struct bio *bio = NULL;
>  	sector_t last_block_in_bio = 0;
>  	struct f2fs_map_blocks map = {0, };
> -	pgoff_t index, offset, next_pgofs = 0;
> -	unsigned max_nr_pages = rac ? readahead_count(rac) :
> -				folio_nr_pages(folio);
> -	unsigned nrpages, len_blks;
> +	pgoff_t index, offset, next_blkofs = 0;
> +	unsigned int max_nr_blocks = rac ?
> +				(readahead_count(rac) * F2FS_BLKS_PER_PAGE(sbi)) :

How about defining F2FS_LOG_BLK_PER_PAGE? readahead_count(rac) << F2FS_LOG_BLK_PER_PAGE
should be faster.

> +				f2fs_blocks_per_folio(sbi, folio);
> +	unsigned int nr_blocks, len_blks;
> +	sector_t last_block_in_file;
>  	struct f2fs_folio_state *ffs;
>  	int ret = 0;
>  	bool folio_in_bio = false;
> @@ -3325,35 +3354,32 @@ static int f2fs_read_data_large_folio(struct inode *inode,
>  	if (!folio)
>  		goto out;
>  
> -	f2fs_update_read_folio_count(F2FS_I_SB(inode), folio);
> +	f2fs_update_read_folio_count(sbi, folio);
>  
>  	folio_in_bio = false;
> -	ffs = NULL;
> -	if (folio_test_large(folio)) {
> -		/*
> -		 * Allocate the folio state before doing anything with the
> -		 * folio, so that the block mapping helpers below can rely on
> -		 * it.
> -		 */
> -		ffs = f2fs_ffs_find_or_alloc(folio);
> -	}
> -	index = folio->index;
> +	index = f2fs_folio_lblk(sbi, folio);
>  	offset = 0;
> -	nrpages = folio_nr_pages(folio);
> +	nr_blocks = f2fs_blocks_per_folio(sbi, folio);
> +	last_block_in_file = F2FS_BYTES_TO_BLK(sbi, f2fs_readpage_limit(inode) +
> +					       F2FS_BLKSIZE(sbi) - 1);

F2FS_BLK_ALIGN(sbi, f2fs_readpage_limit(inode));

>  
> -	for (; nrpages;
> -	     nrpages -= len_blks, max_nr_pages -= len_blks,
> +	for (; nr_blocks;
> +	     nr_blocks -= len_blks, max_nr_blocks -= len_blks,
>  	     index += len_blks, offset += len_blks) {
>  		sector_t block_nr;
> +		bool whole_folio_in_bio;
>  		unsigned int i;
> +		size_t page_offset;
>  
>  		len_blks = 1;
>  
>  		f2fs_skip_fully_uptodate_front(folio, &index, &offset,
> -					       &nrpages, &max_nr_pages);
> -		if (!nrpages)
> +					       &nr_blocks, &max_nr_blocks);
> +		if (!nr_blocks)
>  			break;
>  
> +		page_offset = F2FS_BLK_TO_BYTES(sbi, offset);
> +
>  		/*
>  		 * Map blocks using the previous result first.
>  		 */
> @@ -3361,7 +3387,7 @@ static int f2fs_read_data_large_folio(struct inode *inode,
>  			if (index > map.m_lblk &&
>  				index < (map.m_lblk + map.m_len))
>  				goto got_it;
> -		} else if (index < next_pgofs) {
> +		} else if (index < next_blkofs) {
>  			/* hole case */
>  			goto got_it;
>  		}
> @@ -3371,26 +3397,30 @@ static int f2fs_read_data_large_folio(struct inode *inode,
>  		 * done with this page.
>  		 */
>  		memset(&map, 0, sizeof(map));
> -		map.m_next_pgofs = &next_pgofs;
> +		map.m_next_blkofs = &next_blkofs;
>  		map.m_seg_type = NO_CHECK_TYPE;
>  		map.m_lblk = index;
> -		map.m_len = max_nr_pages;
> +		map.m_len = max_nr_blocks;
>  
>  		ret = f2fs_map_blocks(inode, &map, F2FS_GET_BLOCK_DEFAULT);
>  		if (ret)
>  			goto err_out;
>  got_it:
> -		if ((map.m_flags & F2FS_MAP_MAPPED)) {
> +		/* Zero the blocks past EOF, as f2fs_read_single_page() does. */
> +		if ((map.m_flags & F2FS_MAP_MAPPED) &&
> +		    index < last_block_in_file) {
>  			block_nr = map.m_pblk + index - map.m_lblk;
>  
> -			len_blks = min_t(unsigned int, nrpages, max_nr_pages);
> +			len_blks = min_t(unsigned int, nr_blocks, max_nr_blocks);
>  			len_blks = min_t(unsigned int, len_blks,
>  					(unsigned int)(map.m_lblk + map.m_len - index));
> +			len_blks = min_t(unsigned int, len_blks,
> +					 last_block_in_file - index);
>  			f2fs_truncate_read_extent(inode, folio, offset,
>  						  block_nr, &len_blks);
>  
>  			for (i = 0; i < len_blks; i++) {
> -				if (!f2fs_is_valid_blkaddr(F2FS_I_SB(inode),
> +				if (!f2fs_is_valid_blkaddr(sbi,
>  						block_nr + i,
>  						DATA_GENERIC_ENHANCE_READ)) {
>  					ret = -EFSCORRUPTED;
> @@ -3398,18 +3428,21 @@ static int f2fs_read_data_large_folio(struct inode *inode,
>  				}
>  			}
>  
> +			whole_folio_in_bio = !f2fs_folio_has_ffs(folio) &&
> +					offset == 0 &&
> +					len_blks == f2fs_blocks_per_folio(sbi, folio);
>  		} else {
> -			size_t page_offset = offset << PAGE_SHIFT;
> -
> -			folio_zero_range(folio, page_offset, PAGE_SIZE);
> -			if (vi && !fsverity_verify_blocks(vi, folio, PAGE_SIZE, page_offset)) {
> +			folio_zero_range(folio, page_offset, F2FS_BLKSIZE(sbi));
> +			if (vi && !fsverity_verify_blocks(vi, folio,
> +					F2FS_BLKSIZE(sbi), page_offset)) {
>  				ret = -EIO;
>  				goto err_out;
>  			}
> -			if (folio_test_large(folio)) {
> +			if (f2fs_is_multiblock_folio(sbi, folio)) {
> +				ffs = f2fs_ffs_find_or_alloc(folio);
>  				spin_lock_irq(&ffs->state_lock);
>  				__ffs_mark_subrange_uptodate(folio, ffs,
> -						page_offset, PAGE_SIZE);
> +						page_offset, F2FS_BLKSIZE(sbi));
>  				spin_unlock_irq(&ffs->state_lock);
>  			}
>  			continue;
> @@ -3418,7 +3451,10 @@ static int f2fs_read_data_large_folio(struct inode *inode,
>  		/* We must increment read_blocks_pending before possible BIOs submitting
>  		 * to prevent from premature folio_end_read() call on folio
>  		 */
> -		if (folio_test_large(folio)) {
> +		ffs = NULL;
> +		if (f2fs_is_multiblock_folio(sbi, folio) && !whole_folio_in_bio) {
> +			ffs = f2fs_ffs_find_or_alloc(folio);
> +
>  			/* set the bitmap to wait */
>  			f2fs_update_read_folio_pending(folio, len_blks);
>  		}
> @@ -3427,16 +3463,16 @@ static int f2fs_read_data_large_folio(struct inode *inode,
>  		 * This page will go to BIO.  Do we need to send this
>  		 * BIO off first?
>  		 */
> -		if (bio && (!page_is_mergeable(F2FS_I_SB(inode), bio,
> +		if (bio && (!page_is_mergeable(sbi, bio,
>  						last_block_in_bio, block_nr) ||
>  			!f2fs_crypt_mergeable_bio(bio, inode, index, NULL))) {
>  submit_and_realloc:
> -			f2fs_submit_read_bio(F2FS_I_SB(inode), bio, DATA);
> +			f2fs_submit_read_bio(sbi, bio, DATA);
>  			bio = NULL;
>  		}
>  		if (bio == NULL)
>  			bio = f2fs_grab_read_bio(inode, vi,
> -					block_nr, max_nr_pages,
> +					block_nr, max_nr_blocks,
>  					f2fs_ra_op_flags(rac),
>  					index, false);
>  
> @@ -3447,33 +3483,33 @@ static int f2fs_read_data_large_folio(struct inode *inode,
>  		for (i = 0; i < len_blks; i++)
>  			f2fs_wait_on_block_writeback(inode, block_nr + i);
>  
> -		if (!bio_add_folio(bio, folio,
> -				len_blks * F2FS_BLKSIZE(F2FS_I_SB(inode)),
> -				offset << PAGE_SHIFT))
> +		if (!bio_add_folio(bio, folio, len_blks * F2FS_BLKSIZE(sbi),

F2FS_BLK_TO_BYTES(sbi, len_blks)

> +					page_offset))
>  			goto submit_and_realloc;
>  
>  		folio_in_bio = true;
> -		for (i = 0; i < len_blks; i++)
> -			inc_cache_count(F2FS_I_SB(inode), F2FS_RD_DATA);
> -		f2fs_update_iostat(F2FS_I_SB(inode), NULL, FS_DATA_READ_IO,
> -				len_blks * F2FS_BLKSIZE(F2FS_I_SB(inode)));
> +		add_cache_counts(sbi, F2FS_RD_DATA, len_blks);
> +		f2fs_update_iostat(sbi, NULL, FS_DATA_READ_IO,
> +				len_blks * F2FS_BLKSIZE(sbi));

F2FS_BLK_TO_BYTES(sbi, len_blks)

Thanks,

>  		last_block_in_bio = block_nr + len_blks - 1;
>  	}
>  	trace_f2fs_read_folio(folio, DATA);
> -err_out:
> -	if (!folio_in_bio)
> -		folio_end_read(folio, !ret);
> -	if (ret)
> -		goto out;
> +	if (!folio_in_bio) {
> +		if (!folio_test_uptodate(folio))
> +			folio_mark_uptodate(folio);
> +		folio_unlock(folio);
> +	}
>  	if (rac) {
>  		folio = readahead_folio(rac);
>  		goto next_folio;
>  	}
>  out:
> -	f2fs_submit_read_bio(F2FS_I_SB(inode), bio, DATA);
> -	if (ret && folio_in_bio) {
> -		/* Wait bios and clear uptodate. */
> -		folio_lock(folio);
> +	f2fs_submit_read_bio(sbi, bio, DATA);
> +	return ret;
> +err_out:
> +	f2fs_submit_read_bio(sbi, bio, DATA);
> +	/* The read completion unlocks a folio in the bio, not uptodate. */
> +	if (!folio_in_bio) {
>  		folio_clear_uptodate(folio);
>  		folio_unlock(folio);
>  	}
> @@ -3504,13 +3540,12 @@ static int f2fs_mpage_readpages(struct inode *inode, struct fsverity_info *vi,
>  	pgoff_t nc_cluster_idx = NULL_CLUSTER;
>  	pgoff_t index;
>  #endif
> -	pgoff_t next_pgofs = 0;
> +	pgoff_t next_blkofs = 0;
>  	unsigned nr_pages = rac ? readahead_count(rac) : 1;
> -	struct address_space *mapping = rac ? rac->mapping : folio->mapping;
>  	unsigned max_nr_pages = nr_pages;
>  	int ret = 0;
>  
> -	if (mapping_large_folio_support(mapping))
> +	if (f2fs_has_multiblock_folios(inode))
>  		return f2fs_read_data_large_folio(inode, vi, rac, folio);
>  
>  #ifdef CONFIG_F2FS_FS_COMPRESSION
> @@ -3525,7 +3560,7 @@ static int f2fs_mpage_readpages(struct inode *inode, struct fsverity_info *vi,
>  	map.m_lblk = 0;
>  	map.m_len = 0;
>  	map.m_flags = 0;
> -	map.m_next_pgofs = &next_pgofs;
> +	map.m_next_blkofs = &next_blkofs;
>  	map.m_next_extent = NULL;
>  	map.m_seg_type = NO_CHECK_TYPE;
>  	map.m_may_create = false;
> @@ -5489,9 +5524,9 @@ static int f2fs_write_begin(const struct kiocb *iocb,
>  		 * folio's owner; otherwise an unencrypted @inode whose COW inode
>  		 * is encrypted hits a NULL ->i_crypt_info on decryption.
>  		 */
> -		f2fs_submit_page_read(inode,
> -				      NULL, /* can't write to fsverity files */
> -				      folio, index, blkaddr, 0, true);
> +		f2fs_submit_block_read(inode,
> +				       NULL, /* can't write to fsverity files */
> +				       folio, index, blkaddr, 0, true);
>  
>  		folio_lock(folio);
>  		if (unlikely(folio->mapping != mapping)) {
> @@ -5728,7 +5763,7 @@ static sector_t f2fs_bmap(struct address_space *mapping, sector_t block)
>  		memset(&map, 0, sizeof(map));
>  		map.m_lblk = block;
>  		map.m_len = 1;
> -		map.m_next_pgofs = NULL;
> +		map.m_next_blkofs = NULL;
>  		map.m_seg_type = NO_CHECK_TYPE;
>  
>  		if (!f2fs_map_blocks(inode, &map, F2FS_GET_BLOCK_BMAP))
> @@ -5847,7 +5882,7 @@ static int check_swap_activate(struct swap_info_struct *sis,
>  		memset(&map, 0, sizeof(map));
>  		map.m_lblk = cur_lblock;
>  		map.m_len = last_lblock - cur_lblock;
> -		map.m_next_pgofs = NULL;
> +		map.m_next_blkofs = NULL;
>  		map.m_next_extent = NULL;
>  		map.m_seg_type = NO_CHECK_TYPE;
>  		map.m_may_create = false;
> @@ -5987,6 +6022,43 @@ static void f2fs_swap_deactivate(struct file *file)
>  }
>  #endif
>  
> +static bool f2fs_is_partially_uptodate(struct folio *folio, size_t from,
> +				       size_t count)
> +{
> +	struct inode *inode = folio->mapping->host;
> +	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
> +	struct f2fs_folio_state *ffs;
> +	unsigned int first, last, i;
> +
> +	if (folio_test_uptodate(folio))
> +		return true;
> +
> +	if (f2fs_has_inline_data(inode) || !f2fs_is_multiblock_folio(sbi, folio))
> +		return false;
> +
> +	if (!f2fs_folio_has_ffs(folio))
> +		return false;
> +
> +	if (from >= folio_size(folio))
> +		return false;
> +
> +	count = min_t(size_t, folio_size(folio) - from, count);
> +	if (!count)
> +		return false;
> +
> +	first = F2FS_BYTES_TO_BLK(sbi, from);
> +	last = F2FS_BYTES_TO_BLK(sbi, from + count - 1);
> +
> +	ffs = folio->private;
> +
> +	for (i = first; i <= last; i++) {
> +		if (!test_bit(i, ffs->state))
> +			return false;
> +	}
> +
> +	return true;
> +}
> +
>  const struct address_space_operations f2fs_dblock_aops = {
>  	.read_folio	= f2fs_read_data_folio,
>  	.readahead	= f2fs_readahead,
> @@ -5997,6 +6069,7 @@ const struct address_space_operations f2fs_dblock_aops = {
>  	.migrate_folio	= filemap_migrate_folio,
>  	.invalidate_folio = f2fs_invalidate_folio,
>  	.release_folio	= f2fs_release_folio,
> +	.is_partially_uptodate = f2fs_is_partially_uptodate,
>  	.bmap		= f2fs_bmap,
>  	.swap_activate  = f2fs_swap_activate,
>  	.swap_deactivate = f2fs_swap_deactivate,
> @@ -6087,13 +6160,13 @@ static int f2fs_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
>  {
>  	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
>  	struct f2fs_map_blocks map = { NULL, };
> -	pgoff_t next_pgofs = 0;
> +	pgoff_t next_blkofs = 0;
>  	int err;
>  
>  	map.m_lblk = F2FS_BYTES_TO_BLK(sbi, offset);
>  	map.m_len = F2FS_BYTES_TO_BLK(sbi, offset + length - 1) -
>  							map.m_lblk + 1;
> -	map.m_next_pgofs = &next_pgofs;
> +	map.m_next_blkofs = &next_blkofs;
>  	map.m_seg_type = f2fs_rw_hint_to_seg_type(F2FS_I_SB(inode),
>  						inode->i_write_hint);
>  	if (flags & IOMAP_WRITE && iomap->private) {
> @@ -6146,7 +6219,7 @@ static int f2fs_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
>  			return -ENOTBLK;
>  
>  		if (map.m_pblk == NULL_ADDR) {
> -			iomap->length = F2FS_BLK_TO_BYTES(sbi, next_pgofs) -
> +			iomap->length = F2FS_BLK_TO_BYTES(sbi, next_blkofs) -
>  							iomap->offset;
>  			iomap->type = IOMAP_HOLE;
>  		} else if (map.m_pblk == NEW_ADDR) {
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index bc67416a6663..cf7294068415 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -836,7 +836,7 @@ struct f2fs_map_blocks {
>  	unsigned int m_len;
>  	unsigned int m_flags;
>  	unsigned long m_last_pblk;	/* last allocated block, only used for DIO in LFS mode */
> -	pgoff_t *m_next_pgofs;		/* point next possible non-hole pgofs */
> +	pgoff_t *m_next_blkofs;		/* point next possible non-hole blkofs */
>  	pgoff_t *m_next_extent;		/* point to next possible extent */
>  	int m_seg_type;
>  	bool m_may_create;		/* indicate it is from write path */
> @@ -2349,6 +2349,12 @@ static inline bool f2fs_is_multiblock_folio(struct f2fs_sb_info *sbi,
>  	return folio_size(folio) > F2FS_BLKSIZE(sbi);
>  }
>  
> +static inline bool f2fs_has_multiblock_folios(struct inode *inode)
> +{
> +	return mapping_large_folio_support(inode->i_mapping) ||
> +		f2fs_has_subpage_blocks(F2FS_I_SB(inode));
> +}
> +
>  static inline pgoff_t f2fs_folio_lblk(struct f2fs_sb_info *sbi,
>  				      const struct folio *folio)
>  {
> @@ -4240,7 +4246,7 @@ bool f2fs_is_checkpointed_node(struct f2fs_sb_info *sbi, nid_t nid);
>  bool f2fs_need_inode_block_update(struct f2fs_sb_info *sbi, nid_t ino);
>  int f2fs_get_node_info(struct f2fs_sb_info *sbi, nid_t nid,
>  				struct node_info *ni, bool checkpoint_context);
> -pgoff_t f2fs_get_next_page_offset(struct dnode_of_data *dn, pgoff_t pgofs);
> +pgoff_t f2fs_get_next_block_offset(struct dnode_of_data *dn, pgoff_t blkofs);
>  int f2fs_get_dnode_of_data(struct dnode_of_data *dn, pgoff_t index, int mode);
>  int f2fs_truncate_inode_blocks(struct inode *inode, pgoff_t from);
>  int f2fs_truncate_xattr_node(struct inode *inode);
> @@ -4503,11 +4509,11 @@ int f2fs_reserve_new_blocks(struct dnode_of_data *dn, blkcnt_t count);
>  int f2fs_reserve_new_block(struct dnode_of_data *dn);
>  int f2fs_get_block_locked(struct dnode_of_data *dn, pgoff_t index);
>  int f2fs_reserve_block(struct dnode_of_data *dn, pgoff_t index);
> -struct folio *f2fs_get_read_data_folio(struct inode *inode, pgoff_t index,
> -		blk_opf_t op_flags, bool for_write, pgoff_t *next_pgofs);
> -struct folio *f2fs_find_data_folio(struct inode *inode, pgoff_t index,
> -		pgoff_t *next_pgofs);
> -struct folio *f2fs_get_lock_data_folio(struct inode *inode, pgoff_t index,
> +struct folio *f2fs_get_read_data_folio(struct inode *inode, pgoff_t bidx,
> +		blk_opf_t op_flags, bool for_write, pgoff_t *next_blkofs);
> +struct folio *f2fs_find_data_folio(struct inode *inode, pgoff_t bidx,
> +		pgoff_t *next_blkofs);
> +struct folio *f2fs_get_lock_data_folio(struct inode *inode, pgoff_t bidx,
>  			bool for_write);
>  struct folio *f2fs_get_new_data_folio(struct inode *inode,
>  			struct f2fs_cached_block *ientry, pgoff_t index, bool new_i_size);
> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> index 97c052b98559..1ce4553b1d01 100644
> --- a/fs/f2fs/file.c
> +++ b/fs/f2fs/file.c
> @@ -571,7 +571,7 @@ static loff_t f2fs_seek_block(struct file *file, loff_t offset, int whence)
>  		} else if (err == -ENOENT) {
>  			/* direct node does not exists */
>  			if (whence == SEEK_DATA) {
> -				pgofs = f2fs_get_next_page_offset(&dn, pgofs);
> +				pgofs = f2fs_get_next_block_offset(&dn, pgofs);
>  				continue;
>  			} else {
>  				goto found;
> @@ -1356,7 +1356,7 @@ int f2fs_truncate_hole(struct inode *inode, pgoff_t pg_start, pgoff_t pg_end)
>  		err = f2fs_get_dnode_of_data(&dn, pg_start, LOOKUP_NODE);
>  		if (err) {
>  			if (err == -ENOENT) {
> -				pg_start = f2fs_get_next_page_offset(&dn,
> +				pg_start = f2fs_get_next_block_offset(&dn,
>  								pg_start);
>  				continue;
>  			}
> @@ -2026,7 +2026,7 @@ static int f2fs_expand_inode_data(struct inode *inode, loff_t offset,
>  					loff_t len, int mode)
>  {
>  	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
> -	struct f2fs_map_blocks map = { .m_next_pgofs = NULL,
> +	struct f2fs_map_blocks map = { .m_next_blkofs = NULL,
>  			.m_next_extent = NULL, .m_seg_type = NO_CHECK_TYPE,
>  			.m_may_create = true };
>  	struct f2fs_gc_control gc_control = { .victim_segno = NULL_SEGNO,
> @@ -3095,7 +3095,7 @@ static int f2fs_defragment_range(struct f2fs_sb_info *sbi,
>  					.m_seg_type = NO_CHECK_TYPE,
>  					.m_may_create = false };
>  	struct extent_info ei = {};
> -	pgoff_t pg_start, pg_end, next_pgofs;
> +	pgoff_t pg_start, pg_end, next_blkofs;
>  	unsigned int total = 0, sec_num;
>  	block_t blk_end = 0;
>  	bool fragmented = false;
> @@ -3139,7 +3139,7 @@ static int f2fs_defragment_range(struct f2fs_sb_info *sbi,
>  	}
>  
>  	map.m_lblk = pg_start;
> -	map.m_next_pgofs = &next_pgofs;
> +	map.m_next_blkofs = &next_blkofs;
>  
>  	/*
>  	 * lookup mapping info in dnode page cache, skip defragmenting if all
> @@ -3153,7 +3153,7 @@ static int f2fs_defragment_range(struct f2fs_sb_info *sbi,
>  			goto out;
>  
>  		if (!(map.m_flags & F2FS_MAP_FLAGS)) {
> -			map.m_lblk = next_pgofs;
> +			map.m_lblk = next_blkofs;
>  			continue;
>  		}
>  
> @@ -3200,7 +3200,7 @@ static int f2fs_defragment_range(struct f2fs_sb_info *sbi,
>  			goto clear_out;
>  
>  		if (!(map.m_flags & F2FS_MAP_FLAGS)) {
> -			map.m_lblk = next_pgofs;
> +			map.m_lblk = next_blkofs;
>  			goto check;
>  		}
>  
> @@ -4092,7 +4092,7 @@ int f2fs_precache_extents(struct inode *inode)
>  
>  	map.m_lblk = 0;
>  	map.m_pblk = 0;
> -	map.m_next_pgofs = NULL;
> +	map.m_next_blkofs = NULL;
>  	map.m_next_extent = &m_next_extent;
>  	map.m_seg_type = NO_CHECK_TYPE;
>  	map.m_may_create = false;
> @@ -4385,7 +4385,7 @@ static int f2fs_release_compress_blocks(struct file *filp, unsigned long arg)
>  		if (ret) {
>  			f2fs_unlock_op(sbi, &lc);
>  			if (ret == -ENOENT) {
> -				page_idx = f2fs_get_next_page_offset(&dn,
> +				page_idx = f2fs_get_next_block_offset(&dn,
>  								page_idx);
>  				ret = 0;
>  				continue;
> @@ -4567,7 +4567,7 @@ static int f2fs_reserve_compress_blocks(struct file *filp, unsigned long arg)
>  		if (ret) {
>  			f2fs_unlock_op(sbi, &lc);
>  			if (ret == -ENOENT) {
> -				page_idx = f2fs_get_next_page_offset(&dn,
> +				page_idx = f2fs_get_next_block_offset(&dn,
>  								page_idx);
>  				ret = 0;
>  				continue;
> @@ -4735,7 +4735,7 @@ static int f2fs_sec_trim_file(struct file *filp, unsigned long arg)
>  		ret = f2fs_get_dnode_of_data(&dn, index, LOOKUP_NODE);
>  		if (ret) {
>  			if (ret == -ENOENT) {
> -				index = f2fs_get_next_page_offset(&dn, index);
> +				index = f2fs_get_next_block_offset(&dn, index);
>  				continue;
>  			}
>  			goto out;
> diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
> index 337ecf4df945..6c24001325b2 100644
> --- a/fs/f2fs/gc.c
> +++ b/fs/f2fs/gc.c
> @@ -1246,7 +1246,9 @@ static int ra_data_block(struct inode *inode, pgoff_t index)
>  	}
>  	f2fs_up_read(&F2FS_I(inode)->i_sem);
>  
> -	folio = f2fs_grab_cache_folio(mapping, index, true);
> +	pgoff_t f_index = f2fs_has_subpage_blocks(sbi) ?
> +		f2fs_lblk_to_folio_index(sbi, index) : index;
> +	folio = f2fs_grab_cache_folio(mapping, f_index, true);
>  	if (IS_ERR(folio)) {
>  		err = PTR_ERR(folio);
>  		goto out_iput;
> @@ -1323,6 +1325,30 @@ static int ra_data_block(struct inode *inode, pgoff_t index)
>  	return err;
>  }
>  
> +/*
> + * Prefetch the whole folio holding @bidx with one read, so that contiguous
> + * blocks in the folio share a bio. Skip the folio if it is locked, e.g. by
> + * the read issued for a previous block in the folio.
> + */
> +static void ra_data_folio(struct inode *inode, pgoff_t bidx)
> +{
> +	struct address_space *mapping = inode->i_mapping;
> +	struct folio *folio;
> +
> +	folio = __filemap_get_folio(mapping,
> +			f2fs_lblk_to_folio_index(F2FS_I_SB(inode), bidx),
> +			FGP_LOCK | FGP_CREAT | FGP_NOWAIT,
> +			mapping_gfp_mask(mapping));
> +	if (IS_ERR(folio))
> +		return;
> +
> +	if (folio_test_uptodate(folio))
> +		folio_unlock(folio);
> +	else
> +		mapping->a_ops->read_folio(NULL, folio);
> +	folio_put(folio);
> +}
> +
>  /*
>   * Move data block via meta cache while keeping locked data page.
>   * This can be used to move blocks, aka LBAs, directly on disk.
> @@ -1367,8 +1393,10 @@ static int move_data_block(struct inode *inode, block_t bidx,
>  	}
>  	f2fs_up_read(&F2FS_I(inode)->i_sem);
>  
> +	pgoff_t f_index = f2fs_has_subpage_blocks(fio.sbi) ?
> +		f2fs_lblk_to_folio_index(fio.sbi, bidx) : bidx;
>  	/* do not read out */
> -	folio = f2fs_grab_cache_folio(mapping, bidx, false);
> +	folio = f2fs_grab_cache_folio(mapping, f_index, false);
>  	if (IS_ERR(folio)) {
>  		err = PTR_ERR(folio);
>  		goto out_iput;
> @@ -1389,7 +1417,9 @@ static int move_data_block(struct inode *inode, block_t bidx,
>  		goto out;
>  
>  	if (unlikely(dn.data_blkaddr == NULL_ADDR)) {
> -		folio_clear_uptodate(folio);
> +		f2fs_ffs_clear_subrange_uptodate(folio,
> +			f2fs_folio_byte_offset(fio.sbi, folio, bidx),
> +			F2FS_BLKSIZE(fio.sbi));
>  		err = -ENOENT;
>  		goto put_out;
>  	}
> @@ -1516,24 +1546,26 @@ static int move_data_block(struct inode *inode, block_t bidx,
>  	return err;
>  }
>  
> -static int move_data_page(struct inode *inode, block_t bidx, int gc_type,
> +static int move_data_cache_block(struct inode *inode, block_t bidx, int gc_type,
>  						unsigned int segno, int off)
>  {
> +	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
>  	struct folio *folio;
>  	size_t foff = 0;
> -	bool large = false;
> +	bool has_ffs = false;
>  	int err = 0;
>  
>  	folio = f2fs_get_lock_data_folio(inode, bidx, true);
>  	if (IS_ERR(folio))
>  		return PTR_ERR(folio);
>  
> -	if (f2fs_folio_has_ffs(folio)) {
> -		large = true;
> -		foff = offset_in_folio(folio, (loff_t)bidx << PAGE_SHIFT);
> +	if (f2fs_is_multiblock_folio(sbi, folio)) {
> +		has_ffs = true;
> +		f2fs_ffs_find_or_alloc(folio);
> +		foff = f2fs_folio_byte_offset(sbi, folio, bidx);
>  	}
>  
> -	if (!check_valid_map(F2FS_I_SB(inode), segno, off)) {
> +	if (!check_valid_map(sbi, segno, off)) {
>  		err = -ENOENT;
>  		goto out;
>  	}
> @@ -1547,13 +1579,13 @@ static int move_data_page(struct inode *inode, block_t bidx, int gc_type,
>  			err = -EAGAIN;
>  			goto out;
>  		}
> -		if (large)
> -			f2fs_ffs_mark_subrange_dirty(folio, foff, PAGE_SIZE);
> +		if (has_ffs)
> +			f2fs_ffs_mark_subrange_dirty(folio, foff, F2FS_BLKSIZE(sbi));
>  		folio_mark_dirty(folio);
>  		folio_set_f2fs_gcing(folio);
>  	} else {
>  		struct f2fs_io_info fio = {
> -			.sbi = F2FS_I_SB(inode),
> +			.sbi = sbi,
>  			.ino = inode->i_ino,
>  			.type = DATA,
>  			.temp = COLD,
> @@ -1561,7 +1593,7 @@ static int move_data_page(struct inode *inode, block_t bidx, int gc_type,
>  			.op_flags = REQ_SYNC,
>  			.old_blkaddr = NULL_ADDR,
>  			.folio = folio,
> -			.folio_offset = bidx - folio->index,
> +			.folio_offset = f2fs_folio_blk_offset(sbi, folio, bidx),
>  			.folio_blkcnt = 1,
>  			.encrypted_page = NULL,
>  			.need_lock = LOCK_REQ,
> @@ -1572,15 +1604,15 @@ static int move_data_page(struct inode *inode, block_t bidx, int gc_type,
>  retry:
>  		f2fs_folio_wait_writeback(folio, true, true);
>  
> -		if (large)
> -			f2fs_ffs_mark_subrange_dirty(folio, foff, PAGE_SIZE);
> +		if (has_ffs)
> +			f2fs_ffs_mark_subrange_dirty(folio, foff, F2FS_BLKSIZE(sbi));
>  		folio_mark_dirty(folio);
>  		if (folio_clear_dirty_for_io(folio)) {
> -			if (!large) {
> +			if (!has_ffs) {
>  				inode_dec_dirty_block(inode);
>  				f2fs_remove_dirty_inode(inode);
>  			} else if (f2fs_ffs_clear_subrange_dirty_and_test(folio,
> -							foff, PAGE_SIZE)) {
> +						foff, F2FS_BLKSIZE(sbi))) {
>  				folio_mark_dirty(folio);
>  			}
>  		}
> @@ -1598,15 +1630,16 @@ static int move_data_page(struct inode *inode, block_t bidx, int gc_type,
>  				 * Keep gcing flag for redirtied folio, so that
>  				 * it can be guaranteed by checkpoint.
>  				 */
> -				if (large)
> -					f2fs_ffs_mark_subrange_dirty(folio, foff, PAGE_SIZE);
> +				if (has_ffs)
> +					f2fs_ffs_mark_subrange_dirty(folio, foff,
> +							F2FS_BLKSIZE(sbi));
>  				folio_mark_dirty(folio);
>  				folio_set_f2fs_gcing(folio);
>  			} else if (!f2fs_ffs_has_dirty_subpage(folio)) {
>  				/* migrate this block in later GC */
>  				folio_clear_f2fs_gcing(folio);
>  			}
> -		} else if (large && folio_test_dirty(folio)) {
> +		} else if (has_ffs && folio_test_dirty(folio)) {
>  			/*
>  			 * The folio is left both dirty and under writeback,
>  			 * submit the cached bio before unlocking it, otherwise
> @@ -1742,6 +1775,13 @@ static int gc_data_segment(struct f2fs_sb_info *sbi, struct f2fs_summary *sum,
>  				continue;
>  			}
>  
> +			if (f2fs_has_subpage_blocks(sbi)) {
> +				ra_data_folio(inode, start_bidx);
> +				f2fs_up_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
> +				add_gc_inode(gc_list, inode);
> +				continue;
> +			}
> +
>  			data_folio = f2fs_get_read_data_folio(inode, start_bidx,
>  							REQ_RAHEAD, true, NULL);
>  			f2fs_up_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
> @@ -1785,7 +1825,7 @@ static int gc_data_segment(struct f2fs_sb_info *sbi, struct f2fs_summary *sum,
>  				err = move_data_block(inode, start_bidx,
>  							gc_type, segno, off);
>  			else
> -				err = move_data_page(inode, start_bidx, gc_type,
> +				err = move_data_cache_block(inode, start_bidx, gc_type,
>  								segno, off);
>  
>  			if (!err && (gc_type == FG_GC ||
> diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
> index cb8affb2c1e0..c48b12208e20 100644
> --- a/fs/f2fs/node.c
> +++ b/fs/f2fs/node.c
> @@ -701,7 +701,7 @@ static void f2fs_ra_node_caches(struct f2fs_cached_block *parent, int start, int
>  	blk_finish_plug(&plug);
>  }
>  
> -pgoff_t f2fs_get_next_page_offset(struct dnode_of_data *dn, pgoff_t pgofs)
> +pgoff_t f2fs_get_next_block_offset(struct dnode_of_data *dn, pgoff_t blkofs)
>  {
>  	struct f2fs_sb_info *sbi = F2FS_I_SB(dn->inode);
>  	const long direct_index = ADDRS_PER_INODE(dn->inode);
> @@ -714,7 +714,7 @@ pgoff_t f2fs_get_next_page_offset(struct dnode_of_data *dn, pgoff_t pgofs)
>  	pgoff_t base = 0;
>  
>  	if (!dn->max_level)
> -		return pgofs + 1;
> +		return blkofs + 1;
>  
>  	while (max_level-- > cur_level)
>  		skipped_unit *= NIDS_PER_BLOCK(sbi);
> @@ -733,7 +733,7 @@ pgoff_t f2fs_get_next_page_offset(struct dnode_of_data *dn, pgoff_t pgofs)
>  		f2fs_bug_on(F2FS_I_SB(dn->inode), 1);
>  	}
>  
> -	return ((pgofs - base) / skipped_unit + 1) * skipped_unit + base;
> +	return ((blkofs - base) / skipped_unit + 1) * skipped_unit + base;
>  }
>  
>  /*



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
