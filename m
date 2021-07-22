Return-Path: <SRS0=svdC=MO=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDB1FC63793
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 22 Jul 2021 13:19:04 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D80761285;
	Thu, 22 Jul 2021 13:19:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D80761285
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.92.3)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1m6YbP-0000m1-UA; Thu, 22 Jul 2021 13:19:03 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.3)
 (envelope-from <chao@kernel.org>) id 1m6YbO-0000lq-OE
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 22 Jul 2021 13:19:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=wn3/zER1SmoOGkGXhadAkyCKqlAHVlh75+56/1U54eE=; b=eMo93zwtLdiJYzuQEP+AtLy4o6
 0SdJ+aMGvsy6NPmB73O9c3x1TbIXSikFjTFafIE3RC1aXdUu9H+YftP+2Xe2JRinTQeTw6SY3kSM/
 EOBIOH9NUIv3Julg37hoiUwJRvskyctM3RFunb5YVhumRdxPPOgusli4BnirpzTQJ5KU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:
 Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=wn3/zER1SmoOGkGXhadAkyCKqlAHVlh75+56/1U54eE=; b=mMH1G/JuIyhmsbA8bso0hmRqfE
 ySMkRh8AZVpOquzAng7myvZksrNIU3cbbopMOejLOd4XGnwnnazZ6SUL9cxCtPydJ145MLyMpuCJq
 1NBPDzoK1z4A1GGVFcjrN4EMt1lm12iT0r++Zdmb4jgOnWauG0Ogy9taKnIZ8/uYze7s=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.3)
 id 1m6YbD-00GrGO-DM
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 22 Jul 2021 13:19:02 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 13F5161285;
 Thu, 22 Jul 2021 13:18:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1626959926;
 bh=bcv6IlJoNXeSdpHKVKcs8UYSOQPfqrUyXA/cjo4gCLQ=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=hpa/PlOmQWI4uX70I/rgeb4xwoQsWfZ5+S7/FELSskTu0VDMgrehUQZHQjcQjhK/z
 1YW/Ai5InjBhbpPSszqaDqhKu5srzn/C2zP/T0n1ZRzWKXZSVFXTQzc01+KK4w1U+s
 WtPXuf78f31l3M6nFFgvTBmqSlgh+WC9uxguYKNdx31d2uiJRRyxd/jcCpeO0rLq6j
 7Ua/trlfpu8yS0Eo7OTRZ24J2cuI69i9Y+19GD0IPFSo2JeGSzis2qiODsqshR2dUi
 Lm5KXgRIKwJH8xDl85Qsdz2mDJ71kwGO1DcEUG9EM960/oUjUhJsgTg5VWMXRcrckY
 UjadbOyfJ9TlQ==
To: Eric Biggers <ebiggers@kernel.org>
References: <20210719084548.25895-1-chao@kernel.org>
 <YPi/4kMUAhlRZV3M@sol.localdomain> <YPjNGoFzQojO5Amr@sol.localdomain>
From: Chao Yu <chao@kernel.org>
Message-ID: <311ab257-2d67-fd73-8359-af5b44e1447c@kernel.org>
Date: Thu, 22 Jul 2021 21:18:43 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <YPjNGoFzQojO5Amr@sol.localdomain>
Content-Language: en-US
X-Headers-End: 1m6YbD-00GrGO-DM
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: fix wrong inflight page stats for
 directIO
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
Cc: jaegeuk@kernel.org, Chao Yu <chao.yu@linux.dev>,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2021/7/22 9:42, Eric Biggers wrote:
> On Wed, Jul 21, 2021 at 05:46:26PM -0700, Eric Biggers wrote:
>> On Mon, Jul 19, 2021 at 04:45:48PM +0800, Chao Yu wrote:
>>> Previously, we use sbi->nr_pages[] to account direct IO, the count should
>>> be based on page granularity rather than bio granularity, fix it.
>>>
>>> Fixes: 02b16d0a34a1 ("f2fs: add to account direct IO")
>>> Signed-off-by: Chao Yu <chao@kernel.org>
> 
> Also, do we have to do this, as opposed to just moving F2FS_DIO_WRITE and
> F2FS_DIO_READ out of ->nr_pages[] and into separate counters that are clearly
> defined to be per-request?  As Christoph pointed out
> (https://lkml.kernel.org/r/YPU+3inGclUtcSpJ@infradead.org), these counters are
> only used to check whether there is any in-flight direct I/O at all.  (They're
> also shown in /sys/kernel/debug/f2fs/status, but that doesn't really matter.)
> 
> As Christoph mentioned, there is a way to avoid needing f2fs_dio_submit_bio()
> (which would save a memory allocation for every bio, which can fail).  But it
> will only work if the counters remain per-request.
> 
> Can we leave these as per-request?

I updated the patch, could you please check that?

Thanks,

> 
> - Eric
> 


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
