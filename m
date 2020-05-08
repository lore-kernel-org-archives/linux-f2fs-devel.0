Return-Path: <SRS0=+YV0=6W=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBE37C38A2A
	for <linux-f2fs-devel@archiver.kernel.org>; Fri,  8 May 2020 06:50:47 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB65F20870;
	Fri,  8 May 2020 06:50:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="E+dhxB7i";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="bw4juusN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB65F20870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1jWwqN-0001hg-6Q; Fri, 08 May 2020 06:50:47 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <yuchao0@huawei.com>) id 1jWwqL-0001hG-AO
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 08 May 2020 06:50:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 MIME-Version:Date:Message-ID:From:References:CC:To:Subject:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=sHDUQknQzFwixPPH047L4akre8hnA1SW40ZGMygeZy8=; b=E+dhxB7iH2JVylqV8+dpEt+vc8
 tqQFrHnn5J3W/4U0c4hFOjWH58YIT+ytu9cy21Vh2aO0EW4FjnTu+fi7NfqlGX+rMiA9x3DDYKen0
 CwwEXIw4Va80zAeLz2WWEB7xh7nTVKzDHt0VKQKv9FvbrmvO3P/H8S9Ww/DCwwRnRtKQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:
 Message-ID:From:References:CC:To:Subject:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=sHDUQknQzFwixPPH047L4akre8hnA1SW40ZGMygeZy8=; b=bw4juusNor1Bs6DRDXJSUvaN6K
 Izx4TNfBQ7URXGJCUJkfExK9YTvKp6qj3417EBcZA4JCqRmrO5WF9P/7prFud9xXjxgXch+7nLdBZ
 elF5J2W/OCyICstcx1EVigQD9h/cjCXKofSJz76PZjgis2zwfswB8U4eYGECiQaBi/sY=;
Received: from szxga06-in.huawei.com ([45.249.212.32] helo=huawei.com)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1jWwqI-001N5s-2a
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 08 May 2020 06:50:45 +0000
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id D6EC0D4A70CC61C5C7D9;
 Fri,  8 May 2020 14:50:15 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.205) with Microsoft SMTP Server (TLS) id 14.3.487.0; Fri, 8 May 2020
 14:50:11 +0800
To: Daeho Jeong <daeho43@gmail.com>, <linux-kernel@vger.kernel.org>,
 <linux-f2fs-devel@lists.sourceforge.net>, <kernel-team@android.com>
References: <20200508042506.143395-1-daeho43@gmail.com>
From: Chao Yu <yuchao0@huawei.com>
Message-ID: <4dfb73d9-03a0-bb2f-a112-1dd42db4d7bb@huawei.com>
Date: Fri, 8 May 2020 14:50:10 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20200508042506.143395-1-daeho43@gmail.com>
Content-Language: en-US
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
X-Headers-End: 1jWwqI-001N5s-2a
Subject: Re: [f2fs-dev] [PATCH] f2fs: remove race condition in releasing
 cblocks
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
Cc: Daeho Jeong <daehojeong@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2020/5/8 12:25, Daeho Jeong wrote:
> From: Daeho Jeong <daehojeong@google.com>
> 
> Now, if writing pages and releasing compress blocks occur
> simultaneously, and releasing cblocks is executed more than one time
> to a file, then total block count of filesystem and block count of the
> file could be incorrect and damaged.
> 
> We have to execute releasing compress blocks only one time for a file
> without being interfered by writepages path.
> 
> Signed-off-by: Daeho Jeong <daehojeong@google.com>
> ---
>  fs/f2fs/file.c | 31 ++++++++++++++++++++++++-------
>  1 file changed, 24 insertions(+), 7 deletions(-)
> 
> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> index 4aab4b42d8ba..a92bc51b9b28 100644
> --- a/fs/f2fs/file.c
> +++ b/fs/f2fs/file.c
> @@ -3488,6 +3488,7 @@ static int f2fs_release_compress_blocks(struct file *filp, unsigned long arg)
>  	pgoff_t page_idx = 0, last_idx;
>  	unsigned int released_blocks = 0;
>  	int ret;
> +	int writecount;
>  
>  	if (!f2fs_sb_has_compression(F2FS_I_SB(inode)))
>  		return -EOPNOTSUPP;

Before inode_lock(), there is one case we may jump to out label, in
this case, we may unlock inode incorrectly.

	if (!F2FS_I(inode)->i_compr_blocks)
		goto out;

> -
> -	inode_unlock(inode);
>  out:
> +	inode_unlock(inode);
> +
>  	mnt_drop_write_file(filp);

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
