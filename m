Return-Path: <SRS0=nR8U=5J=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73D4BC10DCE
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 24 Mar 2020 06:11:08 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F2A52073E
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 24 Mar 2020 06:11:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="Gq8rqtKp";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="R2PxWvEt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F2A52073E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1jGcmH-0007TI-SE; Tue, 24 Mar 2020 06:11:05 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <yuchao0@huawei.com>) id 1jGcmG-0007TA-7k
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 24 Mar 2020 06:11:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 MIME-Version:Date:Message-ID:From:References:CC:To:Subject:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=FJBUtx8b5k2LGfrz9RHs2AGXfHlxbyE7W3i8bOzq6Aw=; b=Gq8rqtKpG9+ziMxVmyuTCRlDW9
 cNCXjg5A4zZW7GkgS+s/IzDCdDfOA9U1nFu0seOfyPU7X+xUthH2VoEBltj3wnK233BgYbQVOBFsX
 aHa5COq4aAIy9oDHH8O6BIBRfh25/W+mylyDifXTkJjtTl7iQOfX18bWDdzuM2HooiPg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:
 Message-ID:From:References:CC:To:Subject:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=FJBUtx8b5k2LGfrz9RHs2AGXfHlxbyE7W3i8bOzq6Aw=; b=R2PxWvEtBB3vBdLJbgFaiTfnWK
 xG8d6wWxhIHV+Q2iBwqRQQdL0l07aWmAui4GtN2AWbTZ7BpIyDdZgyJ3Ho3q47SslKoRZDhzscfVV
 F5i8XfzKQzltgx+l5cwUkwaFg4Y70XqM72nNvYSgj1t4C2q2gb99FyKfCCJsN3HjN+lE=;
Received: from szxga05-in.huawei.com ([45.249.212.191] helo=huawei.com)
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1jGcmC-001ehX-7B
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 24 Mar 2020 06:11:04 +0000
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id 44FDDFF01C84AB352606;
 Tue, 24 Mar 2020 14:10:50 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.201) with Microsoft SMTP Server (TLS) id 14.3.487.0; Tue, 24 Mar
 2020 14:10:46 +0800
To: <jaegeuk@kernel.org>
References: <20200229104906.12061-1-yuchao0@huawei.com>
From: Chao Yu <yuchao0@huawei.com>
Message-ID: <6aab59b9-6e33-5b01-acf8-ccbacd9318e3@huawei.com>
Date: Tue, 24 Mar 2020 14:10:46 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20200229104906.12061-1-yuchao0@huawei.com>
Content-Language: en-US
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
X-Headers-End: 1jGcmC-001ehX-7B
Subject: Re: [f2fs-dev] [PATCH] f2fs: remove redundant compress inode check
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

Jaegeuk,

Missed to apply this patch?

On 2020/2/29 18:49, Chao Yu wrote:
> due to f2fs_post_read_required() has did that.
> 
> Signed-off-by: Chao Yu <yuchao0@huawei.com>
> ---
>  fs/f2fs/f2fs.h | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index f4bcbbd5e9ed..882f9ad3445b 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -4006,8 +4006,6 @@ static inline bool f2fs_force_buffered_io(struct inode *inode,
>  		return true;
>  	if (f2fs_is_multi_device(sbi))
>  		return true;
> -	if (f2fs_compressed_file(inode))
> -		return true;
>  	/*
>  	 * for blkzoned device, fallback direct IO to buffered IO, so
>  	 * all IOs can be serialized by log-structured write.
> 


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
