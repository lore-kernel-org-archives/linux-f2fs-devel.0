Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD93EC5AD56
	for <linux-f2fs-devel@archiver.kernel.org>; Sun,  9 Aug 2026 01:19:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-ID:Date:To:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=S1ewBE3shkLakLAn4fgwgalqIcqTE/b8V3bFl00t2UA=; b=ERzUNuCjdCbuP6qF7bYFPXAGef
	SNDJIjt7x9IgJJuvCjVyrQyg0XGNVEkwfG6n7NxWjGNYeGNBx5vC3Tf3vgb21CqZqfbKEVJif98+/
	WCEdHj6oNuZoI6lmDCXQrM9PlVFm57NGJaRyt0W6dxskVebPxjg7Mm1dedF0Uv7MhBUI=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wssCH-0000xB-OR;
	Sun, 09 Aug 2026 01:19:29 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1wssCG-0000x4-57
 for linux-f2fs-devel@lists.sourceforge.net;
 Sun, 09 Aug 2026 01:19:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=961aaWN/im4Z7DBF4zaZ/SbT5+y0jXH7B0a7wAN6gb0=; b=ejcpOnQuLQp+wZWpN/soqjElL3
 A194FA88b/NqAZzSVUdk3HAFKcsU9v0radyig/s4h+dsstiNa9g2kZbhOeTVg7LfPVrmUfMrOsnQ7
 WslGJaanwN28Pdn5Llv0vsG/DaN2gsyglAPsqC6FSxdHhkFLgSVXFzs1ArfmHGKUKwng=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=961aaWN/im4Z7DBF4zaZ/SbT5+y0jXH7B0a7wAN6gb0=; b=hzRQPlB4bYEN4HEUgG8LqUw+JM
 hLWBMBpRfX35tt22cD8OFVV/pbg1U9HPSleauKn6VddQbelQJCa1WoTfJiVADnMaTMbkgeIJvwaqA
 wo/l4vYv9GVP+V6rffcvSUI5SdC36P2UYduYQVZdVGV4WAesecaypEvCVYTE1JuJnHKE=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wssCI-0004UH-RY for linux-f2fs-devel@lists.sourceforge.net;
 Sun, 09 Aug 2026 01:19:28 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id B40FC600DA
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Sun,  9 Aug 2026 01:19:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55B3C1F00A3D;
 Sun,  9 Aug 2026 01:19:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786238361;
 bh=961aaWN/im4Z7DBF4zaZ/SbT5+y0jXH7B0a7wAN6gb0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=Ct1xf1YBMWSmQ3iZrtgt6dYMPX231MWRKi/0GWwiXodGqI7NyAsMTVv7+sPRIwznl
 Rek4c4ygf2udG5CRHtE2Mf9rMqb1XFvn4Tai29puLtTOMGeJeXjm9tYCZ+Gkh9VrUX
 RAqBqqn02Qaama+bJmlR5F7JR4gQCZtm9uYS9xLRp2EvvoZgk0/L2R6TbeLCXtnvnG
 7GsWM3N8o0sP0n1fGyBz+C00+yMH6AgR/nzYVrm8KE5SV9oFDJuLhEyFFtTY/HtE7M
 Em0UL3owS81JTuSxW7cjJOoq5/fNXmdP8wJqOuI0SRbm6NA7zMEnnQuRp4va4c27+C
 3nFHS0gb+VXyQ==
To: jaegeuk@kernel.org
Date: Sun,  9 Aug 2026 09:19:14 +0800
Message-ID: <20260809011914.565936-2-chao@kernel.org>
X-Mailer: git-send-email 2.55.0.654.g21b8a5bc05-goog
In-Reply-To: <20260809011914.565936-1-chao@kernel.org>
References: <20260809011914.565936-1-chao@kernel.org>
MIME-Version: 1.0
X-Headers-End: 1wssCI-0004UH-RY
Subject: [f2fs-dev] [PATCH v4 2/2] f2fs: fix to zero post-EOF data when
 extending file size
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
From: Chao Yu via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Chao Yu <chao@kernel.org>
Cc: stable@kernel.org, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

generic/794  4s ... - output mismatch (see /share/git/fstests/results//generic/794.out.bad)
    --- tests/generic/794.out   2026-06-12 08:46:32.766426241 +0800
    +++ /share/git/fstests/results//generic/794.out.bad 2026-07-05 18:32:55.000000000 +0800
    @@ -1,4 +1,16 @@
     QA output created by 794
     append_write
    +FAIL: non-zero data in gap [4080,4096) after shutdown+remount
    +000000 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a  >ZZZZZZZZZZZZZZZZ<
    +*
    +001000
     truncate_up
    ...
    (Run 'diff -u /share/git/fstests/tests/generic/794.out /share/git/fstests/results//generic/794.out.bad'  to see the entire diff)
Ran: generic/794
Failures: generic/794
Failed 1 of 1 tests

Steps of generic/794:
1. write 4096 bytes to file w/ 0x5a
2. use fiemap to get PBA of first block in file
3. truncate file to 4080
4. umount; write 4096 bytes to file w/ 0x5a directly via PBA; mount
5. extend filesize via
   a) append 4096 from offset 4096, or
   b) truncate 8192, or
   c) fallocate 4096 from offset 4096
