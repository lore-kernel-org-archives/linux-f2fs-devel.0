Return-Path: <SRS0=Qhk5=7L=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93475C433E0
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 29 May 2020 09:30:23 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6117D206B6
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 29 May 2020 09:30:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="gZfQ/ky4";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="ltcqB1RC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6117D206B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1jebLK-0004uH-8Q; Fri, 29 May 2020 09:30:22 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <yuchao0@huawei.com>) id 1jebLI-0004u8-Hf
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 29 May 2020 09:30:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:MIME-Version:Message-ID:Date:Subject:
 CC:To:From:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=b3Or16xs2x04h/6DmDDduRlsDcQKAsV66L9oNLVBFAg=; b=gZfQ/ky4lUB+F46ZjnAcaSGcoq
 f8jPIobhYBZU9132lG7KR/fXuYzFStNnlDXEPqBXgwA+03bawr8HaOLpPoBw2Eo3pY7ABHryVrsgK
 rYUMk5mF8FeqybQU6X29JwmgpDguxScf5rvrfon+xSqNZaGjZC3TmoyMqNrWiEQSJxb4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From:Sender:
 Reply-To:Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date
 :Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=b3Or16xs2x04h/6DmDDduRlsDcQKAsV66L9oNLVBFAg=; b=l
 tcqB1RCCh83X6EhVxV+vh/13sxbDl2wtjMPO9pOL6goaPjstg2MCvpoRC8DyKdSwu+GsVfKgCHw+8
 oElX295tcmNtQO417TBvnVu4sbSeyhR4TL4Tqnn1XzMxWY08OhyeOc7VOFEuq1OUNBB5B5jx6XeGo
 3Zl9MJDBXdPr4Fi0=;
Received: from szxga04-in.huawei.com ([45.249.212.190] helo=huawei.com)
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1jebLE-002Xnp-M6
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 29 May 2020 09:30:20 +0000
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id 9C4A5505144E1C536119;
 Fri, 29 May 2020 17:30:06 +0800 (CST)
Received: from szvp000203569.huawei.com (10.120.216.130) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.487.0; Fri, 29 May 2020 17:30:00 +0800
From: Chao Yu <yuchao0@huawei.com>
To: <jaegeuk@kernel.org>
Date: Fri, 29 May 2020 17:29:47 +0800
Message-ID: <20200529092947.7890-1-yuchao0@huawei.com>
X-Mailer: git-send-email 2.18.0.rc1
MIME-Version: 1.0
X-Originating-IP: [10.120.216.130]
X-CFilter-Loop: Reflected
X-Headers-End: 1jebLE-002Xnp-M6
Subject: [f2fs-dev] [PATCH] Revert "f2fs: fix quota_sync failure due to
 f2fs_lock_op"
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

Under heavy fsstress, we may triggle panic while issuing discard,
because __check_sit_bitmap() detects that discard command may earse
valid data blocks, the root cause is as below race stack described,
since we removed lock when flushing quota data, quota data writeback
may race with write_checkpoint(), so that it causes inconsistency in
between cached discard entry and segment bitmap.

- f2fs_write_checkpoint
 - block_operations
  - set_sbi_flag(sbi, SBI_QUOTA_SKIP_FLUSH)
 - f2fs_flush_sit_entries
  - add_discard_addrs
   - __set_bit_le(i, (void *)de->discard_map);
						- f2fs_write_data_pages
						 - f2fs_write_single_data_page
						   : inode is quota one, cp_rwsem won't be locked
						  - f2fs_do_write_data_page
						   - f2fs_allocate_data_block
						    - f2fs_wait_discard_bio
						      : discard entry has not been added yet.
						    - update_sit_entry
 - f2fs_clear_prefree_segments
  - f2fs_issue_discard
  : add discard entry

This patch fixes this issue by reverting 435cbab95e39 ("f2fs: fix quota_sync
failure due to f2fs_lock_op").

Fixes: 435cbab95e39 ("f2fs: fix quota_sync failure due to f2fs_lock_op")
Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/compress.c | 8 +++-----
 fs/f2fs/data.c     | 4 ++--
 2 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
index a53578a89211..62c4857ae46d 100644
--- a/fs/f2fs/compress.c
+++ b/fs/f2fs/compress.c
@@ -1097,7 +1097,7 @@ static int f2fs_write_compressed_pages(struct compress_ctx *cc,
 	loff_t psize;
 	int i, err;
 
-	if (!IS_NOQUOTA(inode) && !f2fs_trylock_op(sbi))
+	if (!f2fs_trylock_op(sbi))
 		return -EAGAIN;
 
 	set_new_dnode(&dn, cc->inode, NULL, NULL, 0);
@@ -1204,8 +1204,7 @@ static int f2fs_write_compressed_pages(struct compress_ctx *cc,
 		set_inode_flag(inode, FI_FIRST_BLOCK_WRITTEN);
 
 	f2fs_put_dnode(&dn);
-	if (!IS_NOQUOTA(inode))
-		f2fs_unlock_op(sbi);
+	f2fs_unlock_op(sbi);
 
 	spin_lock(&fi->i_size_lock);
 	if (fi->last_disk_size < psize)
@@ -1231,8 +1230,7 @@ static int f2fs_write_compressed_pages(struct compress_ctx *cc,
 out_put_dnode:
 	f2fs_put_dnode(&dn);
 out_unlock_op:
-	if (!IS_NOQUOTA(inode))
-		f2fs_unlock_op(sbi);
+	f2fs_unlock_op(sbi);
 	return -EAGAIN;
 }
 
diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 999a36ff05f1..d983ad54f318 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -2724,8 +2724,8 @@ int f2fs_write_single_data_page(struct page *page, int *submitted,
 			f2fs_available_free_memory(sbi, BASE_CHECK))))
 		goto redirty_out;
 
-	/* Dentry/quota blocks are controlled by checkpoint */
-	if (S_ISDIR(inode->i_mode) || IS_NOQUOTA(inode)) {
+	/* Dentry blocks are controlled by checkpoint */
+	if (S_ISDIR(inode->i_mode)) {
 		fio.need_lock = LOCK_DONE;
 		err = f2fs_do_write_data_page(&fio);
 		goto done;
-- 
2.18.0.rc1



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
