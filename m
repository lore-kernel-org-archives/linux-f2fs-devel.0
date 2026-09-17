Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB007C982D0
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 17 Sep 2026 08:10:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=j+WRBT2LHNnCyrMNeVi7Enr3cWFdjMqmyJe7q6TgrSw=; b=Ye66mQ6fFjs/flipGfYX+fPCDg
	jbOYCK1OW8TVPBLNNssBmsblNDSkqxaAPm/q3eHlUF/Blvhvd8EkF00TYbl8Bj/Hy4WtH2phuoIxh
	iTCM+lXfsrzHoqezI9Gpr7gyYw59V3TTGyOFrgyQSiet/lTASVLua5lX51kGfRkfr4+Q=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1x77C2-0006NG-LZ;
	Thu, 17 Sep 2026 08:10:04 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1x77Bw-0006K0-UM
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 17 Sep 2026 08:09:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=UykKVWBqmzlyI8cYgHwt51rpqVmLZ/BwoeZDabajYo4=; b=atzzM5cgXhvQ+97eXawuramNp3
 uAAvlx3m41hHwnl5/DnpNrtZ8JD1DbocURtuxLb4NCTH796eAcZxzwFDCiW7nrseBZipDGYlgx3/a
 Npe+5U5/s8kKhYsLXuHkCdrIWwcX51Km63r/6j9jemUwm3Y2n4Bk9i5VqSFMSKWcTt/U=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=UykKVWBqmzlyI8cYgHwt51rpqVmLZ/BwoeZDabajYo4=; b=BkThW3EG+PgC5FfK+C01Cr/2Q9
 fMG3XR+hHJglOiuyOFu7QMDSZFxL1X+u5n40Zi/Ms8pJ/ztIrlgZGU/7DZ6CSieAYiaTMSPKnKB3m
 Xp4Ffb463GvT1I9M1mK47moNuMV6M8yTm/MaAU6srItSMa6AvhvTaNWext7AgyEMjHEg=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1x77Br-0005bl-OM for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 17 Sep 2026 08:09:58 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 2030E6022E;
 Thu, 17 Sep 2026 08:09:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BFE41F000FF;
 Thu, 17 Sep 2026 08:09:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789632589;
 bh=UykKVWBqmzlyI8cYgHwt51rpqVmLZ/BwoeZDabajYo4=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To;
 b=V61j4DCj4ah5LSOTCOFsmvR14tPiPu89KoJFUT7ZafNL3UgbTIapTqu9c4t0gxT0N
 KmhP7HU9NKjSkanSpLbGGaY72xrtuws9ZnRQPywE38umtaTDQVj+FdX6vaImJKi+6z
 QW1c9rZjNS1SpRxACgIUsCUeExwhe2f1cvHHrql1nADuXe5g3AhjGqYJMZLYq9XwHU
 MSmZ/R0r09tKlz/ZGWwRAugiXAdA0uLvb38xX1ym5yvlCOSJP4k+H+Xy0BD08EEJXz
 ajq2SGoOyD3P8J3laf/mYZtWi1tv7lPd67pXeFHs+Kt0lLOuhDlEOqoAUhSupL3Maj
 5inw+7e0j5v4A==
Message-ID: <6045b4b3-26ef-4d12-b832-7affc9574df0@kernel.org>
Date: Thu, 17 Sep 2026 16:09:45 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Nanzhe Zhao <zhaonanzhe@xiaomi.com>,
 linux-f2fs-devel@lists.sourceforge.net, Jaegeuk Kim <jaegeuk@kernel.org>
References: <20260915041909.2903887-1-zhaonanzhe@xiaomi.com>
 <20260915041909.2903887-9-zhaonanzhe@xiaomi.com>
