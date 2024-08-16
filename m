Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82ADFC52D7D
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 16 Aug 2024 02:39:50 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1semsY-00064J-5p;
	Fri, 16 Aug 2024 02:39:50 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <prvs=9510baa95=shinichiro.kawasaki@wdc.com>)
 id 1semsX-00064C-GF for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 16 Aug 2024 02:39:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=XSEUeT/CI5bARzxi86gS+1oNfAelKQrQs7vVD3ch538=; b=if4pQZfw1ioRMVvOJNwZr1V2cK
 8S6I4tgoz028UI7gnSckp0cac9Gi8sjillRi2iFoH7iIIeegcgU0AWrAj+VFgeyqKN7zpx2HqtMVa
 3DBgbdBfe5zGOonBfjbJRFbactENdWr13U7tQKULFmJDxVp7dmPNTmnF2QM9Ov16gf1I=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=XSEUeT/CI5bARzxi86gS+1oNfAelKQrQs7vVD3ch538=; b=h
 c6Z/VSoeR91gGABIfvqS1QTpPgn0Hs7SaXSaXmVBYYTKht3k39auVPC0EVDsXPLCbMrRn+55+CDHI
 fSBqQQTpfDnMo2BGdeLE2HtB5+PRRxcnodM0tRC86yThk4AnoTMy7yPLbh1t/VQ89oNb0l36LDSqj
 i2a2J3SCklxbFKxg=;
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1semsW-0003Ec-NX for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 16 Aug 2024 02:39:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1723775988; x=1755311988;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=hca7Vzxw1LdMm4ffrEiopMwKnDTrx2xPmdSVOu+GHhI=;
 b=VwVmSpsXj6pXxYyy4/mgCJSpC4BeinF969Eubil4EqmqEg0bdnf0yMqO
 k2N0WgBWAemOR7tDfh6FLxRBsFsj4FSEB1KvHrcIv4gQ5SXbnejzIgRFc
 jac4somaYyTuebL9H85wKaAaXifCqnTetJtH520OWAOaCVeC0PGaGCXAw
 AmQ3xC0rWU12xoEBeLnDtWpSYmoUV0dMrD+6uKgwXdRamqWqw56JyaZjE
 yrekszm/eNz1LJPrKWDvXYn56Fz/bh8JrVDYl9ujZNjsEW8Ks9U/6kqbY
 J28LboTkzBfzZjGf4ksnnN6PvXvkaFO5Y+CSHKCRujHty97VPG3tv0C8h w==;
X-CSE-ConnectionGUID: v6YaGXsKTYuWxf1cWV7ETA==
X-CSE-MsgGUID: Qzv55dOfQ2mdp1yz/HS45g==
X-IronPort-AV: E=Sophos;i="6.10,150,1719849600"; d="scan'208";a="25114139"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 16 Aug 2024 10:23:55 +0800
IronPort-SDR: 66beab8a_u6sRJfZqcccKRViSs5NA/bRSsMJ1cmkW7HqeEvXngvBT3Ik
 /HAImrrjeEqNI5c4/WZ3ppdE0AXJknWZR3svXSg==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 15 Aug 2024 18:29:47 -0700
WDCIronportException: Internal
Received: from unknown (HELO shindev.ssa.fujisawa.hgst.com) ([10.149.66.30])
 by uls-op-cesaip02.wdc.com with ESMTP; 15 Aug 2024 19:23:54 -0700
To: linux-f2fs-devel@lists.sourceforge.net, Jaegeuk Kim <jaegeuk@kernel.org>,
 Chao Yu <chao@kernel.org>
Date: Fri, 16 Aug 2024 11:23:53 +0900
Message-ID: <20240816022353.734136-1-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
X-Headers-End: 1semsW-0003Ec-NX
Subject: [f2fs-dev] [PATCH] f2fs: check discard support for conventional
 zones
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
From: Shin'ichiro Kawasaki via Linux-f2fs-devel
 <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: Christoph Hellwig <hch@infradead.org>,
 Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 Damien Le Moal <dlemoal@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

As the helper function f2fs_bdev_support_discard() shows, f2fs checks if
the target block devices support discard by calling
bdev_max_discard_sectors() and bdev_is_zoned(). This check works good
for most cases, but it does not work for conventional zones on zoned
block devices. F2fs assumes that zoned block devices support discard,
and calls __submit_discard_cmd(). When __submit_discard_cmd() is called
for sequential write required zones, it works fine since
__submit_discard_cmd() issues zone reset commands instead of discard
commands. However, when __submit_discard_cmd() is called for
conventional zones, __blkdev_issue_discard() is called even when the
devices do not support discard.

The inappropriate __blkdev_issue_discard() call was not a problem before
the commit 30f1e7241422 ("block: move discard checks into the ioctl
handler") because __blkdev_issue_discard() checked if the target devices
support discard or not. If not, it returned EOPNOTSUPP. After the
commit, __blkdev_issue_discard() no longer checks it and always returns
zero and sets NULL to the give bio pointer. This NULL pointer triggers
f2fs_bug_on() in __submit_discard_cmd(). The BUG is recreated with the
commands below at the umount step, where /dev/nullb0 is a zoned null_blk
with 5GB total size, 128MB zone size and 10 conventional zones.

$ mkfs.f2fs -f -m /dev/nullb0
$ mount /dev/nullb0 /mnt
$ for ((i=0;i<5;i++)); do dd if=/dev/zero of=/mnt/test bs=65536 count=1600 conv=fsync; done
$ umount /mnt

To fix the BUG, avoid the inappropriate __blkdev_issue_discard() call.
When discard is requested for conventional zones, check if the device
supports discard or not. If not, return EOPNOTSUPP.

Fixes: 30f1e7241422 ("block: move discard checks into the ioctl handler")
Cc: stable@vger.kernel.org
Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 fs/f2fs/segment.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 78c3198a6308..e10bf3c4eed5 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -1281,6 +1281,8 @@ static int __submit_discard_cmd(struct f2fs_sb_info *sbi,
 			__submit_zone_reset_cmd(sbi, dc, flag,
 						wait_list, issued);
 			return 0;
+		} else if (!bdev_max_discard_sectors(bdev)) {
+			return -EOPNOTSUPP;
 		}
 	}
 #endif
-- 
2.45.2



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
