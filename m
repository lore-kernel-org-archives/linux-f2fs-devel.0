Return-Path: <SRS0=NCuU=6H=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AF6CC55186
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 23 Apr 2020 13:14:07 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4154A2076C;
	Thu, 23 Apr 2020 13:14:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="Ftq98mwy";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="bk5G2wbM";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="I3MyzsA/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4154A2076C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1jRbg6-0007HB-Of; Thu, 23 Apr 2020 13:14:06 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <chao@kernel.org>) id 1jRbg5-0007H2-36
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 23 Apr 2020 13:14:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 MIME-Version:Date:Message-ID:From:Cc:References:To:Subject:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=wU3ViB8TR58UIUwMAieBlNJm3H88iCe9IPDt2eVIgVo=; b=Ftq98mwyuzYDHdmHyLE+ZUlnDK
 9Q/I+pGpFTg2f2+UnX5atfFNAf33dwEU6TAhScnbSrsw/ZQduQx6xDYP0j4UtNB9HXI+3xhYR6jkM
 X+/CW+AQI++prdcFvCAZPNE9uf5TnYvl4i3kTMwNbc9/r/NhXYyTlXpELrrIOeUVw/nc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:
 Message-ID:From:Cc:References:To:Subject:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=wU3ViB8TR58UIUwMAieBlNJm3H88iCe9IPDt2eVIgVo=; b=bk5G2wbMhl4FG6yT2js+au6ZTf
 xZyjVfjouR1Avc5vnUeGwMv0ldpf8PpSVf8AleTxr862Ps0npJpUXuzHwbD3WNhkfnB3pbVnfT8p5
 wCyqL7TRUnk+ChSgDn6oBPJkyADIbbG0NHuwoqc+0E96r6GLeneyu9Xt7FZfGsmKv0ns=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1jRbg0-007bl9-0N
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 23 Apr 2020 13:14:05 +0000
Received: from [192.168.0.107] (unknown [58.213.200.224])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id B2ECA2076C;
 Thu, 23 Apr 2020 13:13:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1587647634;
 bh=sCzr7jegZyFDnovWPo6SGkC+fWK3YOKcrQa3UVaVFq0=;
 h=Subject:To:References:Cc:From:Date:In-Reply-To:From;
 b=I3MyzsA/KeqgxHnqdOnj/WknM268wrDEcFc0gvdmJ4TpI1p9bFmeY8k8ze8uDR322
 Ne+9PICAq5KVQH46faqKUWzN7nNvblevNA6P+GBx38tiUQXTLHjnZ9A9d65hqw0cTR
 BrKfDDmmejLFS3rsfGNmbs9SKy5bMIOHbqNIvobQ=
To: Sayali Lokhande <sayalil@codeaurora.org>, jaegeuk@kernel.org,
 yuchao0@huawei.com, linux-f2fs-devel@lists.sourceforge.net
References: <1587636832-17939-1-git-send-email-sayalil@codeaurora.org>
From: Chao Yu <chao@kernel.org>
Message-ID: <4b1a9995-5c4c-c547-e42a-bc6047dfb7f6@kernel.org>
Date: Thu, 23 Apr 2020 21:13:43 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <1587636832-17939-1-git-send-email-sayalil@codeaurora.org>
X-Headers-End: 1jRbg0-007bl9-0N
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
Cc: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hi Sayali,

On 2020-4-23 18:13, Sayali Lokhande wrote:
> Call stack :
> f2fs_write_checkpoint()
> -> block_operations(sbi)
>     f2fs_lock_all(sbi);
>      down_write(&sbi->cp_rwsem); => write lock held
> <>

It looks the full race condition should be?

						Thread B
						- open()
						 - igrab()
						- write() write inline data
						- unlink()
> -> f2fs_sync_node_pages()
>     if (is_inline_node(page))
>      flush_inline_data()

	ilookup()

> 	page = f2fs_pagecache_get_page()
>          if (!page)
>            goto iput_out;
> 	iput_out:
						- close()
						 - iput()
> 	 iput(inode);
>           -> f2fs_evict_inode()
> 	      f2fs_truncate_blocks()
> 	       f2fs_lock_op()
> 	        down_read(&sbi->cp_rwsem); => read lock fail
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

Call up_write(&sbi->node_change) here could wake up threads earlier who hang on
this lock, how do you think?

Thanks,

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
>


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
