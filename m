Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E2EBC52D7C
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 13 Aug 2024 14:13:56 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1sdsHa-0008EI-Nf;
	Tue, 13 Aug 2024 14:13:54 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1sdsHY-0008EC-Rp
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 13 Aug 2024 14:13:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=CgUI+2tXv2m0nVzqIL76WrwoGRP9ACYfDzKtSiw9BfM=; b=e/8T0eg0KnP68rQNOQ/KmSK9og
 ycA7bcIKZiMtkvYiEyki27/7aAxJYOQBLX0ZPOkDq+yJUz8YB+3EPOtQ969XzH+KpFkjq9WEQePIF
 4nOz6ezCYNehBlRtYIY1nFEr8BOVE5nu6WKtXloxlrdk+Z/BiylfJ4BqaoVAX/qpU7ZQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=CgUI+2tXv2m0nVzqIL76WrwoGRP9ACYfDzKtSiw9BfM=; b=SVmwaK6aJkKecQ6+y89FZt4mGL
 H9dWIgjAlLJMahGja1q355M2z+AwVdGOYRU8y34wWuQOyGCKUK5gbVOtLATisHxv+dHkngfqeLAy6
 xashyqOnO91fj7fy8Sv7uOpVu8vuAwJNp9aR04LM4X2V7kvAqh7zOssd1hJx1TUp02NM=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1sdsHY-0001CJ-3l for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 13 Aug 2024 14:13:52 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id BD9446170E;
 Tue, 13 Aug 2024 14:13:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04FC6C4AF0B;
 Tue, 13 Aug 2024 14:13:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1723558426;
 bh=r8VUUyyyojUjPoAkVdjtfFrqOLyTXjXWxZ3MOiPSYtc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=q7Ws6BEUshWrGSkJ6u4ewdjywioZy237bBmdMqh1qJUIyGgigcirqLDjCC+IxTknZ
 5fVyXQ+QUcBwqUiDQPBEDOHzeBk2KuzDq1Tl9sTJuVSCL45d+EQi9sPHGJz0fgzm2Z
 6pKbzAhXdL2RLzcYIJKnPM1yjoNxsvq/oP2NUu0LmuIGrZe1YuS2Y11rcXC7bALDQw
 XzD2mqp2kfacqv9pyuCySGeuwzcU499UfsiQnAB1aeNC4Kg+CPs226Hd/thhKUW+f0
 0quITyLHUZZS5mLINWSNJqMiiDrczFepJXA2q6+N6aOviZT2opgDepR2f9Sb+fxePA
 aTO8Aq0m3Vtzg==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Date: Tue, 13 Aug 2024 22:13:24 +0800
Message-Id: <20240813141331.417067-2-chao@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240813141331.417067-1-chao@kernel.org>
References: <20240813141331.417067-1-chao@kernel.org>
MIME-Version: 1.0
X-Headers-End: 1sdsHY-0001CJ-3l
Subject: [f2fs-dev] [PATCH 2/9] f2fs: convert f2fs_vm_page_mkwrite() to use
 folio
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
Cc: linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Convert to use folio, so that we can get rid of 'page->index' to
prepare for removal of 'index' field in structure page [1].

[1] https://lore.kernel.org/all/Zp8fgUSIBGQ1TN0D@casper.infradead.org/

