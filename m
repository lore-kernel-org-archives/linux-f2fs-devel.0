Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43E7CC433F5
	for <linux-f2fs-devel@archiver.kernel.org>; Fri,  6 May 2022 00:53:34 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.94.2)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1nmmDr-0007eW-DD; Fri, 06 May 2022 00:53:30 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <jaegeuk@kernel.org>) id 1nmmDq-0007eL-6a
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 06 May 2022 00:53:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=W4qy/vudMhSGD8brwSb4qSWoFA29i2qlwowm5rnKYuw=; b=lQaVhVaKDtovhJM0Xkup3q/Fus
 BPL5OQkOktI8pyuT76B12XuIbSlv8OHRqzxMmShmvYWPNycK0lGZuxJOa16KqNxWJc/gNbe94ueyg
 3wLJdfkzNbjNsizOPfwPsKyZeHNP7s4/n3qKLcyZhOpmgeJAPLziPIpoL2i8w9vtwTBc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=W4qy/vudMhSGD8brwSb4qSWoFA29i2qlwowm5rnKYuw=; b=HxLp6dBFT4HTwBZGJnKywhiKth
 b+fSeZtAtvT/FBprV+myhH/W9Aq2uV9BIevZaHy0T2ouTyI9pJa9i5P/mjgK+MIYrxxQp9vXF1pkh
 NbgH9OhkXNRN8h0TnbLvQ+BQkg76GRbNctoOplNJFPYV7SiI43A+f2ToJgq9i2TxwfAc=;
Received: from ams.source.kernel.org ([145.40.68.75])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.94.2)
 id 1nmmDn-0004xJ-EP
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 06 May 2022 00:53:29 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 882CFB82C77;
 Fri,  6 May 2022 00:53:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D4D2C385A4;
 Fri,  6 May 2022 00:53:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1651798394;
 bh=CNebCznOeFAnc8qF6ffneuM6vdU/dd66WedXNIT0M8w=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=dovigtcA3VXNPZG51qgWyU8q0YoWECeHnTSiLjpmlFf0s6FHu8gmNtyzrjM3QjwdE
 ZTEkQutbBE7obZqc+pVF9qImpxq6To8kdZ0zyDJSK2zvXzH5tdN2baXbYz9dOseVSy
 2JmaTI+vriQVf/XM0MQt+z8+kK39heOSmrfX4csfZfvVenpQ5E5fl6rmMdWgMdn/vz
 Qg0OpLoFDUWCbeuoSXX7EKBjRr3F3xXuMMo/RnxlqR2tEv6W8Mxx8afKsDVwx9Kjs9
 CL8W2vdRZ72MswASqWHK89vVKYTYPWZzIQcF1f59iJlwwFPJydG8Aa6YLAWABubtbg
 m90KJo5ySD3dA==
Date: Thu, 5 May 2022 17:53:12 -0700
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Chao Yu <chao@kernel.org>
Message-ID: <YnRxeJbYNC9eHgtr@google.com>
References: <20220505141507.6616-1-chao@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220505141507.6616-1-chao@kernel.org>
X-Headers-End: 1nmmDn-0004xJ-EP
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: fix to do sanity check on
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

On 05/05, Chao Yu wrote:
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
> v2:
> - adjust check condition according to the case Jaegeuk mentioned.
>  fs/f2fs/segment.c | 24 +++++++++++++++++++++---
>  1 file changed, 21 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> index 3a3e2cec2ac4..942d6d8c18e6 100644
> --- a/fs/f2fs/segment.c
> +++ b/fs/f2fs/segment.c
> @@ -4462,6 +4462,7 @@ static int build_sit_entries(struct f2fs_sb_info *sbi)
>  	unsigned int readed, start_blk = 0;
>  	int err = 0;
>  	block_t total_node_blocks = 0;
> +	block_t total_data_blocks = 0;

How about something like "sit_valid_blocks[DATA | NODE]"?

>  
>  	do {
>  		readed = f2fs_ra_meta_pages(sbi, start_blk, BIO_MAX_VECS,
> @@ -4488,6 +4489,8 @@ static int build_sit_entries(struct f2fs_sb_info *sbi)
>  			seg_info_from_raw_sit(se, &sit);
>  			if (IS_NODESEG(se->type))
>  				total_node_blocks += se->valid_blocks;
> +			else
> +				total_data_blocks += se->valid_blocks;
>  
>  			if (f2fs_block_unit_discard(sbi)) {
>  				/* build discard map only one time */
> @@ -4529,6 +4532,8 @@ static int build_sit_entries(struct f2fs_sb_info *sbi)
>  		old_valid_blocks = se->valid_blocks;
>  		if (IS_NODESEG(se->type))
>  			total_node_blocks -= old_valid_blocks;
> +		else
> +			total_data_blocks -= old_valid_blocks;
>  
>  		err = check_block_count(sbi, start, &sit);
>  		if (err)
> @@ -4536,6 +4541,8 @@ static int build_sit_entries(struct f2fs_sb_info *sbi)
>  		seg_info_from_raw_sit(se, &sit);
>  		if (IS_NODESEG(se->type))
>  			total_node_blocks += se->valid_blocks;
> +		else
> +			total_data_blocks += se->valid_blocks;
>  
>  		if (f2fs_block_unit_discard(sbi)) {
>  			if (is_set_ckpt_flags(sbi, CP_TRIMMED_FLAG)) {
> @@ -4557,13 +4564,24 @@ static int build_sit_entries(struct f2fs_sb_info *sbi)
>  	}
>  	up_read(&curseg->journal_rwsem);
>  
> -	if (!err && total_node_blocks != valid_node_count(sbi)) {
> +	if (err)
> +		return err;
> +
> +	if (total_node_blocks != valid_node_count(sbi)) {
>  		f2fs_err(sbi, "SIT is corrupted node# %u vs %u",
>  			 total_node_blocks, valid_node_count(sbi));
> -		err = -EFSCORRUPTED;
> +		return -EFSCORRUPTED;
>  	}
>  
> -	return err;
> +	if (total_data_blocks + total_node_blocks >
> +				valid_user_blocks(sbi)) {
> +		f2fs_err(sbi, "SIT is corrupted data# %u %u vs %u",
> +			 total_data_blocks, total_node_blocks,
> +			 valid_user_blocks(sbi));
> +		return -EFSCORRUPTED;
> +	}
> +
> +	return 0;
>  }
>  
>  static void init_free_segmap(struct f2fs_sb_info *sbi)
> -- 
> 2.32.0


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
