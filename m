Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 083E0CD8CB2
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 10 Jun 2026 12:09:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vBwtC+jvVxY2Pe47xmkrDd537h7J+KhMdp0hXtdkXuo=; b=i8U6gI3XgAPbZnfoOBnlR6+ZgL
	KP+s2D32QZd5rKYZnv4G4Rt/Qui3UsE0Oi15JrhMiglQBP9CahfN6rn5hZxafb/0OTRiUfvRQrKe3
	hr6OR5fAAv08WjggbQkjc5pQ3SY2DQohW2Awbm63DTRd5i3TjYAvCMlU/LKl443UoONk=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wXHkG-0005HZ-AQ;
	Wed, 10 Jun 2026 12:09:21 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1wXHkF-0005HP-Du
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 10 Jun 2026 12:09:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=bAZPdDg/rpOnaAuujF2rrlfIZrvDxsbfPGxXlX68OM0=; b=WRK0r2+G3avGmr3fMSMQCzRNCG
 Nz3MtCh1DNaDaJ70M/k3mwauPEtStGelE9jimzUm7ATkZEg++KPD/8I5Yg2XImeX2NxZksRagVBeg
 vHB8UyE6QAH4/SwPsSuIsJOmom9naMuG18o6LU8XwjwHzd0GLIAF2lmUub/wJvwHAnuQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=bAZPdDg/rpOnaAuujF2rrlfIZrvDxsbfPGxXlX68OM0=; b=bhUNS0zy1DLxxrgxBe6Pu0+/XL
 hvr/zZUobaMV92cwH/7uJ8xmDZp+uEa/RMv0YENK3+axj4QsWmUcJ/LH9ISMWtzs1Gj1/pC4Qi8QN
 YLKivc1cX43URPiWAOLn9u1UUkxVlz6El4paZOSSUCHqwNyrs+WZLdY7VjDCyRi4/ga4=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wXHkE-0004Bf-1h for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 10 Jun 2026 12:09:20 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 070CA40AD7;
 Wed, 10 Jun 2026 12:09:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C764B1F00893;
 Wed, 10 Jun 2026 12:09:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781093347;
 bh=bAZPdDg/rpOnaAuujF2rrlfIZrvDxsbfPGxXlX68OM0=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To;
 b=C8S3G2tR0/QKC/VVUhTnPVuNVzW2gaYOFx5c7DDTl1YphUU99XT+AZz8r4VDtUTs5
 4gNiUk10e4p7naY/iGmOHNUa81orWAfO7e6H6MIY1zZ+OgBj2vPhkni+VJtZFEsOwh
 Qx1J4tTfzOv8scZmgl2AYR8Apz6oT4jA9+VInG73SMslsvzlt892dvQ6S7x54+13JA
 7Gsa4SsS3Nzlhp+9A22CmjY6I561lu//S1vIzdXAKke55GTTl94sKLEYzqz9GAhcjP
 pfP2mVQh+FjVzswWK3Af/rYOXHRImOKRWQid/jhMIJBqq/HaqIFrdGQ1P4u+1lUGTe
 XcRltr3mK2kHw==
Message-ID: <db2ee7b6-acbb-4a2c-acc0-2d76ea510dc2@kernel.org>
Date: Wed, 10 Jun 2026 20:09:04 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: zhaoyuenan <amktiao030215@gmail.com>
References: <20260521151008.13682-1-amktiao030215@gmail.com>
 <20260522135654.19535-1-amktiao030215@gmail.com>
Content-Language: en-US
In-Reply-To: <20260522135654.19535-1-amktiao030215@gmail.com>
X-Headers-End: 1wXHkE-0004Bf-1h
Subject: Re: [f2fs-dev] [PATCH] f2fs: Add ckpt_thread_task sysfs node
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
From: Chao Yu via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Chao Yu <chao@kernel.org>
Cc: jaegeuk@kernel.org, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hi Yuenan,

On 5/22/26 21:56, zhaoyuenan wrote:
> Hi Chao,
> 
> On 5/22/26 10:50, Chao Yu wrote:
>> Hi Yuenan,
>>
>> Thanks for your contribution!
>>
>> If there is a method to get pid via userspace, I prefer to do it in userspace,
>> rather than implementing and maintaining an duplicated one in kernel.
>>
>> Or do you have a strong reason to do this in kernel?
> 
> The main reason is that retrieving this PID from userspace is currently
> quite complex and fragile.
> 
> Previously, userspace tools had to rely on pipelines like:
> pgrep f2fs_ckpt-$(ls -l /dev/block/by-name/userdata | awk '{print $5$6}' | tr ',' ':')
> 
> This approach has a few drawbacks:
> 1. It requires parsing major/minor numbers and executing multiple commands,
>    which is inefficient for simple monitoring tools.

I don't see why there is any performance concern in your scenario.

> 2. On some older kernels, the thread name can be truncated due to TASK_COMM_LEN
>    limitations, causing 'pgrep' to fail to match the full 'f2fs_ckpt-X:Y' string.

I don't think this method has scalability, is it better to backport below patch? so
that you can trace all kthreads and set them to target cgroup.

https://lore.kernel.org/all/20211120112850.46047-1-laoar.shao@gmail.com

Thanks,

> 
> Exposing the PID via a sysfs node provides a deterministic, lightweight,
> and reliable way (just a simple 'cat') to fetch it without any userspace
> guessing or complex parsing.
> 
> Does this address your concern?
> 
> Thanks,
> Yuenan



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
