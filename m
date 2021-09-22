Return-Path: <SRS0=RrLa=OM=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30C1FC433F5
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 22 Sep 2021 15:23:57 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E9ECC61181;
	Wed, 22 Sep 2021 15:23:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E9ECC61181
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1mT46G-0006Ij-8a; Wed, 22 Sep 2021 15:23:56 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <chao@kernel.org>) id 1mT46E-0006IR-UN
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 22 Sep 2021 15:23:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=LMjlOJ1t0FktSX5butIuqaDOYt0LJpEiPab6bYeKa0Q=; b=CbUffzPoJi2llMci+k0LCwaIXy
 bN7gBj+1ejU4AwJeerkM3hAKIpt4aW3xhUlyMTR/5IDiSlERLx6Ln9Qj/maH0508Yuq1Tn/HP/Iq5
 eVOcfQBLkccIghApc631wtHi9D6oBdcotk33dIeKWULdUgMeMaA+YaGNCvRNcWsFXhsA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:
 Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=LMjlOJ1t0FktSX5butIuqaDOYt0LJpEiPab6bYeKa0Q=; b=GgCmv4JiGrvRvpYadKKZm+SQWb
 oNFpep7gFpgBqT+WSG7wM/qTljbiLZSaK50QdgnwLbbFxt8yf97G3sQIoBznVvUPjrld30kq3HYSj
 XNB6hUintOLgtj0sfwLlJ27VPviKiBSf3B4UuuSpxEyIClgco+WEINWNEkbF0wzqGhzM=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.3)
 id 1mT467-001mQw-U2
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 22 Sep 2021 15:23:54 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 51A62611EE;
 Wed, 22 Sep 2021 15:23:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1632324222;
 bh=iQtZW7bI/BbYz50FbzeKEjP01m1V9pZsyCJK85pCxCk=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=Nq+UGdpuHjxkrO38TRVQ70c83KK9my+Fru9cYgbKriisyN2+PIHg1QjqDjs3BEmqk
 xOWIBexO75Wtav7mMxavaKWhDofU3umydS4ArZVNQXsRGdQp48XaboFV87U9X5uQSZ
 vPspefhIAEyirojJ/78FVJTGhIfBdRooGSoN+itn+ebpe4wgmK4/a0CfWz2QHVy1s5
 lYxyQ501Vp8AVBeDG3WcMuLAxqfRoPLEiG8l2Fwb+UM5776TG8Hqq38lEnakAfcI2B
 4SwmIM8SPJeYAG5/kGXzFkHjkuuE4NGojvrg8NQ8zQckQlgEOgOt67eJD7Nllcatny
 Ndof6jlzjntsw==
To: Jaegeuk Kim <jaegeuk@kernel.org>
References: <20210902172404.3517626-1-daeho43@gmail.com>
 <YTvmhVhLlBPeASHT@google.com>
 <9f4a2954-e8c9-abc5-5df4-a7cec53433a3@kernel.org>
 <YUkR84sklj0SgosC@google.com>
From: Chao Yu <chao@kernel.org>
Message-ID: <6c592379-104d-8975-4385-9778f23cda56@kernel.org>
Date: Wed, 22 Sep 2021 23:23:39 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <YUkR84sklj0SgosC@google.com>
Content-Language: en-US
X-Headers-End: 1mT467-001mQw-U2
Subject: Re: [f2fs-dev] [PATCH v4] f2fs: introduce fragment allocation mode
 mount option
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
Cc: linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com,
 Daeho Jeong <daehojeong@google.com>, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2021/9/21 6:57, Jaegeuk Kim wrote:
> On 09/12, Chao Yu wrote:
>> On 2021/9/11 7:13, Jaegeuk Kim wrote:
>>> Wait. Why do we need to add so many options here? I was expecting to see
>>> performance difference when getting random segments or random blocks as
>>> an extreme case. I don't get the point why we need the middle of those cases.
>>
>> I guess we can simply the aging test procedure of filesystem by changing a bit
>> based on this patch.
> 
> My question was on "fragment:fixed_block".

This mode can be used for below filesystem aging scenario.

Fragmenting filesystem with specified pattern:
1M chunk | 1M hole | 1M chunk | 1M hole | ...

e.g.

Before
1. create/write 10 1M files: file0 file1 file2 ... file9
2. remove file1 file3 file5 ... file9

After
mode=fragment:fixed_block
fragment_chunk_size=1M
fragment_hole_size=1M
1. create/write one 10M file

Thanks,

> 
>>
>> See comments in below thread.
>>
>> https://lore.kernel.org/lkml/425daf77-8020-26ce-dc9f-019d9a881b78@kernel.org/
>>
>> Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
