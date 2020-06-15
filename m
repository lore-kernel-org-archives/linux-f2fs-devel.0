Return-Path: <SRS0=/SzK=74=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C111C433E0
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 15 Jun 2020 01:43:11 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB74C20714;
	Mon, 15 Jun 2020 01:43:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="aEgAeuef";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="XE2Dzcaa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB74C20714
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1jke9V-0006eM-21; Mon, 15 Jun 2020 01:43:09 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <yuchao0@huawei.com>) id 1jke9T-0006eF-Qt
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 15 Jun 2020 01:43:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:Reply-To:Cc:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ls9vkBhOKzv/MgwKZQmtKG9W4zKwpdh3FKyhpuwy/KU=; b=aEgAeuefUZuo29t0fSJ/2MeARe
 4yFgatzV+6Dk32ZvR2NUxH9GuRd7izk1MszGAZnCY2jcY5ed0ACWeLqHa0TDOVibtwV8MUi2NnenJ
 YLU9OK/OnGddrxDQsfzqrkcVQtuyIq68WZIVOmHftpHlTAOf7wMjVX6klOpjHmVFL9z8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:
 Message-ID:From:References:To:Subject:Sender:Reply-To:Cc:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=ls9vkBhOKzv/MgwKZQmtKG9W4zKwpdh3FKyhpuwy/KU=; b=XE2DzcaaQ/jW2ZroMTcCMMLsvk
 1GHmGyDvSXcSuKZaSw4KKF+HRsjiSiBD9heJOwZ7UOhQI8hRI7TEqAIQtw4YJ/z/06tNiXwvpq092
 BjEWuPTXNp26hdKDAmcOeQG2vROEjqFzzQNfaT/a1bUESY35Igxruz3Qi0LIcReS85VQ=;
Received: from szxga07-in.huawei.com ([45.249.212.35] helo=huawei.com)
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1jke9R-002sU1-Od
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 15 Jun 2020 01:43:07 +0000
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id 646C919DAD0A156F6D98
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 15 Jun 2020 09:42:44 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.204) with Microsoft SMTP Server (TLS) id 14.3.487.0; Mon, 15 Jun
 2020 09:42:34 +0800
To: Wei Fang <fangwei1@huawei.com>, <linux-f2fs-devel@lists.sourceforge.net>
References: <20200613042526.30382-1-fangwei1@huawei.com>
From: Chao Yu <yuchao0@huawei.com>
Message-ID: <4811f8f8-ea91-6cea-7bd6-a43c4a0cd6d4@huawei.com>
Date: Mon, 15 Jun 2020 09:42:33 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20200613042526.30382-1-fangwei1@huawei.com>
Content-Language: en-US
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
X-Headers-End: 1jke9R-002sU1-Od
Subject: Re: [f2fs-dev] [PATCH] f2fs: remove useless truncate in
 f2fs_collapse_range()
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hi Wei Fang,

On 2020/6/13 12:25, Wei Fang wrote:
> Since offset < new_size, no need to do truncate_pagecache() again
> with new_size.
> 
> Signed-off-by: Wei Fang <fangwei1@huawei.com>
> ---
>  fs/f2fs/file.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> index 3268f8dd59bb..43544817238b 100644
> --- a/fs/f2fs/file.c
> +++ b/fs/f2fs/file.c
> @@ -1368,13 +1368,12 @@ static int f2fs_collapse_range(struct inode *inode, loff_t offset, loff_t len)
>  		return ret;
>  
>  	/* write out all moved pages, if possible */
> -	down_write(&F2FS_I(inode)->i_mmap_sem);
>  	filemap_write_and_wait_range(inode->i_mapping, offset, LLONG_MAX);
> +
> +	down_write(&F2FS_I(inode)->i_mmap_sem);

I guess this patch mainly avoids useless page cache truncation, could we get rid of
lock coverage update here? or we can do it in separated patch if necessary.

Thanks,

>  	truncate_pagecache(inode, offset);
>  
>  	new_size = i_size_read(inode) - len;
> -	truncate_pagecache(inode, new_size);
> -
>  	ret = f2fs_truncate_blocks(inode, new_size, true);
>  	up_write(&F2FS_I(inode)->i_mmap_sem);
>  	if (!ret)
> 


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
