Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F953C5DF74
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 18 Aug 2026 14:55:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:Date:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=uqKKXs9xi6i9vtJfDglWekF9ilFJwHIb5iGKRE+pIhI=; b=Z77eKEn90UfUQ0RJFSoy2xxSNs
	4BNzYQ0MrJNPImvMMBCCbxMqzrPXE4l0ILtmHUSqKmUHJGqTXkct1ZTATM9Y/y7ipqOWUNFtQsRdz
	usMDwBFWzmZs5bBsDq3hZCG6Rydj5kg0OdkLWgXAE6LWWeEsATw7wP3/HST7A2lUHqgQ=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wwLEI-0001r5-Gt;
	Tue, 18 Aug 2026 14:55:52 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <zhanxusheng1024@gmail.com>) id 1wwLEH-0001qz-9o
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 18 Aug 2026 14:55:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=YsFaoS644NH2HkD0bh5kmr+46rtAuXi0WRjeGi4FwF4=; b=c/sBGvNo52S6ANJj51HlT08EBQ
 OACF07zYH2k133waKlL0W2Shj9crX/Gag94IcT3PjjMBWcmSKwMo1T52jdptu8Vf5+V0ZtoFJoGfY
 VNtL8v30g2vbip3uFbTe+WaQeGnK3BJEWM+hfVN8DIarUESP/quv/hecAJL80AY9gQFw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=YsFaoS644NH2HkD0bh5kmr+46rtAuXi0WRjeGi4FwF4=; b=h
 cmT1GatQZ1eBILiSVp/G3iEfUa0Kh30F3E4/3zITzeThp7jVu7/r7R9OJCHa9tpfvrIlC9oC1N95l
 QZEEf7g/37rnQUzhe2KwqPtUXypxByyCMmflni3BDFpRMX71NcWyEVhPEVjVigRcd9P84LU3QGd3U
 a4xAYtDKM3tSO1dw=;
Received: from mail-pj1-f47.google.com ([209.85.216.47])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wwLEH-0002rG-N4 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 18 Aug 2026 14:55:50 +0000
Received: by mail-pj1-f47.google.com with SMTP id
 98e67ed59e1d1-381c51fde6bso7634a91.2
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 18 Aug 2026 07:55:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787064944; x=1787669744; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=YsFaoS644NH2HkD0bh5kmr+46rtAuXi0WRjeGi4FwF4=;
 b=sd/8U0Sk4Gsv5zdumKwFNW1gL6x5CaeNjH/7mlWhg2E9+X084IpItRQLeDJJAPrLEb
 U4v7NMFz1JI9WrM/fbrKNjTf9VqEUQPllGo9O+doOaXKHcmJmXe5A07JqXBnJaOQC6gf
 y8RIOt2BqoG+2ZKGXi/9udnUOFnnZJBqpi4SNaA9uyJXCLWQIrhIx7kTiCo83AsWo2Gz
 XpeT0ma7GGUcRNRPBVjqfj4HNoRfCvRL+pEnqiugPoJhKyOF3sQ+Aa9+8hd01/1sL4Bf
 h60sLyY66VmFCcecsfmQ4Qc8SCQ2CwAqquSDr3bjPd75yIw/9yA0WLW4xDat7e6BtQK9
 NNDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787064944; x=1787669744;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=YsFaoS644NH2HkD0bh5kmr+46rtAuXi0WRjeGi4FwF4=;
 b=aDU+BnBRK8iDfuaArblhoDNZlUs+V5D9x+FyhnqhBJmJYttymVZ0kSySdIXROBrq7l
 YleGSCPnozSCLNwVyYOe4GWE/8PluNpkUjggb6fvSCfM9XJvgl55gqnXfJsSslO9Uxjm
 lct5vfJ8nlaIJLWpr5J8p5rBaOtejHfS7xE2VM6wwKXn+C2aiueL01JwbuVeVS4We79S
 d0jNOXcJ4EDx6QPUaYt3md9ifEwC2yYEVLT3Fs/uiZHpKpZUASzB5zXAmVYeDb6Y6Kkb
 RJR8X6cEIZMODWNIQDU2CexbTkcRlpUPWHX72h2pGAX+4UTUZM1UunEcT8744VUB8CZf
 UEiQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RoDIy0Z4w9Lw+klgJeLcUvtQ/JWEUII9q2UE+w8VdKHQkV16CcxLYqcFzQimLPdk6MrrfWWwZgfShclXJx8EJ6Q@lists.sourceforge.net
X-Gm-Message-State: AOJu0YzwO6qVmSX9tjiYa4MEeRewdWywP0pYkCodRAf/24H4MYOVGRZX
 gYsvcQtly+mujAYO88ptbjSOYGHFRVzkED84acGeDxwTMU2sfE3rEF2h
