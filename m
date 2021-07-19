Return-Path: <SRS0=w7Yd=ML=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50B5BC12002
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 19 Jul 2021 08:46:12 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 13B8361205
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 19 Jul 2021 08:46:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13B8361205
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1m5Ouh-0003M0-5r; Mon, 19 Jul 2021 08:46:11 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <chao@kernel.org>) id 1m5Ouf-0003Lo-U9
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 19 Jul 2021 08:46:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=gFZo5Z2SnLubprGqwTvLnV7F17tK/jRUcnktLlgb83w=; b=TuN8xr5xdVVAQq2Xxwf0uGMEA1
 Xnfa/pxVkB5F9mNMiqeGiN0sbNQ/KzzkHPvnVih9iOTNlNGKJ9jAWM78znFRGJ46hBffRjdzDWtdf
 Ha9mDftnNjUxORyqo+P+NqN5oTryOQn0+0v+TBEzBXpBI3lSEXxhuwc2qLcClWyRgcxs=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=gFZo5Z2SnLubprGqwTvLnV7F17tK/jRUcnktLlgb83w=; b=c
 IGldOXu6IyZfAup0d6KqJJNe5T+Fh6oA9c3IsETaE7Yz10GT4GvbPiPWjP0kAYrpaXYUTq8jGOB7a
 YTN0okrsWWt1M4bMQKy8885PRP4weo02YOC5YMK54DxUvqIcL3pkw5N0wRd4IvryWoi6G6teLdGuS
 sqxD8E9uWFxla/5A=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.3)
 id 1m5OuU-00049g-WE
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 19 Jul 2021 08:46:08 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9B112611CC;
 Mon, 19 Jul 2021 08:45:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1626684353;
 bh=TNFD7nvB5rMFEOYLBIiExOBM7/f5QTYMUplrVLlFeDQ=;
 h=From:To:Cc:Subject:Date:From;
 b=hYQweFO2oU4T7aQTOoLVFDPC1Xncdn00kd2JESAVOfrbKUu4gRwWoOHX9kDd0GPw4
 JHRk1/9sufD4KY2cKkvVfDkPWQiWCPhNv1Wzkus5E2tjuElKnzrglzfpN8i8uBEPIZ
 XO21c7mP756eq8LMzHpfw1b5NYVTP4+F0WbbyPeItA6JD1TG1R8f6f1sZDDnYFXv3H
 AcOnQ+Orn2Tynx/GJmLdSeB4p147khbnwF7p54ZwtpmN6Afzi2K7bnF6xyLmbuBaem
 gbjzfbhVDB9h1lLO4oiz+wmHoxA+32sFkFeUKrTjr61vxpnXPf5Z9IZ9p7ujq2cRHL
 oX5Ny6kPLQCvw==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Date: Mon, 19 Jul 2021 16:45:48 +0800
Message-Id: <20210719084548.25895-1-chao@kernel.org>
X-Mailer: git-send-email 2.22.1
MIME-Version: 1.0
X-Headers-End: 1m5OuU-00049g-WE
Subject: [f2fs-dev] [PATCH v2] f2fs: fix wrong inflight page stats for
 directIO
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
Cc: Chao Yu <chao.yu@linux.dev>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Previously, we use sbi->nr_pages[] to account direct IO, the count should
be based on page granularity rather than bio granularity, fix it.

Fixes: 02b16d0a34a1 ("f2fs: add to account direct IO")
Signed-off-by: Chao Yu <chao@kernel.org>
---
v2:
- There is one missing line when I reorder in development patches,
so just resend the patch as v2, sorry.
 fs/f2fs/data.c | 11 +++++++----
 fs/f2fs/f2fs.h | 13 +++++++++++++
 2 files changed, 20 insertions(+), 4 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index e6f107de4c92..095350ccf80d 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -3494,8 +3494,9 @@ static void f2fs_dio_end_io(struct bio *bio)
 {
 	struct f2fs_private_dio *dio = bio->bi_private;
 
-	dec_page_count(F2FS_I_SB(dio->inode),
-			dio->write ? F2FS_DIO_WRITE : F2FS_DIO_READ);
+	dec_page_counts(F2FS_I_SB(dio->inode),
+			dio->write ? F2FS_DIO_WRITE : F2FS_DIO_READ,
+			dio->blkcnt);
 
 	bio->bi_private = dio->orig_private;
 	bio->bi_end_io = dio->orig_end_io;
@@ -3510,6 +3511,7 @@ static void f2fs_dio_submit_bio(struct bio *bio, struct inode *inode,
 {
 	struct f2fs_private_dio *dio;
 	bool write = (bio_op(bio) == REQ_OP_WRITE);
+	unsigned int blkcnt = bio_sectors(bio) >> F2FS_LOG_SECTORS_PER_BLOCK;
 
 	dio = f2fs_kzalloc(F2FS_I_SB(inode),
 			sizeof(struct f2fs_private_dio), GFP_NOFS);
@@ -3519,13 +3521,14 @@ static void f2fs_dio_submit_bio(struct bio *bio, struct inode *inode,
 	dio->inode = inode;
 	dio->orig_end_io = bio->bi_end_io;
 	dio->orig_private = bio->bi_private;
+	dio->blkcnt = blkcnt;
 	dio->write = write;
 
 	bio->bi_end_io = f2fs_dio_end_io;
 	bio->bi_private = dio;
 
-	inc_page_count(F2FS_I_SB(inode),
-			write ? F2FS_DIO_WRITE : F2FS_DIO_READ);
+	inc_page_counts(F2FS_I_SB(inode),
+			write ? F2FS_DIO_WRITE : F2FS_DIO_READ, dio->blkcnt);
 
 	submit_bio(bio);
 	return;
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 867f2c5d9559..7369f8087f64 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1759,6 +1759,7 @@ struct f2fs_private_dio {
 	struct inode *inode;
 	void *orig_private;
 	bio_end_io_t *orig_end_io;
+	unsigned int blkcnt;
 	bool write;
 };
 
@@ -2267,6 +2268,12 @@ static inline void inc_page_count(struct f2fs_sb_info *sbi, int count_type)
 		set_sbi_flag(sbi, SBI_IS_DIRTY);
 }
 
+static inline void inc_page_counts(struct f2fs_sb_info *sbi, int count_type,
+							unsigned int count)
+{
+	atomic_add(count, &sbi->nr_pages[count_type]);
+}
+
 static inline void inode_inc_dirty_pages(struct inode *inode)
 {
 	atomic_inc(&F2FS_I(inode)->dirty_pages);
@@ -2281,6 +2288,12 @@ static inline void dec_page_count(struct f2fs_sb_info *sbi, int count_type)
 	atomic_dec(&sbi->nr_pages[count_type]);
 }
 
+static inline void dec_page_counts(struct f2fs_sb_info *sbi, int count_type,
+							unsigned int count)
+{
+	atomic_sub(count, &sbi->nr_pages[count_type]);
+}
+
 static inline void inode_dec_dirty_pages(struct inode *inode)
 {
 	if (!S_ISDIR(inode->i_mode) && !S_ISREG(inode->i_mode) &&
-- 
2.22.1



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