Content-Language: en-US
In-Reply-To: <20260915041909.2903887-9-zhaonanzhe@xiaomi.com>
X-Headers-End: 1x77Br-0005bl-OM
Subject: Re: [f2fs-dev] [PATCH v2 08/14] f2fs: optimize small block size
 large folio read
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 9/15/26 12:19, Nanzhe Zhao wrote:
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
>  fs/f2fs/data.c | 65 ++++++++++++++++++++++++++++++++++----------------
>  1 file changed, 45 insertions(+), 20 deletions(-)
> 
> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> index 287d83debf95..09ad5cf0d9aa 100644
> --- a/fs/f2fs/data.c
> +++ b/fs/f2fs/data.c
> @@ -173,8 +173,9 @@ static void f2fs_finish_read_bio(struct bio *bio, bool in_task)
>  			continue;
>  		}
>  
> -		if (folio_test_large(folio)) {
> -			struct f2fs_folio_state *ffs = folio->private;
> +		if (f2fs_folio_has_ffs(folio)) {
> +			struct f2fs_folio_state *ffs =
> +				(struct f2fs_folio_state *)folio->private;

I just notice that in somewhere, we missed to cast the private field to
f2fs_folio_state pointer as below, please take a look.

ffs = folio->private;

>  
>  			spin_lock_irqsave(&ffs->state_lock, flags);
>  			ffs->read_pages_pending -= nr_pages;
> @@ -2844,8 +2845,7 @@ static int f2fs_read_data_large_folio(struct inode *inode,
>  	pgoff_t index, offset, next_pgofs = 0;
>  	unsigned max_nr_pages = rac ? readahead_count(rac) :
>  				folio_nr_pages(folio);
> -	unsigned int nrpages;
> -	struct f2fs_folio_state *ffs;
> +	unsigned int nrpages, len_blks;
>  	int ret = 0;
>  	bool folio_in_bio = false;
>  
> @@ -2868,11 +2868,17 @@ static int f2fs_read_data_large_folio(struct inode *inode,
>  	folio_in_bio = false;
>  	index = folio->index;
>  	offset = 0;
> -	ffs = NULL;
>  	nrpages = folio_nr_pages(folio);
>  
> -	for (; nrpages; nrpages--, max_nr_pages--, index++, offset++) {
> +	for (; nrpages;
> +	     nrpages -= len_blks, max_nr_pages -= len_blks,
> +	     index += len_blks, offset += len_blks) {
>  		sector_t block_nr;
> +		bool whole_folio_in_bio;
> +		unsigned int i;
> +
> +		len_blks = 1;
> +
>  		/*
>  		 * Map blocks using the previous result first.
>  		 */
> @@ -2901,13 +2907,31 @@ static int f2fs_read_data_large_folio(struct inode *inode,
>  got_it:
>  		if ((map.m_flags & F2FS_MAP_MAPPED)) {
>  			block_nr = map.m_pblk + index - map.m_lblk;
> -			if (!f2fs_is_valid_blkaddr(F2FS_I_SB(inode), block_nr,
> +
> +			len_blks = min_t(unsigned int, nrpages, max_nr_pages);
> +			len_blks = min_t(unsigned int, len_blks,
> +					(unsigned int)(map.m_lblk + map.m_len - index));
> +
> +			for (i = 0; i < len_blks; i++) {
> +				if (!f2fs_is_valid_blkaddr(F2FS_I_SB(inode),
> +						block_nr + i,
>  						DATA_GENERIC_ENHANCE_READ)) {
> -				ret = -EFSCORRUPTED;
> -				goto err_out;
> +					ret = -EFSCORRUPTED;
> +					goto err_out;
> +				}
>  			}
> +
> +			/*
> +			 * If an entire folio is added to one bio,
> +			 * folio_end_read() can complete the folio read status
> +			 * without relying on f2fs_folio_state.
> +			 */
> +			whole_folio_in_bio = offset == 0 &&
> +					len_blks == folio_nr_pages(folio);
> +
>  		} else {
>  			size_t page_offset = offset << PAGE_SHIFT;
> +
>  			folio_zero_range(folio, page_offset, PAGE_SIZE);
>  			if (vi && !fsverity_verify_blocks(vi, folio, PAGE_SIZE, page_offset)) {
>  				ret = -EIO;
> @@ -2917,15 +2941,13 @@ static int f2fs_read_data_large_folio(struct inode *inode,
>  		}
>  
>  		/* We must increment read_pages_pending before possible BIOs submitting
> -		 * to prevent from premature folio_end_read() call on folio
> +		 * to prevent from premature folio_end_read() call on folio.
>  		 */
> -		if (folio_test_large(folio)) {
> -			ffs = f2fs_ffs_find_or_alloc(folio);
> +		if (folio_test_large(folio) && !whole_folio_in_bio) {
> +			f2fs_ffs_find_or_alloc(folio);

Need to check return value?

Thanks,

>  
>  			/* set the bitmap to wait */
> -			spin_lock_irq(&ffs->state_lock);
> -			ffs->read_pages_pending++;
> -			spin_unlock_irq(&ffs->state_lock);
> +			f2fs_update_read_folio_pending(folio, len_blks);
>  		}
>  
>  		/*
> @@ -2949,17 +2971,20 @@ static int f2fs_read_data_large_folio(struct inode *inode,
>  		 * If the page is under writeback, we need to wait for
>  		 * its completion to see the correct decrypted data.
>  		 */
> -		f2fs_wait_on_block_writeback(inode, block_nr);
> +		for (i = 0; i < len_blks; i++)
> +			f2fs_wait_on_block_writeback(inode, block_nr + i);
>  
> -		if (!bio_add_folio(bio, folio, F2FS_BLKSIZE(F2FS_I_SB(inode)),
> +		if (!bio_add_folio(bio, folio,
> +				len_blks * F2FS_BLKSIZE(F2FS_I_SB(inode)),
>  				offset << PAGE_SHIFT))
>  			goto submit_and_realloc;
>  
>  		folio_in_bio = true;
> -		inc_page_count(F2FS_I_SB(inode), F2FS_RD_DATA);
> +		for (i = 0; i < len_blks; i++)
> +			inc_page_count(F2FS_I_SB(inode), F2FS_RD_DATA);
>  		f2fs_update_iostat(F2FS_I_SB(inode), NULL, FS_DATA_READ_IO,
> -				F2FS_BLKSIZE(F2FS_I_SB(inode)));
> -		last_block_in_bio = block_nr;
> +				len_blks * F2FS_BLKSIZE(F2FS_I_SB(inode)));
> +		last_block_in_bio = block_nr + len_blks - 1;
>  	}
>  	trace_f2fs_read_folio(folio, DATA);
>  err_out:



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
