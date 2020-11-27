Return-Path: <SRS0=C6vc=FB=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 283F0C63798
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 27 Nov 2020 01:02:09 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9FF55221F8;
	Fri, 27 Nov 2020 01:02:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="CoZOyGF2";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="Uigoqnjv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FF55221F8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1kiS9H-0003Pe-Gc; Fri, 27 Nov 2020 01:02:07 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <yuchao0@huawei.com>) id 1kiS9F-0003P7-Lm
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 27 Nov 2020 01:02:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 MIME-Version:Date:Message-ID:From:References:CC:To:Subject:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=UhIbSCrw71sZIsX9xR/wrxHp9Dddt7EJ1dafOUjEWWg=; b=CoZOyGF2eIfhf8wpPlvHHY/yU2
 Fr3LoQfgX6KHpQ7DsxmugFFW3zrU5WPKoZoNwy8BKxaulY3Wa22dvs1/VoAkqIDsbRB1+bA1w8zdT
 rAAwUURYHv94FGD3EIDt2QlJCukRTrhpZU2pAxqqSzgA3Wc6EdNIVEJECqcdpHjmXkHg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:
 Message-ID:From:References:CC:To:Subject:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=UhIbSCrw71sZIsX9xR/wrxHp9Dddt7EJ1dafOUjEWWg=; b=Uigoqnjvx7oLfgeNlYGeKAdvTt
 Uqpx+gLRko8YlkddUuD8LFATOKd739Dh+YJycETgmRiL82m9aVBIz+SsuOxOqm0oXLs+ZtiTje6E2
 m2DLBycwWDle9yx0QYpIMeSStiEu2VOf5sHMTmC3VnxXHdAuN9dxur6TfL4KvCPmYfE4=;
Received: from szxga04-in.huawei.com ([45.249.212.190])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1kiS9A-000BEU-1F
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 27 Nov 2020 01:02:05 +0000
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.60])
 by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4ChxCX3pvJz15SNK;
 Fri, 27 Nov 2020 09:01:28 +0800 (CST)
Received: from [10.136.114.67] (10.136.114.67) by smtp.huawei.com
 (10.3.19.211) with Microsoft SMTP Server (TLS) id 14.3.487.0; Fri, 27 Nov
 2020 09:01:47 +0800
To: Eric Biggers <ebiggers@kernel.org>
References: <20201126103709.80006-1-yuchao0@huawei.com>
 <X7/sCLnVPOjkC9DI@sol.localdomain>
From: Chao Yu <yuchao0@huawei.com>
Message-ID: <7ecb947e-2f8c-abd7-c116-c82c474fded7@huawei.com>
Date: Fri, 27 Nov 2020 09:01:47 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <X7/sCLnVPOjkC9DI@sol.localdomain>
Content-Language: en-US
X-Originating-IP: [10.136.114.67]
X-CFilter-Loop: Reflected
X-Headers-End: 1kiS9A-000BEU-1F
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: compress: add compress_inode to
 cache compressed blocks
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
Cc: jaegeuk@kernel.org, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2020/11/27 1:55, Eric Biggers wrote:
> On Thu, Nov 26, 2020 at 06:37:09PM +0800, Chao Yu wrote:
>> Support to use address space of inner inode to cache compressed block,
>> in order to improve cache hit ratio of random read.
>>
>> Signed-off-by: Chao Yu <yuchao0@huawei.com>
> 
> If the file is also encrypted, are the compressed pages that are cached still
> encrypted, or are they decrypted?

In current implementation, they are decrypted in cache.

Thanks,

> 
> - Eric
> .
> 


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
