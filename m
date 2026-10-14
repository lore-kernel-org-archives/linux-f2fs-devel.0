Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A50CDCC6B25
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 14 Oct 2026 06:45:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=c7ZZfArx1LRB3MuJ7Q9L+NfOWM2WYB9OA2X8gQakA6c=; b=RZGsRJCtykTnkSYWUCGzpoWvAa
	yFduRi+7DxlxDbcZKmXw2gJrq/dQNTa/HXv6wRHz/haE/XnMGXc9ISfcHy8rXfjuGKDVTXVllltH3
	gKKnoDG2kOrrivzq4U/ZOMr6hSkBj3rXQ2RU05wZkvi4I2+8kFfhy9FRqAM18fd5Fprk=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xGskL-0006ls-Tb;
	Wed, 14 Oct 2026 06:45:54 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <nzzhao.sigma@gmail.com>) id 1xGskJ-0006lT-Sn
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 14 Oct 2026 06:45:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=iq0JUoaxWVUD6dRb+7CnNaLcmONU4gHxT5O+hxYjY8M=; b=f/WOjhKFxeRrHbf/itCb+GF+c9
 afL0BVsZvTBr77fqE+VZaZRM67R8FHIxDwPkTt8Th2zJepEqUkidlHe5Bhlx8J/WO6WlYzR1n14Bx
 L3S4IinP61a4wEwG1Y/4iZk0AKe3CO2GTpOV4acUT6XS9wq1s78Yp0i6wuVs0uYPXA1I=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=iq0JUoaxWVUD6dRb+7CnNaLcmONU4gHxT5O+hxYjY8M=; b=G9fqtmttg1gVt/+jKTEt5tODAW
 Ft5RaJ46QOLL+OrNX9FpFv3haYfl8o2y+wt+mxOxSg1IrwcY1QYmcNhVYEn2YbE4RT+YeK+yrzwUX
 IogIYwVnYHfKixAEHuovcJPZC/eSNJeGqhQChSNPnVhacGcJWiJ38IkbCnHgLQCKkab0=;
Received: from mail-pj2-f6.google.com ([74.125.227.134])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xGskI-0000wo-Pi for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 14 Oct 2026 06:45:52 +0000
Received: by mail-pj2-f6.google.com with SMTP id
 98e67ed59e1d1-3964e7720afso1846937a91.1
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 13 Oct 2026 23:45:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791960345; x=1792565145; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=iq0JUoaxWVUD6dRb+7CnNaLcmONU4gHxT5O+hxYjY8M=;
 b=mXHLNp8hYXdbhhota52gbxxlMt0UTeemOnTB9o5N9gGdwXExbopCAsWoPJFsPluvEB
 F8dsiNXfhXMosPxS/O+7waOcmmtgLuuFMFUbiUbrzuaqLtuubMdKMGfwgJk1/nGtMuh4
 0Tec/C0PodHNz01mkCyHBnaDMyQYofUwBrm8rbBzXDDEG7r1WmmozYvlvNh1fMFu3Wt7
 porj2qzHU+WkMybbqTEDXBT0bsaXx3NWszSbHj4B9UfFUmzHw8KxAA3Cp0iTd9i3lyX+
 FNM4cJI8U5aZAyoSNY9McHyIDgX7Bj3cjv+7ye5nqBzHnAFxUalATaPh1iJh96fUmd2y
 CgBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791960345; x=1792565145;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=iq0JUoaxWVUD6dRb+7CnNaLcmONU4gHxT5O+hxYjY8M=;
 b=snjMHdb4S9CpL7UqUQN2ZoTRep1FDh7Z1KUSIwVbtjquZIcUcAwhbpBtmWiEdRgrPQ
 wr4KGwKD9ezRNU2nArhpRDt0qWJQF9+RB+WagMpM8hkTPm3qRhgJI9j5z4I6wX+tj5Yd
 JA0SoVy+IZVwJWTPOM7yy28aEzB4/LSes3W/nzVoIxA+uORYRmz/waxhJwCQHVYVwWlM
 WyDoe4kj/Y1bLrr4eGEWbX42kMx7ZmHmGoctRxMtlCYEEfm+moO5qLGHpmZ29GHlssm8
 nUo3X92h8v9ozJAerkv0KNeUfhDQ7zlGxotSBoayi4N3VgToVoqnlCxUVUslg1AQDvXv
 e3RA==
