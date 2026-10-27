Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1070606A31A
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 27 Oct 2026 09:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=TcD8Brqr;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=Bzb0H5nH;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=PCinJxrS;
	dkim=neutral header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Vs44Vzwk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=JvZROhztxAphDUdktT+iW5Sk+uHuvr6Hur6+h3BX+dY=; b=TcD8BrqrYqAXEM
	Id9EUzydzwkprJn2pDz3J8N6Trs4iQy0TmugFcBbTI7RbM3chgcfyFJyn82pwEXT6/u+3Z8DWxW2J
	DvYjjlo0GWgOsr+CzkbDDF3J6CJIJXweW8dEte6S+sXIbtke+d2nc/JC46o9EQQvvnEMOcj+2Bp5Q
	B3k=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xLdaA-000000004bU-3HKh;
	Tue, 27 Oct 2026 09:35:02 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <chao@kernel.org>) id 1xLdZu-000000004aP-17RG
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 27 Oct 2026 09:34:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=oCzWD3tejoxMjAehKZoa5YQ+1ysfxpmL4Mt6sWyvuQ8=; b=Bzb0H5nHiVy5uVr6Kz9fCI+Qps
 A/OP/xTp2wsYwamsgeo2dU+9kHM+qqW9vM9OiZym5r6SyrGKzZpmeBT+feAPrWk93iQzEJKVvabLB
 NoBTtOokc1L1gnx/Rv7Gs3lUMQxCWkwmdM29I3EysO6i/VxXW+5pTd5k4+Vg+ozLPC6E=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=oCzWD3tejoxMjAehKZoa5YQ+1ysfxpmL4Mt6sWyvuQ8=; b=PCinJxrSzJY2cIWE4A5EQ+vZe1
 Cm0p8/cYTMh3pbq1gd4K5+aQEBdpFNBJ80MXnIBPjMB5nho+duKEl0RJ+p6wXJnbZCvkwn4aX38mV
 FUUg6MdC1FbrbFwICVh8rUS8KhN3z3fJodJHd3usfTF/jiMrah5HJBb15AlApyI76TNQ=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xLdZs-000000001ZN-2Nk7
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 27 Oct 2026 09:34:46 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id D451F60136;
 Tue, 27 Oct 2026 09:34:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C25E11F031E8;
 Tue, 27 Oct 2026 09:34:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793093678;
 bh=oCzWD3tejoxMjAehKZoa5YQ+1ysfxpmL4Mt6sWyvuQ8=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To;
 b=Vs44Vzwk7BMmcYt/OQLDT2i6dwhI+/QEidMJ5jY5EaY8w9LFu+1onHkFy4DVxkEMx
 RrViY6wiJjsCEvLizjCSJ2i73zh4FY3chNiRuvLjJ3/giOS/bOAXGkzXSu+OlsPm0o
 doKDSeoiue+IBYDeOUQQlIriQ32KTD9+yCTZFap0clLnhWQ+PXWq1XjK6QOpHkBdKq
 kQaA+VpGyfdDb7OzlYhWon2sVopYvpv9ZJal+GQr9I1w08r62TB+A3Pr1ykXIzD1Ll
 AIon99bNnGgsOfUGzqDxIlskTR9DewtRa0xsWgtCzFelWXcyaK9Cnafr0gmPC7mTpf
 0BaXb3+BsBYJg==
Message-ID: <51afb2dd-9cb7-4997-b20a-4199f8239864@kernel.org>
Date: Tue, 27 Oct 2026 17:34:33 +0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Nanzhe Zhao <nzzhao.sigma@gmail.com>,
 linux-f2fs-devel@lists.sourceforge.net, Jaegeuk Kim <jaegeuk@kernel.org>
References: <20261026033745.784107-1-nzzhao.sigma@gmail.com>
 <20261026033745.784107-6-nzzhao.sigma@gmail.com>
