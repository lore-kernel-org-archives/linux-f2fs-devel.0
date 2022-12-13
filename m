Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF1D1C4332F
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 13 Dec 2022 01:32:23 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1p4u9d-0001iX-NI;
	Tue, 13 Dec 2022 01:32:21 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1p4u9c-0001iR-3v
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 13 Dec 2022 01:32:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=yiZPTjJ/ApG8gzVLHQPpR7k+RXsYQZHh2ZWcF6Z3mi0=; b=ldy5QaYLB3wE2FDuJuPZ716N98
 BHxWzG2Yyt8lT9597EUQsXAvomnxZEM/YX/ZUdZx1zDoZfbonoS9yXnrS69ZNwfRnW4EGEYQaOcPM
 I74p1tpKzq/xaG/hDW6k18id7CkmdT5wEPZlQz7RpTOSq/21iecAaew741pss8EwXVdI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=yiZPTjJ/ApG8gzVLHQPpR7k+RXsYQZHh2ZWcF6Z3mi0=; b=AX2Gv6bHLY9rAXUy4ZogLIetBX
 arMMCP9K/egQAAtjhghZ19RtCxbDiICtXquMaorMwU4oDLnSsftNF94ZXYlqVi/avza/1MQHl7fVL
 4orf82sVrsh36rHjn6ecB1gcqCtyzc7nMFY2VdxlDI9E1SreRZcCmESGsyUMOBZXVJog=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1p4u9b-00FHoN-DM for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 13 Dec 2022 01:32:20 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 2D4416125F;
 Tue, 13 Dec 2022 01:32:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D4DAC433D2;
 Tue, 13 Dec 2022 01:32:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1670895132;
 bh=MMyYxqYgaY4WHnCH6AnxCg4u89mm8aCLLlqYAObFnT4=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=K/wLpSPzCfj2KpgjChoH0dlTLJuOIMuasL4ga6Echu0E8Yr/fdd4CCpTroHZ4+9c/
 mRPUGsfJjiRq71mqlfJ+PRPCYsN63iMr7Vpih+D8deWcAW3AlFRzxV+2zMpxltYu/T
 ihdhFep5s+VyEzE7e0KU+whBF+g6j9wTZGLkhfO24wNQ/RzuS9ge1Piqt6Vb78dwxY
 orhrRS7czNvxWMijq/YRkoPbPtZggZMhEh1hdUVFeqSuZPtjpBzyWChM6ZvuYaP3qw
 XGPso372iE+yHQzGNwh8iSTQhqFHBq6hQA8SMqt+rWFnFQs6ZR18E66KBAWoF7Ss9b
 0V+DkFkig2RaA==
Message-ID: <a364cb12-3241-50a7-fdd5-323825d0a911@kernel.org>
Date: Tue, 13 Dec 2022 09:32:09 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Content-Language: en-US
To: Jaegeuk Kim <jaegeuk@kernel.org>
References: <974f5013-b6af-a39e-0b0f-2ce86253eaeb@kernel.org>
 <20221212141429.6329-1-frank.li@vivo.com>
 <2f100a4a-592d-f098-b204-efeef58341ee@kernel.org>
 <Y5evHVvzGC/8lMfK@google.com>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <Y5evHVvzGC/8lMfK@google.com>
X-Headers-End: 1p4u9b-00FHoN-DM
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: don't call
 f2fs_issue_discard_timeout() when discard_cmd_cnt is 0 in f2fs_put_super()
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
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
 Yangtao Li <frank.li@vivo.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2022/12/13 6:45, Jaegeuk Kim wrote:
> On 12/12, Chao Yu wrote:
>> On 2022/12/12 22:14, Yangtao Li wrote:
>>> Hi Chao,
>>>
>>>> The difference here is, if we use f2fs_realtime_discard_enable() in
>>>> f2fs_put_super(), we will only write checkpoint w/ CP_TRIMMED flag
>>>> when discard option is enable and device supports discard.
>>>
>>>> But actually, if discard option is disabled, we still needs to give
>>>> put_super() a chance to write checkpoint w/ CP_TRIMMED flag.
>>>
>>> Why do we still have to set the CP_TRIMMED flag when the discard opt is not set.
>>> Did I miss something?
>>
>> Hi Yangtao,
>>
>> I guess it's up to scenario. e.g.
>>
>> mount w/ nodiscard and use FITRIM to trigger in-batch discard,
>> if we set CP_TRIMMED flag during umount, next time, after mount
>> w/ discard, it doesn't to issue redundant discard.
> 
> If fitrim was called with a range, we can get a wrong FI_TRIMMED flag. Isn't it

We can set CP_TRIMMED flag only if fitrim was called on full range w/ 4k granularity,
due to it will check sbi->discard_blks variable to make sure there is no range we
haven't trimmed.

> better to get a full discard range after remount even though some are redundant?

If nodiscard is set, and sbi->discard_blks becomes zero, it says a full range fitrim
was been triggered.

So, previous check condition has no problem, right?

	if ((f2fs_hw_support_discard(sbi) || f2fs_hw_should_discard(sbi)) &&
					!sbi->discard_blks && !dropped) {

Thanks,

> 
>>
>> Thanks,
>>
>>>
>>> Thx,
>>> Yangtao


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
