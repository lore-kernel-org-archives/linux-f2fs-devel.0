Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63205C61DE2
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 31 Aug 2026 03:14:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Content-Transfer-Encoding:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vPX2Ujl4om3rLJLS3fYvClzePhcX/6x9LZRJQVJuMgY=; b=MMlmdflUMOv3s7PEYCXVj3Piax
	9UsxJIhIjE/AFFzJPcRbvKu525YcnAbSKIOk21+KGxiXdDrCYGfzr/DBFPq/vmEi4LCcKFcnc9X27
	FIMSqKjlH1HVT5dtX4/ImCDdqr3zn+lKPKGBL8RS0lxErtpkoE6wtfTvoAwOGVGleUhk=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1x0sTU-0007g3-4d;
	Mon, 31 Aug 2026 03:14:20 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1x0sTS-0007fu-Bd
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 31 Aug 2026 03:14:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=08CjuaLjuuTwIB8JeYvme32XZoFlFknp9FI90lwGVIo=; b=KanSzKf4t43nQtZNAqx3EHQLjd
 FW5Dnwsy+FX5JyN/bQ8XliAgsa/vCkXQofOszn2pNw9J6EEwHwrtDinXYBw5pZsqw78bqlOhVUy+Q
 cRs3czbu6p56IHVXc/36RI/kjl+B9NcgR7xhDivXSsyeVsjOm02qJeJH7g5Zh0vr1Q3g=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=08CjuaLjuuTwIB8JeYvme32XZoFlFknp9FI90lwGVIo=; b=bpausBrBWiTiDtpiBQsO+iN1PQ
 9vWPWoLMFl/v/+8519vZ4hW1jXhbVmDRXcJGvneNz7JBhYYUixregmT8evXHiklmQrFeq2uTWwYhj
 Q4fLk/TUbXeuxBU4a3FENHms0am4h9DBbprok14rZUEYuIaJfUoyZYRXClvFn4XyH/xw=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1x0sTS-0005bS-2L for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 31 Aug 2026 03:14:19 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 586B960120;
 Mon, 31 Aug 2026 03:14:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95BE91F000E9;
 Mon, 31 Aug 2026 03:14:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788146052;
 bh=08CjuaLjuuTwIB8JeYvme32XZoFlFknp9FI90lwGVIo=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To;
 b=G58g9XpBGTW7wmr5ym9qC/JSttM/boBEUjgrR2BBfyQde1N9RE1ABDB/60Va/hAWc
 1U+SSryC/wRKaSF/q+lAM0ZvAMyBYGPU5mZ4t84VXZMc6RuCclsDqog1t4Vf8vNsrk
 whdEpfaEVoVIj2nLPW/WlU3zumJhy6mYFEvsR0QSBu8CQf0fa3NImV8Ia/2p5syVun
 hggpXl+6zncmV03w1FBfFMlZo6qzbHsnAP8BV6C4r4wO89aACEGcgIe+X8Sr3sQkI1
 ET7czBkTbyhpduhNF57vNlocwJZyAC2d1o2ujVGu7l1Vf2mwEcDbNvv0CgL/0EWuFQ
 6/jfAw+X5WdJQ==
Message-ID: <45c09edb-138c-4d78-a6aa-c50dfa73cead@kernel.org>
Date: Mon, 31 Aug 2026 11:14:07 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Nanzhe Zhao <zhaonanzhe@xiaomi.com>,
 linux-f2fs-devel@lists.sourceforge.net, Jaegeuk Kim <jaegeuk@kernel.org>
References: <20260826082641.2007658-1-zhaonanzhe@xiaomi.com>
 <20260826082641.2007658-8-zhaonanzhe@xiaomi.com>
