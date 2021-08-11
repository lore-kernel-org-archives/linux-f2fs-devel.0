Return-Path: <SRS0=Klf2=NC=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46EE6C4338F
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 11 Aug 2021 03:03:36 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 09E9C60462;
	Wed, 11 Aug 2021 03:03:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 09E9C60462
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1mDeWl-000586-6g; Wed, 11 Aug 2021 03:03:35 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <chao@kernel.org>) id 1mDeWj-000580-Qf
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 11 Aug 2021 03:03:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:Reply-To:Cc:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=jhewHCAqvhlQXMt4hK/yZ7N2RPqCk2VlNoZuY9grmAg=; b=eyZk2r8TAsXsHDTI79Egq6ZKut
 WqEF6yMt57QlDDcCAyFjhtx0f/BKkYgbhDAVIIqVDo/mTDrvJkFUjR2eCpU+dVWBBMgRRUwgOr/3L
 FVMG1uLz5Rr3EypTP5ALznRwa5A+yVcA3XLUKBRQcBycY9EeCH5j+9Z7NZk4jqf8uaqc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:
 Message-ID:From:References:To:Subject:Sender:Reply-To:Cc:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=jhewHCAqvhlQXMt4hK/yZ7N2RPqCk2VlNoZuY9grmAg=; b=iDosqcT7Z8u9Pu6r8YrzdXWx6q
 bbcse4lW0fF9nFTmTXSAzbFDHQL9VtwUjbvO15gKRagXuomZZPJ+Z6y8v1aMzwM8zcM6G+PYKrtda
 ufIV+o3b4yY2fhgyvsI+wfUFzjlQpKYmiPFAU16lYftkT6R3cTHf9rwbWUZIKRB0uieU=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.3)
 id 1mDeWe-0001R7-UQ
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 11 Aug 2021 03:03:33 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 88BAB60E78;
 Wed, 11 Aug 2021 03:03:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1628650992;
 bh=ettOy+VFNs6f4ibXirUSZ/2TBEWAHyC8CfuGfsHZ0JE=;
 h=Subject:To:References:From:Date:In-Reply-To:From;
 b=kVIb7Q/+GLt6j+D+RdrReT22ZqppIsA6cr3kUYRR6ze5swSQ4yTitdTEu+yALrzHM
 Jr70+QKMTFvI/ZbOGh30Wam9boPndW0x2L20+l8fb04D7xXz0zMezNKFyafLAGcK/r
 8DTfqNR/DyLVAlGh7KrKhueKuxNkmEwxEbEfOk6aG8Ht3Axdh6McBDQN9MPpCtQKQJ
 8RDrcss6f7cCo0LvjpaNubeJDdsmry1yp/mw2k7qNR1amRLz/V2x2IHNau8sqwXot+
 56f3hPgeQJ/4oyHlKZTobhgqe/HGK5XWwNu7kSm0YsBxEHxJJ5NP7Hy5HMKmhMDRPF
 SyuaHIMk6LmmQ==
To: Wu Bo <bo.wu@vivo.com>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
References: <5b68208b-fd94-bf4e-fc4b-d79d13abf1c6@vivo.com>
From: Chao Yu <chao@kernel.org>
Message-ID: <6519b8b7-1eb0-f286-7593-5c5ebbfb5554@kernel.org>
Date: Wed, 11 Aug 2021 11:03:11 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <5b68208b-fd94-bf4e-fc4b-d79d13abf1c6@vivo.com>
Content-Language: en-US
X-Headers-End: 1mDeWe-0001R7-UQ
Subject: Re: [f2fs-dev] f2fs do DIO write make file corruption
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2021/8/11 10:48, Wu Bo wrote:
> I use the following command to create a file, the file may got corruption:
> 	f2fs_io write 2 0 512 inc_num dio $path
> 
> And when I use bio or to set the chunk size to 1 block, the file is
> normal. The commands as following:
> 	f2fs_io write 2 0 512 inc_num buffered $path
> 	f2fs_io write 1 0 512 inc_num dio $path
> 
> I find this bug on old kernel version 4.14.117, and not find on version
> 4.19.152. So this bug is fixed. Can anyone can tell me which patch fixed
> this bug?

Not sure,

https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?h=linux-4.19.y&id=7bae8b6b73e46c307fa355ce086800b7ad6610f8

Thanks,

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
