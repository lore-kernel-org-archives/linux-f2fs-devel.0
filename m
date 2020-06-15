Return-Path: <SRS0=/SzK=74=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13487C433E0
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 15 Jun 2020 07:35:50 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A884B2067B;
	Mon, 15 Jun 2020 07:35:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="mAKdDSQX";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="Fex1oyAe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A884B2067B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1jkjen-0002fL-9r; Mon, 15 Jun 2020 07:35:49 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <fangwei1@huawei.com>) id 1jkjec-0002eF-Of
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 15 Jun 2020 07:35:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:Reply-To:Cc:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=uTYNOCzIz7+IMOu4lJWTRwcprnRja291cK7Ex/aYxfU=; b=mAKdDSQXWz5JXwkqDqi3m3mv8d
 QgTCqwlFDqXtIUGzIrqsNinMzxGRj40pU+fLjkhdTTiqMhF2w3z6W19GZgPCwMSrc5S/oMJZ6u9RW
 av99+0fmx32vHjU4COZfVdNppZCA6VGHdvgNTNtxcPI/zaC7kLF0hGjLmVqVsJKJUDns=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:
 Message-ID:From:References:To:Subject:Sender:Reply-To:Cc:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=uTYNOCzIz7+IMOu4lJWTRwcprnRja291cK7Ex/aYxfU=; b=Fex1oyAeD/96zFMrhKAQBdWBdd
 iSEo8LdxhjONfty2HQu5Y4vkjNTp6CK7VKuCQhHkH0GlqX8H0m3yFl0nZXVKEH50J3iOxZZftuYjH
 fOLSIpe2DZu4EcTyE7zyWtd3rzPuPeWeKJGjuv0kD2BmTOoMIE0W6ic9wFUf4632CgDM=;
Received: from szxga05-in.huawei.com ([45.249.212.191] helo=huawei.com)
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1jkjeW-003ETl-0q
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 15 Jun 2020 07:35:34 +0000
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id EEE94F25481E4753DC74
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 15 Jun 2020 15:34:26 +0800 (CST)
Received: from [127.0.0.1] (10.166.212.179) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.487.0;
 Mon, 15 Jun 2020 15:34:17 +0800
To: Chao Yu <yuchao0@huawei.com>, <linux-f2fs-devel@lists.sourceforge.net>
References: <20200613042526.30382-1-fangwei1@huawei.com>
 <4811f8f8-ea91-6cea-7bd6-a43c4a0cd6d4@huawei.com>
From: Wei Fang <fangwei1@huawei.com>
Message-ID: <75c3d4ab-5506-4a80-740e-e0a7c9ad12cc@huawei.com>
Date: Mon, 15 Jun 2020 15:34:16 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <4811f8f8-ea91-6cea-7bd6-a43c4a0cd6d4@huawei.com>
X-Originating-IP: [10.166.212.179]
X-CFilter-Loop: Reflected
X-Headers-End: 1jkjeW-003ETl-0q
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


On 2020/6/15 9:42, Chao Yu wrote:
> Hi Wei Fang,
>
> On 2020/6/13 12:25, Wei Fang wrote:
>> Since offset < new_size, no need to do truncate_pagecache() again
>> with new_size.
>>
>> Signed-off-by: Wei Fang <fangwei1@huawei.com>
>> ---
>>  fs/f2fs/file.c | 5 ++---
>>  1 file changed, 2 insertions(+), 3 deletions(-)
>>
>> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
>> index 3268f8dd59bb..43544817238b 100644
>> --- a/fs/f2fs/file.c
>> +++ b/fs/f2fs/file.c
>> @@ -1368,13 +1368,12 @@ static int f2fs_collapse_range(struct inode *inode, loff_t offset, loff_t len)
>>  		return ret;
>>  
>>  	/* write out all moved pages, if possible */
>> -	down_write(&F2FS_I(inode)->i_mmap_sem);
>>  	filemap_write_and_wait_range(inode->i_mapping, offset, LLONG_MAX);
>> +
>> +	down_write(&F2FS_I(inode)->i_mmap_sem);
> I guess this patch mainly avoids useless page cache truncation, could we get rid of
> lock coverage update here? or we can do it in separated patch if necessary.
OK, I'll remove the lock coverage change in this patch.

Thanks,
Wei

> Thanks,
>
>>  	truncate_pagecache(inode, offset);
>>  
>>  	new_size = i_size_read(inode) - len;
>> -	truncate_pagecache(inode, new_size);
>> -
>>  	ret = f2fs_truncate_blocks(inode, new_size, true);
>>  	up_write(&F2FS_I(inode)->i_mmap_sem);
>>  	if (!ret)
>>
> .
>




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
