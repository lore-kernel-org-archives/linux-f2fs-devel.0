Return-Path: <SRS0=Z5zS=PK=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 682E9C433F5
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 22 Oct 2021 14:22:31 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A99C60ED5;
	Fri, 22 Oct 2021 14:22:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 2A99C60ED5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1mdvRE-0000R9-U4; Fri, 22 Oct 2021 14:22:28 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <chao@kernel.org>) id 1mdvR4-0000P7-NG
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 22 Oct 2021 14:22:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=5U4Ldb1GyCD7sxU2mqXXYh1QSTaoM8RzI4Eo/qmLcx4=; b=EwV4N9d2Tz7jiYdaJlYlL9bsmw
 RAeuFfuI3MkOaxSW13Rnj1M3hwwA2+if7tNhyJaBFErNzuWQsd0NRaJHPyQaPBb9dcfUTn/+OGQmJ
 brgxi03pRa5/aXide0kBcH9lWNYf7lhBURzhGHcsUePKFioV7GHzRcct6TfWEf8BrUVM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=5U4Ldb1GyCD7sxU2mqXXYh1QSTaoM8RzI4Eo/qmLcx4=; b=YVlr2BiaKiG5ldaQpF5gGXX3ti
 n1IVlS9fgOUsfTzvsmuMEQaEkw6KbV/lpopMxNmqVcJ4MeWsSPeZOqFm01gOgjQqma0cerydV0An0
 e1Hs2ADSYtqteLqHQN3gnKfQadvlocP03EN84qPY+5VO/Y0O4Eh+Wlvtn8v6rufg7SDY=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.3)
 id 1mdvR0-00BuvI-F6
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 22 Oct 2021 14:22:16 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 527A76128B;
 Fri, 22 Oct 2021 14:16:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1634912184;
 bh=2XwGIQYCd7BXFm91WrDjKRyoGcOSgGsahM3gwQctWP8=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=nkacMeC0kiWKbUgOEuxGwqJE/r1TV7R29e4Pe51KjlfF76dXCKhDppgPEMJcx6Gjw
 gXpUTJ5d7jmAPgrwC4BNm+rchMzvH7wr3lf+RfFEyQdO2CVIwcKyoRTvwQixAIsUb5
 Op0FMOI8j5tz1aApE3KU78ZE3t6bxLvkLTytY6XPL8QGKPa5MGcnDyzFKGWHeLk/JW
 OSu7KW+8y9Oo+v9mjgHVEvIHiwlSaInMEbrTWBvRQJsyW5Q7Rr9toR07buEeoP+xOD
 huLXkRrU8a0A+B3n6BW1iqcL0c2Qj9ul8/7/nrhL4rbJUt16Od9nALLKU2hvb+NrmF
 1h5/sATv1ltSA==
Message-ID: <d22bad26-266b-fc5f-efe8-cdad9fd4c1ce@kernel.org>
Date: Fri, 22 Oct 2021 22:16:19 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Content-Language: en-US
To: Jaegeuk Kim <jaegeuk@kernel.org>, Daeho Jeong <daeho43@gmail.com>
References: <20211006174910.2964885-1-daeho43@gmail.com>
 <5743eeca-a6e8-87d4-5799-c622fbada429@kernel.org>
 <CACOAw_zfDZMB4pLEuHWU5YcKnAtfBBTSuXwXy+L2rNJxXC3ysg@mail.gmail.com>
 <16840026-35ba-cce6-4e0b-3332b0902d2a@kernel.org>
 <CACOAw_xW7MZi8BVi-2Zo-=LruZr6k7fC7huYiYuWyaDDDti6WA@mail.gmail.com>
 <02abeeba-c359-cae3-4759-ee2087f21cc9@kernel.org>
 <CACOAw_xh2HSQDjb_tGopvssipDJYnpi4O1X5_eJqSOLpLebqsw@mail.gmail.com>
 <YXHZN5J2jyPG5tcx@google.com>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <YXHZN5J2jyPG5tcx@google.com>
X-Headers-End: 1mdvR0-00BuvI-F6
Subject: Re: [f2fs-dev] [PATCH] f2fs: include non-compressed blocks in
 compr_written_block
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

On 2021/10/22 5:18, Jaegeuk Kim wrote:
> On 10/21, Daeho Jeong wrote:
>>> Okay, shouldn't we Cc stable mailing list for this patch? otherwise
>>> userspace tool may get different stat number with the same compressed
>>> file in different kernel?
>>>
>>
>> Oh, could you let me know what the address of the "stable" mailing list is?
> 
> Added Fixes and -stable. :)

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

> 
>>
>> Thanks,
>>
>>
>> _______________________________________________
>> Linux-f2fs-devel mailing list
>> Linux-f2fs-devel@lists.sourceforge.net
>> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
