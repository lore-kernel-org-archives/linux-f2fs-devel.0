Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F19B2C79F99
	for <linux-f2fs-devel@archiver.kernel.org>; Tue,  8 Sep 2026 03:56:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=yKjhQFITiQBia//eMHgDThlGJsBPETdiGbMtyAg88pc=; b=EzydoFAjRdGNGj1ILfDTUzq/jf
	zDuchIqZ3HDB83bxXKkBtQaI20NzMuJUkN7O31IJV0aeBTbDNHQiifjAJdXmMs8/UL8Ybl/BsMTQh
	WCYsV1p8tBY6+IoUvTD34HY6C3hTB7puHu9Wof1B6k0lhRrerqInxEgMlPy+wTpYuy8w=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1x3mwB-0005Nk-2r;
	Tue, 08 Sep 2026 03:55:59 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <qwjhust@gmail.com>) id 1x3mw9-0005Ne-Ml
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 08 Sep 2026 03:55:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=PPQzWxuhw7pZTs+zszzFmSn4KI/x61XrCe5D1SPsyZk=; b=Psqfo1TnsG/9dtYxq1It418ITw
 xBEaw/YJtGGhyxIa2G2gjLTwUKi4bl4YCni6yGr48OX/ub3+VKsqs9dHr2VELXY0Mi0WDL/ZjC7vD
 9uRQsvoy2wpkmEPFT9Vt5vHnbR/s3xTN2W/TBweml6L8UT6dot3YO4VeLxVSXwzTQrac=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=PPQzWxuhw7pZTs+zszzFmSn4KI/x61XrCe5D1SPsyZk=; b=FURZ/WduxRgY0iETbJGTz6EIAH
 lBL0oagXmj8HafrG4rc25MtsuPcWFIa8Krxk6Dx5QoYAhibyYgjyhpUEanaK3y6ZRgfJ2Dn05xCpu
 g5Giu7CEzz+Clnz4jIxui1ukojHQqFjlusNm0WCBGWRQYUHCIfNvJi48NZIraSHKqAEU=;
Received: from mail-pl1-f180.google.com ([209.85.214.180])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x3mw9-0004B8-QM for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 08 Sep 2026 03:55:58 +0000
Received: by mail-pl1-f180.google.com with SMTP id
 d9443c01a7336-2d944747d41so43408055ad.0
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 07 Sep 2026 20:55:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788839752; x=1789444552; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=PPQzWxuhw7pZTs+zszzFmSn4KI/x61XrCe5D1SPsyZk=;
 b=UIlf5R1SA1JO0artGAZE0k3wB28QwO+DucIAfkfKLN3n88vCnus74RasH3C6Z0mPia
 LmIYA5+uaJ8N6Ga4OLU3B4MzNKAZ655FXAMYfImiXLSgHTD7xiKebcFp+YUevU/rZRXj
 bX8NtcFwEzmETSuNHPlXrNVk9uKmbQapTwocVlw0kZXS2BLqe6i5D8RoeE+aO/dVxNws
 pirSkqznNpl37TOxZtfu4iQ8NgYgzOIn4XTHSdL2cwqYhPBslyAFu5Nh93Gccp7KMxaz
 cKfZqQlk0j//pUQlKtfpHyZBi/s6A+0CmpsEUrwPsSfZaPKg/uM2ddicwNj3JWbaYwhi
 XvRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788839752; x=1789444552;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=PPQzWxuhw7pZTs+zszzFmSn4KI/x61XrCe5D1SPsyZk=;
 b=NKHAHPZmedw8pIvBqUzfgTHOhDfttW9utWw9jGmnoSUW1aH/NJYGfI2Z6SDHuxiAM4
 YecER2Q/IydiRV074G5wby62I8kKwpFOrJCwVqoKylPwnbRdFI0PfhRsCZSWasmAcjX7
 gMzSdaeg6f3LNamVaWJBzdKks5eo3M1on77hrXwf2JWORe/4IOa8Db8c6EQx1FENdJvo
 IboOSdRcmzIgMgDSiznHtArOwtg+Uir7opVGk518o0Tct0DnI4WqFnHnwVt6m2wIsts2
 gDXnuKHpKDLuY/VT0NJ+Vcma/e8qrxq/eaEyXRXHBAg9C5gJ1Xs2733yUU+bpdu4mBQm
 Bpxg==
