Return-Path: <SRS0=HDuJ=WT=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94BC4C3A5A2
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 23 Aug 2019 15:52:43 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 67A03206E0;
	Fri, 23 Aug 2019 15:52:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="J2w+8AOO";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="cEsEGb3P";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nj4hwL4f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67A03206E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1i1Brn-0002km-0q; Fri, 23 Aug 2019 15:52:43 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <chao@kernel.org>) id 1i1Brm-0002kd-EI
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 23 Aug 2019 15:52:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=5WFd420yCAPO88p7DNa8pWwUKjrpg/gUlno0NUhBvPI=; b=J2w+8AOOZLExbyzDmNTXNcr8xo
 L3FygmNHyWla2vP6P3jbDPDGbnx9dgGuqAjfsgIcMFlMRa1q0f+VOdvmRCboKnTxfl9xUg5EEos+1
 h4xEIsWxS/hzF87mtwcGEKEqTNwmgfdAHur62OilZgNuUhsT+eCYwx2nmRGLCgXzVveg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:
 Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=5WFd420yCAPO88p7DNa8pWwUKjrpg/gUlno0NUhBvPI=; b=cEsEGb3P126P52Q6gchDmbGkNS
 f05J303Xscu8PqGiepU4G107xwPfe1LcmSpNDb/jphg9Saib2wCvSBy8WKsc/jKN6oG3e45PMB+0G
 lABbfsXiQwUiBZWB0h4PIJt/hOg2haSphxeigPre18iRfrrBmDF1+a70WtD4K/Bp1Boo=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1i1Bri-00D92S-0o
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 23 Aug 2019 15:52:42 +0000
Received: from [192.168.0.101] (unknown [180.111.132.43])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id B7A8D206E0;
 Fri, 23 Aug 2019 15:52:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1566575552;
 bh=xtrLAb4rp0fqVNdBsEWV9UAxWINEkYWQqhiWlAsox24=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=Nj4hwL4fCNh7J7pB6uw+XHvx2FKJOljjVzQu6fccq2sluOoTrZMN9JcGq/EHJlUjG
 yc2xVotI26qN4jULkIBCmodxIVrzEevm+BmxcozO98vrIqEKM/X8tKN+nWM+Z81a9N
 3/sLgN0d+0u2rf7/PFBFN7tA5lwWRM/EkQBjLpCI=
To: Ju Hyung Park <qkrwngud825@gmail.com>, Chao Yu <yuchao0@huawei.com>
References: <CAD14+f1YGinNQuVKc371vgJGJaaqYWqcaP6WwSuP1mwf-D2Tzw@mail.gmail.com>
 <5696f35e-d91a-801a-d2bb-fbbc188bbf4c@huawei.com>
 <CAD14+f3a1Uifebv8cybJOW8FrCnsvbrCCbT+JupxRVu3kpji9w@mail.gmail.com>
From: Chao Yu <chao@kernel.org>
Message-ID: <baa8b0ce-99b4-4f74-ff7d-e204bced4168@kernel.org>
Date: Fri, 23 Aug 2019 23:52:20 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAD14+f3a1Uifebv8cybJOW8FrCnsvbrCCbT+JupxRVu3kpji9w@mail.gmail.com>
Content-Language: en-US
X-Headers-End: 1i1Bri-00D92S-0o
Subject: Re: [f2fs-dev] f2fs: dirty memory increasing during gc_urgent
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
Cc: linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hi Ju Hyung,

Sorry for the delay.

On 2019-8-16 23:37, Ju Hyung Park wrote:
> Hi Chao,
> 
> On Thu, Aug 15, 2019 at 3:49 PM Chao Yu <yuchao0@huawei.com> wrote:
>> I doubt that before triggering urgent GC, system has dirty datas in memory, then
>> when you trigger `sync`, GCed data and dirty data were flushed to devices
>> together, if we write dirty data with out-place-update model, it may make fragment.
>>
>> So we can try
>> - sync
>> - trigger urgent GC
>> - sync
>> - cat /sys/kernel/debug/f2fs/status to check 'Dirty' field, the value should
>> close to zero
> 
> It's actually not zero.
> 
> Before triggering gc_urgent: 601
> After gc_urgent ends and doing a `sync`: 400
> 
> And after another 2nd gc_urgent run, it finally becomes 0.
> 
> So I'm guessing this wasn't intentional? :P

It's not intentional, I failed to reproduce this issue, could you add some logs
to track why we stop urgent GC even there are still dirty segments?

Thanks,

> 
> Thanks,
> 
> 
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
> 


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
