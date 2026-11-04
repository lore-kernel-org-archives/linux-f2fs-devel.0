Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07D9B606A328
	for <linux-f2fs-devel@archiver.kernel.org>; Wed,  4 Nov 2026 11:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=EWSzUj8L;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=Fh8uNcc0;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=VKExhaRY;
	dkim=neutral header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ItNIRzeU
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=O+u8Advq2TWUZ7l73PQqJV+jJhpg0zbHijCQ+VSdNwo=; b=EWSzUj8LQ2lkiJ
	X+Nb5mCT+wH9Lyx54Fz4fOYpEN8W211gKp5Gh9SeMQwZw6lOCvimrQRtcoZ04z4+VSJr3Blq32j0b
	3WzOA5Y2ZiMCXfFheGYkME2HzYvT6ogRqtfVDpEpKbR6FIRjlIoCEiTXmll8Wx3mceuwyEnd1ss3M
	LxQ=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xOYva-000000007yU-272Z;
	Wed, 04 Nov 2026 11:13:14 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <chao@kernel.org>) id 1xOYvZ-000000007yO-2CPS
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 04 Nov 2026 11:13:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=vyZpc5+vZeCU+0YbT+Y0OwhtiWtaEkOrtE7aWiCWgK4=; b=Fh8uNcc0Pijs+S2K4hqzljgUsQ
 k0wG4bz7InDICtoDjQwmMAUMK+UL/tXLpcE6KEQfPrFR+QxPEqCfSYl1GVQTOf4Bjim7S4GO4guKy
 ya8UBAYnPdKLP0/BMUSFcNshtKlwTHUffcYMtHsTXm4S6g/OLVwAXcJljnhpSipq1ks8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=vyZpc5+vZeCU+0YbT+Y0OwhtiWtaEkOrtE7aWiCWgK4=; b=VKExhaRYYxzsvRIisgx9ZYAtEv
 +FuPmjxr6iWyX/t3IPwjdnA/wqXwHoQMDLlJuiSZydis+cBtGGb7eiJt+rvfT5ZB1Qx1FKmGNSyVx
 Q0MriwV2H3rS1rKqOcY4xRiK1SD4gIeIOEQlVSiAWaiN5PCPpfJyzREnhnIQT7Q6BYhM=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xOYvY-000000000PY-1iRL
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 04 Nov 2026 11:13:13 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id B19D560F2D;
 Wed,  4 Nov 2026 11:13:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 644FD1F000C1;
 Wed,  4 Nov 2026 11:13:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793790786;
 bh=vyZpc5+vZeCU+0YbT+Y0OwhtiWtaEkOrtE7aWiCWgK4=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To;
 b=ItNIRzeUCfLh7VLRjA7RqFdH2THL2WsDuFALEBn1ViJ/UAmrzrjvuVduLgaHG9UGD
 uLU7WrNMUrT8YZfIh/atL8ivqynj7BZJ4urPCLUr4hKCSRxem9IO8hBAzFh32CZYWD
 lQUzMZgh6Uvb21AH9q5E/YEeZZ2p8GjqFgJaHcJW2IlxDjiiywIm+mGGv0ZL1VYrjV
 +JM6pFnC6/RDh+GId69/Dim7/bfPjAX43zGioDxgZsNbk2m/9hdfn+wvRc26nB69oZ
 1HX/uYRTV+TdqXNOvrA94drCkaDn8eUmTPnL6BEel7abtzvA+Iv063SsLiDPIzx9Cc
 WCll3/KlTeDDw==
Message-ID: <37b8dccd-f15f-4f19-b07a-db6b04b627a1@kernel.org>
Date: Wed, 4 Nov 2026 19:13:03 +0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Daeho Jeong <daeho43@gmail.com>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
References: <20261102193952.3002018-1-daeho43@gmail.com>
 <20261102193952.3002018-5-daeho43@gmail.com>
