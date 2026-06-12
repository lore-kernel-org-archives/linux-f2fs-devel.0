Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EE5FCD8CA8
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 12 Jun 2026 08:04:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-Id:Date:To:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=EBRZ6Wrt+971I/59+tGceqCjKYGdjRLZcfC7UdVmYgc=; b=Pj8ro7zYKAjXn4Kb5ueMc1vWC/
	Aejuhe7BCSz/fb7uI8Ek0YRVPR/0RbyjZ12kULeIZT/D5DBhKRYYJGFlWm23l0uWuf5vtodQVylbT
	QUykV/aFOMktdIhM2iTeVeZ+Y9M2ZVT6RZJauQSBEdTHw4rCq+GPwSzcVC/A/vaq/3TE=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wXwsa-0007Do-6v;
	Fri, 12 Jun 2026 08:04:37 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <nzzhao@126.com>) id 1wXwsS-0007Ak-4S
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 12 Jun 2026 08:04:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Sender:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=7XtFIXNO2nV45UwHNTtCd3E8/O3DelfuTrbI36wEcMU=; b=fn1jBb9slA8e8N9roUkAMFj42Y
 GRz5lJ1SJHbXRxTbozM+7ejrA0YGoLnvNqJ3QhE4hbTcqgtgG+4RwQe0NoKCMzYtNfGGGY91KGbVd
 h8BbPEIDkDIghIIEcqzHk+3UabZHFuSfQoISnoQlsdTz6D5AGnobm+JGPQQYfV96QFk8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Sender:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=7XtFIXNO2nV45UwHNTtCd3E8/O3DelfuTrbI36wEcMU=; b=htUE4e8EH8U3XUWWUgStnK6gRw
 5YpP3ucuaQETy7ehio8tBPVCDhO5NAoSWCA6ge88K77YV6WI7vTwqsU7NTObP5bGkvZQuYxEMsiMZ
 E8kj7W9+FU8CD0CTiePAw6idJePk42zXVR314K6Shxpxlrt21K6UWHfAQbVkz+4BBt68=;
Received: from m16.mail.126.com ([117.135.210.7])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wXwsM-0004JS-8a for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 12 Jun 2026 08:04:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
 s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=7X
 tFIXNO2nV45UwHNTtCd3E8/O3DelfuTrbI36wEcMU=; b=llb+ymwf1wJdSu0m5H
 Q34mKbnl0pjp1echboYDl9weMcMlc00Vox1KMamhHFDSutchJ0uSTU0ZUafh/z4T
 fQY0m6iB9hQus82cOd7h+AdW5qP11XHYjYRla9rLiJ1Qr4hi3pov8rHBwUNIPt/A
 p1YQiuhQlIQOkROAms2pj6QDY=
Received: from YLLaptop.. (unknown [])
 by gzga-smtp-mtada-g0-0 (Coremail) with SMTP id
 _____wDX_ytWvStqyXqrBQ--.43664S8; 
 Fri, 12 Jun 2026 16:03:44 +0800 (CST)
To: linux-f2fs-devel@lists.sourceforge.net
Date: Fri, 12 Jun 2026 16:03:31 +0800
Message-Id: <20260612080334.70657-7-zhaonanzhe@xiaomi.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260612080334.70657-1-zhaonanzhe@xiaomi.com>
References: <20260612080334.70657-1-zhaonanzhe@xiaomi.com>
MIME-Version: 1.0
X-CM-TRANSID: _____wDX_ytWvStqyXqrBQ--.43664S8
X-Coremail-Antispam: 1Uf129KBjvJXoW3WrWktr4xZr4DKF17Kw1xZrb_yoW7uw4Upr
 W5G398GrWfWr1UWrn3KFn8Zw1rK34xWrWUuFZ3G3WxZa1Yqwn3KF1kta48ZF48tr98AFna
 qFWjyFy5WFyUGF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jbo7NUUUUU=
