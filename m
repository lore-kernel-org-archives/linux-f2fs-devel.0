Return-Path: <SRS0=4sEP=MM=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35E70C07E95
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 20 Jul 2021 01:25:27 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E58B66113E;
	Tue, 20 Jul 2021 01:25:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E58B66113E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.92.3)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1m5eVi-00072W-BJ; Tue, 20 Jul 2021 01:25:26 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.3)
 (envelope-from <chao@kernel.org>) id 1m5eVg-00072P-QX
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 20 Jul 2021 01:25:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=i2piWmfFmI1jGJzyWtU2k1v6B/zQ32HtdX+UR8+ABWI=; b=Sim9JBDXfi+lHqbAylLkFTvD6U
 qd9nKJkyt23ClGwWn0dUZ71OgmXqCpDCpOVgWOH/vB62tH5N25cn3Idl/H++K2atiDh/Ls5NKYjmw
 8IHtKddiP5MdkAOSYhkN4Vc6tKBw/G/KCWPut9z/h5s9qBMg5yRm11fuFZAp0wuk6v48=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:
 Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=i2piWmfFmI1jGJzyWtU2k1v6B/zQ32HtdX+UR8+ABWI=; b=IRUKHzX9yPKSc/fLtIjhSmlPgZ
 o5htFYGeANheqR3KCEmptuPwh5Np7tZmEZDY6iwJHHvVYdublD/qeDCVx80h/tu/Fw+6d/wxIGCcL
 N6wUWud2wMcoNpBacZBZNCtusmsb2RTbyUUWUjlhjPRaFID4AIrzdVtnJFvghuwXQB6s=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.3)
 id 1m5eVa-0007nO-Ok
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 20 Jul 2021 01:25:24 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 724C261004;
 Tue, 20 Jul 2021 01:25:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1626744313;
 bh=bpoJFkc4WP2VzWtNaJ/5hbShq0wuVrNcAqjgy9xe0dM=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=kSj9FQkIYMaGBkCPL2bAtuP3Wu493GiAD+3SIzDma00gZQ7n71KbZ12bbw7242ZF5
 G/2VNmUGmYDduNbI6QpMcn11skyy9Y2gBzrTlCI8oEl23fDaOEVHt5a6jrdtikPLB7
 j4Cv5q3sGI0QczWO4SPDqcFK1aPqnVGzF8nTPoH/3URgrW3DkFWOyKqm+EwmjpyiV0
 2LoBWYuBGKvDzXSzOwDExCUAISxiZecCNVR+01Cy2BUFnqCpK0BwlvtSPTSJhydt3t
 ObQtZJ1AR4rRrqsDC4qmMYBCj/NDhpMEaplAFNflZeH9DdBAF7AafvFPZwjqOtfjl8
 47IYGc95m1Z5A==
To: Jaegeuk Kim <jaegeuk@kernel.org>
References: <20210719084729.26117-1-chao@kernel.org>
 <YPXEMU8nQdv8n4Dg@google.com>
From: Chao Yu <chao@kernel.org>
Message-ID: <3c2646ae-138b-c0fe-a757-06ae16b31928@kernel.org>
Date: Tue, 20 Jul 2021 09:25:10 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <YPXEMU8nQdv8n4Dg@google.com>
Content-Language: en-US
X-Headers-End: 1m5eVa-0007nO-Ok
Subject: Re: [f2fs-dev] [PATCH] f2fs: multidevice: support direct IO
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

On 2021/7/20 2:28, Jaegeuk Kim wrote:
> On 07/19, Chao Yu wrote:
>> Commit 3c62be17d4f5 ("f2fs: support multiple devices") missed
>> to support direct IO for multiple device feature, this patch
>> adds to support the missing part of multidevice feature.
>>
>> In addition, for multiple device image, we should be aware of
>> any issued direct write IO rather than just buffered write IO,
>> so that fsync and syncfs can issue a preflush command to the
>> device where direct write IO goes, to persist user data for
>> posix compliant.
> 
> Is this aligned to Eric's iomap work?

Will rebase to it soon, when would you plan to queue that iomap serial?

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
