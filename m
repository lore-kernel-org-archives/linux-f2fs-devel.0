Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38E66C44524
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 20 Jul 2026 09:05:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-ID:Date:To:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=rgdRltfYZPVAZa9rEsAO18dzS/C2P1NRwMGB66PS+UU=; b=h5FO3JnHbgHqlxyBjB9M+DmrZ8
	blDHWKFmCI0K9xKzR/1OMTYxRf7ApRsZp+USvOWhprFHaubnHrqwZZLdMHpXXpAw59OxoMilwNBS9
	FXjRwvzRGt6+7KjRYs6b9E7pq7UpRYMt1R1zxALVoa7X5eGcH9rAeUGVnN1FIOsXHJ5o=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wljwU-0008RA-TN;
	Mon, 20 Jul 2026 09:05:40 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <aalbersh@kernel.org>) id 1wljwT-0008Qt-9h
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 20 Jul 2026 09:05:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=wjtx2lzB3uvb4xU+DIuox4Zw+1tx5e8JwgBOS4wBSrM=; b=eLRNLbVzH6AqAYTeX+75yoJwDf
 VeXAAiGU+0s3herhmzkFt2mjSAwh03qJNqj1aS0+YMsSgaZP3o+MavTa1dTdoMUOuNcceN4iZ114m
 GSTq/jcmjqq+bBsPLDNcM1G1zGAV5I58cwqX5EcVoZLrmtDGqPwZMSyShj9lOH2I7oLQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=wjtx2lzB3uvb4xU+DIuox4Zw+1tx5e8JwgBOS4wBSrM=; b=hedtw/WTfPFib6p8wZmRraSTZs
 gZFkZIYI0zeCUFR4k9lGpxYceEuy6E/uKTmseRyFD8Wa3wFG2E21nWcJq3s0mK6gdeweCObHTItWJ
 gA2Au6iW2WQGlATsd33sItcq14HNUJ0QwM0E54EtE5/RCMMvZMW+RFvQ92kdSQfhhdAQ=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wljwP-000887-IW for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 20 Jul 2026 09:05:38 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 4B9CD40E4A;
 Mon, 20 Jul 2026 09:05:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF3271F00A3A;
 Mon, 20 Jul 2026 09:05:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784538327;
 bh=wjtx2lzB3uvb4xU+DIuox4Zw+1tx5e8JwgBOS4wBSrM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=W5A1ewnf2yWgs9Ej+zVBFNx8P864V5/ghhTgdFMN6uh+7L10Qmsv3xFSwXjUQ1i0z
 LNWk1ze25e/GK/1YvbDMY72SRoBuFpqJFkUWV11bGjp0D+NSswc+CrFpI7prvSCotj
 7E8ElFHISr65637ZclACrpTTPsQbNBLjV5L5oE2uxHg57rLyyv2XmKpyNIYc0PG8oK
 y8VIBJc96LWSqCI2mKDfpQsGAn56FZPxqUETkkYVnh20J4+MQYORES/9fnOMDdd0fe
 7MUJRWZeROLbMTF5YBHFCTrYg5+CHjxghUd8e4o2zQ9CdRxgpf6uKdPjUgLeG/MmNf
 bu1pq319TfDZA==
To: linux-xfs@vger.kernel.org, fsverity@lists.linux.dev,
 linux-fsdevel@vger.kernel.org, ebiggers@kernel.org
Date: Mon, 20 Jul 2026 11:03:39 +0200
Message-ID: <20260720090410.3487990-12-aalbersh@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260720090410.3487990-1-aalbersh@kernel.org>
References: <20260720090410.3487990-1-aalbersh@kernel.org>
MIME-Version: 1.0
X-Headers-End: 1wljwP-000887-IW
Subject: [f2fs-dev] [PATCH v12 11/21] xfs: don't report dio_mem_align and
 dio_offset_align for fsverity files
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
From: Andrey Albershteyn via Linux-f2fs-devel
 <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Andrey Albershteyn <aalbersh@kernel.org>
Cc: Andrey Albershteyn <aalbersh@kernel.org>, djwong@kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, linux-ext4@vger.kernel.org, hch@lst.de,
 linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Sashiko.dev reported that while fsverity files falls back to the
buffered IO for Direct I/O, they should not report non-zero values in
dio_mem_align and dio_offset_align, meaning it's not supported.

Signed-off-by: Andrey Albershteyn <aalbersh@kernel.org>
---
 fs/xfs/xfs_iops.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
index 55667cc762f8..70637cdcc299 100644
--- a/fs/xfs/xfs_iops.c
+++ b/fs/xfs/xfs_iops.c
@@ -35,6 +35,7 @@
 #include <linux/security.h>
 #include <linux/iversion.h>
 #include <linux/fiemap.h>
+#include <linux/fsverity.h>
 
 /*
  * Directories have different lock order w.r.t. mmap_lock compared to regular
@@ -580,6 +581,10 @@ xfs_report_dioalign(
 	struct block_device	*bdev = target->bt_bdev;
 
 	stat->result_mask |= STATX_DIOALIGN | STATX_DIO_READ_ALIGN;
+
+	if (fsverity_active(VFS_I(ip)))
+		return;
+
 	stat->dio_mem_align = bdev_dma_alignment(bdev) + 1;
 
 	/*
-- 
2.54.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
