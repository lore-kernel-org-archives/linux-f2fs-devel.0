Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E540FCA9EC5
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 12 Oct 2026 07:04:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Content-Transfer-Encoding:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=NDGEMstFvIaVOqUhgbbgOonE6bw1NEr5lzz+EWSMMGg=; b=ikRFNVPdpffa+bHS4x6U6dByej
	Iuhu6okRqOnIJjUf6KgImZh1XKfc9ObZfc+wjZgaz7aLhTQ2pCMbopchbCBVQdEMGtzP9SHTs9eno
	3uNcph2eS2RSyXUrqu8WgNZsmUVwaRx6xaZQOmcOHmpKOQsvyMb3yoa+t6GRU6rsDsxs=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xGA5L-0001mK-2E;
	Mon, 12 Oct 2026 07:04:35 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1xGA53-0001m2-Uw
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 12 Oct 2026 07:04:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=iHPc9noxhd63rd41CVHU5eVdztT5EDmfh56KyaO4ybA=; b=iMsEHNcugT+r6PqcXssF+i8O+d
 8uY9It4JUBjZhNaKeN1p2etZoQMN0BVXTcmxd7oycBLw9a8PRgKhak2H6Z3rScVbm+V4EhHLcz2X5
 ty1Xtzg+Ckt9iAyZyh6blHFxeZISk35CotOKCPSjzrvsb5SademGuFlyxeURnAIkPPwc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=iHPc9noxhd63rd41CVHU5eVdztT5EDmfh56KyaO4ybA=; b=Kdl/gF9fU2mLME9t2o8Ew55im0
 889QIueeC1fblufng/2GcbKKaPGDuqbnltRhXQ+RDLmHkV/y5Fe13iVx8eWQs+/iiNoZSx5Ar3BCw
 /BhzZRbwCF1Jneed1IFMwzANkdasomEE2GpVkExN/4rE1eA8vbv+6p0sO0kQZcOlfqLo=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1xGA52-0008Vo-Qo for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 12 Oct 2026 07:04:18 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 589FC415D7;
 Mon, 12 Oct 2026 07:04:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD8691F0089B;
 Mon, 12 Oct 2026 07:04:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791788651;
 bh=iHPc9noxhd63rd41CVHU5eVdztT5EDmfh56KyaO4ybA=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To;
 b=C0ID0Pp6/BEYUKz/LDKKQ516W8hD0MvkSmzjb4Jq93PRM7QkBPUWaMpNLu/aBKYCS
 sFulN1eLptiyFAVAfE7faNQgrR2PNh5JdzWEeVM55B7bCJEVIQiJOWtLcF0Kvup1EO
 cvBaQNX0VAt2z+YF8OdkTOQV/EKYHXaTENzDlKDwb2BY+h+6Ejp1KpRAX7VQvrrU8D
 NWrdYZDz8TMO8E4yQvr84RTtuV9Znj0niAt4wDRBfj0ZhBWJGNropWc01I0tUU3VNb
 se4oMLGEnOW7mV4C0tfckBUS1CiqS860VczTlRzhxsq/DO1AuriB7iRI65M+twUS8k
 eH7p6NUmw+hDA==
Message-ID: <c08a6a2c-123f-4bbe-81c2-f294d8bb6214@kernel.org>
Date: Mon, 12 Oct 2026 15:04:05 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Nanzhe Zhao <zhaonanzhe@xiaomi.com>,
 linux-f2fs-devel@lists.sourceforge.net, Jaegeuk Kim <jaegeuk@kernel.org>
References: <20261009161224.4163796-1-zhaonanzhe@xiaomi.com>
 <20261009161224.4163796-9-zhaonanzhe@xiaomi.com>
