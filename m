Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D14DC5DF9C
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 24 Aug 2026 10:51:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:Date:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=7iDm65NhN8GBL2FxbC5KDJAUu7Mv+UtZe8+5y8wPSG0=; b=J7Z+7QzlcO0h8RnuCFbgFjJ/ue
	6XmiDnxFt4S3lfhEQuCLD9I10JadT8FifivmR6KpyQ6JHhMKlp+M0UuiTA9fg9EmoNya5YT0Q7q/O
	AG1VFpqZO6M7P+xcgju3N6mpCq/uqSrA+z9xNwRu/CAoqqOFa9abETOyAq9mNqgoobmE=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wySHS-0001B7-Iy;
	Mon, 24 Aug 2026 10:51:52 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <qwjhust@gmail.com>) id 1wySHR-0001B0-Uw
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 24 Aug 2026 10:51:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Hwg8I9FGGaPyCRZafajo/C1yc24hPoJL28iTZHOv5Gg=; b=B7+m39mZdUpXPLdH6HZLDwMiRY
 gNvnFsJSxDn9jINy/9Wlu3Z3nGkJ3qqgCn11Z1Ru2ig4JxVrjiTJ22BHmLfkmvWNAoJ3hD0sLVQ2S
 Mdm7PyS0gz1h4knIq78q8pxoVEn0Bvj/xH29rF8IoSw01YYl/lfmcp1ExDAO/OXO0xVo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=Hwg8I9FGGaPyCRZafajo/C1yc24hPoJL28iTZHOv5Gg=; b=I
 ZqtikIQq833U/2tp2B+m0DZUEHwSNLC8l45LpMS91eKXX/xOMuB7uhlRb5DhTcNbI6EFTB5MFv4YR
 FVRUQVlanv9wlReePTrcfU5TZFztTLsHHYAys2+gLJUJLhBllNnv/G7l9M1v4u8NtI/7ur68ZANGm
 Gz/Ob6bY/pIZ3Edg=;
Received: from mail-pl1-f171.google.com ([209.85.214.171])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wySHO-0005GP-5U for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 24 Aug 2026 10:51:51 +0000
Received: by mail-pl1-f171.google.com with SMTP id
 d9443c01a7336-2ceab75934dso44837625ad.2
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 24 Aug 2026 03:51:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787568704; x=1788173504; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Hwg8I9FGGaPyCRZafajo/C1yc24hPoJL28iTZHOv5Gg=;
 b=cIHdoCCu2Jarr+664jYWrt5z0bcC/BNz7Cv6oL8Uh4LgfQviXYieXh/fOMm5cmG0FD
 DyF77dngmRnCv0G/B+xQcqp15uVLuZ60jgtMaOft119v8D0wDDwidd1N0h7pvL1JZ25T
 OX3jJ8c0LcwyfCdT6e+CyoKH36kYp1GtMH2AF8Mfh1vfgWbJvH5kKnBZn6IvenMqOC1V
 ZhyyxLMyY5Gblml8ESB8uv0z01jswSAEPz/90KSM9H3x/ztg7Cgjya9P5pE0LDTM6Z0j
 v80s1q3eI5YqT3mEuZN/xxbyhjPdqzhUsLDtb3JpzlkGc1/z31IA0ri2YxApCeWOVXlt
 9mYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787568704; x=1788173504;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Hwg8I9FGGaPyCRZafajo/C1yc24hPoJL28iTZHOv5Gg=;
 b=LpBhDIcFgBAnBrwArB4YjZeMvzS2uhR5twjXfKmMQFA3bQFOwwmhlDHilr6OlNVffL
 uVs/6h8J4gN+eRkhN6O6wUDhZxrskcVxjQRFPIJzr0E6bf+9425Oh3B7zhgd33GlRJxn
 oIsAg9y3ebF/KuB3pooZQqdc1SX64JDI4ncFOruv93bDf1ZUrzFgZZ4wKTNtRaeh21bG
 BeJm+2TEgpoE8RoQFuVHwtBjEV+Wj1t0V+SMr0xPJVEqKKmLYkFRF08GCc3v16AstkR8
 dfzrbV7Tjze6vHD/E9q8rc8MDxzEhE/bnvI0vqYOXUgsnkspuJl4sduf6gZUwc3+xmaM
 FHaA==