6. verify the gap is zeroed in memory [4080,4096)
7. sync range 4096 from offset 4096; shutdown -f (flush meta before shutdown)
8. umount; mount; verify [4080,4096) is zeroed or not.

When extending file size (e.g. via truncate, fallocate, or write) across an
unaligned EOF boundary, we need to ensure that post-EOF data in the partial
page is zeroed out in pagecache and marked dirty, meanwhile, tagging the inode
with FI_ZERO_POST_EOF, so that following checkpoint() and fsync() can persist
the page contain zeroed data before committing inode w/ updated i_size.

This help to prevent stale disk data beyond the previous EOF from being exposed
after remounting or crash recovery.

Since f2fs is a LFS filesystem, we only support direct write via PBA in pinfile,
and pinfile has section-aligned filesize, so in Android, there should no problem,
but for other usage in different environment, let's fix this w/ fsync_mode=strict
mount option.

Cc: stable@kernel.org
Signed-off-by: Chao Yu <chao@kernel.org>
---
v4:
- fix to receive return value of f2fs_zero_post_eof_page() w/ @err rather than
@ret in f2fs_vm_page_mkwrite().
 fs/f2fs/file.c | 100 +++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 84 insertions(+), 16 deletions(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index be319a2e9830..446d2328f975 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -36,16 +36,52 @@
 #include <trace/events/f2fs.h>
 #include <uapi/linux/f2fs.h>
 
-static void f2fs_zero_post_eof_page(struct inode *inode,
-					loff_t new_size, bool lock)
+static int fill_zero(struct inode *inode, pgoff_t index,
+					loff_t start, loff_t len);
+
+static int do_zero_post_eof_page(struct inode *inode, loff_t new_size)
+{
+	loff_t old_size = i_size_read(inode);
+	unsigned int offset, len;
+	pgoff_t index;
+	int err;
+
+	offset = old_size & (PAGE_SIZE - 1);
+
+	if (!offset)
+		return 0;
+
+	len = min_t(loff_t, PAGE_SIZE - offset, new_size - old_size);
+	index = old_size >> PAGE_SHIFT;
+
+	if (f2fs_has_inline_data(inode)) {
+		/* data post eof should be always zero */
+		if (new_size <= MAX_INLINE_DATA(inode))
+			return 0;
+		err = f2fs_convert_inline_inode(inode);
+		if (err)
+			return err;
+	}
+
+	err = fill_zero(inode, index, offset, len);
+	if (err)
+		return err;
+	return filemap_write_and_wait_range(inode->i_mapping,
+				old_size, old_size + len - 1);
+}
+
+static int f2fs_zero_post_eof_page(struct inode *inode,
+					loff_t new_size, bool lock, bool writeback)
 {
 	loff_t old_size = i_size_read(inode);
+	bool strict =
+		F2FS_OPTION(F2FS_I_SB(inode)).fsync_mode == FSYNC_MODE_STRICT;
 
 	if (old_size >= new_size)
-		return;
+		return 0;
 
-	if (mapping_empty(inode->i_mapping))
-		return;
+	if (!strict && mapping_empty(inode->i_mapping))
+		return 0;
 
 	if (lock)
 		filemap_invalidate_lock(inode->i_mapping);
@@ -53,6 +89,16 @@ static void f2fs_zero_post_eof_page(struct inode *inode,
 	truncate_inode_pages_range(inode->i_mapping, old_size, new_size - 1);
 	if (lock)
 		filemap_invalidate_unlock(inode->i_mapping);
+
+	if (!writeback || !strict)
+		return 0;
+	/*
+	 * In fsync_mode=strict, when we expand an unaligned EOF size, we
+	 * should zero post EOF data and writeback the data immediately,
+	 * so that it can avoid exposing stale data after metadata flush
+	 * and POR.
+	 */
+	return do_zero_post_eof_page(inode, new_size);
 }
 
 static vm_fault_t f2fs_filemap_fault(struct vm_fault *vmf)
@@ -132,7 +178,10 @@ static vm_fault_t f2fs_vm_page_mkwrite(struct vm_fault *vmf)
 
 	f2fs_bug_on(sbi, f2fs_has_inline_data(inode));
 
-	f2fs_zero_post_eof_page(inode, (folio->index + 1) << PAGE_SHIFT, true);
+	err = f2fs_zero_post_eof_page(inode,
+		(folio->index + 1) << PAGE_SHIFT, true, false);
+	if (err)
+		goto out_pagefault;
 
 	file_update_time(vmf->vma->vm_file);
 	filemap_invalidate_lock_shared(inode->i_mapping);
@@ -189,7 +238,7 @@ static vm_fault_t f2fs_vm_page_mkwrite(struct vm_fault *vmf)
 
 out_sem:
 	filemap_invalidate_unlock_shared(inode->i_mapping);
-
+out_pagefault:
 	sb_end_pagefault(inode->i_sb);
 out:
 	ret = vmf_fs_error(err);
@@ -1175,8 +1224,12 @@ int f2fs_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 		f2fs_down_write(&fi->i_gc_rwsem[WRITE]);
 		filemap_invalidate_lock(inode->i_mapping);
 
-		if (attr->ia_size > old_size)
-			f2fs_zero_post_eof_page(inode, attr->ia_size, false);
+		if (attr->ia_size > old_size) {
+			err = f2fs_zero_post_eof_page(inode,
+				attr->ia_size, false, true);
+			if (err)
+				goto err_out;
+		}
 		truncate_setsize(inode, attr->ia_size);
 
 		if (attr->ia_size <= old_size)
@@ -1185,6 +1238,7 @@ int f2fs_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 		 * do not trim all blocks after i_size if target size is
 		 * larger than i_size.
 		 */
+err_out:
 		filemap_invalidate_unlock(inode->i_mapping);
 		f2fs_up_write(&fi->i_gc_rwsem[WRITE]);
 		if (err)
@@ -1296,7 +1350,9 @@ static int f2fs_punch_hole(struct inode *inode, loff_t offset, loff_t len)
 	if (ret)
 		return ret;
 
-	f2fs_zero_post_eof_page(inode, offset + len, true);
+	ret = f2fs_zero_post_eof_page(inode, offset + len, true, false);
+	if (ret)
+		return ret;
 
 	pg_start = ((unsigned long long) offset) >> PAGE_SHIFT;
 	pg_end = ((unsigned long long) offset + len) >> PAGE_SHIFT;
@@ -1583,7 +1639,9 @@ static int f2fs_do_collapse(struct inode *inode, loff_t offset, loff_t len)
 	f2fs_down_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
 	filemap_invalidate_lock(inode->i_mapping);
 
-	f2fs_zero_post_eof_page(inode, offset + len, false);
+	ret = f2fs_zero_post_eof_page(inode, offset + len, false, false);
+	if (ret)
+		goto out_unlock;
 
 	f2fs_lock_op(sbi, &lc);
 	f2fs_drop_extent_tree(inode);
@@ -1591,6 +1649,7 @@ static int f2fs_do_collapse(struct inode *inode, loff_t offset, loff_t len)
 	ret = __exchange_data_block(inode, inode, end, start, nrpages - end, true);
 	f2fs_unlock_op(sbi, &lc);
 
+out_unlock:
 	filemap_invalidate_unlock(inode->i_mapping);
 	f2fs_up_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
 	return ret;
@@ -1712,7 +1771,9 @@ static int f2fs_zero_range(struct inode *inode, loff_t offset, loff_t len,
 	if (ret)
 		return ret;
 
-	f2fs_zero_post_eof_page(inode, offset + len, true);
+	ret = f2fs_zero_post_eof_page(inode, offset + len, true, false);
+	if (ret)
+		return ret;
 
 	pg_start = ((unsigned long long) offset) >> PAGE_SHIFT;
 	pg_end = ((unsigned long long) offset + len) >> PAGE_SHIFT;
@@ -1847,7 +1908,9 @@ static int f2fs_insert_range(struct inode *inode, loff_t offset, loff_t len)
 	f2fs_down_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
 	filemap_invalidate_lock(mapping);
 
-	f2fs_zero_post_eof_page(inode, offset + len, false);
+	ret = f2fs_zero_post_eof_page(inode, offset + len, false, false);
+	if (ret)
+		goto out_unlock;
 	truncate_pagecache(inode, offset);
 
 	while (!ret && idx > pg_start) {
@@ -1865,6 +1928,7 @@ static int f2fs_insert_range(struct inode *inode, loff_t offset, loff_t len)
 					idx + delta, nr, false);
 		f2fs_unlock_op(sbi, &lc);
 	}
+out_unlock:
 	filemap_invalidate_unlock(mapping);
 	f2fs_up_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
 	if (ret)
@@ -1907,7 +1971,9 @@ static int f2fs_expand_inode_data(struct inode *inode, loff_t offset,
 	if (err)
 		return err;
 
-	f2fs_zero_post_eof_page(inode, offset + len, true);
+	err = f2fs_zero_post_eof_page(inode, offset + len, true, true);
+	if (err)
+		return err;
 
 	f2fs_balance_fs(sbi, true);
 
@@ -5023,8 +5089,10 @@ static ssize_t f2fs_write_checks(struct kiocb *iocb, struct iov_iter *from)
 	if (err)
 		return err;
 
-	f2fs_zero_post_eof_page(inode,
-		iocb->ki_pos + iov_iter_count(from), true);
+	err = f2fs_zero_post_eof_page(inode,
+		iocb->ki_pos + iov_iter_count(from), true, true);
+	if (err)
+		return err;
 	return count;
 }
 
-- 
2.49.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
