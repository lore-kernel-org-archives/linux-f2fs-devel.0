Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13B1BC4332F
	for <linux-f2fs-devel@archiver.kernel.org>; Sat, 17 Dec 2022 00:47:17 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1p6LMA-0001pX-TZ;
	Sat, 17 Dec 2022 00:47:14 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <jaegeuk@kernel.org>) id 1p6LM9-0001pR-UB
 for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 17 Dec 2022 00:47:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=O0jWofhmonwYucKE4BxS9QQ3NqBC241ik+3gBm8zMUc=; b=RUnyUyXK/bkYJBukWE5F7v6EKZ
 TxzGOtSQRXnsg+XxS3hlCDUscnrjjSfN/ZRjkMM5WXiml0wQJHyUj4Z1kvT6VR0x4eEGrqtGvdD7m
 QABu/iujZCUebQym3qid5BimacHgRZ+EdEpgNes3xHtkix21cKvMvPqujtsErHbpi+yM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=O0jWofhmonwYucKE4BxS9QQ3NqBC241ik+3gBm8zMUc=; b=PzSJ1TAsZjgsHK3Ax4VcYg4Eue
 NDKTv4mtooZB23TCTIngAuWCCxxbyztYkJEesT6guQL/cW3+RPQahJ3WkrCe0DeVVwosXHDQ1Oupi
 u7Qp955iezT5bV3aJlcJQOp8siiwvaHlppbv1CmVaTrsrgAxZN5f6HDUBKkujJptzQiw=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1p6LM9-0000lq-2l for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 17 Dec 2022 00:47:13 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id D1388622FB
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Sat, 17 Dec 2022 00:47:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D2C6C433F1;
 Sat, 17 Dec 2022 00:47:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1671238026;
 bh=a+6qsiRsvE8gU7rhpY2cUbwxGERZ4kE0rv1dRLXXt8U=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=K4qZGtZTVI4OgZnBDUp8Hs73pxk2e/fRcYnWXZN1RSOFeFHlfqZ8fmo4G3X0HajZ5
 4bgk0icvdnFqDgYhjvY5rCIh6BFJuMOaSEgt22qNin/pLicekF3svjYu+fMlYCz4sW
 bFumKilV+CdPhAw0FP3YMdyhYCZsQZExbS6b0ZFP8moAa1yXlVmUurV8fVISw1zEgx
 e4NBlaN6xk7f0s9e/Aw8/91uy1mNYVwwYKQz/eOgIDkmAy+2UNrLeY47PeiIwcnLCi
 YQpbsPzwH+BBMO980sH6iqsLt94sqK7S2hq3i2JXI25P5E0pXAB8+hTELdbFeNYmNe
 U41CVH2Ko84KA==
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: linux-kernel@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net
Date: Fri, 16 Dec 2022 16:46:57 -0800
Message-Id: <20221217004659.2092427-2-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
In-Reply-To: <20221217004659.2092427-1-jaegeuk@kernel.org>
References: <20221217004659.2092427-1-jaegeuk@kernel.org>
MIME-Version: 1.0
X-Headers-End: 1p6LM9-0000lq-2l
Subject: [f2fs-dev] [PATCH 1/3] f2fs: initialize extent_cache parameter
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

This can avoid confusing tracepoint values.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/data.c         | 2 +-
 fs/f2fs/extent_cache.c | 2 +-
 fs/f2fs/file.c         | 2 +-
 fs/f2fs/segment.c      | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 505194c8a258..5f589b8b3b5c 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -2191,7 +2191,7 @@ int f2fs_read_multi_pages(struct compress_ctx *cc, struct bio **bio_ret,
 	sector_t last_block_in_file;
 	const unsigned blocksize = blks_to_bytes(inode, 1);
 	struct decompress_io_ctx *dic = NULL;
-	struct extent_info ei = {0, };
+	struct extent_info ei = {};
 	bool from_dnode = true;
 	int i;
 	int ret = 0;
diff --git a/fs/f2fs/extent_cache.c b/fs/f2fs/extent_cache.c
index 4721f5b0d8b3..749209005644 100644
--- a/fs/f2fs/extent_cache.c
+++ b/fs/f2fs/extent_cache.c
@@ -938,7 +938,7 @@ static int __get_new_block_age(struct inode *inode, struct extent_info *ei)
 
 static void __update_extent_cache(struct dnode_of_data *dn, enum extent_type type)
 {
-	struct extent_info ei;
+	struct extent_info ei = {};
 
 	if (!__may_extent_tree(dn->inode, type))
 		return;
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index a22677345d23..a0c0e0e9e83d 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -2560,7 +2560,7 @@ static int f2fs_defragment_range(struct f2fs_sb_info *sbi,
 	struct f2fs_map_blocks map = { .m_next_extent = NULL,
 					.m_seg_type = NO_CHECK_TYPE,
 					.m_may_create = false };
-	struct extent_info ei = {0, };
+	struct extent_info ei = {};
 	pgoff_t pg_start, pg_end, next_pgofs;
 	unsigned int blk_per_seg = sbi->blocks_per_seg;
 	unsigned int total = 0, sec_num;
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index e2af10d8132b..f8c76ef278df 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -3159,7 +3159,7 @@ static int __get_segment_type_4(struct f2fs_io_info *fio)
 static int __get_age_segment_type(struct inode *inode, pgoff_t pgofs)
 {
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
-	struct extent_info ei;
+	struct extent_info ei = {};
 
 	if (f2fs_lookup_age_extent_cache(inode, pgofs, &ei)) {
 		if (!ei.age)
-- 
2.39.0.314.g84b9a713c41-goog



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