X-Gm-Message-State: AFq9FYL12q6ZBhMuNBLNXgCVkXXGt2YVCfKTjpgCqVdFD4gMEcgW3a24
 tJH/4kPh0PmLL55YOl/0dpeHbb/mD2Pry+n1wbgBK8o3rY9kTpgXPVuQQ3L077km
X-Gm-Gg: AYBFou0k+X8eLxwUFcf2CVYaqXruLm45q0Tl1osENaVvvfMGIiN8xu74WEVe+G2y+wO
 csoFVgTZh7GmyoZeXckqXzr2xhdfOuuugmcx+Xntw2cknqdz7lOcbrGEg8Gb6jh6Yq1sAN42WPv
 KM/Z7x49UV1N4pC8VUFRGoDm/sbPAZozKIvA5Zp3n99iHpoXEGRIFSVa+qISneI0uBYRfuO8/Kt
 Xlq9u8HkTVMczECz0THYlyWgGcik2G2vgEXd72mZCoVGY3k1BV80PxOF9GKk5cd3vXtUI2SP/vW
 dM76ZEO0/kugK4x4sa3b3kgT8QnzCBOu5VbCBvuqETtwrIRlU+nqakUL3mtwhz/Ri2jwudWjNhW
 UxKGSmBH5XIRj0o8UG3dVSzNxMAgolnWTCpNliTUiA6L/0PkALH63RPGtkbYXDlvoLQm53mx0hQ
 Bj09gMyLF1QGZ065mywfmLSnEzGT+k8Is8m7Pfuipi8s9f2NYB90VqSMSicJcbgWL1OrJO/C+a8
 ffEyLafRRZyCDOuLnV37KitMqbXKY1/i8df
X-Received: by 2002:a17:90b:4d86:b0:3a6:d8e0:c359 with SMTP id
 98e67ed59e1d1-3ab3a2fe039mr12110258a91.2.1791960345069; 
 Tue, 13 Oct 2026 23:45:45 -0700 (PDT)
Received: from nzzhao-ThinkCentre-M760t.mioffice.cn ([43.224.245.179])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ac5f04e324sm3236371a91.2.2026.10.13.23.45.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2026 23:45:44 -0700 (PDT)
From: Nanzhe Zhao <nzzhao.sigma@gmail.com>
X-Google-Original-From: Nanzhe Zhao <zhaonanzhe@xiaomi.com>
To: linux-f2fs-devel@lists.sourceforge.net, Jaegeuk Kim <jaegeuk@kernel.org>,
 Chao Yu <chao@kernel.org>
Date: Wed, 14 Oct 2026 14:44:36 +0800
Message-ID: <20261014064445.2835813-8-zhaonanzhe@xiaomi.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261014064445.2835813-1-zhaonanzhe@xiaomi.com>
References: <20261014064445.2835813-1-zhaonanzhe@xiaomi.com>
MIME-Version: 1.0
X-Headers-End: 1xGskI-0000wo-Pi
Subject: [f2fs-dev] [PATCH v5 07/16] f2fs: prepare mmap write faults for
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
Cc: Barry Song <baohua@kernel.org>, Juan Yescas <jyescas@google.com>,
 Daeho Jeong <daehojeong@google.com>, Pengfei Li <lipengfei28@xiaomi.com>,
 Dev Jain <Dev.Jain@arm.com>, David Hildenbrand <David.Hildenbrand@arm.com>,
 linux-kernel@vger.kernel.org, Bo Zhang <zhangbo56@xiaomi.com>,
 Kalesh Singh <kaleshsingh@google.com>, Nanzhe Zhao <nzzhao@126.com>,
 Nanzhe Zhao <zhaonanzhe@xiaomi.com>, Ryan Roberts <Ryan.Roberts@arm.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Now write protect `mmap` also need to support large folio,
Change `f2fs_vm_page_mkwrite` to achieve that.

