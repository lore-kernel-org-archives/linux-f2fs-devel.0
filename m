Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F12D5CD5BB3
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 22 May 2026 07:00:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:Message-ID:Date:To:Sender:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=TWYNMDLCDKUfYqKjDyI2tVONjBQztSNpdSBPxFReYVU=; b=MIFEvjFPI/pgEUhldbC2UQK0RU
	RW/C/s/cUstojhIVneVTK3jbSn2IpxGiSVFzF1/DfnvGOX7hOI8QrQLWt1XMCaNGLQm3jqbPVhy/b
	PpH649mlgUOutz17WWGhqS1ebF77QzT+dvFyYkIV2jwXXsl4pmp1GYH1Nzw/7cKtgCYs=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wQJrV-0005RS-Pd;
	Fri, 22 May 2026 07:00:02 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1wQJr9-0005QI-2z
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 22 May 2026 06:59:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=gmAkAlH6+SDoE0ZbfwLgNcAPs5kMifXSgNxPxnrx7XU=; b=eoGxdX2i/jzdaY4KDzAsa78+3I
 cFYO4WwL0d59RVGs/2k5ULX3NCy/v7c7EbIJ++pRhNdIhD2YkhHcY4MdYvTR8Y1xGI7hKDJKDgCuP
 2Cx45kgfdTp/QNgtOoIsgcMPOoEHzljBLXNn/v5Qq1qGoN9xKLeLi4zSCVXhDrtlyd9I=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=gmAkAlH6+SDoE0ZbfwLgNcAPs5kMifXSgNxPxnrx7XU=; b=f
 nSyrR3lgCQClwMJChxOBfAG79MKo7XtwOekJsiO0GmPGyXXMDoJo5kAzogFAR44xUSr/TNDClqWJ6
 aLVAGyB0REMDh0XIej3BoXFzPwPTKK9P5KDsrBCVogEgtuFABIZdgoUXm9pPpjHi2PS59mN0+fOHw
 niBZharh5VPMatLQ=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wQJr7-0000ZF-MY for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 22 May 2026 06:59:39 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id C239840126;
 Fri, 22 May 2026 06:59:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2829D1F00A3E;
 Fri, 22 May 2026 06:59:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1779433167;
 bh=gmAkAlH6+SDoE0ZbfwLgNcAPs5kMifXSgNxPxnrx7XU=;
 h=From:To:Cc:Subject:Date;
 b=CytKu+sPWWGSP3hsJa2huHgYlP+1EcQY8PSWT2Jfo7J1roLUA9Wp53zE6DohtpPKB
 IN8shqhTtYYjkl1XsStZ2DVqFnzRgexidY2p1W2plC1+kwjx59IsefCpGrASdQt82n
 VfVq+JlxsWiIDMbfhLxxLIEyU7ssICznrvUAXK7ktU7UIjutmZq0mEOCoF1Ec9YhzU
 FpBjF1D0SDQwIzazcrIlYcgP48sD1E37augi91S9WpEzMiWgx7ubROFPySXD2nVIOf
 XKfFYcGfT57D1vzrYA3togWSPaneRsEtU8IQtEhnFUpnRFs6pvaPnYezS1k3Oz2BQ9
 X7VAcpyS0cZSg==
To: jaegeuk@kernel.org
Date: Fri, 22 May 2026 14:59:11 +0800
Message-ID: <20260522065912.1756240-1-chao@kernel.org>
X-Mailer: git-send-email 2.54.0.746.g67dd491aae-goog
MIME-Version: 1.0
X-Headers-End: 1wQJr7-0000ZF-MY
Subject: [f2fs-dev] [PATCH 1/2] Revert: "f2fs: check in-memory block bitmap"
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
From: Chao Yu via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Chao Yu <chao@kernel.org>
Cc: linux-kernel@vger.kernel.org, wallentx <william.allentx@gmail.com>,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Commit 355e78913c0d ("f2fs: check in-memory block bitmap") added
a mirror for valid block bitmap, it expects to detect in-memory
corruption, however we never got any reports from the check points
for almost decade, let's remove the code, it can help to save
memories.

