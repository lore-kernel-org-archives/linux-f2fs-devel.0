Return-Path: <SRS0=8g9c=DC=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 425FCC4363D
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 25 Sep 2020 00:57:45 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8DA6520756
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 25 Sep 2020 00:57:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="Om0mEH9G";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="RAVtchqI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DA6520756
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1kLc3S-0008E1-AG; Fri, 25 Sep 2020 00:57:42 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <yuchao0@huawei.com>) id 1kLc3O-0008Ds-Ki
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 25 Sep 2020 00:57:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 MIME-Version:Date:Message-ID:From:References:CC:To:Subject:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=QW39vTESNQPLj4hy31Q2Y4xhwkFEJGaJvoSobd4Q7WM=; b=Om0mEH9GGWtTqhuyOb0Mr2Bczm
 5wFOOTdpXLCK+hJoyttX+PJ2BHMgPC+DJWGbDVUIsGZKScHDlIQM3GEBahiIPw66MmqFWmxlWkqyq
 gKY/PpynxCUqofbcnOu5/khJOf1uOeDQdw01II4tWL1YLcRxh/8WDC3f7KhGt7Trtqfo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:
 Message-ID:From:References:CC:To:Subject:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=QW39vTESNQPLj4hy31Q2Y4xhwkFEJGaJvoSobd4Q7WM=; b=RAVtchqI3QRHTPQYjrWjg2eG9U
 uog6pKYbSlfZH1T8JHlA0nWr2GRx8DgS5jp8yHl3TW4teMTGw/P542IyTIF4Y5hOpo2Lx6U4kWbVy
 roicx27qurUADfLfH/ehpI5BRzyZ7XzIJ0UBp1x5nqT2IY1L6K+LyLWjLEtywITTDbHI=;
Received: from szxga07-in.huawei.com ([45.249.212.35] helo=huawei.com)
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1kLc3H-004n7k-4j
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 25 Sep 2020 00:57:38 +0000
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id DA3FBF253B9569A7D13D;
 Fri, 25 Sep 2020 08:57:18 +0800 (CST)
Received: from [10.136.114.67] (10.136.114.67) by smtp.huawei.com
 (10.3.19.209) with Microsoft SMTP Server (TLS) id 14.3.487.0; Fri, 25 Sep
 2020 08:57:16 +0800
To: Jaegeuk Kim <jaegeuk@kernel.org>
References: <20200918030349.19667-1-yuchao0@huawei.com>
 <20200924200305.GA2568648@google.com>
From: Chao Yu <yuchao0@huawei.com>
Message-ID: <dbf3a532-cd38-2b31-e4ab-e83505c6c9c4@huawei.com>
Date: Fri, 25 Sep 2020 08:57:15 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20200924200305.GA2568648@google.com>
Content-Language: en-US
X-Originating-IP: [10.136.114.67]
X-CFilter-Loop: Reflected
X-Headers-End: 1kLc3H-004n7k-4j
Subject: Re: [f2fs-dev] [PATCH] f2fs: compress: fix to disallow enabling
 compress on non-empty file
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2020/9/25 4:03, Jaegeuk Kim wrote:
> On 09/18, Chao Yu wrote:
>> Compressed inode and normal inode has different layout, so we should
>> disallow enabling compress on non-empty file to avoid race condition
>> during inode .i_addr array parsing and updating.
>>
>> Signed-off-by: Chao Yu <yuchao0@huawei.com>
>> ---
>>   fs/f2fs/file.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
>> index 58e464cc15f0..139fdfc1dc55 100644
>> --- a/fs/f2fs/file.c
>> +++ b/fs/f2fs/file.c
>> @@ -1821,6 +1821,8 @@ static int f2fs_setflags_common(struct inode *inode, u32 iflags, u32 mask)
>>   		if (iflags & F2FS_COMPR_FL) {
>>   			if (!f2fs_may_compress(inode))
>>   				return -EINVAL;
>> +			if (inode->i_size)
> 
> Changed like this.
> 
> +                       if (S_ISREG(inode->i_mode) && inode->i_size)

My bad, thanks for fixing this. :)

Thanks,

> 
> 
>> +				return -EINVAL;
>>   
>>   			set_compress_context(inode);
>>   		}
>> -- 
>> 2.26.2
> .
> 


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
