Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0DC5606A323
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 27 Oct 2026 09:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=iDoTTsRO;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=VO+HHqeN;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=YtZXT8k7;
	dkim=neutral header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oLSdHlm4
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=vJCcjSIJA7HF8gzFnzuhoe7gGiXSTYc8/sSXOMeAB3E=; b=iDoTTsROULqMo2
	BH22ZDT+imoUiMNGBPa77CYPXymqvhp0nJznbGsDl8Eber0sYgETShE51MgI1RyA6goAraKNHyjwD
	L1QCIEXQ9KuN3lWRu39op3xL74RZelwPugng+y5ivEhDR264kEwHy+9EfXxlpQae9XPeCOlO53ojV
	3iI=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xLdaZ-000000006Nf-2Swq;
	Tue, 27 Oct 2026 09:35:27 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <chao@kernel.org>) id 1xLdaY-000000006NU-3LmZ
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 27 Oct 2026 09:35:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=8cClHpn4QcRtRIEg08pjD1RQp0MconW84frXjCAs5kI=; b=VO+HHqeN0Dc740hZpDSy5dneza
 Er5dzESBhX0YfnzwNH7oLGmKkyTech7OhT0a8JcEV1OUc1mFXFldgjkrz9uZ1Ue7WpYR6yf6dOUkA
 aA7IQeSiGWkM4rGfOxNsUhx/J2J1Id7XGzHecld/i1FSPljCXhJTwBBs9X7VR4Ow0SSU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=8cClHpn4QcRtRIEg08pjD1RQp0MconW84frXjCAs5kI=; b=YtZXT8k7PVc0jGZOpHM/DzUIcs
 g0aDowEm7lc1kGFHuZJVUfVxl5avmF4M30CjdYP/uNkdzC2K8BIzwy4swAGwh9bmNxbEChDqWNMZG
 Du+UupP+vwb85szACnbQ5fmRmS+/SWxfZfF2ebH0cAqfo89v4itSbX1XQ9vjXnC/t9Qo=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xLdaX-000000000nt-3QnK
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 27 Oct 2026 09:35:26 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 6EFF3435D7;
 Tue, 27 Oct 2026 09:35:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D47A1F031E0;
 Tue, 27 Oct 2026 09:35:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793093720;
 bh=8cClHpn4QcRtRIEg08pjD1RQp0MconW84frXjCAs5kI=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To;
 b=oLSdHlm41Z7IPbn9DzDXOCfqPTOuEQJRBonriYWllIN4wDWohCFP42PQLIVnoAYgf
 rWSXzkGeevOfBL9Ko8Rjf3ex7iVnag8HpStv0ojTWa2Y/E5nh62ZzAwEAxRcaBRXTZ
 zJUmrokbHVqAspfpWbyLcHQDjocmmxOJfvX83K5UAn7QK+6CSEY+mIspwt9K0Q6l/O
 KkjUSfd7ypTJvxgjONrpoi9eJ++pjuzW9frq2xV9Yw5LU3urF/I/6Y8JWZgIKa7DrH
 Lr2UcX3UkQDfoclU58dDwWFLuew9grdZTWdrIW9mgKk2BNgQ+ZQIeFbnOzdGt1v5cj
 AKpGM8Bm+DY3g==
Message-ID: <8c731d5a-d000-4faf-a5d2-76f7c17d82ec@kernel.org>
Date: Tue, 27 Oct 2026 17:35:15 +0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Nanzhe Zhao <nzzhao.sigma@gmail.com>,
 linux-f2fs-devel@lists.sourceforge.net, Jaegeuk Kim <jaegeuk@kernel.org>
References: <20261026033745.784107-1-nzzhao.sigma@gmail.com>
 <20261026033745.784107-8-nzzhao.sigma@gmail.com>
