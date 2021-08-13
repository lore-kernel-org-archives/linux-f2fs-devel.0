Return-Path: <SRS0=A+6L=NE=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADBCEC4338F
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 13 Aug 2021 13:42:44 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5873760F11;
	Fri, 13 Aug 2021 13:42:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 5873760F11
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.92.3)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1mEXSM-0002Cx-4e; Fri, 13 Aug 2021 13:42:42 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.3)
 (envelope-from <chao@kernel.org>) id 1mEXSK-0002Cq-LQ
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 13 Aug 2021 13:42:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=6VlkyTSGxqV3VpZ7GtRkAq4wcvxzXKSEIRafuKkZsB0=; b=fHOa+iEMHTZWqSZ68+Rc0q4lVU
 iLf9gMWa/nj9HC5WYrq6CglcVSZkt6xWss6HnY2pJQOfvMzwXQIjJ26SxXEkCMur9ENXwPEvllzy/
 3iow3DFcd3MiVfTxExiJcKwa1KQq+Rf58BrCNTFIKXizOCLMT5DQGva/gTgWwAnPfPzk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:
 Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=6VlkyTSGxqV3VpZ7GtRkAq4wcvxzXKSEIRafuKkZsB0=; b=FKMReJkRAY0zLQqRU1dhg05dp8
 2hY/pGZy8qhsCLGDQ3SF0AWBc6NopaXVdSz7V0MOTTguD67mmztpjMesEJCq7f6Vmmt7o5b0fvkvV
 P4Wrd41a3Y6lWZZmDu0C4BaYD85EETcQTorJXYC7HGv+DFjyzxizi9YF/pKMKVWKz+qA=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.3)
 id 1mEXSB-005DVx-S6
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 13 Aug 2021 13:42:40 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id EDE3960F11;
 Fri, 13 Aug 2021 13:42:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1628862141;
 bh=Radl4pPmym29zKnvSluX6pjnKXnMALkTFS4XBhELDe0=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=Ovxa1ucL3c7DZ6Dbvwem0ix7QmgczSXzEQeDcG/qdzEEkDZvcKJQQolAhTTOjkBk5
 ngR+o65v4bb8E/DMkLU6CtUKa5GZTCe2bq75AFw/LagEpAewVlrYayLF6u6Dais0lk
 k1yGDwlOzEbaOREoNaDx4zPTkCGld3MC/ZErM9lmhy/eIpgQnL1OJljKiIAthCRmtp
 GjWcdosb1ciYUaYMfiIChgmK9g9huWfPUGbr+BhuHt15rWCUA6C+rw8azZOsLbNZUh
 yWlH3QZVklvo/cFWcPEcDnLZNSu6YtMvTJ8yorMWCBv3jGLtG6lG9/hFrKZGAm96bb
 GfQAPHGFfryUg==
