Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29BC0C5DF82
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 20 Aug 2026 07:14:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:Date:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=9zrU6NX6xV3Wn+kQAVrDJL46wV5156jVrteAsmv/dbE=; b=M9Zvlg0LJQkzp9q+spMs9bh7sd
	3gSJF1+OhmiNxRHxCa95eBvXqtJIepOqLt55xuFNZe5/oga3YtDLYI+Qp4uHMGGPTk1kecYnk143V
	0/cROOIgmo8bSogsTMu/Uzfb+JkGRlDCKOTlQMaycgm5+AyAb4tEvA/Y+pAsymiHF2cM=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wwwzJ-0004Gf-LB;
	Thu, 20 Aug 2026 07:14:55 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <qwjhust@gmail.com>) id 1wwwzH-0004GZ-Rj
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 20 Aug 2026 07:14:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=HD+vBOI5n9ykAmeyMyBKQKjVdYyrcIvj46PN/JmKGtM=; b=jArVpFdvXPksdmv+IGRRHUrFaV
 Ygh/uwf1TKOK9B9dag6++6Bc7UeBTtvKjq/cxGGLeiGnKOlF2GDADemBko70EdojLdtikZQMCq5s0
 L33FTodEEBXA7emOX3e37DYN6UKS5IlezR8QOX8MTZvs0tyfdbdSyUf6rSW/UdrN5BdU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=HD+vBOI5n9ykAmeyMyBKQKjVdYyrcIvj46PN/JmKGtM=; b=I
 kxr+pk0df/N0S3oYmr0ZwARuYI1GyxUfchUz33koKTfDn/mZBukVJ7PLFP+rJIWTFi2+Ua57skrk2
 Sw31/AGrA/lkUJ8a1o3AmaOwtGa2YmkS/z+aSghqAfVclmGyGRQixXaP2mhnUrhYRzUZBTDavj9vA
 t0EjDxKIif54nEHI=;
Received: from mail-pf1-f176.google.com ([209.85.210.176])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wwwzE-0003OL-Fg for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 20 Aug 2026 07:14:53 +0000
Received: by mail-pf1-f176.google.com with SMTP id
 d2e1a72fcca58-84a652535dcso1125626b3a.3
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu, 20 Aug 2026 00:14:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787210087; x=1787814887; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=HD+vBOI5n9ykAmeyMyBKQKjVdYyrcIvj46PN/JmKGtM=;
 b=DSr5d2moW31bxH6Zjlbicv+sG3nZhaVjsrE7owQavNJ3YmTnB77Nx9K8bUHNiQTTk+
 atyA2YS/IUfh1yXPyKpmW6UiokSx6++rE33yoXlkm9YW1teQpgzFAJAhj/Q0KiyyMGZV
 ltEWkieR1nxFPiaTGeSCMxKVKSMeWdmUDm8C5LtMHBRweXBzrkYSasgWUoUeZr9/FzhF
 CbB/k4q9C4GwG96K94Y+jZrEFBuTHW4HBYHjXXEcDF+QfFbzAFbVPZO/83QE9GLXBDwy
 JuVtinrDHwTSXnD9oMGrX7sOL27PDtJhcdE8efccImBClkYutk+nup4qAUdokOq/lA9+
 rFKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787210087; x=1787814887;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=HD+vBOI5n9ykAmeyMyBKQKjVdYyrcIvj46PN/JmKGtM=;
 b=dHMbG7zgwL7prnHnXk8Cl51OD021XmjS8ximJe55RnQRNuFkJ8pcyIoD9RJuLdOALF
 bZhc+rCFbFbcg9m9gPyr53OZyUsnvOKLroxIJ6zpOqVFx1Xy0WLUxeQb55CQUyGiHnDT
 Gf8H40seG6z4LRdOi825Wo69UFDpy/zdiGLB+SCtIuC1hKj1oNIUKK/EY4P1hAmbznaB
 KUbGQhxExzdGe9zLjU0O1DiaL5MW0CS5HkUrlOLWPYdyksG6a9MazJpxxXuTTmcqpHu+
 cpSUtILevEbLqYcDC2oiM8Gp7PXJO7vYdjZgXYFL8hVFObBUe6y+Refw24S751jKt1Cl
 axXw==
