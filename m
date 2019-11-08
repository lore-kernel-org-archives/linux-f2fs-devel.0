Return-Path: <SRS0=U1Xf=ZA=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00249C5DF61
	for <linux-f2fs-devel@archiver.kernel.org>; Fri,  8 Nov 2019 01:57:29 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C600321882;
	Fri,  8 Nov 2019 01:57:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="EJ5YNIzl";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="Vm7chWOy";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="ZX30e7v3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C600321882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1iStWi-0000mp-4R; Fri, 08 Nov 2019 01:57:28 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <prvs=208d19533=damien.lemoal@wdc.com>)
 id 1iStWf-0000mK-S9
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 08 Nov 2019 01:57:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=RCZn/nnKwaeoyC7CJp7Wcna40QHlUvfKqEsx39Do8Eg=; b=EJ5YNIzlKuOU7fUdyOspnEzM4g
 SJMJ6trOE8kkEviOKaICwmC8aXHD7BtTiXiZG8fqEztan6kzwSZ/oDjj7f6wHiJgFc7T65m89D0Qr
 OsYJT/E+hk+bem8w3NUZvOWDPB9aOLaiPwsuVrPiz0jOMcpQvvmCeefMEr3wln/ur6XQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=RCZn/nnKwaeoyC7CJp7Wcna40QHlUvfKqEsx39Do8Eg=; b=Vm7chWOyDd9lQN6iT7l/QAlXZy
 Gp5UCO8XMqcmasJiS1tAS6JrUk9s/kRs+Iey5xQQR3AM+oFiHlseQDQVDfQIBPpbw+Y6IqWy0FYe7
 dQVmYCmge0YtWo5qdBWtgtkw0j0I6LL4ZQC2F6F2WPQ69mXcE8kgTelj8C5EsKCvlFEw=;
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1iStWe-004Ptm-EL
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 08 Nov 2019 01:57:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1573178286; x=1604714286;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=bKM/4aInW/OgAqMFQv0OZJNRf46tFrvXlpwNgWcw2sw=;
 b=ZX30e7v3LlSTJwWq1As/8ejigOZFnpNnwua+6S2XGka9Ov6xHZnAye/V
 vcvIOT/26faF3Hmb5Blrtx35fHKmdv46+/VqwXGoC3F/RJNnPYwgHwFe9
 g82z55L77+6ZtyLwe0d6YYp70ZEPq3U8ZASFKhLSksOirr2ZP212Ebp4y
 lC70Lx85SX6PcMe7CbpYKuJh6PTNFkEpyaWjQ+LRWd6YffdtGN0/L8n0B
 LPG+LvBxWWh/6Bqy5u7Ugc44Sc2EcThgZayfn/ibab6r6N/pHs14l63Tm
 LjTOChJ1AJpSK6t/V66eppF86W4t+BseCua5vNigbCHerc+QRqACrE824 Q==;
IronPort-SDR: eqODbI3qWIA2+q4OgkHtxSL5z8unpNR53NBsza85NJBMpIz8jm0lUipyNSkOwdEmyJ0Af+qrir
 WeiOuBKuu7/aS5Sjkne8ERQqO1KzDlzOe1oXPAlt//17NmHtT8BBZ1ni3p6AUMzNMhfvvRQZ3O
 ab8wfEHo92mQzIUqYovM5n6QjHsPjKVF8uD7iIajjyfiwP8S8s2Olp5GdX/Qa7XU4gVNep3MMq
 B6PslEYSCCPjOckj9GiR5uFmiUiuZpUxgPLij8iZWxNg22XL7FENzHqZX/O7w5/6mk1YxnyWAq
 Sik=
X-IronPort-AV: E=Sophos;i="5.68,279,1569254400"; d="scan'208";a="223636912"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 08 Nov 2019 09:57:52 +0800
IronPort-SDR: 8nZBQFllyvWWjPw2iML9awpbrrsTPpGvuBUt5xZyRT0c/xCBk9moqCt8MSDwj8vh5GTEmX+0Rr
 Wzr2ubI14cH44TteHVj9/XlMTOOIQiNM7O25eMOm8vet6ksGL7Y1BrTWNHMUxu6EQ4a25zmnuq
 4UO8V6OfE1dMz82nBUQSDvKh1ntFM0ftv7JRHYwFeXf6RY0YVRv25zTN6XizfU9aOSVB2Jirsa
 cvVGJKucT4XE7T47KlgA2ykfnRFoB0cyPOIhwBoqnC0tlw/RHfC5llZSI4BEbReVsTZAhdFJ3y
 kEZUqwsmkB5D3x/IyV3w5x/6
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Nov 2019 17:52:24 -0800
IronPort-SDR: 4CDSQV2+GUtY/DSWWA7Yt1gBV3s2ut6Ip0kWS6IlKPmfz9aw8vAh4foMojfjAlyTPim0pyGsMD
 mGEEU6eq6rRd8UgsEGjut9tEMR4CHv2QWG/j3M0IqThDPNwox1bJjWLJqSgcfa0awC6USbi0Nf
 U9bZJAbu2+rAeYmDFVrAXIp7ruBASpzX6QP6gPPjUByI2iZBnk1Fog/wFVZHvfqYU38/wrLoIg
 o9yNzMe2paRPu3RPanNpjJzi6mGL7Lb94r/a3kJQZCrHpf7XlDJWpWG5Q8/eJD9wrM6unlf8Su
 QDk=
