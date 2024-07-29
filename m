Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CC6AC3DA4A
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 29 Jul 2024 16:26:56 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1sYTD5-0004Qy-07;
	Mon, 29 Jul 2024 16:26:55 +0000
Received: from [172.30.29.67] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <jaegeuk@kernel.org>) id 1sYTCy-0004Qm-Qh
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 29 Jul 2024 16:26:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=7tPF5hQTdvJr7s09udfA9aFZDg02J5Z+OX1p3w8swgs=; b=ifUhvrZSvwSvrMCjswdsaUEQt4
 MIq2XlNa8Z8dynnkA+vH8d22pQeTefh7agkLGqsENdKA38UmpJom7pLs4HCuPXNnkMqEfxDWWXk7Q
 nMhj9+seDDb4YVWlGwiFkWFZ1jkzX6IikXZ0sYaDGU+2wvcKVe6jT2PLBh6Vbl3Q6zQE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=7tPF5hQTdvJr7s09udfA9aFZDg02J5Z+OX1p3w8swgs=; b=GhTJK84S0U+1iPKIp620y4/JYz
 eazFtRYMQAZdgx89raO94/0lylNyxJWmdEuynCakqICNVS6uxVBwARHvF1nXv/+sk+ndVgUFS8bux
 n1Fze3wBo0spbgS6L4c4UH7C6ogVvkHhPCYMhqJFnYhcPS2CxwvL8TL6voOSbpRyV1+s=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1sYTCy-0001ZL-27 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 29 Jul 2024 16:26:48 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id B477761B75
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 29 Jul 2024 16:26:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F781C32786;
 Mon, 29 Jul 2024 16:26:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1722270402;
 bh=5DJAmjjO5CX30yVxzqsOVYfxU3wFszmuKdtYvT0Qc30=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=b33yKb7/aN0jAQSJGC/gG5idmAse7XkoN74GQYfcYO4Q+RdnKCeI1zwhrNE/FBFn5
 ksjKCofXvc5hbk2s6HzwDTNV7WiEiWmI+HxrgnV82ab4pI5M+GU9oWWFbESeZwMmhv
 TttP8AqQS5L9LN28zruVhhTQIOsn6EarOtZjg/nz34XmCqTTyUWKz3BjWI2N2em4jZ
 HLVSaCDR2UXKjzm80nytePkIzcwIUQMozzXYhwzWmVF5lRdUNjrjY+Oiz6lTB/xeDs
 IYTccFPuvpsRe6b9D8Z1HJttamvUXJW+vtJ0cn0OTXBdrD0WxKUrVdsx025baU5Ka+
 wAMieBRXfx7vQ==
Date: Mon, 29 Jul 2024 16:26:40 +0000
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Chao Yu <chao@kernel.org>
Message-ID: <ZqfCwDcg7nvJPenf@google.com>
References: <20240726012204.1306174-1-chao@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240726012204.1306174-1-chao@kernel.org>
X-Headers-End: 1sYTCy-0001ZL-27
Subject: Re: [f2fs-dev] [PATCH v2 3/4] f2fs: atomic: fix to truncate
 pagecache before on-disk metadata truncation
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

On 07/26, Chao Yu wrote:
> We should always truncate pagecache while truncating on-disk data.
> 
> Fixes: a46bebd502fe ("f2fs: synchronize atomic write aborts")
> Signed-off-by: Chao Yu <chao@kernel.org>
> ---
> v2:
> - fix to use cow_inode instead of inode
>  fs/f2fs/file.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> index 6c62f76474d1..54886ddcb8ab 100644
> --- a/fs/f2fs/file.c
> +++ b/fs/f2fs/file.c
> @@ -2202,6 +2202,7 @@ static int f2fs_ioc_start_atomic_write(struct file *filp, bool truncate)
>  		F2FS_I(fi->cow_inode)->atomic_inode = inode;
>  	} else {
>  		/* Reuse the already created COW inode */
> +		truncate_setsize(fi->cow_inode, 0);

What if the below truncation failed?

>  		ret = f2fs_do_truncate_blocks(fi->cow_inode, 0, true);
>  		if (ret) {
>  			f2fs_up_write(&fi->i_gc_rwsem[WRITE]);
> -- 
> 2.40.1


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
