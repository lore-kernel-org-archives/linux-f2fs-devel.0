Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68EB8C433EF
	for <linux-f2fs-devel@archiver.kernel.org>; Wed,  6 Apr 2022 06:06:51 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.94.2)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1nbyod-0001bP-Gu; Wed, 06 Apr 2022 06:06:50 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2) (envelope-from
 <BATV+4210fbe0094d03a681f9+6800+infradead.org+hch@bombadil.srs.infradead.org>)
 id 1nbyoc-0001aj-Ga; Wed, 06 Apr 2022 06:06:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=d3sJ7l3Ux9SIWrKAiUmyBkG0qOnuM50cLv7WOo5iKv8=; b=GnMc7trU/0QNef62OH8tjkLNxQ
 1+wiiy5rI0LGcNLFGxmT1HcFJwpLoXIBRdQmFX8FXLitgPTsql2MF00WUwnG4XpEWxOICQkxF+YZE
 fZpjAfvzW+aNWCmthZgO7Fx73iNoC7E7Gnn+4Ol6ky58vaECBjYi8V/lCCoE+FnYkWtM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=d3sJ7l3Ux9SIWrKAiUmyBkG0qOnuM50cLv7WOo5iKv8=; b=iYNOThn1MnySGopDHRhR+kQmkq
 r0s0cYCkLt8dmVqXrgI+YzKK7Dj4ok2FWExkNdDQ9AyG2dfxrgaoDlmXFBqnul9t36E3mvKxzwTsy
 di+y1RgjUO8/uE0yMOpyWB5qdS+3C+H6Urfzjs6znQegdV05uTRKRLZIyLn49MRTC73g=;
Received: from bombadil.infradead.org ([198.137.202.133])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.94.2)
 id 1nbyob-0000yi-0b; Wed, 06 Apr 2022 06:06:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-Type:Content-ID:Content-Description;
 bh=d3sJ7l3Ux9SIWrKAiUmyBkG0qOnuM50cLv7WOo5iKv8=; b=U2k/JlDotMbinK7/JDeqSo6/XP
 Bs6ySJFC9su858GHk30OJaJoPB8rDR3fvqdgMURXO1OQquTgsv4KE+byWZoWhPXIJrPHFRYb57htY
 5kZ+Tj1EaeX24yHzNVPsnH8vK+56pifogbah/qUjzUOJyGboKhFS3X1qob8eCfNE75hF6DRia35U9
 qUd69uVjtYbl+AqrDw3m1Y45lEPmXYcMS6cMXqiqEpwL10Cir9JTLmDF/dQj22I6ypwBu1ciZGVg0
 rsksxrk+RgNjFNzHV8WMNg8RMAo9CfrbuDS6Y2JIjcM3aNVVcHFf8/GoINpy91AK7PBW/D671mulY
 8/TSMjOw==;
Received: from 213-225-3-188.nat.highway.a1.net ([213.225.3.188]
 helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nbyoK-003vcM-Lw; Wed, 06 Apr 2022 06:06:33 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Date: Wed,  6 Apr 2022 08:05:08 +0200
Message-Id: <20220406060516.409838-20-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220406060516.409838-1-hch@lst.de>
References: <20220406060516.409838-1-hch@lst.de>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Headers-End: 1nbyob-0000yi-0b
Subject: [f2fs-dev] [PATCH 19/27] block: remove queue_discard_alignment
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
 linux-mmc@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-xfs@vger.kernel.org, ocfs2-devel@oss.oracle.com,
 linux-fsdevel@vger.kernel.org, ntfs3@lists.linux.dev,
 linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Just use bdev_alignment_offset in disk_discard_alignment_show instead.
That helpers is the same except for an always false branch that doesn't
matter in this slow path.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/genhd.c          | 2 +-
 include/linux/blkdev.h | 8 --------
 2 files changed, 1 insertion(+), 9 deletions(-)

diff --git a/block/genhd.c b/block/genhd.c
index 712031ce19070..36532b9318419 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -1019,7 +1019,7 @@ static ssize_t disk_discard_alignment_show(struct device *dev,
 {
 	struct gendisk *disk = dev_to_disk(dev);
 
-	return sprintf(buf, "%d\n", queue_discard_alignment(disk->queue));
+	return sprintf(buf, "%d\n", bdev_alignment_offset(disk->part0));
 }
 
 static ssize_t diskseq_show(struct device *dev,
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 0a1795ac26275..5a9b7aeda010b 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1253,14 +1253,6 @@ bdev_zone_write_granularity(struct block_device *bdev)
 
 int bdev_alignment_offset(struct block_device *bdev);
 
-static inline int queue_discard_alignment(const struct request_queue *q)
-{
-	if (q->limits.discard_misaligned)
-		return -1;
-
-	return q->limits.discard_alignment;
-}
-
 static inline int queue_limit_discard_alignment(struct queue_limits *lim, sector_t sector)
 {
 	unsigned int alignment, granularity, offset;
-- 
2.30.2



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
