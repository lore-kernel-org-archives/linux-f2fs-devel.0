Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5AB8CD98DA
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 16 Jun 2026 13:57:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:Date:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=dNmw9UTr1CienXgEqVfw2sUlitH3L27HD7Lp4q6M+xo=; b=Nffto65xRaR21QTO0ouFppaoAX
	7oSsAQyi5tD4k5c1xMyb1ST1OwEDWifcAJQerd0l4AiW0EaizRMv6kI3AC0Xy5opNxctzsSRUxSL/
	crGtmImuQi8HioyCeZSV40GqjGD+mFy4YzKZ1TU/CAaHO9rbC57f39BZ+9+r8HQTYg2I=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wZUHu-00072b-AC;
	Tue, 16 Jun 2026 13:57:11 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <qwjhust@gmail.com>) id 1wZUHc-00072B-Bg
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 16 Jun 2026 13:56:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=4/yKpIl7fnTH/Z8cujrZ2kgityIQr3NnutG1Y8WhoW4=; b=JMwhJXBosFdC8QJDbDHt9pnFnD
 O3lkqYP+wn1yuFI94r0peghbNT2BdGJtMzypNAU+ETo6UZs5mzKFW5Xa9Av9lwMWgHAeMtmSxdg5S
 8yWNvBHhl/xDIOxW3MzqLZPZse4UM/kcm+1abtthz+QmQ/gGgSFrDwasGSzTXZ0Nzm0s=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=4/yKpIl7fnTH/Z8cujrZ2kgityIQr3NnutG1Y8WhoW4=; b=M
 DjqpCRSB8nu3QVvL7jy3aqh2nTTPmHzbfQTpUlDC3UD7gjIWSbSbeeZrJzhtMForTJh+ZXejtFYV4
 VnmwV9HpwPnOb+aoSQeJBpAgY90u6Renc1cHBCLD1DHxgAFiyyvpBf7bjeRdeyIRiRt6ZUqH+WyYq
 NGcun2B4IDkGE4ZY=;
Received: from mail-dy1-f181.google.com ([74.125.82.181])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wZUHc-0002Pn-97 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 16 Jun 2026 13:56:53 +0000
Received: by mail-dy1-f181.google.com with SMTP id
 5a478bee46e88-3078e0dcd67so4813227eec.0
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 16 Jun 2026 06:56:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781618207; x=1782223007; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=4/yKpIl7fnTH/Z8cujrZ2kgityIQr3NnutG1Y8WhoW4=;
 b=AbvJ/Urh4NWYxy+Me35ToXzglNtc3RqnKOGoRa9IqZ2cDy2WkUixZuRqhQjmRzTwYx
 /7AZfRKM2aqmbIAOfnLIt9EwYVIQz55DDVQbxHf8VBDYuaxIBjD9WHvREU/iC6/DmIke
 xvZyRrj+lgePGpgBIvgrytPHxIcr4LbFyGdQeqP5rqo5krHbre/4CpT/LVPkUUgH6S0e
 l0u5+IPT2cwkn60BPwKf6q6p4/UOsQboYqJjsx6+537h7MfORLVVucMtyYYTQTNlqiPQ
 +9oBFT/aUGA6AmwgsuzH7Wsn6+mEagcURd02XnbKg1C7K3uCINBuabWBXmRZ14BCkXNm
 79bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781618207; x=1782223007;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4/yKpIl7fnTH/Z8cujrZ2kgityIQr3NnutG1Y8WhoW4=;
 b=sUXGvTvnBez4ucH80/1L7k4oIpEVpDr2wIPUtSRzQL0OnAZWY6PlMdvnMzPmjZQr8Q
 JPQFhzNK1nYfxKnNOWsQzNujKps24yA7A1DPna2XaoJbk/QOTe/sixLGcbo0yYGK9FtU
 Kggp4y8pOlqwrMYMnedeGbMCONoHythmF2gy5Pw4sHCYm/hlk3ilOEuzbgbq0p/4ESk+
 LWgR9go28CllKRUn6x6eP+PjBepaxqKuSAQAyTYlJYxV5qnJNQy+nqcGYg9m/Wv1MpCj
 6hZ+e5W90ZkcQw+swPylkG4M8eA909N1MLFyR+R4DcSNBvIDSxCMv+R5m4KPziptUgr2
 UKqA==
X-Forwarded-Encrypted: i=1;
 AFNElJ9X4cS4/leZvA2CAo/3/7XKk+qim7NSsnSfpzoNsFD8OAbGByibVhX/9HiFf5Asz6kuoxNCcCtlgv/iYBjHuoMl@lists.sourceforge.net
