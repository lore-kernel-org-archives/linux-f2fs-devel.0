Return-Path: <SRS0=8jIo=VX=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B91CC7618B
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 26 Jul 2019 07:41:50 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E487217D4
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 26 Jul 2019 07:41:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="NJODQzoQ";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="lU5D5N5L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E487217D4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1hqurN-00065q-Vh; Fri, 26 Jul 2019 07:41:49 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <yuchao0@huawei.com>) id 1hqurN-00065j-Cp
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 26 Jul 2019 07:41:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:MIME-Version:Message-ID:Date:Subject:
 CC:To:From:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=FLA3h3Kxu4OhOmR3sgfeBhghxR1J5jOG+eTa5YOeqwA=; b=NJODQzoQgXt5+nVKHjAEp0sze9
 nYh/RPgE473c7xxQ+73ibnvU9aAteMiT7wof57TuPG0lTP06BaFSC1pfpYiR2v6zwbaakgo2QAlxo
 GHikzXPGgcI5C/GnNFieW0C50wWqgyKV8dDo+urgblE+tmQgCLx8w2ZbrFnDbJnMYmGQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From:Sender:
 Reply-To:Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date
 :Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=FLA3h3Kxu4OhOmR3sgfeBhghxR1J5jOG+eTa5YOeqwA=; b=l
 U5D5N5L+43Zn7e3XvEm4nGiefE9yVqr+zRWDVaX65ORik5TSPsRDPqyuf0fPMjheKk3oI/G4NuaJZ
 7WuztD3mI10LdVH93jDbsbWnrWV3v0zJpOIFajEdP9e5+9lzyXo6Ga9WQc+Qk7cU10idmG5NcRouv
 XRKwpwWlkdgjlZyk=;
Received: from szxga05-in.huawei.com ([45.249.212.191] helo=huawei.com)
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1hqurI-00GmJz-Lw
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 26 Jul 2019 07:41:49 +0000
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id CEFB2AD5269EB315813C;
 Fri, 26 Jul 2019 15:41:30 +0800 (CST)
Received: from szvp000203569.huawei.com (10.120.216.130) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.439.0; Fri, 26 Jul 2019 15:41:23 +0800
From: Chao Yu <yuchao0@huawei.com>
To: <jaegeuk@kernel.org>
Date: Fri, 26 Jul 2019 15:41:20 +0800
Message-ID: <20190726074120.3278-1-yuchao0@huawei.com>
X-Mailer: git-send-email 2.18.0.rc1
MIME-Version: 1.0
X-Originating-IP: [10.120.216.130]
X-CFilter-Loop: Reflected
X-Headers-End: 1hqurI-00GmJz-Lw
Subject: [f2fs-dev] [PATCH v2] f2fs: allocate memory in batch in
 build_sit_info()
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
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

build_sit_info() allocate all bitmaps for each segment one by one,
it's quite low efficiency, this pach changes to allocate large
continuous memory at a time, and divide it and assign for each bitmaps
of segment. For large size image, it can expect improving its mount
speed.

