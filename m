Return-Path: <SRS0=r/0U=WQ=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35543C3A589
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 20 Aug 2019 17:57:28 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 04BCC214DA;
	Tue, 20 Aug 2019 17:57:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="W+YmNKpl";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="Oix6erpu";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="QTOiJBvl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04BCC214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1i08Nr-0005bR-K3; Tue, 20 Aug 2019 17:57:27 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <jaegeuk@kernel.org>) id 1i08Nr-0005bK-7Q
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 20 Aug 2019 17:57:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=uqDFYZZI5yVkRVhpfHEwOxRmwHUQWoqYFVA5K8ZfhgY=; b=W+YmNKplbNWD2YvRvjQPXKuzsG
 f+5KWJ8QowSqKN8rtxgasl7IAdok8tnJiDR4HhSxt3CnEmpZzp2QGZN5foMx74D5+6H8FIuOgADuK
 w5OMLxJFUGmRf1R/5aOOEShB470oVbK69ubwLCKUM9mg8ycKcIOn39lM56s3dxnzsVKY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=uqDFYZZI5yVkRVhpfHEwOxRmwHUQWoqYFVA5K8ZfhgY=; b=Oix6erpuD2D0M9+sp747gPUoxO
 /d8jLQiSNRzKSpIQIqskrSlEfZb1JpvRIH9EVuwRRD/I5hMdq10zRa9gBz3Kz1S6qN9YCWb0+KVg/
 /V5hhWmABjpfPL/xOcHUaBbAXQI+Zqd8/Zke+u0l80r3h3NDamMm0u+AegBKdQQ1q+ck=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1i08Np-00AEL0-9d
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 20 Aug 2019 17:57:27 +0000
Received: from localhost (unknown [104.132.0.81])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 8F399214DA;
 Tue, 20 Aug 2019 17:57:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1566323839;
 bh=BNniGPPz4Jn/haQOn1OkFgeYntu5G2/1DZ4/XsNqCcY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=QTOiJBvlfT5L8rgQtmyi6qetc9cmYuKyLQzB4tTwlfyLVyFIvEHkG2pagC+FaeoY2
 7gwE1pVklAN0uwB1Df27QJOxZbaAvcZn/y9hbGoPMV+DcAReWvYCpeR6p4oYDTRz2h
 JJc0BTJKWLtytNS5NQDA8kW2BOyx6k9m/ukviDqc=
Date: Tue, 20 Aug 2019 10:57:18 -0700
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Message-ID: <20190820175718.GC58214@jaegeuk-macbookpro.roam.corp.google.com>
References: <20190819083034.18218-1-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190819083034.18218-1-shinichiro.kawasaki@wdc.com>
User-Agent: Mutt/1.8.2 (2017-04-18)
X-Headers-End: 1i08Np-00AEL0-9d
Subject: Re: [f2fs-dev] [PATCH 0/4] fsck: Check write pointers of zoned
 block devices
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
Cc: Damien Le Moal <Damien.LeMoal@wdc.com>,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hi Shinichiro,

Thank you so much for the contribution.
BTW, I failed to compile them. Could you please take a look at them one more
time? :)

Thanks,

On 08/19, Shin'ichiro Kawasaki wrote:
> On sudden f2fs shutdown, zoned block device status and f2fs meta data can be
> inconsistent. When f2fs shutdown happens during write operations, write pointers
> on the device go forward but the f2fs meta data does not reflect write pointer
> progress. This inconsistency will eventually cause "Unaligned write command"
> error when restarting write operation after the next mount. This error can be
> observed with xfstests test case generic/388, which enforces sudden shutdown
> during write operation and checks the file system recovery. Once the error
> happens because of the inconsistency, the file system requires fix. However,
> fsck.f2fs does not have a feature to check and fix it.
> 
> This patch series adds a new feature to fsck.f2fs to check and fix the
> inconsistency. First and second patches add two functions which helps fsck to
> call report zone and reset zone commands to zoned block devices. Third patch
> checks write pointers of zones that current segments recorded in meta data point
> to. This covers the failure symptom observed with xfstests. The last patch
> checks write pointers of zones that current segments do not point to, which
> covers a potential failure scenario.
> 
> This patch series depends on other patches for zoned block devices, then it
> conflicts with the master branch in f2fs-tools.git as of Aug/19/2019. It can be
> applied without conflict to dev and dev-test branch tips.
> 
> Shin'ichiro Kawasaki (4):
>   libf2fs_zoned: Introduce f2fs_report_zones() helper function
>   libf2fs_zoned: Introduce f2fs_reset_zone() function
>   fsck.f2fs: Check write pointer consistency with current segments
>   fsck.f2fs: Check write pointer consistency with valid blocks count
> 
>  fsck/fsck.c         | 161 ++++++++++++++++++++++++++++++++++++++++++++
>  fsck/fsck.h         |   3 +
>  fsck/main.c         |   2 +
>  include/f2fs_fs.h   |   3 +
>  lib/libf2fs_zoned.c |  81 ++++++++++++++++++++++
>  5 files changed, 250 insertions(+)
> 
> -- 
> 2.21.0


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
