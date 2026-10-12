Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38542CA9EC5
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 12 Oct 2026 07:09:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Content-Transfer-Encoding:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=CQ2U0HUgJAnFjVfkugomC4krS84VIldlYSG6nGgfzt8=; b=H/bUfOZ5J9EIswSRHQsZuAeCuY
	JrUGRFtl0AvEOrWTWGreIf4lNYzjbU8JAxNyWOv5dRXxf9zQgJZcK7Onx5ESkfljcXgLTVZsnJv1k
	O6Z/UHjMQqvIf3+3z0fThuRdpRiXlnsh8E2Ww6ZL8UJ8jqPet5En32x4SsN7AihIi9Ak=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xGAAU-0005wY-6S;
	Mon, 12 Oct 2026 07:09:54 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1xGAAS-0005wM-I9
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 12 Oct 2026 07:09:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=vc+vo3tyDqzu0eoQG/JEUgM2Kj8/FZF1XersPkE/WXE=; b=hk4Dk5qyoIiHYPnomi7qz6b/l3
 jsST9xS2Xmf0XQdrfySnhY/Q0WjTzbTXXOTiBU+cUH9VtF3sOMyhBZ9kuSH5wMtSURzDTKmwH+9y9
 Yb5i0R/G+Ffrsn+SLV7Xlqyejoe2Duofb/f60taG69Nfep/g+CPilEpo7Ca7ENRwBXjc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=vc+vo3tyDqzu0eoQG/JEUgM2Kj8/FZF1XersPkE/WXE=; b=OndG++D/OS2CdGe5HrfncP3hvI
 1bXgPdzPY9AVEfU0VXaqM+zhbVe/CaTdznnVR2PcmTsZrXJLRHsAb5Wp2G6zbikF4fAiF/qfD+TH6
 SjxjuvxMsWswXlz6oEqFgMyANL7SfCeoREphbZen/wL/eaU6CYhMoPB4cNo4b8mxQRg8=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1xGAAR-0006gC-Tg for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 12 Oct 2026 07:09:53 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 9014341239;
 Mon, 12 Oct 2026 07:09:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 946DE1F0089B;
 Mon, 12 Oct 2026 07:09:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791788986;
 bh=vc+vo3tyDqzu0eoQG/JEUgM2Kj8/FZF1XersPkE/WXE=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To;
 b=fVqnTNcOp1/ajoMRkZ5iOpQq88dUh6+wM/qFcjTsLpzAYpGYU974UREaMZ/789dIL
 B3jjZqAP8jeMdSPb2VAjHAF5GmZTC+/Tfzo/vKS9d00kaESxdTt6rXBmet88puoF0c
 7HDckpFqad39fYFInFpzYNilwV/rm9goupo4JII7e2oZ5MOwsAdDD9wl1esxImSPXn
 1g4Q1EZFBtiOGvQ7ZOHH88LQJ/72s0qsoNIe2csakqKPU9A5GeqkyslrJ0jJB1qaYA
 PoWE13GBDhtDKDBMma/34+8bPvpPFJxQJARfu5TCMFApNsqpp7mpFM5tMpLcDvkx10
 cNHL8DLGf+5eA==
Message-ID: <3be99fcf-86c1-44de-a354-0292646dd1b7@kernel.org>
Date: Mon, 12 Oct 2026 15:09:38 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Nanzhe Zhao <zhaonanzhe@xiaomi.com>,
 linux-f2fs-devel@lists.sourceforge.net, Jaegeuk Kim <jaegeuk@kernel.org>
References: <20261009161224.4163796-1-zhaonanzhe@xiaomi.com>
 <20261009161224.4163796-11-zhaonanzhe@xiaomi.com>
Content-Language: en-US
In-Reply-To: <20261009161224.4163796-11-zhaonanzhe@xiaomi.com>
X-Headers-End: 1xGAAR-0006gC-Tg
Subject: Re: [f2fs-dev] [PATCH v3 10/17] f2fs: optimize small block size
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
 Daeho Jeong <daehojeong@google.com>, Dev Jain <Dev.Jain@arm.com>,
 linux-kernel@vger.kernel.org, David Hildenbrand <David.Hildenbrand@arm.com>,
 Bo Zhang <zhangbo56@xiaomi.com>, Kalesh Singh <kaleshsingh@google.com>,
 Nanzhe Zhao <nzzhao@126.com>, Pengfei Li <lipengfei28@xiaomi.com>,
 Ryan Roberts <Ryan.Roberts@arm.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 10/10/26 00:12, Nanzhe Zhao wrote:
