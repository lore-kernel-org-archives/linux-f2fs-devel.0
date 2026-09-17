Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09E42C982CD
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 17 Sep 2026 06:33:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=AUHyFrqF9pVvgJvvtDbES/0beMlwSLbwFaT0AiDYuhs=; b=IoRsQT6FhXyZtMZRqJuzparln9
	UQnQjx6ToDG2M6F5Wl4VMAXROaRMK+iP7dXK0iyWZOx2yq2l2TIbE1C4LakeRyTTreJr1mibuhTP5
	xzuFgjFtXpNQYZfpjBLZMlHuLvrlyJXGZVF+8YOkB+0RcDVTV1W0ixGXOrfCtCp81fl4=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1x75gJ-0003xL-FN;
	Thu, 17 Sep 2026 06:33:13 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1x75gH-0003xF-Tg
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 17 Sep 2026 06:33:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=2Dkf6N5LkZEVeQLvEwSSS0z/qszvyO+arKERtyYiiCc=; b=IkLaR7gfomwzCS8Sh+dZ5BMy94
 5izmxwOtsnwjtJev2CawS4HbmOqZjFhSVmNh+2p7qERxe3a//SJcA/vFdAn8gywFll10A0cYNaeG7
 kK/uOCtlsjJPIAmn2Rm9uqGFUVkpgJASJ+Y+hHAfy7QCuaVAqZSlzkryRWi3YbCh9oik=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=2Dkf6N5LkZEVeQLvEwSSS0z/qszvyO+arKERtyYiiCc=; b=kFKSEk9pBHqsjpJwf9kL2vGx+O
 /gc93lu9yrC8o5ktdZawGZliNaQhFSUAp4mbuH0arCWFYb0UmYiP3NnK5Gg8sfvBuhBp9uBXfyT6X
 2HAC3XtkNNP9A7nQt3K6ndY7aTlH0Kc0uihDNFMomgp+W62OqTUcPzEAziEpBU5yuQlc=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1x75gD-0003Gf-Ub for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 17 Sep 2026 06:33:11 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 5438260200;
 Thu, 17 Sep 2026 06:33:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B66811F000FF;
 Thu, 17 Sep 2026 06:33:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789626784;
 bh=2Dkf6N5LkZEVeQLvEwSSS0z/qszvyO+arKERtyYiiCc=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To;
 b=bQAZYBLCXtKHUFc//cySnC8WUPfX8kyL60sJp1kHjOfYQPPCf5C9lL2HMC+mtndZn
 nPIrCrEG0+ermm8Q1w4W3u+CrgyjgCOwseS4sW5a0mb/pvSwIkSvcLtntba+SKT+PC
 m47vNGF3vTYuddU5cRPC4LMkvIyT+8/2y1kADAd7vmA9wJ4GvCDhUtd0yEXP1L6fV4
 nRj5xRBt0vbstNL9KFTxpJO3Lchr3RWweT8wKL8Zl20oSmIS6HCR9ue4vIZ7mvYzBs
 F0XJvQpgI68NQ/N3mvJeZzOO62s4g0bVt2MIEHWPfKAV85yZDM0RLeGmQlETN66xOA
 47L6pq1gpTpgQ==
Message-ID: <fe99e57f-20e4-4975-b7ed-f6e16ed331ed@kernel.org>
Date: Thu, 17 Sep 2026 14:32:59 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Nanzhe Zhao <zhaonanzhe@xiaomi.com>,
 linux-f2fs-devel@lists.sourceforge.net, Jaegeuk Kim <jaegeuk@kernel.org>
References: <20260915041909.2903887-1-zhaonanzhe@xiaomi.com>
 <20260915041909.2903887-7-zhaonanzhe@xiaomi.com>
