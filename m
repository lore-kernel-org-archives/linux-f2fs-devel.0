Return-Path: <SRS0=TfYr=L6=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94761C07E99
	for <linux-f2fs-devel@archiver.kernel.org>; Tue,  6 Jul 2021 00:34:26 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4494361978;
	Tue,  6 Jul 2021 00:34:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4494361978
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1m0Z2e-0001Sb-Nv; Tue, 06 Jul 2021 00:34:24 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <chao@kernel.org>) id 1m0YlT-00086N-Iu
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 06 Jul 2021 00:16:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=/smN0w1INxk9pv/0As8keZJ+96h8KhmxqWKljh+DixM=; b=OZ6Cwqlsj1wvFFJVtYzOjof3p6
 dIC5W3QhTsXif+EnQWG7qCRkmJMjc+J9yb36NUaKjmBoafvFyXjqsV9RWYlUEeRdsmtv4FNWzNtTU
 GK2f5rI39CegEMe3acbwANAVNAB64Xx7HfQgLS9uUHHk0WTgYWu0ahzKqRGZWs4E6Z2Y=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:
 Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=/smN0w1INxk9pv/0As8keZJ+96h8KhmxqWKljh+DixM=; b=lDhTu7wAPV+3woXzQbbIurSJq7
 V0CiCxOF0MkZzlJOlSf4KUBxkEhsAAsIfKHfe7S+4zw2x0Ul3sirSOV8q17XsZgj16u8FvmFze/Hm
 odINYGD+8Rabht7u6YmT61bUntv/XFj12TXrldS7N4RhiIs02MqONqoitkJy5qbChtuI=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.3)
 id 1m0YlC-0000t4-NQ
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 06 Jul 2021 00:16:39 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4C8C261369;
 Tue,  6 Jul 2021 00:16:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1625530572;
 bh=fqgzG4+YdYoZurlm67YVOrIFeRf44ClBBF+6X3iuwcQ=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=eCJQMY5HKRT2+u6RtUoTlB8PcxLAr5pgMWFH7Ao/crZh0YbROxhfTm0UnfEkl+0qO
 ix9MDz60WwZxOEQnMAgupiPgeEeuj0BbrFroqE6cpIKmu7bO6x4e/NtSQIQJebixsQ
 z9y558GVFtIHaTA/f1QST5mopjTvr1/DE/7G4NcgEaVrYE9r4/CXmjERSXpeL8I7i1
 W/SvbYuBie6NFVs7uo//DhBxVDm60QNzaQrlzDKmWo92MsqWEx3LC9d0JXkJJJImn4
 hPHuU7jbz5BZFhv51PImowmsY90oo+5i10ps0+Q4jLbgxWw3EQplCBJf5uO3287COe
 r0YfW4QzuCrtg==
To: Jaegeuk Kim <jaegeuk@kernel.org>
References: <20210705052216.831989-1-jaegeuk@kernel.org>
 <c32642d6-6de2-eb2d-5771-c7cefa62fab5@kernel.org>
 <YOLJW0IgCagMk2tF@google.com>
 <e2fdf628-f25c-7495-cfd1-952899f7ff9a@kernel.org>
 <YOLxZAnaKSwBIlK9@casper.infradead.org>
 <5ab8d01a-8fac-60b2-9c2c-a32c5a81b394@kernel.org>
 <YONKKOBwPUdORO59@google.com>
From: Chao Yu <chao@kernel.org>
Message-ID: <5700f9ec-20e9-7de9-7f8e-c11ec7279c20@kernel.org>
Date: Tue, 6 Jul 2021 08:16:11 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YONKKOBwPUdORO59@google.com>
Content-Language: en-US
X-Headers-End: 1m0YlC-0000t4-NQ
Subject: Re: [f2fs-dev] [PATCH] f2fs: initialize page->private when using
 for our internal use
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
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 Matthew Wilcox <willy@infradead.org>, linux-f2fs-devel@lists.sourceforge.net
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2021/7/6 2:06, Jaegeuk Kim wrote:
> On 07/06, Chao Yu wrote:
>> On 2021/7/5 19:47, Matthew Wilcox wrote:
>>> On Mon, Jul 05, 2021 at 07:33:35PM +0800, Chao Yu wrote:
>>>> On 2021/7/5 16:56, Jaegeuk Kim wrote:
>>>>> On 07/05, Chao Yu wrote:
>>>>>> On 2021/7/5 13:22, Jaegeuk Kim wrote:
>>>>>>> We need to guarantee it's initially zero. Otherwise, it'll hurt entire flag
>>>>>>> operations.
>>>>>>
>>>>>> Oops, I didn't get the point, shouldn't .private be zero after page was
>>>>>> just allocated by filesystem? What's the case we will encounter stall
>>>>>> private data left in page?
>>>>>
>>>>> I'm seeing f2fs_migrate_page() has the newpage with some value without Private
>>>>> flag. That causes a kernel panic later due to wrong private flag used in f2fs.
>>>>
>>>> I'm not familiar with that part of codes, so Cc mm mailing list for help.
>>>>
>>>> My question is newpage in .migrate_page() may contain non-zero value in .private
>>>> field but w/o setting PagePrivate flag, is it a normal case?
>>>
>>> I think freshly allocated pages have a page->private of 0.  ie this
>>> code in mm/page_alloc.c:
>>>
>>>                   page = rmqueue(ac->preferred_zoneref->zone, zone, order,
>>>                                   gfp_mask, alloc_flags, ac->migratetype);
>>>                   if (page) {
>>>                           prep_new_page(page, order, gfp_mask, alloc_flags);
>>>
>>> where prep_new_page() calls post_alloc_hook() which contains:
>>>           set_page_private(page, 0);
>>>
>>> Now, I do see in __buffer_migrate_page() (mm/migrate.c):
>>>
>>>           attach_page_private(newpage, detach_page_private(page));
>>>
>>> but as far as I can tell, f2fs doesn't call any of the
>>> buffer_migrate_page() paths.  So I'm not sure why you're seeing
>>> a non-zero page->private.
>>
>> Well, that's strange.
>>
>> Jaegeuk, let's add a BUGON in f2fs to track the call path where newpage
>> has non-zero private value? if this issue is reproducible.
> 
> We can debug anything tho, this issue is blocking the production, and I'd
> like to get this in this merge windows. Could you please check the patch
> has any holes?

The code looks good to me,

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

> 
>>
>> Thanks,
>>
>>>


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
