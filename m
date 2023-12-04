Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2CDCC4167B
	for <linux-f2fs-devel@archiver.kernel.org>; Mon,  4 Dec 2023 18:05:32 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1rADJz-0006eh-T6;
	Mon, 04 Dec 2023 18:05:31 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <jaegeuk@kernel.org>) id 1rADJp-0006eb-0D
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 04 Dec 2023 18:05:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Qu2RYnE4w04GzUb84LXo4r2mK/f+/R1xC48mOPscul4=; b=Ig/VjqQeGRDczVHTvogHFC86As
 k+x12NCisV2d31mQA68hXNvYVyfZusnHeGd53U25tbNLdZDE+EGgptu6OnT2ylV7I+c0uud8L89rR
 87HhHy5oyGeOsuVN8j5vG16jS09aQsXMA2+OMT9ywLBVRk6RXOqPhaiGm4dMg2exE+f4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=Qu2RYnE4w04GzUb84LXo4r2mK/f+/R1xC48mOPscul4=; b=XSrlWsgnaIdFY01R51dti/vzTO
 PRPSWyijumMcIwvHEath/Z6gAXY55MbFzw/Q/ygTqvIAzPj6V2IFC6HY62Pi7TunlzSkOcelBDQ9I
 +SxCpVvsxu0B7+PsqkZQb6tr6s3YnS21NFO5jtVLlBV1C+tWnxINYXzHBLzsKOQTej8k=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1rADJl-0003U2-Ny for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 04 Dec 2023 18:05:19 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 400F9612AF
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon,  4 Dec 2023 18:04:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63F04C433C7;
 Mon,  4 Dec 2023 18:04:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1701713074;
 bh=PwUOwNlOAh2R10G7w1lvJbSsW8uLBZf2Vd4s/Pbn7C8=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=i9AVu69ZIryiI3PhsohcgkW8Ue+YPlthWMUoLAFbugh0wVR0eRz52wYTvFetN7lLM
 Ayvhjb1AWpSA7eXj0iPh/lPKVtfQ3okc92q0NVjScrt7EMybF59PIyaL5i35o0omPk
 DH8fpVlcfLJ4GzcsktlKTHNrd63uPfr43VSxb/Pynleq5c4BKvZb84za+YKO9bfMeM
 Mt+umIlYcJw42krd+AtLNbJoAf8tJFx9dO67tOcW6slFzyRPyq9IGL97O05PvCp1n4
 ZHL1k3iv8Nja/QL8IBtFLS/Zc+tYm7QMtuZx9aANQUksIkTr5LhjWKdecJnoTvl91L
 ucNJDY53woRnQ==
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: linux-kernel@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net
Date: Mon,  4 Dec 2023 10:04:28 -0800
Message-ID: <20231204180428.925779-4-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
In-Reply-To: <20231204180428.925779-1-jaegeuk@kernel.org>
References: <20231204180428.925779-1-jaegeuk@kernel.org>
MIME-Version: 1.0
X-Headers-End: 1rADJl-0003U2-Ny
Subject: [f2fs-dev] [PATCH 4/4] f2fs: let's finish or reset zones all the
 time
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