X-Gm-Message-State: AFuF++mwfF5jVsgqDRdaZPsYs5N8eJkiqy1LbFkwbYGTD99YoqXug9fT
 hw0QmmOQVIbCbeeqj9E9GM2ih1C3BhQWOjJq4n4B4v6Z28fySqPwMIXw
X-Gm-Gg: AYBFou0wCu/OL3pSQhBuziyc7e54s4Prjt96gjkjc4cckXI/HmyEwnpm8YGqwkwC5RD
 EZ0BXELRMo4J3YaZ1ryTs1nlguiBwnKupVUB/+0VoBjivsAVabxBKIpzsH3+AiT1ekrgE9iXElJ
 GKqNV95C15hKdSX7SJNOjp0CmDyiDXW7R0v3+k1Cfy60LSzZvr8HPzTIpIxYfGA5dTCXHcExkEd
 6rzycN3zI0clVQYc5kyYppdvdFpnHRtPJO5/fo9TxnbpVnFaJvmUWarLdJTIoERWg7qodfPf2w4
 W4VwByt9W9ysIgTi19gB8+Z8IFdVp+/8iIvsJOJNLTosKlXsGd8ibtjvK946aiDDWTyP/dQ3mp9
 LviTNVLV7bqEn39Edur4AONih8IUw3x9sWM4QjsgORoWb0rP91ow27MtxsMJPtu+FEzqJGMRpbe
 1EL3VYV2YK67xf/J/1HDo093pBVVbpJ6iG6tMub/c9yFREQSJo1oZbrdGAMVnhISRSZhmF0wufH
 oZFap6CMmC7EGE6n9EtR6Br
X-Received: by 2002:a17:902:fdab:b0:2d9:599e:df95 with SMTP id
 d9443c01a7336-2db122edaa3mr386816705ad.3.1788839752025; 
 Mon, 07 Sep 2026 20:55:52 -0700 (PDT)
Received: from qiwenjie-ThinkCentre-M760t.mioffice.cn ([43.224.245.241])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2db14aeaf74sm51899295ad.81.2026.09.07.20.55.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Sep 2026 20:55:51 -0700 (PDT)
From: Wenjie Qi <qwjhust@gmail.com>
X-Google-Original-From: Wenjie Qi <qiwenjie@xiaomi.com>
To: jaegeuk@kernel.org,
	chao@kernel.org
Date: Tue,  8 Sep 2026 11:55:41 +0800
Message-ID: <cover.1788795700.git.qiwenjie@xiaomi.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1788438786.git.qiwenjie@xiaomi.com>
References: <cover.1788438786.git.qiwenjie@xiaomi.com>
MIME-Version: 1.0
X-Headers-End: 1x3mw9-0004B8-QM
Subject: [f2fs-dev] [PATCH v5 0/2] f2fs: enable buffered RWF_DONTCACHE
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
Cc: axboe@kernel.dk, baohua@kernel.org, jack@suse.cz, qwjhust@gmail.com,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-block@vger.kernel.org, linux-mm@kvack.org, qiwenjie@xiaomi.com,
 linux-fsdevel@vger.kernel.org, tz2294@columbia.edu, hch@lst.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

This series enables buffered RWF_DONTCACHE on F2FS for sustained one-pass
streaming writes, where retaining the written data can displace more useful
cache.

Patch 1 marks dropbehind write bios with BIO_COMPLETE_IN_TASK. Normal and
dropbehind folios may share otherwise mergeable IPU and OPU bios; the flag
is set monotonically when a dropbehind folio joins an existing bio. The
block layer owns deferral from unsafe completion contexts.

