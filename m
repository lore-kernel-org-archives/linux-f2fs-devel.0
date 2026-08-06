Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE155C55ABA
	for <linux-f2fs-devel@archiver.kernel.org>; Thu,  6 Aug 2026 02:38:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=N4IVKQvRE6RgNUD4kPrg2lkwopDXsvnS/KS+cCIEvA4=; b=TpWkpluDI8W5HpyCkGNUB7ZZ2I
	rEdQThsYDoIgB6+lpiT9ZN5A9HK33oXNB2kemAHbKAtyS9VMTBhQBDNUBlYm95bS3yh3E0FdS+Gjx
	eYKUndZ5esgZkkLpcpaOewobSSgD1VnLgaWOnotVknWDv003zncvKqTxByZ4gsTuL5kY=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wro0X-0002Gy-TH;
	Thu, 06 Aug 2026 02:38:58 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1wro0X-0002Gr-8y
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 06 Aug 2026 02:38:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=wd/h1zHowH4MGLhpmRnTj09iTqs6Nx9ZT6Fvmt7cbp8=; b=Xr0i14oYdp5qaKo3C0GQjwI+Ar
 6kkTgetA+pUzToA+AgBazJNwp9xoN/8D1DofuOOHyiLIxroBbLc5OGzhLxJIKBT/Btya22UmpRQGR
 bPugHdjQ234JKLQnuQ/b1pay5QT/LFDyYiff1lJr/NlrYzE/bRnR2lRmj8DSz433+Azs=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=wd/h1zHowH4MGLhpmRnTj09iTqs6Nx9ZT6Fvmt7cbp8=; b=KicVZvt87+ZMWzUlf3E4RQLjRS
 1yMq4GETRn5BV777VWl1b9Gvy8STN5YXgUMjb5SPykJEhwZN9TiW/fgp22kUMItLsuXwExsJKuMUx
 CLT0M4gbK1s8fj/6nAlQWJ7tlye9IlhovQjxQs/8L9d8z/e+EHnJ+MD7c+LmN8DV1BmE=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wro0X-0006S3-1Q for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 06 Aug 2026 02:38:58 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 94B1341881
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu,  6 Aug 2026 02:38:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB8F51F000E9;
 Thu,  6 Aug 2026 02:38:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785983931;
 bh=wd/h1zHowH4MGLhpmRnTj09iTqs6Nx9ZT6Fvmt7cbp8=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To;
 b=W9ajEY5kXe93Vb/S1wGGhH68BFfv+MKLnjaMlxr7VT6Pi3l4+pwwG9eCTdCznOI8M
 ccMPI7O7eKmFRRO7L1SIp9xhZvbgcnqflOHKKlAnOgNAspO1brf4wMcjjGBtw5VWOr
 BsmqlBiLFDwn+GE8CyGLasNvzyT+I7HnAE1sY075moAsIbvnE/K+ZJuMABZSnWUMjn
 og9A6ljVp7DTfXHq1hWGQFU+luFG3NxfVFJDp2cn1YSyI6n9SHQ9/zMsyANQdPz4BS
 TCC8e+OaRHQLK9QnrS2fcDtCrHOWtz1Bb4M3EPNIsCVVTR40gH2Tu4aHc0q1Ug4YK8
 F0WsW4QNtYa+g==
Message-ID: <5ddb4d67-3529-4df2-bf1d-19a805237c78@kernel.org>
Date: Thu, 6 Aug 2026 10:38:48 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
References: <20260804002027.2196300-1-jaegeuk@kernel.org>
 <anKRwA6t34sqgght@google.com>
