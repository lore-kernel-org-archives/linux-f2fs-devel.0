Return-Path: <SRS0=lGl7=JK=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8494C433ED
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 13 Apr 2021 03:27:28 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C49D611CC
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 13 Apr 2021 03:27:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C49D611CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1lW9i3-0004Ql-Hm; Tue, 13 Apr 2021 03:27:27 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <jaegeuk@kernel.org>) id 1lW9i2-0004Qe-4j
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 13 Apr 2021 03:27:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=nS+Ar9xdru9FdZDCyFNjVyqFiRya/QErtICoqFHZEO0=; b=cJBghDakOGsQXl11ezdL9ZjjLy
 TbUB91lijd6Y3D8E9VnmHdHzDK+oJIYYncEspcCuPAVeW4Q2msGiCXV5y0vFfC1Zq69D+PzlbZxox
 oNz3dfIcS3FJc69zgJm6IzltcBMZzqh67IC7Xbnwcen3YN5fmjEw2Hg1+kDgAJXN6xS4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=nS+Ar9xdru9FdZDCyFNjVyqFiRya/QErtICoqFHZEO0=; b=gRWithC6PftUqIH2sqxzrmeBl8
 LIuydyO8MUzsNq7PdiQs6ppEfvUzXbvCT21687p0TtY/ZmnYd7CwE2P3KUO8KWGS7u8JKu4Pc+mGd
 /ZABTGqrdqOmeeo2NDy0ulZoc86owoFjHmGDFBJDL8pnxk9kfT0Nea8il+gEW4RgZ+h4=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.3)
 id 1lW9hy-00088h-3K
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 13 Apr 2021 03:27:26 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 33D44610D2;
 Tue, 13 Apr 2021 03:27:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1618284430;
 bh=0XnIuzI4K1ZQhd0EadbJgO7P+abJbaS+1SwJrUxgrig=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=bQEcSE35DaAXjwGNWQnZ0ZVbFIA38TY/UAwm1KwD/AeFpapF/ib7Lm55UC50tH8Ml
 looATXDVBxBBQ6C8s7v9qoGjfICvFolNd/PFclLdSQo0rlijLaRjHPn0dYcd9clB/D
 5mbd6ufP1e5wObcamjBwimH09zySCVboYTaypryjrZFWuBHyioQuEyMDHY+WUzcYyM
 fv4KXDhpRIUxvYj5rgmrrqzuJa7MLvGGMCn0dnrBls1jVL4ThphLTJ6Q+gKpwaUhaL
 I+Va8Bs1VgvMdHc+07xZG6/Mz8F3izN1Jn5M8pG4MUiCHDWRnRN21h5R9wwRobZEPt
 0pJUx+sarPCuA==
Date: Mon, 12 Apr 2021 20:27:08 -0700
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Chao Yu <yuchao0@huawei.com>
Message-ID: <YHUPjDY9ifsffk4z@google.com>
References: <20210412081512.103592-1-yuchao0@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210412081512.103592-1-yuchao0@huawei.com>
X-Headers-End: 1lW9hy-00088h-3K
Subject: Re: [f2fs-dev] [PATCH v3] f2fs: fix to keep isolation of atomic
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

On 04/12, Chao Yu wrote:
> As Yi Chen reported, there is a potential race case described as below:
> 
> Thread A			Thread B
> - f2fs_ioc_start_atomic_write
> 				- mkwrite
> 				 - set_page_dirty
> 				  - f2fs_set_page_private(page, 0)
>  - set_inode_flag(FI_ATOMIC_FILE)
> 				- mkwrite same page
> 				 - set_page_dirty
> 				  - f2fs_register_inmem_page
> 				   - f2fs_set_page_private(ATOMIC_WRITTEN_PAGE)
> 				     failed due to PagePrivate flag has been set
> 				   - list_add_tail
> 				- truncate_inode_pages
> 				 - f2fs_invalidate_page
> 				  - clear page private but w/o remove it from
> 				    inmem_list
> 				 - set page->mapping to NULL
> - f2fs_ioc_commit_atomic_write
>  - __f2fs_commit_inmem_pages
>    - __revoke_inmem_pages
>     - f2fs_put_page panic as page->mapping is NULL
> 
> The root cause is we missed to keep isolation of atomic write in the case
> of start_atomic_write vs mkwrite, let start_atomic_write helds i_mmap_sem
> lock to avoid this issue.