X-Gm-Gg: AR+sD10PU8tnHHnGnvH5RoV0SKz7SCdqVaX70ALrAcH+P52+CgCHew7xSOK/uVAusGW
 NWH7+F7IhRMCNCnqbdSv670ikdSayXTil4gogTwbi1acNlSvchYOdh6ia6fHjJnVgazgxTEdyVe
 pmwxmVjEwQVROpnesMWgfrxlqpA+GGRjZag2ONwtsv32sOFVteRSa1vvSyZbXo5GzuzzXoNzF/C
 OQ/t74nlJRUylNo+/+JalFYiPNwS4j6rvFoqZAq1c5WI0gRMPI9xgbQ4R62fB3P9rOje6C+1IbJ
 lVwUHfUKvdbWcLGA+nol7U/5swBlwzI2WZfb7hLiMKlRzcgu8Lfu7nBiKZ+nNEDpdZx4I0uBqkO
 hiW5RbeWmCTLZe9J25N7n4/bbij1LOqodcwbwZuLd4jO+yxaZ/RCYPjFh0r2Y6AiDdLWWsc6wad
 p8FeYm48gwoU9OhVLTAFrDHa00GTgI0jS1V3F7zZoJLP+GZ2y0ibY+QtYk9p0RUYTjgDmiIWyZe
 wX64zcOv5U=
X-Received: by 2002:a17:90b:17c5:b0:36b:bec8:94c5 with SMTP id
 98e67ed59e1d1-3933b874ad6mr34245555a91.10.1787064944280; 
 Tue, 18 Aug 2026 07:55:44 -0700 (PDT)
Received: from osman.mioffice.cn ([43.224.245.178])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39339d00eafsm7363740a91.1.2026.08.18.07.55.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Aug 2026 07:55:43 -0700 (PDT)
From: Zhan Xusheng <zhanxusheng1024@gmail.com>
X-Google-Original-From: Zhan Xusheng <zhanxusheng@xiaomi.com>
To: Jaegeuk Kim <jaegeuk@kernel.org>,
	Chao Yu <chao@kernel.org>
Date: Tue, 18 Aug 2026 22:55:35 +0800
Message-ID: <20260818145535.449055-1-zhanxusheng@xiaomi.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Headers-End: 1wwLEH-0002rG-N4
Subject: [f2fs-dev] [PATCH v2] f2fs: fix i_size when pinned fallocate
 partially fails
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
Cc: zhanxusheng@xiaomi.com, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 Zhan Xusheng <zhanxusheng1024@gmail.com>,
 Sungjong Seo <sj1557.seo@samsung.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

From: Zhan Xusheng <zhanxusheng1024@gmail.com>

From: Zhan Xusheng <zhanxusheng@xiaomi.com>

Commit 4275b59673eb ("f2fs: fix to round down start offset of fallocate
for pin file") moved the allocation loop's start down to a section
boundary, but the error path still converts @expanded against @pg_start,
which holds the unrounded start.

@pg_start exists for that conversion: commit 88f2cfc5fa90 ("f2fs: fix to
update last i_size if fallocate partially succeeds") added it as an
immutable base because map.m_lblk moves every round.  Each round now maps
exactly sec_blks blocks starting from rounddown(pg_start, sec_blks), so
pg_start + expanded overshoots the last allocated block by
pg_start % sec_blks, and a partial failure leaves i_size covering a tail
that was never allocated.  Nothing corrects that afterwards either, since
file_dont_truncate() has already cleared FADVISE_TRUNC_BIT.

It needs a start offset that is not section aligned plus a fallocate that
hits ENOSPC partway, so the error path runs with expanded > 0.  On an
80 MiB image with 2 MiB sections:

  truncate -s 80M img
  mkfs.f2fs -s 1 -f img
  mount -o loop img /mnt
  touch /mnt/pinned
  f2fs_io pinfile set /mnt/pinned
  # 2093056 = block 511, so pg_start % sec_blks = 511
  f2fs_io fallocate 0 2093056 536870912 /mnt/pinned
  stat -c %s /mnt/pinned
  filefrag -v /mnt/pinned

The last extent ends at block 10737 either way.  Before, i_size is
46075904, block 11249, so 511 blocks of it were never allocated, and
filefrag does not mark the last extent eof.  After, i_size is 43982848,
block 10738, and eof is back.  A kernel from before that commit also
shows no overshoot.

Keep @pg_start pointing at where allocation actually begins.

Fixes: 4275b59673eb ("f2fs: fix to round down start offset of fallocate for pin file")
Cc: stable@vger.kernel.org
Signed-off-by: Zhan Xusheng <zhanxusheng@xiaomi.com>
---
v1->v2:
- Added the reproducer and the before/after numbers to the changelog,
  as asked by Chao Yu.  No code change.

v1: https://lore.kernel.org/r/20260817022723.3324123-1-zhanxusheng@xiaomi.com

 fs/f2fs/file.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 4b52c56d71f0..cc0d2b8c4684 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -1919,8 +1919,9 @@ static int f2fs_expand_inode_data(struct inode *inode, loff_t offset,
 		block_t sec_len;
 
 		if (map.m_lblk % sec_blks) {
-			map.m_lblk = rounddown(map.m_lblk, sec_blks);
-			map.m_len = pg_end - map.m_lblk;
+			pg_start = rounddown(map.m_lblk, sec_blks);
+			map.m_lblk = pg_start;
+			map.m_len = pg_end - pg_start;
 			if (off_end)
 				map.m_len++;
 		}
-- 
2.43.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
