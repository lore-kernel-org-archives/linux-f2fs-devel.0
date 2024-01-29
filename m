Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52CF7C48286
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 29 Jan 2024 08:08:32 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1rUMgx-0006r2-EI;
	Mon, 29 Jan 2024 08:08:31 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <prvs=751dad7dd=johannes.thumshirn@wdc.com>)
 id 1rUMgs-0006qV-GL for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 29 Jan 2024 08:08:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Message-Id:
 Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=kjczz8mPkeKokmXTN6NURwCatsfIVh3T4Cfy2Zqik+o=; b=H8rB6iNht987mFU114uK9sKmJU
 qQnpD9x6Gm4CfPRfvqTpnvp1Zve9lz8c01yUQXhESZpkHiTEMwx3dfXNV8lDNfrJKNpfdF0GXEFkV
 xSvKm3Ig2iJVUKf1GCvMfUnsgitqNshacw5cwQuOuc5GsNpVT9o4KnM+PJiLSDhQw+aE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Cc:To:In-Reply-To:References:Message-Id:Content-Transfer-Encoding:
 Content-Type:MIME-Version:Subject:Date:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=kjczz8mPkeKokmXTN6NURwCatsfIVh3T4Cfy2Zqik+o=; b=ZQy9/rLpXmUD8zZbo40dhxxh6K
 mfbM543mW2t+bNpyMSOJOoGatiTJvtpgggy1dEiuoz6I+n20iOqV6ikXgYLk+leaftM8Ra01cUF4v
 cu6qOm94e7Q451i9qiaZgY3JY4LZIiWwpWuBtJGOJ6+75u4HP6YRraUFO0lixV9n7cQE=;
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1rUMgq-00039w-Ir for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 29 Jan 2024 08:08:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1706515705; x=1738051705;
 h=from:date:subject:mime-version:content-transfer-encoding:
 message-id:references:in-reply-to:to:cc;
 bh=CVSDtwbfJeIFTP08Wyxu5GIZXiQgdv2rMRXO0YSre0A=;
 b=okm64uilgLyrBU4nuUEeU8SUQFJ8TXjsMgVcGUp5+rKx3XTKViD9zf56
 Jkn35LOqcJSCMNoMu5Lcab589iiQFoUijWn3hqp/WdNI4velFCyq54bbq
 c8kd7Uek5oqgfMxW/Fv46yU4X4NTx5rLRWzG9uYVgIku7kqXe0jRdiRXi
 FGba4H6oJ4s+AFiL++wj8JyT/4lWrJxYXRsATaChNnbf3IjbFPpCR0moX
 xXL2IPrV7txrUtTlUqshSTacyK/J9QZUNBz+ceJeiOKRYvz6sDA0yAUxs
 Yez7cVeHIHLkKYAh6rx85RfDg80pBrxDtb3GvuFXw1Pg84Orfb8Jm9Ovh w==;
X-CSE-ConnectionGUID: RMWM9RxJTcCmmRGMfy+liw==
X-CSE-MsgGUID: CzUjn5J6SQqta4+dQHQLKQ==
X-IronPort-AV: E=Sophos;i="6.05,226,1701100800"; 
   d="scan'208";a="7664669"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 29 Jan 2024 15:52:34 +0800
IronPort-SDR: nDR6+y8W0HTmXgbWP+tQK/et86p6OUj//beIdnhbNtUA6ufQ/Vku9yAn+n2Us58bI7cs/yfppA
 RdUA1aqh1eQw==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 28 Jan 2024 22:56:49 -0800
IronPort-SDR: X23CH+3d3A3FF6NEzAAKeGeexyHJK2ijaqA78yg+E155A1PkvJ9a3HFhhD042eDEA3L5FpbOTj
 Kt5GBf8LBQfw==
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.6])
 by uls-op-cesaip02.wdc.com with ESMTP; 28 Jan 2024 23:52:31 -0800
Date: Sun, 28 Jan 2024 23:52:17 -0800
MIME-Version: 1.0
Message-Id: <20240128-zonefs_nofs-v3-2-ae3b7c8def61@wdc.com>
References: <20240128-zonefs_nofs-v3-0-ae3b7c8def61@wdc.com>
In-Reply-To: <20240128-zonefs_nofs-v3-0-ae3b7c8def61@wdc.com>
To: Damien Le Moal <dlemoal@kernel.org>, 
 Naohiro Aota <naohiro.aota@wdc.com>, Johannes Thumshirn <jth@kernel.org>, 
 Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>, 
 Mikulas Patocka <mpatocka@redhat.com>, dm-devel@lists.linux.dev, 
 Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, 
 David Sterba <dsterba@suse.com>, Jaegeuk Kim <jaegeuk@kernel.org>, 
 Chao Yu <chao@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
 Chaitanya Kulkarni <kch@nvidia.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1706514743; l=1101;
 i=johannes.thumshirn@wdc.com; s=20230613; h=from:subject:message-id;
 bh=CVSDtwbfJeIFTP08Wyxu5GIZXiQgdv2rMRXO0YSre0A=;
 b=yRnVuaXdTnXKe1OQL8z+2PQD65t2opZ+cZ1QIFwSpziKiiFJonren+b9FfKdwqrq5iL08iJ5r
 oHOIOYDruwGAUlsSl5D+/sgv4o0Bwq7ylNk0fIqz52NebMmJzP0AEnu
X-Developer-Key: i=johannes.thumshirn@wdc.com; a=ed25519;
 pk=TGmHKs78FdPi+QhrViEvjKIGwReUGCfa+3LEnGoR2KM=
X-Headers-End: 1rUMgq-00039w-Ir
Subject: [f2fs-dev] [PATCH v3 2/5] dm: dm-zoned: guard blkdev_zone_mgmt with
 noio scope
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
From: Johannes Thumshirn via Linux-f2fs-devel
 <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc: Johannes Thumshirn <johannes.thumshirn@wdc.com>,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-f2fs-devel@lists.sourceforge.net, linux-block@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Guard the calls to blkdev_zone_mgmt() with a memalloc_noio scope.
This helps us getting rid of the GFP_NOIO argument to blkdev_zone_mgmt();

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 drivers/md/dm-zoned-metadata.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/md/dm-zoned-metadata.c b/drivers/md/dm-zoned-metadata.c
index fdfe30f7b697..165996cc966c 100644
--- a/drivers/md/dm-zoned-metadata.c
+++ b/drivers/md/dm-zoned-metadata.c
@@ -1655,10 +1655,13 @@ static int dmz_reset_zone(struct dmz_metadata *zmd, struct dm_zone *zone)
 
 	if (!dmz_is_empty(zone) || dmz_seq_write_err(zone)) {
 		struct dmz_dev *dev = zone->dev;
+		unsigned int noio_flag;
 
+		noio_flag = memalloc_noio_save();
 		ret = blkdev_zone_mgmt(dev->bdev, REQ_OP_ZONE_RESET,
 				       dmz_start_sect(zmd, zone),
-				       zmd->zone_nr_sectors, GFP_NOIO);
+				       zmd->zone_nr_sectors, GFP_KERNEL);
+		memalloc_noio_restore(noio_flag);
 		if (ret) {
 			dmz_dev_err(dev, "Reset zone %u failed %d",
 				    zone->id, ret);

-- 
2.43.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