To: Yangtao Li <frank.li@vivo.com>, jaegeuk@kernel.org
References: <20210813101132.441389-1-frank.li@vivo.com>
From: Chao Yu <chao@kernel.org>
Message-ID: <746edfbc-ae29-b84b-f83f-4093a398804b@kernel.org>
Date: Fri, 13 Aug 2021 21:42:15 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210813101132.441389-1-frank.li@vivo.com>
Content-Language: en-US
X-Headers-End: 1mEXSB-005DVx-S6
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: Don't create discard thread when
 device not support realtime discard
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
Cc: linux-kernel@vger.kernel.org, Fengnan Chang <changfengnan@vivo.com>,
 linux-f2fs-devel@lists.sourceforge.net
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2021/8/13 18:11, Yangtao Li wrote:
> From: Fengnan Chang <changfengnan@vivo.com>
> 
> Don't create discard thread when device not support realtime discard.
> 
> Signed-off-by: Fengnan Chang <changfengnan@vivo.com>
> Signed-off-by: Yangtao Li <frank.li@vivo.com>
> ---
>   fs/f2fs/f2fs.h    |  1 +
>   fs/f2fs/segment.c | 29 +++++++++++++++++++++--------
>   fs/f2fs/super.c   | 34 ++++++++++++++++++++++++++++++++--
>   3 files changed, 54 insertions(+), 10 deletions(-)
> 
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index d24fd5045712..60a408af53a3 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -3483,6 +3483,7 @@ int f2fs_flush_device_cache(struct f2fs_sb_info *sbi);
>   void f2fs_destroy_flush_cmd_control(struct f2fs_sb_info *sbi, bool free);
>   void f2fs_invalidate_blocks(struct f2fs_sb_info *sbi, block_t addr);
>   bool f2fs_is_checkpointed_data(struct f2fs_sb_info *sbi, block_t blkaddr);
> +int f2fs_start_discard_thread(struct f2fs_sb_info *sbi);
>   void f2fs_drop_discard_cmd(struct f2fs_sb_info *sbi);
>   void f2fs_stop_discard_thread(struct f2fs_sb_info *sbi);
>   bool f2fs_issue_discard_timeout(struct f2fs_sb_info *sbi);
> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> index ca9876a6d396..b83a4a1e5023 100644
> --- a/fs/f2fs/segment.c
> +++ b/fs/f2fs/segment.c
> @@ -2112,7 +2112,27 @@ void f2fs_clear_prefree_segments(struct f2fs_sb_info *sbi,
>   wakeup:
>   	wake_up_discard_thread(sbi, false);
>   }

Need a blank line here.

> +int f2fs_start_discard_thread(struct f2fs_sb_info *sbi)
> +{
> +	dev_t dev = sbi->sb->s_bdev->bd_dev;
> +	struct discard_cmd_control *dcc = SM_I(sbi)->dcc_info;
> +	int err = 0;
>   
> +	if (!dcc)
> +		return -EINVAL;
> +	if (!f2fs_realtime_discard_enable(sbi))
> +		return 0;
> +
> +	dcc->f2fs_issue_discard = kthread_run(issue_discard_thread, sbi,
> +				"f2fs_discard-%u:%u", MAJOR(dev), MINOR(dev));
> +	if (IS_ERR(dcc->f2fs_issue_discard)) {
> +		err = PTR_ERR(dcc->f2fs_issue_discard);
> +		kfree(dcc);
> +		SM_I(sbi)->dcc_info = NULL;
> +		return err;
> +	}
> +	return err;
> +}

Ditto,

