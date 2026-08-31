Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4BCEC61DF0
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 31 Aug 2026 04:21:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Content-Transfer-Encoding:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1mhTKYuYpfZvoE5x8KvqF+m2+TFzgAQqzda5N0AofvY=; b=IDn1G9goyVl0YPo6x8eEoui6vA
	uVDdf5AENQoYXqTm00hDCw16V1jA88hRICd+PFyLxNZ7yuhvJ4Wh/uvbrCFSEwCKk+df58rxzvOoH
	hlichs7ayUTyAgxRiD15mhpVhNcW7jB6KTY3VjZNI8z8dbWcqj32BwErEKaWFBpNtEZI=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1x0tWO-0000n0-H4;
	Mon, 31 Aug 2026 04:21:24 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1x0tWM-0000mt-O1
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 31 Aug 2026 04:21:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=D/srB2qi/xGyHk8KhxL5VY+I1yXbGPQR9sondW4gNOo=; b=PSZHsuAquo9nRhNGwRwRFPYK3S
 bjh5vlUGOvgOJcQgjZY4UI2Vkg90+EUfdDOCiYVATU1aInGYh4aCf7HNFXLwbDQifK1G78YL7OhlY
 t37MKgVsAIIXN+bfb0gM2HSvsxrUa+0hRoZ/Hh9wUuNdDUUZwoFsT95fzpad7yrou+qs=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=D/srB2qi/xGyHk8KhxL5VY+I1yXbGPQR9sondW4gNOo=; b=eUmsbUhA6MF2SlKhVZi3gXrpqi
 nz8uXcMpoZ7hWrLNrq/UyVSr0r1dmmCLtfK5acxthmtgNP9cVyhrtueTNV22lqR9/FIAcDpDI4njv
 GwC750AUFdL32xg2ffaH6cEOvafiWZ8VYdF/ikQ+mFd0I5PUYAYQcPv5YHvY0bAULfEg=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1x0tWL-0006eB-7K for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 31 Aug 2026 04:21:22 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 3D6A560120;
 Mon, 31 Aug 2026 04:21:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B27301F000E9;
 Mon, 31 Aug 2026 04:21:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788150074;
 bh=D/srB2qi/xGyHk8KhxL5VY+I1yXbGPQR9sondW4gNOo=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To;
 b=bPyOlk8Np3eKUUfbA/io087Yiuhm+gibwpUYJ+X1Kvm18AahJGiStMGcn0CbbEb+E
 2fZi/kgorvK77XDLEN4Z5Qz5cUInm8DgppI2bHCaW+kKR1vYg/4IdPt2j+upcVDKQ/
 NhaHTMzZ7fvwOYY2B7PmbO9pGI+o0sKrHGmUc9MSYzu4VMB4j738LfJV1kv7UIocFl
 bblNKHuxAWcXjY0FFKisMtwp7xvEgK5MN5n8jR1dlXA7pmOfcS0OnWwdGsI59B+0B3
 YLxIrWzTohE6zIrGdU7w38vfHSQM9FNjERcngiB8xtDDiy/ITmyizVhfXJ3MdEtnDJ
 amEA3k3XafSRg==
Message-ID: <fe3ef362-3d4e-41cc-8237-05261c873bab@kernel.org>
Date: Mon, 31 Aug 2026 12:21:11 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Nanzhe Zhao <zhaonanzhe@xiaomi.com>,
 linux-f2fs-devel@lists.sourceforge.net, Jaegeuk Kim <jaegeuk@kernel.org>
References: <20260826082641.2007658-1-zhaonanzhe@xiaomi.com>
 <20260826082641.2007658-9-zhaonanzhe@xiaomi.com>
