Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3C3FC61DD3
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 31 Aug 2026 06:51:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Content-Transfer-Encoding:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=e3/1T7iQSS/F0Cmgwp819K6fm31xCpFRpotWGeUdWW4=; b=hKRpnPJhbFOc4eJurfhd+nUC5Z
	Q/VQQfUQz/06VwB4RnN25jFvCATAX41/RcOB6Ba1amBDICNZFj7KxN6GuljtKJZz06gL+LTt8j/F8
	C+EwCJsW48Y4PkrPaPJ24N1UwPb0guLBiyTmye22oQcICE5PvwAC5YdLd5vANBihYugo=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1x0vrr-0003jz-Bu;
	Mon, 31 Aug 2026 06:51:40 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1x0vrq-0003js-IQ
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 31 Aug 2026 06:51:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=lnm5Hm8KxB87ch6ERXweKmqJnt+emfIA8af2LTRWWyQ=; b=grEccK72TQlUEw3SEGZau7Yeod
 F/6LX+e08jsOZ9Ak3c0YPdkA3KEIY1u9+S2y4hQ+YcS8d2kevhB84UHNkRqW2PRAp2/7oi4Q/Q/3a
 UEpcF28pnzc6iKoH8uii7QfNw9/UF/Ry8zKDx0byt9+SLL/SUercvX4wApFGJrLv3mX0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=lnm5Hm8KxB87ch6ERXweKmqJnt+emfIA8af2LTRWWyQ=; b=W83NFwekg+6n7FoKdPcdhDYT+u
 j3enkoTBKxy1YjDK/B5XeEucR1Qh6Y0NHIMxDAts5udNCJL7aDFbNnCOUf+ASUOe1i/UQjlSKl1R2
 P/o0GeDQ9IqWf9ySbHpKdonOjKa/IakcYGalh0EpOZ+7pwA/rusZWNk2aiUQqZURF9X0=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1x0vrl-0001Iy-00 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 31 Aug 2026 06:51:40 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 902D0439E8;
 Mon, 31 Aug 2026 06:51:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BB991F000E9;
 Mon, 31 Aug 2026 06:51:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788159091;
 bh=lnm5Hm8KxB87ch6ERXweKmqJnt+emfIA8af2LTRWWyQ=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To;
 b=RU8uoJnWIVv35qX8gYwwPMWQ4zGtXMg1Un6ImInQsH1oi2yJnMDjpO+sJ0uMOB6Md
 B/Q49ViGlBIZezU1pG9EwXx5EBSboq6YiOYV0oJjEDA5AhLONCm4KhoaeVIzVRplo5
 DKp03i9eW3nXQUjz2PylcgF5sEQAIbfio1HHOS71q1u/2R2e328Dz09yP4d27wAdjf
 m3AKnVRJhmPtzXiE3eTgLBpNnDRm2X5vBycydiPAIs5KTyVB92GpetkozOuN1FrC+Z
 MYtJNyKvQ4VwWQzWquPUWWceF4uMpTccua619eIBWa5h0mXy6XSbfDOPR5I9L7q3hR
 EITzWc7Lb09Hg==
Message-ID: <69df3654-4f5d-4f8e-8860-62e545897192@kernel.org>
Date: Mon, 31 Aug 2026 14:51:29 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Xinping Zhang <zhangxp1998@gmail.com>,
 linux-f2fs-devel@lists.sourceforge.net
References: <CAH=xXfEFL7w7nsU3xjNubKJ1soYMqT-DbJBuyzfEX4Rv3rdFEA@mail.gmail.com>
 <CAH=xXfHL4bWFMVa=-a8sRuR_bn9VcaFRo+X3eeZfedSa0C7dww@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAH=xXfHL4bWFMVa=-a8sRuR_bn9VcaFRo+X3eeZfedSa0C7dww@mail.gmail.com>
X-Headers-End: 1x0vrl-0001Iy-00
Subject: Re: [f2fs-dev] [PATCH v3 01/11] f2fs: initialize sb_info early in
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

On 8/31/26 13:32, Xinping Zhang wrote:
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
> @@ -5125,12 +5125,6 @@ static int f2fs_fill_super(struct super_block
> *sb, struct fs_context *fc)
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
> @@ -5138,6 +5132,14 @@ static int f2fs_fill_super(struct super_block

Kelvin,

I can't apply the patch in my git tree, it notices that the patch is corrupted:

Applying: f2fs: initialize sb_info early in f2fs_fill_super
error: patch fragment without header at .git/rebase-apply/patch:6: @@ -5138,6 +5132,14 @@ static int f2fs_fill_super(struct super_block
Patch failed at 0001 f2fs: initialize sb_info early in f2fs_fill_super

I suspect your email client force to wrap long line after "super_block".

Thanks,

> *sb, struct fs_context *fc)
 > >   	sb->s_fs_info = sbi;
>   	sbi->raw_super = raw_super;
> +	init_sb_info(sbi);
> +
> +	/* set a block size */
> +	if (!sb_set_blocksize(sb, sbi->blocksize)) {
> +		f2fs_err(sbi, "unable to set blocksize %u", sbi->blocksize);
> +		err = -EINVAL;
> +		goto free_sb_buf;
> +	}
>   	sbi->max_atc_write_bio_size = UINT_MAX;
> 
>   	INIT_WORK(&sbi->s_error_work, f2fs_record_error_work);
> @@ -5217,8 +5219,6 @@ static int f2fs_fill_super(struct super_block
> *sb, struct fs_context *fc)
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
