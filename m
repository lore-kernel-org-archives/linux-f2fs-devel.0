Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71DA8C531C7
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 23 Jul 2026 09:09:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Yeo+KaFQNj8lZ55FGOv9XHpB32+uebBuMMM7FrYW6RQ=; b=UwKJtv7LrW/SsPpxf5WfhFuWO6
	6YvSsOw+MCAQZ2HwrUt+mXB9FqcPX1/y33HsfY4S1/+XWjaMRJTCZ5OHlBlBA0izo3BVF9NrkJEGM
	4YIZhx8YjJfA75zZQ5vQEjlupddHK3LcaTkvv/NltP/iGSVjWqgNrr6M7VsjYzCNZG18=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wmpRA-000199-Sf;
	Thu, 23 Jul 2026 09:09:53 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1wmpQo-00017Z-D8
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 23 Jul 2026 09:09:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=y0UcESmCim5QmX4ZZ5c1NsMiw8e946qvCG1L8MAl46c=; b=hLShBFgEGEw5F2w8LulUDjQ8EZ
 vK70z39FOAr27JybFW487qVzcahtm4Tdc13kxlg7oi8ZtW5puN4YdcYooua5XaC5oChgs6A49xJW2
 9/EWuiVh46FdOgKO+y/4ZKTDKy69KSUvtLSUIklSbhu90Dx6bwm0uZ6wzUT//VQ1KzO0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=y0UcESmCim5QmX4ZZ5c1NsMiw8e946qvCG1L8MAl46c=; b=dN4QRr2BQfIKxtUmvPnKSR0ZjP
 8xBhv0+Vz+hmeuPxRItcYG6QA3BR687AalQlyuN2Ijbs2rhCyT/hHc1Z2bT8yEbcYBpz2hWKtMJCF
 qqHaNCzb9ftrZQb9G1nxIIXXD3PM7G3rVyuP5rqowzgntkOzuNneQy1E+27GYcktEJ88=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wmpQl-00086E-Cp for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 23 Jul 2026 09:09:31 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id D742E4088E
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu, 23 Jul 2026 09:09:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 574F61F000E9;
 Thu, 23 Jul 2026 09:09:20 +0000 (UTC)
Message-ID: <a081f7cf-bd47-459d-baee-de772d816af4@kernel.org>
Date: Thu, 23 Jul 2026 17:09:12 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Zorro Lang <zlang@kernel.org>
References: <20260706064326.3657995-1-chao@kernel.org>
 <af5f0eb1-0197-4952-a37b-0602799929ec@kernel.org>
 <5c11cd98-bb41-46e0-9765-e2aad57a08e4@kernel.org>
 <aloCfjjqesxpzL9z@zlang-mailbox>
Content-Language: en-US
In-Reply-To: <aloCfjjqesxpzL9z@zlang-mailbox>
X-Headers-End: 1wmpQl-00086E-Cp
Subject: Re: [f2fs-dev] [PATCH v2] common/rc: support f2fs in
 _require_fanotify_ioerrors()
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
Cc: "Darrick J. Wong" <djwong@kernel.org>, fstests@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, Anand Suveer Jain <asj@kernel.org>,
 jaegeuk@kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 7/17/26 18:47, Zorro Lang wrote:
> On Wed, Jul 08, 2026 at 11:25:37AM +0800, Chao Yu wrote:
>> On 7/7/26 18:13, Anand Suveer Jain wrote:
>>> On 6/7/26 14:43, Chao Yu wrote:
>>>> f2fs has supported to report fserror, this patch adds support for f2fs
>>>> in _require_fanotify_ioerrors(), so that we can run generic/791 on f2fs.
>>>>
>>>> Cc: Darrick J. Wong <djwong@kernel.org>
>>>> Signed-off-by: Chao Yu <chao@kernel.org>
>>>> ---
>>>>  common/rc | 3 +++
>>>>  1 file changed, 3 insertions(+)
>>>>
>>>> diff --git a/common/rc b/common/rc
>>>> index 494725547..f51ad59f3 100644
>>>> --- a/common/rc
>>>> +++ b/common/rc
>>>> @@ -6257,6 +6257,9 @@ _require_fanotify_ioerrors()
>>>>  		x="$(_get_fs_sysfs_attr $TEST_DEV err_report_sec)"
>>>>  		test -n "$x" && return 0
>>>>  		;;
>>>
>>>
>>>> +	f2fs)
>>>> +		x="$(cat /sys/fs/f2fs/features/fserror)"
>>>> +		test -n "$x" && return 0
>>>
>>> Don't we need to check if /sys/fs/f2fs/features/fserror
>>> is present in the running kernel (there are helpers)
>>
>> Hi Anand,
>>
>> You mean _has_fs_sysfs_attr()? however, it forces to check first parameter $dev
>> w/ block device type:
>>
>> 	if [ ! -b "$dev" -o -z "$attr" ];then
>> 		_fail "Usage: _has_fs_sysfs_attr <mounted_device> <attr>"
>> 	fi
> 
> Hi Chao and Anand,
> 
> The *_fs_sysfs related helpers were brought in by me in:
>   commit 2a7b77abcd1dde735186b363da24540706c43b73
>   Author: Zorro Lang <zlang@redhat.com>
>   Date:   Tue Jul 5 17:30:24 2016 +0800
> 
>     xfs: configurable behavior on errors at unmount time
> 
> At that time, I didn't think about the "features/" directory.
> 
> Now, let me rethink this set of helpers. I feel that the *_fs_sysfs
> family of functions shouldn't be restricted to the $dev directory,
> we should remove this restriction.
> 
> Following that, we bring in *_fs_sysfs_device (appending the _device suffix)
> helpers which call *_fs_sysfs(). Also change the test cases who call these
> functions.
> 
> Finally, we can introduce the *_fs_sysfs_features functions (or simply use
> *_fs_sysfs directly).
> 
> Also, we have both *_fs_sysfs_attr and *_fs_sysfs, and the logic between
> them is somewhat confusing and easy to mix up.

Zorro,

It makes sense, and good news to their user. Thanks for the proposal.

> 
> I need to write a series of patches to clean up these logic. For this current
> patch, we can start with a small-scale change first. What do you think?

So I will use this first:

f2fs)
    local feat_file="/sys/fs/f2fs/features/fserror"
    if [ -f "$feat_file" ] && [ "$(cat "$feat_file")" = "supported" ]; then
        return 0
    fi
    ;;

And then waiting for your cleanup? or if you want to clean up this, please do it
directly while merging.

Thanks,

> 
> Thanks,
> Zorro
> 
>>
>>
>>> before reading it?
>>
>> How about this?
>>
>> f2fs)
>>     local feat_file="/sys/fs/f2fs/features/fserror"
>>     if [ -f "$feat_file" ] && [ "$(cat "$feat_file")" = "supported" ]; then
>>         return 0
>>     fi
>>     ;;
>>
>>>
>>>
>>>
>>>>  	esac
>>>>  
>>>>  	_notrun "$FSTYP does not support fanotify ioerrors"
>>>
>>



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