Content-Language: en-US
In-Reply-To: <20260826082641.2007658-9-zhaonanzhe@xiaomi.com>
X-Headers-End: 1x0tWL-0006eB-7K
Subject: Re: [f2fs-dev] [PATCH 08/14] f2fs: optimize small block size large
 folio read
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
 Dev Jain <Dev.Jain@arm.com>, linux-kernel@vger.kernel.org,
 David Hildenbrand <David.Hildenbrand@arm.com>, Bo Zhang <zhangbo56@xiaomi.com>,
 Kalesh Singh <kaleshsingh@google.com>, Nanzhe Zhao <nzzhao@126.com>,
 Pengfei Li <lipengfei28@xiaomi.com>, Ryan Roberts <Ryan.Roberts@arm.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 8/26/26 16:26, Nanzhe Zhao wrote:
> The original f2fs_read_data_large_folio() implementation has limited
> benefit with a 4KB block size, mainly because updating
> read_pages_pending greatly increases the number of spinlock
> operations.
> 
> Use len_blks to batch read_pages_pending and iostat updates for
> contiguous mapped blocks. If the contiguous mapping covers the whole
> folio, skip f2fs_folio_state allocation for that folio.
> 
> Signed-off-by: Nanzhe Zhao <zhaonanzhe@xiaomi.com>
> ---
>   fs/f2fs/data.c | 62 ++++++++++++++++++++++++++++++++++++++------------
>   1 file changed, 47 insertions(+), 15 deletions(-)
> 
> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> index 0e54b1e25893..48c1bb6c02e3 100644
> --- a/fs/f2fs/data.c
> +++ b/fs/f2fs/data.c
> @@ -153,6 +153,7 @@ static void f2fs_finish_read_bio(struct bio *bio, bool in_task)
>   		struct folio *folio = fi.folio;
>   		unsigned int nr_pages = fi.length >> PAGE_SHIFT;
>   		bool finished = true;
> +		bool uptodate = bio->bi_status == BLK_STS_OK;
>   
>   		if (!folio_test_large(folio) &&
>   		    f2fs_is_compressed_page(folio)) {
> @@ -163,10 +164,14 @@ static void f2fs_finish_read_bio(struct bio *bio, bool in_task)
>   			continue;
>   		}
>   
> -		if (folio_test_large(folio)) {
> -			struct f2fs_folio_state *ffs = folio->private;
> +		if (f2fs_folio_has_ffs(folio)) {
> +			struct f2fs_folio_state *ffs =
> +				(struct f2fs_folio_state *)folio->private;
>   
>   			spin_lock_irqsave(&ffs->state_lock, flags);
> +			if (bio->bi_status == BLK_STS_OK)
> +				uptodate = __ffs_mark_subrange_uptodate(folio, ffs,
> +						fi.offset, fi.length);
>   			ffs->read_pages_pending -= nr_pages;
>   			finished = !ffs->read_pages_pending;
>   			spin_unlock_irqrestore(&ffs->state_lock, flags);
> @@ -182,7 +187,7 @@ static void f2fs_finish_read_bio(struct bio *bio, bool in_task)
>   			bio->bi_status = BLK_STS_IOERR;
>   
>   		if (finished)
> -			folio_end_read(folio, bio->bi_status == BLK_STS_OK);

folio_end_read(folio, bio->bi_status == BLK_STS_OK && uptodate);
in case f2fs_sanity_check_node_footer() failed.

Thanks,

> +			folio_end_read(folio, uptodate);
>   	}
>   
>   	if (ctx)
> @@ -2887,8 +2892,15 @@ static int f2fs_read_data_large_folio(struct inode *inode,
>   	ffs = NULL;
>   	nrpages = folio_nr_pages(folio);
>   
> -	for (; nrpages; nrpages--, max_nr_pages--, index++, offset++) {
> +	for (; nrpages;
> +	     nrpages -= len_blks, max_nr_pages -= len_blks,
> +	     index += len_blks, offset += len_blks) {
>   		sector_t block_nr;
> +		bool whole_folio_in_bio;
> +		unsigned int i;
> +
> +		len_blks = 1;
> +
>   		/*
>   		 * Map blocks using the previous result first.
>   		 */
> @@ -2917,13 +2929,31 @@ static int f2fs_read_data_large_folio(struct inode *inode,
>   got_it:
>   		if ((map.m_flags & F2FS_MAP_MAPPED)) {
>   			block_nr = map.m_pblk + index - map.m_lblk;
> -			if (!f2fs_is_valid_blkaddr(F2FS_I_SB(inode), block_nr,
> +
> +			len_blks = min_t(unsigned int, nrpages, max_nr_pages);
> +			len_blks = min_t(unsigned int, len_blks,
> +					(unsigned int)(map.m_lblk + map.m_len - index));
> +
> +			for (i = 0; i < len_blks; i++) {
> +				if (!f2fs_is_valid_blkaddr(F2FS_I_SB(inode),
> +						block_nr + i,
>   						DATA_GENERIC_ENHANCE_READ)) {
> -				ret = -EFSCORRUPTED;
> -				goto err_out;
> +					ret = -EFSCORRUPTED;
> +					goto err_out;
> +				}
>   			}
> +
> +			/*
> +			 * If an entire folio is added to one bio,
> +			 * folio_end_read() can complete the folio read status
> +			 * without relying on f2fs_folio_state.
> +			 */
> +			whole_folio_in_bio = offset == 0 &&
> +					len_blks == folio_nr_pages(folio);
> +
>   		} else {
>   			size_t page_offset = offset << PAGE_SHIFT;
> +
>   			folio_zero_range(folio, page_offset, PAGE_SIZE);
>   			if (vi && !fsverity_verify_blocks(vi, folio, PAGE_SIZE, page_offset)) {
>   				ret = -EIO;
> @@ -2933,14 +2963,14 @@ static int f2fs_read_data_large_folio(struct inode *inode,
>   		}
>   
>   		/* We must increment read_pages_pending before possible BIOs submitting
> -		 * to prevent from premature folio_end_read() call on folio
> +		 * to prevent from premature folio_end_read() call on folio.
>   		 */
> -		if (folio_test_large(folio)) {
> +		if (folio_test_large(folio) && !whole_folio_in_bio) {
>   			ffs = f2fs_ffs_find_or_alloc(folio);
>   
>   			/* set the bitmap to wait */
>   			spin_lock_irq(&ffs->state_lock);
> -			ffs->read_pages_pending++;
> +			ffs->read_pages_pending += len_blks;
>   			spin_unlock_irq(&ffs->state_lock);
>   		}
>   
> @@ -2965,17 +2995,19 @@ static int f2fs_read_data_large_folio(struct inode *inode,
>   		 * If the page is under writeback, we need to wait for
>   		 * its completion to see the correct decrypted data.
>   		 */
> -		f2fs_wait_on_block_writeback(inode, block_nr);
> +		for (i = 0; i < len_blks; i++)
> +			f2fs_wait_on_block_writeback(inode, block_nr + i);
>   
> -		if (!bio_add_folio(bio, folio, F2FS_BLKSIZE,
> +		if (!bio_add_folio(bio, folio, len_blks * F2FS_BLKSIZE,
>   					offset << PAGE_SHIFT))
>   			goto submit_and_realloc;
>   
>   		folio_in_bio = true;
> -		inc_page_count(F2FS_I_SB(inode), F2FS_RD_DATA);
> +		for (i = 0; i < len_blks; i++)
> +			inc_page_count(F2FS_I_SB(inode), F2FS_RD_DATA);
>   		f2fs_update_iostat(F2FS_I_SB(inode), NULL, FS_DATA_READ_IO,
> -				F2FS_BLKSIZE);
> -		last_block_in_bio = block_nr;
> +				len_blks * F2FS_BLKSIZE);
> +		last_block_in_bio = block_nr + len_blks - 1;
>   	}
>   	trace_f2fs_read_folio(folio, DATA);
>   err_out:



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
