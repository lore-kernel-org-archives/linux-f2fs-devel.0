Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5704FCDB46F
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 22 Jun 2026 16:09:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-Id:Date:To:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OQ3lPnEnUgmpaVQHLQS8QdefRxDc9TSsCAr1XNxzRY8=; b=U/Xvbr6ZdV7qzyKjPx8TBNm01K
	MKtMPa6Daci/QF0lkzwlR8lW4VCreK+8V/CcDf5r8DyBmSsd2pMvBqPlk5FeHo3gl5l+ALQAM+PJQ
	gtjCzjMaCSKoH6q0g/bis1P1G3SmB77Fs+xZj7PoKsVsWe+zUYeWs+aWJQKwWhIFpfgQ=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wbhDB-00056t-GR;
	Mon, 22 Jun 2026 16:09:23 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <nzzhao@126.com>) id 1wbhD9-00056X-3G
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 22 Jun 2026 16:09:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Sender:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=IIZOu9r8dRLF7yOHU74XLiX0nrUXOdifNmNOr3K0Vr4=; b=Gu31YDJyD6509M3IKiLaiKj+md
 P+O1rm/3pv4OumURrzfa86oVbLv9zsH3/XUWFqxc57dplK6yX8eMtR6l9fH313nDopFece4wf2lQA
 NrW6A4+XbpZIpXyWvvfcasWC+77rFWlOUhbQe41+xxy8MSKsyucu/ERShwhArBq4Wk+g=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Sender:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=IIZOu9r8dRLF7yOHU74XLiX0nrUXOdifNmNOr3K0Vr4=; b=jOJ8as7tnta3U5ZaLROaXmt5aC
 Ob5+/8zl4PhOwkzAikNDlpTNYmZo6ThaV4m1y0jS4SlRijYuQ9QSD/ojdf7hkkHaUbbOspV+1604A
 PFQsQ2HzLOFwEyFEFVd2N5lMCe6W9tmBH1dX13lmLRrtAN/pGQQTHbpJEuHHszN9SAlM=;
Received: from m16.mail.126.com ([117.135.210.8])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wbhD4-0001Al-D8 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 22 Jun 2026 16:09:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
 s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=II
 ZOu9r8dRLF7yOHU74XLiX0nrUXOdifNmNOr3K0Vr4=; b=dcciUl2n1cARTah09M
 ojNyKnUpDf9n6Z14/4XTPmz9Bz6nrPigXPZim4Tv5IO0b+E+HuvSlING4bnetgIe
 iqaDhbKPAH2XiwpdHFzS4CG8nmuh/oQ6us9Eg2rrC/Ns+AbNxMepPXTMMG2TMaLh
 HVsUynriOCDY3LTZVw5hOkohE=
Received: from YLLaptop.. (unknown [])
 by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id
 _____wAXfIP+XTlqz32SBw--.54996S8; 
 Tue, 23 Jun 2026 00:08:41 +0800 (CST)
To: linux-f2fs-devel@lists.sourceforge.net
Date: Tue, 23 Jun 2026 00:08:26 +0800
Message-Id: <20260622160830.324455-7-zhaonanzhe@xiaomi.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260622160830.324455-1-zhaonanzhe@xiaomi.com>
References: <20260622160830.324455-1-zhaonanzhe@xiaomi.com>
MIME-Version: 1.0
X-CM-TRANSID: _____wAXfIP+XTlqz32SBw--.54996S8
X-Coremail-Antispam: 1Uf129KBjvJXoW3JryUWw1DXF17JFWrWw1fCrg_yoW7Zw17pr
 W5Gwn5GrWfXw15WrnagFn8Zw1rK34xWrW7uFWfG3WxZ3Wjqwn3KF1kta48ZF1ktr98AFn2
 qFWjyFy5WF1UGF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j189NUUUUU=
X-Originating-IP: [39.144.78.181]
X-CM-SenderInfo: xq22xtbr6rjloofrz/xtbBowmCUmo5Xgm7owAA3m
X-Headers-End: 1wbhD4-0001Al-D8
Subject: [f2fs-dev] [RFC PATCH v2 06/10] f2fs: prepare mmap write faults for
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
Cc: Barry Song <baohua@kernel.org>, Nanzhe Zhao <zhaonanzhe@xiaomi.com>,
 Juan Yescas <jyescas@google.com>, Dev Jain <Dev.Jain@arm.com>,
 linux-kernel@vger.kernel.org, David Hildenbrand <David.Hildenbrand@arm.com>,
 Bo Zhang <zhangbo56@xiaomi.com>, Kalesh Singh <kaleshsingh@google.com>,
 Ryan Roberts <Ryan.Roberts@arm.com>, Jaegeuk Kim <jaegeuk@kernel.org>,
 Pengfei Li <lipengfei28@xiaomi.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Now write protect `mmap` also need to support large folio,