Cc: wallentx <william.allentx@gmail.com>
Suggested-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/segment.c | 38 --------------------------------------
 fs/f2fs/segment.h |  6 ------
 2 files changed, 44 deletions(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 1ef4edb77078..9926ba9d77ba 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -2455,9 +2455,6 @@ static int update_sit_entry_for_release(struct f2fs_sb_info *sbi, struct seg_ent
 				unsigned int segno, block_t blkaddr, unsigned int offset, int del)
 {
 	bool exist;
-#ifdef CONFIG_F2FS_CHECK_FS
-	bool mir_exist;
-#endif
 	int i;
 	int del_count = -del;
 
@@ -2465,15 +2462,6 @@ static int update_sit_entry_for_release(struct f2fs_sb_info *sbi, struct seg_ent
 
 	for (i = 0; i < del_count; i++) {
 		exist = f2fs_test_and_clear_bit(offset + i, se->cur_valid_map);
-#ifdef CONFIG_F2FS_CHECK_FS
-		mir_exist = f2fs_test_and_clear_bit(offset + i,
-						se->cur_valid_map_mir);
-		if (unlikely(exist != mir_exist)) {
-			f2fs_err(sbi, "Inconsistent error when clearing bitmap, blk:%u, old bit:%d",
-				blkaddr + i, exist);
-			f2fs_bug_on(sbi, 1);
-		}
-#endif
 		if (unlikely(!exist)) {
 			f2fs_err(sbi, "Bitmap was wrongly cleared, blk:%u", blkaddr + i);
 			f2fs_bug_on(sbi, 1);
@@ -2514,20 +2502,8 @@ static int update_sit_entry_for_alloc(struct f2fs_sb_info *sbi, struct seg_entry
 				unsigned int segno, block_t blkaddr, unsigned int offset, int del)
 {
 	bool exist;
-#ifdef CONFIG_F2FS_CHECK_FS
-	bool mir_exist;
-#endif
 
 	exist = f2fs_test_and_set_bit(offset, se->cur_valid_map);
-#ifdef CONFIG_F2FS_CHECK_FS
-	mir_exist = f2fs_test_and_set_bit(offset,
-					se->cur_valid_map_mir);
-	if (unlikely(exist != mir_exist)) {
-		f2fs_err(sbi, "Inconsistent error when setting bitmap, blk:%u, old bit:%d",
-			blkaddr, exist);
-		f2fs_bug_on(sbi, 1);
-	}
-#endif
 	if (unlikely(exist)) {
 		f2fs_err(sbi, "Bitmap was wrongly set, blk:%u", blkaddr);
 		f2fs_bug_on(sbi, 1);
@@ -4771,11 +4747,6 @@ void f2fs_flush_sit_entries(struct f2fs_sb_info *sbi, struct cp_control *cpc)
 			int offset, sit_offset;
 
 			se = get_seg_entry(sbi, segno);
-#ifdef CONFIG_F2FS_CHECK_FS
-			if (memcmp(se->cur_valid_map, se->cur_valid_map_mir,
-						SIT_VBLOCK_MAP_SIZE))
-				f2fs_bug_on(sbi, 1);
-#endif
 
 			/* add discard candidates */
 			if (!(cpc->reason & CP_DISCARD)) {
@@ -4866,11 +4837,7 @@ static int build_sit_info(struct f2fs_sb_info *sbi)
 	if (!sit_i->dirty_sentries_bitmap)
 		return -ENOMEM;
 
-#ifdef CONFIG_F2FS_CHECK_FS
-	bitmap_size = MAIN_SEGS(sbi) * SIT_VBLOCK_MAP_SIZE * (3 + discard_map);
-#else
 	bitmap_size = MAIN_SEGS(sbi) * SIT_VBLOCK_MAP_SIZE * (2 + discard_map);
-#endif
 	sit_i->bitmap = f2fs_kvzalloc(sbi, bitmap_size, GFP_KERNEL);
 	if (!sit_i->bitmap)
 		return -ENOMEM;
@@ -4884,11 +4851,6 @@ static int build_sit_info(struct f2fs_sb_info *sbi)
 		sit_i->sentries[start].ckpt_valid_map = bitmap;
 		bitmap += SIT_VBLOCK_MAP_SIZE;
 
-#ifdef CONFIG_F2FS_CHECK_FS
-		sit_i->sentries[start].cur_valid_map_mir = bitmap;
-		bitmap += SIT_VBLOCK_MAP_SIZE;
-#endif
-
 		if (discard_map) {
 			sit_i->sentries[start].discard_map = bitmap;
 			bitmap += SIT_VBLOCK_MAP_SIZE;
diff --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h
index 08735a165433..38a56b8ab2cc 100644
--- a/fs/f2fs/segment.h
+++ b/fs/f2fs/segment.h
@@ -177,9 +177,6 @@ struct seg_entry {
 	unsigned int ckpt_valid_blocks:10;	/* # of valid blocks last cp */
 	unsigned int padding:6;		/* padding */
 	unsigned char *cur_valid_map;	/* validity bitmap of blocks */
-#ifdef CONFIG_F2FS_CHECK_FS
-	unsigned char *cur_valid_map_mir;	/* mirror of current valid bitmap */
-#endif
 	/*
 	 * # of valid blocks and the validity bitmap stored in the last
 	 * checkpoint pack. This information is used by the SSR mode.
@@ -408,9 +405,6 @@ static inline void seg_info_from_raw_sit(struct seg_entry *se,
 	se->ckpt_valid_blocks = GET_SIT_VBLOCKS(rs);
 	memcpy(se->cur_valid_map, rs->valid_map, SIT_VBLOCK_MAP_SIZE);
 	memcpy(se->ckpt_valid_map, rs->valid_map, SIT_VBLOCK_MAP_SIZE);
-#ifdef CONFIG_F2FS_CHECK_FS
-	memcpy(se->cur_valid_map_mir, rs->valid_map, SIT_VBLOCK_MAP_SIZE);
-#endif
 	se->type = GET_SIT_TYPE(rs);
 	se->mtime = le64_to_cpu(rs->mtime);
 }
-- 
2.49.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