Content-Language: en-US
In-Reply-To: <anKRwA6t34sqgght@google.com>
X-Headers-End: 1wro0X-0006S3-1Q
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: call __add_ino_entry out of the
 eviction path
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 8/5/26 09:28, Jaegeuk Kim via Linux-f2fs-devel wrote:
> The f2fs_evict_inode() can be called during the direct reclaim path, but
> __add_ino_entry requires allocating some memory. Since we don't need to
> do that in that context, let's migrate it in other workqueue context.
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> ---
>  Change log from v1:
>   - fix a bug on the wait logic
> 
>  fs/f2fs/checkpoint.c | 11 ++++++
>  fs/f2fs/data.c       | 13 ++++++-
>  fs/f2fs/f2fs.h       |  4 ++
>  fs/f2fs/inode.c      | 91 +++++++++++++++++++++++++++++++++++++++++---
>  fs/f2fs/super.c      |  9 ++++-
>  5 files changed, 121 insertions(+), 7 deletions(-)
> 
> diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
> index 064f5b537423..4413eccb5ecb 100644
> --- a/fs/f2fs/checkpoint.c
> +++ b/fs/f2fs/checkpoint.c
> @@ -766,6 +766,15 @@ static void __remove_ino_entry(struct f2fs_sb_info *sbi, nid_t ino, int type)
>  	spin_unlock(&im->ino_lock);
>  }
>  
> +static void f2fs_wait_for_inode_record(struct f2fs_sb_info *sbi, int mode)
> +{
> +	if (mode != APPEND_INO && mode != UPDATE_INO)
> +		return;
> +
> +	/* Let's wait for some pending updates for APPEND_INO and UPDATE_INO. */
> +	flush_workqueue(sbi->evict_wq);
> +}
> +
>  void f2fs_add_ino_entry(struct f2fs_sb_info *sbi, nid_t ino, int type)
>  {
>  	/* add new dirty ino entry into list */
> @@ -798,6 +807,8 @@ void f2fs_release_ino_entry(struct f2fs_sb_info *sbi, bool all)
>  	for (i = all ? ORPHAN_INO : APPEND_INO; i < MAX_INO_ENTRY; i++) {
>  		struct inode_management *im = &sbi->im[i];
>  
> +		f2fs_wait_for_inode_record(sbi, i);
> +
>  		spin_lock(&im->ino_lock);
>  		list_for_each_entry_safe(e, tmp, &im->ino_list, list) {
>  			list_del(&e->list);
> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> index c219ea76a3a7..6ae0eb37d20f 100644
> --- a/fs/f2fs/data.c
> +++ b/fs/f2fs/data.c
> @@ -4558,13 +4558,24 @@ int f2fs_init_wq(struct f2fs_sb_info *sbi)
>  {
>  	sbi->wq = alloc_workqueue("f2fs_wq", WQ_UNBOUND | WQ_HIGHPRI,
>  				  num_online_cpus());
> -	return sbi->wq ? 0 : -ENOMEM;
> +	if (!sbi->wq)
> +		return -ENOMEM;
> +
> +	sbi->evict_wq = alloc_workqueue("f2fs_evict_wq",
> +			WQ_UNBOUND | WQ_HIGHPRI, num_online_cpus());
> +	if (!sbi->evict_wq) {
> +		destroy_workqueue(sbi->wq);
> +		return -ENOMEM;
> +	}
> +	return 0;
>  }
>  
>  void f2fs_destroy_wq(struct f2fs_sb_info *sbi)
>  {
>  	if (sbi->wq)
>  		destroy_workqueue(sbi->wq);
> +	if (sbi->evict_wq)
> +		destroy_workqueue(sbi->evict_wq);
>  }
>  
>  int __init f2fs_init_bio_entry_cache(void)
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index c44908258dc1..54f9d3856b5c 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -2016,6 +2016,8 @@ struct f2fs_sb_info {
>  
>  	struct workqueue_struct *wq;		/* bio completion workqueue */
>  
> +	struct workqueue_struct *evict_wq;	/* inode eviction workqueue */
> +
>  	/*
>  	 * If we are in irq context, let's update error information into
>  	 * on-disk superblock in the work.
> @@ -3875,6 +3877,8 @@ int f2fs_write_inode(struct inode *inode, struct writeback_control *wbc);
>  void f2fs_remove_donate_inode(struct inode *inode);
>  void f2fs_evict_inode(struct inode *inode);
>  void f2fs_handle_failed_inode(struct inode *inode, struct f2fs_lock_context *lc);
> +int f2fs_init_evict_inode_work(void);
> +void f2fs_destroy_evict_inode_work(void);
>  
>  /*
>   * namei.c
> diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
> index c95e0b126da4..0d30489cf083 100644
> --- a/fs/f2fs/inode.c
> +++ b/fs/f2fs/inode.c
> @@ -24,6 +24,18 @@
>  extern const struct address_space_operations f2fs_compress_aops;
>  #endif
>  
> +#define NUM_PREALLOC_EVICT_INODE_WORK 8
> +
> +static struct kmem_cache *evict_inode_work_cache;
> +static mempool_t *evict_inode_work_pool;
> +
> +struct evict_inode_work {
> +	struct work_struct work;
> +	struct f2fs_sb_info *sbi;
> +	nid_t ino;
> +	unsigned int add_ino_entry_bits;
> +};
> +
>  void f2fs_mark_inode_dirty_sync(struct inode *inode, bool sync)
>  {
>  	if (is_inode_flag_set(inode, FI_NEW_INODE))
> @@ -637,6 +649,9 @@ struct inode *f2fs_iget(struct super_block *sb, unsigned long ino)
>  		inode->i_fop = &f2fs_dir_operations;
>  		inode->i_mapping->a_ops = &f2fs_dblock_aops;
>  		mapping_set_gfp_mask(inode->i_mapping, GFP_NOFS);
> +
> +		/* Let's prepare APPEND/UPDATE_INO before future access. */
> +		flush_workqueue(sbi->evict_wq);
>  	} else if (S_ISLNK(inode->i_mode)) {
>  		if (file_is_encrypt(inode))
>  			inode->i_op = &f2fs_encrypted_symlink_inode_operations;
> @@ -854,6 +869,25 @@ void f2fs_remove_donate_inode(struct inode *inode)
>  	spin_unlock(&sbi->inode_lock[DONATE_INODE]);
>  }
>  
> +static void f2fs_record_inode_state(struct f2fs_sb_info *sbi, nid_t ino,
> +				    unsigned int bits)
> +{
> +	if (bits & BIT(APPEND_INO))
> +		f2fs_add_ino_entry(sbi, ino, APPEND_INO);
> +	if (bits & BIT(UPDATE_INO))
> +		f2fs_add_ino_entry(sbi, ino, UPDATE_INO);
> +}
> +
> +static void f2fs_evict_inode_work(struct work_struct *work)
> +{
> +	struct evict_inode_work *ew =
> +		container_of(work, struct evict_inode_work, work);
> +
> +	f2fs_record_inode_state(ew->sbi, ew->ino, ew->add_ino_entry_bits);
> +
> +	mempool_free(ew, evict_inode_work_pool);
> +}
> +
>  /*
>   * Called at the last iput() if i_nlink is zero
>   */
> @@ -864,6 +898,7 @@ void f2fs_evict_inode(struct inode *inode)
>  	nid_t xnid = fi->i_xattr_nid;
>  	int err = 0;
>  	bool freeze_protected = false;
> +	unsigned int record_bits = 0;
>  
>  	f2fs_abort_atomic_write(inode, true);
>  
> @@ -1003,12 +1038,32 @@ void f2fs_evict_inode(struct inode *inode)
>  							inode->i_ino);
>  	if (xnid)
>  		invalidate_mapping_pages(NODE_MAPPING(sbi), xnid, xnid);
> -	if (inode->i_nlink) {
> -		if (is_inode_flag_set(inode, FI_APPEND_WRITE))
> -			f2fs_add_ino_entry(sbi, inode->i_ino, APPEND_INO);
> -		if (is_inode_flag_set(inode, FI_UPDATE_WRITE))
> -			f2fs_add_ino_entry(sbi, inode->i_ino, UPDATE_INO);
> +
> +	if (!inode->i_nlink)
> +		goto skip_record;
> +
> +	if (is_inode_flag_set(inode, FI_APPEND_WRITE))
> +		record_bits = BIT(APPEND_INO);
> +	if (is_inode_flag_set(inode, FI_UPDATE_WRITE))
> +		record_bits = BIT(UPDATE_INO);
> +
> +	if (!record_bits)
> +		goto skip_record;
> +
> +	/* Let's do this in workqueue out of the direct reclaim path. */
> +	if (current_is_kswapd()) {
> +		f2fs_record_inode_state(sbi, inode->i_ino, record_bits);
> +	} else {
> +		struct evict_inode_work *ew =
> +			mempool_alloc(evict_inode_work_pool, GFP_NOFS);
> +
> +		ew->sbi = sbi;
> +		ew->ino = inode->i_ino;
> +		ew->add_ino_entry_bits = record_bits;
> +		INIT_WORK(&ew->work, f2fs_evict_inode_work);
> +		queue_work(sbi->evict_wq, &ew->work);
>  	}
> +skip_record:

What do you think of wrapping above codes into a static function for cleanup?

Thanks,

>  	if (is_inode_flag_set(inode, FI_FREE_NID)) {
>  		f2fs_alloc_nid_failed(sbi, inode->i_ino);
>  		clear_inode_flag(inode, FI_FREE_NID);
> @@ -1079,3 +1134,29 @@ void f2fs_handle_failed_inode(struct inode *inode, struct f2fs_lock_context *lc)
>  	/* iput will drop the inode object */
>  	iput(inode);
>  }
> +
> +int __init f2fs_init_evict_inode_work(void)
> +{
> +	evict_inode_work_cache =
> +		kmem_cache_create("f2fs_evict_inode_work",
> +				  sizeof(struct evict_inode_work), 0, 0, NULL);
> +	if (!evict_inode_work_cache)
> +		goto fail;
> +	evict_inode_work_pool =
> +		mempool_create_slab_pool(NUM_PREALLOC_EVICT_INODE_WORK,
> +					 evict_inode_work_cache);
> +	if (!evict_inode_work_pool)
> +		goto fail_free_cache;
> +	return 0;
> +
> +fail_free_cache:
> +	kmem_cache_destroy(evict_inode_work_cache);
> +fail:
> +	return -ENOMEM;
> +}
> +
> +void f2fs_destroy_evict_inode_work(void)
> +{
> +	mempool_destroy(evict_inode_work_pool);
> +	kmem_cache_destroy(evict_inode_work_cache);
> +}
> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> index 67abbf7ab477..6b55c30f0daa 100644
> --- a/fs/f2fs/super.c
> +++ b/fs/f2fs/super.c
> @@ -5763,10 +5763,16 @@ static int __init init_f2fs_fs(void)
>  	err = f2fs_init_xattr_cache();
>  	if (err)
>  		goto free_casefold_cache;
> -	err = register_filesystem(&f2fs_fs_type);
> +	err = f2fs_init_evict_inode_work();
>  	if (err)
>  		goto free_xattr_cache;
> +	err = register_filesystem(&f2fs_fs_type);
> +	if (err)
> +		goto free_evict_inode_cache;
>  	return 0;
> +
> +free_evict_inode_cache:
> +	f2fs_destroy_evict_inode_work();
>  free_xattr_cache:
>  	f2fs_destroy_xattr_cache();
>  free_casefold_cache:
> @@ -5809,6 +5815,7 @@ static int __init init_f2fs_fs(void)
>  static void __exit exit_f2fs_fs(void)
>  {
>  	unregister_filesystem(&f2fs_fs_type);
> +	f2fs_destroy_evict_inode_work();
>  	f2fs_destroy_xattr_cache();
>  	f2fs_destroy_casefold_cache();
>  	f2fs_destroy_compress_cache();



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
