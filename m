Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DCDBD58065
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 25 Nov 2024 11:16:54 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1tFX5I-0004AV-IH;
	Mon, 25 Nov 2024 11:16:53 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1tFX5H-0004AN-MR
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 25 Nov 2024 11:16:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=xXlaBgmqj70sJQf8g97bHlICvG/fEDcSCxIH6cJsi4o=; b=UD+LshI0sg9GKbwU5ciqnf9HDf
 Q/sMonHvmoGHoY6n3aYioiBGaTZQMDc1j1pbYOB5qH+pKNJBu+xX7cnyJMZJpWTm9kVM6THNINmr6
 ZDFtCJijazBmVxWZCZu19cBIZYTAEhYsiVOBBtyqJrDJNnvXFxNsqM400Ba+uEEjURQA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=xXlaBgmqj70sJQf8g97bHlICvG/fEDcSCxIH6cJsi4o=; b=NtyFhd/KX3wKrAuuUgeYkh4aX8
 7AkG3c8gIKM5SFtVqSevlOoip6YRZkddfZbb8L8B4ZIHWVaMPBeyA+IAJ8f55fYWC2D2GjaHTQ3n+
 xYmyvMofD/yFDEeMD5Gld/kUdJQdxA/HnB4iVstT+fO5d54uHYi2szRfkuM7HMMG8euU=;
Received: from nyc.source.kernel.org ([147.75.193.91])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1tFX5H-0004Il-OA for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 25 Nov 2024 11:16:52 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id 0CE99A41571;
 Mon, 25 Nov 2024 11:14:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B6A7C4CED2;
 Mon, 25 Nov 2024 11:16:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1732533405;
 bh=MQjAuGpJVWbMJ1zAOHz6b/mSD730j2sw5ncxWR5rivY=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
 b=ZGxN0JJ8pb+aqiVRGlD0FH1DKLTavbUA3nhu6ujUI5x247t7kqr21gX1bGGbIB7Yy
 RvkMMyA9RsyPa+Pfn/ZdV1qoyKEC0Z/3wZy5/2HOY/wYtBKVUDsJRv3ERvBpma83Rs
 i0hu4f4BWpzsAkaZwOUgHGOXR9bNb/fglkRSA5k5ELe1SVbvtHCVObnLC55IAJ3LUW
 d79hpXotSchIBfybxIdQaAFLVMMa9bz1ZvVeS8meW8kBNM00ho1nJ5TGw7mule+aWV
 7y2YymZAGlQ6cQdQ1oJ5RTwUH6m1AF35LQZy3/m0Y7tDkY5Ub9f0lHo0qGI/X+aY64
 +xEgGA806jnnw==
Message-ID: <1652260c-7657-4f40-ac79-027666f512f0@kernel.org>
Date: Mon, 25 Nov 2024 19:16:41 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Leo Stone <leocstone@gmail.com>, jaegeuk@kernel.org
References: <20241124010459.23283-1-leocstone@gmail.com>
Content-Language: en-US
In-Reply-To: <20241124010459.23283-1-leocstone@gmail.com>
X-Headers-End: 1tFX5H-0004Il-OA
Subject: Re: [f2fs-dev] [PATCH] f2fs: Add check for deleted inode
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
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2024/11/24 9:04, Leo Stone wrote:
> The syzbot reproducer mounts a f2fs image, then tries to unlink an
> existing file. However, the unlinked file already has a link count of 0
> when it is read for the first time in do_read_inode().
> 
> Add a check to sanity_check_inode() for i_nlink == 0.
> 
> #syz test
> 
> Reported-by: syzbot+b01a36acd7007e273a83@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=b01a36acd7007e273a83
> Fixes: 4c8ff7095bef ("f2fs: support data compression")

Hello Leo,

I'm fine w/ this change, but I didn't get it, how did above commit introduce
this bug?

Thanks,

> Signed-off-by: Leo Stone <leocstone@gmail.com>
> ---
>   fs/f2fs/inode.c | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
> index 1ed86df343a5..65f1dc32f173 100644
> --- a/fs/f2fs/inode.c
> +++ b/fs/f2fs/inode.c
> @@ -372,6 +372,12 @@ static bool sanity_check_inode(struct inode *inode, struct page *node_page)
>   		return false;
>   	}
>   
> +	if (inode->i_nlink == 0) {
> +		f2fs_warn(sbi, "%s: inode (ino=%lx) has a link count of 0",
> +			  __func__, inode->i_ino);
> +		return false;
> +	}
> +
>   	return true;
>   }
>   



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
