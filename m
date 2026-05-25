Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B55BBCD5BBF
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 25 May 2026 06:15:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:Date:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=ACE/GACtwtHmg3GvmcXqs4eEzhB2bi0vFjR9OBR4I6o=; b=goyha6B8wnpBbIuDJ2wFooJkn2
	0IjfPmGUf4ZrEGeULGeGTxc/h0ZGTMSE+Y+1PB18qfxtyzcavDABZ4gCsyVHmowErCaZkpFn6bYml
	6ChXCb+RQ8iIxwwiiQcO2Ngj4eXm34akq/vVW9GyOb1P7feEm8PTZZ8JVsvPmqK/L4tE=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wROay-00029O-Eu;
	Mon, 25 May 2026 06:15:24 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <qwjhust@gmail.com>) id 1wROao-00029A-J7
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 25 May 2026 06:15:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=e524VIBtCoTvqSRyApwFpsXYxkWr/qEm71Ha8pUe2kQ=; b=WjsPjyvHiY2YAUmzAyfhY/k9Cy
 tmupO22WP3FlzZHauE8HHfhQ9BFwbbEsmpJTUbGDG71xf0jvhyRlAutK+sYyL/fPJHuukTLYDjQlW
 a4y/cMGW55ZrKca7/0VPf7lGW6aweb4H9gIcr17U+5ucwVV3Ba7dwUDJX7UXCHMp4V08=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=e524VIBtCoTvqSRyApwFpsXYxkWr/qEm71Ha8pUe2kQ=; b=Z
 Dg11XtIy7b6dXpZDHDFtWi1RG8CZXnhiEy6NLjlWbO+yEIgmdZ7C3gNHeO5uDsg2qC+tO+Yicoq6Z
 TUZ8+yTuuxnbYxuwPtaWhClnDSQK8nnLmcv7/urDgaO5QhUrRLsZgcRywOgHhDufX2Rqir7qo6ktB
 XNxwvwaDSsM8hpy0=;
Received: from mail-pj1-f46.google.com ([209.85.216.46])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wROam-0003zv-Sh for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 25 May 2026 06:15:14 +0000
Received: by mail-pj1-f46.google.com with SMTP id
 98e67ed59e1d1-3664df30f53so5505673a91.1
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Sun, 24 May 2026 23:15:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779689703; x=1780294503; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=e524VIBtCoTvqSRyApwFpsXYxkWr/qEm71Ha8pUe2kQ=;
 b=W87+INaSKmehVIs8HlTKE3ui43grbii5SKEShdMp/GcXvkxsrapyR479womTRrhVAN
 Ae7Y7P+uYss1R6SNXQvqMNFKTuS6P/7lM9bgPSst22v2xD8jIHDps02at/0dQXcrfa3N
 AaALQWsNv3vBZPosuIJ6jnlwYsYPWA66mVnkoeE1hASYaXxJCdjZASslL4u57JldPcvQ
 I/lcFijKIM6ZS3l6pA4Dm9CHqGab935oRwem3hn3xCnSwT0TUp5ZK9H3cBtNDzgEwo4e
 VxMAi8DCPdhYYd+VwJqOmB3JLkt0q/nm0UxWJO4VHYFLMPis5tWlBoCzWLSOTd99+rnQ
 DmRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779689703; x=1780294503;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=e524VIBtCoTvqSRyApwFpsXYxkWr/qEm71Ha8pUe2kQ=;
 b=mL08QMhZ493x588fb9MRPi//81FeZb5teAkJyr5VbitzFNXATqktW6MmMWt4zMQ/qY
 NrkxbBM4bf3eLaR3kH7HkYARXP682qAUd2yEnYNs7iL3NwBURvPuPVSsuuXYoOh2lK0+
 LH3E5nEYa7XaDtKewwrKcC1U7xiIML9dqskia3f0XRCO57Wsw9PEXxN0c+CD11CVZk7E
 8jZFVlFJjPPF+WccGlKoHkXceniEWMDsqiCN6EnNqztCP6Jq3C/epywK0XOUiZDZFimi
 ve3hEl2lDgwxhR2ZRj8vauJhbxqmfuk8cS96S/Tn9Ojr7zTSjHClwkCx2AR+Idmn+CTh
 Aw1w==
X-Forwarded-Encrypted: i=1;
 AFNElJ+zzH/54FC0u/YDEIhiVR2rxs6bMeY7fobuzsu8otwU1UdGqqbjm9e5eFMcNtaVIS+qr/wpZiNgqSitvgPdXKI8@lists.sourceforge.net