Note it currently marks the whole large folio dirty
to avoid data loss which causes write amplification.
Further optimization is welcome.

The folio_zero_segment() in mkwrite is extended to zero the
post-EOF part of the faulted folio for both order-0 and large
folios, so the f2fs_zero_post_eof_page() call that was added
to cover the removed shortcut is no longer needed.

Signed-off-by: Nanzhe Zhao <zhaonanzhe@xiaomi.com>
---
 fs/f2fs/f2fs.h |  4 +++
 fs/f2fs/file.c | 96 ++++++++++++++++++++++++++++++++------------------
 2 files changed, 65 insertions(+), 35 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 9edff1e79f2c..d976e6ad058b 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -4492,6 +4492,10 @@ int f2fs_write_single_data_page(struct folio *folio, int *submitted,
 				enum iostat_type io_type,
 				int compr_blocks, bool allow_balance);
 bool f2fs_ffs_test_blk_uptodate(const struct folio *folio, pgoff_t index);
+struct f2fs_folio_state *f2fs_ffs_find_or_alloc(struct folio *folio);
+void f2fs_ffs_mark_subrange_dirty(struct folio *folio, size_t offset, size_t len);
+bool f2fs_ffs_clear_subrange_dirty_and_test(struct folio *folio, size_t offset,
+					    size_t len);
 void f2fs_write_failed(struct inode *inode, loff_t to);
 void f2fs_invalidate_folio(struct folio *folio, size_t offset, size_t length);
 bool f2fs_release_folio(struct folio *folio, gfp_t wait);
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index e53cdb4467b4..30f1484d2f48 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -118,14 +118,48 @@ static vm_fault_t f2fs_filemap_fault(struct vm_fault *vmf)
 	return ret;
 }
 
