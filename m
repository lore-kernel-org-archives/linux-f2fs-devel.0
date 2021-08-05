Return-Path: <SRS0=icLK=M4=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 506B4C4338F
	for <linux-f2fs-devel@archiver.kernel.org>; Thu,  5 Aug 2021 03:15:31 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0467161073;
	Thu,  5 Aug 2021 03:15:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 0467161073
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1mBTqz-0005FG-FE; Thu, 05 Aug 2021 03:15:29 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <chao@kernel.org>) id 1mBTqh-0005Ez-Em
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 05 Aug 2021 03:15:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=X6K3auAgRhF+RUbPJjZnAurEYaPwpowqxcGV7iBFts0=; b=NgnpNYz6xXXuLGDaENRdG9mQuw
 sSQpv3K9bCPuR9wcXGHUqhE8QkS8Tb7CpoTv9bEovi0aF6gczmVZ3fxQEo7o1FPwM/7+HwUuDRG4Q
 W5lJsjliExUDqCmtgN1TYvhAKIBhIhGxiifuxeBDEFeIPYDxoKuqCe2LGUb/zrAnYZKI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:
 Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=X6K3auAgRhF+RUbPJjZnAurEYaPwpowqxcGV7iBFts0=; b=efr/2o7P/zzGOnaYBXYRSlcw7w
 uQlvvbr3DyGRnKC2ECUBmyJcEg9qNukZVXCCkvFwCuRbOsFliF7yU37XLsx8eamfWJ7BzXX9p5CJl
 ZWlGDvfMIbvftN5mrRVGXvKFraAbJKzvMEOXOGvAQjZAE3Ch0F0fgh0WUfn4k/YyQMbc=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.3)
 id 1mBTqb-00Clth-1F
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 05 Aug 2021 03:15:11 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id A420F610A0;
 Thu,  5 Aug 2021 03:14:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1628133299;
 bh=5cm8AXwBgyiHBMqWiIPN+HOr+oCVs4hexDU07cDPJKw=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=bC9DZgtuvKOCo1hfq3Tm65pNNhMnlGTlHbBBM3zC6FHGXMVuS/jOLX7Yo0BBy4bLQ
 lHUCBSxWb5HuQyHNGUVp7iFTWYFyXjT3o912hXnubu+YVzZujEInJNvGOfaX12cWx1
 LO/UjuSpcROQWm/IeN25ldBkPsDEYyb7eL3l3rL9PAocMq8XuFgCi/sz9k0sjh4EQY
 UBZ7fio6jtcLRj5YDzwIYi1FzpbcGrE8OFNDUWwkPxlgeGvA8QOzx8YWCsk3rCvWiN
 RFhlZbw3ci2avSZSIyWLk5RPrLp7LuD4wlqxMHWTKnvVN4gtASQ3JXoKiquy66XDKm
 jvbYXoSqILQjQ==
To: Jaegeuk Kim <jaegeuk@kernel.org>
References: <20210804022348.1414543-1-chao@kernel.org>
 <YQsIj0wKk6YbN/FJ@google.com> <YQsmfm3ibU6bhvZr@google.com>
 <0dad9863-4aa2-3ea3-fd97-457aa635ed66@kernel.org>
 <YQtSrIx0/sAipDs4@google.com>
 <62eb8902-90fa-4b1a-55ce-a178643baf90@kernel.org>
From: Chao Yu <chao@kernel.org>
Message-ID: <8f8a2aad-a201-01d2-eb31-06289421d6ec@kernel.org>
Date: Thu, 5 Aug 2021 11:14:56 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <62eb8902-90fa-4b1a-55ce-a178643baf90@kernel.org>
Content-Language: en-US
X-Headers-End: 1mBTqb-00Clth-1F
Subject: Re: [f2fs-dev] [RFC v3] f2fs: extent cache: support unaligned extent
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
Cc: Chao Yu <chao.yu@linux.dev>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2021/8/5 11:04, Chao Yu wrote:
> On 2021/8/5 10:53, Jaegeuk Kim wrote:
>> On 08/05, Chao Yu wrote:
>>> Jaegeuk,
>>>
>>> On 2021/8/5 7:45, Jaegeuk Kim wrote:
>>>> Chao,
>>>>
>>>> How about this?
>>>> https://github.com/jaegeuk/f2fs/commit/d6bbe121bc24dfabfedc07ba7cb6e921fb70ece0
>>>
>>> Looks more clean, thanks,
>>>
>>>>
>>>> I'm digging one bug in __insert_extent_tree w/ the patch tho.
>>>
>>> Shouldn't we initialize @ei in f2fs_update_extent_tree_range(), otherwise,
>>> __try_merge_extent_node(&ei) -> __is_extent_mergeable() will do the check
>>> w/ uninitialized c_len of @ei.
>>
>> Fixed some bugs, but still getting another data corruption.

You mean data readed indexed by extent cache is inconsistent with the on-disk one,
right?

Thanks,

>>
>> https://github.com/jaegeuk/f2fs/commit/c5d97919c55b467392407b60c1a7b1e3e81721ff
> 
> Let me rebase to your code, and do some tests.
> 
> Thanks
> 
>>
>>>
>>>>> On 08/04, Chao Yu wrote:
>>>>>> +	if (from_dnode)
>>>>>> +		goto skip_reading_dnode;
>>>
>>> Wrong condition here, thanks for fixing.
>>>
>>> Thanks,
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
