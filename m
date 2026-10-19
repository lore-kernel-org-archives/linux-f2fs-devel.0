Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3D82CCF2DE
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 19 Oct 2026 13:18:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:To:Message-ID:Mime-Version:Date:Sender:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=x96GB8xpd5iekad42OwBczKZBxeJ8Ph7YIRsKlCE0Ls=; b=Sf6oAMq+zN4GNET3vMypTozNrx
	WrhiRUSxuLR1V8pGVVYwCxUKVpo6pWKtR0lbWpTFVhkeBra4C15ZfhAV/pXTEafCLXYFiFq9boTbz
	+Esb73eOr6MCLsloidG0rtzK0yZGGagAGspVV3PYcIhnSi0czLtvhmjyM7FvheVCro04=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xInFw-00058n-Lq;
	Mon, 19 Oct 2026 13:18:25 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95) (envelope-from
 <35hDWagwKAL0msuxvdnrzvnljrrjoh.frp@flex--jprusakowski.bounces.google.com>)
 id 1xInFv-00058b-Jz for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 19 Oct 2026 13:18:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Cc:To:From:Subject:Message-ID:
 Mime-Version:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=NVJQb4s7J1RH25YiZPfBsDZyQ07ORbqyxm7vmxap9cY=; b=kHtASaMhtunYxHDSWdeFfbqh5N
 awfTZQFvdzb/fKI7zX8Ieg3Qgg0b03RVEQhqM8wCqZ6tmP9omj+6a/uOH4yCyTuv2PawHPjzXKyXo
 1T8aifKq9PGk9eO5kfN9eZy088YcTxewhBjv443+qIspGH3f8oDfW37MFtcKdECG48wE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Cc:To:From:Subject:Message-ID:Mime-Version:Date:Sender:
 Reply-To:Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date
 :Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=NVJQb4s7J1RH25YiZPfBsDZyQ07ORbqyxm7vmxap9cY=; b=E
 nn/u9AZGR8hs74UGIs1cWslFlpre1CQgsqDfIXUwzsv6ypENyig3lJAdW2wyW2slanCygNRv90jpX
 VUNXkxN1+lit/QeQ4lzg9riuXWoEGgQP3unS098F8daAzY0P2/2EySEUzgxbTc64woiL+U7a6OxDk
 6jR4r1F3nkKXjOl4=;
Received: from mail-ed1-f72.google.com ([209.85.208.72])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xInFu-0002eN-O7 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 19 Oct 2026 13:18:24 +0000
Received: by mail-ed1-f72.google.com with SMTP id
 4fb4d7f45d1cf-6aff6a8ee69so2149406a12.1
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 19 Oct 2026 06:18:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1792415896; x=1793020696;
 darn=lists.sourceforge.net; 
 h=content-type:cc:to:from:subject:message-id:mime-version:date:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=NVJQb4s7J1RH25YiZPfBsDZyQ07ORbqyxm7vmxap9cY=;
 b=UBy/SfKtR7SgKBxTXxdWoaS6mbmKxmprNjKXsd6Bg15APpsdsblsaU7ebGQyyVbssJ
 lzf/xUm++MDqUaP74Eo2a3BIPK9YCeMPUbJBqt1bEalU+MTIJ6mHvr1r3fOdszZLYlIw
 Pfnt5ldb1P57BTMcEbS/JgcVa/BjCjgredAHE41uYfXdN/NX55HnvvCnxMUvDcupMxGK
 g2bZfEHfqKA/HA8KLOmw32QANACMVd5VXsOBk+lBcWsrLod6isYUfp9eV1is/7l3U4zh
 mjbcmzyk0s/CleGFIKh7DKl1lZjF//fOqHoC82quStmc6EZLJXOni1Pd+NaEIstXHEPr
 GFkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792415896; x=1793020696;
 h=content-type:cc:to:from:subject:message-id:mime-version:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=NVJQb4s7J1RH25YiZPfBsDZyQ07ORbqyxm7vmxap9cY=;
 b=KphsLrEgEkIRqyc4ExNuGx4o1w91/V+ZO75vQW4Cc+WKRvsn5jlTM3oC4I1MkTtO0o
 /MmEaL/Pegdsb+96qTPpylqtpVX5omIyDoiwev0EoroejRh2yhh2thmNX92UAKIeBlrj
 bDfmc1FEMyMwzWNYtg3SbFPAGq3Q5r/nN47be8sVaiy5UK5VZH1UtkcX0mjpUkb1MMwf
 BcYPS0pBhBRu4GNTIWT9JlHdp+Be/SCQ+XoNyiW4ZDCTRhdgXHi2auhj6dtBB5645t5w
 swwTk7xgmmWWIF1M26pEWZneHRcLi9x58BCDwY5iQHSLtW6L85z8u1NGlL05CQknzN/e
 4P9A==
