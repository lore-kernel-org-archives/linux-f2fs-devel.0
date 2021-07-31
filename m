Return-Path: <SRS0=A69Z=MX=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8810C4338F
	for <linux-f2fs-devel@archiver.kernel.org>; Sat, 31 Jul 2021 00:48:43 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 889ED61019;
	Sat, 31 Jul 2021 00:48:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 889ED61019
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1m9dBC-0006EK-Tj; Sat, 31 Jul 2021 00:48:42 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <chao@kernel.org>) id 1m9dAx-0006Cq-PI
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 31 Jul 2021 00:48:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=P9LJFT6sJH4lGIklAdMq1IGHW8ZkA2isPzEWn4l/mHQ=; b=VUHl3rs5WuZ6+2BrEDi5tCC8Zz
 XirbtqXCzRitr/B3wfAWBD/b174es9Uuu4ANv/6aHhBgDHcN6Dlks1hhLCzv9spZuMR19+ApuO4Fh
 GuiVbE8o4JkByyan++8FvUhTrp2vxpyev588lVZlTeoks5ZDq3Pc4GrGqCc36Y1AM+pc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:
 Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=P9LJFT6sJH4lGIklAdMq1IGHW8ZkA2isPzEWn4l/mHQ=; b=i3k7eedkk6lorSZKi+CEk8VB0T
 28FOQ87ZUR/LyZBWVESgGKF/xbzCqT4plMegPhCuzq7GaEtWAX01Ez3YNxGa570ClsdgKGMW3CJHt
 2p9Qt3IY1Y7Mr9EJr+2p+02LYyKCHX7BwViWU6JxzNSuiPgfmdtrrZ9/N3JBG+L8aPso=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.3)
 id 1m9dAw-008Dni-EM
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 31 Jul 2021 00:48:27 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8589160FED;
 Sat, 31 Jul 2021 00:48:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1627692498;
 bh=UwDj/y8hR/ti9YDi57SbxdxNismgSQMBBvAIDtT+11U=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=bn4prbbocPP1EKdS4jyVAlSadb9WvZxtpgf7NfvCEwkdu0ZAahLuhsSMHg8Nq03WK
 A3r4GCSJwOj7Znl0UZ7d4b+EDd689KuksRAQeGgueKXTfXgkiNbn9xrosh+AkBh02M
 pdasRX//D7zxUIDskxoklFg6aCnD7oV1ro5RQpZs0i/ErIWq7nNv5/kTeMM1Sa6+x6
 FjdVqZBpyPlVsQyOLfnaKBWiOMrs1yVuna7Fs4zwxgo86GUnR488bdlzpxJyveh/PJ
 bucXoH9uiCqW9TOafeXSvdapBJBBcbI98mozKc29rc4UxnEYNykkqS+6IFskqe832p
 g08dm9Reeg6RQ==
To: Jaegeuk Kim <jaegeuk@kernel.org>
References: <20210730100530.4401-1-chao@kernel.org>
 <YQREtmDLBNKSQViC@google.com>
 <c0af2126-7383-a579-e020-6480216c46fe@kernel.org>
 <1a540deb-4219-4000-2f8d-a72695f1dfde@kernel.org>
 <YQSckPQWe9b0JfNu@google.com>
From: Chao Yu <chao@kernel.org>
Message-ID: <fe768d28-db69-707a-0f95-4f1bf9f48b1e@kernel.org>
Date: Sat, 31 Jul 2021 08:48:16 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <YQSckPQWe9b0JfNu@google.com>
Content-Language: en-US
X-Headers-End: 1m9dAw-008Dni-EM
Subject: Re: [f2fs-dev] [PATCH] f2fs: introduce nosmall_discard mount option
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
 Chao Yu <chao.yu@linux.dev>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2021/7/31 8:42, Jaegeuk Kim wrote:
> On 07/31, Chao Yu wrote:
>> On 2021/7/31 7:41, Chao Yu wrote:
>>> On 2021/7/31 2:28, Jaegeuk Kim wrote:
>>>> how about adding "discard_gran=[small|segment|section]", and keeping discard_map
>>>> in the small case only? And, I think we should set the section mode for zoned
>>>> device automatically.
>>>
>>> Yup, better,
>>>
>>> About the naming, it look discard_gran is not clear here, since there is another
>>> sysfs entry /sys/fs/f2fs/<devname>/discard_granularity has the same name, and
>>> also semantics of newly added mount option is not only control the smallest discard
>>> size, but also indicate discard start offset should be aligned to segment or section.
>>> So how about using: "aligned_discard=[none|segment|section]" instead?
>>
>> Maybe: "aligned_discard=[block|segment|section]"?
> 
> How about discard_unit? I feel that issuing discards in one of those unit
> indicate the offset.

Looks fine to me, let me update the patch.

Thanks,

> 
>>
>>>
>>> Thanks,
>>>
>>>
>>> _______________________________________________
>>> Linux-f2fs-devel mailing list
>>> Linux-f2fs-devel@lists.sourceforge.net
>>> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
>>>


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