X-Gm-Message-State: AFuF++n/eqMdVEfw23huhhauk1Rh/fQXZFncwY5DaH5ovmAC58eIXMUl
 EDnax6OI11xHQ4pBkotmitN0DlqkzI7xCuVBvTkF24RPWAWJwQp7CQ0+
X-Gm-Gg: AR+sD11od1ek/HHqCJYiEh8hUh+M4kF5vkrTJQeXRNGU0OuochUCahIBwzNGE7vAgYd
 3rKYq33J6qaymmahIx3WaiGFY3r5t0cObs/t52h1NBAWbui2uNiYqO+AhByEG8w6IH76r/7yztg
 y+omtEz6zAfb+lmEse0y/CS4UK2mXiQOLoLO0iN+TLOCBaNp1jNNsiv32k7WbTQjkb9AtOwZiYm
 vX2Ym2ySMJZWHrz7y1doS3QhvyNSvhTB63oRZQRZaSf0IunqZr3y9+wpwsp9SVoBVhFM4wnepzb
 fk7oBy3LqFDdEdukpADI7mPv6uCI7irmGEVNh/XASDf0SGqU4uYa5qg1VldG49harzZiacrr6j8
 fAgdkSMnmsCYKHvnFSk7oXaAEt6obMkTaJTzUD18vhDlVSGpFBgsE3jThbZd2BHw3wNOK3FYVhw
 HUmVAm2YHEp0bPmv5GL8WhfzkWALN2pmHlxAAOOev3hFBSn3h89DpjctpIQ6u3Ja4qYle5hkqD7
 syDIydYeW2CgfCKlI1Yy9XE
X-Received: by 2002:a17:90b:5706:b0:38f:de97:b06 with SMTP id
 98e67ed59e1d1-395deea4a72mr33464796a91.5.1787568704301; 
 Mon, 24 Aug 2026 03:51:44 -0700 (PDT)
Received: from qiwenjie-ThinkCentre-M760t.mioffice.cn ([43.224.245.241])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-395e4af6e88sm9708996a91.9.2026.08.24.03.51.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2026 03:51:43 -0700 (PDT)
From: Wenjie Qi <qwjhust@gmail.com>
X-Google-Original-From: Wenjie Qi <qiwenjie@xiaomi.com>
To: jaegeuk@kernel.org,
	chao@kernel.org
Date: Mon, 24 Aug 2026 18:51:35 +0800
Message-ID: <cover.1787568046.git.qiwenjie@xiaomi.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Headers-End: 1wySHO-0005GP-5U
Subject: [f2fs-dev] [PATCH v3 RESEND 0/2] f2fs: enable buffered RWF_DONTCACHE
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

Resending v3 as a new thread; there are no content changes.

This series enables buffered RWF_DONTCACHE on F2FS for sustained one-pass
streaming writes, where retaining the written data can displace more useful
cache.

Patch 1 records whether an F2FS write bio contains dropbehind folios, keeps
normal and dropbehind folios in separate bios in the IPU and OPU paths, and
defers unsafe dropbehind completion through the existing sbi->wq.

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
rounds with no final schedule overrun.  The late-write ratio was
0.02%--0.41%, and maximum schedule lag was 3.3--6.0 ms.
Dontcache left zero target pages resident.  This was a controlled model,
not an unchanged Xiaomi application.

Read tests were unpaced.  Each run started with zero source pages resident
and read the same 64 GiB file sequentially at full speed with preadv2().
Results from two counterbalanced rounds were:

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

Changes since v2:

- keep the implementation unchanged;
- add paced-write, unpaced-read, and normal-I/O control results.

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