X-Gm-Message-State: AOJu0YzrHxWTzVY1GHpuyvtbF0Mdvcy9Yg6vIOYbLgoLMkAFWh9rvdq8
 lzkrIj+rIapEIhGFl1iwfBqqjohktoJeh2O9VpNZ3dGu1iJnAi26LBXa
X-Gm-Gg: AR+sD12338VpTUGCbawTg1hj0SYml8/sKzcEix2coHD+7N2uNemm/1Qrs6/1NZ0i08A
 4X23adIgUNu9TGLk9c9tHw1IrlOSanQIg/Xj3BQGrQy3GvVCN221Z5pJOjQD6fyeCb2L9eqdXbF
 lDUX7HpdpLghPJwVkZbfG8McGgY6QZ7ffV3occOEab+K5LvBWcZv1R/ogRmHXAwNX3Y95YEKuo7
 YZp6fENMXtQh+cmN/zEHOweuxWviPsLlebPLLphxa+ZTD6luB1VWOIBtd+3kpicXOfXXxWgokMz
 n2nq449ta3GXeRpyvlokz82b6JnLXyJmRriTqeRR1M7eTh3su1+s1fstl6n2RqftKPIvOPKlYEB
 KQM4a3HXiix9sIPOuD4kv6s1CHOA4SkxDSL/mmX7DkK/R1O4ziQojy8Q7wsOigxC7UZs14bqcDf
 oHVTYR/lhLjWEBfX8y3TDd3mSZMrZw+ODkOfTMdVSPYA/dsipZOmnw1iFXBcl0iOlhrFklQsE8m
 rzMCBqyXnEwxIGZaWfWClr0
X-Received: by 2002:a05:6a00:189c:b0:84f:b01d:3693 with SMTP id
 d2e1a72fcca58-851d39419a7mr16556367b3a.15.1787210086649; 
 Thu, 20 Aug 2026 00:14:46 -0700 (PDT)
Received: from qiwenjie-ThinkCentre-M760t.mioffice.cn ([43.224.245.241])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-851d36185d3sm1329116b3a.31.2026.08.20.00.14.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Aug 2026 00:14:46 -0700 (PDT)
From: Wenjie Qi <qwjhust@gmail.com>
X-Google-Original-From: Wenjie Qi <qiwenjie@xiaomi.com>
To: jaegeuk@kernel.org,
	chao@kernel.org
Date: Thu, 20 Aug 2026 15:14:36 +0800
Message-ID: <20260820071438.695893-1-qiwenjie@xiaomi.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Headers-End: 1wwwzE-0003OL-Fg
Subject: [f2fs-dev] [PATCH v2 0/2] f2fs: enable buffered RWF_DONTCACHE
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
Cc: qwjhust@gmail.com, qiwenjie@xiaomi.com, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

This series enables buffered RWF_DONTCACHE on F2FS for sustained one-pass
streaming writes, where retaining the written data can displace more useful
cache.

Patch 1 keeps normal and dropbehind folios in separate write bios and
defers dropbehind completion unless it runs in preemptible task context.
Its eligibility check matches the proposed bio_in_atomic() helper instead
of checking only in_task().

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

Changes since the RFC:

- match the stricter proposed bio_in_atomic() eligibility rule;
- add phone correctness and two-round 64-GiB performance results.

Wenjie Qi (2):
  f2fs: complete dropbehind write bios in safe task context
  f2fs: enable buffered RWF_DONTCACHE

 fs/f2fs/data.c | 59 ++++++++++++++++++++++++++++++++++++++++----------
 fs/f2fs/file.c |  2 +-
 2 files changed, 49 insertions(+), 12 deletions(-)

-- 
2.43.0


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
