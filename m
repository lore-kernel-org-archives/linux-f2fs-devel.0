Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C03AC7EE23
	for <linux-f2fs-devel@archiver.kernel.org>; Thu,  8 Jun 2023 11:04:52 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1q7DRj-00076T-J2;
	Thu, 08 Jun 2023 11:04:52 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95) (envelope-from
 <BATV+69acd89764e6999cdd63+7228+infradead.org+hch@bombadil.srs.infradead.org>)
 id 1q7DRe-00075Z-BE for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 08 Jun 2023 11:04:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=5LAvcRPWNtme+VneyJJGFak9XRRAUZ1PtAJwwpA666I=; b=NBOa92VYyLoqcjtUNqFJQWGcMO
 jmuyxOmOxX4t0xxf8aFe18bLrma/RFlI1ctp2FzanVr2/VSuJ3TQbsy5P6Ib0uOWxf3lWgqe8Xqpa
 Z/AOAJCzp11Pi8y3KI3n5HSB4Ns4XeceX/2/531s1opLL+12qgjn4qaeLGKxu44c3GKI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=5LAvcRPWNtme+VneyJJGFak9XRRAUZ1PtAJwwpA666I=; b=bMZJThrQZexFSg1UFrhBj7/D41
 6NC70HL0olrdagW1/mQ37bAHd8YetSeD+mvWIkVv3LArldT/l8lg0WkSdM9DC4wWYbqBWS2QhP0QM
 /lSp+KQmeOrf0vBpYoCEK8O9zVV4NS5RtqBKffklDnhsvlsrOM6FiJhs7ELJi15hoips=;
Received: from bombadil.infradead.org ([198.137.202.133])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1q7DRa-00Ee04-O2 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 08 Jun 2023 11:04:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-Type:Content-ID:Content-Description;
 bh=5LAvcRPWNtme+VneyJJGFak9XRRAUZ1PtAJwwpA666I=; b=Ebn2QLKZe/eCTpDOHDRK4xUyLm
 v5+tyWo63XDWqnHdbbbg3GjQ3q1mbTiQVWiEiYRjZGW6j7tJjrBifJ33h+5l9Ddg2YeoTn0C0mjh6
 t5fJOKm4t896Pz9mSLOD27ZBIyZMb6A+92ZdlXWE/zpee/vzyfJiCrlWHjGIXqVd42wnDtx1czTwV
 2+V8u5JLyfE4bRrPTmYMR+X2rNT6ZVKTg0UwfnhmVqYfQ84In255MgD7p2ZicJ/nOHqqOGeVxenrM
 QiM4jkk/aJN9yt/b/5O9xh1kC97o/wwI3NkDW2SrYe+Kk+ga5IFizyoJUUu1MSzMO1H2sPfsowUtk
 LROpWOvg==;
