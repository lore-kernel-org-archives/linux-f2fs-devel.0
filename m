Return-Path: <SRS0=2ghP=WO=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E039FC3A589
	for <linux-f2fs-devel@archiver.kernel.org>; Sun, 18 Aug 2019 13:03:35 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A56CF20851;
	Sun, 18 Aug 2019 13:03:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="YufjpWfz";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="hIUtHiuM";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="OhaOkCUH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A56CF20851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1hzKqN-0008BX-A3; Sun, 18 Aug 2019 13:03:35 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <chao@kernel.org>) id 1hzKqK-0008BP-9Z
 for linux-f2fs-devel@lists.sourceforge.net; Sun, 18 Aug 2019 13:03:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:Reply-To:Cc:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=1gt7jWz1Zy3QZFogDfNqnQO7uqjKgamL+yR/fUDyqJk=; b=YufjpWfz457eA7jjMeXbH1zPrm
 sg/rtQSUi/KlqbZ/uufmTxT84eZjHPyYkvvCRu1ltTfhe8Q5LjqgUCPnTwWkVamQG13PbHuMbiJan
 ihi0gNx1yWD1XPTDE5r/HCYRoqDD13klBYMiG7WQiVf7vJe+EukHEZOTZQchdKMf2pY0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:
 Message-ID:From:References:To:Subject:Sender:Reply-To:Cc:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=1gt7jWz1Zy3QZFogDfNqnQO7uqjKgamL+yR/fUDyqJk=; b=hIUtHiuMFQGYcIPHmoZMvVZewy
 gb4me08EDd6fpXbnwdjhbCZ3+ws0l341yzHK56KwmTVN9Wwl+vC/VsaWarjdYPXHQLhXtjotQ2mLT
 XeklI1NKZERdotPNDiKEXnhzYnuY8djx03WiwisHsAFfbbrjJF48CXl6mm1kX+9Xf34U=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1hzKqI-007lEz-8y
 for linux-f2fs-devel@lists.sourceforge.net; Sun, 18 Aug 2019 13:03:32 +0000
Received: from [192.168.0.101] (unknown [180.111.132.43])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id E606F20851;
 Sun, 18 Aug 2019 13:03:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1566133404;
 bh=/ebKQnDQUtPwjiEMO40TfGfpRt13W8GMpTIUZhwssow=;
 h=Subject:To:References:From:Date:In-Reply-To:From;
 b=OhaOkCUHR0tOgvFTr+m9P0MudYQVRGxsjI8PL6EXBEic2tiSt+I5hDBCl+WsEAhiU
 sqmMY9KDBf/zHFCpywz7A835ZNcNyvkpGIFkewBQGrE0ib0X4M/meh77qrCjO7pEtF
 FL9FS3U3LMJh5IjaU2DwH6NXYoSL3my07V0PMJ2E=
To: Chao Yu <yuchao0@huawei.com>, Eric Biggers <ebiggers@kernel.org>,
 linux-f2fs-devel@lists.sourceforge.net
References: <20190816055539.30420-1-ebiggers@kernel.org>
 <faefae52-3c06-46b1-8be9-3774a98a212b@huawei.com>
From: Chao Yu <chao@kernel.org>
Message-ID: <26511603-db36-f614-3066-0fcd3f5af483@kernel.org>
Date: Sun, 18 Aug 2019 21:03:21 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <faefae52-3c06-46b1-8be9-3774a98a212b@huawei.com>
Content-Language: en-US
X-Headers-End: 1hzKqI-007lEz-8y
Subject: Re: [f2fs-dev] [PATCH 0/3] f2fs: fixes for FS_IOC_{GET,SET}FSLABEL
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hi Eric,

Do you mind folding these fixes into original patch as it's still in dev branch?

BTW, any comment or suggestion is welcome in my original patch.... :)

Thanks,

On 2019-8-16 14:49, Chao Yu wrote:
> Eric, thanks for all the fixes.
> 
> Thanks,
> 
> On 2019/8/16 13:55, Eric Biggers wrote:
>> Fix some bugs in the f2fs implementation of the FS_IOC_GETFSLABEL and
>> FS_IOC_SETFSLABEL ioctls.
>>
>> Eric Biggers (3):
>>   f2fs: fix buffer overruns in FS_IOC_{GET,SET}FSLABEL
>>   f2fs: fix copying too many bytes in FS_IOC_SETFSLABEL
>>   f2fs: add missing authorization check in FS_IOC_SETFSLABEL
>>
>>  fs/f2fs/file.c | 27 +++++++++------------------
>>  1 file changed, 9 insertions(+), 18 deletions(-)
>>
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
