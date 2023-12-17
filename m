Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF47DC3DA6E
	for <linux-f2fs-devel@archiver.kernel.org>; Sun, 17 Dec 2023 17:27:07 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1rEuuv-0003l0-9m;
	Sun, 17 Dec 2023 17:27:04 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95) (envelope-from
 <BATV+1cffd234e19dbf5c5a3f+7420+infradead.org+hch@bombadil.srs.infradead.org>)
 id 1rEuut-0003kt-3j for linux-f2fs-devel@lists.sourceforge.net;
 Sun, 17 Dec 2023 17:27:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ctU7eNWyO5uU8k+K1R2TcQkMR0gAuYk2v8Yjsja/Y1c=; b=C+ysipWXZWqrOegJ8/CXJFuORt
 GpJ5eAZP8PotTwrEcgnMI/CRhUKrjKlWXTDPviItnSJSyYx+pTJuBTcG8pWCYfF3Ew+o7xyAbmnGQ
 dFWGdQIChr/HGe2hhcyAS6z+KxZVlXJH9nSSSNz9sgwzrypEC1L9DhVpTAvjJiBMOrdk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=ctU7eNWyO5uU8k+K1R2TcQkMR0gAuYk2v8Yjsja/Y1c=; b=gtIhNOH78+aqJuwb8KGfkr9Tjt
 +FNU7hgDxXCURfREl9bdfuPeuPqwvj11J9X/gRyx9dFYxVaFjDVtlXgtxGC03XWLgIjwnYdBKm6q1
 KvuZV5KKicK9dbaEUcSHStJfsIScRsxHf9mHD+uwmM98TjSvPq+hTALkRdw9qTnPPt4c=;
Received: from bombadil.infradead.org ([198.137.202.133])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1rEuuq-0000Sl-3d for linux-f2fs-devel@lists.sourceforge.net;
 Sun, 17 Dec 2023 17:27:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-Type:Content-ID:Content-Description;
 bh=ctU7eNWyO5uU8k+K1R2TcQkMR0gAuYk2v8Yjsja/Y1c=; b=DXYqZVLTY3AXEoBxl64SMyaX8s
 iocWPDWI6wSF+Py9Nzd53oAjEW8s1qbVJSoFuHgjMO7ReyYzIlvWagT4aJ/QmwFjj50jACktmkLZZ
 71o5L28Kq7RX+chawOPRKpL2T53erXPKzIXI2nvXIoChjJLg+xemJqSISQODlbdXJhjhX3utH0SCb
 szSXCMLib0iNpU+rrWEUHdVpkSQBb6SomuF0Kui47LLE3g4uh80BP5X4zJwwPeRq3X5kFrKbtgrF7
 l9Bbdlk6oGly95fNPZZVTL8laT37R0kjKKAPdOWDe6Ywyiy/a+PBeQwlF7aweLD4aibb3mJ7/+CUa
 zv8VYmog==;
Received: from [88.128.92.84] (helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
 id 1rEuPB-0088Od-1n; Sun, 17 Dec 2023 16:54:17 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Date: Sun, 17 Dec 2023 17:53:59 +0100
Message-Id: <20231217165359.604246-6-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231217165359.604246-1-hch@lst.de>
References: <20231217165359.604246-1-hch@lst.de>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Headers-End: 1rEuuq-0000Sl-3d
Subject: [f2fs-dev] [PATCH 5/5] sd: only call disk_clear_zoned when needed
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
Cc: dm-devel@lists.linux.dev, linux-scsi@vger.kernel.org,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 virtualization@lists.linux.dev, Damien Le Moal <dlemoal@kernel.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 linux-f2fs-devel@lists.sourceforge.net, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

disk_clear_zoned only needs to be called when a device reported zone
managed mode first and we clear it.  Add a check so that disk_clear_zoned
isn't called on devices that were never zoned.

This avoids a fairly expensive queue freezing when revalidating
conventional devices.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/scsi/sd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
index dbed075cdb981a..8c8ac5cd1833b4 100644
--- a/drivers/scsi/sd.c
+++ b/drivers/scsi/sd.c
@@ -3149,7 +3149,7 @@ static void sd_read_block_characteristics(struct scsi_disk *sdkp)
 		 * the device physical block size.
 		 */
 		blk_queue_zone_write_granularity(q, sdkp->physical_block_size);
-	} else {
+	} else if (blk_queue_is_zoned(q)) {
 		/*
 		 * Anything else.  This includes host-aware device that we treat
 		 * as conventional.
-- 
2.39.2



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
