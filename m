Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88D8DC79FBB
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 10 Sep 2026 21:27:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:References:
	Message-ID:To:Date:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7uNpC3wiHmnPQvbOwJOrdEGIUbLyYqM7Dj9/XO/M2+k=; b=A95kdO6W4s2D0BQ2bdmZJmwIX+
	D/A/QWUCMb8D1lj1Cd/DVVqybKVxSa+IUC47eOZxwb/nv+u4zNz6EC0Yt0pxvxdFHMVL9c9OHPuw4
	Ma48RPwg4/Lz/eTyOzB4imalwPTsJh12oSIHFheRf1k8KHb9kvgP9ImLZiQyulO22v2A=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1x4mIx-0007Ki-A8;
	Thu, 10 Sep 2026 21:27:32 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <jaegeuk@kernel.org>) id 1x4mIX-0007K7-HA
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 10 Sep 2026 21:27:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=bu68vbqNnGp2CQdc7xwHZtBbShMb5uR0NI7RGHf5Elk=; b=Lviip4BE72UmSTk2VYySof8ynT
 yaoLlb96WbXbslKBrmOgr4CsEX6EnRhPd+avulEODvf9jPQ6tJbf84IiMFSfPRDWsHlUbirH0wvQG
 rThxwtLJBV0c0uY1a+U/wmsV7dlih/jm9C9r/KRhkTJYwgiNtjXvzn6SXVa6x/x+xEVg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=bu68vbqNnGp2CQdc7xwHZtBbShMb5uR0NI7RGHf5Elk=; b=F/B15NiqZ9MscIRwQigjqW1eNu
 lTbJcPgx2dWv7Dawda7dImPHg6zcWfWqcUQa5jz4bOn5OO3MMbQJPQyBcAFQC5eJVpAmNJUNtuD5n
 xsqpX8bkC6HJiw80i25YKTaC4IrcUa1YfTrLUnGhuLJBE6HDX71S5uo2n+bOeCvJvU7s=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1x4mIP-0005tF-PU for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 10 Sep 2026 21:27:02 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 1AE49601F0;
 Thu, 10 Sep 2026 21:26:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85F8A1F000FF;
 Thu, 10 Sep 2026 21:26:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789075615;
 bh=bu68vbqNnGp2CQdc7xwHZtBbShMb5uR0NI7RGHf5Elk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=fxCSOyWRk/swTL+6vQQvsIi8QjkyYM5rFfQVhb/Tq1h8uKy2vfpQnM+pjCvOFI35F
 /SGbZ5JRnK02uxFRjrh2/swah/dC6w6kcM31d5hPeBGjSGQ+2xMaRSvNUeKA7EX2Of
 9RMPO+sEOOYE9HOoa4uIDYYWrtzwB+8WiBFsiIzUUJbAX1wyauQtlM2+Ok/4kx9CgE
 4Jhr6hjXST4j/87SdbKo7gVf4+WYQAsATXN/OoZPUaU5unzoBBuQ42rnHtjXKcf0wa
 nqtM76q/v3+bC9lPYTWyfBxFLStloll2kvCjrTknW9z2hafOIS4UPsL5Kyaj8ro8oE
 egdpuQ5Ion7mA==
Date: Thu, 10 Sep 2026 21:26:54 +0000
To: Chao Yu <chao@kernel.org>
Message-ID: <aqMgnpBYj0zBpioI@google.com>
References: <20260910022026.3301257-1-chao@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260910022026.3301257-1-chao@kernel.org>
X-Headers-End: 1x4mIP-0005tF-PU
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix to avoid folio->mapping
 dereference in is_{meta, node}_folio()
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
Cc: Zhiguo Niu <zhiguo.niu@unisoc.com>, linux-f2fs-devel@lists.sourceforge.net,
 stable@kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Can you rebase on -dev?