Change `f2fs_vm_page_mkwrite` to acheive that.

Note it currently marks the whole large folio dirty
to avoid data loss which causes write amplification.
Further optimization is welcome.

Signed-off-by: Nanzhe Zhao <zhaonanzhe@xiaomi.com>
---
 fs/f2fs/data.c |  2 +-
 fs/f2fs/f2fs.h |  5 +++++
 fs/f2fs/file.c | 55 +++++++++++++++++++++++++++++++++-----------------
 3 files changed, 43 insertions(+), 19 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 8485918e1e4c..c37800befa1e 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -2540,7 +2540,7 @@ int f2fs_read_multi_pages(struct compress_ctx *cc, struct bio **bio_ret,
 }
 #endif
 
-static struct f2fs_folio_state *ffs_find_or_alloc(struct folio *folio)
+struct f2fs_folio_state *ffs_find_or_alloc(struct folio *folio)
 {
 	struct f2fs_folio_state *ffs;
 	unsigned int nr_subpages = folio_nr_pages(folio);
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 2443fa3647d2..1d2e40a42263 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -4256,6 +4256,11 @@ int f2fs_write_single_data_page(struct folio *folio, int *submitted,
 				enum iostat_type io_type,
 				int compr_blocks, bool allow_balance);
 bool ffs_test_blk_uptodate(const struct folio *folio, pgoff_t index);
+struct f2fs_folio_state *ffs_find_or_alloc(struct folio *folio);
+void ffs_mark_subrange_dirty(struct folio *folio, size_t offset, size_t len);
+bool ffs_clear_subrange_dirty_and_test(struct folio *folio, size_t offset,
+					size_t len);
+void ffs_clear_subrange_dirty(struct folio *folio, size_t offset, size_t len);
 void f2fs_write_failed(struct inode *inode, loff_t to);
 void f2fs_invalidate_folio(struct folio *folio, size_t offset, size_t length);
 bool f2fs_release_folio(struct folio *folio, gfp_t wait);
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 1dddd4b04770..b723e0547fad 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -78,6 +78,13 @@ static vm_fault_t f2fs_vm_page_mkwrite(struct vm_fault *vmf)
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
 	struct dnode_of_data dn;
 	bool need_alloc = !f2fs_is_pinned_file(inode);
+	pgoff_t pidx = folio->index + folio_page_idx(folio, vmf->page);
+	loff_t pos = (loff_t)pidx << PAGE_SHIFT;
+	loff_t isize;
+	loff_t folio_start;
+	loff_t valid_end;
+	size_t dirty_len;
+	size_t subpage_off;
 	int err = 0;
 	vm_fault_t ret;
 
@@ -114,7 +121,7 @@ static vm_fault_t f2fs_vm_page_mkwrite(struct vm_fault *vmf)
 
 #ifdef CONFIG_F2FS_FS_COMPRESSION
 	if (f2fs_compressed_file(inode)) {
-		int ret = f2fs_is_compressed_cluster(inode, folio->index);
+		int ret = f2fs_is_compressed_cluster(inode, pidx);
 
 		if (ret < 0) {
 			err = ret;
@@ -132,15 +139,20 @@ static vm_fault_t f2fs_vm_page_mkwrite(struct vm_fault *vmf)
 
 	f2fs_bug_on(sbi, f2fs_has_inline_data(inode));
 
-	f2fs_zero_post_eof_page(inode, (folio->index + 1) << PAGE_SHIFT, true);
-
 	file_update_time(vmf->vma->vm_file);
 	filemap_invalidate_lock_shared(inode->i_mapping);
 
 	folio_lock(folio);
+	isize = i_size_read(inode);
+	folio_start = folio_pos(folio);
+	subpage_off = offset_in_folio(folio, pos);
+	valid_end = min_t(loff_t, folio_start + folio_size(folio), isize);
+	dirty_len = valid_end > folio_start ? valid_end - folio_start : 0;
+
 	if (unlikely(folio->mapping != inode->i_mapping ||
-			folio_pos(folio) > i_size_read(inode) ||
-			!folio_test_uptodate(folio))) {
+			pos >= isize ||
+			!ffs_test_blk_uptodate(folio,
+			folio->index + (subpage_off >> PAGE_SHIFT)))) {
 		folio_unlock(folio);
 		err = -EFAULT;
 		goto out_sem;
@@ -149,9 +161,19 @@ static vm_fault_t f2fs_vm_page_mkwrite(struct vm_fault *vmf)
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
@@ -168,20 +190,17 @@ static vm_fault_t f2fs_vm_page_mkwrite(struct vm_fault *vmf)
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
@@ -194,7 +213,7 @@ static vm_fault_t f2fs_vm_page_mkwrite(struct vm_fault *vmf)
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
