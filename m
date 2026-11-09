Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0905C606A31C
	for <linux-f2fs-devel@archiver.kernel.org>; Mon,  9 Nov 2026 03:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=lAT5Q7BV;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=j4h9p0A3;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=NcpRGwz4;
	dkim=neutral header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eqYhmRZX
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Content-Transfer-Encoding:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=+F6edK/QqdnV75jRD1ttvZyVjd98heUidWPjkoVFdFY=; b=lAT5Q7BVUdOU4t
	3xXT0flAHrOvVQeYbW4/Y0SuznJfnoTSVhnsviSFWXWEN3x5AsrhGBR5ifhLJ1uQ9PNHDqvGtyAng
	SKphj97vIlBrKHf5oGBpCFwq0ogFFZwhCjDHbSTwg0GhYDbgmXwYOH/9Ne1QmmhXGH/2a9GxmBh17
	f/c=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xQFth-000000000xO-1dqB;
	Mon, 09 Nov 2026 03:18:17 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <chao@kernel.org>) id 1xQFtf-000000000xH-22pY
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 09 Nov 2026 03:18:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=WXlWHDUZdvRcJdaGkXE2tCCp1TJfdeXYbXIYIJVs0tA=; b=j4h9p0A3nIEDJU6ijHGYKz/+/k
 OEUR6OiHE+N5diSQMQ4ZULSfpUQbnDlSfX/Ub9vbNVkkoPkUHM50PDbzC6CrRHphq7OAxM78Zt1YL
 D071ZKFIExPfiBATnIjXd2yKbnM6IIVJD8QslzwKW+ho03qgSoBypWGnp0MISAszNjJY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=WXlWHDUZdvRcJdaGkXE2tCCp1TJfdeXYbXIYIJVs0tA=; b=NcpRGwz48WjKI3reBjyIsLmUNs
 K3vnCuDeRRQtbg3zqx+wlJlFTfz42Km2OM0elvd+WXFImIxcduWXuVg4yKMfm/ujRuK4L+M7tlC61
 f5JmYMsGFwHgiqRJb/dXbht7oB60LtrQL3k940Oi/zhlmmwJrAy6wGhkvdXP1yudzJ6U=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xQFte-000000008CM-3RUC
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 09 Nov 2026 03:18:15 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 6546C405B1;
 Mon,  9 Nov 2026 03:18:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 408BB1F0089F;
 Mon,  9 Nov 2026 03:18:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794194289;
 bh=WXlWHDUZdvRcJdaGkXE2tCCp1TJfdeXYbXIYIJVs0tA=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To;
 b=eqYhmRZXHXlheEs6f/1xIGsFp6mf+8alG+djq1BwnfS7i8ahEUmZOmXkyDnBPp7yN
 tLl6c0dsAD/Y2v2oK6sE/Dau3+Q/3FLoDZ3qGtDD1kTmaMLIEdn5p4ujwtYGtW1FLu
 JEJi1u5HMuolAce/SBKEBqwz+VvuB1erDG6WizvKlzREO7a+KfCTbcnMKQ1cIs16f5
 eDIWa2G9MqiLv6SpNgYcZPYilrVfeixFoS4cx+xAKwW41aYQNLJtAnk1Knpjpz9RGw
 xBriuvqWiTVqHIl/gbDCsv6ZxNzrjEco5UX+yMyJ2pxSj5qFyh3RMmnCGiesQOn/a2
 034T9GqRoddpw==
Message-ID: <610e99a6-c622-4a2e-9c6d-a57367994c42@kernel.org>
Date: Mon, 9 Nov 2026 11:18:06 +0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Daeho Jeong <daeho43@gmail.com>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
References: <20261102193952.3002018-1-daeho43@gmail.com>
 <20261102193952.3002018-17-daeho43@gmail.com>
