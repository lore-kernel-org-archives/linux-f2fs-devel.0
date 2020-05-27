Return-Path: <SRS0=Qzrr=7J=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 937AEC433E0
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 27 May 2020 04:03:05 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6084920776;
	Wed, 27 May 2020 04:03:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="H2lGh73c";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="A8Rno5JV";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ea5b/yOr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6084920776
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1jdnHU-00039E-40; Wed, 27 May 2020 04:03:04 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <daeho43@gmail.com>) id 1jdnHM-00038a-Hr
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 27 May 2020 04:02:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=DyZwm58RJro1kic/9IoyyoaUkdPO3Lyg3bl6Kx/XiJU=; b=H2lGh73ctiz1FkGzi+sfF54+96
 GETVCca0Vo3w4/7XjGVglNeOu/wolh7VbyMRd//Pe+ciJhDA1f5aKJJznkMoxH0646HqJoT0bJ6/m
 qbzq8yaHkPA16iHkT42WlN9eyUMzjkYvlp8KH43XfUysUzleHqF8KkAoJJ37BheWUjYk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=DyZwm58RJro1kic/9IoyyoaUkdPO3Lyg3bl6Kx/XiJU=; b=A
 8Rno5JVClzvA59RU7uJxYksM0p2t65qhNhbVKLGxmKJ9z2fiyJjZXr1RpA+HvqU8pyp9gOQvYswv8
 4gCb+EJ7cNbKUNwUZd/3Yeyklckc71Xg24wfB9HDdZkfh+0spcEiRpBCNib6H2XgAUk/lDgQTuT5e
 /dUI+gvmO3slMRbw=;
Received: from mail-pj1-f68.google.com ([209.85.216.68])
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.92.2)
 id 1jdnHL-00EN4T-4c
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 27 May 2020 04:02:56 +0000
Received: by mail-pj1-f68.google.com with SMTP id ci23so892795pjb.5
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 26 May 2020 21:02:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=DyZwm58RJro1kic/9IoyyoaUkdPO3Lyg3bl6Kx/XiJU=;
 b=Ea5b/yOr0ZEjDMlwSBwK+l5ZsIJ+PqMFEO5MA6TfdyDCcSENA+WOIflT3B1Cw10fPh
 5sYGtgm8uMBE1czEC+5Q6RLS0zaBKiqdE9iidYWuF5MzBuNa/zGyLan6r6Yj7JOAul0o
 8oxwT7bfUiv3s6hXNHqdx5Ww8LPIN2YGVVH1uF/Gcdf55Yl7252/xsI9umtSJKpEQVYF
 ur+ZElsaZjcmPCG9nvmfFaIsBCOoo1mhZjc+RxnXlWXAb2ojz/40Kn7cb2Jfe1RI9VPG
 UHwdBSuDqL3qhWbxHm9NMp3VZaSxzFJps7F/tY/jhPTW6pSWbxUw9m1Zu4Nw2QmiFX2n
 6GRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=DyZwm58RJro1kic/9IoyyoaUkdPO3Lyg3bl6Kx/XiJU=;
 b=CZCJct0JAs4v5XgY09wqA3hZGevcUKF9Y5aaJmJa2cHnlkuCIO9kwt7yvyUIpSqQbp
 fFdRy3gLaKq1j4xxeWWY9XLsPiqHbKt26bE2iW+PYgCHBVHNoBdsQT90RzglmozjKYBK
 9Z5hYpJh3S7YbBxGQtQjX2gEcqSKefwNXJiOk/0ttIuKbFh73fpeha7t8hhibykejU7x
 3dosrdUzR2t+F4ZNSmbg2qZ0GrmKoiHxo2aZEQ6BEQtU489hCCwlvaqZK0JFBBkGnS8q
 DaQXhOhqMMvBMM9XONWz8zRJiiR+jJuOkJFGPmzrl3N+nCwyb28FZeGOehlu8159VzxB
 IEtg==
X-Gm-Message-State: AOAM531TRNaUeWONqNhTlJJHFiP9CfMP5J4LDt+7UQodju7nCELtnTMx
 5wHI1x414u5F4w0k6wLhet0=
X-Google-Smtp-Source: ABdhPJysSqvqnQ/9Ue5bcz7zpgWjHw34v7o+0V7YTkhJb2z749Hqtu/41w7UlNOK9ngfynNsYL22Dw==
X-Received: by 2002:a17:902:7c16:: with SMTP id
 x22mr4072964pll.244.1590552162218; 
 Tue, 26 May 2020 21:02:42 -0700 (PDT)
Received: from daehojeong1.seo.corp.google.com
 ([2401:fa00:d:1:b8f4:bbde:37ba:20bd])
 by smtp.gmail.com with ESMTPSA id e5sm797494pfe.121.2020.05.26.21.02.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 May 2020 21:02:41 -0700 (PDT)
From: Daeho Jeong <daeho43@gmail.com>
To: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 kernel-team@android.com
Date: Wed, 27 May 2020 13:02:31 +0900
Message-Id: <20200527040231.70891-1-daeho43@gmail.com>
X-Mailer: git-send-email 2.27.0.rc0.183.gde8f92d652-goog
MIME-Version: 1.0
X-Headers-End: 1jdnHL-00EN4T-4c
Subject: [f2fs-dev] [PATCH] f2fs: protect new segment allocation in
 expand_inode_data
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
Cc: Daeho Jeong <daehojeong@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

From: Daeho Jeong <daehojeong@google.com>

Found a new segemnt allocation without f2fs_lock_op() in
expand_inode_data(). So, when we do fallocate() for a pinned file
and trigger checkpoint very frequently and simultaneously. F2FS gets
stuck in the below code of do_checkpoint() forever.

  f2fs_sync_meta_pages(sbi, META, LONG_MAX, FS_CP_META_IO);
  /* Wait for all dirty meta pages to be submitted for IO */
                                                <= if fallocate() here,
  f2fs_wait_on_all_pages(sbi, F2FS_DIRTY_META); <= it'll wait forever.

Signed-off-by: Daeho Jeong <daehojeong@google.com>
---
 fs/f2fs/file.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index f7de2a1da528..14ace885baa9 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -1660,7 +1660,11 @@ static int expand_inode_data(struct inode *inode, loff_t offset,
 
 		down_write(&sbi->pin_sem);
 		map.m_seg_type = CURSEG_COLD_DATA_PINNED;
+
+		f2fs_lock_op(sbi);
 		f2fs_allocate_new_segments(sbi, CURSEG_COLD_DATA);
+		f2fs_unlock_op(sbi);
+
 		err = f2fs_map_blocks(inode, &map, 1, F2FS_GET_BLOCK_PRE_DIO);
 		up_write(&sbi->pin_sem);
 
-- 
2.27.0.rc0.183.gde8f92d652-goog



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
