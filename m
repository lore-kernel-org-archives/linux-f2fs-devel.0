Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D450C3527C
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 15 Apr 2022 04:53:43 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.94.2)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1nfDxn-0002FF-0d; Fri, 15 Apr 2022 04:53:42 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2) (envelope-from
 <BATV+2d633663de0085320ac7+6809+infradead.org+hch@bombadil.srs.infradead.org>)
 id 1nfDxk-0002F5-L3; Fri, 15 Apr 2022 04:53:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=OTIsP1OizukmDhxFkiULvJk6rKtH8rZ66Toc2zFZ06c=; b=Nw+Pf5rQOSTP7K02XZkj+mVYcw
 hh0RIm0qyGqg5P70SLXc80ig9cYNRuBsqM/D4YlaDVsVoo+X5z2oZPik2GqfP6fSM+DHiUSnAUZs1
 zIiX/KYzj793LVqNUaJpfDSZFJW+AeqtIihEqVgBsvtSEUuep7ztRDzUHguZb/OWpnLw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=OTIsP1OizukmDhxFkiULvJk6rKtH8rZ66Toc2zFZ06c=; b=HUfjA0JPD+2dSOhPT3WGd4XtPe
 84eTg1b0COYsJPz65lcz1ijHkMT0wSDzVBz0Nz8LyxPVnx2CE9moFAHq27oUvH2ELybpuygyHX1L6
 NjMwxRSpa8XgdEHFG8BpiJRvfbHNkUjdRQOdOf9BiNBfHl7OjL/TjWDlwMDE8fjOrp24=;
Received: from bombadil.infradead.org ([198.137.202.133])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.94.2)
 id 1nfDxj-00083r-5i; Fri, 15 Apr 2022 04:53:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-Type:Content-ID:Content-Description;
 bh=OTIsP1OizukmDhxFkiULvJk6rKtH8rZ66Toc2zFZ06c=; b=ooMRjv2JAUzFUPyfh+XZqWb8QW
 Q9pjLNLNX62Z8C2MtoU6HU3VpVt4OAZRBuYSsD6pXMOi8ZjLOdl54eYy3Tp24LGUVsHa2hBE7Y0RM
 gDKNIKXjx2hbqJA1iCpB6nzk3wFq7ScIOiguPmNGaxWjNFoSpuysiesbbWxhRLyGcBXCzqkMTGuuD
 XDeeqdLlxhy91bRF+ZdOWJypNUbEcjrD8gjGqtH4BhZffx0JY9uZOYdBApIPmQ3bzD93iVI7xEHYb
 JNb40WmRbrFCmN1/+6dAisHF7eHMEiTWRFZXLfqhSoZ7Cj20tDlAxwUfcT/Ob7kj6Vu7zsHN8pcpE
 pX9GukFg==;
Received: from [2a02:1205:504b:4280:f5dd:42a4:896c:d877] (helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nfDxR-008Ooe-Ik; Fri, 15 Apr 2022 04:53:21 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Date: Fri, 15 Apr 2022 06:52:34 +0200
Message-Id: <20220415045258.199825-4-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220415045258.199825-1-hch@lst.de>
References: <20220415045258.199825-1-hch@lst.de>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Headers-End: 1nfDxj-00083r-5i
Subject: [f2fs-dev] [PATCH 03/27] target: fix discard alignment on partitions
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
Cc: jfs-discussion@lists.sourceforge.net, linux-nvme@lists.infradead.org,
 virtualization@lists.linux-foundation.org, linux-mm@kvack.org,
 dm-devel@redhat.com, target-devel@vger.kernel.org,
 linux-mtd@lists.infradead.org, drbd-dev@lists.linbit.com,
 linux-s390@vger.kernel.org, linux-nilfs@vger.kernel.org,
 linux-scsi@vger.kernel.org, cluster-devel@redhat.com,
 xen-devel@lists.xenproject.org, linux-ext4@vger.kernel.org,
 linux-um@lists.infradead.org, nbd@other.debian.org,
 linux-block@vger.kernel.org, linux-bcache@vger.kernel.org,
 ceph-devel@vger.kernel.org, linux-raid@vger.kernel.org,
 "Martin K . Petersen" <martin.petersen@oracle.com>, linux-mmc@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org,
 ocfs2-devel@oss.oracle.com, linux-fsdevel@vger.kernel.org,
 ntfs3@lists.linux.dev, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Use the proper bdev_discard_alignment helper that accounts for partition
offsets.

Fixes: c66ac9db8d4a ("[SCSI] target: Add LIO target core v4.0.0-rc6")
Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
---
 drivers/target/target_core_device.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/target/target_core_device.c b/drivers/target/target_core_device.c
index 3a1ec705cd80b..16e775bcf4a7c 100644
--- a/drivers/target/target_core_device.c
+++ b/drivers/target/target_core_device.c
@@ -849,8 +849,8 @@ bool target_configure_unmap_from_queue(struct se_dev_attrib *attrib,
 	 */
 	attrib->max_unmap_block_desc_count = 1;
 	attrib->unmap_granularity = q->limits.discard_granularity / block_size;
-	attrib->unmap_granularity_alignment = q->limits.discard_alignment /
-								block_size;
+	attrib->unmap_granularity_alignment =
+		bdev_discard_alignment(bdev) / block_size;
 	return true;
 }
 EXPORT_SYMBOL(target_configure_unmap_from_queue);
-- 
2.30.2



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
