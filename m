Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D5B0C44506
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 10 Jul 2026 08:54:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-ID:Date:To:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=rgdRltfYZPVAZa9rEsAO18dzS/C2P1NRwMGB66PS+UU=; b=CxHxk8V0x310PxCMQiGb4l8Lwl
	hggGdTuMEFPilEGetYjoHMetydHFtucFlm6LnEx0hlqwg1l1OgXv8DGVcq1oj1aSoe3R7VjYTqHfJ
	/uo3V1yh1AhM+eBI3P3e6yCIc0cITs7aSvL0Ytny/QTVIlG4l6MzuN0sC2/683+eI3Hg=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wi701-0003VK-2u;
	Fri, 10 Jul 2026 08:54:21 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <aalbersh@kernel.org>) id 1wi700-0003Uv-5w
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 10 Jul 2026 08:54:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=wjtx2lzB3uvb4xU+DIuox4Zw+1tx5e8JwgBOS4wBSrM=; b=Ogv6a3zEWzQX8otuMAPu/eS/Sx
 tc3tLtm9REp37KVqNjB7N8b7wa/rF07rtVG/H8eqxMJ+iVArkFfLjDNVqYvil8TzdGjN5HkQpKS/0
 CRQUGMCm5WoMUimJG8Mx67XNl1k0duhXXOCrmH3RsDGciOp6DYphA9FRjAb9fC+GdUtg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=wjtx2lzB3uvb4xU+DIuox4Zw+1tx5e8JwgBOS4wBSrM=; b=gRpnqhJ9yfntb+jgwUxfj+NVtb
 aaonZvdEqnw36zFxV/iiRQfDSTqutK0HR3tJFUX9FUZzpg6oFipwL42A4YEZosNftgLHFDi9iH2Dd
 lNlwZLZr3ZwO27Ky2YPTMkz3sjNs3q3P7sgsW+SI6P0OcD22Kyfx/rL6eTa4jQ4zPQsA=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wi6zl-0007Vm-96 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 10 Jul 2026 08:54:20 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id AE77B6132C;
 Fri, 10 Jul 2026 08:53:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02C9E1F00A3E;
 Fri, 10 Jul 2026 08:53:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783673634;
 bh=wjtx2lzB3uvb4xU+DIuox4Zw+1tx5e8JwgBOS4wBSrM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=fOPGIi2qT/sDSUu1YE04vKmbro26o2XNX87EpoLSHZ3+O7hcik009cJCb7S5J7fMY
 v+rKRa2zqfBXE+UIOFnKDKbZUrntwXpfq415MoxBdLiOsfOyNKhocJCVmwLFLrmjD6
 jQ9zwTMbFkrBmSPTJD7b4eO8PJYhs3Il4cvjKC/QcaaDEAfN0zh6Aw/JNaEegHIC7r
 2bQL7Juuo2BShXDLOQsfRSu1Tynw5LRMJupkDupzUok7+M4x+TmekBERhqQOxAofBG
 /jeU1WsJp1zbEw47ibS360In0xhg7L7SEnY5uDIP6uYKpvJDLgma/1FDaJ4ZQX3AZj
 SmVS2/vV6NCYw==
To: linux-xfs@vger.kernel.org, fsverity@lists.linux.dev,
 linux-fsdevel@vger.kernel.org, ebiggers@kernel.org
Date: Fri, 10 Jul 2026 10:52:38 +0200
Message-ID: <20260710085256.3464201-11-aalbersh@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260710085256.3464201-1-aalbersh@kernel.org>
References: <20260710085256.3464201-1-aalbersh@kernel.org>
MIME-Version: 1.0
X-Headers-End: 1wi6zl-0007Vm-96
Subject: [f2fs-dev] [PATCH v11 10/20] xfs: don't report dio_mem_align and
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
