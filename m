Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 632CACA9ED5
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 12 Oct 2026 06:55:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Content-Transfer-Encoding:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6UdZdSeKQiZPCO3TvCI5VE7Gvz6sOVey6oNKUB7DTyY=; b=KzZ8auFgSSN4f+hsE0N/jWPEz9
	jazFCTfxisQJOiCHI+mu6hwpltM6D+ZrsyMuItdy5uzbFRFDEB8TqAabJTgYTaZFyGy07zeiuF1K2
	mCK/DQb+xt3PBCDbs/74T89Seny2MCMK25GquiOH62CDtuHAxfVlZufxXt1ZXpvYd6YQ=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xG9wA-0004cb-7I;
	Mon, 12 Oct 2026 06:55:07 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1xG9w8-0004cL-Bb
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 12 Oct 2026 06:55:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ixUDbnCWgkzkbUHhz0JT3wyfuPZOPnsypnSoCMDlymM=; b=fM8gJZU4BbVw0ox2zSPbQ4NI+0
 iliiEFDnTTRT+xcQKdvN4T1tusJ6UHCZfe0OHvAzc8Y1BCVuo9AZZJ6XWJboNqC16NAuNVo6+8KZR
 oibwdkhrhbvAc6gdBSFJsjy5IIZ6Pw2gXk9eWtUj0yWXYOYYZWQ5rOch2o35lqhICkbs=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=ixUDbnCWgkzkbUHhz0JT3wyfuPZOPnsypnSoCMDlymM=; b=OcL1ng+9MFMXBdjZKglar8iP12
 0UF5BUfKwivFnOwbhnUiCOdvbA3AV+2E8YAdY4YTDf7g6eQhnvvmq4GUQ/0VBGGvwa+uE18JgXJ5/
 w186kU5mkAYmmW3uY5ou0Ndcb71+w64+vHU48rZ0b7+/0zTdMytyVLtAdVN6U5KMjYzU=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1xG9w7-0008FO-Go for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 12 Oct 2026 06:55:05 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 0B852435EB;
 Mon, 12 Oct 2026 06:54:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D8EE1F0089B;
 Mon, 12 Oct 2026 06:54:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791788097;
 bh=ixUDbnCWgkzkbUHhz0JT3wyfuPZOPnsypnSoCMDlymM=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To;
 b=XF9e7QRx6Sen9F/WbCo4a24ZFzVhrP8Gh2uVb9hpH4V7N31/24z8FOE4QZgrJ2CPL
 Sy+YbTDvfl5vNRBUn5Y4VNKme4dqYynrl/jVlXCoqWwiBMQ2y8gzEkb0uIovf0ayJw
 1nJ5l78WUdsGeWHavbfdzXCR/mgQOKdskATDPXns+5uc5uf6SaNam4H35a+QWctdHV
 FJUv7xczl3IcHpiFmINBl1ML4Qq0aIKGEA7rBxJFfJA9YR42vkcIER/7Pv44NrSY9/
 Ti5NoOMb4lXz3Tf1GtUpWNy7d6IOuvhHuddL62xjeSUzodVlufs6eqGyxOR1j4nTo9
 zhvTCeI7PU8Rg==
Message-ID: <68543181-226a-4f83-a6eb-9b1f419ac707@kernel.org>
Date: Mon, 12 Oct 2026 14:54:51 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Nanzhe Zhao <zhaonanzhe@xiaomi.com>,
 linux-f2fs-devel@lists.sourceforge.net, Jaegeuk Kim <jaegeuk@kernel.org>
References: <20261009161224.4163796-1-zhaonanzhe@xiaomi.com>
 <20261009161224.4163796-7-zhaonanzhe@xiaomi.com>