X-Gm-Message-State: AOJu0Yyp5Nm3i6ch++4/RsWqhWDE8l5GFGL6Gjzln9qXN2Pm9r6/4KDT
 VzahSj90qBQnMAU9rI68mWYg9TOiFE4Oc+ZKNDD2DZh2J+AO4Q/r3r/E
X-Gm-Gg: Acq92OGjum6LXd/tcs/UdlyjSZ/asFp4ICSXMEH4ZDFd4BaDtqvHjKEOsvXFAz/P7HK
 +WGzICQ1PewkgJXoPX1mIoEiCw4UMH4xKE/l4c9tF3CtB35xdTITd/TC8iGtCuV9Tym1jpec7Af
 DWiio48tpaCH1R19FzY/cyRYm+RmADMI9lJsGM6gof37dOu0KiQfgoKJ00QrM55HCk63+mF6xCI
 T2mZIPdeJL7juq/xn7x3SWOCe4+nlARMuQmiRt2NQBVKsHxnpiGWdKdKVGpGK2kmbhyNKxJ21i3
 Xb7VXNooOu2tmFCk+uM/GI/6Btyeyi9W/v2VkgZTl5d7X6TmzDAPGuniO5lvxwhzktTvCo2iFtm
 hZbrod00uM0+EHmHvxKpbgy+C+TOjtz5kclOwmDg7xRPmxHCw00ZRe/Ghx98Y4Rb2eH18Knyuyw
 PdpZzedJJ3hTwt06KGt5S4k/gRlJScQNMLa1yaq7PxTs/TfifSIg6cMFfTnmM=
X-Received: by 2002:a05:693c:3945:b0:307:91f5:93f7 with SMTP id
 5a478bee46e88-3092b94dc86mr7904991eec.0.1781618207060; 
 Tue, 16 Jun 2026 06:56:47 -0700 (PDT)
Received: from qiwenjie-ThinkCentre-M760t.mioffice.cn ([43.224.245.241])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30bc1e2bd13sm626947eec.2.2026.06.16.06.56.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2026 06:56:46 -0700 (PDT)
From: Wenjie Qi <qwjhust@gmail.com>
X-Google-Original-From: Wenjie Qi <qiwenjie@xiaomi.com>
To: jaegeuk@kernel.org,
	chao@kernel.org
Date: Tue, 16 Jun 2026 21:56:37 +0800
Message-ID: <20260616135637.1439319-1-qiwenjie@xiaomi.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Headers-End: 1wZUHc-0002Pn-97
Subject: [f2fs-dev] [PATCH v5] f2fs: use post-decrement count for cp_wait
 wakeup
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
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, qiwenjie@xiaomi.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

f2fs_write_end_io() decrements the writeback page counter and then
reads it again with get_pages() to decide whether the last
F2FS_WB_CP_DATA completion should wake cp_wait.

Use atomic_dec_return() for F2FS_WB_CP_DATA completions so the wakeup
decision is made from the value produced by the decrement itself. Keep
the existing dec_page_count() path for other writeback counters.

Fixes: e234088758fc ("f2fs: avoid wait if IO end up when do_checkpoint for better performance")
Fixes: ce2739e482bc ("f2fs: fix to avoid UAF in f2fs_write_end_io()")
Cc: stable@vger.kernel.org
Signed-off-by: Wenjie Qi <qiwenjie@xiaomi.com>
---
 fs/f2fs/data.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index d83a21998ec2..58d23eb74ec2 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -392,15 +392,17 @@ static void f2fs_write_end_io(struct bio *bio)
 		if (f2fs_in_warm_node_list(folio))
 			f2fs_del_fsync_node_entry(sbi, folio);
 
-		dec_page_count(sbi, type);
-
 		/*
 		 * we should access sbi before folio_end_writeback() to
 		 * avoid racing w/ kill_f2fs_super()
 		 */
-		if (type == F2FS_WB_CP_DATA && !get_pages(sbi, type) &&
-				wq_has_sleeper(&sbi->cp_wait))
-			wake_up(&sbi->cp_wait);
+		if (type == F2FS_WB_CP_DATA) {
+			if (!atomic_dec_return(&sbi->nr_pages[type]) &&
+			    wq_has_sleeper(&sbi->cp_wait))
+				wake_up(&sbi->cp_wait);
+		} else {
+			dec_page_count(sbi, type);
+		}
 
 		folio_clear_f2fs_gcing(folio);
 		folio_end_writeback(folio);

base-commit: c0b65f6129c7fbb526e921dd60261650f1b2bef9
-- 
2.43.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
