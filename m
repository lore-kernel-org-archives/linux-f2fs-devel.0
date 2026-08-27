Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34105C61DC2
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 27 Aug 2026 12:36:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Sij/xMqC5Vp19MPuC8OL3R5M68hDcz4siAGLDJfaiK4=; b=WEQ7zKDwNxQDppzzzyMDC4/3ii
	OFCiB59xTai7nJaPqYCVY+5LiVQJbJzwLGpARaGT5fnn4kQDxkpH/aVj8j/XU88EQoX4GAzbWPmmj
	LZ/ZpKvoOeqWOhPmqWOTHeiriC/0fy2RZsAbhGxkDkrZ0tDrmfAGsCbTnTfDLmS472uU=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wzZL4-0002VA-NN;
	Thu, 27 Aug 2026 12:36:15 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1wzZL3-0002Ux-Aa
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 27 Aug 2026 12:36:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 References:Cc:To:Subject:From:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=hsQSocOw1V6LIZ0bZ5/AEmq7U0N0qqOB9IfyW0+PBaA=; b=Bv4nTXMLpD4Qe+Pt1saSF6gPEc
 eWvo0s+FnQfLfTQjCAl43HssVK4RIASwOnRQXYtog6GUTatzP76LzQMhu1g4mzrYOkKNjPhyUM46j
 TJpf5BP/0jNeLeIWoFvF+S+48i1Ebljt+UK6HEEaUL5kQC+Y3P7IOAqTGb4HY18rN1QQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Cc:To:
 Subject:From:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=hsQSocOw1V6LIZ0bZ5/AEmq7U0N0qqOB9IfyW0+PBaA=; b=NYWdsBbAx60TOeHSw+iD/njJx4
 QJ7OWYyk+CNxsiZt0iOWA3GH1oDCzvRidhcEYwOI5wJBGm1XEf0/iuNPCLs7IOHbkxnyQ+m11Rto5
 QklmvGPPfnig81U+RrOBP1aQDfRPvzLILnYSVQwWyoX3d6h6rXwe8RalKxeUy6OOiQMo=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wzZL2-0007oG-Im for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 27 Aug 2026 12:36:14 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id EB5FB600D9;
 Thu, 27 Aug 2026 12:36:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 514B81F000E9;
 Thu, 27 Aug 2026 12:36:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787834166;
 bh=hsQSocOw1V6LIZ0bZ5/AEmq7U0N0qqOB9IfyW0+PBaA=;
 h=Date:From:Subject:To:Cc:References:In-Reply-To;
 b=Xw7NucEit5a9fn57CYlVKcqnM+3mVOvXgfMkpu/1ykyrdNsYj4rYOPpgAL4JnrStE
 5mVOcsSidSYGLA/SqrgMgAbYCwBJnIBi+Rehx9BKb4yorKpcUa5oSkDh/Fj3hUwHJ+
 ZywCIF38WZLrJCx/slrWCp7DFKi0xYAcrHRIX5V2VdOwx+cituNiqQ67jraw8iJUfI
 1zdH4gs4MImN2W5nUk2kpRqJ5GuP0fKwja9Xw6LdaMIjX7RxROfSwdTMqLER8nEX1T
 SspgrmU2IkN8iDm1nwfGUjXMSD99mU72pT/beoQqIRc4Qki+n46JDJpTlgFqfFXmlW
 fgXyj13Tegt9w==
Message-ID: <eecd3a49-d252-4d36-9e5a-44ac3eb02108@kernel.org>
Date: Thu, 27 Aug 2026 20:36:02 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Nanzhe Zhao <zhaonanzhe@xiaomi.com>, Barry Song <baohua@kernel.org>
References: <20260826082641.2007658-1-zhaonanzhe@xiaomi.com>
 <20260826082641.2007658-7-zhaonanzhe@xiaomi.com>
Content-Language: en-US
In-Reply-To: <20260826082641.2007658-7-zhaonanzhe@xiaomi.com>
X-Headers-End: 1wzZL2-0007oG-Im
Subject: Re: [f2fs-dev] [PATCH 06/14] f2fs: prepare mmap write faults for
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
Cc: linux-f2fs-devel@lists.sourceforge.net, Juan Yescas <jyescas@google.com>,
 Dev Jain <Dev.Jain@arm.com>, linux-kernel@vger.kernel.org,
 David Hildenbrand <David.Hildenbrand@arm.com>, Bo Zhang <zhangbo56@xiaomi.com>,
 Kalesh Singh <kaleshsingh@google.com>, Nanzhe Zhao <nzzhao@126.com>,
 Jaegeuk Kim <jaegeuk@kernel.org>, Pengfei Li <lipengfei28@xiaomi.com>,
 Ryan Roberts <Ryan.Roberts@arm.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 8/26/26 16:26, Nanzhe Zhao wrote:
> Now write protect `mmap` also need to support large folio,
> Change `f2fs_vm_page_mkwrite` to acheive that.
> 
> Note it currently marks the whole large folio dirty
> to avoid data loss which causes write amplification.
> Further optimization is welcome.
> 
> PG_mappedtodisk is useless in f2fs, so drop the
> folio_test_mappedtodisk() check and its goto out_sem

Can you send a separated patch to clean up logic on mappedtodisk flag?

