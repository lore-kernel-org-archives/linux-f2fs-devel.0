Return-Path: <SRS0=SvoF=FW=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8221C2BBD5
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 18 Dec 2020 16:18:32 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9ACD123B76;
	Fri, 18 Dec 2020 16:18:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9ACD123B76
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1kqISe-0006u0-4r; Fri, 18 Dec 2020 16:18:32 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <jaegeuk@kernel.org>) id 1kqIS1-0006sM-Uf
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 18 Dec 2020 16:17:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=wjvj7sjYZlcn00ibrICBRwU3OJf3233q+BRqMD1o0ac=; b=k0e/f5uRAZLt17LL6I7mnsRHe8
 JaGN4YGRyTLFFxHaqhmyGK8IGNFqH8lUyr+/7xa+RUwlsFJsZzrxd/UzuUMUcano8TGsKIBfZasHW
 R13go+vvf0QlFuaMPaIKkPQWajutSEWsfkgCB3HIgx4a1+73p9VDenEdQS5Xrw1etRdo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=wjvj7sjYZlcn00ibrICBRwU3OJf3233q+BRqMD1o0ac=; b=O5VTaSPOwJW/l9hi7c4B8qpAwR
 RLApi/VJ+niWMoCu+ro2yZDgxc4LWdet8B/gqPPy+C32Lyx8nY2Fiux6YhI05fPYfabkMpTe8am1h
 KdQ7P1ujc5SJoz4L3r81SluNxztqShjqy/WTI7limA2QyJ9LuuC3OxKR8qgQQrAMxJjg=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1kqIRt-001TqO-HF
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 18 Dec 2020 16:17:53 +0000
From: Jaegeuk Kim <jaegeuk@kernel.org>
Authentication-Results: mail.kernel.org;
 dkim=permerror (bad message/signature format)
To: linux-f2fs-devel@lists.sourceforge.net
Date: Fri, 18 Dec 2020 08:17:07 -0800
Message-Id: <20201218161708.927900-2-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.29.2.729.g45daf8777d-goog
In-Reply-To: <20201218161708.927900-1-jaegeuk@kernel.org>
References: <20201218161708.927900-1-jaegeuk@kernel.org>
MIME-Version: 1.0
X-Headers-End: 1kqIRt-001TqO-HF
Subject: [f2fs-dev] [PATCH 2/3] mkfs.f2fs: adjust zone alignment when using
 multi-partitions
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
Cc: Jaegeuk Kim <jaegeuk@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

When formatting conventional partition with zoned one, we should align
the starting block address of next device to the zone size.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 mkfs/f2fs_format.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/mkfs/f2fs_format.c b/mkfs/f2fs_format.c
index a6c542e8e1f0..f60dcc029d58 100644
--- a/mkfs/f2fs_format.c
+++ b/mkfs/f2fs_format.c
@@ -254,14 +254,22 @@ static int f2fs_prepare_super_block(void)
 			return -1;
 	}
 
+	if (c.zoned_mode && c.ndevs > 1)
+		zone_align_start_offset +=
+			(c.devices[0].total_sectors * c.sector_size) % zone_size_bytes;
+
 	set_sb(segment0_blkaddr, zone_align_start_offset / blk_size_bytes);
 	sb->cp_blkaddr = sb->segment0_blkaddr;
 
 	MSG(0, "Info: zone aligned segment0 blkaddr: %u\n",
 					get_sb(segment0_blkaddr));
 
-	if (c.zoned_mode && (get_sb(segment0_blkaddr) + c.start_sector /
-					DEFAULT_SECTORS_PER_BLOCK) % c.zone_blocks) {
+	if (c.zoned_mode &&
+		((c.ndevs == 1 &&
+			(get_sb(segment0_blkaddr) + c.start_sector /
+			DEFAULT_SECTORS_PER_BLOCK) % c.zone_blocks) ||
+		(c.ndevs > 1 &&
+			c.devices[1].start_blkaddr % c.zone_blocks))) {
 		MSG(1, "\tError: Unaligned segment0 block address %u\n",
 				get_sb(segment0_blkaddr));
 		return -1;
-- 
2.29.2.729.g45daf8777d-goog



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
