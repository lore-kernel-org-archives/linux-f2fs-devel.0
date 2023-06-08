Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC1E7C7EE23
	for <linux-f2fs-devel@archiver.kernel.org>; Thu,  8 Jun 2023 11:03:43 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1q7DQc-0000q1-Jn;
	Thu, 08 Jun 2023 11:03:43 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95) (envelope-from
 <BATV+69acd89764e6999cdd63+7228+infradead.org+hch@bombadil.srs.infradead.org>)
 id 1q7DQb-0000n8-0L for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 08 Jun 2023 11:03:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=2YKg/eBeG7k8nyypHzoUOIcGXCrUmN8sX6dr3VGobXE=; b=gZxI1rSy3eSUYmh2FIsXsw22rM
 nWR4iDynlCeQAgvIhIdMyx2yst35fKyOc4+DWp0U9PeGSuBMB35+6CYwwGioxWGSLiBOQP9BTeKsN
 FqjUG8eID/EpfJGOnik7C8asky9tGyVd9nE6cHZk+3rBK5YJ5CSz1/73LtMf03hWXCtY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=2YKg/eBeG7k8nyypHzoUOIcGXCrUmN8sX6dr3VGobXE=; b=kVM9QpHUiS8ZL1Xub3P9axq9CE
 JwboaFlop8i5xtrSo8+DQea5NUQ9ZDDtEGtoAxLi42meKGXlpiTnDhC6uGvbJ/Dsn1esDblB4capT
 KAiKkJjo54gTVq63/ZUC3RJvhfV36p+c/TEqDVkNt7PHm3+UEM+sX1v02X2VhcYSDZGE=;
Received: from bombadil.infradead.org ([198.137.202.133])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1q7DQb-0000OF-AC for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 08 Jun 2023 11:03:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-Type:Content-ID:Content-Description;
 bh=2YKg/eBeG7k8nyypHzoUOIcGXCrUmN8sX6dr3VGobXE=; b=Napi92pVYXA9Kd9qbxDMHzX/oO
 qQIawIE2huf2CzL0FRlgVf8ANR9fNOL8VnA9aKO3f+32pJtsG14xXvwLTIoBdLJlOsqtyakSrP0dC
 bStESUw+/6WeL+Owawosge7/1ywBsJkWLGtACUok6qNYw/kF2lycFigMZiEPT1SRK20hgltadGibH
 1JuH+aRe0oLl4MuD7pGyAtcboP3p+Z/U9WhDVOzwqJm7hlw07ZCPeIKakwPmV6MROTmyQAFK4A/Hd
 zcS+LWzz9h+PFLJ6Wn6d4J25a95+kPeIIpyKnUvLzWB4smboEZl4GRLfq9cdAqh/2ApC6vZnT5dcB
 Bvo/G9PA==;
Received: from
 2a02-8389-2341-5b80-39d3-4735-9a3c-88d8.cable.dynamic.v6.surfer.at
 ([2a02:8389:2341:5b80:39d3:4735:9a3c:88d8] helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
 id 1q7DQB-0091io-11; Thu, 08 Jun 2023 11:03:15 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Date: Thu,  8 Jun 2023 13:02:33 +0200
Message-Id: <20230608110258.189493-6-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230608110258.189493-1-hch@lst.de>
References: <20230608110258.189493-1-hch@lst.de>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Headers-End: 1q7DQb-0000OF-AC
Subject: [f2fs-dev] [PATCH 05/30] cdrom: track if a cdrom_device_info was
 opened for data
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
 linux-mtd@lists.infradead.org, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Set a flag when a cdrom_device_info is opened for writing, instead of
trying to figure out this at release time.  This will allow to eventually
remove the mode argument to the ->release block_device_operation as
nothing but the CDROM drivers uses that argument.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Phillip Potter <phil@philpotter.co.uk>
Acked-by: Christian Brauner <brauner@kernel.org>
---
 drivers/cdrom/cdrom.c | 12 +++++-------
 include/linux/cdrom.h |  1 +
 2 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/cdrom/cdrom.c b/drivers/cdrom/cdrom.c
index 08abf1ffede002..adebac1bd210d9 100644
--- a/drivers/cdrom/cdrom.c
+++ b/drivers/cdrom/cdrom.c
@@ -1172,6 +1172,7 @@ int cdrom_open(struct cdrom_device_info *cdi, fmode_t mode)
 			ret = 0;
 			cdi->media_written = 0;
 		}
+		cdi->opened_for_data = true;
 	}
 
 	if (ret)
@@ -1252,7 +1253,6 @@ static int check_for_audio_disc(struct cdrom_device_info *cdi,
 void cdrom_release(struct cdrom_device_info *cdi, fmode_t mode)
 {
 	const struct cdrom_device_ops *cdo = cdi->ops;
-	int opened_for_data;
 
 	cd_dbg(CD_CLOSE, "entering cdrom_release\n");
 
@@ -1270,14 +1270,12 @@ void cdrom_release(struct cdrom_device_info *cdi, fmode_t mode)
 		}
 	}
 
-	opened_for_data = !(cdi->options & CDO_USE_FFLAGS) ||
-		!(mode & FMODE_NDELAY);
-
 	cdo->release(cdi);
-	if (cdi->use_count == 0) {      /* last process that closes dev*/
-		if (opened_for_data &&
-		    cdi->options & CDO_AUTO_EJECT && CDROM_CAN(CDC_OPEN_TRAY))
+
+	if (cdi->use_count == 0 && cdi->opened_for_data) {
+		if (cdi->options & CDO_AUTO_EJECT && CDROM_CAN(CDC_OPEN_TRAY))
 			cdo->tray_move(cdi, 1);
+		cdi->opened_for_data = false;
 	}
 }
 EXPORT_SYMBOL(cdrom_release);
diff --git a/include/linux/cdrom.h b/include/linux/cdrom.h
index 0a5db0b0c958a1..adcc9f2beb2653 100644
--- a/include/linux/cdrom.h
+++ b/include/linux/cdrom.h
@@ -63,6 +63,7 @@ struct cdrom_device_info {
 	unsigned short mmc3_profile;	/* current MMC3 profile */
 	int (*exit)(struct cdrom_device_info *);
 	int mrw_mode_page;
+	bool opened_for_data;
 	__s64 last_media_change_ms;
 };
 
-- 
2.39.2



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