WDCIronportException: Internal
Received: from washi.fujisawa.hgst.com ([10.149.53.254])
 by uls-op-cesaip01.wdc.com with ESMTP; 07 Nov 2019 17:57:13 -0800
From: Damien Le Moal <damien.lemoal@wdc.com>
To: linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
 linux-scsi@vger.kernel.org,
 "Martin K . Petersen" <martin.petersen@oracle.com>, dm-devel@redhat.com,
 Mike Snitzer <snitzer@redhat.com>, linux-f2fs-devel@lists.sourceforge.net,
 Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>
Date: Fri,  8 Nov 2019 10:56:59 +0900
Message-Id: <20191108015702.233102-7-damien.lemoal@wdc.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191108015702.233102-1-damien.lemoal@wdc.com>
References: <20191108015702.233102-1-damien.lemoal@wdc.com>
MIME-Version: 1.0
X-Headers-End: 1iStWe-004Ptm-EL
Subject: [f2fs-dev] [PATCH 6/9] null_blk: clean up report zones
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

From: Christoph Hellwig <hch@lst.de>

Make the instance name match the method name and define the name to NULL
instead of providing an inline stub, which is rather pointless for a
method call.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
---
 drivers/block/null_blk.h       | 11 +++--------
 drivers/block/null_blk_main.c  |  2 +-
 drivers/block/null_blk_zoned.c |  4 ++--
 3 files changed, 6 insertions(+), 11 deletions(-)

diff --git a/drivers/block/null_blk.h b/drivers/block/null_blk.h
index 93c2a3d403da..9bf56fbab091 100644
--- a/drivers/block/null_blk.h
+++ b/drivers/block/null_blk.h
@@ -91,8 +91,8 @@ struct nullb {
 #ifdef CONFIG_BLK_DEV_ZONED
 int null_zone_init(struct nullb_device *dev);
 void null_zone_exit(struct nullb_device *dev);
-int null_zone_report(struct gendisk *disk, sector_t sector,
-		     struct blk_zone *zones, unsigned int *nr_zones);
+int null_report_zones(struct gendisk *disk, sector_t sector,
+		      struct blk_zone *zones, unsigned int *nr_zones);
 blk_status_t null_handle_zoned(struct nullb_cmd *cmd,
 				enum req_opf op, sector_t sector,
 				sector_t nr_sectors);
@@ -105,12 +105,6 @@ static inline int null_zone_init(struct nullb_device *dev)
 	return -EINVAL;
 }
 static inline void null_zone_exit(struct nullb_device *dev) {}
-static inline int null_zone_report(struct gendisk *disk, sector_t sector,
-				   struct blk_zone *zones,
-				   unsigned int *nr_zones)
-{
-	return -EOPNOTSUPP;
-}
 static inline blk_status_t null_handle_zoned(struct nullb_cmd *cmd,
 					     enum req_opf op, sector_t sector,
 					     sector_t nr_sectors)
@@ -123,5 +117,6 @@ static inline size_t null_zone_valid_read_len(struct nullb *nullb,
 {
 	return len;
 }
+#define null_report_zones	NULL
 #endif /* CONFIG_BLK_DEV_ZONED */
 #endif /* __NULL_BLK_H */
diff --git a/drivers/block/null_blk_main.c b/drivers/block/null_blk_main.c
index 89d385bab45b..2687eb36441c 100644
--- a/drivers/block/null_blk_main.c
+++ b/drivers/block/null_blk_main.c
@@ -1444,7 +1444,7 @@ static void null_config_discard(struct nullb *nullb)
 
 static const struct block_device_operations null_ops = {
 	.owner		= THIS_MODULE,
-	.report_zones	= null_zone_report,
+	.report_zones	= null_report_zones,
 };
 
 static void null_init_queue(struct nullb *nullb, struct nullb_queue *nq)
diff --git a/drivers/block/null_blk_zoned.c b/drivers/block/null_blk_zoned.c
index 02f41a3bc4cb..00696f16664b 100644
--- a/drivers/block/null_blk_zoned.c
+++ b/drivers/block/null_blk_zoned.c
@@ -66,8 +66,8 @@ void null_zone_exit(struct nullb_device *dev)
 	kvfree(dev->zones);
 }
 
-int null_zone_report(struct gendisk *disk, sector_t sector,
-		     struct blk_zone *zones, unsigned int *nr_zones)
+int null_report_zones(struct gendisk *disk, sector_t sector,
+		      struct blk_zone *zones, unsigned int *nr_zones)
 {
 	struct nullb *nullb = disk->private_data;
 	struct nullb_device *dev = nullb->dev;
-- 
2.23.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