+static int f2fs_get_block_mkwrite(struct inode *inode, struct folio *folio,
+				  pgoff_t index, bool need_alloc)
+{
+	struct dnode_of_data dn;
+	int err;
+
+	set_new_dnode(&dn, inode, NULL, NULL, 0);
+	if (need_alloc) {
+		err = f2fs_get_block_locked(&dn, index);
+	} else {
+		err = f2fs_get_dnode_of_data(&dn, index, LOOKUP_NODE);
+		f2fs_put_dnode(&dn);
+		if (f2fs_is_pinned_file(inode) &&
+		    !__is_valid_data_blkaddr(dn.data_blkaddr))
+			err = -EIO;
+	}
+
+	if (err)
+		return err;
+
+	f2fs_folio_wait_writeback(folio, false, true);
+
+	/* wait for GCed page writeback via META_MAPPING */
+	f2fs_wait_on_block_writeback(inode, dn.data_blkaddr);
+
+	return 0;
+}
+
 static vm_fault_t f2fs_vm_page_mkwrite(struct vm_fault *vmf)
 {
 	struct folio *folio = page_folio(vmf->page);
 	struct inode *inode = file_inode(vmf->vma->vm_file);
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
-	struct dnode_of_data dn;
 	bool need_alloc = !f2fs_is_pinned_file(inode);
+	pgoff_t pidx = folio->index + folio_page_idx(folio, vmf->page);
+	loff_t pos = (loff_t)pidx << PAGE_SHIFT;
 	loff_t isize;
+	loff_t folio_start;
+	loff_t valid_end;
+	size_t dirty_len;
+	size_t subpage_off;
+	pgoff_t i, nr;
 	int err = 0;
 	vm_fault_t ret;
 
@@ -166,7 +200,7 @@ static vm_fault_t f2fs_vm_page_mkwrite(struct vm_fault *vmf)
 
 #ifdef CONFIG_F2FS_FS_COMPRESSION
 	if (f2fs_compressed_file(inode)) {
-		int ret = f2fs_is_compressed_cluster(inode, folio->index);
+		int ret = f2fs_is_compressed_cluster(inode, pidx);
 
 		if (ret < 0) {
 			err = ret;
@@ -184,11 +218,6 @@ static vm_fault_t f2fs_vm_page_mkwrite(struct vm_fault *vmf)
 
 	f2fs_bug_on(sbi, f2fs_has_inline_data(inode));
 
-	err = f2fs_zero_post_eof_page(inode,
-		(folio->index + 1) << PAGE_SHIFT, true, false);
-	if (err)
-		goto out_pagefault;
-
 	file_update_time(vmf->vma->vm_file);
 	filemap_invalidate_lock_shared(inode->i_mapping);
 
@@ -204,62 +233,59 @@ static vm_fault_t f2fs_vm_page_mkwrite(struct vm_fault *vmf)
 	}
 
 	folio_lock(folio);
-	/*
-	 * A concurrent buffered write can extend isize, so we store isize in a
-	 * local variable to let the zeroing offset match the EOF check below.
-	 */
 	isize = i_size_read(inode);
+	folio_start = folio_pos(folio);
+	subpage_off = offset_in_folio(folio, pos);
+	valid_end = min_t(loff_t, folio_start + folio_size(folio), isize);
+	dirty_len = valid_end - folio_start;
 
 	if (unlikely(folio->mapping != inode->i_mapping ||
-			folio_pos(folio) > isize ||
-			!folio_test_uptodate(folio))) {
+			pos >= isize ||
+			!f2fs_ffs_test_blk_uptodate(folio,
+			folio->index + (subpage_off >> PAGE_SHIFT)))) {
 		folio_unlock(folio);
 		err = -EFAULT;
 		goto out_sem;
 	}
 
-	set_new_dnode(&dn, inode, NULL, NULL, 0);
-	if (need_alloc) {
-		/* block allocation */
-		err = f2fs_get_block_locked(&dn, folio->index);
-	} else {
-		err = f2fs_get_dnode_of_data(&dn, folio->index, LOOKUP_NODE);
-		f2fs_put_dnode(&dn);
-		if (f2fs_is_pinned_file(inode) &&
-		    !__is_valid_data_blkaddr(dn.data_blkaddr))
-			err = -EIO;
-	}
-
-	if (err) {
+	if (folio_test_large(folio) && !f2fs_ffs_find_or_alloc(folio)) {
 		folio_unlock(folio);
+		err = -ENOMEM;
 		goto out_sem;
 	}
 
-	f2fs_folio_wait_writeback(folio, false, true);
+	nr = DIV_ROUND_UP(dirty_len, PAGE_SIZE);
 
-	/* wait for GCed page writeback via generic cache */
-	f2fs_wait_on_block_writeback(inode, dn.data_blkaddr);
+	for (i = 0; i < nr; i++) {
+		err = f2fs_get_block_mkwrite(inode, folio, folio->index + i,
+					     need_alloc);
+		if (err) {
+			folio_unlock(folio);
+			goto out_sem;
+		}
+	}
 
 	/* page is wholly or partially inside EOF */
-	if (((loff_t)(folio->index + 1) << PAGE_SHIFT) > isize) {
-		loff_t offset;
+	if (folio_start + folio_size(folio) > isize) {
+		size_t offset = offset_in_folio(folio, isize);
 
-		offset = isize & ~PAGE_MASK;
 		folio_zero_segment(folio, offset, folio_size(folio));
 	}
+
+	if (folio_test_large(folio))
+		f2fs_ffs_mark_subrange_dirty(folio, 0, dirty_len);
 	folio_mark_dirty(folio);
 
-	f2fs_update_iostat(sbi, inode, APP_MAPPED_IO, F2FS_BLKSIZE(sbi));
+	f2fs_update_iostat(sbi, inode, APP_MAPPED_IO, dirty_len);
 	f2fs_update_time(sbi, REQ_TIME);
 
 out_sem:
 	filemap_invalidate_unlock_shared(inode->i_mapping);
-out_pagefault:
 	sb_end_pagefault(inode->i_sb);
 out:
 	ret = vmf_fs_error(err);
 
-	trace_f2fs_vm_page_mkwrite(inode, folio->index, vmf->vma->vm_flags, ret);
+	trace_f2fs_vm_page_mkwrite(inode, pidx, vmf->vma->vm_flags, ret);
 	return ret;
 }
 
-- 
2.43.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
