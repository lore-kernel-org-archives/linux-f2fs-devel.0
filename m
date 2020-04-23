Return-Path: <SRS0=NCuU=6H=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0663C54FD0
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 23 Apr 2020 20:19:31 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE58E20776;
	Thu, 23 Apr 2020 20:19:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="mn2mQU/l";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="NaA4mRFi";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="YlXKqUtY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE58E20776
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1jRiJm-0001S6-Kw; Thu, 23 Apr 2020 20:19:30 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <jaegeuk@kernel.org>) id 1jRiJm-0001S0-1c
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 23 Apr 2020 20:19:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=3CwrKoUy9npEzB+oWF3o0C45R6kU/yM3kIECGP8cjzI=; b=mn2mQU/l+eQlKjV8SMeBSTVZJH
 XZ9Qv6YrF0nHDF17JdHzjItCelFTvkXZMipmSsOEgR4shhi/5g7yORAtUqZammoIAy2GtWPLo+0ok
 t+m7x6GaFJSQ+glSreY6IRt+ZplDCul8QoZULHCmzc1o0ozZRxryM3tf734SaQS7kMI8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=3CwrKoUy9npEzB+oWF3o0C45R6kU/yM3kIECGP8cjzI=; b=NaA4mRFi3CH1stuXHplS/4yrIX
 zgMfRif4F3XYM9ji0goRzO2I5rJYTrXCoYhop3yzCgzcx9Ysoq9L9PvQ/WdBaWRblGdnlXWpiP+Eo
 d5infMRgQskEmcXGuiplM6Z5JsF36HhdnMsnif9RQ4gNc+cNEY3SY8yPzwNdb8NSZhW8=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1jRiJk-00Be1V-UW
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 23 Apr 2020 20:19:29 +0000
Received: from localhost (unknown [104.132.1.66])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 49C0920724;
 Thu, 23 Apr 2020 20:19:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1587673163;
 bh=3B7rm8CALXCymxZMrU1vXmKnavJAvKdXmx+44ZjrMRw=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=YlXKqUtYSaZ7thtrlvu3u5iKkHqrjOlrbI0Q/nNAFW+nSjbOuZHIHQRTxk+obmoxq
 Aud695RzDE+eJ/PJ9o4OgSCA7A0K5lZnIpL0yF/pF/y/yS98ebMX44BTdd9798j5Kn
 2FlyouW0JJRI04xYim0ciZSmXWrhLxzyegDOKfvw=
Date: Thu, 23 Apr 2020 13:19:22 -0700
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Sayali Lokhande <sayalil@codeaurora.org>
Message-ID: <20200423201922.GB99191@google.com>
References: <1587636832-17939-1-git-send-email-sayalil@codeaurora.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1587636832-17939-1-git-send-email-sayalil@codeaurora.org>
X-Headers-End: 1jRiJk-00Be1V-UW
Subject: Re: [f2fs-dev] [PATCH] f2fs: Avoid double lock for cp_rwsem
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

On 04/23, Sayali Lokhande wrote:
> Call stack :
> f2fs_write_checkpoint()
> -> block_operations(sbi)
>     f2fs_lock_all(sbi);
>      down_write(&sbi->cp_rwsem); => write lock held
> <>
> -> f2fs_sync_node_pages()
>     if (is_inline_node(page))
>      flush_inline_data()
> 	page = f2fs_pagecache_get_page()
>          if (!page)
>            goto iput_out;
> 	iput_out:
> 	 iput(inode);
>           -> f2fs_evict_inode()
> 	      f2fs_truncate_blocks()
> 	       f2fs_lock_op()
> 	        down_read(&sbi->cp_rwsem); => read lock fail

How about this, since we don't actually need to flush inline_data?

diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 4da0d8713df5c..9af8d5319fdd3 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1871,7 +1871,7 @@ int f2fs_sync_node_pages(struct f2fs_sb_info *sbi,
                        }

                        /* flush inline_data */
-                       if (is_inline_node(page)) {
+                       if (is_inline_node(page) && io_type != FS_CP_NODE_IO) {
                                clear_inline_node(page);
                                unlock_page(page);
                                flush_inline_data(sbi, ino_of_node(page));

> 
> Signed-off-by: Sayali Lokhande <sayalil@codeaurora.org>
> ---
>  fs/f2fs/checkpoint.c | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
> index 5ba649e..5c504cf 100644
> --- a/fs/f2fs/checkpoint.c
> +++ b/fs/f2fs/checkpoint.c
> @@ -1219,21 +1219,19 @@ static int block_operations(struct f2fs_sb_info *sbi)
>  		goto retry_flush_quotas;
>  	}
>  
> -retry_flush_nodes:
>  	down_write(&sbi->node_write);
>  
>  	if (get_pages(sbi, F2FS_DIRTY_NODES)) {
>  		up_write(&sbi->node_write);
> +		f2fs_unlock_all(sbi);
>  		atomic_inc(&sbi->wb_sync_req[NODE]);
>  		err = f2fs_sync_node_pages(sbi, &wbc, false, FS_CP_NODE_IO);
>  		atomic_dec(&sbi->wb_sync_req[NODE]);
> -		if (err) {
> -			up_write(&sbi->node_change);
> -			f2fs_unlock_all(sbi);
> +		up_write(&sbi->node_change);
> +		if (err)
>  			goto out;
> -		}
>  		cond_resched();
> -		goto retry_flush_nodes;
> +		goto retry_flush_quotas;
>  	}
>  
>  	/*
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