Content-Language: en-US
In-Reply-To: <20261026033745.784107-8-nzzhao.sigma@gmail.com>
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xLdaX-000000000nt-3QnK
Subject: Re: [f2fs-dev] [PATCH v7 07/15] f2fs: prepare mmap write faults for
 large folios
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
> Now write protect `mmap` also need to support large folio,
> Change `f2fs_vm_page_mkwrite` to achieve that.
> 
> Note it currently marks the whole large folio dirty
> to avoid data loss which causes write amplification.
> Further optimization is welcome.
> 
> The folio_zero_segment() in mkwrite is extended to zero the
> post-EOF part of the faulted folio for both order-0 and large
> folios, so the f2fs_zero_post_eof_page() call that was added
> to cover the removed shortcut is no longer needed.
> 
> Signed-off-by: Nanzhe Zhao <zhaonanzhe@xiaomi.com>
> ---
>  fs/f2fs/f2fs.h |  4 +++
>  fs/f2fs/file.c | 96 ++++++++++++++++++++++++++++++++------------------
>  2 files changed, 65 insertions(+), 35 deletions(-)
> 
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index b89664e28a92..915ca72cf276 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -4492,6 +4492,10 @@ int f2fs_write_single_data_page(struct folio *folio, int *submitted,
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
> index 85b4f1a2ff0d..808b72d3d78a 100644
> --- a/fs/f2fs/file.c
> +++ b/fs/f2fs/file.c
> @@ -118,14 +118,48 @@ static vm_fault_t f2fs_filemap_fault(struct vm_fault *vmf)
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
> +	f2fs_folio_wait_writeback(folio, false, true);
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
>  	loff_t isize;
> +	loff_t folio_start;
> +	loff_t valid_end;
> +	size_t dirty_len;
> +	size_t subpage_off;
> +	pgoff_t i, nr;
>  	int err = 0;
>  	vm_fault_t ret;
>  
> @@ -162,7 +196,7 @@ static vm_fault_t f2fs_vm_page_mkwrite(struct vm_fault *vmf)
>  
>  #ifdef CONFIG_F2FS_FS_COMPRESSION
>  	if (f2fs_compressed_file(inode)) {
> -		int ret = f2fs_is_compressed_cluster(inode, folio->index);
> +		int ret = f2fs_is_compressed_cluster(inode, pidx);
>  
>  		if (ret < 0) {
>  			err = ret;
> @@ -180,11 +214,6 @@ static vm_fault_t f2fs_vm_page_mkwrite(struct vm_fault *vmf)
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
> @@ -200,62 +229,59 @@ static vm_fault_t f2fs_vm_page_mkwrite(struct vm_fault *vmf)
>  	}
>  
>  	folio_lock(folio);

It needs to add below check to avoid racing w/ COLLAPSE_RANGE or INSERT_RANGE ->
f2fs_invalidate_folio()? there is no ffs in large folio after folio_lock().

    if (folio_test_large(folio) && !folio_test_uptodate(folio)) {
        folio_unlock(folio);
        err = -EFAULT;          /* VM_FAULT_NOPAGE, refault */
        goto out_sem;
    }

Thanks,

> -	/*
> -	 * A concurrent buffered write can extend isize, so we store isize in a
> -	 * local variable to let the zeroing offset match the EOF check below.
> -	 */
>  	isize = i_size_read(inode);
> +	folio_start = folio_pos(folio);
> +	subpage_off = offset_in_folio(folio, pos);
> +	valid_end = min_t(loff_t, folio_start + folio_size(folio), isize);
> +	dirty_len = valid_end - folio_start;
>  
>  	if (unlikely(folio->mapping != inode->i_mapping ||
> -			folio_pos(folio) > isize ||
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
> -
> -	if (err) {
> +	if (folio_test_large(folio) && !f2fs_ffs_find_or_alloc(folio)) {
>  		folio_unlock(folio);
> +		err = -ENOMEM;
>  		goto out_sem;
>  	}
>  
> -	f2fs_folio_wait_writeback(folio, false, true);
> +	nr = DIV_ROUND_UP(dirty_len, PAGE_SIZE);
>  
> -	/* wait for GCed page writeback via generic cache */
> -	f2fs_wait_on_block_writeback(inode, dn.data_blkaddr);
> +	for (i = 0; i < nr; i++) {
> +		err = f2fs_get_block_mkwrite(inode, folio, folio->index + i,
> +					     need_alloc);
> +		if (err) {
> +			folio_unlock(folio);
> +			goto out_sem;
> +		}
> +	}
>  
>  	/* page is wholly or partially inside EOF */
> -	if (((loff_t)(folio->index + 1) << PAGE_SHIFT) > isize) {
> -		loff_t offset;
> +	if (folio_start + folio_size(folio) > isize) {
> +		size_t offset = offset_in_folio(folio, isize);
>  
> -		offset = isize & ~PAGE_MASK;
>  		folio_zero_segment(folio, offset, folio_size(folio));
>  	}
> +
> +	if (folio_test_large(folio))
> +		f2fs_ffs_mark_subrange_dirty(folio, 0, dirty_len);
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
