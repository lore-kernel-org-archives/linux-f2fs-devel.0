Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 234D0CA9ED5
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 12 Oct 2026 07:27:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Content-Transfer-Encoding:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=VwtGItI0nzI6AX6sqjY6aJrxqfZWcQVBiTUdSQKSYM8=; b=P5aK+pSihLA2U6kDMc3LGIE4UG
	tCP5j3vW+QAex98HwCmUU1m0NOqaiyYFQ8nfJIMczhRvmC+m0kWHKBgbj8hM+78ZICEWwbOgpPB87
	Je4s5lLsyYAmzoX/CMN5pXJv8mmoPe3M447ialxcmfVnffr15N5GXdwy4jdoOPwtFFt8=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xGARk-00027N-N3;
	Mon, 12 Oct 2026 07:27:42 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1xGARj-00027F-F9
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 12 Oct 2026 07:27:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=O5Crrv7QmlSOOQ+tSXEhOnpQY4JCzNlOfvWo98Zq/n8=; b=ejS79uIjAy+9Dra+et7d7hRLFg
 coDBuGRhMJHXy/XBQly1SJNZUUY6Yp1BkHuSzTCkEBwF7KCIxa0BPnbLhYPtseC72UqLnFTEptn24
 0iW6x4ckltuM/6XHz/HEsbGOpZh7cMZR0sVGP4Xj7S2/ysnzxFL+OXnJ3P0GcQpqIg+o=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=O5Crrv7QmlSOOQ+tSXEhOnpQY4JCzNlOfvWo98Zq/n8=; b=P3we4X/koorSwJWLVOEvbOg4MF
 YOLK3WWwk9zQi/o7jvZzZu6VooUaeZAlSaok7K23GPOU2DaieUMHfskGLUrfsuxmi9qVdikAtoCOO
 5sIH7o3NqCqXSZIu4cCmfAgIB2hXhSo5jOn5zHiXdfx49hLQUPfW61jUYyEkdWiinQyo=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1xGARf-0000fG-Bv for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 12 Oct 2026 07:27:40 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id BCD254327F;
 Mon, 12 Oct 2026 07:27:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 135291F0089B;
 Mon, 12 Oct 2026 07:27:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791790053;
 bh=O5Crrv7QmlSOOQ+tSXEhOnpQY4JCzNlOfvWo98Zq/n8=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To;
 b=TZJHjSNaS5Tj814nGWGzmdULqUOC3VVlQf2k5snDlPZNQCKQxEuaTNFq9IVorlnT1
 HzON+uHvzXwUfadtC/LkZJk7/+ogsAWDVOV9vZqtc/EjTBTFuKnzK1T6m7eHm0ezt4
 7SXrQ45I4LtgsBmBzIT9skRwvYq9SQTsiCtN6n9S5voM95zwYNEAJX3jtdE6toA+bz
 O+36BmuGwLHacd+GKW/QW78K+WblDwJOoboGqhAgEbuFngIhq4T54omRGsjXo8j6A4
 eIJLjw4nUy0p29I+dzLvOFfdWH/MgETlagSjg0BjJi4MV6rUsL6PPRdyMD9QJqqCn2
 6fmxZlA4YkP5w==
Message-ID: <1b2831dc-8d8a-4216-811e-22396fc9e35d@kernel.org>
Date: Mon, 12 Oct 2026 15:27:27 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Nanzhe Zhao <zhaonanzhe@xiaomi.com>,
 linux-f2fs-devel@lists.sourceforge.net, Jaegeuk Kim <jaegeuk@kernel.org>
References: <20261009161224.4163796-1-zhaonanzhe@xiaomi.com>
 <20261009162828.4188050-2-zhaonanzhe@xiaomi.com>
Content-Language: en-US
In-Reply-To: <20261009162828.4188050-2-zhaonanzhe@xiaomi.com>
X-Headers-End: 1xGARf-0000fG-Bv
Subject: Re: [f2fs-dev] [PATCH v3 12/17] f2fs: handle partial truncate of
 large folio dirty subpages
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

