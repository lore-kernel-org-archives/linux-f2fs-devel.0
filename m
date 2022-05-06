Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85568C433F5
	for <linux-f2fs-devel@archiver.kernel.org>; Fri,  6 May 2022 23:22:14 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.94.2)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1nn7H5-0007iV-DI; Fri, 06 May 2022 23:22:13 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <jaegeuk@kernel.org>) id 1nn7H3-0007iG-Ve
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 06 May 2022 23:22:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=9v5cJIGJjN/ZJSHwfCWuva2dmmrJCYY4q9juHAb91eY=; b=Q9OuPmiF9OPo/2JWUmkj3gB6e4
 DwCQJKrjBUg25v852BdkBrv2rkHtIXxmO5P20PEoimDiVWoEn6S9+DG4GOOR3aKNxOdmw/Z5PUrGP
 mQu3FPk2QYo8q4Bv7KABqc73CLi4fyYHPNfFqvpvWvT1bAnCFxVt5sN2YUzySSK3DsiM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=9v5cJIGJjN/ZJSHwfCWuva2dmmrJCYY4q9juHAb91eY=; b=V50rlYV8rVUAMDrvTIuKk7Kg1K
 YX7aAYksp4uVtASBYw7rYXPNAszTgagi8o7oFjv/QiBX/W4n8IMzOBpIUTTYuHAJfSK8khGMX4sXK
 twdqV765QHTIhAj/g5Suf3nQKZikA0nnOXsJtt3jELzX9zbB9K1bSjHx3UEf3iE1Un9g=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.94.2)
 id 1nn7H1-003dDa-KP
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 06 May 2022 23:22:12 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 0339E61A28;
 Fri,  6 May 2022 23:22:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AC7DC385A9;
 Fri,  6 May 2022 23:22:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1651879325;
 bh=0KxPlUem/CmfBocjj06kFOXXVyKwRj4DKawIeoBMDZU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=DytsWlQv+vlTfw3SyKSmWAsf//Ttg/uqV9gzpcRjh6OX5v6e80FekiBsaG0wC4rFZ
 ecUCSYAwNtVtum8eH0otLcUaLW+D3a4p/JvxLleZBj2Sv0zViSLTAXakViif5mlAZl
 Eh2gWhdePTkHf0krStnVVgRxW14buxVzy1KFrCLBNxcZhsN9jDPEfAHlCp7bNgc5VA
 uX2Oa6GExgVkNfyLgZNILxCfpmEWA5PxWivr7PXvGObIoEjgHEsSaCY1XtoDwLFhDm
 Ad5GAFCrXPFxgoYArKqguaL7+DiGzC46W8wEOTIy6oKcPrTeCQv+pdX1uTQZeNvikv
 iYOIHUIieMaQA==
Date: Fri, 6 May 2022 16:22:03 -0700
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Chao Yu <chao@kernel.org>
Message-ID: <YnWtm4opVq3JypW9@google.com>
References: <20220506013306.3563504-1-chao@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220506013306.3563504-1-chao@kernel.org>
X-Headers-End: 1nn7H1-003dDa-KP
Subject: Re: [f2fs-dev] [PATCH v4] f2fs: fix to do sanity check on
 total_data_blocks
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
Cc: Ming Yan <yanming@tju.edu.cn>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

I added a macro to clean up. Could you please check this out?

https://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git/commit/?h=dev&id=6b8beca0edd32075a769bfe4178ca00c0dcd22a9