Content-Language: en-US
In-Reply-To: <20261102193952.3002018-17-daeho43@gmail.com>
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xQFte-000000008CM-3RUC
Subject: Re: [f2fs-dev] [PATCH 16/20] f2fs: preserve inline data in subpage
 block mode
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
X-Spam-Status: No, score=-17.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/3/26 03:39, Daeho Jeong wrote:
> From: Daeho Jeong <daehojeong@google.com>
> 
> A write to an inline inode converted it to a regular inode whenever the
> folio held multiple blocks, allocating a block even for small files.
> Convert only when the write goes beyond MAX_INLINE_DATA; otherwise read
> the inline data into the folio and write it back to the inode block in
> f2fs_write_cache_folios().
> 
> Signed-off-by: Daeho Jeong <daehojeong@google.com>
> ---
>   fs/f2fs/data.c | 59 ++++++++++++++++++++++++++++++++++++++++++--------
>   1 file changed, 50 insertions(+), 9 deletions(-)
> 
> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> index 4e4d1b0d6004..a7cc7231b572 100644
> --- a/fs/f2fs/data.c
> +++ b/fs/f2fs/data.c
> @@ -4732,6 +4732,21 @@ static int f2fs_write_cache_folios(struct address_space *mapping,
>   			}
>   		}
>   
> +		if (f2fs_has_inline_data(inode)) {
> +			err = f2fs_write_inline_data(inode, folio);
> +			if (!err) {
> +				f2fs_ffs_clear_subrange_dirty_and_test(folio, 0,
> +							folio_size(folio));
> +				inode_sub_dirty_blocks(inode, f2fs_blocks_per_folio(sbi, folio));
> +				goto retry_out;
> +			}
> +			if (err != -EAGAIN) {

IIUC, -EAGAIN should not happen here? because we only convert inline to non inline
inode after we hold folio lock and inode cache lock, since we have held folio lock,
so there is no way to convert?

Thanks,

> +				folio_redirty_for_writepage(wbc, folio);
> +				goto retry_out;
> +			}
> +			err = 0;
> +		}
> +
>   		folio_start_writeback(folio);
>   
>   		/*
> @@ -4913,8 +4928,7 @@ static int __f2fs_write_data_pages(struct address_space *mapping,
>   	account_writeback(inode, true);
>   
>   	blk_start_plug(&plug);
> -	if (f2fs_has_multiblock_folios(inode) &&
> -	    !f2fs_has_inline_data(inode))
> +	if (f2fs_has_multiblock_folios(inode))
>   		ret = f2fs_write_cache_folios(mapping, wbc, io_type);
>   	else
>   		ret = f2fs_write_cache_pages(mapping, wbc, io_type);
> @@ -4981,6 +4995,16 @@ void f2fs_write_failed(struct inode *inode, loff_t to)
>   	}
>   }
>   
> +/* Fill @folio from the inline data for a write within the inline area */
> +static void prepare_inline_write_begin(struct inode *inode,
> +		struct folio *folio, struct f2fs_cached_block *ientry)
> +{
> +	f2fs_do_read_inline_data(folio, ientry);
> +	set_inode_flag(inode, FI_DATA_EXIST);
> +	if (inode->i_nlink)
> +		f2fs_cache_set_inline(ientry);
> +}
> +
>   static int prepare_write_begin(struct f2fs_sb_info *sbi,
>   			struct folio *folio, loff_t pos, unsigned int len,
>   			block_t *blk_addr, bool *node_changed)
> @@ -5034,10 +5058,7 @@ static int prepare_write_begin(struct f2fs_sb_info *sbi,
>   
>   	if (f2fs_has_inline_data(inode)) {
>   		if (pos + len <= MAX_INLINE_DATA(inode)) {
> -			f2fs_do_read_inline_data(folio, ientry);
> -			set_inode_flag(inode, FI_DATA_EXIST);
> -			if (inode->i_nlink)
> -				f2fs_cache_set_inline(ientry);
> +			prepare_inline_write_begin(inode, folio, ientry);
>   			goto out;
>   		}
>   		err = f2fs_convert_inline_folio(&dn, folio);
> @@ -5454,7 +5475,8 @@ static int f2fs_write_begin(const struct kiocb *iocb,
>   	 * and #0 page. The locking rule for inline_data conversion should be:
>   	 * folio_lock(folio #0) -> folio_lock(inode_page)
>   	 */
> -	if (index != 0 || f2fs_has_subpage_blocks(sbi)) {
> +	if (index != 0 || (f2fs_has_subpage_blocks(sbi) &&
> +			   pos + len > MAX_INLINE_DATA(inode))) {
>   		err = f2fs_convert_inline_inode(inode);
>   		if (err)
>   			goto fail;
> @@ -5510,6 +5532,23 @@ static int f2fs_write_begin(const struct kiocb *iocb,
>   	blen = min_t(unsigned int, len,
>   		     folio_size(folio) - offset_in_folio(folio, pos));
>   
> +	if (f2fs_has_inline_data(inode) && f2fs_is_multiblock_folio(sbi, folio)) {
> +		struct f2fs_lock_context lc;
> +		struct f2fs_cached_block *ientry;
> +
> +		f2fs_map_lock(sbi, &lc, F2FS_GET_BLOCK_PRE_AIO);
> +		ientry = f2fs_get_inode_cache(sbi, inode->i_ino);
> +		if (IS_ERR(ientry)) {
> +			f2fs_map_unlock(sbi, &lc, F2FS_GET_BLOCK_PRE_AIO);
> +			err = PTR_ERR(ientry);
> +			goto put_folio;
> +		}
> +		prepare_inline_write_begin(inode, folio, ientry);
> +		f2fs_put_cache(ientry, true);
> +		f2fs_map_unlock(sbi, &lc, F2FS_GET_BLOCK_PRE_AIO);
> +		return 0;
> +	}
> +
>   	/*
>   	 * Flush the cached IO of this folio before touching it, especially
>   	 * for the large folio prepare below which reads and updates subpage
> @@ -5618,7 +5657,8 @@ static int f2fs_write_end(const struct kiocb *iocb,
>   	if (!folio_test_uptodate(folio)) {
>   		if (unlikely(copied != len)) {
>   			copied = 0;
> -		} else if (f2fs_is_multiblock_folio(F2FS_I_SB(inode), folio)) {
> +		} else if (f2fs_is_multiblock_folio(F2FS_I_SB(inode), folio) &&
> +			   !f2fs_has_inline_data(inode)) {
>   			f2fs_ffs_mark_subrange_uptodate(folio,
>   					offset_in_folio(folio, pos), len);
>   		} else {
> @@ -5645,7 +5685,8 @@ static int f2fs_write_end(const struct kiocb *iocb,
>   	if (!copied)
>   		goto unlock_out;
>   
> -	if (f2fs_is_multiblock_folio(F2FS_I_SB(inode), folio))
> +	if (f2fs_is_multiblock_folio(F2FS_I_SB(inode), folio) &&
> +	    !f2fs_has_inline_data(inode))
>   		f2fs_ffs_mark_subrange_dirty(folio, offset_in_folio(folio, pos),
>   								   copied);
>   	folio_mark_dirty(folio);



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