X-Gm-Message-State: AOJu0YwBOhgH24rVgt0xfoNlCfYr/ZBV0otCoyaEbHe2iPCuOVMWpEBR
 DSwhrp0a3Ap2jd7JSvm0xxj6HlIdv3vMvtWukx4vH68JFvIZkPDb9wAz
X-Gm-Gg: Acq92OEXjRVQkWIY9A3nYNo7FzJhyqeiQfqSvpJsQhlUSz1DxrYIFUlaH6GKySOi1LJ
 pn9ggI2sGFXe45LRpSWWciOkgag8mZk60ium4i8hmn1zCvVGVU/g2oQgcJQP4Ymnit7HcHvWYul
 G4J1G1ri320O8aAr/PnOyo4ydxINRkNd7JmaLPgK9hBt5/4CZj8FyvAZiaybENKyCXGK3vYSt4I
 jT88Tgi5ArPU0uMZkcdhBr/5XT0bo7Qp3TBvo9b/kZh74lug5kiA0ayeCu+KgbLjrJzr+Z0/MWX
 gFaX3x3a0lunG20IjoqqtsVHChoxkYderraZKUIDOw9nlXf61+GEAxFFskXrd863e3FiQ2PNyrz
 5yGwb5VmKvTCIke6Qu7v8YSnaSRauoa06FvlmXiKs4y1+MM+rGD9LHQef353GeJT4lo+8WHEP9C
 ZC6wn1SiOU8DrqIjo/gsXh+hUbgX3UYxUt15ubp+JPWvvKsaG1xjmcaeFmVRe34uTXT6Ax5g==
X-Received: by 2002:a17:902:f546:b0:2ae:ce35:2686 with SMTP id
 d9443c01a7336-2beb033f57emr145382605ad.5.1779689702651; 
 Sun, 24 May 2026 23:15:02 -0700 (PDT)
Received: from qiwenjie-ThinkCentre-M760t.mioffice.cn ([43.224.245.241])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2beb58b3058sm85611535ad.39.2026.05.24.23.15.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 24 May 2026 23:15:02 -0700 (PDT)
From: Wenjie Qi <qwjhust@gmail.com>
X-Google-Original-From: Wenjie Qi <qiwenjie@xiaomi.com>
To: jaegeuk@kernel.org,
	chao@kernel.org
Date: Mon, 25 May 2026 14:14:56 +0800
Message-ID: <20260525061456.231710-1-qiwenjie@xiaomi.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Headers-End: 1wROam-0003zv-Sh
Subject: [f2fs-dev] [PATCH] f2fs: stop checkpoint on compressed write IO
 error
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
Cc: qwjhust@gmail.com, yuchao0@huawei.com, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, qiwenjie@xiaomi.com, stable@kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Compressed data writes are accounted as F2FS_WB_CP_DATA because they
write compressed pages through fio->compressed_page.  Their end_io path
should therefore have the same checkpoint-stop behavior as ordinary
F2FS_WB_CP_DATA writes.

However, f2fs_compress_write_end_io() only records -EIO in the inode
mapping when the bio fails.  The filesystem can keep checkpointing after
that failure, so a later checkpoint may persist metadata that points to
compressed data blocks whose writeback failed.

Stop checkpointing with STOP_CP_REASON_WRITE_FAIL for failed compressed
F2FS_WB_CP_DATA writes, matching the ordinary data write end_io path.

Fixes: 4c8ff7095bef ("f2fs: support data compression")
Cc: stable@kernel.org
Signed-off-by: Wenjie Qi <qiwenjie@xiaomi.com>
---
 fs/f2fs/compress.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
index caf522d667d6..9b1501004456 100644
--- a/fs/f2fs/compress.c
+++ b/fs/f2fs/compress.c
@@ -1488,8 +1488,11 @@ void f2fs_compress_write_end_io(struct bio *bio, struct folio *folio)
 				f2fs_is_compressed_page(folio));
 	int i;
 
-	if (unlikely(bio->bi_status != BLK_STS_OK))
+	if (unlikely(bio->bi_status != BLK_STS_OK)) {
 		mapping_set_error(cic->inode->i_mapping, -EIO);
+		if (type == F2FS_WB_CP_DATA)
+			f2fs_stop_checkpoint(sbi, true, STOP_CP_REASON_WRITE_FAIL);
+	}
 
 	f2fs_compress_free_page(page);
 
-- 
2.43.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