Patch 2 passes FGP_DONTCACHE to the F2FS buffered write folio lookup,
advertises FOP_DONTCACHE, and handles internal write_begin callers that
pass a NULL kiocb.

Tests were run on a Xiaomi phone with 10.7 GiB of kernel-visible memory,
running Android 16 and Linux 6.12.69 with 4 KiB pages. /data used F2FS.

The performance test wrote exactly 64 GiB per run at 4 KiB,
8 KiB, 16 KiB, 32 KiB, 64 KiB, 128 KiB, 256 KiB, 512 KiB, and 1 MiB.
Two counterbalanced rounds ran ascending normal-first and descending
dontcache-first. Values below are equal-weight means of both runs; N=2.
The pwritev2() writer models the streaming workload; it does not show that
an unchanged Android application already issues RWF_DONTCACHE.

Android remained active with displays off. Each run started after a cache
reset and at least 120 seconds of cooldown. Throughput and one-second
kswapd0/global-memory samples cover the write loop.

Write-loop throughput was:

          normal MiB/s              dontcache MiB/s
 I/O      r1       r2      mean      r1       r2      mean     change
 4K      946.28   935.74   941.01   291.36   309.31   300.33   -68.08%
 8K     1077.05  1105.84  1091.45   477.79   479.79   478.79   -56.13%
 16K    1126.84  1118.49  1122.67   643.40   652.06   647.73   -42.30%
 32K    1150.62  1036.33  1093.48   762.24   751.45   756.84   -30.79%
 64K    1144.80  1163.82  1154.31   852.11   851.19   851.65   -26.22%
 128K   1166.29  1162.84  1164.57   867.47   865.05   866.26   -25.61%
 256K   1153.61  1172.78  1163.19   895.53   885.33   890.43   -23.45%
 512K   1173.61  1197.34  1185.48   903.09   903.01   903.05   -23.82%
 1M     1126.22  1154.59  1140.41   850.74   894.60   872.67   -23.48%

Average kswapd0 CPU and average global Cached were:

 I/O      kswapd0 CPU, normal/DC        Cached MiB, normal/DC
 4K             18.45% / 0%                 4830.15 / 686.56
 8K             21.60% / 0%                 4862.35 / 591.48
 16K            22.75% / 0%                 4905.47 / 625.07
 32K            22.05% / 0%                 4945.82 / 561.59
 64K            23.46% / 0%                 4920.77 / 639.78
 128K           23.16% / 0%                 4971.37 / 693.26
 256K           23.68% / 0%                 4956.93 / 668.60
 512K           24.25% / 0%                 4972.22 / 663.92
 1M             22.01% / 0%                 5001.09 / 705.30

Other global memory means were:

          MemAvailable MiB       Dirty MiB          Writeback MiB
 I/O       normal / DC          normal / DC          normal / DC
 4K      6513.08 / 6382.31     640.48 / 33.93       37.94 / 0.09
 8K      6560.77 / 6529.33     690.89 / 43.57       40.84 / 0.54
 16K     6587.46 / 6519.94     789.16 / 62.67       61.58 / 4.64
 32K     6571.95 / 6566.74     850.48 / 69.14       67.69 / 9.24
 64K     6600.64 / 6559.89    856.97 / 134.28      59.60 / 16.19
 128K    6627.03 / 6465.10    873.68 / 137.57      60.57 / 41.50
 256K    6615.58 / 6541.09    885.98 / 158.15      61.25 / 29.57
 512K    6625.52 / 6534.41    900.65 / 139.07      63.65 / 30.35
 1M      6677.09 / 6539.89    909.70 / 187.56      51.58 / 33.46

          Active(file) MiB      Inactive(file) MiB
 I/O       normal / DC             normal / DC
 4K       279.57 / 264.13         4426.38 / 183.12
 8K       262.32 / 260.97         4472.62 / 182.19
 16K      392.09 / 252.95         4392.78 / 195.82
 32K      254.30 / 248.44         4554.18 / 187.34
 64K      252.73 / 244.94         4545.40 / 267.28
 128K     322.02 / 243.95         4530.63 / 298.91
 256K     245.47 / 240.02         4586.64 / 303.92
 512K     254.75 / 232.05         4591.17 / 288.27
 1M       238.88 / 233.64         4638.81 / 341.00

