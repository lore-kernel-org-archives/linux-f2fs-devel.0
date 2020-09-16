Return-Path: <SRS0=1yAE=CZ=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6E32C43461
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 16 Sep 2020 09:50:19 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F0B8422225;
	Wed, 16 Sep 2020 09:50:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="DeBf0di7";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="IP1k+KXR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0B8422225
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1kIU4r-0000U8-9t; Wed, 16 Sep 2020 09:50:13 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <yuchao0@huawei.com>) id 1kIU4n-0000Ts-KO
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 16 Sep 2020 09:50:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:Reply-To:Cc:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=RWh4352X1Y0yzqB43PusnyGP04waJkmA+MKAXyzY8PI=; b=DeBf0di7LTtQCjWIXEhXwiDG5f
 pyfCO8fAoBKP74uFyO56QUmAc0P8cvuWHwdw3omtb/pC3n9qfXUsVgp6+VYbp93MQDciR1VqcETPn
 hyL4orrCFFyq+RKQTLlZt/KPcdUSf330OUI1fQYvxKdTW/UeIROf8OGy1pRQ3oKpLJ6A=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:
 Message-ID:From:References:To:Subject:Sender:Reply-To:Cc:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=RWh4352X1Y0yzqB43PusnyGP04waJkmA+MKAXyzY8PI=; b=IP1k+KXRcxged4mue0l7MyuuJt
 1R6Rf3YyaI/Tqlj/F6m6tSpa3hzPd1Rwj8q90xxASqx9PUY6SRO60sT05Y3bFKFfox4+VVytd0148
 Y1oVjaZwowL43Pmiu2fOpC/apL/AAninW62YM9sw61tr5/0txkNzXqJSvGVpQfsNZ2Ew=;
Received: from szxga04-in.huawei.com ([45.249.212.190] helo=huawei.com)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1kIU4h-00CBhl-T0
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 16 Sep 2020 09:50:09 +0000
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id 6FF756E3B1301E6816B8;
 Wed, 16 Sep 2020 17:49:46 +0800 (CST)
Received: from [10.136.114.67] (10.136.114.67) by smtp.huawei.com
 (10.3.19.201) with Microsoft SMTP Server (TLS) id 14.3.487.0; Wed, 16 Sep
 2020 17:49:36 +0800
To: "wangxiaojun (N)" <wangxiaojun11@huawei.com>, "jaegeuk@kernel.org"
 <jaegeuk@kernel.org>, "linux-f2fs-devel@lists.sourceforge.net"
 <linux-f2fs-devel@lists.sourceforge.net>
References: <20200916015410.4135737-1-wangxiaojun11@huawei.com>
 <3041cb44-8666-1db2-7474-367cf19f46c7@huawei.com>
 <6FEAADAF081CC14C95AF288712F254AE1D6CBA0A@dggeml531-mbx.china.huawei.com>
From: Chao Yu <yuchao0@huawei.com>
Message-ID: <35370655-1c32-c2d9-2952-08a36e959dde@huawei.com>
Date: Wed, 16 Sep 2020 17:49:35 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <6FEAADAF081CC14C95AF288712F254AE1D6CBA0A@dggeml531-mbx.china.huawei.com>
Content-Language: en-US
X-Originating-IP: [10.136.114.67]
X-CFilter-Loop: Reflected
X-Headers-End: 1kIU4h-00CBhl-T0
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix wrong total_sections check
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="iso-2022-jp"; Format="flowed"; DelSp="yes"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2020/9/16 14:56, wangxiaojun (N) wrote:
> 在 2020/9/16 10:57, Yuchao (T) 写道:
>> On 2020/9/16 9:54, Xiaojun Wang wrote:
>>> Meta area is not included in section_count computation.
>>> The code in mkfs/f2fs_format.c is:
>>> 	total_zones = get_sb(segment_count) / (c.segs_per_zone) -
>>> 					total_meta_zones;
>>> 	set_sb(section_count, total_zones * c.secs_per_zone);
>>>
>>> So the minimum total_sections is 1.
>>>
>>> Signed-off-by: Xiaojun Wang <wangxiaojun11@huawei.com>
>>> ---
>>>    fs/f2fs/super.c | 3 +--
>>>    1 file changed, 1 insertion(+), 2 deletions(-)
>>>
>>> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
>>> index dfa072fa8081..a450c8589841 100644
>>> --- a/fs/f2fs/super.c
>>> +++ b/fs/f2fs/super.c
>>> @@ -2799,8 +2799,7 @@ static int sanity_check_raw_super(struct f2fs_sb_info *sbi,
>>>    		return -EFSCORRUPTED;
>>>    	}
>>>    
>>> -	if (total_sections > segment_count ||
>>> -			total_sections < F2FS_MIN_SEGMENTS ||
>>> +	if (total_sections > segment_count || total_sections < 1 ||
>>>    			segs_per_sec > segment_count || !segs_per_sec) {
>> Here, we try to check sanity on segs_per_sec config directly and indirectly:
>> - directly: check raw_super->segs_per_sec field
>> - indirectly: check whether segment_count / total_sections is less than 1
>>
>> So I guess that first condition is wrong as well, should change it like?
>>
>> if (total_sections > segment_count - 'total_meta_segment_count' ||
>>
>> Thoughts?
>>
>> Thanks,
> 
> Hi Chao, aggree with you.
> 
> 'total_meta_segment_count' = le32_to_cpu(raw_super->segment_count_ckpt) +
> 			le32_to_cpu(raw_super->segment_count_sit) +
> 			le32_to_cpu(raw_super->segment_count_nat) +
> 			le32_to_cpu(raw_super->segment_count_ssa)
> But the above values will be checked in sanity_check_area_boundary() which will be called later.
> So can we move the total_sections checking to sanity_check_area_boundary

I think we'd better keep segs_per_sec check in sanity_check_raw_super(), as
it's a field of superblock.

>   ensure the 'total_meta_segment_count' is correct ?

It looks the condition below is wrong as well for the same reason you mentioned
in commit message?

if (unlikely(fsmeta < F2FS_MIN_SEGMENTS ||

Thanks,

> 
>>
>>>    		f2fs_info(sbi, "Invalid segment/section count (%u, %u x %u)",
>>>    			  segment_count, total_sections, segs_per_sec);
>>>
> 
> 
> .
> 


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
