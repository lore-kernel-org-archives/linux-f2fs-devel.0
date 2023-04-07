Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C09DFC761A6
	for <linux-f2fs-devel@archiver.kernel.org>; Fri,  7 Apr 2023 01:20:46 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1pkamT-0008Qq-Ns;
	Fri, 07 Apr 2023 01:20:46 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1pkamS-0008Qk-7c
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 07 Apr 2023 01:20:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=OlWXmqE54jgNAcKhxAr/HBLQq4s6mbGle60Wyp1Aqrs=; b=TCajZxpTCeFvGNN76dZmp/yO+l
 T5tGNrTTWKit+BzMq5RE2h4ypCPsHddvLU46QKzwtRiRjsGwVqijDB3nEZXtvep7Ds9DjwICe0kj5
 45ejk4EpAL2U5VZHJvpROpCv16PFM6f4fLlXX07S7w1AFeHFMZIkIa9qKtprmWmwtROY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=OlWXmqE54jgNAcKhxAr/HBLQq4s6mbGle60Wyp1Aqrs=; b=ZoqcKiryAFkyNd7hzJQofqzqC5
 +SiOph661h4kpVvOQb/ouiH1JUWsqpTc82ckpqAphbpOul43dBV/z2JnSdrJ05uR8yfZXHLrhcLXo
 631jfM0wmGco2i03fHbVDE74Ra0W3VwZARX9ApqhsB6ZegHRfIZiFhXCRc8QOQAPjW54=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1pkamR-00HJle-UD for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 07 Apr 2023 01:20:44 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 3EDC160B4A;
 Fri,  7 Apr 2023 01:20:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B58D1C433D2;
 Fri,  7 Apr 2023 01:20:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1680830437;
 bh=Hc+mjLQ2bPKEmltX+LVQc3NphT2dO+gfyXP2aojuCvg=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=giyOu+tXQd58ibN/OItUiwGCjzK+IWyTiXq9LbbkeHnHYSqNVjJ/2YVOnyI3YdFj4
 QqkT096W3Tviz0t8jfjvEMSiVLenBS+a3w7evLCelDHKbMjCogMmxr/m6W99+03+Rv
 /xJIvUVzxPJWrPceyzViNRnPs4bHz4LZpuTygbNceaSSnRiv8EK0vuh3vun7Uijoq2
 xJeTYeGeqN5rE5HqhGOr0SrkgsZlLdXXoGSnx7M6aZDN4JmEt9WU4InYEtXwM15UTO
 MS9S13oApgcw4CkVZ8249FVWQwVuxlPOR8+IgJXriyTXCixnmsKEWjus3LthEaBOF+
 Hf91u6hlaEtEw==
Message-ID: <2f076e24-b550-437a-a271-6f62f1d236d8@kernel.org>
Date: Fri, 7 Apr 2023 09:20:35 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Content-Language: en-US
To: Jaegeuk Kim <jaegeuk@kernel.org>
References: <20230331113305.77217-1-frank.li@vivo.com>
 <3918411a-77fc-48d7-5b80-c4b84203a39c@kernel.org>
 <ZC2aZJFIJZclTkkK@google.com>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <ZC2aZJFIJZclTkkK@google.com>
X-Headers-End: 1pkamR-00HJle-UD
Subject: Re: [f2fs-dev] [PATCH] f2fs: convert to use sysfs_emit
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
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
 Yangtao Li <frank.li@vivo.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2023/4/5 23:57, Jaegeuk Kim wrote:
> On 04/05, Chao Yu wrote:
>> On 2023/3/31 19:33, Yangtao Li wrote:
>>> Let's use sysfs_emit.
>>>
>>> Signed-off-by: Yangtao Li <frank.li@vivo.com>
>>> ---
>>>    fs/f2fs/sysfs.c | 10 ++--------
>>>    1 file changed, 2 insertions(+), 8 deletions(-)
>>>
>>> diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
>>> index 9ddc6ee19433..2c0b2cb05a3a 100644
>>> --- a/fs/f2fs/sysfs.c
>>> +++ b/fs/f2fs/sysfs.c
>>> @@ -312,19 +312,13 @@ static ssize_t f2fs_sbi_show(struct f2fs_attr *a,
>>>    	if (!strcmp(a->attr.name, "ckpt_thread_ioprio")) {
>>>    		struct ckpt_req_control *cprc = &sbi->cprc_info;
>>> -		int len = 0;
>>>    		int class = IOPRIO_PRIO_CLASS(cprc->ckpt_thread_ioprio);
>>>    		int data = IOPRIO_PRIO_DATA(cprc->ckpt_thread_ioprio);
>>> -		if (class == IOPRIO_CLASS_RT)
>>> -			len += scnprintf(buf + len, PAGE_SIZE - len, "rt,");
>>> -		else if (class == IOPRIO_CLASS_BE)
>>> -			len += scnprintf(buf + len, PAGE_SIZE - len, "be,");
>>> -		else
>>> +		if (class != IOPRIO_CLASS_RT && class != IOPRIO_CLASS_BE)
>>>    			return -EINVAL;
>>> -		len += scnprintf(buf + len, PAGE_SIZE - len, "%d\n", data);
>>> -		return len;
>>> +		return sysfs_emit(buf, "%s,%d\n", class == IOPRIO_CLASS_RT ? "rt" : "be", data);
>>
>> Exceed 80 columns.
> 
> Fixed and applied.

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
