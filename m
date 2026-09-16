Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C838BC88E5C
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 16 Sep 2026 11:47:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=88IJYY/onzwSLVcjjdc7+ag89AHmRj7hBIk1dtMxs5E=; b=UhEfwb3bGXgKD10MIo3LYfPXKM
	hITQZw3MD8+EofxSYuIiHtnaNzd+CLf6F1XoFAkCgjaEjmgUGE30naPkUxA9dK+TXX8TveRcALfEC
	vsQIWTk6FDe1r+isZ7bNtnWGYs0IqPnZxb4tShE0CspqdVilmfW9rws5SF5sMLXLkDLo=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1x6o6n-0001LX-3i;
	Wed, 16 Sep 2026 11:47:25 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1x6o6j-0001Kz-68
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 16 Sep 2026 11:47:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=kZRKNSQWm5kS0+QGQvTDt2BAcQoG2wcXTtCy79m3lRY=; b=dXfQEadoIPbEiJnWz0M7NjHGWw
 siX4hBwIYj36YyKcX6vo9InwUndfLUDPTdDb66aa8LC0Z3RXa5K04I1gyGJCgXB26EGHgm0HsZI+x
 U+ht2QQiXxxONpzQGRKfgp36KLEEAe3IavQGJ10Nz5n8S4J46g5hpeLfXWCmZvqGnhwg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=kZRKNSQWm5kS0+QGQvTDt2BAcQoG2wcXTtCy79m3lRY=; b=OovWR5nkxA7RWeb/BqEURF7e5s
 YEayp2FBA2VlqHaK4UhoNRGrJRv2DL5PhjzK6kFI6fk3LkLiv+x0f57dP5hzHK87R7dyhNs+zfdba
 l7i1+ZxYnlMy92FHP8/WgwGqOheYvsrqrfaPS0Muaj4fv66s2pXz8Lkv5amOLNngtYxM=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1x6o6h-0001Ww-LP for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 16 Sep 2026 11:47:21 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id E7CA860234;
 Wed, 16 Sep 2026 11:47:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 792821F000FF;
 Wed, 16 Sep 2026 11:47:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789559233;
 bh=kZRKNSQWm5kS0+QGQvTDt2BAcQoG2wcXTtCy79m3lRY=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To;
 b=J8QrbztgqNLFVtevBJaDEMoVW3hPUV0Uf5zEWfVj9xDHax+pK//CvJqaqnHRROsbB
 9RgZYSjnzczbFcKG5X9LE4w2fa0LXXos/u7h0c2jL8ksCatydtjmvG5qEa8LaPNmKb
 Ek/4d+8MStEj9oALgch/R+F0GYwvZmGYyGqrFZy4+cXwa34ZNLg3lca82iEF1eDY90
 gxYvMh8YhKJlG/+hDBsani2Tgf5Gtx9n3CJ9sanqjrsTBEaFkVZU2XKioeJPyolI+a
 CLTBuliKst+m7Cjmslg7/jGtIQnnCWZtCjVLRquBFg/EQdQieNTW2vpajzalpgJk2l
 9uOkdhV692bcA==
Message-ID: <78333738-966d-498e-9c36-19312de9ff71@kernel.org>
Date: Wed, 16 Sep 2026 19:47:09 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Nanzhe Zhao <zhaonanzhe@xiaomi.com>,
 linux-f2fs-devel@lists.sourceforge.net, Jaegeuk Kim <jaegeuk@kernel.org>
References: <20260915041909.2903887-1-zhaonanzhe@xiaomi.com>
 <20260915041909.2903887-4-zhaonanzhe@xiaomi.com>
Content-Language: en-US
In-Reply-To: <20260915041909.2903887-4-zhaonanzhe@xiaomi.com>
X-Headers-End: 1x6o6h-0001Ww-LP
Subject: Re: [f2fs-dev] [PATCH v2 03/14] f2fs: support regular file buffered
 writes on large folios
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

