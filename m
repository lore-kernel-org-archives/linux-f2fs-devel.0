Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFA16CA9ED2
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 13 Oct 2026 11:57:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=RPQQ8W8GxZOwNjISeFVtBdcy1RHa9oOwCrPlnFgYFfY=; b=Il0PNyxAUFVTXPH2znVpXrCbKc
	3UKSRp3scNkSvHg+mk9BjfLGjmzhvlEHQDrCinoqHQR5BKGCjTAYRUQlz4BLW2kwAiBhHWqDABfqv
	+mmcUHdm/kQSUlp69UfZESh43LlmwS2s4Ey7P5uSOEHsy4afN1ZU0GIpXP0mB8Eo7/E8=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xGb8C-0000jG-35;
	Tue, 13 Oct 2026 11:57:20 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <nzzhao.sigma@gmail.com>) id 1xGb8A-0000j2-RF
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 13 Oct 2026 11:57:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=tUCgCRsOlq9BAGXeOk1uN6rtd7xYn5TxPQZMxbJkExY=; b=P9az/i/MStcD5MwY/SIKLHn9xN
 Deholckcwrhg7TuxgQfyLxao6zuR+H2Hp8SI9pOv0BJkwNvneyT+IsZvT45cAGH6hEqxrynyU9VOf
 WGluwDyipq6wBzgqgf1wJV8xEzvtNrxu3CQgTBP3M/M1fJZfgucK7GDA55agQLBLKZ1M=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=tUCgCRsOlq9BAGXeOk1uN6rtd7xYn5TxPQZMxbJkExY=; b=LgmMwcd2dZ74OfOE9h4iYksIhw
 1Flzuk2ddRxygkblDNF+ttpx6w++tHjW3/BD83QKLlSODZX5u+Nm7DvLwC0VE3LczMf+QnVL3BR+4
 5Z1WHostEoXOJg44kGpIizZ0E1/5rdJ+/duzeNvX3HB4pYDYnrzWr5JJBfLXbYU6pdLQ=;
Received: from mail-pj2-f1.google.com ([74.125.227.129])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xGb8A-0001UR-2h for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 13 Oct 2026 11:57:19 +0000
Received: by mail-pj2-f1.google.com with SMTP id
 98e67ed59e1d1-3ab39d38631so82625a91.1
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 13 Oct 2026 04:57:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791892632; x=1792497432; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=tUCgCRsOlq9BAGXeOk1uN6rtd7xYn5TxPQZMxbJkExY=;
 b=kb8JGqpoTffuiLq77wdmuPGNAGWNdiaubKlZrLuB6eibcDVZacjCAoeShaRzCvYDOD
 /Yyjcf/5w0jApUXhKqLMRzoLJn55O1of0CZGgPkqjGVzygZHyyvtSoPvXr8F2wmF/+qD
 8FnHb5v1pDkGpjwID/Y+ZXMNBiarvrrSuha4FV1fJ97EE7zQKs/saCFG9Nonjfm+zd8J
 EgLR7MYccjt4NfemI3YkB2KZOlTNTSvdOykDiL20w0rZ62TH0cVbiP0eqeDkw6mhwmlv
 hSe5zOOSx5CZCcAp0NrAh0ud4aoy7NDDmEjYlKaCCa/tisHo/U4jbBwUa4rsodXzW690
 /RXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791892632; x=1792497432;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=tUCgCRsOlq9BAGXeOk1uN6rtd7xYn5TxPQZMxbJkExY=;
 b=D6JwkW7hxj2wYqdomZJ255wUi0IjDjplEynvxHLdAUj3xvnfAByIvd63sBqqsu+QUG
 fT8FoGy9BSX4tjN0RHpybVYTBxQro5RRx21bZEqZmFrQ718+cufV3J5bnVZnstf/f4lT
 Gh9nAlclyy+uF0hGR0NX0jf/mFEzodjAXAZ7rIRINsBbGtRdGyYDljS61TITbESlxlIA
 q3L/POVTdSZKV4zkDVEZPGTlLQoDz5y4+8FkEeo/sVpWChP46zoB8GaD5zQvq6bQwsk8
 0y7oQuNR3r/0a1uJSAT7EJskvnDtNwfdAeAMZe5PxTnBiTLcNwteYVrXxDjgq31Y9LR7
 R1zQ==
X-Gm-Message-State: AFq9FYLdRiWdN4tlfjTMSTQXeZZPuKvqFhwVlSfkN5S9FK/oa9pQti+3
 +cGNZMDulBYZ/uZnViwrXfbYMUoD8BTwYGFqa31kVAfW6r5U1fszTfaf2cykWnc3S2E=
