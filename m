Return-Path: <SRS0=VCJL=M2=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64731C4338F
	for <linux-f2fs-devel@archiver.kernel.org>; Tue,  3 Aug 2021 01:07:34 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2528160F9C;
	Tue,  3 Aug 2021 01:07:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 2528160F9C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1mAiu4-0000Ar-CQ; Tue, 03 Aug 2021 01:07:32 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <chao@kernel.org>) id 1mAiu3-0000Af-3r
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 03 Aug 2021 01:07:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Z2MColt8gSaiEqdJX598fJwCeSZZOO6STq2Uc0TPLC8=; b=kM23FtgQPL8zDLB1tuVs63dJZu
 TCnlHOeDd3BN+ST8IxDcyhm93NXkHjf43OcNQ40TRh0K/yEQIa0ZMOyO+fz//0G0Fj1J2k6G6uVdE
 wTuVNenOF1+obPzabU2PaaCQFscn4HRcww/Q1+Qy51jl4RHDSFWYqFNOnPg11R86bkis=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:
 Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=Z2MColt8gSaiEqdJX598fJwCeSZZOO6STq2Uc0TPLC8=; b=Ztboh12TTDYmmjpbs14Oj/p5H9
 oR0WFY2EioQvQnFZi2hSOVi6snZVvdufv7C6REgi9HtDw035Pgr7GLDCZWX/c7WeOJpTQrPOlBF+h
 7onL+DflnCk9qGLzxY1Mcm6YXx/GtTeZdTCibu3u6ZrB6/3MUKeHuBp9P5SQiiL22dxo=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.3)
 id 1mAiu0-0002C4-Cw
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 03 Aug 2021 01:07:31 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3C5C460F9C;
 Tue,  3 Aug 2021 01:07:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1627952843;
 bh=gqoUY+WypcTVS9T5fCC9B2LZOiAtQUuaP7ib+nH0mqo=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=C+guK3wo3oQ8SdMdH5v1DypVz76yeAWsUm+LojLC9wD77dC6bdUdtXDmcSGeRBUng
 GT3fOO0LhUSIuyvnrgvQ+0IwI56D4Bb6Kc25LuN6rtOAux1xszIH3goURjP526+TKO
 lVmpGZANslmQdlbhyJJCNqNt7UnlYjliXkBAKXdnp5uUXYWxpt2fpzuLedQ/Q6Qpx9
 gJkIDDfDhtQOXWJlxDXwt1ZDcgLm1dyOebMVBEpI9yXx+kZk6qmdEcnMGNdz1lHpFK
 ESfZDAyHJLOYR7PCB3Id/FmQZ+6haq7JfK4Ptn4iRdYCPbRCuUSPTm2CeVQExga0zx
 AAT2fy1cx1kiQ==
To: Jaegeuk Kim <jaegeuk@kernel.org>
References: <20210707015815.1978-1-chao@kernel.org>
 <YQRQ4kHvdRTBnb10@google.com>
 <51565c85-a475-bcb8-bbb2-e3125c5223a3@kernel.org>
 <YQgziuikMr0fvlT7@google.com>
From: Chao Yu <chao@kernel.org>
Message-ID: <3256dc39-2a82-cb60-038b-69e262c32d18@kernel.org>
Date: Tue, 3 Aug 2021 09:07:22 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <YQgziuikMr0fvlT7@google.com>
Content-Language: en-US
X-Headers-End: 1mAiu0-0002C4-Cw
Subject: Re: [f2fs-dev] [RFC NO MERGE] f2fs: extent cache: support unaligned
 extent
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

On 2021/8/3 2:03, Jaegeuk Kim wrote:
> On 08/01, Chao Yu wrote:
>> On 2021/7/31 3:20, Jaegeuk Kim wrote:
>>> On 07/07, Chao Yu wrote:
>>>> Currently, it only works in readonly format f2fs image.
>>
>> There wouldn't be any race condition because unaligned extent only works
>> for ro feature now?
> 
> Isn't your patch proposing on writable partition?

Please check description in patch message, now it was designed only for
compression case w/ ro feature, let's check and support rw partition later.

Thanks,

> 
>>
>>> Is there any race condition between the address in extent_cache and the one in
>>> dnode? I feel that we could synchronize it by locking its dnode block.
>>
>> Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
