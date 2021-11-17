Return-Path: <SRS0=IuHR=QE=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D262AC433EF
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 17 Nov 2021 16:57:04 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 811CB62F90
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 17 Nov 2021 16:57:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 811CB62F90
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.94.2)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1mnOF5-0000OU-6N; Wed, 17 Nov 2021 16:57:03 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <jaegeuk@kernel.org>) id 1mnOF3-0000OB-9w
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 17 Nov 2021 16:57:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=mOWKuD1sWXt0UZ+u985+7zFxDQrBJh8expHAinpK+wY=; b=KBP+tO8XNq5zFG6OFKPx/vDNuK
 zhTqWPEtLm9o3hJQiGnGRtIHlBICKVJ/jddfdJ2vQjG2ciIS8nQWOC2WmPYJ4QERZ7tP2nJg6ZMIE
 mKJDj05zfsIucuNo3JKtCuaEhHVmLJ0xiSdYjIc2dwtE+v2O7rJgn5/klFMpGHTRo5Cw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=mOWKuD1sWXt0UZ+u985+7zFxDQrBJh8expHAinpK+wY=; b=BWgLTSCpW1MDlH1TDNpG9ran32
 HqeDHWTqKdhMb5ImCHi7Tlv9ApjSueH3emjPn8hRwTzkiFbnp4IXvEOc8G8mJ5REt7gCxfa1lJjzX
 sOas2jJ0p3cgDlbMW2e2IJRJa8OdUo4qE5NWu7jSM0xCW6Oif8g4PsQjRQr/vVdhmxJo=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.3)
 id 1mnOEy-00GWo5-JP
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 17 Nov 2021 16:57:01 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 017BA62F90;
 Wed, 17 Nov 2021 16:56:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1637168206;
 bh=wYYq7JIGe7T++RofZFKvll3ULuqrZ5GmSq0XgEF6dLo=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=nJ64db7zU0rPyM9idZqgcTR6z4iaRgkd1bHhCLtECrpDeAe26x/IC9f7xE1HlXDsP
 ZgLHJFEJd7wrm9Bn1sqPFN79gu3CpqTpXF7NxkIOKit2jXZJyfxSN/UCkx0hUb7HtA
 DNGn9aR0pAElK8Og5IPhDFd/Tv5mviD/LgIumrrCKT5F5WSjF6mBf7EyDQzgo8S+ai
 +Ig4kGDZTIM6ZYCAeAxFmwKp/QWPgbBEg2mceBy23eoZc+/MyjDiApZp53andbLusA
 stur58N23gRrD1hxWyViiJKxEJrRHdlcodx8+JcQ0uauDKcHiyXOI+++WVYMwPZPC6
 YxDqdNfPovt9Q==
Date: Wed, 17 Nov 2021 08:56:44 -0800
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: niuzhiguo84@gmail.com
Message-ID: <YZU0TFBH6k2Q6fJZ@google.com>
References: <1636438608-27597-1-git-send-email-niuzhiguo84@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1636438608-27597-1-git-send-email-niuzhiguo84@gmail.com>
X-Headers-End: 1mnOEy-00GWo5-JP
Subject: Re: [f2fs-dev] [PATCH Vx 1/1] f2fs: Avoid deadlock between
 writeback and checkpoint
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
Cc: Jing.Xia@unisoc.com, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 11/09, niuzhiguo84@gmail.com wrote:
> From: Zhiguo Niu <zhiguo.niu@unisoc.com>
> 
> There could be a scenario as following:
> The inodeA and inodeB are in b_io queue of writeback
> inodeA : f2fs's node inode
> inodeB : a dir inode with only one dirty pages, and the node page
> of inodeB cached into inodeA
> 
> writeback:
> 
> wb_workfn
> wb_writeback
> blk_start_plug
>         loop {
>         queue_io
>         progress=__writeback_inodes_wb
>                 __writeback_single_inode
>                         do_writepages
>                                 f2fs_write_data_pages
>                                 wbc->pages_skipped +=get_dirty_pages
>                         inode->i_state &= ~dirty
>                 wrote++
>                 requeue_inode
>         }
> blk_finish_plug
> 
> checkpoint:
> 
> f2fs_write_checkpoint
> f2fs_sync_dirty_inodes
> filemap_fdatawrite
> do_writepages
> f2fs_write_data_pages
>         f2fs_write_single_data_page
>                 f2fs_do_write_data_page
>                         set_page_writeback
>                         f2fs_outplace_write_data
>                                 f2fs_update_data_blkaddr
>                                         f2fs_wait_on_page_writeback
>                 inode_dec_dirty_pages
> 
> 1. Writeback thread flush inodeA, and push it's bio request in task's plug;
> 2. Checkpoint thread writes inodeB's dirty page, and then wait its node
>     page writeback cached into inodeA which is in writeback task's plug
> 3. Writeback thread flush inodeB and skip writing the dirty page as
>     wb_sync_req[DATA] > 0.
> 4. As none of the inodeB's page is marked as PAGECACHE_TAG_DIRTY, writeback
>     thread clear inodeB's dirty state.
> 5. Then inodeB is moved from b_io to b_dirty because of pages_skipped > 0
>     as checkpoint thread is stuck before dec dirty_pages.
> 
> This patch collect correct pages_skipped according to the tag state in
> page tree of inode
> 
> Signed-off-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
> Signed-off-by: Jing Xia <jing.xia@unisoc.com>
> ---
>  fs/f2fs/data.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> index f4fd6c246c9a..e98628e3868c 100644
> --- a/fs/f2fs/data.c
> +++ b/fs/f2fs/data.c
> @@ -3237,7 +3237,9 @@ static int __f2fs_write_data_pages(struct address_space *mapping,
>  	return ret;
>  
>  skip_write:
> -	wbc->pages_skipped += get_dirty_pages(inode);
> +	wbc->pages_skipped +=
> +		mapping_tagged(inode->i_mapping, PAGECACHE_TAG_DIRTY) ?

Is there any race condition to get 0, if there's any dirty page? IOWs, it
seems the current condition is just requeuing the inode as dirty, but next
flushing time will remove it from dirty list. Is this giving too much overheads?

> +		get_dirty_pages(inode) : 0;
>  	trace_f2fs_writepages(mapping->host, wbc, DATA);
>  	return 0;
>  }
> -- 
> 2.28.0


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