X-Gm-Gg: AYBFou1f3najDD+0LiYCwszKEurTwG0X25fMofaIacYuPPOrGCd8yrF/C0AJGImCF9c
 vsfMqscbhNpGaNSoyS9J1RMZiM/01yIAiNJ36oh/BqLmyKipz/dz/2VG3vanR/k38+e6WpRWPQ7
 uH/OEyqmOSzhB76dEt/MV8Xc2iwmzJ6o9Y//tu0SpjiXW26KmkfWm+1JTe4QW0gUkaMzul4Fgmn
 FYOgeXb3tHiW9ybf7ElnHZl7IDqbKx0JQFoEztaP9jF+gkopWYuGP81+8REzJTeLJqilNM0ANsC
 GzDp4S7SnpGaun9B/MbgWS7e+9QeNPn4mo9ZkN6hvQvJQABxxePvj5yFx25uul8J3xsQPXfxDhy
 NvZvK6+pJ/knfTNvU+nU9e6aLa8E2cj32eVpCuQSpzwkcx9lHRSUYh9MN6HRnBXI/kCFzodOF/7
 uqkt/QEYoafvB8UgNvHKGmA1LDVygOVHhKEnc0Dm0DZd2ElrbEyOqRm50B/FSnyxKWGhcYlWJks
 rUeIp/Ub0SqYST0a3SH+cpANpMEZ54BDmhM
X-Received: by 2002:a17:90b:3912:b0:3a4:930e:6c35 with SMTP id
 98e67ed59e1d1-3ab3a369eafmr6931610a91.4.1791892632244; 
 Tue, 13 Oct 2026 04:57:12 -0700 (PDT)
Received: from nzzhao-ThinkCentre-M760t.mioffice.cn ([43.224.245.179])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ab37139b59sm21248516a91.13.2026.10.13.04.57.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2026 04:57:11 -0700 (PDT)
From: Nanzhe Zhao <nzzhao.sigma@gmail.com>
To: linux-f2fs-devel@lists.sourceforge.net, Jaegeuk Kim <jaegeuk@kernel.org>,
 Chao Yu <chao@kernel.org>
Date: Tue, 13 Oct 2026 19:56:12 +0800
Message-ID: <20261013115621.968742-10-nzzhao.sigma@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261013115621.968742-1-nzzhao.sigma@gmail.com>
References: <20261013115621.968742-1-nzzhao.sigma@gmail.com>
MIME-Version: 1.0
X-Headers-End: 1xGb8A-0001UR-2h
Subject: [f2fs-dev] [PATCH v4 09/18] f2fs: prepare mmap write faults for
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

From: Nanzhe Zhao <zhaonanzhe@xiaomi.com>

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
 fs/f2fs/data.c |  55 +++++++++++++++++++------
 fs/f2fs/f2fs.h |   7 ++++
 fs/f2fs/file.c | 108 +++++++++++++++++++++++++++++++++++--------------
 3 files changed, 127 insertions(+), 43 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index f994a31f8..d158c343f 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -2794,33 +2794,64 @@ int f2fs_read_multi_pages(struct compress_ctx *cc, struct bio **bio_ret,
 }
 #endif
 
