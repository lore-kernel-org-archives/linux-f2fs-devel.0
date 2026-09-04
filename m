Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEC29C624DB
	for <linux-f2fs-devel@archiver.kernel.org>; Fri,  4 Sep 2026 01:58:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Content-Transfer-Encoding:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=uO71/eLktEyEulE2ni3MKJ+2PMRPGVr0cgLgUd5ebCA=; b=et3Aez92jcgRHTRIfTBuXpxs69
	15hPwN3JZDV7lmY8V5v3Bx8danFUCkT5VR9nFzk65CmrsZSnUAYOwhw8be/2szNesFcx84pn3fPpa
	48NLdLTzLM6U+OAsdnPMp2R+1FXfWJ6G88CUTqYnm7M4rroExNpNbBUtbsUJ9ZIjyhPk=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1x2JC4-0003gB-Tc;
	Fri, 04 Sep 2026 01:58:14 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1x2JC3-0003g1-D9
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 04 Sep 2026 01:58:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=5jRoPi4cTptirujGl8tv0MSWyBrX8XHDykK0aOfJU6s=; b=TUEaDAmChiYnFU5noaHWvwjXXm
 ++/0HkpsrULg6R8ijWC3QnRPHH/qBgLqH+iynpZulHcYCC6ct9WS88k8ykRjUx8qRNY+pPgfXQm4W
 lQd1YWYeditj+cAwTdMWCXa9fWvCVCpntbZXCvQ5hcScHSea1z7LmOJ54jhqxlXJV8Yk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=5jRoPi4cTptirujGl8tv0MSWyBrX8XHDykK0aOfJU6s=; b=aWwLhCWIZ9ORipBMy5wFF+1r7M
 nsvBKPUqjqT+T+W0PrSFWX30IuG5jwWqCvrx3fW5nUiA9gY1YJeaIZQHAzU8yfD5bsY0brfqvmo0/
 90KW7Ne0rwbuzX6CIgqSO+rq2ncvsszCy4M6sstGsgtWYOOtwY90NSfEGQ6OrDQpEuGU=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1x2JBz-0002yJ-2X for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 04 Sep 2026 01:58:12 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id ADD4C40258;
 Fri,  4 Sep 2026 01:58:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 388E51F000E9;
 Fri,  4 Sep 2026 01:58:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788487085;
 bh=5jRoPi4cTptirujGl8tv0MSWyBrX8XHDykK0aOfJU6s=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To;
 b=GHzZFcibisKvc3McRLctaer1hVGVRWmT9Gg5rW4UE5d+dHNsCPkRsSL02nz0FZGfS
 q7fjUQRn02KHmiFBm6vqLi8XLjQQ06i2HRnhAdWqxAEeIuHBqlrntJJqXTVApFx9M5
 oHoSBfQlrNIpbsP7dbje+/RtXhCvhRfaICoyLcjb8ghH8FAiZ02jj9J0erXYfSIoBl
 8+me/L2HyES8KCLKuTKnOF2plowHOYYGOat4f/VVHAhZr2i1BgRKX1w5uSgLvN3SWD
 67Z0ji2zhw60pehjW31wwjIC9FRtrJ1zAc93b927kiFm8ZXw3W86QQvRRkb6v81o/y
 FWX+0lX/YnQNw==
Message-ID: <e491de3c-b377-4530-9ecf-f12796705779@kernel.org>
Date: Fri, 4 Sep 2026 09:58:02 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Kelvin Zhang <zhangxp1998@gmail.com>,
 linux-f2fs-devel@lists.sourceforge.net
References: <cover.1788479509.git.zhangxp1998@gmail.com>
 <3a430f1eaa7b07583d83828477adff5a90ede9e8.1788479509.git.zhangxp1998@gmail.com>
Content-Language: en-US
In-Reply-To: <3a430f1eaa7b07583d83828477adff5a90ede9e8.1788479509.git.zhangxp1998@gmail.com>
X-Headers-End: 1x2JBz-0002yJ-2X
Subject: Re: [f2fs-dev] [PATCH v9 05/11] f2fs: describe dentry block layout
 dynamically
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
Cc: Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 9/4/26 07:56, Kelvin Zhang wrote:
> An on-disk directory block contains a bitmap, reserved padding, an
> array of directory entries (struct f2fs_dir_entry), and matching filename
> slots. A fixed compile-time structure couples their offsets to 4KB blocks
> and relies on static reserved-space definitions.
> 
> Remove struct f2fs_dentry_block and compute region offsets (bitmap
> bytes, directory-entry count, and filename slots) dynamically from the
> filesystem block size. Access directory blocks through
> struct f2fs_dentry_ptr views initialized with the runtime geometry.
> 
> Update directory operations, inline dentry handling, and recovery paths
> to use the dynamic block layout. No functional change is introduced for
> 4KB blocks.
> 
> Signed-off-by: Kelvin Zhang <zhangxp1998@gmail.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