Content-Language: en-US
In-Reply-To: <20261009161224.4163796-7-zhaonanzhe@xiaomi.com>
X-Headers-End: 1xG9w7-0008FO-Go
Subject: Re: [f2fs-dev] [PATCH v3 06/17] f2fs: account large folio dirty
 data at block granularity
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
> Originally inode->dirty_pages was accounted once per folio, but f2fs
> needs the counter to be accounted in blocks.
> 
> This introduces batch dirty page add/sub accounting; for a large folio
> the changed dirty page count is computed from the dirty bitmap bit
> changes.
> 
> Found by f2fs/006 (lfs + checkpoint=disable) and generic/363.
> 
> Signed-off-by: Nanzhe Zhao <zhaonanzhe@xiaomi.com>
> ---
>   fs/f2fs/checkpoint.c | 38 ++++++++++++++++++++++----
>   fs/f2fs/data.c       | 24 ++++++++++++----
>   fs/f2fs/f2fs.h       | 65 ++++++++++++++++++++++++++++++++++----------
>   3 files changed, 101 insertions(+), 26 deletions(-)
> 
> diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
> index 81c1c2de936f..49075c840c61 100644
> --- a/fs/f2fs/checkpoint.c
> +++ b/fs/f2fs/checkpoint.c
> @@ -1316,20 +1316,46 @@ static void __remove_dirty_inode(struct inode *inode, enum inode_type type)
>   	stat_dec_dirty_inode(F2FS_I_SB(inode), type);
>   }
>   
> -void f2fs_update_dirty_folio(struct inode *inode, struct folio *folio)
> +/*
> + * Account @nr dirty pages (negative when dirtiness is cleared) for @inode.
> + */
> +void f2fs_account_dirty_pages(struct inode *inode, int nr)

How about f2fs_account_dirty_blocks() to match your commit title?

