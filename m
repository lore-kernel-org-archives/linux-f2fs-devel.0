Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C0EAC7EE43
	for <linux-f2fs-devel@archiver.kernel.org>; Thu,  8 Jun 2023 11:04:14 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1q7DR6-00013Z-My;
	Thu, 08 Jun 2023 11:04:13 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95) (envelope-from
 <BATV+69acd89764e6999cdd63+7228+infradead.org+hch@bombadil.srs.infradead.org>)
 id 1q7DR5-00012M-4w for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 08 Jun 2023 11:04:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=HfQKDcXIxVfpxDhJoYVU8U+lxQr2DjI7c93KYK31huo=; b=MyTzSAjHs4sSF+Waxq8cNLOXAO
 gLJfJ5v7l9LcutTzJUEhHVlmdoYyuEUxmMiXXiqB8i8txMJ30VJzA4PTLtqLyWw4kxh0bh38sRuDY
 vpWsmSgxCGLJ87s+ii49YmVbMyf2gNW3HdFRrqijXQWOwJRT8R1Qu3p78t78Z+vn1IdA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=HfQKDcXIxVfpxDhJoYVU8U+lxQr2DjI7c93KYK31huo=; b=DrkK/oqPjIXfEao8GbLs928jkr
 nLPMYTbDTf10xnMNnWfkhWktTOV8HPYUhMqoigLC/x9cw4ADfbRIWJ3chSw2X8YScmwIVhX7kw8NG
 EWqgrbamWs6fTlzlX1MGP6bgo1dH641s8vwS/4XxIa2GDpRHgzjhRBT2RyFpqWNEq/7c=;
Received: from bombadil.infradead.org ([198.137.202.133])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1q7DR4-00Edx9-Vo for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 08 Jun 2023 11:04:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-Type:Content-ID:Content-Description;
 bh=HfQKDcXIxVfpxDhJoYVU8U+lxQr2DjI7c93KYK31huo=; b=R7kJ0MJbD7zxTDiQlX4DG3rUJ6
 rh5jyLNnBqFnzd5SLvlvgUTIjHLhE1Z4ZC05/xS08Qis/ud/p+ahjsdMfce6SBXCGLDTRX5WU3rPr
 e1YlXWjk/u17FHigPVzV9Ep16pPOxftsIYvcrd3NOH+Y/y8nesj/sVOXqA3/XHYYwUBPNCrz9uj5J
 UvZhmbrJ6B1bGpvK9T+/USw5677+Byd4dwQWJZR7IbLxYqOHlnIeoYmHZ2z0gCWeCGovJi3/AWsyH
 vi6dJ9q1AzhkI27fHWkZPrBBvyUMObzSq2uxoT6ARNDZL/Q6zS/Ynz40T44S6S3pflLAIGTNNA2Hw
 o9SdoJ5Q==;
Received: from
 2a02-8389-2341-5b80-39d3-4735-9a3c-88d8.cable.dynamic.v6.surfer.at
 ([2a02:8389:2341:5b80:39d3:4735:9a3c:88d8] helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
 id 1q7DQU-00925z-04; Thu, 08 Jun 2023 11:03:34 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Date: Thu,  8 Jun 2023 13:02:40 +0200
Message-Id: <20230608110258.189493-13-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230608110258.189493-1-hch@lst.de>
References: <20230608110258.189493-1-hch@lst.de>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Headers-End: 1q7DR4-00Edx9-Vo
Subject: [f2fs-dev] [PATCH 12/30] bcache: don't pass a stack address to
 blkdev_get_by_path
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

sb is just an on-stack pointer that can easily be reused by other calls.
Switch to use the bcache-wide bcache_kobj instead as there is no need to
claim per-bcache device anyway.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Hannes Reinecke <hare@suse.de>
---
 drivers/md/bcache/super.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/md/bcache/super.c b/drivers/md/bcache/super.c
index 94b91c45c9e2a9..4a2aed047aec12 100644
--- a/drivers/md/bcache/super.c
+++ b/drivers/md/bcache/super.c
@@ -2560,7 +2560,7 @@ static ssize_t register_bcache(struct kobject *k, struct kobj_attribute *attr,
 	err = "failed to open device";
 	bdev = blkdev_get_by_path(strim(path),
 				  FMODE_READ|FMODE_WRITE|FMODE_EXCL,
-				  sb, NULL);
+				  bcache_kobj, NULL);
 	if (IS_ERR(bdev)) {
 		if (bdev == ERR_PTR(-EBUSY)) {
 			dev_t dev;
-- 
2.39.2



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
