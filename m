Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E009C5DF87
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 21 Aug 2026 01:50:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Content-Transfer-Encoding:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FNjDWXv2pAAOLwICgX7S1gnoFb94TQOxuHIKgTozs5Y=; b=S6qhAsVGdWvS0X5umcJkA+aUL8
	+yrP0sXkZ0Yr6WqAsWrwNvX5qVucnkZcWHXc47JcJmUmbbY8PXGF9otnyKmIufYHhGi1Zbdv4i1Pq
	tGQkeZZbFZfU6sJIXG921NKLRpPr2qL9E0l96n28m1sB8clbDDYsZofEiPmzSEOc6QvE=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wxEOb-0003uZ-QO;
	Fri, 21 Aug 2026 01:50:14 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1wxEOa-0003uS-Gg
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 21 Aug 2026 01:50:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=70D8rCXiESgssIEfrgsxFH7LPPhbt9/Ke7IYz/6fsZ4=; b=BLZta3Obg1SwmX0tuGW9q3DKtU
 geuDO1bFK4Pn4/NdIKSkhgBs3sHgLFJbG2tpVZzIrPmHOygYTGCuJ7ub5BDXRnl7G2ouAfcTbS8Lw
 5xu8iD8IzvDx6P3RynpsWogBO7hmHPWOWXM8C9HX44scG73MVMjs7kHnJm3V2luIHCNs=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=70D8rCXiESgssIEfrgsxFH7LPPhbt9/Ke7IYz/6fsZ4=; b=TpTpfqQCJtj7yQuLseHKnsFgED
 4L0+j7USsOPnOqkzkK712njeLvUXzCcRvSy14FpPbMtAgKs69ShRQ/VpHSgZvXdn2s5KenS3aqySy
 nzz7mcqrethsyl+6dKVIpejzmr02ipDREuM+BIii72J0p2QgRoVSqkHgzb31zRmwc3Dc=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wxEOZ-0002x3-UN for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 21 Aug 2026 01:50:13 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 17B3843BC7;
 Fri, 21 Aug 2026 01:50:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44A761F000E9;
 Fri, 21 Aug 2026 01:50:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787277005;
 bh=70D8rCXiESgssIEfrgsxFH7LPPhbt9/Ke7IYz/6fsZ4=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To;
 b=ZyMSz/j/bFbau4zCMxxYJMabUYATwCdW/U0Vqv/0TK5EBbUInQIUi9n8a0aBf/IRE
 OiHY9Q8E4+JeFz6oir72HQ0FGORBnU1DI6LXOaqVwllaAi82pXMl8XzkEvCPyCir6J
 zf7kKFCxQMZ4Ba03fTarl84d2c3LF9lzXqW5vX64W+DPozOMRNb1KBH1RKfE+iYjzC
 K8tTEM3D9W6qDP6xO1kI24PFtIuw82jFJjdczj0RN/PPV002Y37k6p96mqlDh78VXI
 FGOgJeewtdC6h1Qozvkb0Xkb+VXVCVXcJw/7tJMLSUZp56Ud0bYGKIVEQTjPi/SZQi
 gWonILq/jEYCQ==
Message-ID: <15a3ea00-8f50-4673-b445-1c83b1369ae8@kernel.org>
Date: Fri, 21 Aug 2026 09:50:02 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Wenjie Qi <qwjhust@gmail.com>, jaegeuk@kernel.org
References: <20260820071438.695893-1-qiwenjie@xiaomi.com>
Content-Language: en-US
In-Reply-To: <20260820071438.695893-1-qiwenjie@xiaomi.com>
X-Headers-End: 1wxEOZ-0002x3-UN
Subject: Re: [f2fs-dev] [PATCH v2 0/2] f2fs: enable buffered RWF_DONTCACHE
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
Cc: qiwenjie@xiaomi.com, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 8/20/26 15:14, Wenjie Qi wrote:
> This series enables buffered RWF_DONTCACHE on F2FS for sustained one-pass
> streaming writes, where retaining the written data can displace more useful
> cache.
> 
> Patch 1 keeps normal and dropbehind folios in separate write bios and
> defers dropbehind completion unless it runs in preemptible task context.
> Its eligibility check matches the proposed bio_in_atomic() helper instead
> of checking only in_task().
> 
> Patch 2 passes FGP_DONTCACHE to the F2FS buffered write folio lookup and
> advertises FOP_DONTCACHE.
> 
> Tests were run on a Xiaomi phone with 10.7 GiB of kernel-visible memory,
> running Android 16 and Linux 6.12.69 with 4 KiB pages.  /data used F2FS.
> 
> The performance test wrote exactly 64 GiB per run at 4 KiB,
> 8 KiB, 16 KiB, 32 KiB, 64 KiB, 128 KiB, 256 KiB, 512 KiB, and 1 MiB.
> Two counterbalanced rounds ran ascending normal-first and descending
> dontcache-first.  Values below are equal-weight means of both runs; N=2.
> The pwritev2() writer models the streaming workload; it does not show that
> an unchanged Android application already issues RWF_DONTCACHE.
> 
> Android remained active with displays off.  Each run started after a cache
> reset and at least 120 seconds of cooldown.  Throughput and one-second
> kswapd0/global-memory samples cover the write loop.
> 