Signed-off-by: Chen Gong <gongchen4@huawei.com>
Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
v2:
- fix warning triggered in kmalloc() if requested memory size exceeds 4MB.
 fs/f2fs/segment.c | 51 +++++++++++++++++++++--------------------------
 fs/f2fs/segment.h |  1 +
 2 files changed, 24 insertions(+), 28 deletions(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index a661ac32e829..d720eacd9c57 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -3941,7 +3941,7 @@ static int build_sit_info(struct f2fs_sb_info *sbi)
 	struct f2fs_super_block *raw_super = F2FS_RAW_SUPER(sbi);
 	struct sit_info *sit_i;
 	unsigned int sit_segs, start;
-	char *src_bitmap;
+	char *src_bitmap, *bitmap;
 	unsigned int bitmap_size;
 
 	/* allocate memory for SIT information */
@@ -3964,27 +3964,31 @@ static int build_sit_info(struct f2fs_sb_info *sbi)
 	if (!sit_i->dirty_sentries_bitmap)
 		return -ENOMEM;
 
+#ifdef CONFIG_F2FS_CHECK_FS
+	bitmap_size = MAIN_SEGS(sbi) * SIT_VBLOCK_MAP_SIZE * 4;
+#else
+	bitmap_size = MAIN_SEGS(sbi) * SIT_VBLOCK_MAP_SIZE * 3;
+#endif
+	sit_i->bitmap = f2fs_kvzalloc(sbi, bitmap_size, GFP_KERNEL);
+	if (!sit_i->bitmap)
+		return -ENOMEM;
+
+	bitmap = sit_i->bitmap;
+
 	for (start = 0; start < MAIN_SEGS(sbi); start++) {
-		sit_i->sentries[start].cur_valid_map
-			= f2fs_kzalloc(sbi, SIT_VBLOCK_MAP_SIZE, GFP_KERNEL);
-		sit_i->sentries[start].ckpt_valid_map
-			= f2fs_kzalloc(sbi, SIT_VBLOCK_MAP_SIZE, GFP_KERNEL);
-		if (!sit_i->sentries[start].cur_valid_map ||
-				!sit_i->sentries[start].ckpt_valid_map)
-			return -ENOMEM;
+		sit_i->sentries[start].cur_valid_map = bitmap;
+		bitmap += SIT_VBLOCK_MAP_SIZE;
+
+		sit_i->sentries[start].ckpt_valid_map = bitmap;
+		bitmap += SIT_VBLOCK_MAP_SIZE;
 
 #ifdef CONFIG_F2FS_CHECK_FS
-		sit_i->sentries[start].cur_valid_map_mir
-			= f2fs_kzalloc(sbi, SIT_VBLOCK_MAP_SIZE, GFP_KERNEL);
-		if (!sit_i->sentries[start].cur_valid_map_mir)
-			return -ENOMEM;
+		sit_i->sentries[start].cur_valid_map_mir = bitmap;
+		bitmap += SIT_VBLOCK_MAP_SIZE;
 #endif
 
-		sit_i->sentries[start].discard_map
-			= f2fs_kzalloc(sbi, SIT_VBLOCK_MAP_SIZE,
-							GFP_KERNEL);
-		if (!sit_i->sentries[start].discard_map)
-			return -ENOMEM;
+		sit_i->sentries[start].discard_map = bitmap;
+		bitmap += SIT_VBLOCK_MAP_SIZE;
 	}
 
 	sit_i->tmp_map = f2fs_kzalloc(sbi, SIT_VBLOCK_MAP_SIZE, GFP_KERNEL);
@@ -4492,21 +4496,12 @@ static void destroy_free_segmap(struct f2fs_sb_info *sbi)
 static void destroy_sit_info(struct f2fs_sb_info *sbi)
 {
 	struct sit_info *sit_i = SIT_I(sbi);
-	unsigned int start;
 
 	if (!sit_i)
 		return;
 
-	if (sit_i->sentries) {
-		for (start = 0; start < MAIN_SEGS(sbi); start++) {
-			kvfree(sit_i->sentries[start].cur_valid_map);
-#ifdef CONFIG_F2FS_CHECK_FS
-			kvfree(sit_i->sentries[start].cur_valid_map_mir);
-#endif
-			kvfree(sit_i->sentries[start].ckpt_valid_map);
-			kvfree(sit_i->sentries[start].discard_map);
-		}
-	}
+	if (sit_i->sentries)
+		kvfree(sit_i->bitmap);
 	kvfree(sit_i->tmp_map);
 
 	kvfree(sit_i->sentries);
diff --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h
index b74602813a05..ec4d568fd58c 100644
--- a/fs/f2fs/segment.h
+++ b/fs/f2fs/segment.h
@@ -226,6 +226,7 @@ struct sit_info {
 	block_t sit_base_addr;		/* start block address of SIT area */
 	block_t sit_blocks;		/* # of blocks used by SIT area */
 	block_t written_valid_blocks;	/* # of valid blocks in main area */
+	char *bitmap;			/* all bitmaps pointer */
 	char *sit_bitmap;		/* SIT bitmap pointer */
 #ifdef CONFIG_F2FS_CHECK_FS
 	char *sit_bitmap_mir;		/* SIT bitmap mirror */
-- 
2.18.0.rc1



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