Content-Language: en-US
In-Reply-To: <20260915041909.2903887-7-zhaonanzhe@xiaomi.com>
X-Headers-End: 1x75gD-0003Gf-Ub
Subject: Re: [f2fs-dev] [PATCH v2 06/14] f2fs: prepare mmap write faults for
 large folios
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
> Now write protect `mmap` also need to support large folio,
> Change `f2fs_vm_page_mkwrite` to acheive that.
> 
> Note it currently marks the whole large folio dirty
> to avoid data loss which causes write amplification.
> Further optimization is welcome.
> 
> PG_mappedtodisk is useless in f2fs, so drop the
> folio_test_mappedtodisk() check and its goto out_sem
> shortcut in f2fs_vm_page_mkwrite().  We extend the
> folio_zero_segment() in mkwrite to zero the post-EOF part
> of the faulted folio for both order-0 and large folios, so
> the f2fs_zero_post_eof_page() call added to cover that
> shortcut is no longer needed.
> 
> Signed-off-by: Nanzhe Zhao <zhaonanzhe@xiaomi.com>
> ---
>  fs/f2fs/f2fs.h |   4 ++
>  fs/f2fs/file.c | 107 ++++++++++++++++++++++++++++++-------------------
>  2 files changed, 70 insertions(+), 41 deletions(-)
> 
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index 8eccca6e5d27..f48e2627d90a 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -4393,6 +4393,10 @@ int f2fs_write_single_data_page(struct folio *folio, int *submitted,
>  				enum iostat_type io_type,
>  				int compr_blocks, bool allow_balance);
>  bool f2fs_ffs_test_blk_uptodate(const struct folio *folio, pgoff_t index);
> +struct f2fs_folio_state *f2fs_ffs_find_or_alloc(struct folio *folio);
> +void f2fs_ffs_mark_subrange_dirty(struct folio *folio, size_t offset, size_t len);
> +bool f2fs_ffs_clear_subrange_dirty_and_test(struct folio *folio, size_t offset,
> +					    size_t len);
>  void f2fs_write_failed(struct inode *inode, loff_t to);
>  void f2fs_invalidate_folio(struct folio *folio, size_t offset, size_t length);
>  bool f2fs_release_folio(struct folio *folio, gfp_t wait);
> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> index 9071bd23e57b..738a751c3903 100644
> --- a/fs/f2fs/file.c
> +++ b/fs/f2fs/file.c
> @@ -118,13 +118,47 @@ static vm_fault_t f2fs_filemap_fault(struct vm_fault *vmf)
>  	return ret;
>  }
>  
> +static int f2fs_get_block_mkwrite(struct inode *inode, struct folio *folio,
> +				  pgoff_t index, bool need_alloc)
> +{
> +	struct dnode_of_data dn;
> +	int err;
> +
> +	set_new_dnode(&dn, inode, NULL, NULL, 0);
> +	if (need_alloc) {
> +		err = f2fs_get_block_locked(&dn, index);
> +	} else {
> +		err = f2fs_get_dnode_of_data(&dn, index, LOOKUP_NODE);
> +		f2fs_put_dnode(&dn);
> +		if (f2fs_is_pinned_file(inode) &&
> +		    !__is_valid_data_blkaddr(dn.data_blkaddr))
> +			err = -EIO;
> +	}
> +
> +	if (err)
> +		return err;
> +
> +	f2fs_folio_wait_writeback(folio, DATA, false, true);
> +
> +	/* wait for GCed page writeback via META_MAPPING */
> +	f2fs_wait_on_block_writeback(inode, dn.data_blkaddr);
> +
> +	return 0;
> +}
> +
>  static vm_fault_t f2fs_vm_page_mkwrite(struct vm_fault *vmf)
>  {
>  	struct folio *folio = page_folio(vmf->page);
>  	struct inode *inode = file_inode(vmf->vma->vm_file);
>  	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
> -	struct dnode_of_data dn;
>  	bool need_alloc = !f2fs_is_pinned_file(inode);
> +	pgoff_t pidx = folio->index + folio_page_idx(folio, vmf->page);
> +	loff_t pos = (loff_t)pidx << PAGE_SHIFT;
> +	loff_t isize;
> +	loff_t folio_start;
> +	loff_t valid_end;
> +	size_t dirty_len;
> +	size_t subpage_off;

pgoff_t i, nr;

>  	int err = 0;
>  	vm_fault_t ret;
>  
> @@ -161,7 +195,7 @@ static vm_fault_t f2fs_vm_page_mkwrite(struct vm_fault *vmf)
>  
>  #ifdef CONFIG_F2FS_FS_COMPRESSION
>  	if (f2fs_compressed_file(inode)) {
> -		int ret = f2fs_is_compressed_cluster(inode, folio->index);
> +		int ret = f2fs_is_compressed_cluster(inode, pidx);
>  
>  		if (ret < 0) {
>  			err = ret;
> @@ -179,72 +213,63 @@ static vm_fault_t f2fs_vm_page_mkwrite(struct vm_fault *vmf)
>  
>  	f2fs_bug_on(sbi, f2fs_has_inline_data(inode));
>  
> -	err = f2fs_zero_post_eof_page(inode,
> -		(folio->index + 1) << PAGE_SHIFT, true, false);
> -	if (err)
> -		goto out_pagefault;
> -
>  	file_update_time(vmf->vma->vm_file);
>  	filemap_invalidate_lock_shared(inode->i_mapping);
>  
>  	folio_lock(folio);
> +	isize = i_size_read(inode);
> +	folio_start = folio_pos(folio);
> +	subpage_off = offset_in_folio(folio, pos);
> +	valid_end = min_t(loff_t, folio_start + folio_size(folio), isize);
> +	dirty_len = valid_end > folio_start ? valid_end - folio_start : 0;

valid_end <= folio_start, is this a possible case? if the folio is post EOF,
can it be dirtied via mmap?

> +
>  	if (unlikely(folio->mapping != inode->i_mapping ||
> -			folio_pos(folio) > i_size_read(inode) ||
> -			!folio_test_uptodate(folio))) {
> +			pos >= isize ||
> +			!f2fs_ffs_test_blk_uptodate(folio,
> +			folio->index + (subpage_off >> PAGE_SHIFT)))) {
>  		folio_unlock(folio);
>  		err = -EFAULT;
>  		goto out_sem;
>  	}
>  
> -	set_new_dnode(&dn, inode, NULL, NULL, 0);
> -	if (need_alloc) {
> -		/* block allocation */
> -		err = f2fs_get_block_locked(&dn, folio->index);
> -	} else {
> -		err = f2fs_get_dnode_of_data(&dn, folio->index, LOOKUP_NODE);
> -		f2fs_put_dnode(&dn);
> -		if (f2fs_is_pinned_file(inode) &&
> -		    !__is_valid_data_blkaddr(dn.data_blkaddr))
> -			err = -EIO;
> -	}
> +	pgoff_t i, nr = DIV_ROUND_UP(dirty_len, PAGE_SIZE);
>  
> -	if (err) {
> -		folio_unlock(folio);
> -		goto out_sem;
> +	for (i = 0; i < nr; i++) {
> +		err = f2fs_get_block_mkwrite(inode, folio, folio->index + i,
> +					     need_alloc);
> +		if (err) {
> +			folio_unlock(folio);
> +			goto out_sem;
> +		}
>  	}
>  
> -	f2fs_folio_wait_writeback(folio, DATA, false, true);
> -
> -	/* wait for GCed page writeback via META_MAPPING */
> -	f2fs_wait_on_block_writeback(inode, dn.data_blkaddr);
> -
> -	/*
> -	 * check to see if the page is mapped already (no holes)
> -	 */
> -	if (folio_test_mappedtodisk(folio))
> -		goto out_sem;

I think we'd better to drop this logic in a separated patch, it doesn't
belong to current patch?

Thanks,

> -
>  	/* page is wholly or partially inside EOF */
> -	if (((loff_t)(folio->index + 1) << PAGE_SHIFT) >
> -						i_size_read(inode)) {
> -		loff_t offset;
> +	if (folio_start + folio_size(folio) > isize) {
> +		size_t offset = offset_in_folio(folio, isize);
>  
> -		offset = i_size_read(inode) & ~PAGE_MASK;
>  		folio_zero_segment(folio, offset, folio_size(folio));
>  	}
> +
> +	if (folio_test_large(folio)) {
> +		if (!f2fs_ffs_find_or_alloc(folio)) {
> +			folio_unlock(folio);
> +			err = -ENOMEM;
> +			goto out_sem;
> +		}
> +		f2fs_ffs_mark_subrange_dirty(folio, 0, dirty_len);
> +	}
>  	folio_mark_dirty(folio);
>  
> -	f2fs_update_iostat(sbi, inode, APP_MAPPED_IO, F2FS_BLKSIZE(sbi));
> +	f2fs_update_iostat(sbi, inode, APP_MAPPED_IO, dirty_len);
>  	f2fs_update_time(sbi, REQ_TIME);
>  
>  out_sem:
>  	filemap_invalidate_unlock_shared(inode->i_mapping);
> -out_pagefault:
>  	sb_end_pagefault(inode->i_sb);
>  out:
>  	ret = vmf_fs_error(err);
>  
> -	trace_f2fs_vm_page_mkwrite(inode, folio->index, vmf->vma->vm_flags, ret);
> +	trace_f2fs_vm_page_mkwrite(inode, pidx, vmf->vma->vm_flags, ret);
>  	return ret;
>  }
>  



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
