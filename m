Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04ECAFB5EA4
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 17 Mar 2026 02:02:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Content-Transfer-Encoding:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7WZjvJAFqLgu9df/ZDhrvBRshU8aZz4IagBKxaEpz4Y=; b=PJcR9G02Zd8w2VcY0yCCZOs484
	MyjoplunpuZI4/EIoBuxBu5bMxpo+Ppw+vNzFdJZJQMo515g0RWxf5KhYR+KQufeBdyZjbi1bIcMl
	d28zkeI8cMcWiT3HAD+x28Z66CMxN/9/0lnGXnwe1P6FMuVZi7fSAIxDKRMvterXfL5Y=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1w2Jl2-000334-T7;
	Tue, 17 Mar 2026 02:02:09 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1w2Jl1-00032q-NQ
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 17 Mar 2026 02:02:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=EhM3evaErAJWCVjDNv1E2jYw+OeiweCMBKxW9wK5s4A=; b=ckDkpiBGAsWi6vibLDZQegF+6Z
 v8IFuJkfOOR8GF7WL+x19AkZYcptcfkyP2D6AjeSynzIDbbaomYTx0M/mcF3OhoivMkSVPybjzJ5q
 s08QehQaNbVuUBaqOm4/CaqEMkyAkZqGSR3fQuNkc2ZQkP8YnhKJDqdGGUzEXS0Ny76A=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=EhM3evaErAJWCVjDNv1E2jYw+OeiweCMBKxW9wK5s4A=; b=T/1bmO7SToJ0J1OC/rInunDc97
 5W4m8lZAVGxu2NqtEpvohy3p6bbFy7jaCRGRNkSao2hNLjBAf37YFIRMvGKY+onWRbHoHgX47TVWS
 4wttoZo7vM/PvmniTMJmx1DqOYEWS/06zUr9uY5jOlrnHKuSpZEYpiyA6aPX6/MLfRT8=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1w2Jl1-0000AN-Sf for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 17 Mar 2026 02:02:08 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 5893B444FD;
 Tue, 17 Mar 2026 02:02:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A891BC19421;
 Tue, 17 Mar 2026 02:02:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1773712922;
 bh=iSXhEMpThhNE+B4cdYthU3SUORC59xoUVLwCH/Rrh44=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
 b=l/pZ/lgkbZhdPKMZQHFB2Tp+Cap3KB2Z7oDpXlMXfID/Tf6rzSuT0C60Zm81+Px2a
 e+5tTSrAxUX2vreFcQg6duszYHm7Fjf6Mggs9iXKzNLNKTmdJFu9xtvgBRxahWzEpz
 kRaXtrfoeCc+1NMFqtdVmCxM72MAVRV8Hm8i7J+LwVewkybXhQj6B+mtFS+t37kj5f
 U0mhpy/qfs4AckEl5kDILzZrQI1q3u0tiwfyzso/5tgCEnliRp01+3GAHHlcdW/eUN
 +1pLCz+NqaSJiZDoEYYx7EewNzAvgLZISJ/M3nSlvgP+j7EqrOr3aac7Dp+uJxDI/y
 8FulI7t+Jif0g==
