Return-Path: <SRS0=Hc1M=Z4=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D5E4C43603
	for <linux-f2fs-devel@archiver.kernel.org>; Fri,  6 Dec 2019 03:32:13 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C23421823
	for <linux-f2fs-devel@archiver.kernel.org>; Fri,  6 Dec 2019 03:32:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="XcG23KNh";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="MCk/NvHC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C23421823
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1id4Lk-0005GT-CW; Fri, 06 Dec 2019 03:32:12 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <yuchao0@huawei.com>) id 1id4Li-0005GH-H5
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 06 Dec 2019 03:32:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:MIME-Version:Message-ID:Date:Subject:
 CC:To:From:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=o/enalIwF8+oFs0VCmBmFYlr6HI56ec+H2svrNPDkTs=; b=XcG23KNhKf5twQ/3CKkUrLn4IQ
 b2X4CCVOSWCD49tAdLKpL3DU5Rn3I32mCtE39LzO7iIvrJz22Vf/YSpxW7eSI1Z7CwUfkx8Q7bZfm
 ha5jiIXdUnbwKYulab1RFXjZT9C7z6OhY4qLfZsbQF7zkTbSV1cZz7xpECT5UlYQHais=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From:Sender:
 Reply-To:Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date
 :Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=o/enalIwF8+oFs0VCmBmFYlr6HI56ec+H2svrNPDkTs=; b=M
 Ck/NvHCzD6TU1KIydN5RVssByUDFYeUBiAxg4+pw3JqLQLrH6p+KDnTY5VpoOWGdekw8WndVXuazg
 uVoW+JZnmA0fMb+NqOQbr97DR+zXemqt3HbkJpX1hBU1Wz0hus5abhyDKJ531WZXdlC9r4G5kLlkp
 6mD6SThxfbARryd4=;
Received: from szxga04-in.huawei.com ([45.249.212.190] helo=huawei.com)
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1id4Lg-00BHRg-NV
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 06 Dec 2019 03:32:10 +0000
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id 67EADA3DF8EF18778786;
 Fri,  6 Dec 2019 11:31:58 +0800 (CST)
Received: from szvp000203569.huawei.com (10.120.216.130) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.439.0; Fri, 6 Dec 2019 11:31:47 +0800
From: Chao Yu <yuchao0@huawei.com>
To: <jaegeuk@kernel.org>
Date: Fri, 6 Dec 2019 11:31:00 +0800
Message-ID: <20191206033100.36345-1-yuchao0@huawei.com>
X-Mailer: git-send-email 2.18.0.rc1
MIME-Version: 1.0
X-Originating-IP: [10.120.216.130]
X-CFilter-Loop: Reflected
X-Headers-End: 1id4Lg-00BHRg-NV
Subject: [f2fs-dev] [PATCH] f2fs: fix to relocate f2fs_balance_fs() in
 mkwrite()
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

As Dinosaur Huang reported, there is a potential deadlock in between
GC and mkwrite():

Thread A			Thread B
- do_page_mkwrite
 - f2fs_vm_page_mkwrite
  - lock_page
				- f2fs_balance_fs
                                 - mutex_lock(gc_mutex)
				 - f2fs_gc
				  - do_garbage_collect
				   - ra_data_block
				    - grab_cache_page
  - f2fs_balance_fs
   - mutex_lock(gc_mutex)

In order to fix this, we just move f2fs_balance_fs() out of page lock's
coverage in f2fs_vm_page_mkwrite().

Reported-by: Dinosaur Huang <dinosaur.huang@unisoc.com>
Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/file.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index c0560d62dbee..ed3290225506 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -67,6 +67,8 @@ static vm_fault_t f2fs_vm_page_mkwrite(struct vm_fault *vmf)
 
 	f2fs_bug_on(sbi, f2fs_has_inline_data(inode));
 
+	f2fs_balance_fs(sbi, true);
+
 	file_update_time(vmf->vma->vm_file);
 	down_read(&F2FS_I(inode)->i_mmap_sem);
 	lock_page(page);
@@ -120,8 +122,6 @@ static vm_fault_t f2fs_vm_page_mkwrite(struct vm_fault *vmf)
 out_sem:
 	up_read(&F2FS_I(inode)->i_mmap_sem);
 
-	f2fs_balance_fs(sbi, dn.node_changed);
-
 	sb_end_pagefault(inode->i_sb);
 err:
 	return block_page_mkwrite_return(err);
-- 
2.18.0.rc1



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
