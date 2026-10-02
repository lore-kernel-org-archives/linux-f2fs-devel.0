Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84C6DCA5FE6
	for <linux-f2fs-devel@archiver.kernel.org>; Fri,  2 Oct 2026 22:37:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-ID:Date:To:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zPvGjENhKJnnE0mr1za4g5dDBdwWcnRdrtwCxhTv5rg=; b=FHDdRZk75vPyzd2xK5pljJUMoO
	0Iozlqzqb/iXKgVohlmTnYf9lMdijA4D+oS3MB7XezbddCXEJJgccERlgTr3elAsTj6BPPb9iJ1D/
	hxZKwSm5VvKZlzB0HaT150dogWrzJ7GTAHtkcltgdq/ggkorRokdCHQNoN4QuymAoTcw=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xClt4-0003dH-DX;
	Fri, 02 Oct 2026 22:37:55 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <aalbersh@kernel.org>) id 1xClt3-0003d5-3n
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 02 Oct 2026 22:37:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ieVuD4QM5J41nXjMBZicua2S6B/WM0wDRAu86VZATUA=; b=PPbJXahoU+eBf/wIFB6BO53zBa
 vzXHqJ000rKBCI/liVYZPjzaXCZGPacCSN/xh8aijOBhre5dKFxJv/bpP/IKtg6Fakwj2GGcKTIWZ
 +9x2VWVD6AO83BPTnuZpdW90oi6nRgw0JKvl0APrTHqYKObC/MC4JQZ9DyKN7My3VvNI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=ieVuD4QM5J41nXjMBZicua2S6B/WM0wDRAu86VZATUA=; b=LnFLZd2VDQyYLB6Kll+2sK3nRy
 cC816398sEO6oN/yz/WOytItGmsr9F3iJiwOvBGO+83pM3+Qzi/WwO2kipm9Ms8bxSpOzyEcdggRu
 0eMyridALtm8veO8KgGY+xQ/AEutPdTmDYzuQBpwOd/Yt+dmZu6CyPPYvFmfbGhs5x0c=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1xClt3-0003j2-EG for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 02 Oct 2026 22:37:53 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 2779543E38;
 Fri,  2 Oct 2026 22:37:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F7D11F000FF;
 Fri,  2 Oct 2026 22:37:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790980668;
 bh=ieVuD4QM5J41nXjMBZicua2S6B/WM0wDRAu86VZATUA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=laeAvlxHHeZ6Gte499h9yTtQJvpFgsdWN+gvKWUOCNP7KOHdNtYZMYj3fwWTfNjXr
 pq8f2uFqJbR1EKTTKCOKIYg4ZJzzWY1xpfXeMtssLVo+ORkuobos6oJOSbPBSjXp1J
 o++FLhVXeMGL3o4k74vh+VS7vftXkT/xXEnoBM9lWPgEFxsN2pzyTDdRgLCpjYXZBY
 RsFt2zuA1HMsR3ErbZ6Tl7OGqvcRwmsCEe5jnFsaVRnlmJJHk5XEL4Lfodf3xOToi3
 Z786P3kwJBXjGqxIN6vxA95vzkKiO83v3Ljg2UwEAcSvAjWx9Flk3oavfJibauapaQ
 htYUNR0YTBuUQ==
To: djwong@kernel.org, ebiggers@kernel.org, hch@lst.de,
 Carlos Maiolino <cem@kernel.org>
Date: Sat,  3 Oct 2026 00:36:51 +0200
Message-ID: <20261002223705.2175542-11-aalbersh@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261002223705.2175542-1-aalbersh@kernel.org>
References: <20261002223705.2175542-1-aalbersh@kernel.org>
MIME-Version: 1.0
X-Headers-End: 1xClt3-0003j2-EG
Subject: [f2fs-dev] [PATCH v17 10/21] xfs: don't report dio_mem_align and
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
Cc: fsverity@lists.linux.dev, Andrey Albershteyn <aalbersh@kernel.org>,
 david@fromorbit.com, linux-unionfs@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
 linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Sashiko.dev reported that while fsverity files falls back to the
buffered IO for Direct I/O, they should not report non-zero values in
dio_mem_align and dio_offset_align, meaning it's not supported.

The STATX_DIOALIGN | STATX_DIO_READ_ALIGN flags are used to explicitly
report if DIO is supported or not. They can not indicate that fallback
to the buffered IO is used in this case. The zero alignment values also
mean that DIO is not supported on this file, see statx(2).

Signed-off-by: Andrey Albershteyn <aalbersh@kernel.org>
Acked-by: Eric Biggers <ebiggers@kernel.org>
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/xfs/xfs_iops.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
index b07ca2a33c64..d9c25c06cc60 100644
--- a/fs/xfs/xfs_iops.c
+++ b/fs/xfs/xfs_iops.c
@@ -35,6 +35,7 @@
 #include <linux/security.h>
 #include <linux/iversion.h>
 #include <linux/fiemap.h>
+#include <linux/fsverity.h>
 
 /*
  * Directories have different lock order w.r.t. mmap_lock compared to regular
@@ -579,6 +580,10 @@ xfs_report_dioalign(
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