X-Gm-Message-State: AFq9FYI7O78PTfh2XlYE1K2QIpehuSS6rZOKqfgiYSm4MK1EoKbhPO99
 2R/iBKCq/tsNMyFPbG/kPASrWcHdTSmMMofuCZGCyt72pAiF7B1Qylg/9CwYXTnqPxaCuVhM5Mq
 Kol7aL6KtfTE0uOXiCvene5QrxvxBHw==
X-Received: from ejbo18.prod.google.com ([2002:a17:906:3592:b0:c36:3d60:e17c])
 (user=jprusakowski job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:906:ba89:b0:c2e:4b90:3c55 with SMTP id
 a640c23a62f3a-c41999706aemr474593466b.5.1792413926615; 
 Mon, 19 Oct 2026 05:45:26 -0700 (PDT)
Date: Mon, 19 Oct 2026 12:45:22 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.176.g3575e65682-goog
Message-ID: <20261019124522.3702174-1-jprusakowski@google.com>
To: Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>
X-Headers-End: 1xInFu-0002eN-O7
Subject: [f2fs-dev] [PATCH] f2fs: zero post-EOF data regardless of
 fsync_mode when extending file size
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
From: Jan Prusakowski via Linux-f2fs-devel
 <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Jan Prusakowski <jprusakowski@google.com>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Commit 5eced87b7d19 ("f2fs: fix to zero post-EOF data when extending
file size") gated post-EOF page zeroing and writeback behind
fsync_mode=strict. In the default fsync_mode=posix, extending a file
across an unaligned EOF boundary via truncate(), fallocate(), or write()
past EOF leaves stale on-disk data in [old_size, PAGE_ALIGN(old_size))
unzeroed when the page is not cached or after crash recovery, exposing
stale data and failing xfstest generic/794.

Zero and write back the partial post-EOF page on file size extension
regardless of fsync_mode, while avoiding unnecessary block allocations
and synchronous writeback:

1. Use f2fs_get_lock_data_folio() instead of fill_zero() in
   do_zero_post_eof_page() so that sparse holes (-ENOENT) are skipped
   without allocating physical blocks, and avoid calling
   f2fs_balance_fs() while f2fs_setattr() holds i_gc_rwsem[WRITE].
2. Skip post-EOF disk zeroing for inline files (whose post-EOF bytes are
   already zeroed in the inode page and upon inline conversion) and
   compressed clusters.
3. Only request synchronous writeback in f2fs_write_checks() when
   iocb->ki_pos > i_size_read(inode) (when the write starts past EOF,
   leaving an unwritten gap) and in f2fs_expand_inode_data() when
   !(mode & FALLOC_FL_KEEP_SIZE), avoiding synchronous writeback on
   normal sequential append writes.

Fixes: 5eced87b7d19 ("f2fs: fix to zero post-EOF data when extending file size")
Assisted-by: LLM
Signed-off-by: Jan Prusakowski <jprusakowski@google.com>
---
 fs/f2fs/file.c | 74 ++++++++++++++++++++++++++------------------------
 1 file changed, 38 insertions(+), 36 deletions(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 3b5ad281b518..d8fb72aa7a6d 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -36,36 +36,39 @@
 #include <trace/events/f2fs.h>
 #include <uapi/linux/f2fs.h>
 
-static int fill_zero(struct inode *inode, pgoff_t index,
-					loff_t start, loff_t len);
-
 static int do_zero_post_eof_page(struct inode *inode, loff_t new_size)
 {
 	loff_t old_size = i_size_read(inode);
-	unsigned int offset, len;
-	pgoff_t index;
+	unsigned int offset = old_size & (PAGE_SIZE - 1);
+	pgoff_t index = old_size >> PAGE_SHIFT;
+	struct folio *folio;
+	unsigned int len;
 	int err;
 
-	offset = old_size & (PAGE_SIZE - 1);
-
 	if (!offset)
 		return 0;
 
-	len = min_t(loff_t, PAGE_SIZE - offset, new_size - old_size);
-	index = old_size >> PAGE_SHIFT;
+	if (f2fs_has_inline_data(inode))
+		return 0;
 
-	if (f2fs_has_inline_data(inode)) {
-		/* data post eof should be always zero */
-		if (new_size <= MAX_INLINE_DATA(inode))
-			return 0;
-		err = f2fs_convert_inline_inode(inode);
-		if (err)
+	if (f2fs_compressed_file(inode)) {
+		err = f2fs_is_compressed_cluster(inode, index);
+		if (err < 0)
 			return err;
+		if (err)
+			return 0;
 	}
 
-	err = fill_zero(inode, index, offset, len);
-	if (err)
-		return err;
+	folio = f2fs_get_lock_data_folio(inode, index, true);
+	if (IS_ERR(folio))
+		return PTR_ERR(folio) == -ENOENT ? 0 : PTR_ERR(folio);
+
+	len = min_t(loff_t, PAGE_SIZE - offset, new_size - old_size);
+	f2fs_folio_wait_writeback(folio, true, true);
+	folio_zero_range(folio, offset, len);
+	folio_mark_dirty(folio);
+	f2fs_folio_put(folio, true);
+
 	return filemap_write_and_wait_range(inode->i_mapping,
 				old_size, old_size + len - 1);
 }
@@ -74,29 +77,26 @@ static int f2fs_zero_post_eof_page(struct inode *inode,
 					loff_t new_size, bool lock, bool writeback)
 {
 	loff_t old_size = i_size_read(inode);
-	bool strict =
-		F2FS_OPTION(F2FS_I_SB(inode)).fsync_mode == FSYNC_MODE_STRICT;
 
 	if (old_size >= new_size)
 		return 0;
 
-	if (!strict && mapping_empty(inode->i_mapping))
-		return 0;
-
-	if (lock)
-		filemap_invalidate_lock(inode->i_mapping);
-	/* zero or drop pages only in range of [old_size, new_size] */
-	truncate_inode_pages_range(inode->i_mapping, old_size, new_size - 1);
-	if (lock)
-		filemap_invalidate_unlock(inode->i_mapping);
+	if (!mapping_empty(inode->i_mapping)) {
+		if (lock)
+			filemap_invalidate_lock(inode->i_mapping);
+		/* zero or drop pages only in range of [old_size, new_size] */
+		truncate_inode_pages_range(inode->i_mapping, old_size,
+							new_size - 1);
+		if (lock)
+			filemap_invalidate_unlock(inode->i_mapping);
+	}
 
-	if (!writeback || !strict)
+	if (!writeback)
 		return 0;
 	/*
-	 * In fsync_mode=strict, when we expand an unaligned EOF size, we
-	 * should zero post EOF data and writeback the data immediately,
-	 * so that it can avoid exposing stale data after metadata flush
-	 * and POR.
+	 * When we expand an unaligned EOF size, we should zero post-EOF
+	 * data and writeback the data immediately, so that it can avoid
+	 * exposing stale data after metadata flush and POR.
 	 */
 	return do_zero_post_eof_page(inode, new_size);
 }
@@ -1984,7 +1984,8 @@ static int f2fs_expand_inode_data(struct inode *inode, loff_t offset,
 	if (err)
 		return err;
 
-	err = f2fs_zero_post_eof_page(inode, offset + len, true, true);
+	err = f2fs_zero_post_eof_page(inode, offset + len, true,
+					!(mode & FALLOC_FL_KEEP_SIZE));
 	if (err)
 		return err;
 
@@ -5367,7 +5368,8 @@ static ssize_t f2fs_write_checks(struct kiocb *iocb, struct iov_iter *from)
 		return err;
 
 	err = f2fs_zero_post_eof_page(inode,
-		iocb->ki_pos + iov_iter_count(from), true, true);
+		iocb->ki_pos + iov_iter_count(from), true,
+		iocb->ki_pos > i_size_read(inode));
 	if (err)
 		return err;
 	return count;
-- 
2.56.0.176.g3575e65682-goog



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
