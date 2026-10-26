Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3581606A325
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 26 Oct 2026 03:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=Kx6DA+gv;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=c8toZ907;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=XQvpzZKs;
	dkim=neutral header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=BFP15+55
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:List-Owner;
	bh=CylUm/VdQ2Vt+NPNygt1eOjDF2loymUjNaxCYkFecCI=; b=Kx6DA+gvcnO24nfGh6rEZmQ7gR
	N3hMHgGXfcUpxI2ro9BZ7amqdWsacgdnyQX3kqqzuRQHzIb25Ni/BfFdBmlS1nPBMzpA1oQRylHPZ
	PlR9K5iOeAbgcVroVPwwAp/bR4Q0vT6WYmkHt4pyHYOtKFQ/NV5KacJTR61YIhSj0WQs=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xLBXd-000000007IL-2DH6;
	Mon, 26 Oct 2026 03:38:33 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <nzzhao.sigma@gmail.com>) id 1xLBXc-000000007I6-0an0
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 26 Oct 2026 03:38:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=xH8iNd9WnjMnVC8aNeUQIIpc1ap9O6kroHREtqw8lw0=; b=c8toZ907dBXOUPlpw/RVSbGyFx
 m8/bpUSyWhpbkU6MMNxpWOZljBDJBNyjbM/zHTbv3OPYIiKP7ul/5GfSlfMzuUCKm3LkOYByS54Bp
 pM5wBuBhcTU1gC/R7WLebGWQQICwEIM45S5oWR38HRM03LedysSIOJ5qTOMfLPG+krN0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=xH8iNd9WnjMnVC8aNeUQIIpc1ap9O6kroHREtqw8lw0=; b=XQvpzZKs2H2WEW0WuYpGnxeGgN
 Tcbil7Z54PH500OuPtY5HhbJb84ZF933voZydh3tTYKr6KSUaW/omqltDtpbaA0AlyoEboaTI3zj+
 KL/49zKj/W3GUHoJi61mWnJo+gZZ3GBO9BzRJL8b+AGdkBpIETIrD808nZWqU288XbX0=;
Received: from mail-pj2-f8.google.com ([74.125.227.136])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xLBXa-000000002aG-3Ldh
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 26 Oct 2026 03:38:32 +0000
Received: by mail-pj2-f8.google.com with SMTP id
 98e67ed59e1d1-3ac6fe4aff0so1779058a91.0
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Sun, 25 Oct 2026 20:38:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792985905; x=1793590705; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=xH8iNd9WnjMnVC8aNeUQIIpc1ap9O6kroHREtqw8lw0=;
 b=BFP15+55e3HomMqLEJVYp0VFWgSPFrhv48DhofRzMyTm+jG0h90F7hyXr/iMNVFf46
 P6LuXL2U2DgW/xYcPPgyoxBQDm+AZkpS07IvkloE3/y6FrPBDhtAugVELiwD+4TdG4Sb
 Pjvizc0czMnX33GGEwRbIk8p/uyji2csaVgfgrSSq+b8pr+jrSqebPWuT5lxstoVdPin
 pP/KQE2ptM8huQYtIjB8klkn2EhU+L0gI4pWCJMDGzdIr8z7RYeLy3yO8HhWZhhMwPzB
 KyysdzHuJOP0Y7Lkaa/3+rGMF7jjyEgwTD1ou8b3IpcNVAlNVKFwGhuW4Q4/NNRkh9iQ
 NXag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792985905; x=1793590705;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=xH8iNd9WnjMnVC8aNeUQIIpc1ap9O6kroHREtqw8lw0=;
 b=NSVQK5g4FcjaQeDGq+UkFrazmqHM9MwbnhWlFstR1V+hETaGheps6RuakNXxXP7cLu
 QkvXPvELWtsjhBNEvSsS7WinIBTlTQpNyQV2cwDmV3bqFduENfghwUs5vFCCTbKyGAfZ
 ZYvRJEfiCWdOQPD7A89yxL9db7JXsRT0kV5lH1GozcQ7F/Md8nhXouYgdXTPEx+sb4n2
 gZg4i1C2oh4vxqfSM4T+2+brJ4CjzCbaI1PuRFezdogBaO6mHF6E3Vzilg/mPghwzzyZ
 t6UD24MON6lBOjFBXXq/viC1JmVasF0a/7lzcKIJo2NlMG9SEaXxNkz4Id1mjR6scTpG
 0x9A==
X-Gm-Message-State: AFq9FYKraIbI79Y5V0z8eLolLHKCGFxrvPIamNVI5TjswPNvp1THGamg
 oJojRbKv47nQol7Z3P3EcvWSOIoNsJ6S9PCdPr9XeDfoh0kqOI4MGs2HAyYzNmVP+aM+PA==