Content-Language: en-US
In-Reply-To: <20261102193952.3002018-5-daeho43@gmail.com>
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xOYvY-000000000PY-1iRL
Subject: Re: [f2fs-dev] [PATCH 04/20] f2fs: support subpage blocks in
 directory operations
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
Cc: Daeho Jeong <daehojeong@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-17.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/3/26 03:39, Daeho Jeong wrote:
> From: Daeho Jeong <daehojeong@google.com>
> 
> With subpage blocks, a directory folio holds several dentry blocks.
> Address a dentry block within its folio by its block index, and mark
> only the modified dentry block dirty. When an empty dentry block is
> freed, clear only the state of that block and keep the folio dirty if
> other blocks in it are still dirty.
> 
> Signed-off-by: Daeho Jeong <daehojeong@google.com>
> ---
>  fs/f2fs/dir.c    | 120 +++++++++++++++++++++++++++++++++--------------
>  fs/f2fs/f2fs.h   |   2 +
>  fs/f2fs/inline.c |   6 +--
>  3 files changed, 89 insertions(+), 39 deletions(-)
> 
> diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
> index 3eb0b7255951..aa3511c6f8fe 100644
> --- a/fs/f2fs/dir.c
> +++ b/fs/f2fs/dir.c
> @@ -37,6 +37,31 @@ static inline bool f2fs_should_fallback_to_linear(struct inode *dir)
>  extern struct kmem_cache *f2fs_cf_name_slab;
>  #endif
>  
> +static inline pgoff_t f2fs_dentry_to_lblk(struct f2fs_sb_info *sbi,
> +					  struct folio *folio, void *de)
> +{
> +	size_t off = round_down((size_t)(de - folio_address(folio)),
> +				(size_t)F2FS_BLKSIZE(sbi));
> +
> +	return f2fs_folio_lblk(sbi, folio) + (off >> sbi->log_blocksize);

return f2fs_folio_lblk(sbi, folio) + F2FS_BYTES_TO_BLK(sbi, off);

> +}
> +
> +void f2fs_mark_dentry_folio_dirty(struct inode *dir, struct folio *folio,
> +				  pgoff_t bidx)
> +{
> +	struct f2fs_sb_info *sbi = F2FS_I_SB(dir);
> +
> +	if (f2fs_has_subpage_blocks(sbi)) {
> +		size_t off = f2fs_folio_byte_offset(sbi, folio, bidx);
> +
> +		f2fs_ffs_mark_subrange_uptodate(folio, off, F2FS_BLKSIZE(sbi));
> +		f2fs_ffs_mark_subrange_dirty(folio, off, F2FS_BLKSIZE(sbi));
> +	} else if (!folio_test_uptodate(folio)) {
> +		folio_mark_uptodate(folio);
> +	}
> +	folio_mark_dirty(folio);
> +}
> +
>  static unsigned long dir_blocks(struct inode *inode)
>  {
>  	return F2FS_BYTES_TO_BLK(F2FS_I_SB(inode),
> @@ -190,15 +215,16 @@ static unsigned long dir_block_index(unsigned int level,
>  }
>  
>  static struct f2fs_dir_entry *find_in_block(struct inode *dir,
> -				struct folio *dentry_folio,
> +				struct folio *dentry_folio, pgoff_t bidx,
>  				const struct f2fs_filename *fname,
>  				int *max_slots,
>  				bool use_hash)
>  {
> +	struct f2fs_sb_info *sbi = F2FS_I_SB(dir);
>  	void *dentry_blk;
>  	struct f2fs_dentry_ptr d;
>  
> -	dentry_blk = folio_address(dentry_folio);
> +	dentry_blk = f2fs_folio_lblk_address(sbi, dentry_folio, bidx);
>  
>  	make_dentry_ptr_block(dir, &d, dentry_blk);
>  	return f2fs_find_target_dentry(&d, fname, max_slots, use_hash);
> @@ -289,7 +315,7 @@ static struct f2fs_dir_entry *find_in_level(struct inode *dir,
>  	unsigned int nbucket, nblock;
>  	unsigned int bidx, end_block, bucket_no;
>  	struct f2fs_dir_entry *de = NULL;
> -	pgoff_t next_pgofs;
> +	pgoff_t next_blkofs;
>  	bool room = false;
>  	int max_slots;
>  
> @@ -306,11 +332,11 @@ static struct f2fs_dir_entry *find_in_level(struct inode *dir,
>  	while (bidx < end_block) {
>  		/* no need to allocate new dentry pages to all the indices */
>  		struct folio *dentry_folio;
> -		dentry_folio = f2fs_find_data_folio(dir, bidx, &next_pgofs);
> +		dentry_folio = f2fs_find_data_folio(dir, bidx, &next_blkofs);
>  		if (IS_ERR(dentry_folio)) {
>  			if (PTR_ERR(dentry_folio) == -ENOENT) {
>  				room = true;
> -				bidx = next_pgofs;
> +				bidx = next_blkofs;
>  				continue;
>  			} else {
>  				*dentry_block = dentry_folio;
> @@ -318,7 +344,8 @@ static struct f2fs_dir_entry *find_in_level(struct inode *dir,
>  			}
>  		}
>  
> -		de = find_in_block(dir, dentry_folio, fname, &max_slots, use_hash);
> +		de = find_in_block(dir, dentry_folio, bidx, fname, &max_slots,
> +				   use_hash);
>  		if (IS_ERR(de)) {
>  			f2fs_folio_put(dentry_folio, false);
>  			*dentry_block = ERR_CAST(de);
> @@ -354,7 +381,7 @@ struct f2fs_dir_entry *__f2fs_find_entry(struct inode *dir,
>  					 const struct f2fs_filename *fname,
>  					 void **dentry_block)
>  {
> -	unsigned long npages = dir_blocks(dir);
> +	unsigned long nblocks = dir_blocks(dir);
>  	struct f2fs_dir_entry *de = NULL;
>  	unsigned int max_depth;
>  	unsigned int level;
> @@ -370,7 +397,7 @@ struct f2fs_dir_entry *__f2fs_find_entry(struct inode *dir,
>  		goto out;
>  	}
>  
> -	if (npages == 0)
> +	if (nblocks == 0)
>  		goto out;
>  
>  	max_depth = F2FS_I(dir)->i_current_depth;
> @@ -468,7 +495,8 @@ void f2fs_set_link(struct inode *dir, struct f2fs_dir_entry *de,
>  		f2fs_folio_wait_writeback(folio, true, true);
>  		de->ino = cpu_to_le32(inode->i_ino);
>  		de->file_type = fs_umode_to_ftype(inode->i_mode);
> -		folio_mark_dirty(folio);
> +		f2fs_mark_dentry_folio_dirty(dir, folio,
> +				f2fs_dentry_to_lblk(F2FS_I_SB(dir), folio, de));
>  	}
>  
>  	inode_set_mtime_to_ts(dir, inode_set_ctime_current(dir));
> @@ -539,12 +567,12 @@ static int make_empty_dir(struct inode *inode,
>  	if (IS_ERR(dentry_folio))
>  		return PTR_ERR(dentry_folio);
>  
> -	dentry_blk = folio_address(dentry_folio);
> +	dentry_blk = f2fs_folio_lblk_address(F2FS_I_SB(inode), dentry_folio, 0);
>  
>  	make_dentry_ptr_block(inode, &d, dentry_blk);
>  	f2fs_do_make_empty_dir(inode, parent, &d);
>  
> -	folio_mark_dirty(dentry_folio);
> +	f2fs_mark_dentry_folio_dirty(inode, dentry_folio, 0);
>  	f2fs_folio_put(dentry_folio, true);
>  	return 0;
>  }
> @@ -737,7 +765,8 @@ int f2fs_add_regular_entry(struct inode *dir, const struct f2fs_filename *fname,
>  		if (IS_ERR(dentry_folio))
>  			return PTR_ERR(dentry_folio);
>  
> -		dentry_blk = folio_address(dentry_folio);
> +		dentry_blk = f2fs_folio_lblk_address(F2FS_I_SB(dir),
> +						     dentry_folio, block);
>  		make_dentry_ptr_block(dir, &d, dentry_blk);
>  		bit_pos = f2fs_room_for_filename(d.bitmap, slots, d.max);
>  		if (bit_pos < d.max)
> @@ -764,7 +793,7 @@ int f2fs_add_regular_entry(struct inode *dir, const struct f2fs_filename *fname,
>  	f2fs_update_dentry(ino, mode, &d, &fname->disk_name, fname->hash,
>  			   bit_pos);
>  
> -	folio_mark_dirty(dentry_folio);
> +	f2fs_mark_dentry_folio_dirty(dir, dentry_folio, block);
>  
>  	if (inode) {
>  		f2fs_i_pino_write(inode, dir->i_ino);
> @@ -902,25 +931,28 @@ void f2fs_delete_entry(struct f2fs_dir_entry *dentry, void *dentry_block,
>  	struct folio *folio;
>  	unsigned int bit_pos;
>  	int slots = GET_DENTRY_SLOTS(le16_to_cpu(dentry->name_len));
> +	struct f2fs_sb_info *sbi = F2FS_I_SB(dir);
> +	size_t block_offset;
>  	pgoff_t index;
>  	int i;
>  
> -	f2fs_update_time(F2FS_I_SB(dir), REQ_TIME);
> +	f2fs_update_time(sbi, REQ_TIME);
>  
> -	if (F2FS_OPTION(F2FS_I_SB(dir)).fsync_mode == FSYNC_MODE_STRICT)
> -		f2fs_add_ino_entry(F2FS_I_SB(dir), dir->i_ino, TRANS_DIR_INO);
> +	if (F2FS_OPTION(sbi).fsync_mode == FSYNC_MODE_STRICT)
> +		f2fs_add_ino_entry(sbi, dir->i_ino, TRANS_DIR_INO);
>  
>  	if (f2fs_has_inline_dentry(dir))
>  		return f2fs_delete_inline_entry(dentry,
>  				f2fs_dentry_cache(dentry_block), dir, inode);
>  
>  	folio = f2fs_dentry_folio(dentry_block);
> -	index = folio->index;
>  
>  	folio_lock(folio);
>  	f2fs_folio_wait_writeback(folio, true, true);
>  
> -	dentry_blk = folio_address(folio);
> +	index = f2fs_dentry_to_lblk(sbi, folio, dentry);
> +	block_offset = f2fs_folio_byte_offset(sbi, folio, index);
> +	dentry_blk = folio_address(folio) + block_offset;

Use f2fs_folio_lblk_address() for cleanup?

Thanks,

>  	make_dentry_ptr_block(dir, &d, dentry_blk);
>  	bit_pos = dentry - d.dentry;
>  	for (i = 0; i < slots; i++)
> @@ -928,18 +960,31 @@ void f2fs_delete_entry(struct f2fs_dir_entry *dentry, void *dentry_block,
>  
>  	/* Let's check and deallocate this dentry page */
>  	bit_pos = find_next_bit_le(d.bitmap, d.max, 0);
> -	folio_mark_dirty(folio);
> +	f2fs_mark_dentry_folio_dirty(dir, folio, index);
>  
>  	if (bit_pos == d.max &&
>  	    !f2fs_truncate_hole(dir, index, index + 1)) {
> +		if (f2fs_has_subpage_blocks(sbi)) {
> +			bool dirty;
> +
> +			dirty = f2fs_ffs_clear_subrange_dirty_and_test(folio,
> +					block_offset, F2FS_BLKSIZE(sbi));
> +			f2fs_ffs_clear_subrange_uptodate(folio, block_offset,
> +							 F2FS_BLKSIZE(sbi));
> +			if (dirty)
> +				goto keep_dirty;
> +		}
>  		f2fs_clear_page_cache_dirty_tag(folio);
>  		folio_clear_dirty_for_io(folio);
> -		folio_clear_uptodate(folio);
> -		folio_detach_private(folio);
> +		if (!f2fs_has_subpage_blocks(sbi)) {
> +			folio_clear_uptodate(folio);
> +			folio_detach_private(folio);
> +			inode_dec_dirty_block(dir);
> +		}
>  
> -		inode_dec_dirty_block(dir);
>  		f2fs_remove_dirty_inode(dir);
>  	}
> +keep_dirty:
>  	f2fs_folio_put(folio, true);
>  
>  	inode_set_mtime_to_ts(dir, inode_set_ctime_current(dir));
> @@ -961,20 +1006,21 @@ bool f2fs_empty_dir(struct inode *dir)
>  		return f2fs_empty_inline_dir(dir);
>  
>  	while (bidx < nblock) {
> -		pgoff_t next_pgofs;
> +		pgoff_t next_blkofs;
>  		struct folio *dentry_folio;
>  
> -		dentry_folio = f2fs_find_data_folio(dir, bidx, &next_pgofs);
> +		dentry_folio = f2fs_find_data_folio(dir, bidx, &next_blkofs);
>  		if (IS_ERR(dentry_folio)) {
>  			if (PTR_ERR(dentry_folio) == -ENOENT) {
> -				bidx = next_pgofs;
> +				bidx = next_blkofs;
>  				continue;
>  			} else {
>  				return false;
>  			}
>  		}
>  
> -		dentry_blk = folio_address(dentry_folio);
> +		dentry_blk = f2fs_folio_lblk_address(F2FS_I_SB(dir),
> +						     dentry_folio, bidx);
>  		make_dentry_ptr_block(dir, &d, dentry_blk);
>  		if (bidx == 0)
>  			bit_pos = 2;
> @@ -1080,7 +1126,7 @@ int f2fs_fill_dentries(struct dir_context *ctx, struct f2fs_dentry_ptr *d,
>  static int f2fs_readdir(struct file *file, struct dir_context *ctx)
>  {
>  	struct inode *inode = file_inode(file);
> -	unsigned long npages = dir_blocks(inode);
> +	unsigned long nblocks = dir_blocks(inode);
>  	void *dentry_blk = NULL;
>  	struct file_ra_state *ra = &file->f_ra;
>  	loff_t start_pos = ctx->pos;
> @@ -1089,6 +1135,8 @@ static int f2fs_readdir(struct file *file, struct dir_context *ctx)
>  	unsigned int n = (unsigned long)ctx->pos / entries;
>  	struct f2fs_dentry_ptr d;
>  	struct fscrypt_str fstr = FSTR_INIT(NULL, 0);
> +	pgoff_t f_last = nblocks ? f2fs_lblk_to_folio_index(sbi, nblocks - 1) : 0;
> +	pgoff_t f_index, ra_pages;
>  	int err = 0;
>  
>  	if (IS_ENCRYPTED(inode)) {
> @@ -1106,9 +1154,9 @@ static int f2fs_readdir(struct file *file, struct dir_context *ctx)
>  		goto out_free;
>  	}
>  
> -	for (; n < npages; ctx->pos = n * entries) {
> +	for (; n < nblocks; ctx->pos = n * entries) {
>  		struct folio *dentry_folio;
> -		pgoff_t next_pgofs;
> +		pgoff_t next_blkofs;
>  
>  		/* allow readdir() to be interrupted */
>  		if (fatal_signal_pending(current)) {
> @@ -1118,23 +1166,25 @@ static int f2fs_readdir(struct file *file, struct dir_context *ctx)
>  		cond_resched();
>  
>  		/* readahead for multi pages of dir */
> -		if (npages - n > 1 && !ra_has_index(ra, n))
> -			page_cache_sync_readahead(inode->i_mapping, ra, file, n,
> -				min(npages - n, (pgoff_t)MAX_DIR_RA_PAGES));
> +		f_index = f2fs_lblk_to_folio_index(sbi, n);
> +		ra_pages = f_last - f_index + 1;
> +		if (nblocks - n > 1 && !ra_has_index(ra, f_index))
> +			page_cache_sync_readahead(inode->i_mapping, ra, file, f_index,
> +				min(ra_pages, (pgoff_t)MAX_DIR_RA_PAGES));
>  
> -		dentry_folio = f2fs_find_data_folio(inode, n, &next_pgofs);
> +		dentry_folio = f2fs_find_data_folio(inode, n, &next_blkofs);
>  		if (IS_ERR(dentry_folio)) {
>  			err = PTR_ERR(dentry_folio);
>  			if (err == -ENOENT) {
>  				err = 0;
> -				n = next_pgofs;
> +				n = next_blkofs;
>  				continue;
>  			} else {
>  				goto out_free;
>  			}
>  		}
>  
> -		dentry_blk = folio_address(dentry_folio);
> +		dentry_blk = f2fs_folio_lblk_address(sbi, dentry_folio, n);
>  
>  		make_dentry_ptr_block(inode, &d, dentry_blk);
>  
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index 114d3d7bcd3e..3822824326d7 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -4193,6 +4193,8 @@ void f2fs_delete_entry(struct f2fs_dir_entry *dentry, void *dentry_blk,
>  int f2fs_do_tmpfile(struct inode *inode, struct inode *dir,
>  					struct f2fs_filename *fname);
>  bool f2fs_empty_dir(struct inode *dir);
> +void f2fs_mark_dentry_folio_dirty(struct inode *dir, struct folio *folio,
> +				  pgoff_t bidx);
>  
>  static inline int f2fs_add_link(struct dentry *dentry, struct inode *inode)
>  {
> diff --git a/fs/f2fs/inline.c b/fs/f2fs/inline.c
> index 49905aa08418..ba0aff8e5643 100644
> --- a/fs/f2fs/inline.c
> +++ b/fs/f2fs/inline.c
> @@ -463,10 +463,6 @@ static int f2fs_move_inline_dirents(struct inode *dir,
>  	memcpy(dst.dentry, src.dentry, SIZE_OF_DIR_ENTRY * src.max);
>  	memcpy(dst.filename, src.filename, src.max * F2FS_SLOT_LEN);
>  
> -	if (!folio_test_uptodate(folio))
> -		folio_mark_uptodate(folio);
> -	folio_mark_dirty(folio);
> -
>  	/* clear inline dir and flag after data writeback */
>  	f2fs_truncate_inline_inode(dir, ientry, 0);
>  
> @@ -484,6 +480,8 @@ static int f2fs_move_inline_dirents(struct inode *dir,
>  	f2fs_i_depth_write(dir, 1);
>  	if (i_size_read(dir) < F2FS_BLKSIZE(F2FS_I_SB(dir)))
>  		f2fs_i_size_write(dir, F2FS_BLKSIZE(F2FS_I_SB(dir)));
> +
> +	f2fs_mark_dentry_folio_dirty(dir, folio, 0);
>  out:
>  	f2fs_folio_put(folio, true);
>  	return err;



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
