Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1D99C3DA4A
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 16 Aug 2024 04:07:21 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1seoFE-0005XQ-0o;
	Fri, 16 Aug 2024 04:07:20 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <prvs=9510baa95=shinichiro.kawasaki@wdc.com>)
 id 1seoF5-0005XG-ER for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 16 Aug 2024 04:07:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=R2zo8GlS0/lCcPSCaLXx72V6F1oz0fMkSh+qR2fiOd0=; b=DrMtzmqO02RM5SJ7KeqVAYwmiq
 p35zPDInc/+DQDtNWnQvTmr45szMsGVoV4AmmEKYSDX+oSO5TP41n8SCAIrFlmzAcFuAtAqYCQ/h5
 rAmqoS28aiHdoZ8AlqDrShlutnQRvRVKdsZUjfrc0It1W2jLOLePXVm2LCQ5yAy5pIS8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=R2zo8GlS0/lCcPSCaLXx72V6F1oz0fMkSh+qR2fiOd0=; b=X
 5w3jmcQHWSCxs6IMo98ZhOuC0QOX33E5mBriqKT8Xm9/l38uInWp/5416FsbEpWfAjFewf+wrmyfS
 86ArjETrg3t6pxJiw/t4hOjYZXKmaJh9TGeeXUgld1eoSNNTKZJ/K9lDD+g4HNEPqwz41sUAqRwcT
 qxBfeFD6Hq9KI4Do=;
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1seoF5-0007en-7g for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 16 Aug 2024 04:07:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1723781231; x=1755317231;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=Mjq4b8vuWHlvt6zvqXCQEUF4HiK39uu1LADOAFKuvLY=;
 b=MRxvz3e6xtZ8XleGn8U7GKJk5XmOeLoGKf6euzq/vhQgUUQMitEFxtE4
 U/t28+PkVMz3Rkp6GXptyV1dQEovD1PaKc1y30J++ueCIesV7INkQXFur
 1zroTKeou8SAzZ2eg5USvh93xLHQcWK1dLIb9AK9/Jbz2GitxT53Oo37S
 XBuHPogD92AOuq9PrxEgGEgkqYScej8R8LuZlGo5Yxw1jzNag7KDFw+jS
 OfwLvQbEZxSFHt8FVIh5GbJvoF2KoQArfD+VFJX7Wya9yXfehuCPJIevk
 LBJxqagoQvHklleV7hMWAn6wMGudlpFjfEtAzVJuu2/RoohP8QPe4A8Dd A==;
X-CSE-ConnectionGUID: QI3dI2IfTIudmy+XlZBWbw==
X-CSE-MsgGUID: trylf9LzS/u4kmvfUBSH9w==
X-IronPort-AV: E=Sophos;i="6.10,150,1719849600"; d="scan'208";a="25120543"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 16 Aug 2024 12:07:05 +0800
IronPort-SDR: 66bec3b8_xQtp/21XxEZ3WBWIkNwiaz94VMKD+VvfV/cAthrHU3hQSUE
 i0ZTfAv/VXYXnO0jEUIHyKycORkbRBHBJ3a71vw==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 15 Aug 2024 20:12:57 -0700
WDCIronportException: Internal
Received: from unknown (HELO shindev.ssa.fujisawa.hgst.com) ([10.149.66.30])
 by uls-op-cesaip02.wdc.com with ESMTP; 15 Aug 2024 21:07:05 -0700
To: linux-f2fs-devel@lists.sourceforge.net, Jaegeuk Kim <jaegeuk@kernel.org>,
 Chao Yu <chao@kernel.org>
Date: Fri, 16 Aug 2024 13:07:03 +0900
Message-ID: <20240816040703.736887-1-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
X-Headers-End: 1seoF5-0007en-7g
Subject: [f2fs-dev] [PATCH v2] f2fs: check discard support for conventional
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
bdev_max_discard_sectors() and bdev_is_zoned(). This check works well
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
commit, __blkdev_issue_discard() no longer checks it. It always returns
zero and sets NULL to the given bio pointer. This NULL pointer triggers
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
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
---
Changes from v1:
* Removed the else, added the comment and improved commit message wording

 fs/f2fs/segment.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 78c3198a6308..f49cc404b2f2 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -1282,6 +1282,13 @@ static int __submit_discard_cmd(struct f2fs_sb_info *sbi,
 						wait_list, issued);
 			return 0;
 		}
+
+		/*
+		 * Issue discard for conventional zones only if the device
+		 * supports discard.
+		 */
+		if (!bdev_max_discard_sectors(bdev))
+			return -EOPNOTSUPP;
 	}
 #endif
 
-- 
2.45.2



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
