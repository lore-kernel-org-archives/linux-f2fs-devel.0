Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7076C44508
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 15 Jul 2026 18:05:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:References:
	Message-ID:To:Date:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=G3nV7mE2edk3jRjEJa53GCzn3u1gLuwxyAwxsYNc8ZA=; b=gNpGbIkHLd58O/2LUodO0o93vQ
	Zwgg7EnAC6zXkk6iAA76kssL9zJYv9FJBrOhZmkKuXeOy6tGBNJOtsmrNq3delVw8Zjw2i74tl1Gc
	FBSpSNlQdF2trrfni2LOFt1oFs6YB5gmk8FwSATQtwTTJydf5G3XlC/fGbR4l7XJUWVY=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wk3zB-0003YR-LA;
	Wed, 15 Jul 2026 18:05:34 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <jaegeuk@kernel.org>) id 1wk3z9-0003YK-N9
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 15 Jul 2026 18:05:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=y+j3XhXAjUTzHooiJRk8qHZv0bycga9dQQh4LFh9mh8=; b=hzR0Jn0kZXyYeRvsqgsuhqk/rR
 DS3UQF6UBdoZ59j+RZ2rfLMkwoZ5TT+p+92agNBiJsojP03jqPg/HVeRAjFO0xTFaHcRHDcgNipT5
 y5ipuKml79Gvciqfs9m2+bh3iuXnUQ+tE91Z1pj19hH7T7Pl2dFFMl1si+xwgX0Cftss=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=y+j3XhXAjUTzHooiJRk8qHZv0bycga9dQQh4LFh9mh8=; b=ZQ6sV4zgzg137tC7AVFc4F8huS
 nWAJrBVvqxBMXOsTGxtXXMrfnUKh037q4FPy1UwvcwmAgh52fPFjZ/DAZEvNVB6hyWerjlaQuRyWh
 6H4taBJKDL82ZekguQN8GSbCnNgUfSdqGT/5OGBuynyRUTXa8p1/lfMsvku3NoGHdkks=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wk3z8-0000LH-Mv for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 15 Jul 2026 18:05:32 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id A17EB61838
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed, 15 Jul 2026 18:05:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30A971F000E9;
 Wed, 15 Jul 2026 18:05:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784138719;
 bh=y+j3XhXAjUTzHooiJRk8qHZv0bycga9dQQh4LFh9mh8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=mWC4qfOzaQsOuEZtQEUYBmETZJZEwp1ngTIOTHOrpO2+u1G+f1wODX9qqwMmCN7k3
 C02TA/hmNNr5YqA5T21Ga61afs23WkWO/Wnqr66HpRrDI+ynG+Md+Tn/+RaucafaBv
 lYYD7KVJzEpTYcTt57SCb00Ls7IWeIxxPNR3XVqWIERi2728UpgvZ2SD1mMFwpmnSg
 z0C0tgrl6vY+jnm8FqEdxkNJW5ehDnfvB2aTQmpYal3hgRVPyiU4ld+UxKsnEUq3/f
 cXbzWYEKgR3uHe1bI87v6S7dGKmI2M+yF6aP6fNm2TCWua61pyYx1TkBciZPoYVh+8
 wkQjtZo+0xtOg==
Date: Wed, 15 Jul 2026 18:05:17 +0000
To: Chao Yu <chao@kernel.org>
Message-ID: <alfL3c5Br1wQhvfb@google.com>
References: <20260706072606.3709384-1-chao@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260706072606.3709384-1-chao@kernel.org>
X-Headers-End: 1wk3z8-0000LH-Mv
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix to zero post-EOF data when
 extending file size
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
From: Jaegeuk Kim via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net, stable@kernel.org,
 linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

This causes sysmtem hang during xfstests.

