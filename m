Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7315C624CE
	for <linux-f2fs-devel@archiver.kernel.org>; Tue,  1 Sep 2026 00:48:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Content-Transfer-Encoding:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=l8qcG/iepOe3xc09RrrHxGAjXYRx+V/9PWIsSmm1jf4=; b=Y50yR3Releimz2ou4Hma9siW7o
	VMWRqZK4F7C+8TzqiGl6oHZDQwq5PNUzHZ/50LetTaEkBilUNvNHli/75Rqro8jXPkdPFiZFcHmhd
	fXRBeF1l9GMmRXWTA43JB0IeQKtfT6m0Pl40U+5DK8XpvrORIqlQJQBsNRz+dMBO/nt0=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1x1CgO-0003Gq-MA;
	Tue, 01 Sep 2026 00:48:58 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1x1CgL-0003Gg-UI
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 01 Sep 2026 00:48:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=4GM7YLcTrZAhuHNncgplMw79c7B1b/yStv4vzrmeQFA=; b=WvF7rzyQQxniUYrT9fevrn2n9z
 2csAox/bkUp14qcD+dnU0Uby7zVg6py/j4jy1b9jabJNv4L97oU1AJAPb4U8AgpgMJv3Xry8oYMRq
 dOFquT07RezkTQSJlHbkByMxiSc1hQ0dJIMNvG3eL0EqiDPsLTlNjazf/rbm57ZfR9aI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=4GM7YLcTrZAhuHNncgplMw79c7B1b/yStv4vzrmeQFA=; b=Pwe3bNVLy4uIeNffjfgajMFFjn
 nuwmjpKWjPGpm4lj223Bcx7XBiMbMWaVqIuGUHhKvsJWcTXeAkCe9+cc8BXHgmAA6Fb27S3jRbdd5
 lQTEoQTjswsU+AtK4+zzfFveqkORS7QnQgamrcDX4EwjPydp+WaywzlP3w233Ba5nppc=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1x1CgI-0005tw-US for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 01 Sep 2026 00:48:55 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 91A13407FB;
 Tue,  1 Sep 2026 00:48:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D9C41F000E9;
 Tue,  1 Sep 2026 00:48:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788223729;
 bh=4GM7YLcTrZAhuHNncgplMw79c7B1b/yStv4vzrmeQFA=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To;
 b=OUIIiXxjbvl5g33d+o3USzwKmcOTFhSB+GHaD5l4IAbNDVfRRUBB62ExE95xz6EVe
 p6KdPH61W29LOMQLAJJTX/ZBAaz7UoNmSjB3mgEO7dQ2Xr+CoL9vt+5PuVFeaCVaON
 cdrLbKu5xtNSuwh8ezuY+HoQxpStxxGttJyg4yG39n/Ro6uUCFix9d3uuzctxvPdla
 Q71UHXnwfhPXNTjEbMl/WoRlCLQMf4UfuRgU2MrNCMgPhAVFUaidwkfOaG5bmoqhUN
 TJYI5SZlvc2sCXZsORGmnf2RiH+k0waQJOO3BNGavVgd7wmGhHvc288VlDTsFeTAVY
 Ad4HDsJ0VOn4g==
Message-ID: <7ab51a29-a214-4e39-b684-4c4b3b87eca4@kernel.org>
Date: Tue, 1 Sep 2026 08:48:47 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Kelvin Zhang <zhangxp1998@gmail.com>,
 linux-f2fs-devel@lists.sourceforge.net
References: <cover.1788213716.git.zhangxp1998@gmail.com>
 <d3fa15836c409ac6028956c06dbe11a8e0149734.1788213716.git.zhangxp1998@gmail.com>
Content-Language: en-US
In-Reply-To: <d3fa15836c409ac6028956c06dbe11a8e0149734.1788213716.git.zhangxp1998@gmail.com>
X-Headers-End: 1x1CgI-0005tw-US
Subject: Re: [f2fs-dev] [PATCH v7 01/11] f2fs: initialize sb_info early in
 f2fs_fill_super
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
Cc: jaegeuk@kernel.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 9/1/26 06:05, Kelvin Zhang wrote:
> Previously, init_sb_info() was invoked late in f2fs_fill_super(), after
> processing superblock error tracking, mount options, and sb->s_maxbytes.
> 
> However, read_raw_super_block() reads the superblock folio directly
> from the block device mapping using folio page offsets. This makes the
> initial static sb_set_blocksize(sb, F2FS_BLKSIZE) call redundant.
> 
> Move init_sb_info() to execute immediately after sbi->raw_super is
> attached, allowing the block device block size to be set dynamically via
> sb_set_blocksize(sb, sbi->blocksize).
> 
> This early initialization also prepares for upcoming patches that add
> dynamically computed filesystem geometry fields, such as
> sbi->addrs_per_block and sbi->nids_per_block, to init_sb_info(). These
> fields are required by earlier initialization steps, including mount option
> consistency checks and sb->s_maxbytes computation.
> 
> Signed-off-by: Kelvin Zhang <zhangxp1998@gmail.com>
> ---
>   fs/f2fs/super.c | 16 ++++++++--------
>   1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> index 253a579e9d5b..2d9f5b77f815 100644
> --- a/fs/f2fs/super.c
> +++ b/fs/f2fs/super.c
> @@ -5125,12 +5125,6 @@ static int f2fs_fill_super(struct super_block *sb, struct fs_context *fc)
>   	}
>   	mutex_init(&sbi->flush_lock);
>   
> -	/* set a block size */
> -	if (unlikely(!sb_set_blocksize(sb, F2FS_BLKSIZE))) {
> -		f2fs_err(sbi, "unable to set blocksize");
> -		goto free_sbi;
> -	}
> -
>   	err = read_raw_super_block(sbi, &raw_super, &valid_super_block,
>   								&recovery);
>   	if (err)
> @@ -5138,6 +5132,14 @@ static int f2fs_fill_super(struct super_block *sb, struct fs_context *fc)
>   
>   	sb->s_fs_info = sbi;
>   	sbi->raw_super = raw_super;
> +	init_sb_info(sbi);
> +
> +	/* set a block size */
> +	if (!sb_set_blocksize(sb, sbi->blocksize)) {

It's better to keep unlikely.

if (unlikely(!sb_set_blocksize(sb, sbi->blocksize))) {

Thanks,

> +		f2fs_err(sbi, "unable to set blocksize %u", sbi->blocksize);
> +		err = -EINVAL;
> +		goto free_sb_buf;
> +	}
>   	sbi->max_atc_write_bio_size = UINT_MAX;
>   
>   	INIT_WORK(&sbi->s_error_work, f2fs_record_error_work);
> @@ -5217,8 +5219,6 @@ static int f2fs_fill_super(struct super_block *sb, struct fs_context *fc)
>   	if (err)
>   		goto free_bio_info;
>   
> -	init_sb_info(sbi);
> -
>   	err = f2fs_init_iostat(sbi);
>   	if (err)
>   		goto free_bio_info;



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
