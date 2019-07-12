Return-Path: <SRS0=bfh/=VJ=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BF1DC742A5
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 12 Jul 2019 08:56:22 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 569F220863
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 12 Jul 2019 08:56:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="C37od3hY";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="Vwe/L/2E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 569F220863
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1hlrLp-000420-Vv; Fri, 12 Jul 2019 08:56:21 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <yuchao0@huawei.com>) id 1hlrLo-00041V-6Y
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 12 Jul 2019 08:56:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:CC:To:From:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=jcjaO8KZ3Psnc9W80xntW0ZkRtaO4izxJicJXS2Smts=; b=C37od3hYB2UplvaGZCLqUbTdyl
 RAuBq5BYWStpLFeB2KMDgHG1Kxcn0K80HlmNc5CqdK56/dsz0zdV3/Q231L04GikBfPuVTimTOySk
 ps5jujuUtE5G7txcUGLBVfg0BXwRMSSSfwVx9CCoO1+D/0tXIV9Xt+9m3J306YwFqP1w=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:
 CC:To:From:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=jcjaO8KZ3Psnc9W80xntW0ZkRtaO4izxJicJXS2Smts=; b=Vwe/L/2EIPBo5SBo7AWF+7t92l
 G+znNLcHnSmNzbmVw5MUl2HFxJsSS+ZVEAqhaAMAo7HxEtRXq+PsGpVl5JUz46URL75gMEC/306Qx
 V07aipYJ8okEB5ffA/lKYuqI3ppzuL2wp0o52IwjcqmJBiRVujpPXnCzK5QboN3hc9iY=;
Received: from szxga05-in.huawei.com ([45.249.212.191] helo=huawei.com)
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1hlrLk-00Gqgw-TM
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 12 Jul 2019 08:56:20 +0000
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id 252D2A13B4022EAF004E;
 Fri, 12 Jul 2019 16:56:09 +0800 (CST)
Received: from szvp000203569.huawei.com (10.120.216.130) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.439.0; Fri, 12 Jul 2019 16:56:00 +0800
From: Chao Yu <yuchao0@huawei.com>
To: <jaegeuk@kernel.org>
Date: Fri, 12 Jul 2019 16:55:42 +0800
Message-ID: <20190712085542.4068-2-yuchao0@huawei.com>
X-Mailer: git-send-email 2.18.0.rc1
In-Reply-To: <20190712085542.4068-1-yuchao0@huawei.com>
References: <20190712085542.4068-1-yuchao0@huawei.com>
MIME-Version: 1.0
X-Originating-IP: [10.120.216.130]
X-CFilter-Loop: Reflected
X-Headers-End: 1hlrLk-00Gqgw-TM
Subject: [f2fs-dev] [PATCH 2/2] f2fs: fix panic of IO alignment feature
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

Since 07173c3ec276 ("block: enable multipage bvecs"), one bio vector
can store multi pages, so that we can not calculate max IO size of
bio as PAGE_SIZE * bio->bi_max_vecs. However IO alignment feature of
f2fs always has that assumption, so finally, it may cause panic during
IO submission as below stack.

 kernel BUG at fs/f2fs/data.c:317!
 RIP: 0010:__submit_merged_bio+0x8b0/0x8c0
 Call Trace:
  f2fs_submit_page_write+0x3cd/0xdd0
  do_write_page+0x15d/0x360
  f2fs_outplace_write_data+0xd7/0x210
  f2fs_do_write_data_page+0x43b/0xf30
  __write_data_page+0xcf6/0x1140
  f2fs_write_cache_pages+0x3ba/0xb40
  f2fs_write_data_pages+0x3dd/0x8b0
  do_writepages+0xbb/0x1e0
  __writeback_single_inode+0xb6/0x800
  writeback_sb_inodes+0x441/0x910
  wb_writeback+0x261/0x650
  wb_workfn+0x1f9/0x7a0
  process_one_work+0x503/0x970
  worker_thread+0x7d/0x820
  kthread+0x1ad/0x210
  ret_from_fork+0x35/0x40

This patch adds one extra condition to check left space in bio while
trying merging page to bio, to avoid panic.

This bug was reported in bugzilla:

https://bugzilla.kernel.org/show_bug.cgi?id=204043

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
v2: add IO type check.
 fs/f2fs/data.c          | 10 ++++++++++
 fs/f2fs/super.c         |  2 +-
 include/linux/f2fs_fs.h |  1 +
 3 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index f1e401f9fc13..1971e59cdedb 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -504,6 +504,16 @@ static bool io_is_mergeable(struct f2fs_sb_info *sbi, struct bio *bio,
 					block_t last_blkaddr,
 					block_t cur_blkaddr)
 {
+	if (F2FS_IO_ALIGNED(sbi) && (fio->type == DATA || fio->type == NODE)) {
+		unsigned int filled_blocks =
+				F2FS_BYTES_TO_BLK(bio->bi_iter.bi_size);
+		unsigned int io_size = F2FS_IO_SIZE(sbi);
+		unsigned int left_vecs = bio->bi_max_vecs - bio->bi_vcnt;
+
+		/* IOs in bio is aligned and left space of vectors is not enough */
+		if (!(filled_blocks % io_size) && left_vecs < io_size)
+			return false;
+	}
 	if (!page_is_mergeable(sbi, bio, last_blkaddr, cur_blkaddr))
 		return false;
 	return io_type_is_mergeable(io, fio);
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index d95a681ef7c9..a98e3b93395d 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -3204,7 +3204,7 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
 	if (err)
 		goto free_bio_info;
 
-	if (F2FS_IO_SIZE(sbi) > 1) {
+	if (F2FS_IO_ALIGNED(sbi)) {
 		sbi->write_io_dummy =
 			mempool_create_page_pool(2 * (F2FS_IO_SIZE(sbi) - 1), 0);
 		if (!sbi->write_io_dummy) {
diff --git a/include/linux/f2fs_fs.h b/include/linux/f2fs_fs.h
index 65559900d4d7..52af9ac164b4 100644
--- a/include/linux/f2fs_fs.h
+++ b/include/linux/f2fs_fs.h
@@ -41,6 +41,7 @@
 #define F2FS_IO_SIZE_BYTES(sbi)	(1 << (F2FS_OPTION(sbi).write_io_size_bits + 12)) /* B */
 #define F2FS_IO_SIZE_BITS(sbi)	(F2FS_OPTION(sbi).write_io_size_bits) /* power of 2 */
 #define F2FS_IO_SIZE_MASK(sbi)	(F2FS_IO_SIZE(sbi) - 1)
+#define F2FS_IO_ALIGNED(sbi)	(F2FS_IO_SIZE(sbi) > 1)
 
 /* This flag is used by node and meta inodes, and by recovery */
 #define GFP_F2FS_ZERO		(GFP_NOFS | __GFP_ZERO)
-- 
2.18.0.rc1



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