Content-Language: en-US
In-Reply-To: <20261009161224.4163796-9-zhaonanzhe@xiaomi.com>
X-Headers-End: 1xGA52-0008Vo-Qo
Subject: Re: [f2fs-dev] [PATCH v3 08/17] f2fs: prepare mmap write faults for
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
 Daeho Jeong <daehojeong@google.com>, Dev Jain <Dev.Jain@arm.com>,
 linux-kernel@vger.kernel.org, David Hildenbrand <David.Hildenbrand@arm.com>,
 Bo Zhang <zhangbo56@xiaomi.com>, Kalesh Singh <kaleshsingh@google.com>,
 Nanzhe Zhao <nzzhao@126.com>, Pengfei Li <lipengfei28@xiaomi.com>,
 Ryan Roberts <Ryan.Roberts@arm.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 10/10/26 00:12, Nanzhe Zhao wrote:
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
>   fs/f2fs/f2fs.h |   4 ++
>   fs/f2fs/file.c | 102 ++++++++++++++++++++++++++++++++-----------------
>   2 files changed, 71 insertions(+), 35 deletions(-)
> 
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index 2cf98f49c876..a78c69b6abb0 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -4488,6 +4488,10 @@ int f2fs_write_single_data_page(struct folio *folio, int *submitted,
>   				enum iostat_type io_type,
>   				int compr_blocks, bool allow_balance);
>   bool f2fs_ffs_test_blk_uptodate(const struct folio *folio, pgoff_t index);
> +struct f2fs_folio_state *f2fs_ffs_find_or_alloc(struct folio *folio);
> +void f2fs_ffs_mark_subrange_dirty(struct folio *folio, size_t offset, size_t len);
> +bool f2fs_ffs_clear_subrange_dirty_and_test(struct folio *folio, size_t offset,
> +					    size_t len);
>   void f2fs_write_failed(struct inode *inode, loff_t to);
>   void f2fs_invalidate_folio(struct folio *folio, size_t offset, size_t length);
>   bool f2fs_release_folio(struct folio *folio, gfp_t wait);
> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> index e7471949faf2..6eb0c8e05b66 100644
> --- a/fs/f2fs/file.c
> +++ b/fs/f2fs/file.c
> @@ -118,13 +118,48 @@ static vm_fault_t f2fs_filemap_fault(struct vm_fault *vmf)
>   	return ret;
>   }
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
>   static vm_fault_t f2fs_vm_page_mkwrite(struct vm_fault *vmf)
>   {
>   	struct folio *folio = page_folio(vmf->page);
>   	struct inode *inode = file_inode(vmf->vma->vm_file);
>   	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
> -	struct dnode_of_data dn;
>   	bool need_alloc = !f2fs_is_pinned_file(inode);
> +	pgoff_t pidx = folio->index + folio_page_idx(folio, vmf->page);
> +	loff_t pos = (loff_t)pidx << PAGE_SHIFT;
> +	loff_t isize;
> +	loff_t folio_start;
> +	loff_t valid_end;
> +	size_t dirty_len;
> +	size_t subpage_off;
> +	pgoff_t i, nr;
>   	int err = 0;
>   	vm_fault_t ret;
>   
> @@ -161,7 +196,7 @@ static vm_fault_t f2fs_vm_page_mkwrite(struct vm_fault *vmf)
>   
>   #ifdef CONFIG_F2FS_FS_COMPRESSION
>   	if (f2fs_compressed_file(inode)) {
> -		int ret = f2fs_is_compressed_cluster(inode, folio->index);
> +		int ret = f2fs_is_compressed_cluster(inode, pidx);
>   
>   		if (ret < 0) {
>   			err = ret;
> @@ -179,66 +214,63 @@ static vm_fault_t f2fs_vm_page_mkwrite(struct vm_fault *vmf)
>   
>   	f2fs_bug_on(sbi, f2fs_has_inline_data(inode));
>   
> -	err = f2fs_zero_post_eof_page(inode,
> -		(folio->index + 1) << PAGE_SHIFT, true, false);
> -	if (err)
> -		goto out_pagefault;
> -
>   	file_update_time(vmf->vma->vm_file);
>   	filemap_invalidate_lock_shared(inode->i_mapping);
>   
>   	folio_lock(folio);
> +	isize = i_size_read(inode);
> +	folio_start = folio_pos(folio);
> +	subpage_off = offset_in_folio(folio, pos);
> +	valid_end = min_t(loff_t, folio_start + folio_size(folio), isize);
> +	dirty_len = valid_end - folio_start;
> +
>   	if (unlikely(folio->mapping != inode->i_mapping ||
> -			folio_pos(folio) > i_size_read(inode) ||
> -			!folio_test_uptodate(folio))) {
> +			pos >= isize ||
> +			!f2fs_ffs_test_blk_uptodate(folio,
> +			folio->index + (subpage_off >> PAGE_SHIFT)))) {
>   		folio_unlock(folio);
>   		err = -EFAULT;
>   		goto out_sem;
>   	}
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
> +	nr = DIV_ROUND_UP(dirty_len, PAGE_SIZE);
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
>   	}
>   
> -	f2fs_folio_wait_writeback(folio, false, true);
> -
> -	/* wait for GCed page writeback via generic cache */
> -	f2fs_wait_on_block_writeback(inode, dn.data_blkaddr);
> -
>   	/* page is wholly or partially inside EOF */
> -	if (((loff_t)(folio->index + 1) << PAGE_SHIFT) >
> -						i_size_read(inode)) {
> -		loff_t offset;
> +	if (folio_start + folio_size(folio) > isize) {
> +		size_t offset = offset_in_folio(folio, isize);
>   
> -		offset = i_size_read(inode) & ~PAGE_MASK;
>   		folio_zero_segment(folio, offset, folio_size(folio));
>   	}
> +
> +	if (folio_test_large(folio)) {
> +		if (!f2fs_ffs_find_or_alloc(folio)) {

Can we call f2fs_ffs_find_or_alloc() after f2fs_convert_inline_inode()? I feel
it's so later to fail due to -ENOMEM.

Thanks,

> +			folio_unlock(folio);
> +			err = -ENOMEM;
> +			goto out_sem;
> +		}
> +		f2fs_ffs_mark_subrange_dirty(folio, 0, dirty_len);
> +	}
>   	folio_mark_dirty(folio);
>   
> -	f2fs_update_iostat(sbi, inode, APP_MAPPED_IO, F2FS_BLKSIZE(sbi));
> +	f2fs_update_iostat(sbi, inode, APP_MAPPED_IO, dirty_len);
>   	f2fs_update_time(sbi, REQ_TIME);
>   
>   out_sem:
>   	filemap_invalidate_unlock_shared(inode->i_mapping);
> -out_pagefault:
>   	sb_end_pagefault(inode->i_sb);
>   out:
>   	ret = vmf_fs_error(err);
>   
> -	trace_f2fs_vm_page_mkwrite(inode, folio->index, vmf->vma->vm_flags, ret);
> +	trace_f2fs_vm_page_mkwrite(inode, pidx, vmf->vma->vm_flags, ret);
>   	return ret;
>   }
>   



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
