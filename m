Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFDA7CD5BBF
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 25 May 2026 05:30:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:Date:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=EonpmTAJhDgsiODEi3BfuVt/W7foAduNtJuhNIXFb4g=; b=hJ2/ZE7WjgHwjfHFp3bm4XVaGt
	EMK/gLiwXhEfb5cHqLPTJlls5nKzOyEm4bgLj3Mv94FtDiTPIq7BnhdcEiJlXxodfGxj0T9Ej5E6+
	RwGpz2ulkSTKw7LCOpOPCU5DqifBVonjWGb42kj6pqkURSXHBEeOQT9Xq8RgAGcZNSlo=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wRNtp-0002Fk-6U;
	Mon, 25 May 2026 05:30:49 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <qwjhust@gmail.com>) id 1wRNtW-0002Dr-Ct
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 25 May 2026 05:30:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=mmULhzMqQgIJ++PNrW86VNXnjitDHbIlXJa6RMFWk4k=; b=d5cAOhzfsjXsPi8SXG+jrijgjQ
 yqB5ZXg2D3OprQ/ZGiOe9v/xFV+jKBoqbjFs0+cyEUtSEPMcXaZ5QrnCscXDTSD9c44zQwC1LcOMX
 ZQReDX+t9pj9ixIzAQYsq/VhaRLYXGymZDJG0e7IUM4d2i3XoM5jmDSbYC8EzrdOy+Bw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=mmULhzMqQgIJ++PNrW86VNXnjitDHbIlXJa6RMFWk4k=; b=O
 aCRZl/HwD8gxTg765WUsahZ2GKP5rqEYwOqHfCrZjWElNw0ZRbKtPe1F916l4uogbXlL9yWTeSCHW
 hKRdsqPZk9tG5EhgeM0vEPKsmrGpNi/bJdI6ucOQwyMmoITvb+olqmG0HYS9/kUlS9oo7hEvJ4Kcj
 OP0wMsLKOX/sK3/o=;
Received: from mail-pj1-f42.google.com ([209.85.216.42])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wRNtV-0000Np-3j for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 25 May 2026 05:30:31 +0000
Received: by mail-pj1-f42.google.com with SMTP id
 98e67ed59e1d1-369576666d5so4337427a91.0
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Sun, 24 May 2026 22:30:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779687024; x=1780291824; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=mmULhzMqQgIJ++PNrW86VNXnjitDHbIlXJa6RMFWk4k=;
 b=rqsxgyOrvvZ3nwIf3LUoSNTTFjgzslFvOg6szcQUQh2SLihlSbUH0geP7/fVFVBy0v
 RpHKdOPDQb3pV7mulsORe3Y5+2pEAANef7ahgBx/qFspf5+nZRYYwnK/3fKlL6IEF6gr
 dACwr7twdLvFi5x4Mo59U9kW+BuzJAxhvswUGVO352LqomBmRyVHJPsuNCZ2JSGAqXM5
 /rAlWOgdklZPuih/4RangkYX5EOXKavi05K3LgHA05FqhbaEGfSN+fuw2HuJUWAprwjD
 TIRI/qBLZ548YPfNsbWv0axVPGhqoZB9RM0idqPxhOHd2jPJZKlz11w7NPf8dMZPof0i
 D2tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779687024; x=1780291824;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mmULhzMqQgIJ++PNrW86VNXnjitDHbIlXJa6RMFWk4k=;
 b=OucaKt6n4hX1YYM3paMP4b1L1idzEN64TEqMVDWOJR4u+ri0duw3w7o5ntbU5x9qOv
 S25IdC8+T/L9vCkP04aXLIiS43x5emyDC2Ex97D4v9r5J4Lcr0xIz+VUTJDH10tgktJt
 ItywC0jDV/7Kio/1fEuUGJ6aJI2rSGu5lPaE7sOnOKda/m86zZiCLM2CQ9E4mm9Gfw7Y
 mKNH5VXM749xEuUxJMaqtfNnHLopUuRBM2khl/MLl/Mw3HvreyeO/A7CIqIpz5Qdimr0
 WnCztNQqchFLaXcxgV/b3COUZjpwqvSrzj2S6EX3bgVW4dbLORESAKGYygEMGcL5vtII
 uezA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+t/KqVOW8CxnMoxFPFqhrP21k9i0vpCEm7QpUd3URhSY647ASr7j230Z94XnqaB3aHUCn/94DBj0aA+xh19rZM@lists.sourceforge.net
X-Gm-Message-State: AOJu0Yx2hsS46D7luOdYb++u0UGIYgRSWi6pdR9B08adrZRqjO7/+GjW
 nrj9dQMGtsjug0aF1t/VFz55429ixxwUIcT0IoTWVjKJ8C2TlFPPbdNhUdvURJIL
