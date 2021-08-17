Return-Path: <SRS0=6Xs1=NI=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B8AFC4338F
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 17 Aug 2021 00:34:37 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B33460F55
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 17 Aug 2021 00:34:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 5B33460F55
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1mFn3t-0003kG-1B; Tue, 17 Aug 2021 00:34:37 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <nathan@kernel.org>) id 1mFn3s-0003k6-6f
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 17 Aug 2021 00:34:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=iTBaXC+dS5RHYNAWlGzl6+PLmpUl/w21Dec4wRKejtk=; b=TPsATTtE8BtKpwCZoqXNLT40ke
 UgHGGxu3y6Kn5a+7CJHXnV/EiLPjmd8gZKReYwPvw0cbZlk8PgYY7Kw+vERbKwCabSP3o5fqMyj1v
 OElWrZb0klB5j+OfVPB855tgLVEikszpspZna4xPtKJZKNv7iLJeU38wpcC+xUcZjF8k=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:
 Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=iTBaXC+dS5RHYNAWlGzl6+PLmpUl/w21Dec4wRKejtk=; b=VaR3g4ER0eBp2l0PyVwZLC3yda
 w7Ul550pRsR1bN75eWIRhEqKh0m+K9STaslJKkaWabPPEr/gbXhz3TykUKdQopIWjGJy1mkUsq4fJ
 /tbQe0yfVQJVpPK+LzRdcB1paJWAcUXIB5KQjSO26MONfkmJfvhDIAOGaVVQRNso7PuI=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.3)
 id 1mFn3s-0006Od-Kw
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 17 Aug 2021 00:34:37 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 680E160F39;
 Tue, 17 Aug 2021 00:34:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1629160469;
 bh=E0NfnEyiTSyWDge60fnhZNw6CHy7zGw8qtpGLglIxc0=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=Yn/zSxFl5u93MbNSH3rfMndlBIiIsqXQn6RgnRyNVWPvbj7WycdsB4UDE3+zgjJZe
 qG1aMjWShRPQT2+F3K1t2xsksGrVMg0u/MmhoSr6/l3jayu09+HS+Gep5n0dArY5iL
 MeWcuNRcJBd84wG679xJ9fS/UGiJK0m3dlUkdnY83z35LbAnIlLN+fq2cuZ0AjdkVm
 e+FeI8NFAMQSzcEEkcxQRABTMTj9jVqq56LLX03pMoBQHZ7Imbb4cHk7TD/1wbAcCE
 0t9GfGtDTgJY0OmZtuxE6p1rFxWHl3wlhNMicXPMXQvj61lWwDJhx+hCImEgmwIuYN
 2y4DEi21A3RGw==
To: Jaegeuk Kim <jaegeuk@kernel.org>
References: <20210816234247.139528-1-nathan@kernel.org>
 <YRsD6P4x9v38oDWl@google.com>
From: Nathan Chancellor <nathan@kernel.org>
Message-ID: <1f2eff07-f003-03c8-b3c8-0e06f9bf9684@kernel.org>
Date: Mon, 16 Aug 2021 17:34:28 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <YRsD6P4x9v38oDWl@google.com>
Content-Language: en-US
X-Headers-End: 1mFn3s-0006Od-Kw
Subject: Re: [f2fs-dev] [PATCH] f2fs: Add missing inline to
 f2fs_sanity_check_cluster() stub
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
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 8/16/2021 5:33 PM, Jaegeuk Kim wrote:
> Hi Nathan,
> 
> On 08/16, Nathan Chancellor wrote:
>> Without this, there is a warning in nearly every fs/f2fs/ file when
>> F2FS_FS_COMPRESSION is not set:
>>
>> In file included from fs/f2fs/super.c:31:
>> fs/f2fs/f2fs.h:4251:13: warning: unused function 'f2fs_sanity_check_cluster' [-Wunused-function]
>> static bool f2fs_sanity_check_cluster(struct dnode_of_data *dn) { return false; }
>>              ^
>> 1 warning generated.
>>
>> Fixes: 1495870233e7 ("f2fs: compress: do sanity check on cluster")
> 
> This has not been merged yet, so if you don't mind, can I integrate your fix in
> the original patch?

Sure thing!

Cheers,
Nathan


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