Content-Language: en-US
In-Reply-To: <20260826082641.2007658-8-zhaonanzhe@xiaomi.com>
X-Headers-End: 1x0sTS-0005bS-2L
Subject: Re: [f2fs-dev] [PATCH 07/14] f2fs: make GC migration large-folio
 aware
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 8/26/26 16:26, Nanzhe Zhao wrote:
> GC can operate on a 4K block that is cached inside a large folio.
> The data lookup helpers therefore need to test and update uptodate
> state for the addressed subpage instead of rejecting large folios or
> treating the whole folio as the target block.
> 
> Let f2fs_get_read_data_folio(), f2fs_find_data_folio(), and
> f2fs_get_lock_data_folio() to use subpage uptodate state. Submit
> single-block reads at the requested folio offset and zero only the
> addressed 4K range for NEW_ADDR.
> 
> Also update `move_data_page` to mark, clear, and restore dirty
> state for the target subpage, and submit write I/O with the subpage
> offset recorded in f2fs_io_info.
> 
> Signed-off-by: Nanzhe Zhao <zhaonanzhe@xiaomi.com>
> ---
>   fs/f2fs/data.c | 96 ++++++++++++++++++++++++++++++++++----------------
>   fs/f2fs/f2fs.h |  6 ++--
>   fs/f2fs/gc.c   | 30 ++++++++++++++--
>   3 files changed, 97 insertions(+), 35 deletions(-)
> 
> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> index 608d8ea8e607..0e54b1e25893 100644
> --- a/fs/f2fs/data.c
> +++ b/fs/f2fs/data.c
> @@ -1241,19 +1241,31 @@ static struct bio *f2fs_grab_read_bio(struct inode *inode,
>   
>   /* This can handle encryption stuffs */
>   static void f2fs_submit_page_read(struct inode *inode, struct fsverity_info *vi,
> -				  struct folio *folio, block_t blkaddr,
> -				  blk_opf_t op_flags, bool for_write)
> +				  struct folio *folio, pgoff_t index,
> +				  block_t blkaddr, blk_opf_t op_flags,
> +				  bool for_write)
>   {
>   	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
>   	struct bio *bio;
> +	size_t offset = 0;
>   
> -	bio = f2fs_grab_read_bio(inode, vi, blkaddr, 1, op_flags, folio->index,
> +	if (f2fs_folio_has_ffs(folio)) {
> +		struct f2fs_folio_state *ffs = folio->private;
> +		unsigned long flags;
> +
> +		offset = offset_in_folio(folio, (loff_t)index << PAGE_SHIFT);



> +		spin_lock_irqsave(&ffs->state_lock, flags);
> +		ffs->read_pages_pending++;
> +		spin_unlock_irqrestore(&ffs->state_lock, flags);
> +	}

How about wrapping this to a function, and use it to clean up the codes.

f2fs_update_read_folio_pending(, pages)

> +
> +	bio = f2fs_grab_read_bio(inode, vi, blkaddr, 1, op_flags, index,
>   				 for_write);
>   
>   	/* wait for GCed page writeback via META_MAPPING */
>   	f2fs_wait_on_block_writeback(inode, blkaddr);
>   
> -	if (!bio_add_folio(bio, folio, PAGE_SIZE, 0))
> +	if (!bio_add_folio(bio, folio, PAGE_SIZE, offset))
>   		f2fs_bug_on(sbi, 1);
>   
>   	inc_page_count(sbi, F2FS_RD_DATA);
> @@ -1399,21 +1411,13 @@ struct folio *f2fs_get_read_data_folio(struct inode *inode, pgoff_t index,
>   	struct dnode_of_data dn;
>   	struct folio *folio;
>   	int err;
> -retry:
> +
>   	folio = f2fs_grab_cache_folio(mapping, index, for_write);
>   	if (IS_ERR(folio))
>   		return folio;
>   
> -	if (folio_test_large(folio)) {
> -		pgoff_t folio_index = mapping_align_index(mapping, index);
> -		unsigned long nr_pages = folio_nr_pages(folio);
> -
> -		f2fs_folio_put(folio, true);
> -		invalidate_inode_pages2_range(mapping, folio_index,
> -				folio_index + nr_pages - 1);
> -		f2fs_schedule_timeout(DEFAULT_SCHEDULE_TIMEOUT);
> -		goto retry;
> -	}
> +	if (folio_test_large(folio))
> +		f2fs_ffs_find_or_alloc(folio);
>   
>   	if (f2fs_lookup_read_extent_cache_block(inode, index,
>   						&dn.data_blkaddr)) {
> @@ -1448,7 +1452,7 @@ struct folio *f2fs_get_read_data_folio(struct inode *inode, pgoff_t index,
>   		goto put_err;
>   	}
>   got_it:
> -	if (folio_test_uptodate(folio)) {
> +	if (f2fs_ffs_test_blk_uptodate(folio, index)) {
>   		folio_unlock(folio);
>   		return folio;
>   	}
> @@ -1461,15 +1465,17 @@ struct folio *f2fs_get_read_data_folio(struct inode *inode, pgoff_t index,
>   	 * f2fs_init_inode_metadata.
>   	 */
>   	if (dn.data_blkaddr == NEW_ADDR) {
> -		folio_zero_segment(folio, 0, folio_size(folio));
> -		if (!folio_test_uptodate(folio))
> -			folio_mark_uptodate(folio);
> +		size_t offset = offset_in_folio(folio,
> +						(loff_t)index << PAGE_SHIFT);
> +
> +		folio_zero_segment(folio, offset, offset + PAGE_SIZE);
> +		f2fs_ffs_mark_subrange_uptodate(folio, offset, PAGE_SIZE);
>   		folio_unlock(folio);
>   		return folio;
>   	}
>   
> -	f2fs_submit_page_read(inode, f2fs_need_verity(inode, folio->index),
> -			      folio, dn.data_blkaddr, op_flags, for_write);
> +	f2fs_submit_page_read(inode, f2fs_need_verity(inode, index),
> +			      folio, index, dn.data_blkaddr, op_flags, for_write);
>   	return folio;
>   
>   put_err:
> @@ -1486,7 +1492,7 @@ struct folio *f2fs_find_data_folio(struct inode *inode, pgoff_t index,
>   	folio = f2fs_filemap_get_folio(mapping, index, FGP_ACCESSED, 0);
>   	if (IS_ERR(folio))
>   		goto read;
> -	if (folio_test_uptodate(folio))
> +	if (f2fs_ffs_test_blk_uptodate(folio, index))
>   		return folio;
>   	f2fs_folio_put(folio, false);
>   
> @@ -1495,11 +1501,11 @@ struct folio *f2fs_find_data_folio(struct inode *inode, pgoff_t index,
>   	if (IS_ERR(folio))
>   		return folio;
>   
> -	if (folio_test_uptodate(folio))
> +	if (f2fs_ffs_test_blk_uptodate(folio, index))
>   		return folio;
>   
>   	folio_wait_locked(folio);
> -	if (unlikely(!folio_test_uptodate(folio))) {
> +	if (unlikely(!f2fs_ffs_test_blk_uptodate(folio, index))) {
>   		f2fs_folio_put(folio, false);
>   		return ERR_PTR(-EIO);
>   	}
> @@ -1523,7 +1529,8 @@ struct folio *f2fs_get_lock_data_folio(struct inode *inode, pgoff_t index,
>   
>   	/* wait for read completion */
>   	folio_lock(folio);
> -	if (unlikely(folio->mapping != mapping || !folio_test_uptodate(folio))) {
> +	if (unlikely(folio->mapping != mapping ||
> +		    !f2fs_ffs_test_blk_uptodate(folio, index))) {
>   		f2fs_folio_put(folio, true);
>   		return ERR_PTR(-EIO);
>   	}
> @@ -2681,6 +2688,23 @@ static void f2fs_ffs_mark_subrange_uptodate(struct folio *folio, size_t offset,
>   		folio_mark_uptodate(folio);
>   }
>   
> +bool f2fs_ffs_test_blk_dirty(const struct folio *folio, pgoff_t index)
> +{
> +	struct f2fs_folio_state *ffs;
> +	unsigned int idx, nr_subpages;
> +
> +	if (!f2fs_folio_has_ffs(folio))
> +		return folio_test_dirty(folio);
> +
> +	if (!folio_contains(folio, index))
> +		return false;

Can we change this to a sanity check?

> +
> +	ffs = folio->private;
> +	nr_subpages = folio_nr_pages(folio);
> +	idx = index - folio->index;
> +	return test_bit(nr_subpages + idx, ffs->state);
> +}
> +
>   void f2fs_ffs_mark_subrange_dirty(struct folio *folio,
>   				    size_t offset, size_t len)
>   {
> @@ -2719,18 +2743,30 @@ static bool __ffs_clear_subrange_dirty(struct folio *folio,
>   			2 * nr_subpages;
>   }
>   
> -void f2fs_ffs_clear_subrange_dirty(struct folio *folio, size_t offset, size_t len)
> +/**
> + * f2fs_ffs_clear_subrange_dirty - clear the dirty bits of a folio subrange
> + * @folio: the large folio
> + * @offset: start byte offset within the folio
> + * @len: byte length of the subrange
> + *
> + * Clear the dirty bits of the 4K subpages covered by [offset, offset + len),
> + * and return whether the folio still has any dirty subpage left.
> + */
> +bool f2fs_ffs_clear_subrange_dirty(struct folio *folio, size_t offset,
> +				   size_t len)
>   {
>   	struct f2fs_folio_state *ffs;
>   	unsigned long flags;
> +	bool dirty;
>   
>   	if (!f2fs_folio_has_ffs(folio))
> -		return;
> +		return false;
>   
> -	ffs = (struct f2fs_folio_state *)folio->private;
> +	ffs = folio->private;
>   	spin_lock_irqsave(&ffs->state_lock, flags);
> -	__ffs_clear_subrange_dirty(folio, ffs, offset, len);
> +	dirty = __ffs_clear_subrange_dirty(folio, ffs, offset, len);
>   	spin_unlock_irqrestore(&ffs->state_lock, flags);
> +	return dirty;
>   }
>   
>   static unsigned int ffs_next_dirty_subpage(struct f2fs_folio_state *ffs,
> @@ -4853,7 +4889,7 @@ static int f2fs_write_begin(const struct kiocb *iocb,
>   		 */
>   		f2fs_submit_page_read(inode,
>   				      NULL, /* can't write to fsverity files */
> -				      folio, blkaddr, 0, true);
> +				      folio, index, blkaddr, 0, true);
>   
>   		folio_lock(folio);
>   		if (unlikely(folio->mapping != mapping)) {
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index 71e6d7e34c7b..0ffbe2bd04c8 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -4344,10 +4344,10 @@ int f2fs_write_single_data_page(struct folio *folio, int *submitted,
>   				int compr_blocks, bool allow_balance);
>   bool f2fs_ffs_test_blk_uptodate(const struct folio *folio, pgoff_t index);
>   struct f2fs_folio_state *f2fs_ffs_find_or_alloc(struct folio *folio);
> +bool f2fs_ffs_test_blk_dirty(const struct folio *folio, pgoff_t index);
>   void f2fs_ffs_mark_subrange_dirty(struct folio *folio, size_t offset, size_t len);
> -bool f2fs_ffs_clear_subrange_dirty_and_test(struct folio *folio, size_t offset,
> -					size_t len);
> -void f2fs_ffs_clear_subrange_dirty(struct folio *folio, size_t offset, size_t len);
> +bool f2fs_ffs_clear_subrange_dirty(struct folio *folio, size_t offset,
> +				   size_t len);
>   void f2fs_write_failed(struct inode *inode, loff_t to);
>   void f2fs_invalidate_folio(struct folio *folio, size_t offset, size_t length);
>   bool f2fs_release_folio(struct folio *folio, gfp_t wait);
> diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
> index 0c17038fcfd7..42e6dfcbf98d 100644
> --- a/fs/f2fs/gc.c
> +++ b/fs/f2fs/gc.c
> @@ -1504,12 +1504,19 @@ static int move_data_page(struct inode *inode, block_t bidx, int gc_type,
>   						unsigned int segno, int off)
>   {
>   	struct folio *folio;
> +	size_t foff = 0;
> +	bool large = false;
>   	int err = 0;
>   
>   	folio = f2fs_get_lock_data_folio(inode, bidx, true);
>   	if (IS_ERR(folio))
>   		return PTR_ERR(folio);
>   
> +	if (f2fs_folio_has_ffs(folio)) {
> +		large = true;
> +		foff = offset_in_folio(folio, (loff_t)bidx << PAGE_SHIFT);
> +	}
> +
>   	if (!check_valid_map(F2FS_I_SB(inode), segno, off)) {
>   		err = -ENOENT;
>   		goto out;
> @@ -1524,6 +1531,8 @@ static int move_data_page(struct inode *inode, block_t bidx, int gc_type,
>   			err = -EAGAIN;
>   			goto out;
>   		}
> +		if (large)
> +			f2fs_ffs_mark_subrange_dirty(folio, foff, PAGE_SIZE);
>   		folio_mark_dirty(folio);
>   		folio_set_f2fs_gcing(folio);
>   	} else {
> @@ -1536,32 +1545,49 @@ static int move_data_page(struct inode *inode, block_t bidx, int gc_type,
>   			.op_flags = REQ_SYNC,
>   			.old_blkaddr = NULL_ADDR,
>   			.folio = folio,
> +			.folio_offset = bidx - folio->index,
> +			.folio_blkcnt = 1,
>   			.encrypted_page = NULL,
>   			.need_lock = LOCK_REQ,
>   			.io_type = FS_GC_DATA_IO,
>   		};
> -		bool is_dirty = folio_test_dirty(folio);
> +		struct f2fs_folio_state *ffs = NULL;
> +		bool is_dirty = f2fs_ffs_test_blk_dirty(folio, bidx);
>   
>   retry:
>   		f2fs_folio_wait_writeback(folio, DATA, true, true);
>   
> +		if (large) {
> +			ffs = folio->private;
> +			f2fs_ffs_mark_subrange_dirty(folio, foff, PAGE_SIZE);
> +		}
>   		folio_mark_dirty(folio);
>   		if (folio_clear_dirty_for_io(folio)) {
>   			inode_dec_dirty_pages(inode);
>   			f2fs_remove_dirty_inode(inode);
> +			if (large &&
> +			    f2fs_ffs_clear_subrange_dirty(folio, foff, PAGE_SIZE))
> +				folio_mark_dirty(folio);

Why do we need to mark folio dirty again after clearing dirty?

Thanks,

>   		}
>   
> +		if (large)
> +			atomic_inc(&ffs->write_pages_pending);
>   		folio_set_f2fs_gcing(folio);
>   
>   		err = f2fs_do_write_data_page(&fio);
>   		if (err) {
>   			folio_clear_f2fs_gcing(folio);
> +			if (large)
> +				atomic_dec(&ffs->write_pages_pending);
>   			if (err == -ENOMEM) {
>   				memalloc_retry_wait(GFP_NOFS);
>   				goto retry;
>   			}
> -			if (is_dirty)
> +			if (is_dirty) {
> +				if (large)
> +					f2fs_ffs_mark_subrange_dirty(folio, foff, PAGE_SIZE);
>   				folio_mark_dirty(folio);
> +			}
>   		}
>   	}
>   out:



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