Message-ID: <a8e1b900-1976-43da-9894-ac7f9697f5aa@kernel.org>
Date: Tue, 17 Mar 2026 10:01:58 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Yongpeng Yang <monty_pavel@sina.com>, Jaegeuk Kim <jaegeuk@kernel.org>
References: <20260315181321.4063984-2-monty_pavel@sina.com>
Content-Language: en-US
In-Reply-To: <20260315181321.4063984-2-monty_pavel@sina.com>
X-Headers-End: 1w2Jl1-0000AN-Sf
Subject: Re: [f2fs-dev] [PATCH v3 1/3] f2fs: refactor f2fs_move_node_folio
 function
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
Cc: Yongpeng Yang <yangyongpeng@xiaomi.com>,
 linux-f2fs-devel@lists.sourceforge.net
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2026/3/16 02:13, Yongpeng Yang wrote:
> From: Yongpeng Yang <yangyongpeng@xiaomi.com>
> 
> This patch refactor the f2fs_move_node_folio() function. No logical
> change.
> 
> Signed-off-by: Yongpeng Yang <yangyongpeng@xiaomi.com>
> ---
>   fs/f2fs/f2fs.h |  2 ++
>   fs/f2fs/node.c | 54 ++++++++++++++++++++++++++++++--------------------
>   2 files changed, 34 insertions(+), 22 deletions(-)
> 
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index 8942b2a63cfd..be5132f992e8 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -3947,6 +3947,8 @@ int f2fs_sanity_check_node_footer(struct f2fs_sb_info *sbi,
>   					enum node_type ntype, bool in_irq);
>   struct folio *f2fs_get_inode_folio(struct f2fs_sb_info *sbi, pgoff_t ino);
>   struct folio *f2fs_get_xnode_folio(struct f2fs_sb_info *sbi, pgoff_t xnid);
> +int f2fs_write_single_node_folio(struct folio *node_folio, int sync_mode,
> +			bool mark_dirty, enum iostat_type io_type);
>   int f2fs_move_node_folio(struct folio *node_folio, int gc_type);
>   void f2fs_flush_inline_data(struct f2fs_sb_info *sbi);
>   int f2fs_fsync_node_pages(struct f2fs_sb_info *sbi, struct inode *inode,
> diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
> index bbfa677ef46f..12b943eae4d9 100644
> --- a/fs/f2fs/node.c
> +++ b/fs/f2fs/node.c
> @@ -1843,41 +1843,51 @@ static bool __write_node_folio(struct folio *folio, bool atomic, bool *submitted
>   	return false;
>   }
>   
> -int f2fs_move_node_folio(struct folio *node_folio, int gc_type)
> +int f2fs_write_single_node_folio(struct folio *node_folio, int sync_mode,
> +			bool mark_dirty, enum iostat_type io_type)
>   {
>   	int err = 0;
> +	struct writeback_control wbc = {
> +		.sync_mode = WB_SYNC_ALL,
> +		.nr_to_write = 1,
> +	};
>   
> -	if (gc_type == FG_GC) {
> -		struct writeback_control wbc = {
> -			.sync_mode = WB_SYNC_ALL,
> -			.nr_to_write = 1,
> -		};
> +	if (!sync_mode) {
> +		/* set page dirty and write it */
> +		if (mark_dirty && !folio_test_writeback(node_folio))
> +			folio_mark_dirty(node_folio);
> +		goto out_folio;
> +	}
>   
> -		f2fs_folio_wait_writeback(node_folio, NODE, true, true);
> +	f2fs_folio_wait_writeback(node_folio, NODE, true, true);
>   
> +	if (mark_dirty)
>   		folio_mark_dirty(node_folio);
> +	else if (!folio_test_dirty(node_folio))
> +		goto out_folio;
>   
> -		if (!folio_clear_dirty_for_io(node_folio)) {
> -			err = -EAGAIN;
> -			goto out_page;
> -		}
> -
> -		if (!__write_node_folio(node_folio, false, NULL,
> -					&wbc, false, FS_GC_NODE_IO, NULL))
> -			err = -EAGAIN;
> -		goto release_page;
> -	} else {
> -		/* set page dirty and write it */
> -		if (!folio_test_writeback(node_folio))
> -			folio_mark_dirty(node_folio);
> +	if (!folio_clear_dirty_for_io(node_folio)) {
> +		err = -EAGAIN;
> +		goto out_folio;
>   	}
> -out_page:
> +
> +	if (!__write_node_folio(node_folio, false, NULL,
> +				&wbc, false, FS_GC_NODE_IO, NULL))
> +		err = -EAGAIN;
> +	goto release_folio;
> +out_folio:
>   	folio_unlock(node_folio);
> -release_page:
> +release_folio:
>   	f2fs_folio_put(node_folio, false);
>   	return err;
>   }
>   
> +int f2fs_move_node_folio(struct folio *node_folio, int gc_type)
> +{
> +	return f2fs_write_single_node_folio(node_folio, gc_type == FG_GC,
> +			gc_type == FG_GC, FS_GC_NODE_IO);

mark_dirty should always be true for boty FGGC and BGGC?

Thanks,

> +}
> +
>   int f2fs_fsync_node_pages(struct f2fs_sb_info *sbi, struct inode *inode,
>   			struct writeback_control *wbc, bool atomic,
>   			unsigned int *seq_id)



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