Thanks very much for the update.

> Write-loop throughput was:

What about read?

> 
>            normal MiB/s              dontcache MiB/s
>   I/O      r1       r2      mean      r1       r2      mean     change
>   4K      946.28   935.74   941.01   291.36   309.31   300.33   -68.08%
>   8K     1077.05  1105.84  1091.45   477.79   479.79   478.79   -56.13%
>   16K    1126.84  1118.49  1122.67   643.40   652.06   647.73   -42.30%
>   32K    1150.62  1036.33  1093.48   762.24   751.45   756.84   -30.79%
>   64K    1144.80  1163.82  1154.31   852.11   851.19   851.65   -26.22%
>   128K   1166.29  1162.84  1164.57   867.47   865.05   866.26   -25.61%
>   256K   1153.61  1172.78  1163.19   895.53   885.33   890.43   -23.45%
>   512K   1173.61  1197.34  1185.48   903.09   903.01   903.05   -23.82%
>   1M     1126.22  1154.59  1140.41   850.74   894.60   872.67   -23.48%

Seems side-effect, how will this affect userspace applications?

> 
> Average kswapd0 CPU and average global Cached were:
> 
>   I/O      kswapd0 CPU, normal/DC        Cached MiB, normal/DC
>   4K             18.45% / 0%                 4830.15 / 686.56
>   8K             21.60% / 0%                 4862.35 / 591.48
>   16K            22.75% / 0%                 4905.47 / 625.07
>   32K            22.05% / 0%                 4945.82 / 561.59
>   64K            23.46% / 0%                 4920.77 / 639.78
>   128K           23.16% / 0%                 4971.37 / 693.26
>   256K           23.68% / 0%                 4956.93 / 668.60
>   512K           24.25% / 0%                 4972.22 / 663.92
>   1M             22.01% / 0%                 5001.09 / 705.30
> 
> Other global memory means were:
> 
>            MemAvailable MiB       Dirty MiB          Writeback MiB
>   I/O       normal / DC          normal / DC          normal / DC
>   4K      6513.08 / 6382.31     640.48 / 33.93       37.94 / 0.09
>   8K      6560.77 / 6529.33     690.89 / 43.57       40.84 / 0.54
>   16K     6587.46 / 6519.94     789.16 / 62.67       61.58 / 4.64
>   32K     6571.95 / 6566.74     850.48 / 69.14       67.69 / 9.24
>   64K     6600.64 / 6559.89    856.97 / 134.28      59.60 / 16.19
>   128K    6627.03 / 6465.10    873.68 / 137.57      60.57 / 41.50
>   256K    6615.58 / 6541.09    885.98 / 158.15      61.25 / 29.57
>   512K    6625.52 / 6534.41    900.65 / 139.07      63.65 / 30.35
>   1M      6677.09 / 6539.89    909.70 / 187.56      51.58 / 33.46
> 
>            Active(file) MiB      Inactive(file) MiB
>   I/O       normal / DC             normal / DC
>   4K       279.57 / 264.13         4426.38 / 183.12
>   8K       262.32 / 260.97         4472.62 / 182.19
>   16K      392.09 / 252.95         4392.78 / 195.82
>   32K      254.30 / 248.44         4554.18 / 187.34
>   64K      252.73 / 244.94         4545.40 / 267.28
>   128K     322.02 / 243.95         4530.63 / 298.91
>   256K     245.47 / 240.02         4586.64 / 303.92
>   512K     254.75 / 232.05         4591.17 / 288.27
>   1M       238.88 / 233.64         4638.81 / 341.00

Can we compare the data before/after the patch?

Thanks,

> 
> Dontcache left zero target-file pages resident at every size.  Normal
> retained about 1.19--1.24 million pages.  Normal runs incurred roughly
> 15.6 million kswapd page scans and steals per run, while dontcache recorded
> zero.  Direct scan and allocation-stall deltas were zero in both modes.
> 
> Changes since the RFC:
> 
> - match the stricter proposed bio_in_atomic() eligibility rule;
> - add phone correctness and two-round 64-GiB performance results.
> 
> Wenjie Qi (2):
>    f2fs: complete dropbehind write bios in safe task context
>    f2fs: enable buffered RWF_DONTCACHE
> 
>   fs/f2fs/data.c | 59 ++++++++++++++++++++++++++++++++++++++++----------
>   fs/f2fs/file.c |  2 +-
>   2 files changed, 49 insertions(+), 12 deletions(-)
> 



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
