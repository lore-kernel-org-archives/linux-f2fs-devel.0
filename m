Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC8FFC4345F
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 16 Apr 2024 16:53:46 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1rwm41-0004nQ-Pm;
	Tue, 16 Apr 2024 16:53:45 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <jaegeuk@kernel.org>) id 1rwm40-0004nI-54
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 16 Apr 2024 16:53:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=dyW9b2DzTc+q4RWL9x+ZL2HdEm+k2q5Iin0tq7ir8Ow=; b=hSQzSgnSjVpBmrrM+/iyppwS3Z
 fnUKl9IMfwsku5JvOwUk2vLmClW6ZwMBe2HAGL/107/amvwcMpn9aYXflfUOlUt4FbAxqXSX5kzrc
 HkMEDa7/X74rk3Fy5MnwZO/xPqK2BQ+FnHb2vK7Ggg2cuGktcMNPSGscKqrV9BpRbFUI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=dyW9b2DzTc+q4RWL9x+ZL2HdEm+k2q5Iin0tq7ir8Ow=; b=R6fSVh/aNVS9UJLq5iLnYqzqFJ
 Cb17w6Ft6C8OSEakTVZOj17fozmu2iVeGmxgLiwLYGHM9zdfxp6gExEyKvlGK11KP6RmyQRFLsyWt
 8ClQQWlcqq5Oszck3aKV0O/eHeWajCPXqg/Fycyp1mmWNymgNQ4UNUager4RUSKyyCBc=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1rwm3z-0006vp-MS for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 16 Apr 2024 16:53:44 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 2DF026124C;
 Tue, 16 Apr 2024 16:53:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9681DC113CE;
 Tue, 16 Apr 2024 16:53:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1713286412;
 bh=ezmFLIFNn/ZZBBwAdVS+xgDslQU7nT4nfmH+rCWjzn4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=NjTFfF5ZRQPjgO7avZxPkAG7vsZZEREB0wcobTxKIQIgMTu8WSMxQHbjNkP+nfGsA
 UZWpeiLm3oVsdp8XG1ojM2puTFljifv5y5WjpVvVtnMk/lyA5ErYtYWdmN2DeyA5Ti
 aQhwv/NKo88jNt6Lyy20xFIadXpLcyxAPTmGk039Tjjhl0RVVoR1ZQ9dTjcMcDUhwJ
 Hl3Fei7ScL6iMcl8H2ou/CoGvKAOeheASItF9frPuUq6YLQ1OCgKPNPtUQyeZ7n7Mb
 nKtaBH2cbdD1BG+TCk/AcdWGhNBciLZuBwrhsYrnJ9L20oxk/J4x25ZHJxs5WvKziF
 nE6Q29xRRDJKA==
Date: Tue, 16 Apr 2024 16:53:31 +0000
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Liao Yuanhong <liaoyuanhong@vivo.com>
Message-ID: <Zh6tC-fTZZlP5Dk2@google.com>
References: <20240415091650.27825-1-liaoyuanhong@vivo.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240415091650.27825-1-liaoyuanhong@vivo.com>
X-Headers-End: 1rwm3z-0006vp-MS
Subject: Re: [f2fs-dev] [PATCH] f2fs:add zone device priority option to the
 mount options
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
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

I don't see any point why we need this.

