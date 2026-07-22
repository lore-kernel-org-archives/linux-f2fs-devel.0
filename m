Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F10EBC44536
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 22 Jul 2026 13:52:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Content-Transfer-Encoding:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=u9RPA7ekbAoieMspe8kCH1GX2XHSIXzZR28sCDMMwnY=; b=C59l7xBc0jAt5fk6u1spUVvvRO
	CCNW/7kTIUiGFHalcRxLVTsadj+/O7UDi0boDyLAfk00nQoHrYj05Sy4AKvQ1zkvjX9CkRj4upMYY
	08AL8oDjcriTKu8KSbcxMv8xuHrOO6iapaiu42TQKwHuGSNaf8K70tUQaVtElDDiJNlY=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wmXMi-0002aS-S9;
	Wed, 22 Jul 2026 13:52:05 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <bvanassche@acm.org>) id 1wmXMC-0002Xe-FZ
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 22 Jul 2026 13:51:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=+nVcIbsiAs5qjlk55CRaE2XCGdGpLHa05sOnOzYwOYk=; b=dIs8lKgGHx9RbjVV+inUhmgGeN
 LMu0mPvy7HNxP86hxenb4ck6zitaQYoO+29H9ZZqr5aBnJ8IU2nBTdu0/xYIkhSyEZ8n2kmBPJMFS
 7hpirglx4p/e8L0dRtGugvNY6pB4jAAxcYH6/bnstDM1CalnsGi+qjm7t8jWh8CHhLZY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=+nVcIbsiAs5qjlk55CRaE2XCGdGpLHa05sOnOzYwOYk=; b=TKLVQ5FTUvh/b8zYNRHYzq1JId
 XLrsn5rh1SqfcaGhWateC8d5a995wapuXrLtZOXK//o/FjzC4AZx/nfLwLeVag6YrOg07lRM6j9iB
 JKwOCUZKcN6GGy3jQzSYYUUam3dHlk3HtBFj0IZ4PmCQjR9g5iridqxCQLzxHRuY0X6Y=;
Received: from 011.lax.mailroute.net ([199.89.1.14])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wmXMB-00005b-RU for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 22 Jul 2026 13:51:33 +0000
Received: from localhost (localhost [127.0.0.1])
 by 011.lax.mailroute.net (Postfix) with ESMTP id 4h4wdp5Hsdz1XM6JT;
 Wed, 22 Jul 2026 13:51:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
 content-transfer-encoding:content-type:content-type:in-reply-to
 :from:from:content-language:references:subject:subject
 :user-agent:mime-version:date:date:message-id:received:received;
 s=mr01; t=1784728283; x=1787320284; bh=+nVcIbsiAs5qjlk55CRaE2XC
 GdGpLHa05sOnOzYwOYk=; b=q+NBVhZkg4Wt7t3af2TTp0SpAkyw0aiwKBgdutIt
 0qZE27fVb3URyq01vbqB0GHrYQtZTAX1NYnLxCfwHI33k3+mbQqHsFV1TBU6PCoW
 rQUbP52n25SiNptrytB5a7ELv4oHOjxqYA0hM+y7Js45z7tYZlLysCep0U5Y7Xdd
 FIU8sX52GnKhu31nAkuv7FtmfZB0Mz+rNvYvu2nbzrKuvd0OBUTZLkcqc0GoOdmn
 Wxz9VdrByUTD9CJ7g0tLrr4nUELIbmrVrt+bRTQnC0aCWTdlqHqKYD+49Vyh4ZVk
 qqQ1OyZCwFQsgmLVmdrIPB464TPGGsWUaLbEpV+Iz62zoA==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id vQCBWsrD3AoK; Wed, 22 Jul 2026 13:51:23 +0000 (UTC)
Received: from [192.168.50.14] (c-73-231-117-72.hsd1.ca.comcast.net
 [73.231.117.72])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 (Authenticated sender: bvanassche@acm.org)
 by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4h4wdj6rPwz1XM5kD;
 Wed, 22 Jul 2026 13:51:21 +0000 (UTC)
Message-ID: <c9907593-4521-4ad9-9c11-394b3012998e@acm.org>
Date: Wed, 22 Jul 2026 06:51:19 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Daeho Jeong <daeho43@gmail.com>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
References: <20260721164752.3853201-1-daeho43@gmail.com>
Content-Language: en-US
In-Reply-To: <20260721164752.3853201-1-daeho43@gmail.com>
X-Headers-End: 1wmXMB-00005b-RU
Subject: Re: [f2fs-dev] [PATCH] fsck.f2fs: flush device buffer before zone
 transition on zoned storage
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
From: Bart Van Assche via Linux-f2fs-devel
 <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Bart Van Assche <bvanassche@acm.org>
Cc: Daeho Jeong <daehojeong@google.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 7/21/26 9:47 AM, Daeho Jeong wrote:
> On zoned storage devices (F2FS_ZONED_HM), fsck.f2fs opens block devices
> with buffered I/O (O_RDWR). When a curseg fills up its current zone and
> moves to a new zone in find_next_free_block(), pending buffered writes
> to the previous zone may still reside in the OS page cache / I/O queue.
> 
> As a result, issuing a write to the newly allocated zone can happen before
> the device hardware finishes committing all blocks of the previous zone,
> causing the hardware to see an additional open zone request that exceeds
> the device's max open zone limit (e.g. open zones exceeded error).
> 
> Fix this by calling f2fs_fsync_device() right before allocating a new zone
> when crossing zone boundaries (!(segno % segs_per_zone)). This flushes
> all pending writes to physical media, ensuring the device hardware
> auto-closes (FULL) the previous zone before opening the new zone.
> 
> Signed-off-by: Daeho Jeong <daehojeong@google.com>
> ---
>   fsck/mount.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/fsck/mount.c b/fsck/mount.c
> index 6f640a0..3bd40fe 100644
> --- a/fsck/mount.c
> +++ b/fsck/mount.c
> @@ -3073,6 +3073,9 @@ int find_next_free_block(struct f2fs_sb_info *sbi, u64 *to, int left,
>   			if (!(segno % segs_per_zone)) {
>   				u64 new_blkaddr = SM_I(sbi)->main_blkaddr;
>   
> +				if (c.zoned_model == F2FS_ZONED_HM)
> +					f2fs_fsync_device();
> +
>   				ret = find_next_free_block(sbi, &new_blkaddr, 0,
>   						want_type, true);
>   				if (ret)

Will this change make a difference on Android because the Android
f2fs-tools already use O_DSYNC when opening a zoned block device?
 From lib/libf2fs.c:

                 if (dev->zoned_model == F2FS_ZONED_HM)
                         flags |= O_DSYNC;

See also commit 10dad5ed7ce1 ("f2fs-tools: support zoned ufs devices").

Thanks,

Bart.



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
