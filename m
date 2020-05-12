Return-Path: <SRS0=rqbO=62=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64A2AC47255
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 12 May 2020 01:44:50 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 30143206DD
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 12 May 2020 01:44:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="CGoAXo6z";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="X91SMUdx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30143206DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1jYJyT-0003Mh-7q; Tue, 12 May 2020 01:44:49 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <yuchao0@huawei.com>) id 1jYJyK-0003MM-Vw
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 12 May 2020 01:44:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 MIME-Version:Date:Message-ID:From:References:CC:To:Subject:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=npwdMlkBD7a3d82eDJ0AOI4+QetQs5FhIa03MFFM0cY=; b=CGoAXo6zfEzpqpK/xpL/DjsnZ8
 8qj3oMpmr4ygNZKunh1H5hYfJQQ990iJyrU9wZpglKdRNfIzV4cL1TQMQH0gFZlZwv+Zrz9ZgZScX
 tBHaK+TGN0ZGtE6xw1tooDt8eVSX2HbtI/5InC7Kq1BIns6LlnGJ7Q/f6HMgATi9//yA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:
 Message-ID:From:References:CC:To:Subject:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=npwdMlkBD7a3d82eDJ0AOI4+QetQs5FhIa03MFFM0cY=; b=X91SMUdxxNn41cG7/1Z223d87n
 yOHFPda6qLkbee8ESjBJJBFmgDiXzcNToKaPZxocDFF0JDwksARlpo3XGm3KoeUzWFwBuksGBNjMb
 mf3blkanT3VcyzyZAyxP+h4hPqk/B3FAWpyyC60uOZ1FN0B6YlfzIilZwfS44VSwu304=;
Received: from szxga06-in.huawei.com ([45.249.212.32] helo=huawei.com)
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1jYJyF-005Jk2-Kx
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 12 May 2020 01:44:37 +0000
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id C6F26100283E77CE895F;
 Tue, 12 May 2020 09:44:28 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.210) with Microsoft SMTP Server (TLS) id 14.3.487.0; Tue, 12 May
 2020 09:44:28 +0800
To: <jaegeuk@kernel.org>
References: <20200508011603.54553-1-yuchao0@huawei.com>
From: Chao Yu <yuchao0@huawei.com>
Message-ID: <0e7fd845-f89b-f483-bb5a-c6cb7ec5c739@huawei.com>
Date: Tue, 12 May 2020 09:44:27 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20200508011603.54553-1-yuchao0@huawei.com>
Content-Language: en-US
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
X-Headers-End: 1jYJyF-005Jk2-Kx
Subject: Re: [f2fs-dev] [PATCH] f2fs: compress: fix zstd data corruption
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
Cc: Daeho Jeong <daehojeong@google.com>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hi Jaegeuk,

I think we need this patch in order to avoid writebacking incomplete data
compressed by zstd.

On 2020/5/8 9:16, Chao Yu wrote:
> During zstd compression, ZSTD_endStream() may return non-zero value
> because distination buffer is full, but there is still compressed data
> remained in intermediate buffer, it means that zstd algorithm can not
> save at last one block space, let's just writeback raw data instead of
> compressed one, this can fix data corruption when decompressing
> incomplete stored compression data.
> 

Fixes: 50cfa66f0de0 ("f2fs: compress: support zstd compress algorithm")

Thanks,


> Signed-off-by: Daeho Jeong <daehojeong@google.com>
> Signed-off-by: Chao Yu <yuchao0@huawei.com>
> ---
>  fs/f2fs/compress.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
> index c22cc0d37369..5e4947250262 100644
> --- a/fs/f2fs/compress.c
> +++ b/fs/f2fs/compress.c
> @@ -358,6 +358,13 @@ static int zstd_compress_pages(struct compress_ctx *cc)
>  		return -EIO;
>  	}
>  
> +	/*
> +	 * there is compressed data remained in intermediate buffer due to
> +	 * no more space in cbuf.cdata
> +	 */
> +	if (ret)
> +		return -EAGAIN;
> +
>  	cc->clen = outbuf.pos;
>  	return 0;
>  }
> 


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