On 9/15/26 12:18, Nanzhe Zhao wrote:
> To avoid the complexity of unlocking a large folio in write_begin,
> preallocate partial blocks for inodes that can use large folios.
> During write_begin, read only the partial head and tail 4K subpages
> that need read-before-write, and skip read I/O for the full middle
> subpages covered by the write.
> 
> Signed-off-by: Nanzhe Zhao <zhaonanzhe@xiaomi.com>
> ---
>  fs/f2fs/data.c | 300 +++++++++++++++++++++++++++++++++++++++++++++++--
>  fs/f2fs/f2fs.h |   1 +
>  fs/f2fs/file.c |  17 ++-
>  3 files changed, 304 insertions(+), 14 deletions(-)
> 
> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> index f14044e8a6f4..a490df4f50b3 100644
> --- a/fs/f2fs/data.c
> +++ b/fs/f2fs/data.c
> @@ -1233,6 +1233,35 @@ static void f2fs_submit_page_read(struct inode *inode, struct fsverity_info *vi,
>  	f2fs_submit_read_bio(sbi, bio, DATA);
>  }
>  
> +/*
> + * Synchronously read a single 4K subpage by reusing f2fs_submit_page_read()
> + * so that iostat, trace, blk-crypto and post-read handling are all preserved.
> + * The caller must have already allocated ffs for the folio.
> + */
> +static int f2fs_submit_page_read_sync(struct inode *inode, struct folio *folio,
> +				      pgoff_t index, block_t blkaddr)
> +{
> +	struct f2fs_folio_state *ffs = folio->private;
> +
> +	/* Add bias so end_io does not call folio_end_read(). */
> +	f2fs_update_read_folio_pending(folio, 1);

f2fs_update_read_folio_pending() was used here for the first time, do we need
to relocate definition in this patch?

> +
> +	f2fs_submit_page_read(inode, NULL, folio, index, blkaddr,
> +			      REQ_OP_READ, false);
> +
> +	/* Wait until all bios have completed (pending drops back to our bias). */
> +	while (READ_ONCE(ffs->read_pages_pending) != 1)
> +		f2fs_io_schedule_timeout(DEFAULT_SCHEDULE_TIMEOUT);
> +
> +	/* Remove the bias. */
> +	f2fs_update_read_folio_pending(folio, -1);
> +
> +	if (!f2fs_ffs_test_blk_uptodate(folio, index))
> +		return -EIO;
> +
> +	return 0;
> +}
> +
>  static void __set_data_blkaddr(struct dnode_of_data *dn, block_t blkaddr)
>  {
>  	__le32 *addr = get_dnode_addr(dn->inode, dn->node_folio);
> @@ -2570,6 +2599,114 @@ static void ffs_detach_free(struct folio *folio)
>  	kfree(ffs);
>  }
>  
> +bool f2fs_ffs_test_blk_uptodate(const struct folio *folio, pgoff_t index)
> +{
> +	struct f2fs_folio_state *ffs;
> +	unsigned int idx;
> +
> +	f2fs_bug_on(F2FS_F_SB(folio), !folio_contains(folio, index));
> +
> +	if (folio_test_uptodate(folio))
> +		return true;
> +
> +	if (!f2fs_folio_has_ffs(folio))
> +		return false;
> +
> +	ffs = (struct f2fs_folio_state *)folio->private;
> +	idx = index - folio->index;
> +	return test_bit(idx, ffs->state);
> +}
> +
> +static bool __ffs_mark_subrange_uptodate(struct folio *folio,
> +		struct f2fs_folio_state *ffs, size_t offset, size_t len)
> +{
> +	unsigned int nr_subpages = folio_nr_pages(folio);
> +	unsigned int start, end;
> +
> +	start = offset >> PAGE_SHIFT;
> +	end = (offset + len + PAGE_SIZE - 1) >> PAGE_SHIFT;
> +	end = min(end, nr_subpages);
> +
> +	bitmap_set(ffs->state, start, end - start);
> +	return bitmap_full(ffs->state, nr_subpages);
> +}
> +
> +static void f2fs_ffs_mark_subrange_uptodate(struct folio *folio, size_t offset,
> +				       size_t len)
> +{
> +	struct f2fs_folio_state *ffs;
> +	unsigned long flags;
> +	bool mark_uptodate = false;
> +
> +	f2fs_bug_on(F2FS_F_SB(folio), offset + len > folio_size(folio));
> +
> +	if (!f2fs_folio_has_ffs(folio)) {
> +		folio_mark_uptodate(folio);
> +		return;
> +	}
> +
> +	ffs = (struct f2fs_folio_state *)folio->private;
> +	spin_lock_irqsave(&ffs->state_lock, flags);
> +	mark_uptodate = __ffs_mark_subrange_uptodate(folio, ffs, offset, len) &&
> +			!ffs->read_pages_pending;
> +	spin_unlock_irqrestore(&ffs->state_lock, flags);
> +	if (mark_uptodate)
> +		folio_mark_uptodate(folio);
> +}
> +
> +static void f2fs_ffs_mark_subrange_dirty(struct folio *folio,
> +				    size_t offset, size_t len)
> +{
> +	struct f2fs_folio_state *ffs;
> +	unsigned int nr_subpages, start, end;
> +	unsigned long flags;
> +
> +	f2fs_bug_on(F2FS_F_SB(folio), offset + len > folio_size(folio));
> +
> +	if (!f2fs_folio_has_ffs(folio))
> +		return;
> +
> +	ffs = (struct f2fs_folio_state *)folio->private;
> +	nr_subpages = folio_nr_pages(folio);
> +	start = offset >> PAGE_SHIFT;
> +	end = (offset + len + PAGE_SIZE - 1) >> PAGE_SHIFT;
> +	end = min(end, nr_subpages);
> +
> +	spin_lock_irqsave(&ffs->state_lock, flags);
> +	bitmap_set(ffs->state, nr_subpages + start, end - start);
> +	spin_unlock_irqrestore(&ffs->state_lock, flags);
> +}
> +
> +static bool find_next_valid_block(const struct folio *folio,
> +				  size_t orig_off, size_t *need_off,
> +				  size_t len)
> +{
> +	size_t start = orig_off;
> +	size_t end = start + len;
> +	size_t head, tail;
> +	pgoff_t index;
> +
> +	if (start & (PAGE_SIZE - 1)) {
> +		head = round_down(start, PAGE_SIZE);
> +		index = folio->index + (head >> PAGE_SHIFT);
> +		if (!f2fs_ffs_test_blk_uptodate(folio, index)) {
> +			*need_off = head;
> +			return true;
> +		}
> +	}
> +
> +	if (end & (PAGE_SIZE - 1)) {
> +		tail = round_down(end - 1, PAGE_SIZE);

tail = round_down(end, PAGE_SIZE);

> +		index = folio->index + (tail >> PAGE_SHIFT);
> +		if (!f2fs_ffs_test_blk_uptodate(folio, index)) {
> +			*need_off = tail;
> +			return true;
> +		}
> +	}
> +
> +	return false;
> +}
> +
>  static int f2fs_read_data_large_folio(struct inode *inode,
>  		struct fsverity_info *vi,
>  		struct readahead_control *rac, struct folio *folio)
> @@ -3927,6 +4064,110 @@ static int prepare_atomic_write_begin(struct f2fs_sb_info *sbi,
>  	return 0;
>  }
>  
> +static int prepare_large_folio_write_begin(struct inode *inode,
> +					  struct folio *folio, loff_t pos,
> +					  unsigned int len)
> +{
> +	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
> +	struct f2fs_folio_state *ffs;
> +	size_t ori_off = offset_in_folio(folio, pos);
> +	size_t need_off = ori_off;
> +	int err = 0;
> +
> +	len = min_t(unsigned int, len, folio_size(folio) - ori_off);
> +
> +	/*
> +	 * When folio minimum order is non-zero, the fsverity

Seems there is a condition that folio minimum order is non-zero, do we
need to check this condition along w/ FI_PREALLOCATED_ALL?

> +	 * page_cache_write() path enters f2fs_write_begin() via
> +	 * aops->write_begin without going through f2fs_write_iter(),
> +	 * so preallocation from f2fs_write_iter() is skipped.  In that
> +	 * case, if FI_PREALLOCATED_ALL is not set, we must preallocate
> +	 * the write blocks here.
> +	 */
> +	if (!is_inode_flag_set(inode, FI_PREALLOCATED_ALL)) {
> +		struct f2fs_map_blocks map = {};
> +
> +		map.m_lblk = F2FS_BYTES_TO_BLK(sbi, pos);
> +		map.m_len = F2FS_BLK_ALIGN(sbi, pos + len) - map.m_lblk;
> +
> +		if (!IS_DEVICE_ALIASING(inode))
> +			map.m_may_create = true;
> +		map.m_seg_type = NO_CHECK_TYPE;
> +
> +		err = f2fs_map_blocks(inode, &map, F2FS_GET_BLOCK_PRE_AIO);
> +		if (err)
> +			return err;
> +	}
> +
> +	ffs = f2fs_ffs_find_or_alloc(folio);
> +	if (!ffs)
> +		return -ENOMEM;
> +
> +	/* Skip read if the folio is already fully uptodate or the write
> +	 * covers the entire folio.
> +	 */
> +	if (folio_test_uptodate(folio) || len == folio_size(folio))
> +		return 0;
> +
> +	if (!f2fs_verity_in_progress(inode) &&
> +	    !(pos & (PAGE_SIZE - 1)) && (pos + len) >= i_size_read(inode)) {
> +		size_t zoff = ori_off + len;
> +
> +		if (zoff < folio_size(folio))
> +			folio_zero_segment(folio, zoff, folio_size(folio));
> +		return 0;
> +	}
> +
> +	/* Inline data must have been converted before reaching here. */
> +	f2fs_bug_on(sbi, f2fs_has_inline_data(inode));
> +
> +	while (find_next_valid_block(folio, ori_off,
> +				     &need_off, len)) {
> +		struct dnode_of_data dn;
> +		pgoff_t index = folio->index + (need_off >> PAGE_SHIFT);
> +		block_t blkaddr;
> +		bool get_dn = false;
> +
> +		if (!f2fs_lookup_read_extent_cache_block(inode, index,
> +							&blkaddr)) {
> +			if (IS_DEVICE_ALIASING(inode))
> +				return -ENODATA;
> +
> +			set_new_dnode(&dn, inode, NULL, NULL, 0);
> +			err = f2fs_get_dnode_of_data(&dn, index, LOOKUP_NODE);
> +			if (err)
> +				return err;
> +			get_dn = true;

Can we call f2fs_put_dnode(&dn) here? since we don't need to cover dnode
lock during I/O?

Thanks,

> +			blkaddr = dn.data_blkaddr;
> +
> +			if (blkaddr == NEW_ADDR) {
> +				size_t off = offset_in_folio(folio,
> +							     index << PAGE_SHIFT);
> +
> +				folio_zero_segment(folio, off, off + PAGE_SIZE);
> +				f2fs_ffs_mark_subrange_uptodate(folio, off,
> +							       PAGE_SIZE);
> +				goto out;
> +			}
> +
> +			if (!f2fs_is_valid_blkaddr(sbi, blkaddr,
> +						  DATA_GENERIC_ENHANCE_READ)) {
> +				err = -EFSCORRUPTED;
> +				goto out;
> +			}
> +		}
> +
> +		err = f2fs_submit_page_read_sync(inode, folio, index, blkaddr);
> +out:
> +		if (get_dn)
> +			f2fs_put_dnode(&dn);
> +		if (err)
> +			return err;
> +	}
> +
> +	return 0;
> +}
> +
>  static int f2fs_write_begin(const struct kiocb *iocb,
>  			    struct address_space *mapping,
>  			    loff_t pos, unsigned len, struct folio **foliop,
> @@ -3938,6 +4179,7 @@ static int f2fs_write_begin(const struct kiocb *iocb,
>  	pgoff_t index = pos >> PAGE_SHIFT;
>  	bool need_balance = false;
>  	block_t blkaddr = NULL_ADDR;
> +	fgf_t fgp = FGP_LOCK | FGP_WRITE | FGP_CREAT;
>  	int err = 0;
>  
>  	trace_f2fs_write_begin(inode, pos, len);
> @@ -3985,9 +4227,15 @@ static int f2fs_write_begin(const struct kiocb *iocb,
>  	 * Do not use FGP_STABLE to avoid deadlock.
>  	 * Will wait that below with our IO control.
>  	 */
> -	folio = f2fs_filemap_get_folio(mapping, index,
> -				FGP_LOCK | FGP_WRITE | FGP_CREAT,
> -				mapping_gfp_mask(mapping));
> +	/*
> +	 * Inline data is carried in the first subpage.  Keep the index #0
> +	 * folio order-0 so that the existing inline read/convert paths
> +	 * (prepare_write_begin()) still apply; large folios are used from
> +	 * the second folio on.
> +	 */
> +	fgp |= fgf_set_order(f2fs_has_inline_data(inode) ? PAGE_SIZE : len);
> +	folio = f2fs_filemap_get_folio(mapping, index, fgp,
> +				      mapping_gfp_mask(mapping));
>  	if (IS_ERR(folio)) {
>  		err = PTR_ERR(folio);
>  		goto fail;
> @@ -4000,7 +4248,7 @@ static int f2fs_write_begin(const struct kiocb *iocb,
>  	if (f2fs_is_atomic_file(inode))
>  		err = prepare_atomic_write_begin(sbi, folio, pos, len,
>  					&blkaddr, &need_balance);
> -	else
> +	else if (!folio_test_large(folio))
>  		err = prepare_write_begin(sbi, folio, pos, len,
>  					&blkaddr, &need_balance);
>  	if (err)
> @@ -4021,6 +4269,14 @@ static int f2fs_write_begin(const struct kiocb *iocb,
>  
>  	f2fs_folio_wait_writeback(folio, DATA, false, true);
>  
> +	if (folio_test_large(folio)) {
> +		err = prepare_large_folio_write_begin(inode,
> +					folio, pos, len);
> +		if (!err)
> +			return 0;
> +		goto put_folio;
> +	}
> +
>  	if (len == folio_size(folio) || folio_test_uptodate(folio))
>  		return 0;
>  
> @@ -4081,15 +4337,20 @@ static int f2fs_write_end(const struct kiocb *iocb,
>  	trace_f2fs_write_end(inode, pos, len, copied);
>  
>  	/*
> -	 * This should be come from len == PAGE_SIZE, and we expect copied
> -	 * should be PAGE_SIZE. Otherwise, we treat it with zero copied and
> -	 * let generic_perform_write() try to copy data again through copied=0.
> +	 * If a short copy happens on a folio that isn't uptodate, we treat
> +	 * it with zero copied and let generic_perform_write() try to copy
> +	 * data again through copied=0.
>  	 */
>  	if (!folio_test_uptodate(folio)) {
> -		if (unlikely(copied != len))
> +		if (unlikely(copied != len)) {
>  			copied = 0;
> -		else
> +		} else if (folio_test_large(folio)) {
> +			f2fs_ffs_mark_subrange_uptodate(folio,
> +					offset_in_folio(folio, pos), len);
> +		} else {
> +			/* This should be come from len == PAGE_SIZE */
>  			folio_mark_uptodate(folio);
> +		}
>  	}
>  
>  #ifdef CONFIG_F2FS_FS_COMPRESSION
> @@ -4108,6 +4369,9 @@ static int f2fs_write_end(const struct kiocb *iocb,
>  	if (!copied)
>  		goto unlock_out;
>  
> +	if (folio_test_large(folio))
> +		f2fs_ffs_mark_subrange_dirty(folio, offset_in_folio(folio, pos),
> +								   copied);
>  	folio_mark_dirty(folio);
>  
>  	if (f2fs_is_atomic_file(inode))
> @@ -4170,8 +4434,22 @@ static bool f2fs_dirty_data_folio(struct address_space *mapping,
>  
>  	trace_f2fs_set_page_dirty(folio, DATA);
>  
> -	if (!folio_test_uptodate(folio))
> -		folio_mark_uptodate(folio);
> +	if (!folio_test_uptodate(folio)) {
> +		bool uptodate = true;
> +
> +		if (f2fs_folio_has_ffs(folio)) {
> +			struct f2fs_folio_state *ffs =
> +				(struct f2fs_folio_state *)folio->private;
> +			unsigned long flags;
> +
> +			spin_lock_irqsave(&ffs->state_lock, flags);
> +			uptodate = bitmap_full(ffs->state, folio_nr_pages(folio)) &&
> +				   !ffs->read_pages_pending;
> +			spin_unlock_irqrestore(&ffs->state_lock, flags);
> +		}
> +		if (uptodate)
> +			folio_mark_uptodate(folio);
> +	}
>  	BUG_ON(folio_test_swapcache(folio));
>  
>  	if (filemap_dirty_folio(mapping, folio)) {
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index 326382ede1c3..8eccca6e5d27 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -4392,6 +4392,7 @@ int f2fs_write_single_data_page(struct folio *folio, int *submitted,
>  				struct writeback_control *wbc,
>  				enum iostat_type io_type,
>  				int compr_blocks, bool allow_balance);
> +bool f2fs_ffs_test_blk_uptodate(const struct folio *folio, pgoff_t index);
>  void f2fs_write_failed(struct inode *inode, loff_t to);
>  void f2fs_invalidate_folio(struct folio *folio, size_t offset, size_t length);
>  bool f2fs_release_folio(struct folio *folio, gfp_t wait);
> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> index b0bdc7a977b9..9071bd23e57b 100644
> --- a/fs/f2fs/file.c
> +++ b/fs/f2fs/file.c
> @@ -5412,9 +5412,20 @@ static int f2fs_preallocate_blocks(struct kiocb *iocb, struct iov_iter *iter,
>  			return ret;
>  	}
>  
> -	/* Do not preallocate blocks that will be written partially in 4KB. */
> -	map.m_lblk = F2FS_BLK_ALIGN(sbi, pos);
> -	map.m_len = F2FS_BYTES_TO_BLK(sbi, pos + count);
> +	if (!dio && mapping_large_folio_support(inode->i_mapping)) {
> +		/*
> +		 * Preallocate all blocks touched by a large-folio buffered write so
> +		 * the regular write_begin path does not need to unlock the folio for
> +		 * f2fs_balance_fs().  Rechecking large-folio state after unlock is
> +		 * unreliable since partial truncation can split the folio.
> +		 */
> +		map.m_lblk = F2FS_BYTES_TO_BLK(sbi, pos);
> +		map.m_len = F2FS_BLK_ALIGN(sbi, pos + count);
> +	} else {
> +		/* Do not preallocate blocks that will be written partially in 4KB. */
> +		map.m_lblk = F2FS_BLK_ALIGN(sbi, pos);
> +		map.m_len = F2FS_BYTES_TO_BLK(sbi, pos + count);
> +	}
>  	if (map.m_len > map.m_lblk)
>  		map.m_len -= map.m_lblk;
>  	else



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
