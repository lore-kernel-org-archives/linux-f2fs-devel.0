Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83201C79FB9
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 10 Sep 2026 14:15:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Content-Transfer-Encoding:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1/SzaAoqcRpFkLPggV/Lrz8P+MZIqNwJdnrYZAvG3ek=; b=SI/vo9mdj/NEHi6JTTIKP63LSh
	YyHCjtWb0bDt/5mABz9Lke3Hwb5OQlyKcAcLhV0RR/Y+D+J6B2wbL9IG1KRGKjVAardTOTaWNqax3
	TqrIfBkZoAkLW1eujFu6rz9ebXzMZhyhZVLBs2JUwhB8M7s1jAp4ksdinnvNrxl4ZlqU=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1x4fYZ-0005GQ-5N;
	Thu, 10 Sep 2026 14:15:15 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1x4fYY-0005GK-58
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 10 Sep 2026 14:15:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=TiUw/s/a5THXpKNutlCo5ceA78d7FKvTZXpt6nB2WDM=; b=euOqLvUvl9PSTwhGkgfSUJn3zZ
 ZJHko/DDGMRP4ppHy3EC3tILbWABuVApmoko0sxvFLMyK5Fu3X2ZtMnLv8dzGVgdsr3ZLRSq03lEY
 GS9BB6FYs1btJTjVObGqUlHr7budunubdlEobVRtKm7BMqhWrwLLZz0VQnj3n/8NnzIM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=TiUw/s/a5THXpKNutlCo5ceA78d7FKvTZXpt6nB2WDM=; b=TgIa4WxLkbkT3BpGCRfh54ydiw
 DzF1SEBpY1jZMu5Y8CpeOucZXqhPof9Rn1br6bCuH5sC+9j/KIp94oru5lIjIoXr5treXbeVrZCml
 8Tn7NgzJc0yWkqdyvLyY/ibR/thfKkhdOuiEIT+yFS4UxmOAb956/MnEoLxRgftRBCbQ=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1x4fYX-0002AD-6K for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 10 Sep 2026 14:15:14 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id D1A9741273;
 Thu, 10 Sep 2026 14:15:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 988CA1F000FF;
 Thu, 10 Sep 2026 14:15:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789049707;
 bh=TiUw/s/a5THXpKNutlCo5ceA78d7FKvTZXpt6nB2WDM=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To;
 b=OykTcqL4d2iurhxpPxK93+PH89vvmNx5+3i+Q3z2sh5S25z14NIvXJG9W0cxefFjA
 NmdwFLDikwh5MJCPIv9VI/ggKb1BrDTx4edHuAPTPyD8Pf9nhxSKUIcZEYnu2/bB9c
 tRwlUkkyUztPw4tcAs4jFtjpsovBvrl0O+CH67EU3UOHsYKl8HDzp9kkFxMV4Ilva4
 M9pnRXd4809xytxNbcxwjvvr1OWn2Hims1vx/XUqQeh9IPXkv0wBDLWvZjkY9KPcNC
 dM5x5RPEv2qsdMQjViayhqn7jHRNwFkeJJPq+llZWG/ws0Ud/sfUVstxoEBZ1S7bWe
 zVs62TqX/jFdw==
Message-ID: <894da5cc-7bc4-4b0f-9d6d-ae80a169616d@kernel.org>
Date: Thu, 10 Sep 2026 22:15:00 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: "David Hildenbrand (Arm)" <david@kernel.org>, Zi Yan <ziy@nvidia.com>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Muchun Song <muchun.song@linux.dev>, Lorenzo Stoakes <ljs@kernel.org>,
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>,
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>,
 Michal Hocko <mhocko@suse.com>, Baolin Wang <baolin.wang@linux.alibaba.com>,
 Nico Pache <nico.pache@linux.dev>, Ryan Roberts <ryan.roberts@arm.com>,
 Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
 Lance Yang <lance.yang@linux.dev>, Usama Arif <usama.arif@linux.dev>,
 Gregory Price <gourry@gourry.net>, Ying Huang
 <ying.huang@linux.alibaba.com>, Alistair Popple <apopple@nvidia.com>,
 Johannes Weiner <hannes@cmpxchg.org>, Qi Zheng <qi.zheng@linux.dev>,
 Shakeel Butt <shakeel.butt@linux.dev>, Kairui Song <kasong@tencent.com>
References: <20260907-remove-pg_private-v3-0-6ae22f9d9272@nvidia.com>
 <20260907-remove-pg_private-v3-6-6ae22f9d9272@nvidia.com>
 <e5792e81-e8a5-42e1-aafe-58dc603f4968@kernel.org>
 <7e11c56d-05e6-48f0-b5b8-b4a0e18ddc1d@kernel.org>
 <520b6aca-b515-4720-977f-1adb484f2e08@kernel.org>
 <d700c4ea-b54e-4195-b124-3c89177ee49e@kernel.org>
 <18ab9827-9e10-4360-a1d0-3b25d86a71a9@kernel.org>
Content-Language: en-US
In-Reply-To: <18ab9827-9e10-4360-a1d0-3b25d86a71a9@kernel.org>
X-Headers-End: 1x4fYX-0002AD-6K
Subject: Re: [f2fs-dev] [PATCH v3 06/14] f2fs: stop using PG_private
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
Cc: linux-mm@kvack.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-kernel@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 9/10/26 17:15, David Hildenbrand (Arm) wrote:
> On 9/10/26 10:43, Chao Yu wrote:
>> On 9/10/26 15:34, David Hildenbrand (Arm) wrote:
>>> On 9/10/26 04:41, Chao Yu wrote:
>>>>
>>>> David,
>>>>
>>>> Thanks for the patch, at a glance, it seems fine, can you please send
>>>> a formal patch? then we can apply to dev-test for test.
>>>
>>> I'm hoping Zi will drag that along as part of this patch set. Is this fine or do
>>
>> Oh, I see.
>>
>>> you want it sent as a complete standalone patch (will make merging Zi's series
>>> slightly more complicated :) ).
>>
>> I think sending as a separated patch based on Zi Yan's patch is fine, since the
>> purpose of this patch is a little different from Zi's one.
> 
> I'd prefer this patch over of Zi's patch.
> 
>>
>> Note that: ("f2fs: stop using PG_private") has been merged in
>> https://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git/log/?h=dev-test
> That just a testing branch, right?

Yes, if necessary we can append the new patch based on this branch. :)

Thanks,



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
