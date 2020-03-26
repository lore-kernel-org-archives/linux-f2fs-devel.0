Return-Path: <SRS0=yNny=5L=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFA6FC43331
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 26 Mar 2020 09:35:21 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AFF7B2073E
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 26 Mar 2020 09:35:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="RvqhVI2w";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="Jiakz8Y4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFF7B2073E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1jHOv3-0003YH-4C; Thu, 26 Mar 2020 09:35:21 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <yuchao0@huawei.com>) id 1jHOv2-0003Y0-5W
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 26 Mar 2020 09:35:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 MIME-Version:Date:Message-ID:From:References:CC:To:Subject:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=1Dgk26+ga1imxVl88UdJNYF/M7NFE95vSbj0YEIPx7c=; b=RvqhVI2wf4bXWYDI/bKRiFRU9n
 5b3G/eKRpohK9Eh2Jh4TvabljojCQZ2MJApOFnx4UYVwkkbK1pBX0IUSper52H8gg6oPDsK1IHgg0
 lvw5EMDP1pdM81xFLUsCXEmxITc+oFUJYbrmhzsjsrDpjZ29K6J3Jh9v6bqc3/CC7lJw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:
 Message-ID:From:References:CC:To:Subject:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=1Dgk26+ga1imxVl88UdJNYF/M7NFE95vSbj0YEIPx7c=; b=Jiakz8Y4J6/W42iluziP1gNfo4
 Sy+5Llvtz6P/p/YC0m1iTSQIi60rKkX5XNQee1lvyqESb1YEeHT5sGUjW/EHTQ+W/Bmz9euF1KPvO
 smGt/tk8LC5QWGZDeZ9mSbZy7ivkuSBTFexyclTbdx2EBCkiq53Xpwo4mDY/8L459fQI=;
Received: from szxga05-in.huawei.com ([45.249.212.191] helo=huawei.com)
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1jHOuz-004IqQ-U0
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 26 Mar 2020 09:35:20 +0000
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id 7644EDB1CEFD789CD5B1;
 Thu, 26 Mar 2020 17:35:08 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.204) with Microsoft SMTP Server (TLS) id 14.3.487.0; Thu, 26 Mar
 2020 17:35:04 +0800
To: Jaegeuk Kim <jaegeuk@kernel.org>
References: <20200325092754.63411-1-yuchao0@huawei.com>
 <20200325155806.GC65658@google.com>
From: Chao Yu <yuchao0@huawei.com>
Message-ID: <87d715d0-a5c4-7b54-95bb-9b627d163271@huawei.com>
Date: Thu, 26 Mar 2020 17:35:03 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20200325155806.GC65658@google.com>
Content-Language: en-US
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
X-Headers-End: 1jHOuz-004IqQ-U0
Subject: Re: [f2fs-dev] [PATCH RFC] f2fs: don't inline compressed inode
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

On 2020/3/25 23:58, Jaegeuk Kim wrote:
> On 03/25, Chao Yu wrote:
>> f2fs_may_inline_data() only check compressed flag on current inode
>> rather than on parent inode, however at this time compressed flag
>> has not been inherited yet.
> 
> When write() or other allocation happens, it'll be reset.

Yeah, all tests are fine w/o this RFC patch, anyway, will let you know if
I find something incompatible.

Thanks,

> 
>>
>> Signed-off-by: Chao Yu <yuchao0@huawei.com>
>> ---
>>
>> Jaegeuk,
>>
>> I'm not sure about this, whether inline_data flag can be compatible with
>> compress flag, thoughts?
>>
>>  fs/f2fs/namei.c | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
>> index f54119da2217..3807d1b4c4bc 100644
>> --- a/fs/f2fs/namei.c
>> +++ b/fs/f2fs/namei.c
>> @@ -86,7 +86,8 @@ static struct inode *f2fs_new_inode(struct inode *dir, umode_t mode)
>>  	if (test_opt(sbi, INLINE_XATTR))
>>  		set_inode_flag(inode, FI_INLINE_XATTR);
>>  
>> -	if (test_opt(sbi, INLINE_DATA) && f2fs_may_inline_data(inode))
>> +	if (test_opt(sbi, INLINE_DATA) && f2fs_may_inline_data(inode) &&
>> +					!f2fs_compressed_file(dir))
>>  		set_inode_flag(inode, FI_INLINE_DATA);
>>  	if (f2fs_may_inline_dentry(inode))
>>  		set_inode_flag(inode, FI_INLINE_DENTRY);
>> -- 
>> 2.18.0.rc1
> .
> 


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
