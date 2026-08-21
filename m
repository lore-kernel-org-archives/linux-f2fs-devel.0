Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F9F5C5DF94
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 21 Aug 2026 15:26:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:References:
	Message-ID:To:Date:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=h92LKtWtZCRjFKuPaR0AscCxYQ9s2yZ6XleQxL4UHQc=; b=PAE69okeYMd/wRD1cZkhWYf1fr
	yiGMydHxiJKQI/I1/K/tFUntqsPNgGTKlhF9DfIVqipZ4X0WyzZSnhtnQoEg4Buj1JGPEVI6pbUwk
	Etyr9QrAEo4tzYpTnVKHRfQoRMiU6PnTPOz/vpWphZo9PbksIc2VDR1LQWkpUgUipJqY=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wxR8f-00026y-5W;
	Fri, 21 Aug 2026 15:26:37 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <jaegeuk@kernel.org>) id 1wxR8K-00026e-1l
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 21 Aug 2026 15:26:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=zgvC+ZCXI1rwTwuEGY8JXlZpfQViE/VMlFibVJTRVQM=; b=ktrfVT+bK3TDE6t6g0DK6r0Ub3
 PO0kfzO7aKMK9OzTjGYktneAjphokf9S8G8ggw0p1p07XXtfMWjKLXtepI28UCAMGXTnF7FO1b2OF
 KPWGy7Q3HD/yxQ10hlDuPtoSbLKTiX75dL9mciEFJMfdKxTNZ+xm6/i5M84DyzwM0YP0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=zgvC+ZCXI1rwTwuEGY8JXlZpfQViE/VMlFibVJTRVQM=; b=gIOHmP2+ajsxq8yYiSX6WuZYsq
 WMI01uj/WhnKgmdncVJg7uzH+2fe/gS5cq99Wu0+36tyMMU/td6LT820MVyvgfkI6o4M4zCBSbax9
 IuD36YrQOUkBud6YMGK1+Xa6yP6Wt8y2QUVeuhPzvq6GgsTS9CcxeF5rrA9JpbnbcWTo=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wxR8I-0004Jt-E4 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 21 Aug 2026 15:26:16 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id BF05561126;
 Fri, 21 Aug 2026 15:26:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38B4E1F000E9;
 Fri, 21 Aug 2026 15:26:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787325968;
 bh=zgvC+ZCXI1rwTwuEGY8JXlZpfQViE/VMlFibVJTRVQM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=Emjrd3K/rVNG/oKNRDM19baqYHO7vIUsrG4htuMywOdGnnE80NR1RE/tE8bB55XJo
 folzNw7ofcYiwW7BP/NBFEhI9ht1wMkcs470L4QUlpGHZfYq0zc7Lco7vJiUGWZN3a
 wbK6axPvBp0axPUTfsXjFTcQI0ponpmSDzh7hXWsIAOjysISrJ8LaX5ZAfzIHSo/mz
 +grbu7BGeK0BqPoOVO9kUFykyDskqwfhRcUlCtme0rv/01g3RdyBq7pzfUBc2kPvW1
 WjUEc78QpEuyIpqzyFpkjWO8Pa1xZGDIbObrXPnYPiXXutwx0bfzFdRQZA68HqGuYZ
 j8D+lPYkIdeUA==
Date: Fri, 21 Aug 2026 15:26:06 +0000
To: Daeho Jeong <daeho43@gmail.com>
Message-ID: <aohuDgLbl5SSnJ9T@google.com>
References: <20260821141742.2678300-1-daeho43@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260821141742.2678300-1-daeho43@gmail.com>
X-Headers-End: 1wxR8I-0004Jt-E4
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix error handling on device alias
 check in rename and unlink
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
Cc: Daeho Jeong <daehojeong@google.com>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net,
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>, kernel-team@android.com,
 stable@kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 08/21, Daeho Jeong wrote:
> From: Daeho Jeong <daehojeong@google.com>
> 
> In f2fs_rename() and f2fs_unlink(), directly returning -EPERM when
> encountering a device aliasing file bypasses the cleanup path.
> 
> Fix this by setting err to -EPERM and jumping to the proper cleanup
> labels (out_dir and out) instead of returning immediately.
> 
> Fixes: a737e409a3d6 ("f2fs: support dynamic reserve/release for device aliasing")
> Cc: stable@kernel.org

Applied without Fixes and stable, since the original patch has not been
upstreamed.

> Reported-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> Signed-off-by: Daeho Jeong <daehojeong@google.com>
> Reviewed-by: Chao Yu <chao@kernel.org>
> ---
>  fs/f2fs/namei.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
> index 784f636244e1..b9b15c5d28de 100644
> --- a/fs/f2fs/namei.c
> +++ b/fs/f2fs/namei.c
> @@ -571,8 +571,10 @@ static int f2fs_unlink(struct inode *dir, struct dentry *dentry)
>  
>  	trace_f2fs_unlink_enter(dir, dentry);
>  
> -	if (IS_DEVICE_ALIASING(inode))
> -		return -EPERM;
> +	if (IS_DEVICE_ALIASING(inode)) {
> +		err = -EPERM;
> +		goto out;
> +	}
>  
>  	if (unlikely(f2fs_cp_error(sbi))) {
>  		err = -EIO;
> @@ -1025,8 +1027,10 @@ static int f2fs_rename(struct mnt_idmap *idmap, struct inode *old_dir,
>  	}
>  
>  	if (new_inode) {
> -		if (IS_DEVICE_ALIASING(new_inode))
> -			return -EPERM;
> +		if (IS_DEVICE_ALIASING(new_inode)) {
> +			err = -EPERM;
> +			goto out_dir;
> +		}
>  
>  		err = -ENOTEMPTY;
>  		if (old_is_dir && !f2fs_empty_dir(new_inode))
> -- 
> 2.55.0.766.g2966f0265a-goog
> 
> 
> 
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