On 07/06, Chao Yu via Linux-f2fs-devel wrote:
> generic/794  4s ... - output mismatch (see /share/git/fstests/results//generic/794.out.bad)
>     --- tests/generic/794.out   2026-06-12 08:46:32.766426241 +0800
>     +++ /share/git/fstests/results//generic/794.out.bad 2026-07-05 18:32:55.000000000 +0800
>     @@ -1,4 +1,16 @@
>      QA output created by 794
>      append_write
>     +FAIL: non-zero data in gap [4080,4096) after shutdown+remount
>     +000000 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a  >ZZZZZZZZZZZZZZZZ<
>     +*
>     +001000
>      truncate_up
>     ...
>     (Run 'diff -u /share/git/fstests/tests/generic/794.out /share/git/fstests/results//generic/794.out.bad'  to see the entire diff)
> Ran: generic/794
> Failures: generic/794
> Failed 1 of 1 tests
> 
> Steps of generic/794:
> 1. write 4096 bytes to file w/ 0x5a
> 2. use fiemap to get PBA of first block in file
> 3. truncate file to 4080
> 4. umount; write 4096 bytes to file w/ 0x5a directly via PBA; mount
> 5. extend filesize via
>    a) append 4096 from offset 4096, or
>    b) truncate 8192, or
>    c) fallocate 4096 from offset 4096
> 6. verify the gap is zeroed in memory [4080,4096)
> 7. sync range 4096 from offset 4096; shutdown -f (flush meta before shutdown)
> 8. umount; mount; verify [4080,4096) is zeroed or not.
> 
> When extending file size (e.g. via truncate, fallocate, or write) across an
> unaligned EOF boundary, we need to ensure that post-EOF data in the partial
> page is zeroed out in pagecache and marked dirty, meanwhile, tagging the inode
> with FI_ZERO_POST_EOF, so that following checkpoint() and fsync() can persist
> the page contain zeroed data before committing inode w/ updated i_size.
> 
> This help to prevent stale disk data beyond the previous EOF from being exposed
> after remounting or crash recovery.
> 
> Since f2fs is a LFS filesystem, we only support direct write via PBA in pinfile,
> and pinfile has section-aligned filesize, so in Android, there should no problem,
> but for other usage in different environment, let's fix this w/ fsync_mode=strict
> mount option.
> 
> Cc: stable@kernel.org
> Signed-off-by: Chao Yu <chao@kernel.org>
> ---
>  fs/f2fs/checkpoint.c |  4 ++++
>  fs/f2fs/f2fs.h       |  1 +
>  fs/f2fs/file.c       | 35 ++++++++++++++++++++++++++++++++---
>  3 files changed, 37 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
> index 064f5b537423..6f486d3a94c7 100644
> --- a/fs/f2fs/checkpoint.c
> +++ b/fs/f2fs/checkpoint.c
> @@ -1359,6 +1359,10 @@ static int f2fs_sync_inode_meta(struct f2fs_sb_info *sbi)
>  		inode = igrab(&fi->vfs_inode);
>  		spin_unlock(&sbi->inode_lock[DIRTY_META]);
>  		if (inode) {
> +			if (is_inode_flag_set(inode, FI_ZERO_POST_EOF)) {
> +				filemap_write_and_wait(inode->i_mapping);
> +				clear_inode_flag(inode, FI_ZERO_POST_EOF);
> +			}
>  			sync_inode_metadata(inode, 0);
>  
>  			/* it's on eviction */
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index 8e2fb0bda467..41be09dad43c 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -939,6 +939,7 @@ enum {
>  	FI_ATOMIC_REPLACE,	/* indicate atomic replace */
>  	FI_OPENED_FILE,		/* indicate file has been opened */
>  	FI_DONATE_FINISHED,	/* indicate page donation of file has been finished */
> +	FI_ZERO_POST_EOF,	/* indicate unaligned EOF gap was zeroed in pagecache */
>  	FI_MAX,			/* max flag, never be used */
>  };
>  
> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> index 11cc8d79c235..2e9d585073ec 100644
> --- a/fs/f2fs/file.c
> +++ b/fs/f2fs/file.c
> @@ -36,21 +36,43 @@
>  #include <trace/events/f2fs.h>
>  #include <uapi/linux/f2fs.h>
>  
> +static int fill_zero(struct inode *inode, pgoff_t index,
> +					loff_t start, loff_t len);
> +
>  static void f2fs_zero_post_eof_page(struct inode *inode,
>  					loff_t new_size, bool lock)
>  {
>  	loff_t old_size = i_size_read(inode);
> +	unsigned int offset;
>  
>  	if (old_size >= new_size)
>  		return;
>  
> -	if (mapping_empty(inode->i_mapping))
> -		return;
> -
>  	if (lock)
>  		filemap_invalidate_lock(inode->i_mapping);
> +
>  	/* zero or drop pages only in range of [old_size, new_size] */
>  	truncate_inode_pages_range(inode->i_mapping, old_size, new_size);
> +
> +	/*
> +	 * When expanding an unaligned EOF size, zero post-EOF data in
> +	 * pagecache and set FI_ZERO_POST_EOF, so following checkpointing
> +	 * or fsync can persist correct data to disk before committing
> +	 * inode w/ updated i_size.
> +	 */
> +	if (F2FS_OPTION(F2FS_I_SB(inode)).fsync_mode != FSYNC_MODE_STRICT)
> +		goto out_unlock;
> +
> +	offset = old_size & (PAGE_SIZE - 1);
> +	if (offset) {
> +		unsigned int len = min_t(loff_t, PAGE_SIZE - offset,
> +							new_size - old_size);
> +		pgoff_t index = old_size >> PAGE_SHIFT;
> +
> +		fill_zero(inode, index, offset, len);
> +		set_inode_flag(inode, FI_ZERO_POST_EOF);
> +	}
> +out_unlock:
>  	if (lock)
>  		filemap_invalidate_unlock(inode->i_mapping);
>  }
> @@ -304,6 +326,13 @@ static int f2fs_do_sync_file(struct file *file, loff_t start, loff_t end,
>  	if (S_ISDIR(inode->i_mode))
>  		goto go_write;
>  
> +	if (is_inode_flag_set(inode, FI_ZERO_POST_EOF)) {
> +		ret = filemap_write_and_wait(inode->i_mapping);
> +		if (ret)
> +			return ret;
> +		clear_inode_flag(inode, FI_ZERO_POST_EOF);
> +	}
> +
>  	/* if fdatasync is triggered, let's do in-place-update */
>  	if (datasync || get_dirty_pages(inode) <= SM_I(sbi)->min_fsync_blocks)
>  		set_inode_flag(inode, FI_NEED_IPU);
> -- 
> 2.49.0
> 
> 
> 
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
