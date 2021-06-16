Return-Path: <SRS0=P3Wg=LK=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99C45C48BE6
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 16 Jun 2021 13:22:17 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D72B6115C;
	Wed, 16 Jun 2021 13:22:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D72B6115C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1ltVUl-0001a2-B3; Wed, 16 Jun 2021 13:22:15 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <chao@kernel.org>) id 1ltVUj-0001Zk-VN
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 16 Jun 2021 13:22:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=v3U7DgOiOg7AnkDZfRoQe0J3n6iXfeM6X56hyKANeok=; b=APp96IcigRhqnla3/UK/6fc1p6
 1z+E8WPnCEjdGzbs5Gnm8wbZQzm810SaMVr1Phl332jutqO8AWlzRCB4/phSkq6tgRQxJUXURw2nt
 IhvMconBBY1FKzqSJgADTXpzgG+NaqinKoFTwLJv3QAMjf8qQQ6T5sBq/y3nh9ni44bQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:
 Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=v3U7DgOiOg7AnkDZfRoQe0J3n6iXfeM6X56hyKANeok=; b=YVxgd5kHDu6W74VV9eSKqz5OZ0
 GBTeWXzfXIoahwYbcnIT5jAZrWBaygXxBPv+cwZb9e2jjprp3igyRX6fl2Jyfv1aZrJZiWzjFE61X
 W+lKpl/YIlkw76RlZs0xSJ+rQe3ZgGUwlf45Lg/Tz53xQr1aFHe/6yssb+INf9/0THnA=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.3)
 id 1ltVUf-0005YQ-8x
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 16 Jun 2021 13:22:14 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 72CC56024A;
 Wed, 16 Jun 2021 13:21:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1623849720;
 bh=XvUb6HgL5Guwej8X1ct0HdyCzH2UHdwnXQTZ1SrJgPE=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=dAhOFb4AVm3pjhWFjDf0kYIhF/DINz0cPIzzprbp3rmkqqzIMiU1Wxl4qXOm4vmtY
 /6Nm8kGExYy4XCiUeoQ/tCGGsmsN1ptDUYCq+5oxdOGjR9ghZgE2yqXh6Ub2TTbWQl
 GNZPNsYT2zityJub/OBLx8cSJESXhDRZ6Yzqnj+NXOr4ixfaURd9nfYDp/yMzHuB/4
 qIi6gcGXQFsofdtJcCziLxannENCASYsDdRgt9ROc6+BCQ01tFevrOmohXlcvqMsLb
 Tj8VzJ8GVqNHh4ZyVrxIV1+fz+Ko4Br8f6IuhXqoDtiZfo1lczqmogb8vauoGBUHtZ
 bN1UVFYLz0bXg==
To: Gao Xiang <hsiangkao@linux.alibaba.com>,
 Wang Xiaojun <wangxiaojun11@huawei.com>
References: <20210615013509.4130329-1-wangxiaojun11@huawei.com>
 <YMgRBshqToatVwzP@B-P7TQMD6M-0146.local>
From: Chao Yu <chao@kernel.org>
Message-ID: <ca465121-5c6b-4342-c6c9-3d8be3d32e5a@kernel.org>
Date: Wed, 16 Jun 2021 21:21:58 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YMgRBshqToatVwzP@B-P7TQMD6M-0146.local>
Content-Language: en-US
X-Headers-End: 1ltVUf-0005YQ-8x
Subject: Re: [f2fs-dev] [PATCH] f2fs: replace ERANGE with ENAMETOOLONG in
 file name length check
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
Cc: jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2021/6/15 10:31, Gao Xiang wrote:
> On Tue, Jun 15, 2021 at 09:35:09AM +0800, Wang Xiaojun wrote:
>> ERANGE indicates that the math result is not representative. Here,
>> ENAMETOOLONG is used to replace ERANGE.
>>
>> Signed-off-by: Wang Xiaojun <wangxiaojun11@huawei.com>
> 
> I don't think ENAMETOOLONG is a valid return code for {g,s}etxattr.
> https://man7.org/linux/man-pages/man2/getxattr.2.html
> https://man7.org/linux/man-pages/man2/setxattr.2.html
> instead of ERANGE.

Agreed, it should implement according to man of {g,s}etxattr.

Thanks,

> 
> please also see ext4 / xfs implementations.
> 
> Thanks,
> Gao Xiang
> 
> 
>> ---
>>   fs/f2fs/xattr.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/fs/f2fs/xattr.c b/fs/f2fs/xattr.c
>> index c8f34decbf8e..eb827c10e970 100644
>> --- a/fs/f2fs/xattr.c
>> +++ b/fs/f2fs/xattr.c
>> @@ -529,7 +529,7 @@ int f2fs_getxattr(struct inode *inode, int index, const char *name,
>>   
>>   	len = strlen(name);
>>   	if (len > F2FS_NAME_LEN)
>> -		return -ERANGE;
>> +		return -ENAMETOOLONG;
>>   
>>   	down_read(&F2FS_I(inode)->i_xattr_sem);
>>   	error = lookup_all_xattrs(inode, ipage, index, len, name,
>> @@ -646,7 +646,7 @@ static int __f2fs_setxattr(struct inode *inode, int index,
>>   	len = strlen(name);
>>   
>>   	if (len > F2FS_NAME_LEN)
>> -		return -ERANGE;
>> +		return -ENAMETOOLONG;
>>   
>>   	if (size > MAX_VALUE_LEN(inode))
>>   		return -E2BIG;
>> -- 
>> 2.25.4
>>
>>
>>
>> _______________________________________________
>> Linux-f2fs-devel mailing list
>> Linux-f2fs-devel@lists.sourceforge.net
>> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
> 
> 
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
> 


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
