Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9785C5CFC1
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 14 Aug 2026 09:27:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-ID:Date:To:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Z+29OQwoCMt9k9vfv4SF5xrvKnyaIfLnRxrEk8Jw3hs=; b=GQqcw2eRtMvJrPelfcts/QSJT3
	PuppED8Fn++A3f82TbsfjARvPOToUlsYMYazkXNXDHK8R6Li+uInV063pryJl4WWVqsKniGtw+HIR
	YFuHKoNMn4l6Nyw7EHtcz4SbeHiXD9NR6OkkiWKvHu8TdwRbkY0vamggVLdKNBjm4+mQ=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wuoCD-00050b-Fs;
	Fri, 14 Aug 2026 09:27:23 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <aalbersh@kernel.org>) id 1wuoC7-0004zE-N9
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 14 Aug 2026 09:27:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=giX2dcWxgKGhap3ejBHZWfLPOTR0m2VLYbHv8ZTBG40=; b=OJsJ3/6UM9Gdu6isVGcrxgyU1L
 3t9JTCd2XzPrybif01k62tZw+sYiOcsQPOzNY8hPswcbFMrBigwbYF44LB8jJpmg3SE+ygogQT0xD
 C19wcT4izw+niiEZ4Pj/9u4Rj4/9xgHPX3keXH+lVH72yUwRpKjwpO6pkOHaBgtId6kk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=giX2dcWxgKGhap3ejBHZWfLPOTR0m2VLYbHv8ZTBG40=; b=bZc8fGbjUZnrEYQjmOO2JyLgDh
 lt4nuJPEC+y8k1HdbFmvDPJQgKxdvIqvSnEwAcedE50UhtRaFPlKTrNrAMlw+HrLYOR7leGlMQbrP
 k1FX6kIQDIq3urH6W80MDjVCbVZLL6bJgZ0RwXD5mZKLmm0kk6gL52Gm7OaHv5ZNSneM=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wuoBh-0007lm-UR for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 14 Aug 2026 09:26:54 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 404B860A5D;
 Fri, 14 Aug 2026 09:26:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE94C1F000E9;
 Fri, 14 Aug 2026 09:26:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786699608;
 bh=giX2dcWxgKGhap3ejBHZWfLPOTR0m2VLYbHv8ZTBG40=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=GqtoLl1JIGWVjsvmfzz05rL/fwLue6wqzeHWtCWpIaPhh+RJSJR5BDIMmaLM9sC+S
 tFrsXByWsr30zPcwDkKyQOYovjEe4bjbeSZGtNJVq0FPoa7Yv2ykyt5ytRyyNdbCsi
 icOPUPmXbO2DlEzeaZ9gG7C/R/O7JueBDZHgKw1a0zqQnav9+9wp/ot0QQ460KR7+5
 +TkX5H2e4W0C+o5WDaUqBmFHHKUeVB6qBJrAOeklTP1JLwaBQxBKDesKzWAkROZzjx
 ZJFVt2hMPitfM7Y2xCY/FgsxK/4ck+dhLtilzZle0WUldYLjqXctmjnKrx/7NMuc+P
 Sb8Y7RUiKQ0xQ==
To: djwong@kernel.org, ebiggers@kernel.org, hch@lst.de,
 Jens Axboe <axboe@kernel.dk>, Carlos Maiolino <cem@kernel.org>
Date: Fri, 14 Aug 2026 11:24:32 +0200
Message-ID: <20260814092448.1818082-16-aalbersh@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260814092448.1818082-1-aalbersh@kernel.org>
References: <20260814092448.1818082-1-aalbersh@kernel.org>
MIME-Version: 1.0
X-Headers-End: 1wuoBh-0007lm-UR
Subject: [f2fs-dev] [PATCH v15 15/25] xfs: don't report dio_mem_align and
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
Cc: fsverity@lists.linux.dev, linux-xfs@vger.kernel.org,
 Andrey Albershteyn <aalbersh@kernel.org>, david@fromorbit.com,
 linux-unionfs@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 Tal Zussman <tz2294@columbia.edu>, linux-ext4@vger.kernel.org,
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