>   static int create_discard_cmd_control(struct f2fs_sb_info *sbi)
>   {
>   	dev_t dev = sbi->sb->s_bdev->bd_dev;

Need to remove unused dev.

> @@ -2153,14 +2173,7 @@ static int create_discard_cmd_control(struct f2fs_sb_info *sbi)
>   	init_waitqueue_head(&dcc->discard_wait_queue);
>   	SM_I(sbi)->dcc_info = dcc;
>   init_thread:
> -	dcc->f2fs_issue_discard = kthread_run(issue_discard_thread, sbi,
> -				"f2fs_discard-%u:%u", MAJOR(dev), MINOR(dev));
> -	if (IS_ERR(dcc->f2fs_issue_discard)) {
> -		err = PTR_ERR(dcc->f2fs_issue_discard);
> -		kfree(dcc);
> -		SM_I(sbi)->dcc_info = NULL;
> -		return err;
> -	}
> +	err = f2fs_start_discard_thread(sbi);
>   
>   	return err;

return f2fs_start_discard_thread(sbi);

err becomes unused.

>   }
> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> index 84cd085020cd..ff19c30cd6a1 100644
> --- a/fs/f2fs/super.c
> +++ b/fs/f2fs/super.c
> @@ -2101,12 +2101,15 @@ static int f2fs_remount(struct super_block *sb, int *flags, char *data)
>   	bool need_restart_gc = false, need_stop_gc = false;
>   	bool need_restart_ckpt = false, need_stop_ckpt = false;
>   	bool need_restart_flush = false, need_stop_flush = false;
> +	bool need_enable_ckpt = false, need_disable_ckpt = false;
>   	bool no_extent_cache = !test_opt(sbi, EXTENT_CACHE);
>   	bool enable_checkpoint = !test_opt(sbi, DISABLE_CHECKPOINT);
>   	bool no_io_align = !F2FS_IO_ALIGNED(sbi);
>   	bool no_atgc = !test_opt(sbi, ATGC);
> +	bool no_discard = !test_opt(sbi, DISCARD);
>   	bool no_compress_cache = !test_opt(sbi, COMPRESS_CACHE);
>   	bool block_unit_discard = f2fs_block_unit_discard(sbi);
> +	struct discard_cmd_control *dcc;
>   #ifdef CONFIG_QUOTA
>   	int i, j;
>   #endif
> @@ -2274,7 +2277,7 @@ static int f2fs_remount(struct super_block *sb, int *flags, char *data)
>   	} else {
>   		err = f2fs_create_flush_cmd_control(sbi);
>   		if (err)
> -			goto restore_ckpt;
> +			goto restore_ckpt_thread;
>   		need_stop_flush = true;
>   	}
>   
> @@ -2283,8 +2286,28 @@ static int f2fs_remount(struct super_block *sb, int *flags, char *data)
>   			err = f2fs_disable_checkpoint(sbi);
>   			if (err)
>   				goto restore_flush;
> +			need_enable_ckpt = true;
>   		} else {
>   			f2fs_enable_checkpoint(sbi);
> +			need_disable_ckpt = true;
> +		}
> +	}
> +
> +	if (no_discard == !!test_opt(sbi, DISCARD)) {
> +		if (test_opt(sbi, DISCARD)) {
> +			err = f2fs_start_discard_thread(sbi);
> +			if (err)
> +				goto restore_ckpt;
> +

Unneeded blank line.

> +		} else {
> +			dcc = SM_I(sbi)->dcc_info;
> +			if (!dcc) {
> +				err = -EINVAL;
> +				goto restore_ckpt;
> +			}
> +			f2fs_stop_discard_thread(sbi);
> +			if (unlikely(atomic_read(&dcc->discard_cmd_cnt)))

I don't think this is an unlikely case.

> +				f2fs_issue_discard_timeout(sbi);

How about starting/stopping discard thread after flush thread status update,
leaving complicated checkpoint disabling status change in the last stage of
remount().

Thanks,

>   		}
>   	}
>   
> @@ -2302,6 +2325,13 @@ static int f2fs_remount(struct super_block *sb, int *flags, char *data)
>   	adjust_unusable_cap_perc(sbi);
>   	*flags = (*flags & ~SB_LAZYTIME) | (sb->s_flags & SB_LAZYTIME);
>   	return 0;
> +restore_ckpt:
> +	if (need_enable_ckpt) {
> +		f2fs_enable_checkpoint(sbi);
> +	} else if (need_disable_ckpt) {
> +		if (f2fs_disable_checkpoint(sbi))
> +			f2fs_warn(sbi, "checkpoint has been enable");
> +	}
>   restore_flush:
>   	if (need_restart_flush) {
>   		if (f2fs_create_flush_cmd_control(sbi))
> @@ -2310,7 +2340,7 @@ static int f2fs_remount(struct super_block *sb, int *flags, char *data)
>   		clear_opt(sbi, FLUSH_MERGE);
>   		f2fs_destroy_flush_cmd_control(sbi, false);
>   	}
> -restore_ckpt:
> +restore_ckpt_thread:
>   	if (need_restart_ckpt) {
>   		if (f2fs_start_ckpt_thread(sbi))
>   			f2fs_warn(sbi, "background ckpt thread has stopped");
> 


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