> The original f2fs_read_data_large_folio() implementation has limited
> benefit with a 4KB block size, mainly because updating
> read_pages_pending greatly increases the number of spinlock
> operations.
> 
> Use len_blks to batch read_pages_pending and iostat updates for
> contiguous mapped blocks.
> 
> Signed-off-by: Nanzhe Zhao <zhaonanzhe@xiaomi.com>
> ---
>   fs/f2fs/data.c | 48 ++++++++++++++++++++++++++++++++----------------
>   1 file changed, 32 insertions(+), 16 deletions(-)
> 
> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> index 171b6a38e5cc..6f6f5223951d 100644
> --- a/fs/f2fs/data.c
> +++ b/fs/f2fs/data.c
> @@ -158,7 +158,7 @@ static void f2fs_finish_read_bio(struct bio *bio, bool in_task)
>   			continue;
>   		}
>   
> -		if (folio_test_large(folio)) {
> +		if (f2fs_folio_has_ffs(folio)) {
>   			struct f2fs_folio_state *ffs =
>   				(struct f2fs_folio_state *)folio->private;
>   
> @@ -3081,7 +3081,7 @@ static int f2fs_read_data_large_folio(struct inode *inode,
>   	pgoff_t index, offset, next_pgofs = 0;
>   	unsigned max_nr_pages = rac ? readahead_count(rac) :
>   				folio_nr_pages(folio);
> -	unsigned nrpages;
> +	unsigned nrpages, len_blks;
>   	struct f2fs_folio_state *ffs;
>   	int ret = 0;
>   	bool folio_in_bio = false;
> @@ -3105,11 +3105,16 @@ static int f2fs_read_data_large_folio(struct inode *inode,
>   	folio_in_bio = false;
>   	index = folio->index;
>   	offset = 0;
> -	ffs = NULL;
>   	nrpages = folio_nr_pages(folio);
>   
> -	for (; nrpages; nrpages--, max_nr_pages--, index++, offset++) {
> +	for (; nrpages;
> +	     nrpages -= len_blks, max_nr_pages -= len_blks,
> +	     index += len_blks, offset += len_blks) {
>   		sector_t block_nr;
> +		unsigned int i;
> +
> +		len_blks = 1;
> +
>   		/*
>   		 * Map blocks using the previous result first.
>   		 */
> @@ -3138,13 +3143,23 @@ static int f2fs_read_data_large_folio(struct inode *inode,
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
>   		} else {
>   			size_t page_offset = offset << PAGE_SHIFT;
> +
>   			folio_zero_range(folio, page_offset, PAGE_SIZE);
>   			if (vi && !fsverity_verify_blocks(vi, folio, PAGE_SIZE, page_offset)) {
>   				ret = -EIO;
> @@ -3154,7 +3169,7 @@ static int f2fs_read_data_large_folio(struct inode *inode,
>   		}
>   
>   		/* We must increment read_pages_pending before possible BIOs submitting
> -		 * to prevent from premature folio_end_read() call on folio
> +		 * to prevent from premature folio_end_read() call on folio.

It's not worth to change this line only by adding a "."

>   		 */
>   		if (folio_test_large(folio)) {
>   			ffs = f2fs_ffs_find_or_alloc(folio);
> @@ -3164,9 +3179,7 @@ static int f2fs_read_data_large_folio(struct inode *inode,
>   			}
>   
>   			/* set the bitmap to wait */
> -			spin_lock_irq(&ffs->state_lock);
> -			ffs->read_pages_pending++;
> -			spin_unlock_irq(&ffs->state_lock);
> +			f2fs_update_read_folio_pending(folio, len_blks);
>   		}
>   
>   		/*
> @@ -3190,17 +3203,20 @@ static int f2fs_read_data_large_folio(struct inode *inode,
>   		 * If the page is under writeback, we need to wait for
>   		 * its completion to see the correct decrypted data.
>   		 */
> -		f2fs_wait_on_block_writeback(inode, block_nr);
> +		for (i = 0; i < len_blks; i++)
> +			f2fs_wait_on_block_writeback(inode, block_nr + i);

f2fs_wait_on_block_writeback_range()

>   
> -		if (!bio_add_folio(bio, folio, F2FS_BLKSIZE(F2FS_I_SB(inode)),
> +		if (!bio_add_folio(bio, folio,
> +				len_blks * F2FS_BLKSIZE(F2FS_I_SB(inode)),
>   				offset << PAGE_SHIFT))
>   			goto submit_and_realloc;
>   
>   		folio_in_bio = true;
> -		inc_cache_count(F2FS_I_SB(inode), F2FS_RD_DATA);
> +		for (i = 0; i < len_blks; i++)
> +			inc_cache_count(F2FS_I_SB(inode), F2FS_RD_DATA);
>   		f2fs_update_iostat(F2FS_I_SB(inode), NULL, FS_DATA_READ_IO,
> -				F2FS_BLKSIZE(F2FS_I_SB(inode)));
> -		last_block_in_bio = block_nr;
> +				len_blks * F2FS_BLKSIZE(F2FS_I_SB(inode)));
> +		last_block_in_bio = block_nr + len_blks - 1;
>   	}
>   	trace_f2fs_read_folio(folio, DATA);
>   err_out:



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
