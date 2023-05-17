Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37B0CC77B7A
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 17 May 2023 08:37:10 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1pzCej-0003oh-4X;
	Wed, 17 May 2023 08:37:09 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1pzCeh-0003ob-Bv
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 17 May 2023 08:37:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 Subject:From:References:Cc:To:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=mRhDfX9pFFFFc/u3wGNE7KrxSDm4n4MoyXTunvniHTg=; b=KrN1Dn5nAbHuLUUVXZ3CziTZXP
 HX79fFcd553bcLxzkPlkax1tcd5fvh91hRSMULT2FTqMDGQDgeigjXL9/kBPVK7VsTx2E7i0wSmR6
 8OCjy1D9BWyqHRD4oiY4L1cvnw9No+i61g1615lS+A9FZvq3PnLM7mOEiTQDRaUYw+HE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:Subject:From:
 References:Cc:To:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=mRhDfX9pFFFFc/u3wGNE7KrxSDm4n4MoyXTunvniHTg=; b=U8huLEaufKGHsfnZBgIKlohn5B
 Hs265gNEyLvCaKlw5YaWxyLKqL7JXS00gmskEwJqsOJbSB7X0pCpJorzz68Xd5gGr0GjzxhWL1KGH
 mu2KofMy9bke7bDcewf//9Haq5SWEh1g8NuyrP8GTr3eq8YaDJZJP+/W9VYOP87e5LOg=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1pzCeh-00ArL9-0v for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 17 May 2023 08:37:07 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id A042B643C4;
 Wed, 17 May 2023 08:37:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48818C433EF;
 Wed, 17 May 2023 08:36:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1684312621;
 bh=awX7GTJ2Wx17K0IkbJEWyVtj8sz41Jnnhewfqplzsis=;
 h=Date:To:Cc:References:From:Subject:In-Reply-To:From;
 b=ZdcNShYE/SSjsuQ3S5AOWATMcA39cqrFPyxq748K2G+OiBo1aXQMQ9xso+9orlp4M
 g3lihFE+QvjAPSFjeUP0Krispdcb6s2CossAHuDyi4pHiht9WpFUh1qvgTPBoiLjQf
 nNtIfyZaKufU9jRshkouw3o0D4DYWJRVdiu8jM5u+1Al+jglkauY1y4LaHlcQhw8Cd
 ENrzJlu4nQEzD0zqMKlA5piROoTIH8+Oq4p9SI9HDSANlGaZoLHg8EsUKEN1gA0dI1
 DIx096I1PkItZr5CIqS9exupFZhgXFJtdIazdDXGALwjfk7mhXW57Qe4un39WvEyES
 MvfS9tiCzJ/9g==
Message-ID: <94958409-f726-9da6-3b9f-76efa022ee9d@kernel.org>
Date: Wed, 17 May 2023 16:36:57 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Content-Language: en-US
To: Wu Bo <bo.wu@vivo.com>
References: <45eb63c6-a147-776a-99b5-7ac06848ede8@kernel.org>
 <20230517035953.47810-1-bo.wu@vivo.com>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20230517035953.47810-1-bo.wu@vivo.com>
X-Headers-End: 1pzCeh-00ArL9-0v
Subject: Re: [f2fs-dev] [PATCH 1/1] f2fs: pass I_NEW flag to trace event
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
Cc: wubo.oduw@gmail.com, jaegeuk@kernel.org, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2023/5/17 11:59, Wu Bo wrote:
> On 2023/5/17 10:44, Chao Yu wrote:
>> On 2023/5/16 20:07, Wu Bo wrote:
>>> Modify the order between 'trace_f2fs_iget' & 'unlock_new_inode', so the
>>> I_NEW can pass to the trace event when the inode initialised.
>>
>> Why is it needed? And trace_f2fs_iget() won't print inode->i_state?
> 
> When connect a trace_probe to f2fs_iget, it will be able to determine whether
> the inode is new initialised in order to do different process.

I didn't get it, you want to hook __tracepoint_f2fs_iget() w/ your own callback?

Thanks,

> 
>>
>> Thanks,
>>
>>>
>>> Signed-off-by: Wu Bo <bo.wu@vivo.com>
>>> ---
>>>    fs/f2fs/inode.c | 2 +-
>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
>>> index cf4327ad106c..caf959289fe7 100644
>>> --- a/fs/f2fs/inode.c
>>> +++ b/fs/f2fs/inode.c
>>> @@ -577,8 +577,8 @@ struct inode *f2fs_iget(struct super_block *sb,
>>> unsigned long ino)
>>>            file_dont_truncate(inode);
>>>        }
>>>    -    unlock_new_inode(inode);
>>>        trace_f2fs_iget(inode);
>>> +    unlock_new_inode(inode);
>>>        return inode;
>>>      bad_inode:
>>
>>
>> _______________________________________________
>> Linux-f2fs-devel mailing list
>> Linux-f2fs-devel@lists.sourceforge.net
>> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
>>


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
