Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA290EFB7FD
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 24 Feb 2026 05:55:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:References:
	Message-ID:To:Date:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Tybm9c1sW2f5C+67lYxvZzFFhcTDj6QwGt3HO6thpVE=; b=Io2vcd55WRL5UKIEz4tP8tgIW2
	X5DIyHtPYFYcLLpBBn/Kd2DfmnX1+/M4cRvzWSZNoR0UWezZRe8HXRCRfeWbosLv+HezYjhKS/WlX
	k9vZOtmUgD+qVUjjIo37qH6WKwuAuN9F9G9uXczqEDpoQTdYGO9faDAn6zC2Id1UH+G8=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1vulOa-0006D4-87;
	Tue, 24 Feb 2026 05:55:44 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <jaegeuk@kernel.org>) id 1vulOZ-0006Cw-5j
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 24 Feb 2026 05:55:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Gsjcgg1CsmqEsymPxH/CQF/5goO3c1QXoOKHHT97j6w=; b=lMP/HGkBZN5nAjAyoHc4Rz0HAX
 yAMY6mbLWIyhmdqU+y6wLQCmLhGHIGO7r05UjDi02FefCdAelVVH1q7OwukHBJZrfsKHLA0Otua1s
 MV4e/gPExCbayOX0SSpFm4zIAtRMgWBvMwcSHMgMErINBzzCvtYnRYrbEN7fn7V4rqsQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=Gsjcgg1CsmqEsymPxH/CQF/5goO3c1QXoOKHHT97j6w=; b=XZ5/8wgw0z/NYwkyHwlV/Rvz2L
 3wxdDLOWqMk5VE/XAtfeaVKFnpN/De2T5Un7g1IOgblUHBLKGPIYxB/SwfJBcZTAlPkQ2xP9zaXaH
 S95bu75Hord+GHMzUMl23XvgUMIknNaBs8XMZBZMx3KLr0zQIBW6ZhYvhExpERmC+a4Q=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1vulOY-0005Mw-FP for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 24 Feb 2026 05:55:43 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 1A19960131;
 Tue, 24 Feb 2026 03:26:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B46BC116C6;
 Tue, 24 Feb 2026 03:26:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1771903574;
 bh=qSam5JFpaSCyqC9HUogDz6AuUDfmmdcPXZAhw/u1DHc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=kfJ0Zr9Mm4f1Y5qPXMj1C3EvkexgaKjqfTF9lAcVRFqb4yoXDPntDk/B36fEsBK9k
 TT+lx1na3r8D7psrO8aBhQh7phiqHr0roSp/nfSATgwhcI8nJl6VvGFMGdGqSP08E+
 f9Okug6iZF+LlVW2D4nsPZwrYaDWW5FiQargxILsqoEruFh9q5kyaKio26pPO0yowu
 /2MU3KMyVFnsCq43Vjz+PDRBouKrEwdcQZp1ap7UXQFOUrUx3l+HcpDwVc+OULr8M5
 nQKP/lIiS+Gd8MfQlEcA5kQU/04RwGCb9IiRYUEaj01GnTf3pF8uiZtyNI4bhyWGXA
 nQbtTUS2hf+7Q==
Date: Tue, 24 Feb 2026 03:26:12 +0000
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Message-ID: <aZ0aVDSWpRRqFwl9@google.com>
References: <20260218125237.3340441-1-shinichiro.kawasaki@wdc.com>
 <20260218125237.3340441-2-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260218125237.3340441-2-shinichiro.kawasaki@wdc.com>
X-Headers-End: 1vulOY-0005Mw-FP
Subject: Re: [f2fs-dev] [PATCH v2 1/1] f2fs: fix lockdep WARN of
 sbi->cp_global_sem and q->q_usage_counter
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
Cc: Damien Le Moal <dlemoal@kernel.org>, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 02/18, Shin'ichiro Kawasaki wrote:
> From: Shin'ichiro Kawasaki via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
> 
> A lockdep WARN is observed recently under the following steps:
> 
> 1) Create a zoned TCMU device
> 2) Create a f2fs filesystem on the zoned TCMU device and mount it
> 3) Fill the filesystem with files and trigger GC
> 4) Unmout the filesystem
> 5) Remove the zoned TCMU device
> 
> The lockdep WARN indicates that a circular lock depedency formed by four
> contexts, as described below.
> 
> a) TCMU device removal context:
>  - call del_gendisk() to get q->q_usage_counter
>  - call start_flush_work() to get work_completion of wb->dwork
> b) f2fs writeback context:
>  - in wb_workfn(), which holds work_completion of wb->dwork
>  - call f2fs_balance_fs() to get sbi->gc_lock
> c) f2fs vfs_write context:
>  - call f2fs_gc() to get sbi->gc_lock
>  - call f2fs_write_checkpoint() to get sbi->cp_global_sem
> d) f2fs mount context:
>  - call recover_fsync_data() to get sbi->cp_global_sem
>  - call f2fs_check_and_fix_write_pointer() to call blkdev_report_zones()
>    that goes down to blk_mq_alloc_request and get q->q_usage_counter
> 
> To suppress the WARN, cut the dependency d) between sbi->cp_global_sem
> and q->q_usage_counter. For that purpose, move the
> f2fs_check_and_fix_write_pointer() call outside of the critical section
> of sbi->cp_global_sem in f2fs_recovery_fsync_data(). This change is fine
> because the write pointer fix operation only affects the main segments
> and does not interact with the check point metadata. Furthermore,
> conflicts between the write pointer fix operation and data/node flush
> operations remain protected by SBI_POR_DOING.
> 
> Fixes: c426d99127b1 ("f2fs: Check write pointer consistency of open zones")
> Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
> Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> ---
>  fs/f2fs/recovery.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/f2fs/recovery.c b/fs/f2fs/recovery.c
> index a26071f2b0bc..87fd6cd436fe 100644
> --- a/fs/f2fs/recovery.c
> +++ b/fs/f2fs/recovery.c
> @@ -922,6 +922,8 @@ int f2fs_recover_fsync_data(struct f2fs_sb_info *sbi, bool check_only)
>  		truncate_inode_pages_final(META_MAPPING(sbi));
>  	}
>  
> +	f2fs_up_write_trace(&sbi->cp_global_sem, &lc);
> +
>  	/*
>  	 * If fsync data succeeds or there is no fsync data to recover,
>  	 * and the f2fs is not read only, check and fix zoned block devices'
> @@ -933,8 +935,6 @@ int f2fs_recover_fsync_data(struct f2fs_sb_info *sbi, bool check_only)
>  	if (!err)
>  		clear_sbi_flag(sbi, SBI_POR_DOING);
>  
> -	f2fs_up_write_trace(&sbi->cp_global_sem, &lc);
> -

This was a guard to prevent checkpoint during f2fs_check_and_fix_write_pointer()
where it changes the checkpoint as well?

>  	/* let's drop all the directory inodes for clean checkpoint */
>  	destroy_fsync_dnodes(&dir_list, err);
>  
> -- 
> 2.49.0


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