Content-Language: en-US
In-Reply-To: <20261026033745.784107-6-nzzhao.sigma@gmail.com>
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xLdZs-000000001ZN-2Nk7
Subject: Re: [f2fs-dev] [PATCH v7 05/15] f2fs: support large folio writeback
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
Cc: Barry Song <baohua@kernel.org>, Juan Yescas <jyescas@google.com>,
 Daeho Jeong <daehojeong@google.com>, linux-kernel@vger.kernel.org,
 Dev Jain <Dev.Jain@arm.com>, David Hildenbrand <David.Hildenbrand@arm.com>,
 Pengfei Li <lipengfei28@xiaomi.com>, Bo Zhang <zhangbo56@xiaomi.com>,
 Kalesh Singh <kaleshsingh@google.com>, Nanzhe Zhao <nzzhao@126.com>,
 Nanzhe Zhao <zhaonanzhe@xiaomi.com>, Ryan Roberts <Ryan.Roberts@arm.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-17.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/26/26 11:37, Nanzhe Zhao wrote:
> From: Nanzhe Zhao <zhaonanzhe@xiaomi.com>
> 
> Large folio can contain multiple dirty ranges.
> Add a folio-based writeback path for large-folio mapping files
> and keep the legacy f2fs_write_cache_pages() path unchanged for
> non large-folio mapping files.
> 
> Signed-off-by: Nanzhe Zhao <zhaonanzhe@xiaomi.com>
> ---
>  fs/f2fs/data.c    | 521 +++++++++++++++++++++++++++++++++++++++++++++-
>  fs/f2fs/segment.c |   8 +-
>  2 files changed, 521 insertions(+), 8 deletions(-)
> 
> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> index 126cad81227f..a0822d06e3bc 100644
> --- a/fs/f2fs/data.c
> +++ b/fs/f2fs/data.c
> @@ -358,6 +358,49 @@ static void f2fs_cache_write_end_bio(struct bio *bio)
>  	bio_put(bio);
>  }
>  
> +static bool f2fs_ffs_has_dirty_subpage(struct folio *folio)
> +{
> +	struct f2fs_folio_state *ffs;
> +	unsigned long flags;
> +	unsigned int nr_subpages;
> +	bool dirty;
> +
> +	if (!f2fs_folio_has_ffs(folio))
> +		return false;
> +
> +	ffs = (struct f2fs_folio_state *)folio->private;
> +	nr_subpages = folio_nr_pages(folio);
> +
> +	spin_lock_irqsave(&ffs->state_lock, flags);
> +	dirty = find_next_bit(ffs->state, 2 * nr_subpages,
> +				nr_subpages) < 2 * nr_subpages;
> +	spin_unlock_irqrestore(&ffs->state_lock, flags);
> +
> +	return dirty;
> +}
> +
> +/*
> + * Drop a write page pending of @folio.  When the last pending is gone,
> + * clear PAGE_PRIVATE_GCING if no dirty subpage is left, and end
> + * writeback if it was started.
> + */
> +static void f2fs_ffs_put_write_pending(struct folio *folio, unsigned int nr)
> +{
> +	struct f2fs_folio_state *ffs;
> +
> +	if (!f2fs_folio_has_ffs(folio))
> +		goto release;
> +
> +	ffs = (struct f2fs_folio_state *)folio->private;
> +	if (!atomic_sub_and_test(nr, &ffs->write_pages_pending))
> +		return;
> +release:
> +	if (!f2fs_ffs_has_dirty_subpage(folio))
> +		folio_clear_f2fs_gcing(folio);
> +	if (folio_test_writeback(folio))
> +		folio_end_writeback(folio);
> +}
> +
>  static void f2fs_write_end_bio(struct bio *bio)
>  {
>  	struct f2fs_sb_info *sbi = bio->bi_private;
> @@ -373,6 +416,8 @@ static void f2fs_write_end_bio(struct bio *bio)
>  
>  	bio_for_each_folio_all(fi, bio) {
>  		struct folio *folio = fi.folio;
> +		unsigned int nr_pages = fi.length >> PAGE_SHIFT;
> +		unsigned int npages = nr_pages;
>  		enum count_type type;
>  
>  #ifdef CONFIG_F2FS_FS_COMPRESSION
> @@ -392,7 +437,8 @@ static void f2fs_write_end_bio(struct bio *bio)
>  			}
>  		}
>  
> -		dec_cache_count(sbi, type);
> +		while (nr_pages--)
> +			dec_cache_count(sbi, type);
>  
>  		/*
>  		 * we should access sbi before folio_end_writeback() to
> @@ -402,8 +448,7 @@ static void f2fs_write_end_bio(struct bio *bio)
>  				wq_has_sleeper(&sbi->cp_wait))
>  			wake_up(&sbi->cp_wait);
>  
> -		folio_clear_f2fs_gcing(folio);
> -		folio_end_writeback(folio);
> +		f2fs_ffs_put_write_pending(folio, npages);
>  	}
>  
>  	bio_put(bio);
> @@ -2940,7 +2985,7 @@ static unsigned int __ffs_mark_subrange_dirty(struct folio *folio,
>  	return bitmap_weight(ffs->state, 2 * nr_subpages) - before;
>  }
>  
> -static void f2fs_ffs_mark_subrange_dirty(struct folio *folio,
> +void f2fs_ffs_mark_subrange_dirty(struct folio *folio,
>  				    size_t offset, size_t len)
>  {
>  	struct f2fs_folio_state *ffs;
> @@ -2958,6 +3003,99 @@ static void f2fs_ffs_mark_subrange_dirty(struct folio *folio,
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
> @@ -3495,7 +3633,7 @@ int f2fs_do_write_data_page(struct f2fs_io_info *fio)
>  	if (ipu_force ||
>  		(__is_valid_data_blkaddr(fio->old_blkaddr) &&
>  					need_inplace_update(fio))) {
> -		folio_start_writeback(folio);
> +		__folio_start_writeback(folio, folio_test_dirty(folio));
>  		f2fs_put_dnode(&dn);
>  		if (fio->need_lock == LOCK_REQ)
>  			f2fs_unlock_op(fio->sbi, &lc);
> @@ -3522,7 +3660,7 @@ int f2fs_do_write_data_page(struct f2fs_io_info *fio)
>  
>  	fio->version = ni.version;
>  
> -	folio_start_writeback(folio);
> +	__folio_start_writeback(folio, folio_test_dirty(folio));
>  
>  	if (fio->compr_blocks && fio->old_blkaddr == COMPRESS_ADDR)
>  		f2fs_i_compr_blocks_update(inode, fio->compr_blocks - 1, false);
> @@ -3530,6 +3668,13 @@ int f2fs_do_write_data_page(struct f2fs_io_info *fio)
>  	/* LFS mode write path */
>  	f2fs_outplace_write_data(&dn, fio);
>  	trace_f2fs_do_write_data_page(folio, OPU);
> +	/*
> +	 * The outplace write path failed to submit this block.
> +	 */
> +	if (!fio->submitted) {
> +		err = -EIO;
> +		goto out_writepage;
> +	}
>  	set_inode_flag(inode, FI_APPEND_WRITE);
>  	if (atomic_commit)
>  		folio_clear_f2fs_atomic(folio);
> @@ -3541,6 +3686,144 @@ int f2fs_do_write_data_page(struct f2fs_io_info *fio)
>  	return err;
>  }
>  
> +static int f2fs_write_folio_dirty_range(struct folio *folio, int *submitted,
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
> +			dn_held = false;
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
> +		/*
> +		 * The outplace write path failed to submit this block.
> +		 */
> +		if (!fio.submitted) {
> +			err = -EIO;
> +			goto block_done;
> +		}
> +		if (submitted)
> +			(*submitted)++;
> +		submitted_blk = true;
> +		set_inode_flag(inode, FI_APPEND_WRITE);
> +		trace_f2fs_do_write_data_page(folio, OPU);
> +block_done:
> +		if (dn_held)
> +			f2fs_put_dnode(&dn);
> +		/*
> +		 * If this block was not submitted, roll back its
> +		 * write pages pending.
> +		 */
> +		if (!submitted_blk && ffs)
> +			f2fs_ffs_put_write_pending(folio, 1);
> +		if (!err) {
> +			*pos = ((loff_t)data_idx + 1) << PAGE_SHIFT;
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
> @@ -3990,6 +4273,226 @@ static int f2fs_write_cache_pages(struct address_space *mapping,
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
> +		retry = false;
> +
> +		if (err) {
> +			folio_redirty_for_writepage(wbc, folio);
> +			goto retry_out;
> +		}
> +
> +		if (atomic_read(&sbi->wb_sync_req[DATA]) &&
> +		    wbc->sync_mode == WB_SYNC_NONE) {
> +			folio_redirty_for_writepage(wbc, folio);
> +			/*
> +			 * A WB_SYNC_ALL writeback is in progress, so defer
> +			 * this writeback.  Mark the error as -EBUSY to let
> +			 * writeback_iter() stop iterating.
> +			 */
> +			err = -EBUSY;
> +			goto retry_out;
> +		}
> +
> +		/*
> +		 * If cp_error is set, all subpages of this folio are not written
> +		 * back unless the filesystem is mounted with errors=remount-ro.
> +		 */
> +		if (unlikely(f2fs_cp_error(sbi))) {
> +			mapping_set_error(folio->mapping, -EIO);
> +			if (F2FS_OPTION(sbi).errors == MOUNT_ERRORS_READONLY) {
> +				folio_redirty_for_writepage(wbc, folio);
> +			} else {
> +				if (f2fs_folio_has_ffs(folio))
> +					f2fs_ffs_clear_subrange_dirty_and_test(folio, 0,
> +									folio_size(folio));
> +				inode_dec_dirty_pages(inode);
> +			}
> +			goto retry_out;
> +		}
> +
> +		/*
> +		 * Writing back one large folio performs multiple block allocations, so
> +		 * best-effort balance the filesystem before writing it back.
> +		 */
> +		if (!F2FS_I(inode)->wb_task && has_not_enough_free_secs(sbi, 0, 0)) {
> +			folio_redirty_for_writepage(wbc, folio);
> +			retry = true;
> +			folio_unlock(folio);
> +			f2fs_balance_fs(sbi, true);
> +			folio_lock(folio);
> +			goto retry;
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
> +				f2fs_folio_wait_writeback(folio, true, true);
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
> +		/*
> +		 * Large folios can be submitted as multiple bios, which may
> +		 * complete while we are still submitting the remaining dirty
> +		 * ranges.  Hold a bias on write_pages_pending to prevent
> +		 * folio_end_writeback() from being called early.
> +		 */
> +		if (!bias_added && f2fs_folio_has_ffs(folio)) {
> +			ffs = (struct f2fs_folio_state *)folio->private;
> +			WARN_ON_ONCE(atomic_read(&ffs->write_pages_pending) != 0);
> +			atomic_inc(&ffs->write_pages_pending);
> +			bias_added = true;
> +		}
> +
> +		while ((r_len = ffs_find_dirty_range(folio, &pos, end_pos))) {
> +			err = f2fs_write_folio_dirty_range(folio, &submitted,
> +					wbc, io_type, &pos, r_len);
> +			folio_submitted += submitted;
> +			nwritten += submitted;
> +			if (err)
> +				goto out;
> +		}
> +
> +		/* If none of the subpages of a folio is submitted, keep the atomic flag */
> +		if (folio_submitted &&
> +		    f2fs_is_atomic_file(inode) &&
> +		    folio_test_f2fs_atomic(folio))
> +			folio_clear_f2fs_atomic(folio);
> +
> +out:
> +		/*
> +		 * Clear the dirty state of the subranges that were written back.
> +		 * If some subranges are still dirty (e.g. the folio was only
> +		 * partially written back), or if the writeback failed, the
> +		 * folio must stay dirty so that the remaining subranges are
> +		 * written back later.
> +		 */
> +		if (f2fs_ffs_clear_subrange_dirty_and_test(folio, 0,
> +					(err ? pos : end_pos) - folio_pos(folio)) || err)

dirty bits may set beyond isize?

- fill_zero() with KEEP_SIZE beyond i_size;
- BG_GC on blocks beyond EOF;
- f2fs_ffs_find_or_alloc() on an already-dirty folio, which sets all dirty bits.

So we'd better to clear all bits in ffs?

size_t clear_pos = err ? pos - folio_pos(folio) : folio_size(folio);

if (f2fs_ffs_clear_subrange_dirty_and_test(folio, 0, clear_pos) || err)

Thanks,


> +			folio_redirty_for_writepage(wbc, folio);
> +		else
> +			inode_dec_dirty_pages(inode);
> +
> +		/*
> +		 * Release the bias taken above and we end writeback here if
> +		 * no write bio is in flight.
> +		 */
> +		if (bias_added) {
> +			f2fs_ffs_put_write_pending(folio, 1);
> +		} else if (!folio_submitted && folio_test_writeback(folio)) {
> +			/*
> +			 * Order-0 folios take no bias, so end the writeback
> +			 * if nothing was submitted.
> +			 */
> +			folio_end_writeback(folio);
> +		}
> +
> +retry_out:
> +		if (op_locked) {
> +			f2fs_unlock_op(sbi, &lc);
> +			op_locked = false;
> +		}
> +
> +		folio_unlock(folio);
> +	}
> +
> +	if (nwritten)
> +		f2fs_submit_merged_write_cond(F2FS_M_SB(mapping), mapping->host,
> +					       NULL);
> +
> +	/*
> +	 * Prevent the -EBUSY error that stopped writeback_iter() from
> +	 * propagating to the user.
> +	 */
> +	if (err == -EBUSY)
> +		err = 0;
> +	return err;
> +}
> +
>  static inline bool __should_serialize_io(struct inode *inode,
>  					struct writeback_control *wbc)
>  {
> @@ -4084,7 +4587,11 @@ static int __f2fs_write_data_pages(struct address_space *mapping,
>  	account_writeback(inode, true);
>  
>  	blk_start_plug(&plug);
> -	ret = f2fs_write_cache_pages(mapping, wbc, io_type);
> +	if (mapping_large_folio_support(inode->i_mapping) &&
> +	    !f2fs_has_inline_data(inode))
> +		ret = f2fs_write_cache_folios(mapping, wbc, io_type);
> +	else
> +		ret = f2fs_write_cache_pages(mapping, wbc, io_type);
>  	blk_finish_plug(&plug);
>  
>  	account_writeback(inode, false);
> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> index 80f58c586e33..cbb65e0343c8 100644
> --- a/fs/f2fs/segment.c
> +++ b/fs/f2fs/segment.c
> @@ -4173,7 +4173,13 @@ static void do_write_block(struct f2fs_summary *sum, struct f2fs_io_info *fio)
>  				"%s Failed to allocate data block, ino:%u, index:%lu, type:%d, old_blkaddr:0x%x, new_blkaddr:0x%x, err:%d",
>  				__func__, fio->ino, folio->index, type,
>  				fio->old_blkaddr, fio->new_blkaddr, err);
> -			folio_end_writeback(folio);
> +			/*
> +			 * For a large folio, the caller rolls back
> +			 * write_pages_pending and ends writeback when the last
> +			 * pending write is gone.
> +			 */
> +			if (!f2fs_folio_has_ffs(folio))
> +				folio_end_writeback(folio);
>  		}
>  		f2fs_bug_on(fio->sbi, !is_set_ckpt_flags(fio->sbi,
>  							CP_ERROR_FLAG));



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