>   {
>   	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
>   	enum inode_type type = S_ISDIR(inode->i_mode) ? DIR_INODE : FILE_INODE;
>   
> -	if (!S_ISDIR(inode->i_mode) && !S_ISREG(inode->i_mode) &&
> -			!S_ISLNK(inode->i_mode))
> +	if (!nr)
>   		return;
>   
>   	spin_lock(&sbi->inode_lock[type]);
> -	if (type != FILE_INODE || test_opt(sbi, DATA_FLUSH))
> -		__add_dirty_inode(inode, type);
> -	inode_inc_dirty_pages(inode);
> +	if (nr > 0) {
> +		if (type != FILE_INODE || test_opt(sbi, DATA_FLUSH))
> +			__add_dirty_inode(inode, type);
> +		inode_inc_dirty_pages_nr(inode, nr);
> +	} else {
> +		inode_dec_dirty_pages_nr(inode, -nr);
> +		__remove_dirty_inode(inode, type);
> +	}
>   	spin_unlock(&sbi->inode_lock[type]);
> +}
> +
> +void f2fs_update_dirty_folio(struct inode *inode, struct folio *folio)
> +{
> +	if (!S_ISDIR(inode->i_mode) && !S_ISREG(inode->i_mode) &&
> +			!S_ISLNK(inode->i_mode))
> +		return;
> +
> +	/*
> +	 * Large folios have a subpage dirty bitmap, so defer their dirty accounting
> +	 * to the f2fs_ffs_*subrange_dirty*() helpers.  This avoids nesting
> +	 * ffs->state_lock with the inode dirty list lock.
> +	 */
> +	if (f2fs_folio_has_ffs(folio)) {
> +		folio_set_f2fs_reference(folio);
> +		return;
> +	}
> +
> +	f2fs_account_dirty_pages(inode, 1);
>   
>   	folio_set_f2fs_reference(folio);
>   }
> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> index da388ed9cccc..d45fbe0db161 100644
> --- a/fs/f2fs/data.c
> +++ b/fs/f2fs/data.c
> @@ -2902,6 +2902,7 @@ void f2fs_ffs_mark_subrange_dirty(struct folio *folio,
>   				    size_t offset, size_t len)
>   {
>   	struct f2fs_folio_state *ffs;
> +	unsigned int set;
>   	unsigned long flags;
>   
>   	f2fs_bug_on(F2FS_F_SB(folio), offset + len > folio_size(folio));
> @@ -2912,21 +2913,27 @@ void f2fs_ffs_mark_subrange_dirty(struct folio *folio,
>   	ffs = (struct f2fs_folio_state *)folio->private;
>   
>   	spin_lock_irqsave(&ffs->state_lock, flags);
> -	__ffs_mark_subrange_dirty(folio, ffs, offset, len);
> +	set = __ffs_mark_subrange_dirty(folio, ffs, offset, len);
>   	spin_unlock_irqrestore(&ffs->state_lock, flags);
> +
> +	if (set)
> +		f2fs_account_dirty_pages(folio->mapping->host, set);
>   }
>   
>   static bool __ffs_clear_subrange_dirty(struct folio *folio,
> -			struct f2fs_folio_state *ffs, size_t offset, size_t len)
> +			struct f2fs_folio_state *ffs, size_t offset, size_t len,
> +			unsigned int *cleared)
>   {
>   	unsigned int nr_subpages = folio_nr_pages(folio);
> -	unsigned int start, end;
> +	unsigned int start, end, before;
>   
>   	start = offset >> PAGE_SHIFT;
>   	end = (offset + len + PAGE_SIZE - 1) >> PAGE_SHIFT;
>   	end = min(end, nr_subpages);
>   
> +	before = bitmap_weight(ffs->state, 2 * nr_subpages);
>   	bitmap_clear(ffs->state, nr_subpages + start, end - start);
> +	*cleared = before - bitmap_weight(ffs->state, 2 * nr_subpages);
>   	return find_next_bit(ffs->state, 2 * nr_subpages, nr_subpages) <
>   			2 * nr_subpages;
>   }
> @@ -2938,13 +2945,15 @@ static bool __ffs_clear_subrange_dirty(struct folio *folio,
>    * @len: byte length of the subrange
>    *
>    * Clear the dirty bits of the 4K subpages covered by [offset, offset + len),
> - * and return whether the folio still has any dirty subpage left.
> + * account the cleared subpages against the inode dirty counters, and return
> + * whether the folio still has any dirty subpage left.
>    */
>   bool f2fs_ffs_clear_subrange_dirty_and_test(struct folio *folio, size_t offset,
>   					    size_t len)
>   {
>   	struct f2fs_folio_state *ffs;
>   	unsigned long flags;
> +	unsigned int cleared = 0;
>   	bool dirty;
>   
>   	if (!f2fs_folio_has_ffs(folio))
> @@ -2952,9 +2961,12 @@ bool f2fs_ffs_clear_subrange_dirty_and_test(struct folio *folio, size_t offset,
>   
>   	ffs = (struct f2fs_folio_state *)folio->private;
>   	spin_lock_irqsave(&ffs->state_lock, flags);
> -	dirty = __ffs_clear_subrange_dirty(folio, ffs, offset, len);
> +	dirty = __ffs_clear_subrange_dirty(folio, ffs, offset, len, &cleared);
>   	spin_unlock_irqrestore(&ffs->state_lock, flags);
>   
> +	if (cleared)
> +		f2fs_account_dirty_pages(folio->mapping->host, -cleared);
> +
>   	return dirty;
>   }
>   
> @@ -4319,7 +4331,7 @@ static int f2fs_write_cache_folios(struct address_space *mapping,
>   		if (f2fs_ffs_clear_subrange_dirty_and_test(folio, 0,
>   					(err ? pos : end_pos) - folio_pos(folio)))
>   			folio_redirty_for_writepage(wbc, folio);
> -		else
> +		else if (!f2fs_folio_has_ffs(folio))
>   			inode_dec_dirty_pages(inode);
>   
>   		if (bias_added) {
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index e14275f98fe7..2cf98f49c876 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -2916,9 +2916,10 @@ static inline void dec_valid_block_count(struct f2fs_sb_info *sbi,
>   	f2fs_i_blocks_write(inode, count, false, true);
>   }
>   
> -static inline void inc_cache_count(struct f2fs_sb_info *sbi, int count_type)
> +static inline void inc_cache_count_nr(struct f2fs_sb_info *sbi,

add_cache_counts()

> +					int count_type, int nr)
>   {
> -	atomic_inc(&sbi->nr_caches[count_type]);
> +	atomic_add(nr, &sbi->nr_caches[count_type]);
>   
>   	if (count_type == F2FS_DIRTY_DENTS ||
>   			count_type == F2FS_DIRTY_NODES ||
> @@ -2928,31 +2929,66 @@ static inline void inc_cache_count(struct f2fs_sb_info *sbi, int count_type)
>   		set_sbi_flag(sbi, SBI_IS_DIRTY);
>   }
>   
> -static inline void inode_inc_dirty_pages(struct inode *inode)
> +static inline void dec_cache_count_nr(struct f2fs_sb_info *sbi,

sub_cache_counts()

> +					int count_type, int nr)
>   {
> -	atomic_inc(&F2FS_I(inode)->dirty_pages);
> -	inc_cache_count(F2FS_I_SB(inode), S_ISDIR(inode->i_mode) ?
> -				F2FS_DIRTY_DENTS : F2FS_DIRTY_DATA);
> -	if (IS_NOQUOTA(inode))
> -		inc_cache_count(F2FS_I_SB(inode), F2FS_DIRTY_QDATA);
> +	atomic_sub(nr, &sbi->nr_caches[count_type]);
> +}
> +
> +static inline void inc_cache_count(struct f2fs_sb_info *sbi, int count_type)
> +{
> +	inc_cache_count_nr(sbi, count_type, 1);
>   }
>   
>   static inline void dec_cache_count(struct f2fs_sb_info *sbi, int count_type)
>   {
> -	atomic_dec(&sbi->nr_caches[count_type]);
> +	dec_cache_count_nr(sbi, count_type, 1);
>   }
>   
> -static inline void inode_dec_dirty_pages(struct inode *inode)
> +/*
> + * Account @nr dirty pages for @inode; one page is
> + * (PAGE_SIZE >> log_blocksize) filesystem blocks.
> + */
> +static inline void inode_inc_dirty_pages_nr(struct inode *inode, int nr)

inode_add_dirty_blocks()

> +{
> +	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
> +	int blocks = nr * (PAGE_SIZE >> sbi->log_blocksize);
> +

    	if (!S_ISDIR(inode->i_mode) && !S_ISREG(inode->i_mode) &&
    			!S_ISLNK(inode->i_mode))
    		return;

> +	atomic_add(blocks, &F2FS_I(inode)->dirty_pages);
> +	if (S_ISDIR(inode->i_mode))
> +		inc_cache_count_nr(sbi, F2FS_DIRTY_DENTS, blocks);
> +	else
> +		inc_cache_count_nr(sbi, F2FS_DIRTY_DATA, blocks);
> +	if (IS_NOQUOTA(inode))
> +		inc_cache_count_nr(sbi, F2FS_DIRTY_QDATA, blocks);
> +}
> +
> +static inline void inode_dec_dirty_pages_nr(struct inode *inode, int nr)

inode_sub_dirty_blocks()

>   {
> +	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
> +	int blocks = nr * (PAGE_SIZE >> sbi->log_blocksize);
> +
>   	if (!S_ISDIR(inode->i_mode) && !S_ISREG(inode->i_mode) &&
>   			!S_ISLNK(inode->i_mode))
>   		return;
>   
> -	atomic_dec(&F2FS_I(inode)->dirty_pages);
> -	dec_cache_count(F2FS_I_SB(inode), S_ISDIR(inode->i_mode) ?
> -				F2FS_DIRTY_DENTS : F2FS_DIRTY_DATA);
> +	atomic_sub(blocks, &F2FS_I(inode)->dirty_pages);
> +	if (S_ISDIR(inode->i_mode))
> +		dec_cache_count_nr(sbi, F2FS_DIRTY_DENTS, blocks);
> +	else
> +		dec_cache_count_nr(sbi, F2FS_DIRTY_DATA, blocks);
>   	if (IS_NOQUOTA(inode))
> -		dec_cache_count(F2FS_I_SB(inode), F2FS_DIRTY_QDATA);
> +		dec_cache_count_nr(sbi, F2FS_DIRTY_QDATA, blocks);
> +}
> +
> +static inline void inode_inc_dirty_pages(struct inode *inode)

inode_inc_dirty_block()

> +{
> +	inode_inc_dirty_pages_nr(inode, 1);
> +}
> +
> +static inline void inode_dec_dirty_pages(struct inode *inode)

inode_dec_dirty_block()

> +{
> +	inode_dec_dirty_pages_nr(inode, 1);
>   }
>   
>   static inline void inc_atomic_write_cnt(struct inode *inode)
> @@ -4380,6 +4416,7 @@ void f2fs_remove_orphan_inode(struct f2fs_sb_info *sbi, nid_t ino);
>   int f2fs_recover_orphan_inodes(struct f2fs_sb_info *sbi);
>   int f2fs_get_valid_checkpoint(struct f2fs_sb_info *sbi);
>   void f2fs_update_dirty_folio(struct inode *inode, struct folio *folio);
> +void f2fs_account_dirty_pages(struct inode *inode, int nr);
>   void f2fs_remove_dirty_inode(struct inode *inode);
>   int f2fs_sync_dirty_inodes(struct f2fs_sb_info *sbi, enum inode_type type,
>   								bool from_cp);



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
