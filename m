Return-Path: <SRS0=/9Ak=GR=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BCD1C433E0
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 14 Jan 2021 21:54:04 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B15BB23A9D
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 14 Jan 2021 21:54:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B15BB23A9D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1l0AZ8-0005ez-8j; Thu, 14 Jan 2021 21:54:02 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <jaegeuk@kernel.org>) id 1l0AZ7-0005ef-JO
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 14 Jan 2021 21:54:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=dxNsTIdOD68R0r+jp4WzeuSiR3HcQeo1DtAJp4e08U4=; b=HnVe5RF1hrhuhQmT9iSIJ3WEti
 7l3cuM3Zr3jMiBYNYvn5T8unaylTEEklK4qBQXn2Mk5cyKunoPWlQI7nOkBua0TL1U5Zo52WMsTCd
 lFHq0TuVcpY5VBKpH+FMKqD/uBk/KjgO+JAFsqVucO+XYn3nxsKCBRllZQDUs3lDu0hE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=dxNsTIdOD68R0r+jp4WzeuSiR3HcQeo1DtAJp4e08U4=; b=hwXDMT04PLlHEJvvtOAnVkiMly
 i4VEiZJZqPX/mw+wR8mZJ54OygWDV+pdo8lNddE2Tu60A9rEp7Ka4hMLl+HnENfgPnhqu3gLeq/eg
 TfUExTFhBUUEgrYAyba9xF4BTxLDiiuVe2FXDv7XMFq1JoOVQOnryl8jbEPd1kvAb04I=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1l0AZ0-00BqRb-8g
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 14 Jan 2021 21:54:01 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id AAC7523A5E;
 Thu, 14 Jan 2021 21:53:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1610661228;
 bh=LZDXMs+IwNxt9SSavL2uZ4wrZhW2+BbtcWkyjK6KhwI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=GYzayenKVF9dkvKT2ZIbtQ5/nrGyUCSmlvrrbwMeHsgvnxePgZGbLCm3dq2WE6ngM
 G5A2HT08K4bNn1YkwYb0HJdt7DQvWrrwoAttVv/f6LgLGSApjt7+w0CqVak0bGyb5m
 K76Gp9Q86tOUJPi3TAV+HddUX/zbyFxZ0TATcbZTa/uM4QUpVb5zUp9Y8iQ6MMVjZH
 ZSIUcgDFJ9UYmpzrHstyUoSJWkT4CnDIFxYTOvHIUYHuNsSv7wR+LZiYRDwKnioZLX
 DnrMC9GKADZc1tYwZqNNBaQf1ceK2EkfPyZknebXxZxaRs6FogeEN+fXIwR0v0vRZl
 eAMsdqV9SCwUg==
Date: Thu, 14 Jan 2021 13:53:47 -0800
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Chao Yu <yuchao0@huawei.com>
Message-ID: <YAC9a6quO2VOirLi@google.com>
References: <20201230075557.108818-1-yuchao0@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201230075557.108818-1-yuchao0@huawei.com>
X-Headers-End: 1l0AZ0-00BqRb-8g
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: fix to keep isolation of atomic
 write
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
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 12/30, Chao Yu wrote:
> ThreadA					ThreadB
> - f2fs_ioc_start_atomic_write
> - write
> - f2fs_ioc_commit_atomic_write
>  - f2fs_commit_inmem_pages
>  - f2fs_drop_inmem_pages
>  - f2fs_drop_inmem_pages
>   - __revoke_inmem_pages
> 					- f2fs_vm_page_mkwrite
> 					 - set_page_dirty
> 					  - tag ATOMIC_WRITTEN_PAGE and add page
> 					    to inmem_pages list
>   - clear_inode_flag(FI_ATOMIC_FILE)
> 					- f2fs_vm_page_mkwrite
> 					  - set_page_dirty
> 					   - f2fs_update_dirty_page
> 					    - f2fs_trace_pid
> 					     - tag inmem page private to pid

Hmm, how about removing fs/f2fs/trace.c to make private more complicated
like this? I think we can get IO traces from tracepoints.

