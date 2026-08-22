Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B20A6C5DF8C
	for <linux-f2fs-devel@archiver.kernel.org>; Sat, 22 Aug 2026 07:10:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Content-Transfer-Encoding:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BKmMltsXP0c5WiLF8bgRDhJfys50EgaqkF+OkhLySZc=; b=WmlJbguX5jgdyPdPXn9oQWLwb2
	PurCLsYHDrAc7KujiWxXkH1WKOFUbMdjSLkmP/5P5JqeZ2dh5Vk3QRh8d6stsY4DNeyRzCoNP2rUl
	nG/h/oTazo/wFe9/206NrLtshUHORMVEuiXWM8275e9l94gY6UZ/YeQyKcAxZt7Pb50c=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wxfsA-0000Sn-Se;
	Sat, 22 Aug 2026 07:10:35 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1wxfrn-0000Qz-RL
 for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 22 Aug 2026 07:10:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=z+PD1FJQQZXjGT39NUNG7iAD+zFhllq/eUNIq4cDZJ8=; b=U/+ENGeSeZ/PXKgEpi168iYbIQ
 653SLQk8DhJL7OlavE+j0eqQ0RK2xjbuwi8SvwNRfK1TWskOETEkAO4rYrsSr1XtMtIjNgju3Nt/h
 wZSlQMHy6lQKmOzA1yC+6puV9cuBuhjdfRmhkmQMRXJukm/3xMlnciH+ceCPckiygpoY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=z+PD1FJQQZXjGT39NUNG7iAD+zFhllq/eUNIq4cDZJ8=; b=Ifz7nGyTT3oohbfNMAMufTePvw
 2vlacOMbKXbuOwO8W9A1/jp/MILh4/IY7vlG0J+xFRTwZLLwWRefMEupAg93u63P+2xHw4sGohUTp
 HQ7B/TfG8CluI9NcWAr651DiW9/6uY0v04Q2Mkfc8dR6b2r57HaCm5FWK8C403f9KSbI=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wxfrn-0000Oi-R0 for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 22 Aug 2026 07:10:12 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 5179843F75;
 Sat, 22 Aug 2026 07:10:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4488E1F000E9;
 Sat, 22 Aug 2026 07:10:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787382606;
 bh=z+PD1FJQQZXjGT39NUNG7iAD+zFhllq/eUNIq4cDZJ8=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To;
 b=jluUBCcimzEAYB7eK+t4nluVxZGIEYxZbAtDrYV+nURl04SwbVFDjFKfl3imndG41
 wyOlvb0ZxQKXY1sl560rr2hFDWUxMBfHTDX9/o8Q1EjxAgqRlsJ1vnrNQ1M04Zjn6y
 OY6GdsZhjzR6DtiyHfsaOueKe8da0Rs3BVkG5GPDj/d4lhfKQJWyeAe93pqj0Wtm/K
 claSyQ68MKOTmcYBT2A7pIrHgByl4gEqBHIkJFk0nAkXFimWXt0jCnPfYwUEdFTEpj
 MwaysiR+VQYSqNvaqz9sd4c9Y1PODbJ/ypZ8HOMuIpGVGXjqFGMqn0nDBbn2185YSN
 nNhS+YShXOFjw==
Message-ID: <8d10a64e-f128-4287-b9a0-310992b0f372@kernel.org>
Date: Sat, 22 Aug 2026 15:10:02 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Jaegeuk Kim <jaegeuk@kernel.org>
References: <20260821141742.2678300-1-daeho43@gmail.com>
 <aohuDgLbl5SSnJ9T@google.com>
 <b04fad97-89ea-43fc-a3b0-951c78838bcb@kernel.org>
 <aojpZFWIYAQ5Y-2W@google.com>
Content-Language: en-US
In-Reply-To: <aojpZFWIYAQ5Y-2W@google.com>
X-Headers-End: 1wxfrn-0000Oi-R0
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix error handling on device alias
 check in rename and unlink
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
Cc: Daeho Jeong <daehojeong@google.com>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net,
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>, kernel-team@android.com,
 stable@kernel.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 8/22/26 08:12, Jaegeuk Kim wrote:
> On 08/22, Chao Yu wrote:
>> On 8/21/26 23:26, Jaegeuk Kim via Linux-f2fs-devel wrote:
>>> On 08/21, Daeho Jeong wrote:
>>>> From: Daeho Jeong <daehojeong@google.com>
>>>>
>>>> In f2fs_rename() and f2fs_unlink(), directly returning -EPERM when
>>>> encountering a device aliasing file bypasses the cleanup path.
>>>>
>>>> Fix this by setting err to -EPERM and jumping to the proper cleanup
>>>> labels (out_dir and out) instead of returning immediately.
>>>>
>>>> Fixes: a737e409a3d6 ("f2fs: support dynamic reserve/release for device aliasing")
>>>> Cc: stable@kernel.org
>>>
>>> Applied without Fixes and stable, since the original patch has not been
>>> upstreamed.
>>
>> Jaegeuk, if we don't plan to merge them, we'd better keep the Fixes and stable
>> line, otherwise, once the two patches be upstreamed, we may missed to backport
>> the fix one due to the missing lines?
> 
> My concern is the never existing hash in upstream. And, I don't think this will
> go into any LTS.

Oh, I see, actually, my concern is developers may potentially miss this fix when
backporting related feature.

Thanks,

> 
>>
>> Thanks,
>>
>>>
>>>> Reported-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
>>>> Signed-off-by: Daeho Jeong <daehojeong@google.com>
>>>> Reviewed-by: Chao Yu <chao@kernel.org>
>>>> ---
>>>>    fs/f2fs/namei.c | 12 ++++++++----
>>>>    1 file changed, 8 insertions(+), 4 deletions(-)
>>>>
>>>> diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
>>>> index 784f636244e1..b9b15c5d28de 100644
>>>> --- a/fs/f2fs/namei.c
>>>> +++ b/fs/f2fs/namei.c
>>>> @@ -571,8 +571,10 @@ static int f2fs_unlink(struct inode *dir, struct dentry *dentry)
>>>>    	trace_f2fs_unlink_enter(dir, dentry);
>>>> -	if (IS_DEVICE_ALIASING(inode))
>>>> -		return -EPERM;
>>>> +	if (IS_DEVICE_ALIASING(inode)) {
>>>> +		err = -EPERM;
>>>> +		goto out;
>>>> +	}
>>>>    	if (unlikely(f2fs_cp_error(sbi))) {
>>>>    		err = -EIO;
>>>> @@ -1025,8 +1027,10 @@ static int f2fs_rename(struct mnt_idmap *idmap, struct inode *old_dir,
>>>>    	}
>>>>    	if (new_inode) {
>>>> -		if (IS_DEVICE_ALIASING(new_inode))
>>>> -			return -EPERM;
>>>> +		if (IS_DEVICE_ALIASING(new_inode)) {
>>>> +			err = -EPERM;
>>>> +			goto out_dir;
>>>> +		}
>>>>    		err = -ENOTEMPTY;
>>>>    		if (old_is_dir && !f2fs_empty_dir(new_inode))
>>>> -- 
>>>> 2.55.0.766.g2966f0265a-goog
>>>>
>>>>
>>>>
>>>> _______________________________________________
>>>> Linux-f2fs-devel mailing list
>>>> Linux-f2fs-devel@lists.sourceforge.net
>>>> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
>>>
>>>
>>> _______________________________________________
>>> Linux-f2fs-devel mailing list
>>> Linux-f2fs-devel@lists.sourceforge.net
>>> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
>>



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
