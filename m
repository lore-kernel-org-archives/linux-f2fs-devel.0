Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B75F7C4451C
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 21 Jul 2026 18:45:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-ID:Date:To:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=rgdRltfYZPVAZa9rEsAO18dzS/C2P1NRwMGB66PS+UU=; b=F/dai+Mzegd3HaPLbw9wJlY431
	aL0Qd4ugMXSGpSBvER1xagZ9YTq41CzYwVR++vGU3xaTtIv3lZGY4DLAH6Vlm3wBDBoicLy8683Kn
	7yeALplw6LNyz8DBQ/6OcagZUFGY5u5/LLwZ+I5WyfZI6RluVpcDMFfcjUbq9jjGqU/I=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wmFSm-0003Ng-1m;
	Tue, 21 Jul 2026 18:45:05 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <aalbersh@kernel.org>) id 1wmFSJ-0003LE-Ul
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 21 Jul 2026 18:44:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=wjtx2lzB3uvb4xU+DIuox4Zw+1tx5e8JwgBOS4wBSrM=; b=CQ2sJEjKln47garPEv6Kq0Qeol
 eCGqgJeDQIAE2ADLYHroTzh+KTg+kaAaOCo4eqqaFxisZ9iTpdCZbiRECC50yYEhnDEkQE6RjSEYN
 QQfG9Q7bKTPfmCTFhHBlZFUQ7A9xhAOLry0SqUp+evaiwB8ywwskSfGfefyisE671RKc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=wjtx2lzB3uvb4xU+DIuox4Zw+1tx5e8JwgBOS4wBSrM=; b=lmeQUqm1ip8lHi6EnIYuahdg7w
 HQrI077m8i5GR9cesF987RR7v53Kun7TbpGkzgiHNZPhhE6YEHor/j7c3S4rkP/Ywj7eb6TGrqzad
 EQs1sqs0kP0cYIHsG3CN1ooZZtkjRPbM+f5V6s1jrCqLCab01wgVAerl2zolydJEhQmM=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wmFSG-00031U-3J for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 21 Jul 2026 18:44:37 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id C538043B02;
 Tue, 21 Jul 2026 18:44:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BB451F000E9;
 Tue, 21 Jul 2026 18:44:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784659470;
 bh=wjtx2lzB3uvb4xU+DIuox4Zw+1tx5e8JwgBOS4wBSrM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=A1aNh133LaOr+veWURHQdGc2XGiZKvo8KSp2tkJ9AohhNSRRwgxYI4BSjWTZDZu9p
 JSdQ5hRIQXzsdB1A+jK3Ut0TEpUBotTPNfdzbm8kqFXMgilK0WHXxF4rTtwgRElbwq
 gt71KVal9gMebJUpZToY1VctlGmoXBhD0IdNjJ23rcw5RAXf7ubB5q7jx3wmU00biU
 KeVB4X1SSzXlrcP1qyl3Q3isnNrLaDRD/q5sxfKb4R155MOvj7neSQO6O5aqnAcbOb
 LsFa+LnE6ozBPhnGvsW/64uEXxSPGFs8AtWm8T1PQaFaaoq/pcsqRKAsHfUifXGON1
 oHbmGOA1YF3NQ==
To: linux-xfs@vger.kernel.org, fsverity@lists.linux.dev,
 linux-fsdevel@vger.kernel.org, ebiggers@kernel.org
Date: Tue, 21 Jul 2026 20:40:49 +0200
Message-ID: <20260721184346.416657-13-aalbersh@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260721184346.416657-1-aalbersh@kernel.org>
References: <20260721184346.416657-1-aalbersh@kernel.org>
MIME-Version: 1.0
X-Headers-End: 1wmFSG-00031U-3J
Subject: [f2fs-dev] [PATCH v13 12/23] xfs: don't report dio_mem_align and
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