On 10/10/26 00:28, Nanzhe Zhao wrote:
> A large folio can be partial truncated and stays in folio mapping, we
> need to clear the subrange dirty bits and uptodate bits that the partial
> truncate covers. If this partial truncate happens to clear the last
> subrange dirty bits, then cancel the whole folio dirty state.
> 
> Also add a guard in f2fs_write_single_data_folio() so a large folio
> subpage whose disk block was already truncated (NULL_ADDR) is skipped
> 
> Signed-off-by: Nanzhe Zhao <zhaonanzhe@xiaomi.com>
> ---
>   fs/f2fs/data.c | 115 ++++++++++++++++++++++++++++++++++++++++++++++---
>   1 file changed, 109 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> index 21c43019167a..138a77044e95 100644
> --- a/fs/f2fs/data.c
> +++ b/fs/f2fs/data.c
> @@ -329,6 +329,27 @@ static void f2fs_read_end_io(struct bio *bio)
>   	f2fs_verify_and_finish_bio(bio, intask);
>   }
>   
> +static bool f2fs_ffs_has_dirty_subpage(struct folio *folio)
> +{
> +	struct f2fs_folio_state *ffs;
> +	unsigned long flags;
> +	unsigned int nr_subpages;
> +	bool dirty;
> +
> +	if (!f2fs_folio_has_ffs(folio))
> +		return false;
> +
> +	ffs = (struct f2fs_folio_state *)folio->private;
> +	nr_subpages = folio_nr_pages(folio);
> +
> +	spin_lock_irqsave(&ffs->state_lock, flags);
> +	dirty = find_next_bit(ffs->state, 2 * nr_subpages,
> +				nr_subpages) < 2 * nr_subpages;
> +	spin_unlock_irqrestore(&ffs->state_lock, flags);
> +
> +	return dirty;
> +}
> +
>   static void f2fs_write_end_bio(struct bio *bio)
>   {
>   	struct f2fs_sb_info *sbi = bio->bi_private;
> @@ -380,7 +401,8 @@ static void f2fs_write_end_bio(struct bio *bio)
>   			wake_up(&sbi->cp_wait);
>   
>   		if (finished) {
> -			folio_clear_f2fs_gcing(folio);
> +			if (!f2fs_ffs_has_dirty_subpage(folio))
> +				folio_clear_f2fs_gcing(folio);
>   			folio_end_writeback(folio);
>   		}
>   	}
> @@ -2893,6 +2915,29 @@ static void f2fs_ffs_mark_subrange_uptodate(struct folio *folio, size_t offset,
>   		folio_mark_uptodate(folio);
>   }
>   
> +static void ffs_clear_subrange_uptodate(struct folio *folio,
> +					size_t offset, size_t len)
> +{
> +	struct f2fs_folio_state *ffs;
> +	unsigned int nr_subpages, start, end;
> +	unsigned long flags;
> +
> +	f2fs_bug_on(F2FS_F_SB(folio), offset + len > folio_size(folio));
> +
> +	if (!f2fs_folio_has_ffs(folio))
> +		return;
> +
> +	ffs = (struct f2fs_folio_state *)folio->private;
> +	nr_subpages = folio_nr_pages(folio);
> +	start = offset >> PAGE_SHIFT;
> +	end = (offset + len + PAGE_SIZE - 1) >> PAGE_SHIFT;
> +	end = min(end, nr_subpages);
> +
> +	spin_lock_irqsave(&ffs->state_lock, flags);
> +	bitmap_clear(ffs->state, start, end - start);
> +	spin_unlock_irqrestore(&ffs->state_lock, flags);
> +}
> +
>   bool f2fs_ffs_test_blk_dirty(const struct folio *folio, pgoff_t index)
>   {
>   	struct f2fs_folio_state *ffs;
> @@ -3771,12 +3816,35 @@ static int f2fs_write_folio_dirty_range(struct folio *folio, int *submitted,
>   
>   		err = f2fs_get_dnode_of_data(&dn, data_idx, LOOKUP_NODE);
>   
> +		/*
> +		 * If a subpage of folio for a cow file is dirtied but not
> +		 * reserve a cow block, fallback to original inode to lookup
> +		 * block address

writeback vs truncate on atomic file?

> +		 */
> +		if (atomic_commit && (err == -ENOENT ||
> +		    (!err && dn.data_blkaddr == NULL_ADDR))) {
> +			f2fs_put_dnode(&dn);
> +			set_new_dnode(&dn, inode, NULL, NULL, 0);
> +			err = f2fs_get_dnode_of_data(&dn, data_idx,
> +						     LOOKUP_NODE);
> +			/* Original inode has no block, handled as truncated below */
> +			if (err == -ENOENT)
> +				err = 0;
> +		}
>   		if (err)
>   			goto block_done;
>   		dn_held = true;
>   
>   		fio.old_blkaddr = dn.data_blkaddr;
>   
> +		/* This page is already truncated */
> +		if (fio.old_blkaddr == NULL_ADDR) {
> +			ffs_clear_subrange_uptodate(folio,
> +					(unsigned long long)i << PAGE_SHIFT,

(loff_t)i << PAGE_SHIFT,

Thanks,

> +					PAGE_SIZE);
> +			goto block_done;
> +		}
> +
>   got_it:
>   		if (__is_valid_data_blkaddr(fio.old_blkaddr) &&
>   		    !f2fs_is_valid_blkaddr(sbi, fio.old_blkaddr,
> @@ -4325,6 +4393,7 @@ static int f2fs_write_cache_folios(struct address_space *mapping,
>   		bool verity_in_progress;
>   		int folio_submitted = 0;
>   		bool bias_added = false;
> +		bool dirty;
>   
>   		submitted = 0;
>   		next = true;
> @@ -4432,15 +4501,19 @@ static int f2fs_write_cache_folios(struct address_space *mapping,
>   		 * partially written back), the folio must stay dirty so that
>   		 * the remaining subranges are written back later.
>   		 */
> -		if (f2fs_ffs_clear_subrange_dirty_and_test(folio, 0,
> -					(err ? pos : end_pos) - folio_pos(folio)))
> +		dirty = f2fs_ffs_clear_subrange_dirty_and_test(folio, 0,
> +					(err ? pos : end_pos) - folio_pos(folio));
> +		if (dirty)
>   			folio_redirty_for_writepage(wbc, folio);
>   		else if (!f2fs_folio_has_ffs(folio))
>   			inode_dec_dirty_pages(inode);
>   
>   		if (bias_added) {
> -			if (atomic_dec_and_test(&ffs->write_pages_pending))
> +			if (atomic_dec_and_test(&ffs->write_pages_pending)) {
> +				if (!dirty)
> +					folio_clear_f2fs_gcing(folio);
>   				folio_end_writeback(folio);
> +			}
>   		} else if (!folio_submitted && folio_test_writeback(folio)) {
>   			folio_end_writeback(folio);
>   		}
> @@ -5243,10 +5316,40 @@ void f2fs_invalidate_folio(struct folio *folio, size_t offset, size_t length)
>   	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
>   
>   	if (inode->i_ino >= F2FS_ROOT_INO(sbi) &&
> -				(offset || length != folio_size(folio)))
> +				(offset || length != folio_size(folio))) {
> +		size_t clear_start = round_up(offset, PAGE_SIZE);
> +		size_t clear_end = round_down(offset + length, PAGE_SIZE);
> +		size_t clear_length;
> +		bool dirty;
> +
> +		/*
> +		 * If the truncated range falls within a single subpage, no
> +		 * subpage state needs to be cleared.
> +		 */
> +		if (clear_start >= clear_end || !f2fs_folio_has_ffs(folio))
> +			return;
> +
> +		clear_length = clear_end - clear_start;
> +		dirty = f2fs_ffs_clear_subrange_dirty_and_test(folio,
> +						clear_start, clear_length);
> +		ffs_clear_subrange_uptodate(folio, clear_start, clear_length);
> +
> +		/*
> +		 * If the truncated subrange happens to clear the remaining
> +		 * dirty bitmap of the whole folio, cancel the folio-level
> +		 * dirty state.
> +		 */
> +		if (!dirty && folio_test_dirty(folio))
> +			folio_cancel_dirty(folio);
> +		if (!dirty && !folio_test_writeback(folio))
> +			folio_clear_f2fs_gcing(folio);
>   		return;
> +	}
>   
> -	if (folio_test_dirty(folio)) {
> +	if (f2fs_folio_has_ffs(folio)) {
> +		f2fs_ffs_clear_subrange_dirty_and_test(folio, 0,
> +							folio_size(folio));
> +	} else if (folio_test_dirty(folio)) {
>   		inode_dec_dirty_pages(inode);
>   		f2fs_remove_dirty_inode(inode);
>   	}



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
