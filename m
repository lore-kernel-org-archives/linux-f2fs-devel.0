Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6FFDC36002
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 25 Mar 2025 02:20:10 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1twtth-0006g2-KB;
	Tue, 25 Mar 2025 02:20:09 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1twttg-0006fw-F2
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 25 Mar 2025 02:20:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=OXucu9VQefM6FjvE55QUW8kzyVOSM2ojPhEhEk884qI=; b=QAxtyFMptc5cD7XqwxSa+5tfk2
 gET8AmwQ2noZW2n3ucMtIPDYrEtRenABOp0grAYro2Lmc3AGQ/fXKqWbLaSU3xVq1ltbu2FGyYpyF
 JbDixi/64ecsFyrp2TG5D+qpkl3aI8PnZ4ASJcS4D9nbzoeF3YI+Kij0ml/YIPozYzxk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=OXucu9VQefM6FjvE55QUW8kzyVOSM2ojPhEhEk884qI=; b=AfHnEvevG15w6YxQ4ueF8FdLpX
 cAHHdXlAtuRWmIymiqoJgf/tdyafy+9GbDTRJJ9TWSPTV1L8ihgGTKAlmhguR5wu6RLUKd7Rqov9m
 SXlkZ0RS9pJVo2eCbtIUCE2wLqYPyRtb7i7c9iX0Az9zCxuzGgZrna5GKChS7a8kAJkE=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1twtta-0005zt-5N for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 25 Mar 2025 02:20:07 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 8B82D615EE;
 Tue, 25 Mar 2025 02:19:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EE2DC4CEE9;
 Tue, 25 Mar 2025 02:19:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1742869196;
 bh=wSctBKNRe6g0GRperENT7TTEViMYOGbWLRHvCzoCGg0=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
 b=qDaT83ysn6M7wv/3T6om+wUVRvMdiV1X/824PEvJ9DwSvyWlsz/8zlsMCOzYiHNjg
 A8F8WXR/zWX1iXSjKkG0YFKMt4JpEZnwK7k/WJ4aLd6rAQGAEOam1hYulf9YZSVYPJ
 p+BctDvU6XdaHYD8ezhKBOq9qfjZMcWZWdWe9WbRJ3x2fpm+TnB/yU8AMj5eymGETI
 c55dacx0zKvdINJkCTOlwA86Cj689khZsW9gG+cxS0GPoqIhXel4cp1NEKR5fh62H7
 fqv9Y8vDjWD2VLtVr8ZpkWF3d1mkxatIMX/lP8+2cibaCHwYS0RVuoP/R4h37Ko0hY
 Sly2uw+7GP+aA==
Message-ID: <84f619ec-50cc-4767-81d8-f100ebbc9ae9@kernel.org>
Date: Tue, 25 Mar 2025 10:19:52 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Daeho Jeong <daeho43@gmail.com>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
References: <20250321213328.1170234-1-daeho43@gmail.com>
Content-Language: en-US
In-Reply-To: <20250321213328.1170234-1-daeho43@gmail.com>
X-Headers-End: 1twtta-0005zt-5N
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: support zero sized file truncate
 for device aliasing files
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
Cc: Daeho Jeong <daehojeong@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 3/22/25 05:33, Daeho Jeong wrote:
> From: Daeho Jeong <daehojeong@google.com>
> 
> support a file truncation to zero size for device aliasing files.
> 
> Signed-off-by: Daeho Jeong <daehojeong@google.com>
> ---
> v2: make the extent length zero
> ---
>  fs/f2fs/file.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> index f92a9fba9991..69952f208086 100644
> --- a/fs/f2fs/file.c
> +++ b/fs/f2fs/file.c
> @@ -775,6 +775,11 @@ int f2fs_do_truncate_blocks(struct inode *inode, u64 from, bool lock)
>  		f2fs_update_time(sbi, REQ_TIME);
>  
>  		f2fs_put_page(ipage, 1);
> +
> +		write_lock(&et->lock);
> +		et->largest.len = 0;
> +		write_unlock(&et->lock);

f2fs_mark_inode_dirty_sync(inode, true); ?

Thanks,

> +
>  		goto out;
>  	}
>  
> @@ -1036,7 +1041,7 @@ int f2fs_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
>  
>  	if ((attr->ia_valid & ATTR_SIZE)) {
>  		if (!f2fs_is_compress_backend_ready(inode) ||
> -				IS_DEVICE_ALIASING(inode))
> +				(IS_DEVICE_ALIASING(inode) && attr->ia_size))
>  			return -EOPNOTSUPP;
>  		if (is_inode_flag_set(inode, FI_COMPRESS_RELEASED) &&
>  			!IS_ALIGNED(attr->ia_size,



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