Dontcache left zero target-file pages resident at every size. Normal
retained about 1.19--1.24 million pages. Normal runs incurred roughly
15.6 million kswapd page scans and steals per run, while dontcache recorded
zero. Direct scan and allocation-stall deltas were zero in both modes.

A controlled explicit-dontcache model issued 64 KiB writes for 120 seconds
at 64, 128, and 256 MiB/s. Both modes sustained all three rates in both
rounds with no final schedule overrun. Between 0.02% and 0.41% of writes
completed late, with a maximum schedule lag of 3.3--6.0 ms. Dontcache left
zero target pages resident. This was a controlled model, not an unchanged
Xiaomi application.

Buffered read throughput was:

 I/O       normal MiB/s   dontcache MiB/s   change
 4K          1825.50          1695.10        -7.14%
 8K          1901.46          1847.96        -2.81%
 16K         1941.60          1872.55        -3.56%
 32K         1960.95          1905.92        -2.81%
 64K         1951.35          1886.54        -3.32%
 128K        1960.03          1915.82        -2.26%
 256K        1976.01          1900.41        -3.83%
 512K        1973.31          1911.24        -3.15%
 1M          2230.91          2007.82       -10.00%

Dontcache left zero source pages resident in all measured read runs.

The normal-I/O control showed read-throughput differences of +0.67%,
-0.90%, and -2.58%, and write-throughput differences of -1.75%, +0.33%,
and +2.33%, at 4 KiB, 64 KiB, and 1 MiB respectively.

As a separate memory-pressure supplement, I tested F2FS on x86-64 QEMU
with the F2FS images backed by the host NVMe. Each run issued a 1-GiB
homogeneous sequential write using 8-KiB or 1-MiB I/O. Normal and
dontcache each ran in three counterbalanced rounds with
memory.max=255852544, memory.swap.max=0, and formal tracing was disabled.
Values below are medians of three completed runs.

 I/O    N done  D done   MiB/s N/D        memcg MiB N/D
 8 KiB  3/3    3/3      236.259/227.634  160.867/2.075
 1 MiB  3/3    3/3      222.232/859.805  155.178/9.098

 I/O    scan N/D            steal N/D
 8 KiB  270,821/0           201,227/0
 1 MiB  344,267/0           201,013/0

Scan is the number of pages examined by reclaim, while steal is the number
of pages successfully reclaimed. memcg MiB is average memory.current.

At 8 KiB, dontcache throughput was 3.65% lower. The paired changes were
-12.7%, +65.8%, and -3.65%, so the direction was not stable. At 1 MiB,
dontcache throughput was 286.90% higher, and all three paired changes were
positive: +96.1%, +257.8%, and +295.8%. Average memory.current decreased by
98.71% at 8 KiB and 94.14% at 1 MiB. Dontcache recorded zero scan and steal
in both profiles.

Changes since v4:

- allow normal and dropbehind folios to share write bios, following iomap,
  and set BIO_COMPLETE_IN_TASK when a dropbehind folio joins an existing
  bio;
- handle internal write_begin callers that pass a NULL kiocb;
- add QEMU memory-pressure and mixed-bio measurements.

Wenjie Qi (2):
  f2fs: complete dropbehind write bios in task context
  f2fs: enable buffered RWF_DONTCACHE

 fs/f2fs/data.c | 15 ++++++++++++---
 fs/f2fs/file.c |  2 +-
 2 files changed, 13 insertions(+), 4 deletions(-)

-- 
2.43.0


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
