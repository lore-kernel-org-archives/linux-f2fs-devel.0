Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF057C0219E
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 12 Feb 2025 03:24:40 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1ti3Mc-0002GV-UM;
	Wed, 12 Feb 2025 03:24:38 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <jaegeuk@kernel.org>) id 1ti3MY-0002GL-AE
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 12 Feb 2025 03:24:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=3cF4jpPCbXZ21mBmW53+xVNbKvU91O0wI+8QggPdDcM=; b=YIUeE0Yx7F3o6yTOx53MGdxUUs
 qoEGkU/+XcaqKOdBz1CWc3zj2/bl99wpDVy+tKhE+3mKKQc7hR20GLu5OhNzY9jGCQbXBAhZQNKwY
 TbANgXBEl3EbeDp2Q9+mCFM29f/ax49iIVhjD+YiwW/zC7a9zNES3bMXGm9025wLGFTE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=3cF4jpPCbXZ21mBmW53+xVNbKvU91O0wI+8QggPdDcM=; b=TGJitEQKJBPSh6S3+F93Oa6/JF
 hVqZpvKlHdlW0fn91pIBL1JEoU646XZ01x1ZMzVjKlJHA5LY5jsvduwXttWyhsLRFmhestyGOyuk7
 plU+580/HCQi/VXGfhVp4oOwHhqh+4JFTzunYquZX1bymFE1vwCwN5BBZKUtHZ4tbauk=;
Received: from nyc.source.kernel.org ([147.75.193.91])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1ti3MX-0003JP-JU for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 12 Feb 2025 03:24:34 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id 76599A402F6;
 Wed, 12 Feb 2025 03:22:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F01FC4CEDF;
 Wed, 12 Feb 2025 03:24:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1739330667;
 bh=dy4F+MGp9D9JulVy4MJqpsD5oPjbC4M5GjqzusIpkoE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=vMdZqc0EAKiHlAQPK8T0z5op3FSxOPWxOGBBaDFnCJqddUE7Yr4NLuE8C81/I1U4X
 7H9Dx0iKGAfA8p3KYCNiNuKPli2Q0UVUkvQi9p9z38weM0lqBCS7Iz5pxGwNl6hCVm
 ZNEMDbh9He8jjMLlZry8iV6HqjpNrpsh8VsA/WGrfqKU4ZyINHGHgTD5WKW++AmtsW
 yJsEZYJKkCuIByPh0Bb3YmeydYq/HyeytdSI8NLoafVX6IvBs0D11oHokb2bQ00age
 UsUKLlercwaGpdm6eFuxcLZpqmpuX//bzV1LeQpOG+R6kzKkVmNw0UZq6QJQm41Kwa
 NSwDYY8OXmR+g==
Date: Wed, 12 Feb 2025 03:24:25 +0000
To: Chao Yu <chao@kernel.org>
Message-ID: <Z6wUaT91OnABzNfQ@google.com>
References: <20250211071725.457343-1-chao@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250211071725.457343-1-chao@kernel.org>
X-Headers-End: 1ti3MX-0003JP-JU
Subject: Re: [f2fs-dev] [PATCH v3 RESEND] f2fs: add check for deleted inode
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
Cc: syzbot+b01a36acd7007e273a83@syzkaller.appspotmail.com,
 linux-kernel@vger.kernel.org, Leo Stone <leocstone@gmail.com>,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 02/11, Chao Yu wrote:
> From: Leo Stone <leocstone@gmail.com>
> 
> The syzbot reproducer mounts a f2fs image, then tries to unlink an
> existing file. However, the unlinked file already has a link count of 0
> when it is read for the first time in do_read_inode().
> 
> Add a check to sanity_check_inode() for i_nlink == 0.
> 
> [Chao Yu: rebase the code]
> Reported-by: syzbot+b01a36acd7007e273a83@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=b01a36acd7007e273a83
> Fixes: 39a53e0ce0df ("f2fs: add superblock and major in-memory structure")
> Signed-off-by: Leo Stone <leocstone@gmail.com>
> Signed-off-by: Chao Yu <chao@kernel.org>
> ---
> - no logic change, just rebase the code to last dev-test branch
>  fs/f2fs/inode.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
> index d6ad7810df69..543fb942bec1 100644
> --- a/fs/f2fs/inode.c
> +++ b/fs/f2fs/inode.c
> @@ -386,6 +386,12 @@ static bool sanity_check_inode(struct inode *inode, struct page *node_page)
>  		}
>  	}
>  
> +	if (inode->i_nlink == 0) {
> +		f2fs_warn(sbi, "%s: inode (ino=%lx) has a link count of 0",
> +			  __func__, inode->i_ino);
> +		return false;
> +	}

This gives a wrong EFSCORRUPTED when recoverying orphan inodes.

f2fs_recover_orphan_inodes
-> f2fs_iget_retry
 -> orphan inode can have i_nlink = 0.

> +
>  	return true;
>  }
>  
> -- 
> 2.48.1.502.g6dc24dfdaf-goog


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
