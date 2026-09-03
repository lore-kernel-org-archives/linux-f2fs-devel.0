Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F7F6C624D6
	for <linux-f2fs-devel@archiver.kernel.org>; Thu,  3 Sep 2026 13:00:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:Date:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=T++7cy6eY0d6kQZJeySWhdcTIJc+BMSWLo77KkrAVWQ=; b=ZBqVUrbMT7jf4YNVgmEBokppMZ
	E6D2LVTrac85506jwgCbu3gKIBLybVNuDrWy45KT7iuEZp1w9kwSHPaqBErbw0LzRKO8gfdE67xTn
	Cf/HanbaSZzbOgsZDdmg2Np8Pub4xmOZDzzwqVSImF24e+DTRSYOlln1+xlkDJjgJQC0=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1x2738-0006tC-9S;
	Thu, 03 Sep 2026 13:00:14 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <qwjhust@gmail.com>) id 1x2736-0006t3-P3
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 03 Sep 2026 13:00:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ySykvbIWmO4Te6vIVwftEuMOLYpDg3lGaudbSYAL6eg=; b=Hcl/qibr0j+FoTSOEKNTZQe5+k
 lHd48ytpNRP8JD1+DUQOStyRDrM1mGEbKk2EA3k6+gzed/GD5JorTDQSlpLuGG05ykbo2ZbrKBRnU
 ybAzzXThheyiY/hj2s/6njf82e8kxqLEPr75Hgqa6NbbsipEv39p4NFeGGxJLYWPo0Ko=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=ySykvbIWmO4Te6vIVwftEuMOLYpDg3lGaudbSYAL6eg=; b=V
 y8dGmAlhPPfiS0LNHw5AHlrUhSqmh0dtAnUOKHImd6vuQivKQzQAoAfs/nmlIEP40+90bIuSfAzym
 gEafjxG4zruqSkvtCA+9tXZoIIohTazcMoEjypnE5q0WS/FbnlFHJfMRQ2tOzTxAHJVnX6SYoO5+5
 Pgdy78I9YjsIfEGA=;
Received: from mail-pf1-f169.google.com ([209.85.210.169])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x2733-00039x-4v for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 03 Sep 2026 13:00:12 +0000
Received: by mail-pf1-f169.google.com with SMTP id
 d2e1a72fcca58-8485b358552so2125899b3a.2
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu, 03 Sep 2026 06:00:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788440403; x=1789045203; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=ySykvbIWmO4Te6vIVwftEuMOLYpDg3lGaudbSYAL6eg=;
 b=HbAUqlxOF1BvzlDxFIiFndcEehpYcH5nOYHlv26elwrZtxEUleYcg6wN5r30NyCJDo
 v9RvMBxnpZE+Vp+EkQKV32lFOicOotUUy7xrOz1OgBru8WBhE/+U1DxUHtUNIdEm/Qxr
 cWAPReECZbeTAYQCOOOMznSH4p3i5A88fdoO8ONaDHYwB90VtyvKCUKP4zJXEJriOYQ6
 uW0EW2iXmEa9o4cRWn50c15jDRdU07jUg7tyrhULm0CgDh3nNHEOIee64znZ54LDJMfy
 hOgdeAqai5FuaDiLoN9zNqltNbwuIjgc5TyO5oWWGLzXxHu7FuMDvEsJ0O5GrQ2NEu1m
 bVlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788440403; x=1789045203;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ySykvbIWmO4Te6vIVwftEuMOLYpDg3lGaudbSYAL6eg=;
 b=oI4gSTLpTxXrnqcvUGy3E2gccx4lfjwO4SGFF1/05qs/B9FyDbpdZDAbuxo0EceBnP
 RzpsOteg8XKkuuEWr43vLP0ZimuK8YxXHdFjSrKxhtUXsy31U7FD+vO3vngZVdg/2TQf
 YnPPRF+U708bLVzJSVrxNEfAxXR9/56dgcgGHS579tFduCxz2gwknlKFZUeek/jfO7n1
 zk3H6UF2ntk3mW/70EAhM4CpFv1En6XUP0tdh/qjVRG9hBlZRn2zcH6MdotN6Xsz4Dcg
 KLourM9oF/+yiy1n1TM2ymL6ctB9EVjKaC5LW0+hFja7f0eGGJGbbI32aALowXXQcFig
 MazA==
X-Gm-Message-State: AFuF++nMxL1lUpIxa3YlJmO8gNj2H4jb02Uvi3p//sMsyQEqNPtdOTpg
 7bexoUbivjhYKPGh59tuQ7sr25i9v8x6DPDRRMrZcXEx1QIfLzmybj8D
