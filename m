Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFB72C4167B
	for <linux-f2fs-devel@archiver.kernel.org>; Mon,  4 Dec 2023 18:05:45 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1rADKD-0008Ht-1X;
	Mon, 04 Dec 2023 18:05:45 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <jaegeuk@kernel.org>) id 1rADK1-0008Hl-0C
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 04 Dec 2023 18:05:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=bHgvlR7opcdsXndy/cEVWyidzHDwr/pEoNe0B44Z2W0=; b=JOKL5pGWSbVcEuZ7fZqOwvpAVe
 HyN2KdyyR0wlfSRtwTi2b3y5bK8BUSyxxJg8sTGFvc7sWbZvTUK7WbGx07WD98LVL9aUA0HkEM8BB
 7SfYtk2iin+DBJ4oHcugmZVjYoheEpczwUBodl35qAoy4BfG/0j+aoKop/GsQdHFSnyM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=bHgvlR7opcdsXndy/cEVWyidzHDwr/pEoNe0B44Z2W0=; b=OyRG6DnZB7siensKmoLcUg99Ua
 c37oqNaID5a0M8bs5nQYoPp8mcRfT/GEWC7mNE+BIakDGWAAwqHFikc3NCdNmlEgtBQIMiAvQvwkh
 NnoiROHmp/daIllVNEdoTWdyMaZZ7DMHoV/1I6JsqVFO+ppUv/ybdqk35HvdsuGPqNk0=;
Received: from sin.source.kernel.org ([145.40.73.55])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1rADJl-0003Tz-P5 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 04 Dec 2023 18:05:22 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id E1D6DCE127D
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon,  4 Dec 2023 18:04:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D72FC433C8;
 Mon,  4 Dec 2023 18:04:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1701713073;
 bh=0phZvSzPedzW6aghBJdL/2EodTWmVUATApogRYUPDL4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=JJUpsYKjhndUIiQOWhL/JnuOSKRB4lZI+bnPJji3zxHnVVmcPDhoE/U0MgdbyqWrs
 zgqIk78WA38WbHWv8Xn/2rJyK5Aeh7aF4VWtrnadkOBuzDx1IJPFp91pgOS1pZPnX5
 4fjfBp8Z4ioemkmo0f5iq/aQ8ngMnYp+fdDEZaBU2uDlTvf35o8taW9N0hE4jcuFjE
 nQv9bB/Mb8Zb/2tCyrBPTCrNs0QKiKi06ePBjMHppvd/tY00JhKNmm3CS2Axk0AMSu
 4iKlvZcfK8Opeqt44AlZe+tmTLGnOZSwiRBaHcX/aEgLNdSvCgggjf/WVmcHTjf9Rf
 2UDGeWImdFb3A==
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: linux-kernel@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net
Date: Mon,  4 Dec 2023 10:04:27 -0800
Message-ID: <20231204180428.925779-3-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
In-Reply-To: <20231204180428.925779-1-jaegeuk@kernel.org>
References: <20231204180428.925779-1-jaegeuk@kernel.org>
MIME-Version: 1.0
X-Headers-End: 1rADJl-0003Tz-P5
Subject: [f2fs-dev] [PATCH 3/4] f2fs: check write pointers when
 checkpoint=disable
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
Cc: Jaegeuk Kim <jaegeuk@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Even if f2fs was rebooted as staying checkpoint=disable, let's match the write
pointers all the time.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/super.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 617340e9ea7f..9a874b4d1501 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -4741,7 +4741,7 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
 #ifdef CONFIG_QUOTA
 	f2fs_recover_quota_end(sbi, quota_enabled);
 #endif
-
+reset_checkpoint:
 	/*
 	 * If the f2fs is not readonly and fsync data recovery succeeds,
 	 * check zoned block devices' write pointer consistency.
@@ -4752,7 +4752,6 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
 			goto free_meta;
 	}
 
-reset_checkpoint:
 	f2fs_init_inmem_curseg(sbi);
 
 	/* f2fs_recover_fsync_data() cleared this already */
-- 
2.43.0.rc2.451.g8631bc7472-goog



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