Cc: Matthew Wilcox <willy@infradead.org>
Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/file.c | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 8d2f4160a8eb..3c73da7bb05a 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -53,7 +53,7 @@ static vm_fault_t f2fs_filemap_fault(struct vm_fault *vmf)
 
 static vm_fault_t f2fs_vm_page_mkwrite(struct vm_fault *vmf)
 {
-	struct page *page = vmf->page;
+	struct folio *folio = page_folio(vmf->page);
 	struct inode *inode = file_inode(vmf->vma->vm_file);
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
 	struct dnode_of_data dn;
@@ -85,7 +85,7 @@ static vm_fault_t f2fs_vm_page_mkwrite(struct vm_fault *vmf)
 
 #ifdef CONFIG_F2FS_FS_COMPRESSION
 	if (f2fs_compressed_file(inode)) {
-		int ret = f2fs_is_compressed_cluster(inode, page->index);
+		int ret = f2fs_is_compressed_cluster(inode, folio->index);
 
 		if (ret < 0) {
 			err = ret;
@@ -105,11 +105,11 @@ static vm_fault_t f2fs_vm_page_mkwrite(struct vm_fault *vmf)
 
 	file_update_time(vmf->vma->vm_file);
 	filemap_invalidate_lock_shared(inode->i_mapping);
-	lock_page(page);
-	if (unlikely(page->mapping != inode->i_mapping ||
-			page_offset(page) > i_size_read(inode) ||
-			!PageUptodate(page))) {
-		unlock_page(page);
+	folio_lock(folio);
+	if (unlikely(folio->mapping != inode->i_mapping ||
+			folio_pos(folio) > i_size_read(inode) ||
+			!folio_test_uptodate(folio))) {
+		folio_unlock(folio);
 		err = -EFAULT;
 		goto out_sem;
 	}
@@ -117,9 +117,9 @@ static vm_fault_t f2fs_vm_page_mkwrite(struct vm_fault *vmf)
 	set_new_dnode(&dn, inode, NULL, NULL, 0);
 	if (need_alloc) {
 		/* block allocation */
-		err = f2fs_get_block_locked(&dn, page->index);
+		err = f2fs_get_block_locked(&dn, folio->index);
 	} else {
-		err = f2fs_get_dnode_of_data(&dn, page->index, LOOKUP_NODE);
+		err = f2fs_get_dnode_of_data(&dn, folio->index, LOOKUP_NODE);
 		f2fs_put_dnode(&dn);
 		if (f2fs_is_pinned_file(inode) &&
 		    !__is_valid_data_blkaddr(dn.data_blkaddr))
@@ -127,11 +127,11 @@ static vm_fault_t f2fs_vm_page_mkwrite(struct vm_fault *vmf)
 	}
 
 	if (err) {
-		unlock_page(page);
+		folio_unlock(folio);
 		goto out_sem;
 	}
 
-	f2fs_wait_on_page_writeback(page, DATA, false, true);
+	f2fs_wait_on_page_writeback(folio_page(folio, 0), DATA, false, true);
 
 	/* wait for GCed page writeback via META_MAPPING */
 	f2fs_wait_on_block_writeback(inode, dn.data_blkaddr);
@@ -139,18 +139,18 @@ static vm_fault_t f2fs_vm_page_mkwrite(struct vm_fault *vmf)
 	/*
 	 * check to see if the page is mapped already (no holes)
 	 */
-	if (PageMappedToDisk(page))
+	if (folio_test_mappedtodisk(folio))
 		goto out_sem;
 
 	/* page is wholly or partially inside EOF */
-	if (((loff_t)(page->index + 1) << PAGE_SHIFT) >
+	if (((loff_t)(folio->index + 1) << PAGE_SHIFT) >
 						i_size_read(inode)) {
 		loff_t offset;
 
 		offset = i_size_read(inode) & ~PAGE_MASK;
-		zero_user_segment(page, offset, PAGE_SIZE);
+		folio_zero_segment(folio, offset, folio_size(folio));
 	}
-	set_page_dirty(page);
+	folio_mark_dirty(folio);
 
 	f2fs_update_iostat(sbi, inode, APP_MAPPED_IO, F2FS_BLKSIZE);
 	f2fs_update_time(sbi, REQ_TIME);
@@ -162,7 +162,7 @@ static vm_fault_t f2fs_vm_page_mkwrite(struct vm_fault *vmf)
 out:
 	ret = vmf_fs_error(err);
 
-	trace_f2fs_vm_page_mkwrite(inode, page->index, vmf->vma->vm_flags, ret);
+	trace_f2fs_vm_page_mkwrite(inode, folio->index, vmf->vma->vm_flags, ret);
 	return ret;
 }
 
-- 
2.40.1



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