-struct f2fs_folio_state *f2fs_ffs_find_or_alloc(struct folio *folio)
+struct f2fs_folio_state *f2fs_ffs_alloc(struct f2fs_sb_info *sbi,
+					struct folio *folio)
 {
 	struct f2fs_folio_state *ffs;
-	unsigned int nr_subpages = folio_nr_pages(folio);
-	unsigned long private = (unsigned long)folio->private;
+	unsigned int nr_subpages;
 
-	f2fs_bug_on(F2FS_F_SB(folio), !folio_test_large(folio));
-	f2fs_bug_on(F2FS_F_SB(folio),
-		    test_bit(F2FS_FOLIO_PRIVATE_NOT_POINTER, &private));
-
-	if (f2fs_folio_has_ffs(folio))
-		return (struct f2fs_folio_state *)folio->private;
+	if (!folio_test_large(folio) || f2fs_folio_has_ffs(folio))
+		return NULL;
 
-	ffs = f2fs_kmalloc(F2FS_F_SB(folio),
+	nr_subpages = folio_nr_pages(folio);
+	ffs = f2fs_kmalloc(sbi,
 			struct_size(ffs, state, BITS_TO_LONGS(2 * nr_subpages)),
 			GFP_NOFS | __GFP_ZERO);
 	if (!ffs)
-		return NULL;
+		return ERR_PTR(-ENOMEM);
 
 	spin_lock_init(&ffs->state_lock);
+	return ffs;
+}
+
+void f2fs_ffs_attach(struct folio *folio, struct f2fs_folio_state *ffs)
+{
+	unsigned int nr_subpages = folio_nr_pages(folio);
+
+	if (!ffs)
+		return;
+
+	if (!folio_test_large(folio) || f2fs_folio_has_ffs(folio)) {
+		kfree(ffs);
+		return;
+	}
+
 	if (folio_test_uptodate(folio))
 		bitmap_set(ffs->state, 0, nr_subpages);
 	if (folio_test_dirty(folio))
 		bitmap_set(ffs->state, nr_subpages, nr_subpages);
 
 	folio_attach_private(folio, ffs);
-	return ffs;
+}
+
+struct f2fs_folio_state *f2fs_ffs_find_or_alloc(struct folio *folio)
+{
+	struct f2fs_folio_state *ffs;
+	unsigned long private = (unsigned long)folio->private;
+
+	f2fs_bug_on(F2FS_F_SB(folio), !folio_test_large(folio));
+	f2fs_bug_on(F2FS_F_SB(folio),
+		    test_bit(F2FS_FOLIO_PRIVATE_NOT_POINTER, &private));
+
+	if (f2fs_folio_has_ffs(folio))
+		return (struct f2fs_folio_state *)folio->private;
+
+	ffs = f2fs_ffs_alloc(F2FS_F_SB(folio), folio);
+	if (IS_ERR(ffs))
+		return NULL;
+
+	f2fs_ffs_attach(folio, ffs);
+	return (struct f2fs_folio_state *)folio->private;
 }
 
 static void ffs_detach_free(struct folio *folio)
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index e5c1d6a65..876339eb2 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -4467,6 +4467,13 @@ int f2fs_write_single_data_page(struct folio *folio, int *submitted,
 				enum iostat_type io_type,
 				int compr_blocks, bool allow_balance);
 bool f2fs_ffs_test_blk_uptodate(const struct folio *folio, pgoff_t index);
+struct f2fs_folio_state *f2fs_ffs_alloc(struct f2fs_sb_info *sbi,
+					struct folio *folio);
+void f2fs_ffs_attach(struct folio *folio, struct f2fs_folio_state *ffs);
+struct f2fs_folio_state *f2fs_ffs_find_or_alloc(struct folio *folio);
+void f2fs_ffs_mark_subrange_dirty(struct folio *folio, size_t offset, size_t len);
+bool f2fs_ffs_clear_subrange_dirty_and_test(struct folio *folio, size_t offset,
+					    size_t len);
 void f2fs_write_failed(struct inode *inode, loff_t to);
 void f2fs_invalidate_folio(struct folio *folio, size_t offset, size_t length);
 bool f2fs_release_folio(struct folio *folio, gfp_t wait);
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index f7ed20f0c..37d41f593 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -118,14 +118,49 @@ static vm_fault_t f2fs_filemap_fault(struct vm_fault *vmf)
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
+	struct f2fs_folio_state *ffs = NULL;
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
 
@@ -162,7 +197,7 @@ static vm_fault_t f2fs_vm_page_mkwrite(struct vm_fault *vmf)
 
 #ifdef CONFIG_F2FS_FS_COMPRESSION
 	if (f2fs_compressed_file(inode)) {
-		int ret = f2fs_is_compressed_cluster(inode, folio->index);
+		int ret = f2fs_is_compressed_cluster(inode, pidx);
 
 		if (ret < 0) {
 			err = ret;
@@ -172,6 +207,17 @@ static vm_fault_t f2fs_vm_page_mkwrite(struct vm_fault *vmf)
 		}
 	}
 #endif
+	/*
+	 * Preallocate the folio state before the block allocation and page
+	 * locking work, so that -ENOMEM can not be reported too late.
+	 */
+	ffs = f2fs_ffs_alloc(sbi, folio);
+	if (IS_ERR(ffs)) {
+		err = PTR_ERR(ffs);
+		ffs = NULL;
+		goto out;
+	}
+
 	/* should do out of any locked page */
 	if (need_alloc)
 		f2fs_balance_fs(sbi, true);
@@ -180,11 +226,6 @@ static vm_fault_t f2fs_vm_page_mkwrite(struct vm_fault *vmf)
 
 	f2fs_bug_on(sbi, f2fs_has_inline_data(inode));
 
-	err = f2fs_zero_post_eof_page(inode,
-		(folio->index + 1) << PAGE_SHIFT, true, false);
-	if (err)
-		goto out_pagefault;
-
 	file_update_time(vmf->vma->vm_file);
 	filemap_invalidate_lock_shared(inode->i_mapping);
 
@@ -194,57 +235,62 @@ static vm_fault_t f2fs_vm_page_mkwrite(struct vm_fault *vmf)
 	 * local variable to let the zeroing offset match the EOF check below.
 	 */
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
+	f2fs_ffs_attach(folio, ffs);
+	ffs = NULL;
+	if (folio_test_large(folio) && !f2fs_folio_has_ffs(folio) &&
+	    !f2fs_ffs_find_or_alloc(folio)) {
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
+	kfree(ffs);
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