X-Gm-Gg: AYBFou20z29b+imokMyPc6/Pn//oljQX4ANuD5yR2b1Ap1L8dpPFDVi+jsZzejx6CKE
 zGHmbR55R9FMK4bCX0kxhj5ju6oR7P1FD//uBGcdU02Rl0aT1P19SfulU3DM3cginsdC5lbugZI
 n0z2rAVp7y++4VLBdocsEDvJeHXQH4+UthZfj5x+K9Z8Y/ZZ2nkeoLOecbaDyJOxcOiWiQLGKsH
 nB/4KAwmuf55yOyGh/aoTK+9Oi56Xw5uGsJFRt+vFqj7SHfwn/Dh/+CK6s4n6nJcxsff7rkXkqK
 NDB/UkYPtQaLgWGIh7E3YazDyvrWmWiajkwxloTUQpnn91cwzd+7lY7ER2JoFh8gMzgRIYDxVuV
 0T5dniTHYbFXEPXyIw40GiUPsO+LxtvW3vPdDnfeJlcVNYBVVOdCazL4G2PXTm1S970maFOX0gt
 gmZoitMPsDSxpfXujaB+3nRSxs0G6XJKaugA4l8nyjfRPQbTT7OP9OhJedMdX3Xtk7h8oGX7Tjc
 Cg58Ko3es+QJq3z3RVNtUcVKCEFlhPWBFVvTPwPxW4C7qpWTR0eu8MrGUPxRkxxdW4PES6zVU/X
 sejFs4JqhXiIphDLKyAAYfPuAfc/zmZX9vF9idzxvRWDJUY1wc50QczrYWyY9LGxYCc=
X-Received: by 2002:a17:90b:2642:b0:3ac:9df3:6b07 with SMTP id
 98e67ed59e1d1-3adead488demr4751824a91.24.1792985905155; 
 Sun, 25 Oct 2026 20:38:25 -0700 (PDT)
Received: from nzzhao-ThinkCentre-M760t.mioffice.cn ([43.224.245.179])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3adebe8f0b2sm6409823a91.8.2026.10.25.20.38.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 Oct 2026 20:38:24 -0700 (PDT)
From: Nanzhe Zhao <nzzhao.sigma@gmail.com>
To: linux-f2fs-devel@lists.sourceforge.net, Jaegeuk Kim <jaegeuk@kernel.org>,
 Chao Yu <chao@kernel.org>
Date: Mon, 26 Oct 2026 11:37:37 +0800
Message-ID: <20261026033745.784107-8-nzzhao.sigma@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261026033745.784107-1-nzzhao.sigma@gmail.com>
References: <20261026033745.784107-1-nzzhao.sigma@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xLBXa-000000002aG-3Ldh
Subject: [f2fs-dev] [PATCH v7 07/15] f2fs: prepare mmap write faults for
 large folios
X-BeenThere: linux-f2fs-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: Barry Song <baohua@kernel.org>, Juan Yescas <jyescas@google.com>,
 Daeho Jeong <daehojeong@google.com>, linux-kernel@vger.kernel.org,
 Dev Jain <Dev.Jain@arm.com>, David Hildenbrand <David.Hildenbrand@arm.com>,
 Pengfei Li <lipengfei28@xiaomi.com>, Bo Zhang <zhangbo56@xiaomi.com>,
 Kalesh Singh <kaleshsingh@google.com>, Nanzhe Zhao <nzzhao@126.com>,
 Nanzhe Zhao <zhaonanzhe@xiaomi.com>, Ryan Roberts <Ryan.Roberts@arm.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

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
 fs/f2fs/f2fs.h |  4 +++
 fs/f2fs/file.c | 96 ++++++++++++++++++++++++++++++++------------------
 2 files changed, 65 insertions(+), 35 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index b89664e28a92..915ca72cf276 100644
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
index 85b4f1a2ff0d..808b72d3d78a 100644
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
 
@@ -162,7 +196,7 @@ static vm_fault_t f2fs_vm_page_mkwrite(struct vm_fault *vmf)
 
 #ifdef CONFIG_F2FS_FS_COMPRESSION
 	if (f2fs_compressed_file(inode)) {
-		int ret = f2fs_is_compressed_cluster(inode, folio->index);
+		int ret = f2fs_is_compressed_cluster(inode, pidx);
 
 		if (ret < 0) {
 			err = ret;
@@ -180,11 +214,6 @@ static vm_fault_t f2fs_vm_page_mkwrite(struct vm_fault *vmf)
 
 	f2fs_bug_on(sbi, f2fs_has_inline_data(inode));
 
-	err = f2fs_zero_post_eof_page(inode,
-		(folio->index + 1) << PAGE_SHIFT, true, false);
-	if (err)
-		goto out_pagefault;
-
 	file_update_time(vmf->vma->vm_file);
 	filemap_invalidate_lock_shared(inode->i_mapping);
 
@@ -200,62 +229,59 @@ static vm_fault_t f2fs_vm_page_mkwrite(struct vm_fault *vmf)
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
