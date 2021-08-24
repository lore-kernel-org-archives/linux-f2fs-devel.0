Return-Path: <SRS0=FIBF=NP=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E1F2C4338F
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 24 Aug 2021 01:31:59 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B1E32613B1;
	Tue, 24 Aug 2021 01:31:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B1E32613B1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1mILID-0001jy-NU; Tue, 24 Aug 2021 01:31:57 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <chao@kernel.org>) id 1mILIC-0001jo-BD
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 24 Aug 2021 01:31:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=5dk9KAdjFTwMIemab6BmTVmu3uoE+I1lsFn8Gd18PME=; b=QakvN2Jhpd2A5lP56g9REitqgj
 e3Y7gD4Vr6YeuUWCc+wlV4hqX4Tk/AjY1WDyGN09WCXKVQjfI6P0c18tGQTPge0x4rcUIsQ56JzWN
 OPpf2SSPBT6DJRiIrcOeKcYjHBy8GqYQiChsr+NstUv6zaC4doCJAmUR82WTIz7ibi0I=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:
 Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=5dk9KAdjFTwMIemab6BmTVmu3uoE+I1lsFn8Gd18PME=; b=gdC/lv+LSvbtuAw2Suf/RSOkt2
 QynmIEtdWCSnZY92l8BeNoAspJ3mnPm89ciwh0LgFUuGGEt/H0TNKVXv3BqzzZKaOr4ewplRWmow6
 cmUB2bOaUydxValhs7aK/eELmXeqQvspC2xpefwnSq4LmGYvgEdTuhBAGt80krYyxeeI=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.3)
 id 1mILIB-0005l1-5f
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 24 Aug 2021 01:31:56 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id C2452613B1;
 Tue, 24 Aug 2021 01:31:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1629768708;
 bh=3ypYGUhqc1Arh9dmrLMyzzsqCNrdZMllCVgunLULrzk=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=qnRlTkiMe2IQ+BM060szoD41+CMcBT7Ex3asL4USZCC/hyA4p61EwmxvdHBFBk2JK
 JQR/rs23nz/G2zFr3bdibs8jrq6JpQ8TTW2f2zIQUj0epyjItxTFD2DSHRrMVnaJSA
 IFI7fq4MLrFH1bYM3AMAxXXj4kr/0eplIWe19ZRRh6u6RcH1A0kkR/FtL4NoxsrOMN
 3M7hEql4/iu73Tr8JbRZO6Lkbw1fqcZ4UmyKheORqUnkPu81ytmJIlTg7q/1m47E08
 5x1Kwh0Nn5gWx7nGv2ygZNJ526iJzspHwslll9XF53Q1iIdgp1fbJdKnPQ2ZU49icu
 IsxpttNHxiz4A==
To: jaegeuk@kernel.org
References: <20210824011948.15408-1-chao@kernel.org>
From: Chao Yu <chao@kernel.org>
Message-ID: <eadccf3a-057f-4d79-895d-140927167b69@kernel.org>
Date: Tue, 24 Aug 2021 09:31:47 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210824011948.15408-1-chao@kernel.org>
Content-Language: en-US
X-Headers-End: 1mILIB-0005l1-5f
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix wrong option name printed by
 parse_options()
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

On 2021/8/24 9:19, Chao Yu wrote:
> It prints below kernel message during mounting w/ checkpoint=disable
> option:
> 
> "F2FS-fs (pmem0): checkpoint=merge cannot be used with checkpoint=disable"

Oops, this message should have been removed by

"f2fs: rename checkpoint=merge mount option to checkpoint_merge"

I may used old f2fs module, please ignore this...


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
