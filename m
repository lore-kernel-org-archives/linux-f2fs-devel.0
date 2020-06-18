Return-Path: <SRS0=lp92=77=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE220C433E1
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 18 Jun 2020 03:28:42 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C436320853;
	Thu, 18 Jun 2020 03:28:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="QulQCCB7";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="lWkhRVhl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C436320853
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1jllEI-0002IE-Fj; Thu, 18 Jun 2020 03:28:42 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <yuchao0@huawei.com>) id 1jllEH-0002I7-DX
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 18 Jun 2020 03:28:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 MIME-Version:Date:Message-ID:From:References:CC:To:Subject:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=vXdj56LrQPWABy1zW2yQAhKac/LJs/4giL07TcdD9rA=; b=QulQCCB79fwPWJCYyBQQdxHPMw
 +ghvaHQEdO32vNttiB+YcSg3wH9JGaNyPU4w4QhVGBAt2sSHneZ9plzQE1aDwSL2ktqwZMT56z5Mb
 nzLdnhDtgsJ2/iT4dCkXjuDmRhDLEAE/TJAsAC7DPV7ZX1vksh+YmaB/8zuBokzpLB3k=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:
 Message-ID:From:References:CC:To:Subject:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=vXdj56LrQPWABy1zW2yQAhKac/LJs/4giL07TcdD9rA=; b=lWkhRVhlDDun4EeOtDD6y59wv1
 iArfQCCPbATwyeh0PIb3YmLxP8sP2i/F419omLy3ciXqt7ubFaGcxQwgjLVVR9UAaCm8gyO57NkT3
 pklH3BKRMuSsDxENx0RlCNUiG8pNob07EKff3Eo4XmwjPhRPANPIhQmuzWdVaRXiKHsI=;
Received: from szxga07-in.huawei.com ([45.249.212.35] helo=huawei.com)
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1jllEE-0076vG-Uj
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 18 Jun 2020 03:28:41 +0000
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id 519763C700A116FC05BF;
 Thu, 18 Jun 2020 11:28:32 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.208) with Microsoft SMTP Server (TLS) id 14.3.487.0; Thu, 18 Jun
 2020 11:28:22 +0800
To: Jaegeuk Kim <jaegeuk@kernel.org>, Eric Biggers <ebiggers@kernel.org>
References: <20200605181533.73113-1-efremov@linux.com>
 <20200609221446.24537-1-efremov@linux.com>
 <20200609222546.GA24766@sol.localdomain> <20200615175800.GA117170@google.com>
From: Chao Yu <yuchao0@huawei.com>
Message-ID: <033a4854-5ebd-4db4-c60f-f0f6826d70ea@huawei.com>
Date: Thu, 18 Jun 2020 11:28:22 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20200615175800.GA117170@google.com>
Content-Language: en-US
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
X-Headers-End: 1jllEE-0076vG-Uj
Subject: Re: [f2fs-dev] [PATCH v3] f2fs: use kfree() instead of kvfree() to
 free superblock data
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
Cc: linux-kernel@vger.kernel.org, Denis Efremov <efremov@linux.com>,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2020/6/16 1:58, Jaegeuk Kim wrote:
> On 06/09, Eric Biggers wrote:
>> On Wed, Jun 10, 2020 at 01:14:46AM +0300, Denis Efremov wrote:
>>> Use kfree() instead of kvfree() to free super in read_raw_super_block()
>>> because the memory is allocated with kzalloc() in the function.
>>> Use kfree() instead of kvfree() to free sbi, raw_super in
>>> f2fs_fill_super() and f2fs_put_super() because the memory is allocated
>>> with kzalloc().
>>>
>>> Fixes: 5222595d093e ("f2fs: use kvmalloc, if kmalloc is failed")
>>> Signed-off-by: Denis Efremov <efremov@linux.com>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,

>>
>> I don't think "Fixes" is appropriate here.
> 
> Agreed. I queued this Cl without it. :)
> Thanks,
> 
>>
>> kvfree() still works on kmalloc'ed memory; it's just not preferred.
>>
>> So this is more a cleanup than a fix.
>>
>> - Eric
> .
> 


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