> 					- truncate
> 					 - f2fs_invalidate_page
> 					 - set page->mapping to NULL
> 					  then it will cause panic once we
> 					  access page->mapping
> 
> The root cause is we missed to keep isolation of atomic write in the case
> of commit_atomic_write vs mkwrite, let commit_atomic_write helds i_mmap_sem
> lock to avoid this issue.
> 
> Signed-off-by: Chao Yu <yuchao0@huawei.com>
> ---
> v2:
> - use i_mmap_sem to avoid mkwrite racing with below flows:
>  * f2fs_ioc_start_atomic_write
>  * f2fs_drop_inmem_pages
>  * f2fs_commit_inmem_pages
> 
>  fs/f2fs/file.c    | 3 +++
>  fs/f2fs/segment.c | 7 +++++++
>  2 files changed, 10 insertions(+)
> 
> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> index 4e6d4b9120a8..a48ec650d691 100644
> --- a/fs/f2fs/file.c
> +++ b/fs/f2fs/file.c
> @@ -2050,6 +2050,7 @@ static int f2fs_ioc_start_atomic_write(struct file *filp)
>  		goto out;
>  
>  	down_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
> +	down_write(&F2FS_I(inode)->i_mmap_sem);
>  
>  	/*
>  	 * Should wait end_io to count F2FS_WB_CP_DATA correctly by
> @@ -2060,6 +2061,7 @@ static int f2fs_ioc_start_atomic_write(struct file *filp)
>  			  inode->i_ino, get_dirty_pages(inode));
>  	ret = filemap_write_and_wait_range(inode->i_mapping, 0, LLONG_MAX);
>  	if (ret) {
> +		up_write(&F2FS_I(inode)->i_mmap_sem);
>  		up_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
>  		goto out;
>  	}
> @@ -2073,6 +2075,7 @@ static int f2fs_ioc_start_atomic_write(struct file *filp)
>  	/* add inode in inmem_list first and set atomic_file */
>  	set_inode_flag(inode, FI_ATOMIC_FILE);
>  	clear_inode_flag(inode, FI_ATOMIC_REVOKE_REQUEST);
> +	up_write(&F2FS_I(inode)->i_mmap_sem);
>  	up_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
>  
>  	f2fs_update_time(F2FS_I_SB(inode), REQ_TIME);
> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> index d8570b0359f5..dab870d9faf6 100644
> --- a/fs/f2fs/segment.c
> +++ b/fs/f2fs/segment.c
> @@ -327,6 +327,8 @@ void f2fs_drop_inmem_pages(struct inode *inode)
>  	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
>  	struct f2fs_inode_info *fi = F2FS_I(inode);
>  
> +	down_write(&F2FS_I(inode)->i_mmap_sem);
> +
>  	while (!list_empty(&fi->inmem_pages)) {
>  		mutex_lock(&fi->inmem_lock);
>  		__revoke_inmem_pages(inode, &fi->inmem_pages,
> @@ -344,6 +346,8 @@ void f2fs_drop_inmem_pages(struct inode *inode)
>  		sbi->atomic_files--;
>  	}
>  	spin_unlock(&sbi->inode_lock[ATOMIC_FILE]);
> +
> +	up_write(&F2FS_I(inode)->i_mmap_sem);
>  }
>  
>  void f2fs_drop_inmem_page(struct inode *inode, struct page *page)
> @@ -467,6 +471,7 @@ int f2fs_commit_inmem_pages(struct inode *inode)
>  	f2fs_balance_fs(sbi, true);
>  
>  	down_write(&fi->i_gc_rwsem[WRITE]);
> +	down_write(&F2FS_I(inode)->i_mmap_sem);
>  
>  	f2fs_lock_op(sbi);
>  	set_inode_flag(inode, FI_ATOMIC_COMMIT);
> @@ -478,6 +483,8 @@ int f2fs_commit_inmem_pages(struct inode *inode)
>  	clear_inode_flag(inode, FI_ATOMIC_COMMIT);
>  
>  	f2fs_unlock_op(sbi);
> +
> +	up_write(&F2FS_I(inode)->i_mmap_sem);
>  	up_write(&fi->i_gc_rwsem[WRITE]);
>  
>  	return err;
> -- 
> 2.29.2


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