My only concern is performance regression. Could you please verify the numbers?

> 
> Reported-by: Yi Chen <chenyi77@huawei.com>
> Signed-off-by: Chao Yu <yuchao0@huawei.com>
> ---
> v3:
> - rebase to last dev branch
> - update commit message because this patch fixes a different racing issue
> of atomic write
>  fs/f2fs/file.c    | 3 +++
>  fs/f2fs/segment.c | 6 ++++++
>  2 files changed, 9 insertions(+)
> 
> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> index d697c8900fa7..6284b2f4a60b 100644
> --- a/fs/f2fs/file.c
> +++ b/fs/f2fs/file.c
> @@ -2054,6 +2054,7 @@ static int f2fs_ioc_start_atomic_write(struct file *filp)
>  		goto out;
>  
>  	down_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
> +	down_write(&F2FS_I(inode)->i_mmap_sem);
>  
>  	/*
>  	 * Should wait end_io to count F2FS_WB_CP_DATA correctly by
> @@ -2064,6 +2065,7 @@ static int f2fs_ioc_start_atomic_write(struct file *filp)
>  			  inode->i_ino, get_dirty_pages(inode));
>  	ret = filemap_write_and_wait_range(inode->i_mapping, 0, LLONG_MAX);
>  	if (ret) {
> +		up_write(&F2FS_I(inode)->i_mmap_sem);
>  		up_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
>  		goto out;
>  	}
> @@ -2077,6 +2079,7 @@ static int f2fs_ioc_start_atomic_write(struct file *filp)
>  	/* add inode in inmem_list first and set atomic_file */
>  	set_inode_flag(inode, FI_ATOMIC_FILE);
>  	clear_inode_flag(inode, FI_ATOMIC_REVOKE_REQUEST);
> +	up_write(&F2FS_I(inode)->i_mmap_sem);
>  	up_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
>  
>  	f2fs_update_time(F2FS_I_SB(inode), REQ_TIME);
> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> index 0cb1ca88d4aa..78c8342f52fd 100644
> --- a/fs/f2fs/segment.c
> +++ b/fs/f2fs/segment.c
> @@ -325,6 +325,7 @@ void f2fs_drop_inmem_pages(struct inode *inode)
>  	struct f2fs_inode_info *fi = F2FS_I(inode);
>  
>  	do {
> +		down_write(&F2FS_I(inode)->i_mmap_sem);
>  		mutex_lock(&fi->inmem_lock);
>  		if (list_empty(&fi->inmem_pages)) {
>  			fi->i_gc_failures[GC_FAILURE_ATOMIC] = 0;
> @@ -339,11 +340,13 @@ void f2fs_drop_inmem_pages(struct inode *inode)
>  			spin_unlock(&sbi->inode_lock[ATOMIC_FILE]);
>  
>  			mutex_unlock(&fi->inmem_lock);
> +			up_write(&F2FS_I(inode)->i_mmap_sem);
>  			break;
>  		}
>  		__revoke_inmem_pages(inode, &fi->inmem_pages,
>  						true, false, true);
>  		mutex_unlock(&fi->inmem_lock);
> +		up_write(&F2FS_I(inode)->i_mmap_sem);
>  	} while (1);
>  }
>  
> @@ -468,6 +471,7 @@ int f2fs_commit_inmem_pages(struct inode *inode)
>  	f2fs_balance_fs(sbi, true);
>  
>  	down_write(&fi->i_gc_rwsem[WRITE]);
> +	down_write(&F2FS_I(inode)->i_mmap_sem);
>  
>  	f2fs_lock_op(sbi);
>  	set_inode_flag(inode, FI_ATOMIC_COMMIT);
> @@ -479,6 +483,8 @@ int f2fs_commit_inmem_pages(struct inode *inode)
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