Received: from
 2a02-8389-2341-5b80-39d3-4735-9a3c-88d8.cable.dynamic.v6.surfer.at
 ([2a02:8389:2341:5b80:39d3:4735:9a3c:88d8] helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
 id 1q7DR7-0092nK-2n; Thu, 08 Jun 2023 11:04:14 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Date: Thu,  8 Jun 2023 13:02:53 +0200
Message-Id: <20230608110258.189493-26-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230608110258.189493-1-hch@lst.de>
References: <20230608110258.189493-1-hch@lst.de>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Headers-End: 1q7DRa-00Ee04-O2
Subject: [f2fs-dev] [PATCH 25/30] block: move a few internal definitions out
 of blkdev.h
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
Cc: Vignesh Raghavendra <vigneshr@ti.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>, linux-nvme@lists.infradead.org,
 Phillip Potter <phil@philpotter.co.uk>, Chris Mason <clm@fb.com>,
 dm-devel@redhat.com, "Md. Haris Iqbal" <haris.iqbal@ionos.com>,
 Pavel Machek <pavel@ucw.cz>, Miquel Raynal <miquel.raynal@bootlin.com>,
 Jack Wang <jinpu.wang@ionos.com>, linux-nilfs@vger.kernel.org,
 linux-scsi@vger.kernel.org, Richard Weinberger <richard@nod.at>,
 linux-pm@vger.kernel.org, linux-um@lists.infradead.org,
 Josef Bacik <josef@toxicpanda.com>, Coly Li <colyli@suse.de>,
 linux-block@vger.kernel.org, linux-bcache@vger.kernel.org,
 Alexander Viro <viro@zeniv.linux.org.uk>, David Sterba <dsterba@suse.com>,
 Christian Brauner <brauner@kernel.org>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 linux-f2fs-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org,
 linux-mtd@lists.infradead.org, linux-btrfs@vger.kernel.org,
 Hannes Reinecke <hare@suse.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

All these helpers are only used in core block code, so move them out of
the public header.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Acked-by: Christian Brauner <brauner@kernel.org>
---
 block/blk.h            | 23 +++++++++++++++++++++--
 include/linux/blkdev.h | 27 ---------------------------
 2 files changed, 21 insertions(+), 29 deletions(-)

diff --git a/block/blk.h b/block/blk.h
index 9582fcd0df4123..6910220aa030f1 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -394,10 +394,27 @@ static inline struct bio *blk_queue_bounce(struct bio *bio,
 #ifdef CONFIG_BLK_DEV_ZONED
 void disk_free_zone_bitmaps(struct gendisk *disk);
 void disk_clear_zone_settings(struct gendisk *disk);
-#else
+int blkdev_report_zones_ioctl(struct block_device *bdev, fmode_t mode,
+		unsigned int cmd, unsigned long arg);
+int blkdev_zone_mgmt_ioctl(struct block_device *bdev, fmode_t mode,
+		unsigned int cmd, unsigned long arg);
+#else /* CONFIG_BLK_DEV_ZONED */
 static inline void disk_free_zone_bitmaps(struct gendisk *disk) {}
 static inline void disk_clear_zone_settings(struct gendisk *disk) {}
-#endif
+static inline int blkdev_report_zones_ioctl(struct block_device *bdev,
+		fmode_t mode, unsigned int cmd, unsigned long arg)
+{
+	return -ENOTTY;
+}
+static inline int blkdev_zone_mgmt_ioctl(struct block_device *bdev,
+		fmode_t mode, unsigned int cmd, unsigned long arg)
+{
+	return -ENOTTY;
+}
+#endif /* CONFIG_BLK_DEV_ZONED */
+
+struct block_device *bdev_alloc(struct gendisk *disk, u8 partno);
+void bdev_add(struct block_device *bdev, dev_t dev);
 
 int blk_alloc_ext_minor(void);
 void blk_free_ext_minor(unsigned int minor);
@@ -449,6 +466,8 @@ extern struct device_attribute dev_attr_events_poll_msecs;
 
 extern struct attribute_group blk_trace_attr_group;
 
+int truncate_bdev_range(struct block_device *bdev, fmode_t mode, loff_t lstart,
+		loff_t lend);
 long blkdev_ioctl(struct file *file, unsigned cmd, unsigned long arg);
 long compat_blkdev_ioctl(struct file *file, unsigned cmd, unsigned long arg);
 
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 97803603902076..6b65623e447c02 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -318,7 +318,6 @@ typedef int (*report_zones_cb)(struct blk_zone *zone, unsigned int idx,
 void disk_set_zoned(struct gendisk *disk, enum blk_zoned_model model);
 
 #ifdef CONFIG_BLK_DEV_ZONED
-
 #define BLK_ALL_ZONES  ((unsigned int)-1)
 int blkdev_report_zones(struct block_device *bdev, sector_t sector,
 			unsigned int nr_zones, report_zones_cb cb, void *data);
@@ -328,33 +327,11 @@ extern int blkdev_zone_mgmt(struct block_device *bdev, enum req_op op,
 			    gfp_t gfp_mask);
 int blk_revalidate_disk_zones(struct gendisk *disk,
 			      void (*update_driver_data)(struct gendisk *disk));
-
-extern int blkdev_report_zones_ioctl(struct block_device *bdev, fmode_t mode,
-				     unsigned int cmd, unsigned long arg);
-extern int blkdev_zone_mgmt_ioctl(struct block_device *bdev, fmode_t mode,
-				  unsigned int cmd, unsigned long arg);
-
 #else /* CONFIG_BLK_DEV_ZONED */
-
 static inline unsigned int bdev_nr_zones(struct block_device *bdev)
 {
 	return 0;
 }
-
-static inline int blkdev_report_zones_ioctl(struct block_device *bdev,
-					    fmode_t mode, unsigned int cmd,
-					    unsigned long arg)
-{
-	return -ENOTTY;
-}
-
-static inline int blkdev_zone_mgmt_ioctl(struct block_device *bdev,
-					 fmode_t mode, unsigned int cmd,
-					 unsigned long arg)
-{
-	return -ENOTTY;
-}
-
 #endif /* CONFIG_BLK_DEV_ZONED */
 
 /*
@@ -1493,11 +1470,7 @@ void blkdev_put(struct block_device *bdev, void *holder);
 struct block_device *blkdev_get_no_open(dev_t dev);
 void blkdev_put_no_open(struct block_device *bdev);
 
-struct block_device *bdev_alloc(struct gendisk *disk, u8 partno);
-void bdev_add(struct block_device *bdev, dev_t dev);
 struct block_device *I_BDEV(struct inode *inode);
-int truncate_bdev_range(struct block_device *bdev, fmode_t mode, loff_t lstart,
-		loff_t lend);
 
 #ifdef CONFIG_BLOCK
 void invalidate_bdev(struct block_device *bdev);
-- 
2.39.2



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