> shortcut in f2fs_vm_page_mkwrite().  We extend the
> folio_zero_segment() in mkwrite to zero the post-EOF part
> of the faulted folio for both order-0 and large folios, so
> the f2fs_zero_post_eof_page() call added to cover that
> shortcut is no longer needed.
> > Signed-off-by: Nanzhe Zhao <zhaonanzhe@xiaomi.com>
> ---
>  fs/f2fs/f2fs.h |  5 +++++
>  fs/f2fs/file.c | 59 +++++++++++++++++++++++++++++++-------------------
>  2 files changed, 42 insertions(+), 22 deletions(-)
> 
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index ae6031693700..71e6d7e34c7b 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -4343,6 +4343,11 @@ int f2fs_write_single_data_page(struct folio *folio, int *submitted,
>  				enum iostat_type io_type,
>  				int compr_blocks, bool allow_balance);
>  bool f2fs_ffs_test_blk_uptodate(const struct folio *folio, pgoff_t index);
> +struct f2fs_folio_state *f2fs_ffs_find_or_alloc(struct folio *folio);
> +void f2fs_ffs_mark_subrange_dirty(struct folio *folio, size_t offset, size_t len);
> +bool f2fs_ffs_clear_subrange_dirty_and_test(struct folio *folio, size_t offset,
> +					size_t len);
> +void f2fs_ffs_clear_subrange_dirty(struct folio *folio, size_t offset, size_t len);
>  void f2fs_write_failed(struct inode *inode, loff_t to);
>  void f2fs_invalidate_folio(struct folio *folio, size_t offset, size_t length);
>  bool f2fs_release_folio(struct folio *folio, gfp_t wait);
> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> index e40285d4f9c2..02d687527241 100644
> --- a/fs/f2fs/file.c
> +++ b/fs/f2fs/file.c
> @@ -124,6 +124,13 @@ static vm_fault_t f2fs_vm_page_mkwrite(struct vm_fault *vmf)
>  	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
>  	struct dnode_of_data dn;
>  	bool need_alloc = !f2fs_is_pinned_file(inode);
> +	pgoff_t pidx = folio->index + folio_page_idx(folio, vmf->page);
> +	loff_t pos = (loff_t)pidx << PAGE_SHIFT;
> +	loff_t isize;
> +	loff_t folio_start;
> +	loff_t valid_end;
> +	size_t dirty_len;
> +	size_t subpage_off;
>  	int err = 0;
>  	vm_fault_t ret;
>  
> @@ -160,7 +167,7 @@ static vm_fault_t f2fs_vm_page_mkwrite(struct vm_fault *vmf)
>  
>  #ifdef CONFIG_F2FS_FS_COMPRESSION
>  	if (f2fs_compressed_file(inode)) {
> -		int ret = f2fs_is_compressed_cluster(inode, folio->index);
> +		int ret = f2fs_is_compressed_cluster(inode, pidx);
>  
>  		if (ret < 0) {
>  			err = ret;
> @@ -178,18 +185,20 @@ static vm_fault_t f2fs_vm_page_mkwrite(struct vm_fault *vmf)
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
> @@ -198,9 +207,19 @@ static vm_fault_t f2fs_vm_page_mkwrite(struct vm_fault *vmf)
>  	set_new_dnode(&dn, inode, NULL, NULL, 0);
>  	if (need_alloc) {
>  		/* block allocation */
> -		err = f2fs_get_block_locked(&dn, folio->index);
> +		if (folio_test_large(folio)) {
> +			pgoff_t i, nr = DIV_ROUND_UP(dirty_len, PAGE_SIZE);
> +
> +			for (i = 0; i < nr; i++) {
> +				err = f2fs_get_block_locked(&dn, folio->index + i);
> +				if (err)
> +					break;

We only need to call f2fs_get_block_locked() for vmf->page?

Hi Barry, could you please help to confirm this? Only vmf->page contain dirty
data, rather than whole large folio contain dirty data?

Thanks,

> +			}
> +		} else {
> +			err = f2fs_get_block_locked(&dn, pidx);
> +		}
>  	} else {
> -		err = f2fs_get_dnode_of_data(&dn, folio->index, LOOKUP_NODE);
> +		err = f2fs_get_dnode_of_data(&dn, pidx, LOOKUP_NODE);
>  		f2fs_put_dnode(&dn);
>  		if (f2fs_is_pinned_file(inode) &&
>  		    !__is_valid_data_blkaddr(dn.data_blkaddr))
> @@ -217,20 +236,17 @@ static vm_fault_t f2fs_vm_page_mkwrite(struct vm_fault *vmf)
>  	/* wait for GCed page writeback via META_MAPPING */
>  	f2fs_wait_on_block_writeback(inode, dn.data_blkaddr);
>  
> -	/*
> -	 * check to see if the page is mapped already (no holes)
> -	 */
> -	if (folio_test_mappedtodisk(folio))
> -		goto out_sem;
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
> +		f2fs_ffs_find_or_alloc(folio);
> +		f2fs_ffs_mark_subrange_dirty(folio, 0, dirty_len);
> +	}
>  	folio_mark_dirty(folio);
>  
>  	f2fs_update_iostat(sbi, inode, APP_MAPPED_IO, F2FS_BLKSIZE);
> @@ -238,12 +254,11 @@ static vm_fault_t f2fs_vm_page_mkwrite(struct vm_fault *vmf)
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
