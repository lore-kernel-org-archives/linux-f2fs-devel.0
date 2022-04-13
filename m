Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5365CC4332F
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 13 Apr 2022 15:49:45 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.94.2)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1nefFY-0005Uq-7D; Wed, 13 Apr 2022 15:49:42 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <jaegeuk@kernel.org>) id 1nefFX-0005Ui-4w
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 13 Apr 2022 15:49:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=IDeNb+gWk/P4kjRsjN/+7ezEbdfplvxJFlw2bN4SlzQ=; b=Yj9Bud/oJ2bI8fQL3LDpxSct2o
 pL59voBHtvqvhbwqdLwEMSmqnjXi5cAKnrIOkWC8Xi9+YFTNtx9PyG0fsLV/10lTUwR6MiiOmEjtr
 OpI2nWMpJJt3jptvKuRIp2cYs8ARzgIzog1Wo/wISMV8EYeHiuVTr6CWcJTwRGUOXumQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=IDeNb+gWk/P4kjRsjN/+7ezEbdfplvxJFlw2bN4SlzQ=; b=PZ4feAcTT/xL9HW9tYC6Xhc+wu
 k88Kw8Byirsh2Dg+JdjoKMP9KJn8jCjIVC12bH82ADAVGCPBO3pBDB3z6uJT0/qShN7hp+FH411HJ
 7OakOS/sO6yN5mdYpbNou6Je6gDjEl3xHJAya6mq7qdNIFlduyu+PMBCDe6iOe2Evjg8=;
Received: from ams.source.kernel.org ([145.40.68.75])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.94.2)
 id 1nefFR-0001tp-6d
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 13 Apr 2022 15:49:41 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id E3239B824F9
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed, 13 Apr 2022 15:49:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8032FC385A4;
 Wed, 13 Apr 2022 15:49:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1649864969;
 bh=rfY+zz0EuMCDCl5xRvtF27SM8BicRPxM1bncNrdxx0A=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=doIhqVsnjd2JQK1auCF3NlybCIVILT6hrtkjgPvkbU9ocftiLFygYW6NGXNKbmgji
 lB2ClmnfaMlvTDNlz+U7O0Y+BMRuR1wjqfOX2bnUxXDhD256W7Q+yd0T/8miimjFlO
 jtzSAxG+NRek/wdNLYb7g5QsiyweekKbx4N7iZXlNhJHTwbz0KRgyZ+HAOnKGmr6zC
 S37szmfOKyxZ9ExQAIG3JrBBOJOnB/ucmLZQLBnZTlTY5gb8cBZZeS1HLxww1a+sV4
 PpqFjsRiJqh/apPR4DTdtR4rcVn6nebXu51AJvwhMWlvRHL9R8CvdEtbkqgMmKe+1C
 l9/wpv57+ZFDQ==
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: linux-kernel@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net
Date: Wed, 13 Apr 2022 08:49:20 -0700
Message-Id: <20220413154920.2024872-2-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.36.0.rc0.470.gd361397f0d-goog
In-Reply-To: <20220413154920.2024872-1-jaegeuk@kernel.org>
References: <20220413154920.2024872-1-jaegeuk@kernel.org>
MIME-Version: 1.0
X-Headers-End: 1nefFR-0001tp-6d
Subject: [f2fs-dev] [PATCH 2/2] f2fs: keep io_flags to avoid IO split due to
 different op_flags in two fio holders
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

Let's attach io_flags to bio only, so that we can merge IOs given original
io_flags only.

Fixes: 64bf0eef0171 ("f2fs: pass the bio operation to bio_alloc_bioset")
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/data.c | 33 +++++++++++++++++++++------------
 1 file changed, 21 insertions(+), 12 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index acc523f893ba..fcf0daa386de 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -387,11 +387,23 @@ int f2fs_target_device_index(struct f2fs_sb_info *sbi, block_t blkaddr)
 	return 0;
 }
 
-static void __attach_io_flag(struct f2fs_io_info *fio, unsigned int io_flag)
+static unsigned int f2fs_io_flags(struct f2fs_io_info *fio)
 {
 	unsigned int temp_mask = (1 << NR_TEMP_TYPE) - 1;
-	unsigned int fua_flag = io_flag & temp_mask;
-	unsigned int meta_flag = (io_flag >> NR_TEMP_TYPE) & temp_mask;
+	unsigned int fua_flag, meta_flag, io_flag;
+	unsigned int op_flags = 0;
+
+	if (fio->op != REQ_OP_WRITE)
+		return 0;
+	if (fio->type == DATA)
+		io_flag = fio->sbi->data_io_flag;
+	else if (fio->type == NODE)
+		io_flag = fio->sbi->node_io_flag;
+	else
+		return 0;
+
+	fua_flag = io_flag & temp_mask;
+	meta_flag = (io_flag >> NR_TEMP_TYPE) & temp_mask;
 
 	/*
 	 * data/node io flag bits per temp:
@@ -400,9 +412,10 @@ static void __attach_io_flag(struct f2fs_io_info *fio, unsigned int io_flag)
 	 * Cold | Warm | Hot | Cold | Warm | Hot |
 	 */
 	if ((1 << fio->temp) & meta_flag)
-		fio->op_flags |= REQ_META;
+		op_flags |= REQ_META;
 	if ((1 << fio->temp) & fua_flag)
-		fio->op_flags |= REQ_FUA;
+		op_flags |= REQ_FUA;
+	return op_flags;
 }
 
 static struct bio *__bio_alloc(struct f2fs_io_info *fio, int npages)
@@ -412,14 +425,10 @@ static struct bio *__bio_alloc(struct f2fs_io_info *fio, int npages)
 	sector_t sector;
 	struct bio *bio;
 
-	if (fio->type == DATA)
-		__attach_io_flag(fio, sbi->data_io_flag);
-	else if (fio->type == NODE)
-		__attach_io_flag(fio, sbi->node_io_flag);
-
 	bdev = f2fs_target_device(sbi, fio->new_blkaddr, &sector);
-	bio = bio_alloc_bioset(bdev, npages, fio->op | fio->op_flags, GFP_NOIO,
-			       &f2fs_bioset);
+	bio = bio_alloc_bioset(bdev, npages,
+				fio->op | fio->op_flags | f2fs_io_flags(fio),
+				GFP_NOIO, &f2fs_bioset);
 	bio->bi_iter.bi_sector = sector;
 	if (is_read_io(fio->op)) {
 		bio->bi_end_io = f2fs_read_end_io;
-- 
2.36.0.rc0.470.gd361397f0d-goog



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