On 04/15, Liao Yuanhong wrote:
> Add a zone device priority option in the mount options. When enabled, the 
> file system will prioritize using zone devices free space instead of 
> conventional devices when writing to the end of the storage space.
> 
> Signed-off-by: Liao Yuanhong <liaoyuanhong@vivo.com>
> ---
>  fs/f2fs/f2fs.h    |  1 +
>  fs/f2fs/segment.c | 13 ++++++++++++-
>  fs/f2fs/super.c   | 20 ++++++++++++++++++++
>  3 files changed, 33 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index fced2b7652f4..e2438f7d2e13 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -116,6 +116,7 @@ extern const char *f2fs_fault_name[FAULT_MAX];
>  #define	F2FS_MOUNT_GC_MERGE		0x02000000
>  #define F2FS_MOUNT_COMPRESS_CACHE	0x04000000
>  #define F2FS_MOUNT_AGE_EXTENT_CACHE	0x08000000
> +#define F2FS_MOUNT_PRIORITY_ZONED	0x10000000
>  
>  #define F2FS_OPTION(sbi)	((sbi)->mount_opt)
>  #define clear_opt(sbi, option)	(F2FS_OPTION(sbi).opt &= ~F2FS_MOUNT_##option)
> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> index 4fd76e867e0a..adbe68a11fa5 100644
> --- a/fs/f2fs/segment.c
> +++ b/fs/f2fs/segment.c
> @@ -2697,7 +2697,18 @@ static int get_new_segment(struct f2fs_sb_info *sbi,
>  find_other_zone:
>  	secno = find_next_zero_bit(free_i->free_secmap, MAIN_SECS(sbi), hint);
>  	if (secno >= MAIN_SECS(sbi)) {
> -		secno = find_first_zero_bit(free_i->free_secmap,
> +		/* set hint to get section from zone device first */
> +		if (test_opt(sbi, PRIORITY_ZONED)) {
> +			hint = GET_SEC_FROM_SEG(sbi, first_zoned_segno(sbi));
> +			secno = find_next_zero_bit(free_i->free_secmap,
> +						MAIN_SECS(sbi), hint);
> +
> +			/* get section from clu if exceeding the size limit */
> +			if (secno >= MAIN_SECS(sbi))
> +				secno = find_first_zero_bit(free_i->free_secmap,
> +							MAIN_SECS(sbi));
> +		} else
> +			secno = find_first_zero_bit(free_i->free_secmap,
>  							MAIN_SECS(sbi));
>  		if (secno >= MAIN_SECS(sbi)) {
>  			ret = -ENOSPC;
> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> index a4bc26dfdb1a..2742978a100a 100644
> --- a/fs/f2fs/super.c
> +++ b/fs/f2fs/super.c
> @@ -126,6 +126,8 @@ enum {
>  	Opt_inline_data,
>  	Opt_inline_dentry,
>  	Opt_noinline_dentry,
> +	Opt_priority_zoned,
> +	Opt_nopriority_zoned,
>  	Opt_flush_merge,
>  	Opt_noflush_merge,
>  	Opt_barrier,
> @@ -204,6 +206,8 @@ static match_table_t f2fs_tokens = {
>  	{Opt_inline_data, "inline_data"},
>  	{Opt_inline_dentry, "inline_dentry"},
>  	{Opt_noinline_dentry, "noinline_dentry"},
> +	{Opt_priority_zoned, "priority_zoned"},
> +	{Opt_nopriority_zoned, "nopriority_zoned"},
>  	{Opt_flush_merge, "flush_merge"},
>  	{Opt_noflush_merge, "noflush_merge"},
>  	{Opt_barrier, "barrier"},
> @@ -805,6 +809,16 @@ static int parse_options(struct super_block *sb, char *options, bool is_remount)
>  		case Opt_noinline_dentry:
>  			clear_opt(sbi, INLINE_DENTRY);
>  			break;
> +#ifdef CONFIG_BLK_DEV_ZONED
> +		case Opt_priority_zoned:
> +			if (f2fs_sb_has_blkzoned(sbi))
> +				set_opt(sbi, PRIORITY_ZONED);
> +			break;
> +		case Opt_nopriority_zoned:
> +			if (f2fs_sb_has_blkzoned(sbi))
> +				clear_opt(sbi, PRIORITY_ZONED);
> +			break;
> +#endif
>  		case Opt_flush_merge:
>  			set_opt(sbi, FLUSH_MERGE);
>  			break;
> @@ -1990,6 +2004,12 @@ static int f2fs_show_options(struct seq_file *seq, struct dentry *root)
>  		seq_puts(seq, ",inline_dentry");
>  	else
>  		seq_puts(seq, ",noinline_dentry");
> +#ifdef CONFIG_BLK_DEV_ZONED
> +	if (test_opt(sbi, PRIORITY_ZONED))
> +		seq_puts(seq, ",priority_zoned");
> +	else
> +		seq_puts(seq, ",nopriority_zoned");
> +#endif
>  	if (test_opt(sbi, FLUSH_MERGE))
>  		seq_puts(seq, ",flush_merge");
>  	else
> -- 
> 2.25.1


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