On 09/10, Chao Yu via Linux-f2fs-devel wrote:
> From: Chao Yu <chao@kernel.org>
> 
> Otherwise, it may cause NULL pointer dereference in race condition:
> 
> Thread A			Thread B
> 				- f2fs_setattr
> 				 - f2fs_truncate
> 				  - f2fs_truncate_blocks
> 			    	   - f2fs_do_truncate_blocks
> 				    - f2fs_truncate_inode_blocks
> 				     - truncate_dnode
> 				      - truncate_node
> 				       - invalidate_mapping_pages
> 				        - folio->mapping = NULL
> - folio_lock
> - is_node_folio
>  - F2FS_F_SB(folio): dereference on folio->mapping
> 
> Cc: stable@kernel.org
> Fixes: 019a8912425e ("f2fs: introduce is_{meta,node}_folio")
> Reported-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
> Closes: https://lore.kernel.org/linux-f2fs-devel/c5d29b31-e764-4782-9639-be84b1b2bfc2@kernel.org
> Signed-off-by: Chao Yu <chao@kernel.org>
> ---
>  fs/f2fs/checkpoint.c |  4 ++--
>  fs/f2fs/data.c       |  7 ++++---
>  fs/f2fs/f2fs.h       | 10 +++++-----
>  fs/f2fs/gc.c         |  2 +-
>  fs/f2fs/node.c       | 22 +++++++++++-----------
>  fs/f2fs/segment.c    |  2 +-
>  6 files changed, 24 insertions(+), 23 deletions(-)
> 
> diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
> index 712c4508f38c..dfbfe42086f2 100644
> --- a/fs/f2fs/checkpoint.c
> +++ b/fs/f2fs/checkpoint.c
> @@ -291,7 +291,7 @@ static struct folio *__get_meta_folio(struct f2fs_sb_info *sbi, pgoff_t index,
>  	f2fs_update_iostat(sbi, NULL, FS_META_READ_IO, F2FS_BLKSIZE(sbi));
>  
>  	folio_lock(folio);
> -	if (unlikely(!is_meta_folio(folio))) {
> +	if (unlikely(!is_meta_folio(sbi, folio))) {
>  		f2fs_folio_put(folio, true);
>  		goto repeat;
>  	}
> @@ -638,7 +638,7 @@ long f2fs_sync_meta_pages(struct f2fs_sb_info *sbi, long nr_to_write,
>  
>  			folio_lock(folio);
>  
> -			if (unlikely(!is_meta_folio(folio))) {
> +			if (unlikely(!is_meta_folio(sbi, folio))) {
>  continue_unlock:
>  				folio_unlock(folio);
>  				continue;
> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> index 93ed8416a289..0da78bf05ac0 100644
> --- a/fs/f2fs/data.c
> +++ b/fs/f2fs/data.c
> @@ -172,7 +172,8 @@ static void f2fs_finish_read_bio(struct bio *bio, bool in_task)
>  			dec_page_count(F2FS_F_SB(folio), __read_io_type(folio));
>  
>  		if (bio->bi_status == BLK_STS_OK &&
> -			F2FS_F_SB(folio)->node_inode && is_node_folio(folio) &&
> +			F2FS_F_SB(folio)->node_inode &&
> +			is_node_folio(F2FS_F_SB(folio), folio) &&
>  			f2fs_sanity_check_node_footer(F2FS_F_SB(folio),
>  				folio, folio->index, NODE_TYPE_REGULAR, true))
>  			bio->bi_status = BLK_STS_IOERR;
> @@ -359,12 +360,12 @@ static void f2fs_write_end_bio(struct bio *bio)
>  			}
>  		}
>  
> -		if (is_node_folio(folio)) {
> +		if (is_node_folio(sbi, folio)) {
>  			f2fs_sanity_check_node_footer(sbi, folio,
>  				folio->index, NODE_TYPE_REGULAR, true);
>  			f2fs_bug_on(sbi, folio->index != nid_of_node(sbi, folio));
>  		}
> -		if (f2fs_in_warm_node_list(folio))
> +		if (f2fs_in_warm_node_list(sbi, folio))
>  			f2fs_del_fsync_node_entry(sbi, folio);
>  
>  		dec_page_count(sbi, type);
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index 693153cbd8a0..ebc621f302e1 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -2371,14 +2371,14 @@ static inline struct address_space *NODE_MAPPING(struct f2fs_sb_info *sbi)
>  	return sbi->node_inode->i_mapping;
>  }
>  
> -static inline bool is_meta_folio(struct folio *folio)
> +static inline bool is_meta_folio(struct f2fs_sb_info *sbi, struct folio *folio)
>  {
> -	return folio->mapping == META_MAPPING(F2FS_F_SB(folio));
> +	return folio->mapping == META_MAPPING(sbi);
>  }
>  
> -static inline bool is_node_folio(struct folio *folio)
> +static inline bool is_node_folio(struct f2fs_sb_info *sbi, struct folio *folio)
>  {
> -	return folio->mapping == NODE_MAPPING(F2FS_F_SB(folio));
> +	return folio->mapping == NODE_MAPPING(sbi);
>  }
>  
>  static inline bool is_sbi_flag_set(struct f2fs_sb_info *sbi, unsigned int type)
> @@ -4063,7 +4063,7 @@ enum node_type;
>  
>  int f2fs_check_nid_range(struct f2fs_sb_info *sbi, nid_t nid);
>  bool f2fs_available_free_memory(struct f2fs_sb_info *sbi, int type);
> -bool f2fs_in_warm_node_list(struct folio *folio);
> +bool f2fs_in_warm_node_list(struct f2fs_sb_info *sbi, struct folio *folio);
>  void f2fs_init_fsync_node_info(struct f2fs_sb_info *sbi);
>  void f2fs_del_fsync_node_entry(struct f2fs_sb_info *sbi, struct folio *folio);
>  void f2fs_reset_fsync_node_info(struct f2fs_sb_info *sbi);
> diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
> index aedb45c8ee4a..c70deac9f1a3 100644
> --- a/fs/f2fs/gc.c
> +++ b/fs/f2fs/gc.c
> @@ -1431,7 +1431,7 @@ static int move_data_block(struct inode *inode, block_t bidx,
>  						F2FS_BLKSIZE(fio.sbi));
>  
>  		folio_lock(mfolio);
> -		if (unlikely(!is_meta_folio(mfolio) ||
> +		if (unlikely(!is_meta_folio(fio.sbi, mfolio) ||
>  			     !folio_test_uptodate(mfolio))) {
>  			err = -EIO;
>  			f2fs_folio_put(mfolio, true);
> diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
> index 8c150d4966e5..f16144b75d11 100644
> --- a/fs/f2fs/node.c
> +++ b/fs/f2fs/node.c
> @@ -332,10 +332,10 @@ static unsigned int __gang_lookup_nat_set(struct f2fs_nm_info *nm_i,
>  							start, nr);
>  }
>  
> -bool f2fs_in_warm_node_list(struct folio *folio)
> +bool f2fs_in_warm_node_list(struct f2fs_sb_info *sbi, struct folio *folio)
>  {
> -	return is_node_folio(folio) && IS_DNODE(F2FS_F_SB(folio), folio) &&
> -					is_cold_node(F2FS_F_SB(folio), folio);
> +	return is_node_folio(sbi, folio) && IS_DNODE(sbi, folio) &&
> +					is_cold_node(sbi, folio);
>  }
>  
>  void f2fs_init_fsync_node_info(struct f2fs_sb_info *sbi)
> @@ -1296,7 +1296,7 @@ int f2fs_truncate_inode_blocks(struct inode *inode, pgoff_t from)
>  			goto fail;
>  		if (offset[1] == 0 && get_nid(sbi, folio, offset[0], true)) {
>  			folio_lock(folio);
> -			BUG_ON(!is_node_folio(folio));
> +			BUG_ON(!is_node_folio(sbi, folio));
>  			set_nid(sbi, folio, offset[0], 0, true);
>  			folio_unlock(folio);
>  		}
> @@ -1612,7 +1612,7 @@ static struct folio *__get_node_folio(struct f2fs_sb_info *sbi, pgoff_t nid,
>  
>  	folio_lock(folio);
>  
> -	if (unlikely(!is_node_folio(folio))) {
> +	if (unlikely(!is_node_folio(sbi, folio))) {
>  		f2fs_folio_put(folio, true);
>  		goto repeat;
>  	}
> @@ -1731,7 +1731,7 @@ static struct folio *last_fsync_dnode(struct f2fs_sb_info *sbi, nid_t ino)
>  
>  			folio_lock(folio);
>  
> -			if (unlikely(!is_node_folio(folio))) {
> +			if (unlikely(!is_node_folio(sbi, folio))) {
>  continue_unlock:
>  				folio_unlock(folio);
>  				continue;
> @@ -1841,7 +1841,7 @@ static bool __write_node_folio(struct folio *folio, bool atomic, bool do_fsync,
>  				f2fs_need_dentry_mark(sbi, ino_of_node(sbi, folio)));
>  
>  	/* should add to global list before clearing PAGECACHE status */
> -	if (f2fs_in_warm_node_list(folio)) {
> +	if (f2fs_in_warm_node_list(sbi, folio)) {
>  		seq = f2fs_add_fsync_node_entry(sbi, folio);
>  		if (seq_id)
>  			*seq_id = seq;
> @@ -1965,7 +1965,7 @@ int f2fs_fsync_node_pages(struct f2fs_sb_info *sbi, struct inode *inode,
>  
>  			folio_lock(folio);
>  
> -			if (unlikely(!is_node_folio(folio))) {
> +			if (unlikely(!is_node_folio(sbi, folio))) {
>  continue_unlock:
>  				folio_unlock(folio);
>  				continue;
> @@ -2023,7 +2023,7 @@ int f2fs_fsync_node_pages(struct f2fs_sb_info *sbi, struct inode *inode,
>  		f2fs_debug(sbi, "Retry to write fsync mark: ino=%u, idx=%lx",
>  			   ino, last_folio->index);
>  		folio_lock(last_folio);
> -		if (unlikely(!is_node_folio(last_folio))) {
> +		if (unlikely(!is_node_folio(sbi, last_folio))) {
>  			f2fs_folio_put(last_folio, true);
>  			ret = -EAGAIN;
>  			goto out;
> @@ -2101,7 +2101,7 @@ void f2fs_flush_inline_data(struct f2fs_sb_info *sbi)
>  
>  			folio_lock(folio);
>  
> -			if (unlikely(!is_node_folio(folio)))
> +			if (unlikely(!is_node_folio(sbi, folio)))
>  				goto unlock;
>  			if (!folio_test_dirty(folio))
>  				goto unlock;
> @@ -2173,7 +2173,7 @@ int f2fs_sync_node_pages(struct f2fs_sb_info *sbi,
>  			else if (!folio_trylock(folio))
>  				continue;
>  
> -			if (unlikely(!is_node_folio(folio))) {
> +			if (unlikely(!is_node_folio(sbi, folio))) {
>  continue_unlock:
>  				folio_unlock(folio);
>  				continue;
> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> index 0b6267d0354e..ffdd2c510b3c 100644
> --- a/fs/f2fs/segment.c
> +++ b/fs/f2fs/segment.c
> @@ -4161,7 +4161,7 @@ static void do_write_page(struct f2fs_summary *sum, struct f2fs_io_info *fio)
>  			__func__, fio->ino, folio->index, type,
>  			fio->old_blkaddr, fio->new_blkaddr, err);
>  		folio_end_writeback(folio);
> -		if (f2fs_in_warm_node_list(folio))
> +		if (f2fs_in_warm_node_list(fio->sbi, folio))
>  			f2fs_del_fsync_node_entry(fio->sbi, folio);
>  		f2fs_bug_on(fio->sbi, !is_set_ckpt_flags(fio->sbi,
>  							CP_ERROR_FLAG));
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