X-Gm-Gg: AYBFou36lukkSHAJVbbW4SZBfq25F5heOoenxrhGi2ZGUOMhj2nEcZHJk5+gdoJ35SN
 FDmrDxnq1CQ4RWGCMyL6eMQpS64uqr3/Tf08m8j7Gn5KHHWWqYxkUIPUlS1vvjDcaF+WldY3iNd
 /sU77Rpcma51Jq/XSSpibuUpkXtEsLNM3JugchELMH7i28M+Ga5aBESUowKOznmaqoDc02mSPo/
 rGIGg1ec0jCJ+XY2KsdJUroXvD/JzmHJjinlQnHIhEibsNSNwHQzaflc8+C+MCWRwspRer1Dk1C
 lOnYOvGCIczcWvDsImxLIGvQqkvPNJMtEkTVCRzB5h0LqoNHDoFWjNDWHbKk/gHNOtVh2RMjsT/
 tqtERV5RpibSPxwtxbmz1X1T0nYK11OVDZWtXGSjyixO9ighiI+R7o5ZImLWx+g3fxwKC6+pJBK
 fD7eSp3CK4MenjoHhC9r/Nh9LsDc7AFe8xLYyf8TWl2v9JkFQzBvo4JwsyHMLtvkdL88A/GUtYQ
 9Ju4tsYyB6CTw6v1+8y9mJb
X-Received: by 2002:a05:6a00:189c:b0:848:4754:28e4 with SMTP id
 d2e1a72fcca58-85ed3895332mr17366905b3a.15.1788440403103; 
 Thu, 03 Sep 2026 06:00:03 -0700 (PDT)
Received: from qiwenjie-ThinkCentre-M760t.mioffice.cn ([43.224.245.241])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-85db23f7bccsm2980946b3a.10.2026.09.03.05.59.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2026 06:00:01 -0700 (PDT)
From: Wenjie Qi <qwjhust@gmail.com>
X-Google-Original-From: Wenjie Qi <qiwenjie@xiaomi.com>
To: jaegeuk@kernel.org,
	chao@kernel.org
Date: Thu,  3 Sep 2026 20:59:51 +0800
Message-ID: <cover.1788438786.git.qiwenjie@xiaomi.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Headers-End: 1x2733-00039x-4v
Subject: [f2fs-dev] [PATCH v4 0/2] f2fs: enable buffered RWF_DONTCACHE
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

Patch 1 marks dropbehind write bios with BIO_COMPLETE_IN_TASK and uses the
same flag to keep normal and dropbehind folios separate in the IPU and OPU
paths.  The block layer owns deferral from unsafe completion contexts.

Patch 2 passes FGP_DONTCACHE to the F2FS buffered write folio lookup and
advertises FOP_DONTCACHE.

Tests were run on a Xiaomi phone with 10.7 GiB of kernel-visible memory,
running Android 16 and Linux 6.12.69 with 4 KiB pages.  /data used F2FS.

The performance test wrote exactly 64 GiB per run at 4 KiB,
8 KiB, 16 KiB, 32 KiB, 64 KiB, 128 KiB, 256 KiB, 512 KiB, and 1 MiB.
Two counterbalanced rounds ran ascending normal-first and descending
dontcache-first.  Values below are equal-weight means of both runs; N=2.
The pwritev2() writer models the streaming workload; it does not show that
an unchanged Android application already issues RWF_DONTCACHE.

Android remained active with displays off.  Each run started after a cache
reset and at least 120 seconds of cooldown.  Throughput and one-second
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

Dontcache left zero target-file pages resident at every size.  Normal
retained about 1.19--1.24 million pages.  Normal runs incurred roughly
15.6 million kswapd page scans and steals per run, while dontcache recorded
zero.  Direct scan and allocation-stall deltas were zero in both modes.

A controlled explicit-dontcache model issued 64 KiB writes for 120 seconds
at 64, 128, and 256 MiB/s.  Both modes sustained all three rates in both
rounds with no final schedule overrun.  Between 0.02% and 0.41% of writes
completed late, with a maximum schedule lag of 3.3--6.0 ms.  Dontcache left
zero target pages resident.  This was a controlled model, not an unchanged
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

Changes since v3:

- use the common block task-context completion infrastructure;
- rebase onto the current F2FS development branch based on v7.3-rc1.

Wenjie Qi (2):
  f2fs: complete dropbehind write bios in task context
  f2fs: enable buffered RWF_DONTCACHE

 fs/f2fs/data.c | 27 +++++++++++++++++++++------
 fs/f2fs/file.c |  2 +-
 2 files changed, 22 insertions(+), 7 deletions(-)

-- 
2.43.0


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