X-Originating-IP: [223.104.43.40]
X-CM-SenderInfo: xq22xtbr6rjloofrz/xtbBogDsvGorvWCYWwAA3t
X-Headers-End: 1wXwsM-0004JS-8a
Subject: [f2fs-dev] [RFC PATCH 6/9] f2fs: prepare mmap write faults for
 large folios
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
From: Nanzhe Zhao via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Nanzhe Zhao <zhaonanzhe@xiaomi.com>
Cc: Barry Song <baohua@kernel.org>, Ryan Roberts <Ryan.Roberts@arm.com>,
 Juan Yescas <jyescas@google.com>, Dev Jain <Dev.Jain@arm.com>,
 David Hildenbrand <David.Hildenbrand@arm.com>,
 Pengfei Li <lipengfei28@xiaomi.com>, Bo Zhang <zhangbo56@xiaomi.com>,
 Kalesh Singh <kaleshsingh@google.com>, Jaegeuk Kim <jaegeuk@kernel.org>,
 Nanzhe Zhao <zhaonanzhe@xiaomi.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

From: Nanzhe <zhaonanzhe@xiaomi.com>

Now write protect `mmap` also need to support large folio,
Change `f2fs_vm_page_mkwrite` to acheive that.

Note it currently marks the whole large folio dirty
to avoid data loss which causes write amplification.
Further optimization is welcome.

Signed-off-by: Nanzhe <zhaonanzhe@xiaomi.com>
---
 fs/f2fs/data.c |  5 ++---
 fs/f2fs/f2fs.h |  2 ++
 fs/f2fs/file.c | 50 +++++++++++++++++++++++++++++++++-----------------
 3 files changed, 37 insertions(+), 20 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 2de8c7963080..346057826835 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -2512,7 +2512,7 @@ int f2fs_read_multi_pages(struct compress_ctx *cc, struct bio **bio_ret,
 }
 #endif
 
-static struct f2fs_folio_state *ffs_find_or_alloc(struct folio *folio)
+struct f2fs_folio_state *ffs_find_or_alloc(struct folio *folio)
 {
 	struct f2fs_folio_state *ffs;
 	unsigned int nr_subpages = folio_nr_pages(folio);
@@ -2596,8 +2596,7 @@ void ffs_mark_subrange_uptodate(struct folio *folio, size_t offset, size_t len)
 		folio_mark_uptodate(folio);
 }
 
