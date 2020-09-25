Return-Path: <SRS0=8g9c=DC=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CAC8C4727C
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 25 Sep 2020 23:52:36 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A42432086A;
	Fri, 25 Sep 2020 23:52:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="Mtcnpk7s";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="PSM6ksmR";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nnx7v1D3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A42432086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1kLxVu-0002M0-VH; Fri, 25 Sep 2020 23:52:30 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <chao@kernel.org>) id 1kLxVt-0002Lm-Nq
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 25 Sep 2020 23:52:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 MIME-Version:Date:Message-ID:From:Cc:References:To:Subject:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=DUCdKXDdm4doXRAr1mq0QWOaQ9r+rBnCB37vRjaskcI=; b=Mtcnpk7s1Xs3/BvZjosqTLsmfU
 jQq+YmVeybjUqEsP4NIjyxb6Vxd8q6ThHc3NNih/qjy6uDS6dkGjtSO28KQDaApG/0DaOHQuENeBs
 3L/J+3BTagOwfwOPWzD/Vg6STvev2Fhb8PUgv4lvOGM2aw3D/fLPjETd0FBXMigu0TUI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:
 Message-ID:From:Cc:References:To:Subject:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=DUCdKXDdm4doXRAr1mq0QWOaQ9r+rBnCB37vRjaskcI=; b=PSM6ksmRyOlwA1y68pVnvlcNY1
 vDkUUeKdRrGQ6GmaN2RsgmwBfR/GpOwTQWE1l6pPg2KD+zFmnKzReli15CpytuLP5mM1+4PkQMZZ1
 MyDI30O4TE8EI7szk10VE6vSSAAqK+9UN4b5ctpsFCxxPL95tzfSYueNnFiIXBhw3Fy0=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1kLxVk-0068IM-FU
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 25 Sep 2020 23:52:29 +0000
Received: from [192.168.0.108] (unknown [49.65.245.23])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id A76B72086A;
 Fri, 25 Sep 2020 23:52:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1601077923;
 bh=ZkUZbwYNu+N2k86JlSKaiNxxxqZoYyYDsJpysECYrn0=;
 h=Subject:To:References:Cc:From:Date:In-Reply-To:From;
 b=Nnx7v1D3lKZK+m2XFkFtvG8UjSGoOH0St+Lio+v1j+fRPgkSapE+oNUeuSPcVMti3
 f0PZTfYMz8UUEoyRXVlNj4qf4nQnFU8ffhnUEUetdZ4Voi+DF0Wwpaf3wbR//prTPO
 FEB4R3EtrNX9HwQyf7A/rA7ImU4lxefW49rWBkuY=
To: Jaegeuk Kim <jaegeuk@kernel.org>
References: <20200918030349.19667-1-yuchao0@huawei.com>
 <20200924200305.GA2568648@google.com>
 <dbf3a532-cd38-2b31-e4ab-e83505c6c9c4@huawei.com>
 <7a072554-9d64-b4ac-b85b-de0acd9e507f@huawei.com>
 <20200925170729.GA2843966@google.com>
 <d05174f0-4ca6-c492-8ce3-ac8f146e177c@kernel.org>
 <20200925232332.GA4136545@google.com> <20200925232629.GD4136545@google.com>
From: Chao Yu <chao@kernel.org>
Message-ID: <605ebd33-6923-3828-d223-c1c26b65df01@kernel.org>
Date: Sat, 26 Sep 2020 07:51:58 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <20200925232629.GD4136545@google.com>
X-Headers-End: 1kLxVk-0068IM-FU
Subject: Re: [f2fs-dev] [PATCH] f2fs: compress: fix to disallow enabling
 compress on non-empty file
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2020-9-26 7:26, Jaegeuk Kim wrote:
> On 09/25, Jaegeuk Kim wrote:
>> On 09/26, Chao Yu wrote:
>>> On 2020-9-26 1:07, Jaegeuk Kim wrote:
>>>> On 09/25, Chao Yu wrote:
>>>>> Jaegeuk,
>>>>>
>>>>> I noticed that in dev branch there are several patches which have not been
>>>>> sent to mailing list, could you please send them out?
>>>>
>>>> Chao, which patches?
>>>
>>> Jaegeuk, they are
>>>
>>> 	f2fs: point man pages for some f2fs utils
>>
>> Ah, just sent.
>>
>>> 	f2fs: fix slab leak of rpages pointer
>>
>> I did before?
>
> I missed to add f2fs mailing list. Resent them.

Jaegeuk, thanks, :)

Thanks,

>
>>
>>>
>>> Thanks,
>>>
>>>>
>>>>>
>>>>> Thanks,
>>>>
>>>>
>>>> _______________________________________________
>>>> Linux-f2fs-devel mailing list
>>>> Linux-f2fs-devel@lists.sourceforge.net
>>>> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
>>>>
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
