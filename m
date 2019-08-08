Return-Path: <SRS0=IlpB=WE=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B8DCC0650F
	for <linux-f2fs-devel@archiver.kernel.org>; Thu,  8 Aug 2019 06:47:00 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 45FAA21874
	for <linux-f2fs-devel@archiver.kernel.org>; Thu,  8 Aug 2019 06:47:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="DAb/1QhU";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="d+lh7kv9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45FAA21874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1hvcCR-0004Rd-QO; Thu, 08 Aug 2019 06:46:59 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <yuehaibing@huawei.com>) id 1hvcCQ-0004RL-06
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 08 Aug 2019 06:46:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 MIME-Version:Date:Message-ID:From:CC:References:To:Subject:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=9K0GzhYu6DNhhS26DoGB/39x4vItey3iPFCSFXoQnIc=; b=DAb/1QhUgbJupgMqrRh0VTdfoZ
 ZBey3PzHzHJDGXMWYGIgID+jtYh6a+529wZgjyynfGPC/L4R7rZ7tLcCd+OmB9iqzsY6cZ9sjmvQs
 6BJqGHKNUm2Ohrr6KMk7INjBTjcui6Y0l2qNDxTSpJFFM+aFLKArXc9ds4hmox79G4R4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:
 Message-ID:From:CC:References:To:Subject:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=9K0GzhYu6DNhhS26DoGB/39x4vItey3iPFCSFXoQnIc=; b=d+lh7kv9o9YC+cVoF2sfHydy2S
 zN+JHPSzayJL2O/f+olhOq1hVpTuxYDhLdyYdJPsDDKaA85uSfoR0F6Rd0iMy/snazxq79uaj0nL6
 /Xn5wDZ4Cf5iSGvAcAHofNcLNjcAhr5AlwaZUJC4EE+KEMYCalb6JwjOtt9brgBq5lkE=;
Received: from szxga04-in.huawei.com ([45.249.212.190] helo=huawei.com)
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1hvcCN-00EliL-RZ
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 08 Aug 2019 06:46:57 +0000
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id F10AA387A0EDCAB66BF8;
 Thu,  8 Aug 2019 14:46:48 +0800 (CST)
Received: from [127.0.0.1] (10.133.213.239) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.439.0;
 Thu, 8 Aug 2019 14:46:42 +0800
To: Chao Yu <yuchao0@huawei.com>, <jaegeuk@kernel.org>, <chao@kernel.org>
References: <20190808020253.27276-1-yuehaibing@huawei.com>
 <4e1c457e-621f-e9bd-e625-3a9f27da2277@huawei.com>
From: Yuehaibing <yuehaibing@huawei.com>
Message-ID: <c93cdedd-2144-79d9-92ac-a3e02f58a5ef@huawei.com>
Date: Thu, 8 Aug 2019 14:46:40 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <4e1c457e-621f-e9bd-e625-3a9f27da2277@huawei.com>
X-Originating-IP: [10.133.213.239]
X-CFilter-Loop: Reflected
X-Headers-End: 1hvcCN-00EliL-RZ
Subject: Re: [f2fs-dev] [PATCH] f2fs: Fix build error while CONFIG_NLS=m
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2019/8/8 14:18, Chao Yu wrote:
> Hi Haibing,
> 
> Thanks for the patch!
> 
> Out of curiosity, does Hulk Robot check linux-next git repo as well? This will
> be more valuable if the bug can be found during development of related patch?

Yes, Hulk Robot now do this on linux-next.git and linux.git every day.

> 
> On 2019/8/8 10:02, YueHaibing wrote:
>> If CONFIG_F2FS_FS=y but CONFIG_NLS=m, building fails:
>>
>> fs/f2fs/file.o: In function `f2fs_ioctl':
>> file.c:(.text+0xb86f): undefined reference to `utf16s_to_utf8s'
>> file.c:(.text+0xe651): undefined reference to `utf8s_to_utf16s'
>>
>> Select CONFIG_NLS to fix this.
>>
>> Reported-by: Hulk Robot <hulkci@huawei.com>
>> Fixes: 61a3da4d5ef8 ("f2fs: support FS_IOC_{GET,SET}FSLABEL")
>> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> 
> Reviewed-by: Chao Yu <yuchao0@huawei.com>
> 
> Thanks,
> 
> .
> 



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
