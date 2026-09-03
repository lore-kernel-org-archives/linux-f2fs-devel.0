Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 013E8C61DD3
	for <linux-f2fs-devel@archiver.kernel.org>; Thu,  3 Sep 2026 23:08:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Content-Transfer-Encoding:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Bt9RWoEfv2B6Eiem5Ft/J/pHcypeF4DjGWgqlP3hrjg=; b=FP4V1mXZZhowD/tMCVRIUE/KuO
	a+4KlparE8mwFQyX52xOfPTgJ8hrS5GWHOM5g3u9kaLsdF7p5W+yLXm3MI4k6sq35+jSEVUkA5Xps
	M7JFyrnm+WSNfB+09CEMl5pqhZ0JRHbQdk7Fh7c55iQFonDIvczzoN/13Zo1v22XPajA=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1x2GYA-0002RB-NP;
	Thu, 03 Sep 2026 23:08:54 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1x2GY9-0002R4-Kz
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 03 Sep 2026 23:08:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=hHj79ivnCIVQ9oSllj2cnlRWSVM8NqFq3uES2gy708g=; b=LI9oajKHsHC0J21z8JuR5QMjPh
 7i2PEPjpot24DThRxCyfVXIAX2GGCNtWyZEN64rG9A2xsNqlbn7+vSIgVbexliFrCFQupK4DnsuPs
 mn/7GgKdop1FGDVPhI3fobjmWrAJUY9UGeYbsiFKbbksxeZznTTYejYIPRDegMY+cWc4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=hHj79ivnCIVQ9oSllj2cnlRWSVM8NqFq3uES2gy708g=; b=SLRFLSPROC+c2dtdvcxe95gyrE
 Z4veEjBNaR07yYnwXpYHB9zWMyfYCJ/aIx+I5Znq0pxJxFrx4qFcB9ni8NmgfbH2Yy5+3lqDKXo1p
 R0JUrLzaRmkRLoXvV4Ysng1bsch3u/hUEilqWYBY2SewXr0+JhOp4feS2TmeHMGKNg7I=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1x2GY7-0001SO-Uv for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 03 Sep 2026 23:08:53 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 1AE4660234;
 Thu,  3 Sep 2026 23:08:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E1631F000E9;
 Thu,  3 Sep 2026 23:08:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788476925;
 bh=hHj79ivnCIVQ9oSllj2cnlRWSVM8NqFq3uES2gy708g=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To;
 b=MGp5qUENaJhoALBIifj9MxMBnpcVab85xm/plvjj3SBjz5XgEeG0DCEqwe68cAhTS
 Udfv3C17JKhGtkpIN09P+mqW3DSi8B1xdzsGoQpir/j3E+33Qsc0brhii8U3YWy661
 y/1LO8syJYXy1c0UsiHlTuLVa+gQdOlkodGyrbGNbbqmvlsFY8sNrhSEtFQxZkCUKo
 g5SkZFC7b8Xrh2/72cbvhQUlG/1Po41bUVpJl+FTJ6r21c0P32Xs/MZo2jeoyzt1IA
 6mt/aPoofbJ6cmMpgRR8Ynz7Sv+Vo+WT3RoT+JvsfYb7j9YeMBhr8ASsammssxEpo+
 hz1hGSxTa8H7w==
Message-ID: <12ea8eda-403b-4932-90ba-beadb1354533@kernel.org>
Date: Fri, 4 Sep 2026 07:08:42 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Daeho Jeong <daeho43@gmail.com>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
References: <20260903161031.1280195-1-daeho43@gmail.com>
Content-Language: en-US
In-Reply-To: <20260903161031.1280195-1-daeho43@gmail.com>
X-Headers-End: 1x2GY7-0001SO-Uv
Subject: Re: [f2fs-dev] [PATCH v4] f2fs: drop pending discard commands
 before reserving device alias
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
Cc: Daeho Jeong <daehojeong@google.com>, stable@vger.kernel.org,
 Wenjie Qi <qiwenjie@xiaomi.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 9/4/2026 12:10 AM, Daeho Jeong wrote:
> From: Daeho Jeong <daehojeong@google.com>
> 
> When reserving a device alias via f2fs_ioc_reserve_dev_alias(),
> f2fs_reserve_device_alias() bulk-marks all blocks in the target device
> range as valid in SIT.
> 
> However, if the device was previously in the released state, stale
> pending discard commands covering that range may still exist in dcc->root.
> When f2fs_issue_discard_thread later processes those commands,
> __check_sit_bitmap() detects valid blocks in the discard range and
> triggers a kernel BUG().
> 
> To fix this:
> 1. Introduce f2fs_drop_discard_cmd_range() to traverse the discard rbtree,
>     drop all pending D_PREP discard commands in the range,
>     and wait for any in-flight discard bios under dcc->cmd_lock.
> 2. Call f2fs_drop_discard_cmd_range() in f2fs_ioc_reserve_dev_alias()
>     before f2fs_reserve_device_alias().
> 
> Reported-by: Wenjie Qi <qiwenjie@xiaomi.com>
> Fixes: eae3faf210bd ("f2fs: support dynamic reserve/release for device aliasing")
> Cc: stable@vger.kernel.org
> Signed-off-by: Daeho Jeong <daehojeong@google.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