In order to limit # of open zones, let's finish or reset zones given # of
valid blocks per section and its zone condition.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/segment.c | 74 +++++++++++------------------------------------
 1 file changed, 17 insertions(+), 57 deletions(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 9081c9af977a..5696a4d381ff 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -4870,82 +4870,44 @@ static int check_zone_write_pointer(struct f2fs_sb_info *sbi,
 				    struct f2fs_dev_info *fdev,
 				    struct blk_zone *zone)
 {
-	unsigned int wp_segno, wp_blkoff, zone_secno, zone_segno, segno;
-	block_t zone_block, wp_block, last_valid_block;
+	unsigned int zone_segno;
+	block_t zone_block, wp_block, valid_block_cnt;
 	unsigned int log_sectors_per_block = sbi->log_blocksize - SECTOR_SHIFT;
-	int i, s, b, ret;
-	struct seg_entry *se;
+	int ret;
 
 	if (zone->type != BLK_ZONE_TYPE_SEQWRITE_REQ)
 		return 0;
 
 	wp_block = fdev->start_blk + (zone->wp >> log_sectors_per_block);
-	wp_segno = GET_SEGNO(sbi, wp_block);
-	wp_blkoff = wp_block - START_BLOCK(sbi, wp_segno);
 	zone_block = fdev->start_blk + (zone->start >> log_sectors_per_block);
 	zone_segno = GET_SEGNO(sbi, zone_block);
-	zone_secno = GET_SEC_FROM_SEG(sbi, zone_segno);
-
-	if (zone_segno >= MAIN_SEGS(sbi))
-		return 0;
 
 	/*
 	 * Skip check of zones cursegs point to, since
 	 * fix_curseg_write_pointer() checks them.
 	 */
-	for (i = 0; i < NO_CHECK_TYPE; i++)
-		if (zone_secno == GET_SEC_FROM_SEG(sbi,
-						   CURSEG_I(sbi, i)->segno))
-			return 0;
+	if (zone_segno >= MAIN_SEGS(sbi) ||
+	    IS_CURSEC(sbi, GET_SEC_FROM_SEG(sbi, zone_segno)))
+		return 0;
 
 	/*
-	 * Get last valid block of the zone.
+	 * Get # of valid block of the zone.
 	 */
-	last_valid_block = zone_block - 1;
-	for (s = sbi->segs_per_sec - 1; s >= 0; s--) {
-		segno = zone_segno + s;
-		se = get_seg_entry(sbi, segno);
-		for (b = sbi->blocks_per_seg - 1; b >= 0; b--)
-			if (f2fs_test_bit(b, se->cur_valid_map)) {
-				last_valid_block = START_BLOCK(sbi, segno) + b;
-				break;
-			}
-		if (last_valid_block >= zone_block)
-			break;
-	}
+	valid_block_cnt = get_valid_blocks(sbi, zone_segno, true);
 
-	/*
-	 * When safely unmounted in the previous mount, we can trust write
-	 * pointers. Otherwise, finish zones.
-	 */
-	if (is_set_ckpt_flags(sbi, CP_UMOUNT_FLAG)) {
-		/*
-		 * The write pointer matches with the valid blocks or
-		 * already points to the end of the zone.
-		 */
-		if ((last_valid_block + 1 == wp_block) ||
-				(zone->wp == zone->start + zone->len))
-			return 0;
-	}
+	if ((!valid_block_cnt && zone->cond == BLK_ZONE_COND_EMPTY) ||
+	    (valid_block_cnt && zone->cond == BLK_ZONE_COND_FULL))
+		return 0;
 
-	if (last_valid_block + 1 == zone_block) {
-		if (is_set_ckpt_flags(sbi, CP_UMOUNT_FLAG)) {
-			/*
-			 * If there is no valid block in the zone and if write
-			 * pointer is not at zone start, reset the write
-			 * pointer.
-			 */
-			f2fs_notice(sbi,
-			      "Zone without valid block has non-zero write "
-			      "pointer. Reset the write pointer: wp[0x%x,0x%x]",
-			      wp_segno, wp_blkoff);
-		}
+	if (!valid_block_cnt) {
+		f2fs_notice(sbi, "Zone without valid block has non-zero write "
+			    "pointer. Reset the write pointer: cond[0x%x]",
+			    zone->cond);
 		ret = __f2fs_issue_discard_zone(sbi, fdev->bdev, zone_block,
 					zone->len >> log_sectors_per_block);
 		if (ret)
 			f2fs_err(sbi, "Discard zone failed: %s (errno=%d)",
 				 fdev->path, ret);
-
 		return ret;
 	}
 
@@ -4957,10 +4919,8 @@ static int check_zone_write_pointer(struct f2fs_sb_info *sbi,
 	 * selected for write operation until it get discarded.
 	 */
 	f2fs_notice(sbi, "Valid blocks are not aligned with write "
-			    "pointer: valid block[0x%x,0x%x] wp[0x%x,0x%x]",
-			    GET_SEGNO(sbi, last_valid_block),
-			    GET_BLKOFF_FROM_SEG0(sbi, last_valid_block),
-			    wp_segno, wp_blkoff);
+		    "pointer: valid block[0x%x,0x%x] cond[0x%x]",
+		    zone_segno, valid_block_cnt, zone->cond);
 
 	ret = blkdev_zone_mgmt(fdev->bdev, REQ_OP_ZONE_FINISH,
 				zone->start, zone->len, GFP_NOFS);
-- 
2.43.0.rc2.451.g8631bc7472-goog



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