On 05/06, Chao Yu wrote:
> As Yanming reported in bugzilla:
> 
> https://bugzilla.kernel.org/show_bug.cgi?id=215916
> 
> The kernel message is shown below:
> 
> kernel BUG at fs/f2fs/segment.c:2560!
> Call Trace:
>  allocate_segment_by_default+0x228/0x440
>  f2fs_allocate_data_block+0x13d1/0x31f0
>  do_write_page+0x18d/0x710
>  f2fs_outplace_write_data+0x151/0x250
>  f2fs_do_write_data_page+0xef9/0x1980
>  move_data_page+0x6af/0xbc0
>  do_garbage_collect+0x312f/0x46f0
>  f2fs_gc+0x6b0/0x3bc0
>  f2fs_balance_fs+0x921/0x2260
>  f2fs_write_single_data_page+0x16be/0x2370
>  f2fs_write_cache_pages+0x428/0xd00
>  f2fs_write_data_pages+0x96e/0xd50
>  do_writepages+0x168/0x550
>  __writeback_single_inode+0x9f/0x870
>  writeback_sb_inodes+0x47d/0xb20
>  __writeback_inodes_wb+0xb2/0x200
>  wb_writeback+0x4bd/0x660
>  wb_workfn+0x5f3/0xab0
>  process_one_work+0x79f/0x13e0
>  worker_thread+0x89/0xf60
>  kthread+0x26a/0x300
>  ret_from_fork+0x22/0x30
> RIP: 0010:new_curseg+0xe8d/0x15f0
> 
> The root cause is: ckpt.valid_block_count is inconsistent with SIT table,
> stat info indicates filesystem has free blocks, but SIT table indicates
> filesystem has no free segment.
> 
> So that during garbage colloection, it triggers panic when LFS allocator
> fails to find free segment.
> 
> This patch tries to fix this issue by checking consistency in between
> ckpt.valid_block_count and block accounted from SIT.
> 
> Cc: stable@vger.kernel.org
> Reported-by: Ming Yan <yanming@tju.edu.cn>
> Signed-off-by: Chao Yu <chao.yu@oppo.com>
> ---
> v4:
> - fix to set data/node type correctly.
>  fs/f2fs/segment.c | 37 ++++++++++++++++++++++++++-----------
>  1 file changed, 26 insertions(+), 11 deletions(-)
> 
> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> index 3a3e2cec2ac4..4735d477059d 100644
> --- a/fs/f2fs/segment.c
> +++ b/fs/f2fs/segment.c
> @@ -4461,7 +4461,8 @@ static int build_sit_entries(struct f2fs_sb_info *sbi)
>  	unsigned int i, start, end;
>  	unsigned int readed, start_blk = 0;
>  	int err = 0;
> -	block_t total_node_blocks = 0;
> +	block_t sit_valid_blocks[2] = {0, 0};
> +	int type;
>  
>  	do {
>  		readed = f2fs_ra_meta_pages(sbi, start_blk, BIO_MAX_VECS,
> @@ -4486,8 +4487,9 @@ static int build_sit_entries(struct f2fs_sb_info *sbi)
>  			if (err)
>  				return err;
>  			seg_info_from_raw_sit(se, &sit);
> -			if (IS_NODESEG(se->type))
> -				total_node_blocks += se->valid_blocks;
> +
> +			type = IS_NODESEG(se->type) ? NODE : DATA;
> +			sit_valid_blocks[type] += se->valid_blocks;
>  
>  			if (f2fs_block_unit_discard(sbi)) {
>  				/* build discard map only one time */
> @@ -4527,15 +4529,17 @@ static int build_sit_entries(struct f2fs_sb_info *sbi)
>  		sit = sit_in_journal(journal, i);
>  
>  		old_valid_blocks = se->valid_blocks;
> -		if (IS_NODESEG(se->type))
> -			total_node_blocks -= old_valid_blocks;
> +
> +		type = IS_NODESEG(se->type) ? NODE : DATA;
> +		sit_valid_blocks[type] -= old_valid_blocks;
>  
>  		err = check_block_count(sbi, start, &sit);
>  		if (err)
>  			break;
>  		seg_info_from_raw_sit(se, &sit);
> -		if (IS_NODESEG(se->type))
> -			total_node_blocks += se->valid_blocks;
> +
> +		type = IS_NODESEG(se->type) ? NODE : DATA;
> +		sit_valid_blocks[type] += se->valid_blocks;
>  
>  		if (f2fs_block_unit_discard(sbi)) {
>  			if (is_set_ckpt_flags(sbi, CP_TRIMMED_FLAG)) {
> @@ -4557,13 +4561,24 @@ static int build_sit_entries(struct f2fs_sb_info *sbi)
>  	}
>  	up_read(&curseg->journal_rwsem);
>  
> -	if (!err && total_node_blocks != valid_node_count(sbi)) {
> +	if (err)
> +		return err;
> +
> +	if (sit_valid_blocks[NODE] != valid_node_count(sbi)) {
>  		f2fs_err(sbi, "SIT is corrupted node# %u vs %u",
> -			 total_node_blocks, valid_node_count(sbi));
> -		err = -EFSCORRUPTED;
> +			 sit_valid_blocks[NODE], valid_node_count(sbi));
> +		return -EFSCORRUPTED;
>  	}
>  
> -	return err;
> +	if (sit_valid_blocks[DATA] + sit_valid_blocks[NODE] >
> +				valid_user_blocks(sbi)) {
> +		f2fs_err(sbi, "SIT is corrupted data# %u %u vs %u",
> +			 sit_valid_blocks[DATA], sit_valid_blocks[NODE],
> +			 valid_user_blocks(sbi));
> +		return -EFSCORRUPTED;
> +	}
> +
> +	return 0;
>  }
>  
>  static void init_free_segmap(struct f2fs_sb_info *sbi)
> -- 
> 2.25.1


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
