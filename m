Return-Path: <SRS0=lp92=77=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74597C433DF
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 18 Jun 2020 06:36:58 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A9ED21924
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 18 Jun 2020 06:36:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="ESmPRNSi";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="BpR9jjjU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A9ED21924
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1jloAS-0008Lr-1V; Thu, 18 Jun 2020 06:36:56 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <yuchao0@huawei.com>) id 1jloAQ-0008Lg-Sb
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 18 Jun 2020 06:36:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:CC:To:From:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=+rJhrzVoa2NUbXAlMKXRCjfNHDF12wFZUXH5ckydcNQ=; b=ESmPRNSiO0RT6iLtdQpAPgRsr9
 FZ+v9YEgxhpeT0bnEI5hn6Rsp4TpNGMCJAxsPWDjffmaAhSKw+qW8FDCXh+IcKBewojwadjSdTtni
 RafTZTe2soQWUP2V4XuW+YWpU1J+EOT4Z1/g6wmmE2EE7bsHgayB8XR+NyUPcUx/+Mvw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:
 CC:To:From:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=+rJhrzVoa2NUbXAlMKXRCjfNHDF12wFZUXH5ckydcNQ=; b=BpR9jjjUzRoRzykAYRNR9o4BVr
 ldfEyEZO1RbLiEKerR1qlimHJs75SBAfKPfES4YWaWY2TXa76nicvT3KcryzIZ4JmAytNboQPiKo1
 67E41trQ+IDz81BW0v6lA8UMwE+I+cgabGtexVvmK+xrSdmg7TaPLuc/ryQ1T00gyjeg=;
Received: from szxga04-in.huawei.com ([45.249.212.190] helo=huawei.com)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1jloAN-007xlF-2P
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 18 Jun 2020 06:36:54 +0000
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id 7EA343DA2EC6CFCA4384;
 Thu, 18 Jun 2020 14:36:40 +0800 (CST)
Received: from szvp000203569.huawei.com (10.120.216.130) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.487.0; Thu, 18 Jun 2020 14:36:32 +0800
From: Chao Yu <yuchao0@huawei.com>
To: <jaegeuk@kernel.org>
Date: Thu, 18 Jun 2020 14:36:23 +0800
Message-ID: <20200618063625.110273-3-yuchao0@huawei.com>
X-Mailer: git-send-email 2.18.0.rc1
In-Reply-To: <20200618063625.110273-1-yuchao0@huawei.com>
References: <20200618063625.110273-1-yuchao0@huawei.com>
MIME-Version: 1.0
X-Originating-IP: [10.120.216.130]
X-CFilter-Loop: Reflected
X-Headers-End: 1jloAN-007xlF-2P
Subject: [f2fs-dev] [PATCH 3/5] f2fs: shrink node_write lock coverage
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

- to avoid race between checkpoint and quota file writeback, it
just needs to hold read lock of node_write in writeback path.
- node_write lock has covered all LFS data write paths, it's not
necessary, we only need to hold node_write lock at write path of
quota file.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/compress.c | 18 +++++++++++++++---
 fs/f2fs/data.c     | 12 ++++++++++++
 fs/f2fs/segment.c  | 11 -----------
 3 files changed, 27 insertions(+), 14 deletions(-)

diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
index 36b51795b0c3..3ff6c0305ec6 100644
--- a/fs/f2fs/compress.c
+++ b/fs/f2fs/compress.c
@@ -1096,8 +1096,16 @@ static int f2fs_write_compressed_pages(struct compress_ctx *cc,
 	loff_t psize;
 	int i, err;
 
-	if (!IS_NOQUOTA(inode) && !f2fs_trylock_op(sbi))
+	if (IS_NOQUOTA(inode)) {
+		/*
+		 * We need to wait for node_write to avoid block allocation during
+		 * checkpoint. This can only happen to quota writes which can cause
+		 * the below discard race condition.
+		 */
+		down_read(&sbi->node_write);
+	} else if (!f2fs_trylock_op(sbi)) {
 		return -EAGAIN;
+	}
 
 	set_new_dnode(&dn, cc->inode, NULL, NULL, 0);
 
@@ -1203,7 +1211,9 @@ static int f2fs_write_compressed_pages(struct compress_ctx *cc,
 		set_inode_flag(inode, FI_FIRST_BLOCK_WRITTEN);
 
 	f2fs_put_dnode(&dn);
-	if (!IS_NOQUOTA(inode))
+	if (IS_NOQUOTA(inode))
+		up_read(&sbi->node_write);
+	else
 		f2fs_unlock_op(sbi);
 
 	spin_lock(&fi->i_size_lock);
@@ -1230,7 +1240,9 @@ static int f2fs_write_compressed_pages(struct compress_ctx *cc,
 out_put_dnode:
 	f2fs_put_dnode(&dn);
 out_unlock_op:
-	if (!IS_NOQUOTA(inode))
+	if (IS_NOQUOTA(inode))
+		up_read(&sbi->node_write);
+	else
 		f2fs_unlock_op(sbi);
 	return -EAGAIN;
 }
diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index c78ce08f6400..cbdf062d3562 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -2719,8 +2719,20 @@ int f2fs_write_single_data_page(struct page *page, int *submitted,
 
 	/* Dentry/quota blocks are controlled by checkpoint */
 	if (S_ISDIR(inode->i_mode) || IS_NOQUOTA(inode)) {
+		/*
+		 * We need to wait for node_write to avoid block allocation during
+		 * checkpoint. This can only happen to quota writes which can cause
+		 * the below discard race condition.
+		 */
+		if (IS_NOQUOTA(inode))
+			down_read(&sbi->node_write);
+
 		fio.need_lock = LOCK_DONE;
 		err = f2fs_do_write_data_page(&fio);
+
+		if (IS_NOQUOTA(inode))
+			up_read(&sbi->node_write);
+
 		goto done;
 	}
 
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 5b2a6f865a6d..cb861ed98ee3 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -3107,14 +3107,6 @@ void f2fs_allocate_data_block(struct f2fs_sb_info *sbi, struct page *page,
 		type = CURSEG_COLD_DATA;
 	}
 
-	/*
-	 * We need to wait for node_write to avoid block allocation during
-	 * checkpoint. This can only happen to quota writes which can cause
-	 * the below discard race condition.
-	 */
-	if (IS_DATASEG(type))
-		down_write(&sbi->node_write);
-
 	down_read(&SM_I(sbi)->curseg_lock);
 
 	mutex_lock(&curseg->curseg_mutex);
@@ -3180,9 +3172,6 @@ void f2fs_allocate_data_block(struct f2fs_sb_info *sbi, struct page *page,
 
 	up_read(&SM_I(sbi)->curseg_lock);
 
-	if (IS_DATASEG(type))
-		up_write(&sbi->node_write);
-
 	if (put_pin_sem)
 		up_read(&sbi->pin_sem);
 }
-- 
2.18.0.rc1



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
