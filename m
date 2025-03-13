Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 483FCC28B28
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 13 Mar 2025 01:40:23 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1tsXYa-0000ep-EG;
	Thu, 13 Mar 2025 01:40:20 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1tsXYZ-0000ei-6k
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 13 Mar 2025 01:40:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=boQlEvNRxiUZmPKefCMUll4vuzpDrdQeYnxttYJpNYQ=; b=jRXdOlev1HcxMY5vdzs9V0S+Y5
 mPl+dCRKKq4nw2734V0i12DarncRDMH/EpQNv8iNgUc3Nuz/G0H91EquqONJZ2OBKpudyBBHZbVLT
 n8+R+r70edrhjrHy6/PrQsUS+4GpS9iin+sfqXkM5BAMa64Kqgt5VB0n423w/fKaGqCQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=boQlEvNRxiUZmPKefCMUll4vuzpDrdQeYnxttYJpNYQ=; b=Kcm4KF70Lu/o9p4qV+jrJMjYg3
 WZI5VDr4Hmmyrz1kfeAJ2dnEvudrMnSE6nbkwqY7klkEHAqAynoxuXJYFsR/RT96kd7mwoXH8pEe5
 sCfFIyrK78s0yw0PksFBU+EKibhQmHI9L2UEvL5+vamTzw0bk3L1RgPVkKVU5QDpeg1o=;
Received: from nyc.source.kernel.org ([147.75.193.91])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1tsXYT-0002kd-RK for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 13 Mar 2025 01:40:19 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id 34BD8A42A16;
 Thu, 13 Mar 2025 01:34:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 751C2C4CEDD;
 Thu, 13 Mar 2025 01:40:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1741830007;
 bh=y8SI8ZSjzp4zCdxGliDL3yjJJfMwL4QwZKalS7Uh2ik=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
 b=U8xzUQ/bjaKlnGxlo9M/xrqiya608F7fg2qqATE69AYtVWfP1EdDcqJ802VqYfdRm
 Wu5HKqL0KRp8x8HulpjFVke9QFeFUz6p3ruwPTw6jMbAfeMjWiSkXRUJznA7dHooBh
 UUb0KjsJVfKI8WCCv+oA0U3S6lk7qGCrrXgZGSR7437pZG4bY5tF3iYvhA8hHv4CKl
 n4OKBQwefSYJU7DJYnCOG1NRXxLvcZJUatjqNmZsTxClMGC0jbuatDyHe//z5Piy1n
 0vLKIdE5hJzKTog+DMoA/YU2KG0q1IPp8EEc4SD66zEFWT3g+8us56Ls4skLpmbfsp
 Kz1S1kaEKafLg==
Message-ID: <0b622cf5-26b0-4fe3-943c-352b2b07101f@kernel.org>
Date: Thu, 13 Mar 2025 09:40:04 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Eric Sandeen <sandeen@redhat.com>, linux-f2fs-devel@lists.sourceforge.net
References: <20250303172127.298602-1-sandeen@redhat.com>
 <20250303172127.298602-4-sandeen@redhat.com>
 <5f8c60ec-2186-4315-b8c2-74aee91205df@kernel.org>
 <a2eda580-d205-40cf-b0d6-2dfa90dfc03b@redhat.com>
Content-Language: en-US
In-Reply-To: <a2eda580-d205-40cf-b0d6-2dfa90dfc03b@redhat.com>
X-Headers-End: 1tsXYT-0002kd-RK
Subject: Re: [f2fs-dev] [PATCH 3/9] f2fs: factor out an f2fs_default_check
 function
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
From: Chao Yu via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Chao Yu <chao@kernel.org>
Cc: jaegeuk@kernel.org, Eric Sandeen <sandeen@sandeen.net>,
 lihongbo22@huawei.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 3/12/25 21:29, Eric Sandeen wrote:
> On 3/11/25 10:10 PM, Chao Yu wrote:
>> On 3/4/25 01:12, Eric Sandeen wrote:
>>> From: Eric Sandeen <sandeen@sandeen.net>
>>>
>>> The current options parsing function both parses options and validates
>>> them - factor the validation out to reduce the size of the function and
>>> make transition to the new mount API possible, because under the new mount
>>> API, options are parsed one at a time, and cannot all be tested at the end
>>> of the parsing function.
>>>
>>> Signed-off-by: Eric Sandeen <sandeen@redhat.com>
>>> ---
>>>  fs/f2fs/super.c | 16 ++++++++++++++--
>>>  1 file changed, 14 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
>>> index 29b3aa1ee99c..7cfd5e4e806e 100644
>>> --- a/fs/f2fs/super.c
>>> +++ b/fs/f2fs/super.c
>>> @@ -687,7 +687,7 @@ static int parse_options(struct super_block *sb, char *options, bool is_remount)
>>>  	int ret;
>>>  
>>>  	if (!options)
>>> -		goto default_check;
>>
>> Eric, do you know in which condition options can be NULL, mount w/o any
>> specified options?
>>
>> If so, maybe we'd keep this in order to chech whether default options
>> generated from default_options() is conflicted or not? What do you think?
>>
>> Thanks,
> 
> Yes, that's I think that is correct - (!options) is true when no f2fs-specific
> options are present for parsing.
> 
> However, I think that we do still check default options with my patch in this
> case, because both calls to parse_options() still call f2fs_default_check()
> when parse_options() completes.
> 
> Or am I misunderstanding your question?
> 
> I added printks to check:
> 
> # mount -o loop,ro  f2fsfile.img mnt
> [root@fedora-rawhide f2fs-test]# dmesg 
> [847946.326384] loop2: detected capacity change from 0 to 819200
> [847946.337625] parse_options: (!options) is true
> [847946.337637] enter f2fs_default_check()

Oh, I missed that we will call f2fs_default_check() after default_options()
anyway, so I guess it's fine here.

Thanks for your confirmation.

> 
> Thank you for reviewing this series. I think at least the first 2 or 3 patches
> are suitable for merge now, if you agree. I am fairly certain that the rest of

I've reviewed other patches, they look clean to me, Jaegeuk has merged them into
dev-test branch, let's test them for a while.

> them are proper steps towards mount API conversion as well, but as I have not
> yet finished the work, I can't guarantee it yet. :)

Thanks for the effect, and good to see progress on changing to use new
mount API. :)

Thanks,

> 
> Thanks,
> -Eric
> 



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