-static void ffs_mark_subrange_dirty(struct folio *folio,
-				    size_t offset, size_t len)
+void ffs_mark_subrange_dirty(struct folio *folio, size_t offset, size_t len)
 {
 	struct f2fs_folio_state *ffs;
 	unsigned int nr_subpages, start, end;
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index ac71d0d22a81..c9d0e9b41a91 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -4255,6 +4255,8 @@ int f2fs_write_single_data_page(struct folio *folio, int *submitted,
 				int compr_blocks, bool allow_balance);
 bool ffs_test_blk_uptodate(const struct folio *folio, pgoff_t index);
 void ffs_mark_subrange_uptodate(struct folio *folio, size_t offset, size_t len);
+struct f2fs_folio_state *ffs_find_or_alloc(struct folio *folio);
+void ffs_mark_subrange_dirty(struct folio *folio, size_t offset, size_t len);
 void f2fs_write_failed(struct inode *inode, loff_t to);
 void f2fs_invalidate_folio(struct folio *folio, size_t offset, size_t length);
 bool f2fs_release_folio(struct folio *folio, gfp_t wait);
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index eb8e237f3dad..c1b3c9d1ab92 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -78,6 +78,12 @@ static vm_fault_t f2fs_vm_page_mkwrite(struct vm_fault *vmf)
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
 	struct dnode_of_data dn;
 	bool need_alloc = !f2fs_is_pinned_file(inode);
+	pgoff_t pidx = folio->index + folio_page_idx(folio, vmf->page);
+	loff_t pos = (loff_t)pidx << PAGE_SHIFT;
+	loff_t isize;
+	loff_t folio_start;
+	loff_t valid_end;
+	size_t dirty_len;
 	int err = 0;
 	vm_fault_t ret;
 
@@ -114,7 +120,7 @@ static vm_fault_t f2fs_vm_page_mkwrite(struct vm_fault *vmf)
 
 #ifdef CONFIG_F2FS_FS_COMPRESSION
 	if (f2fs_compressed_file(inode)) {
-		int ret = f2fs_is_compressed_cluster(inode, folio->index);
+		int ret = f2fs_is_compressed_cluster(inode, pidx);
 
 		if (ret < 0) {
 			err = ret;
@@ -132,14 +138,17 @@ static vm_fault_t f2fs_vm_page_mkwrite(struct vm_fault *vmf)
 
 	f2fs_bug_on(sbi, f2fs_has_inline_data(inode));
 
-	f2fs_zero_post_eof_page(inode, (folio->index + 1) << PAGE_SHIFT, true);
-
 	file_update_time(vmf->vma->vm_file);
 	filemap_invalidate_lock_shared(inode->i_mapping);
 
 	folio_lock(folio);
+	isize = i_size_read(inode);
+	folio_start = folio_pos(folio);
+	valid_end = min_t(loff_t, folio_start + folio_size(folio), isize);
+	dirty_len = valid_end > folio_start ? valid_end - folio_start : 0;
+
 	if (unlikely(folio->mapping != inode->i_mapping ||
-			folio_pos(folio) > i_size_read(inode) ||
+			pos >= isize ||
 			!folio_test_uptodate(folio))) {
 		folio_unlock(folio);
 		err = -EFAULT;
@@ -149,9 +158,19 @@ static vm_fault_t f2fs_vm_page_mkwrite(struct vm_fault *vmf)
 	set_new_dnode(&dn, inode, NULL, NULL, 0);
 	if (need_alloc) {
 		/* block allocation */
-		err = f2fs_get_block_locked(&dn, folio->index);
+		if (folio_test_large(folio)) {
+			pgoff_t i, nr = DIV_ROUND_UP(dirty_len, PAGE_SIZE);
+
+			for (i = 0; i < nr; i++) {
+				err = f2fs_get_block_locked(&dn, folio->index + i);
+				if (err)
+					break;
+			}
+		} else {
+			err = f2fs_get_block_locked(&dn, pidx);
+		}
 	} else {
-		err = f2fs_get_dnode_of_data(&dn, folio->index, LOOKUP_NODE);
+		err = f2fs_get_dnode_of_data(&dn, pidx, LOOKUP_NODE);
 		f2fs_put_dnode(&dn);
 		if (f2fs_is_pinned_file(inode) &&
 		    !__is_valid_data_blkaddr(dn.data_blkaddr))
@@ -168,20 +187,17 @@ static vm_fault_t f2fs_vm_page_mkwrite(struct vm_fault *vmf)
 	/* wait for GCed page writeback via META_MAPPING */
 	f2fs_wait_on_block_writeback(inode, dn.data_blkaddr);
 
-	/*
-	 * check to see if the page is mapped already (no holes)
-	 */
-	if (folio_test_mappedtodisk(folio))
-		goto out_sem;
-
 	/* page is wholly or partially inside EOF */
-	if (((loff_t)(folio->index + 1) << PAGE_SHIFT) >
-						i_size_read(inode)) {
-		loff_t offset;
+	if (folio_start + folio_size(folio) > isize) {
+		size_t offset = offset_in_folio(folio, isize);
 
-		offset = i_size_read(inode) & ~PAGE_MASK;
 		folio_zero_segment(folio, offset, folio_size(folio));
 	}
+
+	if (folio_test_large(folio)) {
+		ffs_find_or_alloc(folio);
+		ffs_mark_subrange_dirty(folio, 0, dirty_len);
+	}
 	folio_mark_dirty(folio);
 
 	f2fs_update_iostat(sbi, inode, APP_MAPPED_IO, F2FS_BLKSIZE);
@@ -194,7 +210,7 @@ static vm_fault_t f2fs_vm_page_mkwrite(struct vm_fault *vmf)
 out:
 	ret = vmf_fs_error(err);
 
-	trace_f2fs_vm_page_mkwrite(inode, folio->index, vmf->vma->vm_flags, ret);
+	trace_f2fs_vm_page_mkwrite(inode, pidx, vmf->vma->vm_flags, ret);
 	return ret;
 }
 
-- 
2.34.1



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
