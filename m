Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44414C433EF
	for <linux-f2fs-devel@archiver.kernel.org>; Thu,  3 Feb 2022 14:30:22 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.94.2)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1nFd7s-0004bB-If; Thu, 03 Feb 2022 14:30:19 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <chao@kernel.org>) id 1nFd7r-0004b2-Fw
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 03 Feb 2022 14:30:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=9PCpAFZl6QDI+oGCQD61D+tvevFyuQ5MWfJ+R6g9ZLM=; b=nEqjSgsUFCLCvocnWGc/PDAzcA
 IfLrXCyWuhjU1uKzPdI4i4QZ6IXzXeURLn+uKjHcYhyw3mk30PS8FPqYAUodRzwNkG+yx6YpgbcbX
 1YurMFbtyPKp8gba8ZF/AwCjur3sG2fDECyCNOMv6aeEzI3jiR0kc0hgHnJMsp2/gMc8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=9PCpAFZl6QDI+oGCQD61D+tvevFyuQ5MWfJ+R6g9ZLM=; b=kzF1PzmEf3WyKMl7+BHjrRY6SW
 DbEn5DctNTDfBAOAO7H+pYSlr8lngh9yKjVG9/Gd6d19oRePFQUrVUSPQamd58itFJh+eSmTGQfLR
 v2wT6U7Hi1h83uKw3e/9EheCqH9hJDbXqrd8zqM5wbb0sTXkRIbyiJ8kek5qBVK+HXpg=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.94.2)
 id 1nFd7p-00F9Xk-Aw
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 03 Feb 2022 14:30:17 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id E87F661985;
 Thu,  3 Feb 2022 14:30:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12CD4C340F3;
 Thu,  3 Feb 2022 14:30:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1643898611;
 bh=WQlUEDnPU6rflf/eis0zKL8HGwOfYb/N1ihp+Oy30rI=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=cgAohf+IerzFlOsz0HEomaf4zOuahOJgqEnXCuvsK3C5AgrQZG/ReE32vv2VpSQvy
 6UkzJ2H2D9Y2f3HyPfrTp5PMSppPVO73/EPi/StG9A5e8auurbVYWHVL8MyZuKHrGD
 DOJZ3ui6D4H/tu4YbYe1KZ76/JLPhfpMrdjlPe5HfVclQz06iRH4cdglMwaI3lk/3Y
 RSmRZCmgoaOF9+S5PrTfEtt/rqXcQXH0MCnh8uo4cTRXoAgOdm4+8e4Ua1PQSeT6Ad
 8T1SBcHKgrMHFycKu9lguVHRyiFX5RLPEJpqnOLflmpTkTqR7mIsuY13skXRO9pLNu
 8dUuSFKsYAeRA==
Message-ID: <28244cc2-8e83-0730-1777-a363b834819e@kernel.org>
Date: Thu, 3 Feb 2022 22:30:05 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Content-Language: en-US
To: Eric Biggers <ebiggers@kernel.org>
References: <20220130092858.1260210-1-sunke32@huawei.com>
 <6dbebe97-b29d-ede4-79cf-4d66b2d44c01@kernel.org>
 <YflzoYxCHlA+yCdw@sol.localdomain>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <YflzoYxCHlA+yCdw@sol.localdomain>
X-Headers-End: 1nFd7p-00F9Xk-Aw
Subject: Re: [f2fs-dev] [PATCH] common/attr: _acl_get_max echo 532 for f2fs
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
Cc: Sun Ke <sunke32@huawei.com>, guan@eryu.me, fstests@vger.kernel.org,
 linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2022/2/2 1:53, Eric Biggers wrote:
> On Sun, Jan 30, 2022 at 11:07:17PM +0800, Chao Yu wrote:
>> On 2022/1/30 17:28, Sun Ke wrote:
>>> Run generic/026 on f2fs, the diff:
>>>
>>>       -chacl: cannot set access acl on "largeaclfile": Argument list too long
>>>       +Wrong ACL count - 532 != 531
>>>
>>> The ACL_MAX_ENTRIES depend on MAX_VALUE_LEN(inode), MAX_VALUE_LEN(inode) I got
>>> by printk is 4244, so I think the ACL_MAX_ENTRIES should be
>>> (4244 - 20) / 8 + 4 =532.
>>>
>>> Signed-off-by: Sun Ke <sunke32@huawei.com>
>>
>> FYI:
>>
>> https://patchwork.kernel.org/project/fstests/patch/20170428131307.3384-1-chao@kernel.org/
>>
>> I've update the patch based on Jaegeuk's comments, however, I forgot to send it to
>> mailing list, so could you please check revised one below?
>>
>>  From 68965c837fd04795064b352589e3f7005e6d75f5 Mon Sep 17 00:00:00 2001
>> From: Chao Yu <chao@kernel.org>
>> Date: Fri, 28 Apr 2017 20:51:11 +0800
>> Subject: [PATCH v2] attr: adbjust acl_max of f2fs
>>
>> f2fs has set inline_xattr as a default option, and introduced a new option
>> named 'noinline_xattr' for disabling default inline_xattr option. So in
>> _acl_get_max we need to check 'noinline_xattr' string in fs option,
>> otherwise we may select the wrong max acl number since we always found
>> the string 'inline_xattr' in fs option.
>>
>> Additionally, f2fs has changed disk layout of xattr block a bit, so will
>> contain one more entry in both inline and noinline xattr inode, this patch
>> will modify the max acl number to adjust it.
>>
>> Signed-off-by: Chao Yu <chao@kernel.org>
>> ---
>> v2:
>> - adjust the config for old kernel as well.
>>   common/attr | 11 ++++++++---
>>   1 file changed, 8 insertions(+), 3 deletions(-)
>>
>> diff --git a/common/attr b/common/attr
>> index 35682d7c..6377a936 100644
>> --- a/common/attr
>> +++ b/common/attr
>> @@ -26,11 +26,16 @@ _acl_get_max()
>>   		echo 8191
>>   		;;
>>   	f2fs)
>> -		_fs_options $TEST_DEV | grep "inline_xattr" >/dev/null 2>&1
>> +		_fs_options $TEST_DEV | grep "noinline_xattr" >/dev/null 2>&1
>>   		if [ $? -eq 0 ]; then
>> -			echo 531
>> +			echo 507
>>   		else
>> -			echo 506
>> +			_fs_options $TEST_DEV | grep "inline_xattr" >/dev/null 2>&1
>> +			if [ $? -eq 0 ]; then
>> +				echo 532
>> +			else
>> +				echo 507
>> +			fi
>>   		fi
>>   		;;
> 
> Can you add a comment that explains how these numbers were calculated?  They
> seem very random.

I guess Sun Ke has given a good example...

If inline_xattr is enabled, max xattr size should be:
(4096 - 24 + 200) - (24 + 4) = 4244
then ACL_MAX_ENTRIES should be:
(4244 - (4 + 4 * 4)) / 8 + 4 = 532

Otherwise, if noinline_xattr is enabled, max xattr size should be:
(4096 - 24) - (24 + 4) = 4044
then ACL_MAX_ENTRIES should be:
(4044 - (4 + 4 * 4)) / 8 + 4 = 507

+Cc f2fs mailing list.

Thanks,

> 
> - Eric


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
