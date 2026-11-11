Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20100606A321
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 11 Nov 2026 11:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=AvF1Tpfy;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=Zs9JNfiC;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=SNlk3nrP;
	dkim=neutral header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mXNCcv7A
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=eYFy9KETgJ03sLl3AelaWV/VlvhlHDbEzf34hyP3oF0=; b=AvF1TpfyJQ07H8
	FzPjPLhP/tr9QQEPSoUWcXj1QZ3GScM8WHjeB3DIjWLN48+2ZeaHefBDYbNzyZWoNspvY6ZMQZmvC
	rzMr6Ik93YXKVDOsNCuIW3sbY1jApx/ndQDK0bi5I5rHbnPL+uRYDlgHCnAGGIzI0NrekFwMk/F8H
	WKA=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xR6cu-000000008Pm-47xn;
	Wed, 11 Nov 2026 11:36:28 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <chao@kernel.org>) id 1xR6ct-000000008PY-3ee5
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 11 Nov 2026 11:36:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=6ef3BW3A5FVT5x/mpefs4145su/1qFLNbKYUDqCerLU=; b=Zs9JNfiCy5YMTutjp3U1feiFKk
 7Si/at1fZT0rhZj0OVykYU3LGr4dLacX4tePbqvvPUAdfQ2fcKIsHDk9Nl8vM4aD+eUeNNQjFTmB3
 OPQkF2Vc+kJcgZ9RY/Du6hG3MvkHfdiHXUh+BjEJsNciTn1LSdYWfJWzoBC5ola3xB0M=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=6ef3BW3A5FVT5x/mpefs4145su/1qFLNbKYUDqCerLU=; b=SNlk3nrPFf5yiks2BymYI2OiOi
 fPNZhSGifOLbLdsXvQ5c9diVpKcq/HOwFrsK1FFRQl1B9ClLvqoM2iASw9oo9DPyRJA5c3eGd8R04
 rKZe7JppxcxSOrtmYO4I+S/m8F31Ot1c0tW9HTKCc8u17dUa4Kqo9JWJdZPiSytB8How=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xR6cs-000000003uY-119X
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 11 Nov 2026 11:36:27 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id DA7E843DA0;
 Wed, 11 Nov 2026 11:36:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDE291F00A05;
 Wed, 11 Nov 2026 11:36:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794396980;
 bh=6ef3BW3A5FVT5x/mpefs4145su/1qFLNbKYUDqCerLU=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To;
 b=mXNCcv7AXNopwNMQPTesiR1qQrAdv3fbAmc58SeIoRuUlniu3GMcK149CgUQ90txD
 XJuyrmzfEh1U+r4J7KnFuOkDkEsa2MGHAgxQN6L4s/7uGP9Si0geyi+LwXQpnSYGdX
 i1+syBY8hEyma1ohntJTd0yb86lKIP0i4jea5AOOEf+TCRXYCfuU0BYdad/+dyzXyx
 hDyKV8g7BF4VdO1cfrvjOD5Ru1zWjYa/RJFFCv9JNvVjIkTwWwOEuf48rMZveFWzQV
 +FEeyFpjxsi39MM0K1pVgb43DcRPSmyOUKboscRThZJzKK/XKIPeivshnWSfXXdMqS
 s624B+RcZyPsw==
Message-ID: <f26ac11b-cf63-4627-9d12-e1216fc0135e@kernel.org>
Date: Wed, 11 Nov 2026 19:36:18 +0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Hungyu Lin <dennylin0707@gmail.com>, jaegeuk@kernel.org
References: <20261108045722.12091-1-dennylin0707@gmail.com>
Content-Language: en-US
In-Reply-To: <20261108045722.12091-1-dennylin0707@gmail.com>
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xR6cs-000000003uY-119X
Subject: Re: [f2fs-dev] [PATCH] f2fs: require inode ownership for ioctls
 that change per-file state
X-BeenThere: linux-f2fs-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
From: Chao Yu via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Chao Yu <chao@kernel.org>
Cc: linux-kernel@vger.kernel.org, daehojeong@google.com,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-17.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/8/26 12:57, Hungyu Lin wrote:
> F2FS_IOC_RELEASE_COMPRESS_BLOCKS, F2FS_IOC_RESERVE_COMPRESS_BLOCKS,
> F2FS_IOC_SET_PIN_FILE and F2FS_IOC_IO_PRIO change the state of the inode
> behind the file descriptor without checking who the caller is. Any user
> who can open a file, even read-only, can:

How about checking write permission instead of inode_owner_or_capable()?

	if (inode_permission(file_mnt_idmap(filp), inode, MAY_WRITE))
		return -EACCES;

> 
>  - release its compressed blocks, after which writes to the file fail
>    with -EPERM until the blocks are reserved again or the file is
>    truncated to zero;
>  - reserve released blocks again, which consumes free space;
>  - pin it while it has no data blocks, after which writes that extend
>    the file fail with -EIO;
>  - unpin it, so that garbage collection may move blocks that a user of
>    F2FS_IOC_SET_PIN_FILE expects to stay in place;
>  - set its write I/O priority hint.
> 
> F2FS_IOC_SET_PIN_FILE checked inode_owner_or_capable() when it was
> added. Commit aff7b628ac2d ("f2fs: set pin_file under CAP_SYS_ADMIN")
> replaced that with a CAP_SYS_ADMIN check, and commit b13bdf03bb80
> ("f2fs: allow all the users to pin a file") then removed the
> CAP_SYS_ADMIN check, leaving the ioctl without any permission check.
> 
> The atomic write ioctls require both FMODE_WRITE and
> inode_owner_or_capable(). Requiring FMODE_WRITE here would break
> f2fs_io, which releases and reserves compressed blocks through a

I think we can fix f2fs_io.

> read-only file descriptor, and Android, which releases them the same
> way. Require only inode_owner_or_capable(), as F2FS_IOC_SET_PIN_FILE
> originally did, so that only the owner or a caller with CAP_FOWNER can
> change this state. Users can still pin their own files.
> 
> Fixes: b13bdf03bb80 ("f2fs: allow all the users to pin a file")
> Fixes: ef8d563f184e ("f2fs: introduce F2FS_IOC_RELEASE_COMPRESS_BLOCKS")
> Fixes: c75488fb4d82 ("f2fs: introduce F2FS_IOC_RESERVE_COMPRESS_BLOCKS")
> Fixes: 5f95c1812a65 ("f2fs: add ioctl to get IO priority hint")

IMO, we'd better to fix them in separated patches.

Thanks,

> Cc: stable@vger.kernel.org
> Signed-off-by: Hungyu Lin <dennylin0707@gmail.com>
> ---
>  fs/f2fs/file.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> index e2c0f5083313..0730de36554a 100644
> --- a/fs/f2fs/file.c
> +++ b/fs/f2fs/file.c
> @@ -3664,6 +3664,9 @@ static int f2fs_ioc_set_pin_file(struct file *filp, unsigned long arg)
>  	if (!pin && IS_DEVICE_ALIASING(inode))
>  		return -EOPNOTSUPP;
>  
> +	if (!inode_owner_or_capable(file_mnt_idmap(filp), inode))
> +		return -EACCES;
> +
>  	ret = mnt_want_write_file(filp);
>  	if (ret)
>  		return ret;
> @@ -3982,6 +3985,9 @@ static int f2fs_ioc_io_prio(struct file *filp, unsigned long arg)
>  	if (!S_ISREG(inode->i_mode) || level >= F2FS_IOPRIO_MAX)
>  		return -EINVAL;
>  
> +	if (!inode_owner_or_capable(file_mnt_idmap(filp), inode))
> +		return -EACCES;
> +
>  	inode_lock(inode);
>  	F2FS_I(inode)->ioprio_hint = level;
>  	inode_unlock(inode);
> @@ -4235,6 +4241,9 @@ static int f2fs_release_compress_blocks(struct file *filp, unsigned long arg)
>  	if (f2fs_readonly(sbi->sb))
>  		return -EROFS;
>  
> +	if (!inode_owner_or_capable(file_mnt_idmap(filp), inode))
> +		return -EACCES;
> +
>  	ret = mnt_want_write_file(filp);
>  	if (ret)
>  		return ret;
> @@ -4430,6 +4439,9 @@ static int f2fs_reserve_compress_blocks(struct file *filp, unsigned long arg)
>  	if (f2fs_readonly(sbi->sb))
>  		return -EROFS;
>  
> +	if (!inode_owner_or_capable(file_mnt_idmap(filp), inode))
> +		return -EACCES;
> +
>  	ret = mnt_want_write_file(filp);
>  	if (ret)
>  		return ret;



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