X-Gm-Gg: Acq92OHb66NMBuOBDdSbWNkLjOccizYzBW10aCzfvBdEjKpgPS51S/OPQD+kaGpj4LJ
 ppRDkhtnzmoWSGCRO0ygGT6+QCIf0T1h285otzjsRy93k28DNI6DCS/Wb6utDSUhI8HE+rCtAZb
 Vlr58sIE/ifh1WUfZIGL/TP/dHJd3Zhbth5FKiYW+KLo1Js/RDoIi/78PRiUt7wjvL/g7FHdH37
 l/JwM7e0hEr6d+i8NSP0H3SzLL0SmfO/NRQvNfSZ95jXbT4jNCq1LuXNTV9lK8NM1zdD3lI51Kz
 e/mx+yCuxTcfH1Hhksmecb+tFAYwPDeJ8d7xjauqfHHYmQg5VE7h/IiIBixLm5FKNuHgd+vhMkE
 8HY/bfH4GJF2hwRLjVYHxe0Fj9dBjyvYb1C0TmiBe9Ncpzl4igP7mmgbOYhOkegq9qdvN4Rwh9Y
 lmDuU7rfyumbb9XT8ePbpW3dpTrl/iJw8qkAIy9csLJf2VwdyVCF7S9Pauzk4mEHBIwT8EBQ==
X-Received: by 2002:a17:90b:4fc2:b0:368:3854:3a2e with SMTP id
 98e67ed59e1d1-36a676d2e82mr14823899a91.26.1779687023292; 
 Sun, 24 May 2026 22:30:23 -0700 (PDT)
Received: from qiwenjie-ThinkCentre-M760t.mioffice.cn ([43.224.245.241])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-36a72c4cd92sm8554452a91.10.2026.05.24.22.30.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 24 May 2026 22:30:22 -0700 (PDT)
From: Wenjie Qi <qwjhust@gmail.com>
X-Google-Original-From: Wenjie Qi <qiwenjie@xiaomi.com>
To: jaegeuk@kernel.org,
	chao@kernel.org
Date: Mon, 25 May 2026 13:30:16 +0800
Message-ID: <20260525053016.169150-1-qiwenjie@xiaomi.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Headers-End: 1wRNtV-0000Np-3j
Subject: [f2fs-dev] [PATCH] f2fs: avoid cp_wait use-after-free in
 f2fs_write_end_io()
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
Cc: geoo115@gmail.com, qwjhust@gmail.com, yangyongpeng@xiaomi.com,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 qiwenjie@xiaomi.com, stable@kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

f2fs_write_end_io() currently decrements the writeback page counter before
waking sbi->cp_wait for the last F2FS_WB_CP_DATA completion.

That decrement can drop the F2FS_WB_CP_DATA count to zero. It can unblock
a concurrent unmount path waiting in f2fs_wait_on_all_pages(). Unmount can
continue through f2fs_put_super() and eventually free sbi while the end_io
callback is still about to evaluate wq_has_sleeper() and wake_up() on
sbi->cp_wait.

Commit 2d9c4a4ed4ee ("f2fs: fix UAF caused by decrementing sbi->nr_pages[]
in f2fs_write_end_io()") fixed one post-decrement sbi access by moving the
warm-node-list handling before dec_page_count(). The compressed writeback
path follows the same rule and documents that dec_page_count() must be the
last access to sbi when it can drop F2FS_WB_CP_DATA to zero.

Apply the same ordering rule to the cp_wait wakeup. Check whether this is
the last F2FS_WB_CP_DATA completion and wake the waiter before the counter
decrement. Then the callback no longer dereferences sbi->cp_wait after the
lifetime boundary. A waiter that runs before the decrement may observe old
count and sleep until the one-jiffy timeout, but correctness no longer
depends on touching sbi after the counter reaches zero.

Fixes: ce2739e482bc ("f2fs: fix to avoid UAF in f2fs_write_end_io()")
Cc: stable@kernel.org
Signed-off-by: Wenjie Qi <qiwenjie@xiaomi.com>
---
 fs/f2fs/data.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index d83a21998ec2..b1e9fb5ca159 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -392,16 +392,16 @@ static void f2fs_write_end_io(struct bio *bio)
 		if (f2fs_in_warm_node_list(folio))
 			f2fs_del_fsync_node_entry(sbi, folio);
 
-		dec_page_count(sbi, type);
-
 		/*
-		 * we should access sbi before folio_end_writeback() to
-		 * avoid racing w/ kill_f2fs_super()
+		 * Access sbi before dec_page_count() and folio_end_writeback()
+		 * to avoid racing w/ kill_f2fs_super().
 		 */
-		if (type == F2FS_WB_CP_DATA && !get_pages(sbi, type) &&
-				wq_has_sleeper(&sbi->cp_wait))
+		if (type == F2FS_WB_CP_DATA && get_pages(sbi, type) == 1 &&
+		    wq_has_sleeper(&sbi->cp_wait))
 			wake_up(&sbi->cp_wait);
 
+		dec_page_count(sbi, type);
+
 		folio_clear_f2fs_gcing(folio);
 		folio_end_writeback(folio);
 	}
-- 
2.43.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
