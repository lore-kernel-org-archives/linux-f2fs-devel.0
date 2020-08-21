Return-Path: <SRS0=Tg9B=B7=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B513C433E3
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 21 Aug 2020 09:04:36 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E437820578
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 21 Aug 2020 09:04:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="ce9GPKe9";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="Ow68REti"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E437820578
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1k92yP-0008O0-LH; Fri, 21 Aug 2020 09:04:33 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <yuchao0@huawei.com>) id 1k92yO-0008Nt-Fb
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 21 Aug 2020 09:04:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 MIME-Version:Date:Message-ID:From:References:CC:To:Subject:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=2LKgZQrEby3l3BHgREoiIub51G6RkRpwUofR7ZU63Oc=; b=ce9GPKe9Apx16ytpMppkJEL3Ca
 iw45YVn/y7ur+5dOJPyf+d/4k3if+mSkY1oO19/RnPVcJbfRl61Ab2SV1fuxX//WQeQSJLUxdakhY
 w/kzEU0GREdSGljcLKp8Duqi2+z81ZHuwZBor4cMX2ZXEBcFK024B8kCzXYOj4rpB9Yg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:
 Message-ID:From:References:CC:To:Subject:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=2LKgZQrEby3l3BHgREoiIub51G6RkRpwUofR7ZU63Oc=; b=Ow68REtiEmPlD1UnKeY1/fGZhK
 BNyORbKeXP6IYI/zmN09zl81tPbsm2zE/td5o31ZxB7eh54gcUjs23Z1KBf/pdsQ4sAz76V5d9sgc
 OkhnXWc9R39beJxTD+UokUhShu9Drnzp27UfCmGIvu5Yrih5wnFXlfcCyi62vUvyobv8=;
Received: from szxga04-in.huawei.com ([45.249.212.190] helo=huawei.com)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1k92yK-00EJUU-N9
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 21 Aug 2020 09:04:32 +0000
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id 01AF6E993C5C937A9016;
 Fri, 21 Aug 2020 17:03:38 +0800 (CST)
Received: from [10.136.114.67] (10.136.114.67) by smtp.huawei.com
 (10.3.19.213) with Microsoft SMTP Server (TLS) id 14.3.487.0; Fri, 21 Aug
 2020 17:03:34 +0800
To: Dan Robertson <dan@dlrobertson.com>, Jaegeuk Kim <jaegeuk@kernel.org>,
 Chao Yu <chao@kernel.org>
References: <20200821034732.18182-1-dan@dlrobertson.com>
 <20200821034732.18182-2-dan@dlrobertson.com>
From: Chao Yu <yuchao0@huawei.com>
Message-ID: <a530a1fa-5cc3-5c32-1f19-f52603a17f27@huawei.com>
Date: Fri, 21 Aug 2020 17:03:34 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20200821034732.18182-2-dan@dlrobertson.com>
Content-Language: en-US
X-Originating-IP: [10.136.114.67]
X-CFilter-Loop: Reflected
X-Headers-End: 1k92yK-00EJUU-N9
Subject: Re: [f2fs-dev] [PATCH 1/1] f2fs: check output position in move
 range ioctl
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
Cc: linux-f2fs-devel@lists.sourceforge.net
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2020/8/21 11:47, Dan Robertson wrote:
> When the move range ioctl is used, check the output position and ensure
> that it is a non-negative value. Without this check f2fs_get_dnode_of_data
> may hit a memmory bug.

Nice catch!

> 
> Signed-off-by: Dan Robertson <dan@dlrobertson.com>
> ---
>   fs/f2fs/file.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> index 8a422400e824..62f9625299ca 100644
> --- a/fs/f2fs/file.c
> +++ b/fs/f2fs/file.c
> @@ -2798,6 +2798,8 @@ static int f2fs_move_file_range(struct file *file_in, loff_t pos_in,
>   	}
>   
>   	ret = -EINVAL;
> +	if (pos_out < 0)
> +		goto out_unlock;

IMO, it would be better to check both pos_in and pos_out out of inode lock
coverage, maybe after encryption flag check?

Thanks,

>   	if (pos_in + len > src->i_size || pos_in + len < pos_in)
>   		goto out_unlock;
>   	if (len == 0)
> 
> 
> 
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
> .
> 


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
