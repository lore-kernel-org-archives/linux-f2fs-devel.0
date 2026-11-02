Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E4FA606D81B
	for <linux-f2fs-devel@archiver.kernel.org>; Mon,  2 Nov 2026 19:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=L656NhTt;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=hqyNDZel;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=PnofEDjc;
	dkim=neutral header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MZi9odoq
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:List-Owner;
	bh=4BZ7AsnQU+Mtg0Mdykr8MSgci4YxShMOWZygkisY2qI=; b=L656NhTtZdrFXfvdDIhRWq1KrE
	i4YRWbUTEN5Htj9/atOrkM+7N4ryVIgk84o8FMp5FsyVO0IYGgjWtMSOOKJv9lz3O3rCsf0bN+yEe
	ewakdNOTbAiVQkBgCQOKRu5yp/WquhcQ2scLiG/pZjA5yrpLjHH8+fDP3eBw8S0S+Y0I=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xNxtO-000000003yB-0bOw;
	Mon, 02 Nov 2026 19:40:30 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <daeho43@gmail.com>) id 1xNxtM-000000003xv-3i35
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 02 Nov 2026 19:40:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=lzquzX1F/dDFaaBlWjyTqsyhcPZg1hR5MPVxo5VoLuM=; b=hqyNDZeleOgBUkS2MYmfEp8tZu
 Y2VmRTk6gpaYkxY26Gjx9oQkuKo9ywfR+0frELGcD7L4TIPsFTCsK6rSc/evO1Si/W4JYvML27I+P
 6EOIIFNXCPFqnRgzAfdZQj26JiI7KdNFbT9vGXhK5awnaL2EM/OFWvE1QZQUV/DhvuKA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=lzquzX1F/dDFaaBlWjyTqsyhcPZg1hR5MPVxo5VoLuM=; b=PnofEDjclfNQeFR9HXpUbNKaP7
 6DI0+4J6bHYvDed6ASPqkKGbF8tUI9YL4PyF6pxHQXzuI2xXOr+4gYbsAecIvoAnALPPqKSlSRFgu
 6LDP0LP8G5dpD2F6+55JiKtoZvBU+IDWck/rSr7z0ItmPTFzjautqrfjUFA7CJkLKsAs=;
Received: from mail-pg1-f177.google.com ([209.85.215.177])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xNxtK-000000002ZU-3VYj
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 02 Nov 2026 19:40:28 +0000
Received: by mail-pg1-f177.google.com with SMTP id
 41be03b00d2f7-cc758830601so2084785a12.2
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 02 Nov 2026 11:40:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793648421; x=1794253221; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=lzquzX1F/dDFaaBlWjyTqsyhcPZg1hR5MPVxo5VoLuM=;
 b=MZi9odoqJFq2B7N8Td+CFf28r+O8BZ+5lHAoq2b0wrKFYGDbfHr6GAveHoB+P+4+kX
 EyfjWd4Gfxe1+8MAOdGNHSTQWGjy+8oMXSB7C3p3TUU6NDHBa2viYcbXhC6cn7EDzOq/
 YurxZVeKJu/Qrrl029W+RAcX9SGcBtg6ZcOh4TfQVU9HlGLks9n0o4qpJBqUGyb5eBn3
 UeyAUQFr2uenA3w4jthEtGbjEYvhPykE+NT+8ArfXMw1VN5jp5QM4dTPAjcOQimkRWFH
 dwYXrGYQ9wNWzQCWh3NJq2+ouILpo6c2XapxUM9DGeH76tW/DXR7Skn+FnkaRX95FJmR
 eOlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793648421; x=1794253221;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=lzquzX1F/dDFaaBlWjyTqsyhcPZg1hR5MPVxo5VoLuM=;
 b=lKwmaMxI7A9tqLrUDqvukV6kudvEe3qpnUBqy90IwxE7/EvrJhqWv7W9YsAY8n52up
 t6uQfPxP8aFzDBz06KTRDoJfnY+0XPC6c1jPBNn9/jLcyssbl/zreBSibHO3nxTGtSko
 RDIvNOCKHlH0+vkQpJu5LZZ2chjy7emY1pqiHTwCbnt/07tL5CiaYGzKpPO5+nFHUc6u
 i+Qi0oXAM4yEdF1E7UYmgrhRiPEHrZqyCFACKEyOW6gZAUULaHMJX10secvGz7u2TeIN
 xyHse5SEqTisv2jT/XjlmtvIMoHADELwi1PwQBp/dk51HhhhFTxynFx39MxDqz6vKNt0
 BD0g==
X-Forwarded-Encrypted: i=1;
 AKwUvBwZ/OKqIuPr1fWrmJ/i1UmoXusWUArGabylbNM3bwdc070pXRXFAtb7B9EoNofqiHIGo+ZVK/XlODoRLiwHw4yw@lists.sourceforge.net
X-Gm-Message-State: AFq9FYLRoj0W2LqJWYpg/KaUjDaR0X0i8cvx782OV2EMsddDzoaEGsBd
 VLxBibX2zvG5o8khxGFsao+rEfHc5w/b6vYfVuPd8NdG3aYFYgnZvRE8
X-Gm-Gg: AYBFou044qRL3WfELRXf5r+nWulvJclSGxPYYKGqmdsfRSGyvvYFRR5Hs8ovHJbYjme
 rDgb0URy57Y/GHSDFPwXcPZNj7PjXuvSuLC44nBXvYL41hHvOwaL4jy5BnCyRBLJPhIYdHoexKf
 6u1okcMtA3I+lZ+YrDGyYgEiBBcqBXpMHe0IQ/6etNEX1CvfuVniyNrWZtWbnhjpL/5rTpt/uRx
 s4SDNgYwKATUWGgecN1g03R7hIz4g4l6p9oRUr1SIPLRSgtjkWEFP27/iI7ENozDwVYtSkz/Za6
 yG8/JMrWFM8TX3PP9eyyekQspLnO1lXixB4y7iajfxuZPgYqumSrem15kQQakOv3ODJq7XknbaG
 880ZL1Q3wTrckcbRRGoB8mp0aFWOJB1oTG4bNkzZzd9QDJ8iyMxDdm9ZNAWHGkuaZdKdlK7M87I
 v8B2iE65VFYNnk+lTW48s83isJUHta9kDHUJFFBsgfKbpujg9a+Ag1qK+yXVMoCr5YLFia68T4k
 FH+1towSDb6bAL8gLEBHjijLOF2NOSR/jGimP52vCm9NK0HSHt/Y9oV+TWfdFhQC2DCBZ+ltzO6
 daYoHPkTv10AuK79h41k961RV/8odjjBxa1tO18F9CZc3xmaq/AK/jmGw2Q2gkaEU4/qo4L+9fo
 eHAIZNNKljFBdEEz2uK9XAjOPkOXZyBto2uKB+rferEEP0A==
X-Received: by 2002:a05:6a20:6f93:b0:3e2:89c3:2fa4 with SMTP id
 adf61e73a8af0-3e928cd8c05mr9398174637.38.1793648420558; 
 Mon, 02 Nov 2026 11:40:20 -0800 (PST)
Received: from f2fs-test.c.googlers.com.com
 (193.67.125.34.bc.googleusercontent.com. [34.125.67.193])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cdb364c48d4sm241826a12.27.2026.11.02.11.40.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2026 11:40:19 -0800 (PST)
From: Daeho Jeong <daeho43@gmail.com>
To: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 kernel-team@android.com
Date: Mon,  2 Nov 2026 11:39:40 -0800
Message-ID: <20261102193952.3002018-9-daeho43@gmail.com>
X-Mailer: git-send-email 2.56.0.385.gac671c819a-goog
In-Reply-To: <20261102193952.3002018-1-daeho43@gmail.com>
References: <20261102193952.3002018-1-daeho43@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: 1.1 (+)
X-Headers-End: 1xNxtK-000000002ZU-3VYj
Subject: [f2fs-dev] [PATCH 08/20] f2fs: adapt range operations and mmap for
 subpage blocks
X-BeenThere: linux-f2fs-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: Daeho Jeong <daehojeong@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Daeho Jeong <daehojeong@google.com>

- A writable PTE covers the whole folio, so page_mkwrite prepares
  every block of the folio up to EOF and dirties only those blocks.
- Align zero range, punch hole, preallocation and truncation to the
  block size instead of PAGE_SIZE. When i_size grows, write-protect the
  folio straddling the old EOF so that stores to its new blocks fault
  into page_mkwrite.
- Unmap every base page overlapping a punched or zeroed range, and
  truncate the page cache without truncate_pagecache_range(), whose
  unmap underflows for a range ending in the first page.
- For SEEK_DATA, treat a NEW_ADDR block as data only if the block
  itself is dirty.
- When truncation zeroes the tail of a page, mark only the block
  holding the new EOF dirty, not the blocks after it.

The SEEK_DATA change also applies to large folios when the block size
equals PAGE_SIZE.

Signed-off-by: Daeho Jeong <daehojeong@google.com>
---
 fs/f2fs/data.c |  58 +++++++++--
 fs/f2fs/f2fs.h |   4 +-
 fs/f2fs/file.c | 263 ++++++++++++++++++++++++++++++++-----------------
 3 files changed, 228 insertions(+), 97 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 41246f83b31d..77915a2eb190 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -3198,7 +3198,7 @@ bool f2fs_ffs_dirty_blk_range(struct folio *folio, unsigned int from,
 
 static bool find_next_valid_block(const struct folio *folio,
 				  size_t orig_off, size_t *need_off,
-				  size_t len)
+				  size_t len, bool read_full)
 {
 	struct f2fs_sb_info *sbi = F2FS_M_SB(folio->mapping);
 	size_t start = orig_off;
@@ -3206,6 +3206,20 @@ static bool find_next_valid_block(const struct folio *folio,
 	size_t head, tail;
 	pgoff_t index;
 
+	/* Find every block that is not uptodate, not only the partial ones. */
+	if (read_full) {
+		for (head = round_down(*need_off, F2FS_BLKSIZE(sbi)); head < end;
+		     head += F2FS_BLKSIZE(sbi)) {
+			index = f2fs_folio_lblk(sbi, folio) +
+				F2FS_BYTES_TO_BLK(sbi, head);
+			if (!f2fs_ffs_test_blk_uptodate(folio, index)) {
+				*need_off = head;
+				return true;
+			}
+		}
+		return false;
+	}
+
 	if (start & (F2FS_BLKSIZE(sbi) - 1)) {
 		head = round_down(start, F2FS_BLKSIZE(sbi));
 		index = f2fs_folio_lblk(sbi, folio) +
@@ -5222,7 +5236,8 @@ static bool f2fs_balance_fs_folio_locked(struct folio *folio,
 
 static int prepare_large_folio_write_begin(struct inode *inode,
 					  struct folio *folio, loff_t pos,
-					  unsigned int len, bool *need_balance)
+					  unsigned int len, bool read_full,
+					  bool preallocated, bool *need_balance)
 {
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
 	struct f2fs_folio_state *ffs;
@@ -5238,8 +5253,7 @@ static int prepare_large_folio_write_begin(struct inode *inode,
 	 * Reserve blocks without f2fs_balance_fs() since the folio is locked;
 	 * the caller balances after unlocking it if *need_balance is set.
 	 */
-	if (!is_inode_flag_set(inode, FI_PREALLOCATED_ALL) &&
-	    !IS_DEVICE_ALIASING(inode)) {
+	if (!preallocated && !IS_DEVICE_ALIASING(inode)) {
 		pgoff_t first = F2FS_BYTES_TO_BLK(sbi, pos);
 		pgoff_t last = F2FS_BLK_ALIGN(sbi, pos + len);
 		pgoff_t idx;
@@ -5261,14 +5275,15 @@ static int prepare_large_folio_write_begin(struct inode *inode,
 	/* Skip read if the folio is already fully uptodate or the write
 	 * covers the entire folio.
 	 */
-	if (folio_test_uptodate(folio) || len == folio_size(folio))
+	if (folio_test_uptodate(folio) ||
+	    (!read_full && len == folio_size(folio)))
 		return 0;
 
 	/*
 	 * Skip read if the write starts at a block boundary and reaches EOF,
 	 * and zero the rest of the folio instead.
 	 */
-	if (!f2fs_verity_in_progress(inode) &&
+	if (!read_full && !f2fs_verity_in_progress(inode) &&
 	    !(pos & (F2FS_BLKSIZE(sbi) - 1)) && (pos + len) >= i_size_read(inode)) {
 		size_t zoff = ori_off + len;
 
@@ -5281,7 +5296,7 @@ static int prepare_large_folio_write_begin(struct inode *inode,
 	f2fs_bug_on(sbi, f2fs_has_inline_data(inode));
 
 	while (find_next_valid_block(folio, ori_off,
-				     &need_off, len)) {
+				     &need_off, len, read_full)) {
 		struct dnode_of_data dn;
 		pgoff_t index = f2fs_folio_lblk(sbi, folio) +
 				F2FS_BYTES_TO_BLK(sbi, need_off);
@@ -5382,6 +5397,20 @@ static int prepare_large_folio_atomic_write_begin(struct inode *inode,
 	return 0;
 }
 
+int f2fs_prepare_subpage_mkwrite(struct inode *inode, struct folio *folio,
+				 loff_t pos, unsigned int len)
+{
+	bool need_balance = false;
+
+	/*
+	 * mkwrite runs without inode_lock, so FI_PREALLOCATED_ALL may have
+	 * been set by a concurrent write() for a different range. It calls
+	 * f2fs_balance_fs() before locking the folio, so ignore need_balance.
+	 */
+	return prepare_large_folio_write_begin(inode, folio, pos, len, true,
+					       false, &need_balance);
+}
+
 static int f2fs_write_begin(const struct kiocb *iocb,
 			    struct address_space *mapping,
 			    loff_t pos, unsigned len, struct folio **foliop,
@@ -5490,7 +5519,9 @@ static int f2fs_write_begin(const struct kiocb *iocb,
 					mapping, folio, pos, len, retried);
 	} else {
 		err = prepare_large_folio_write_begin(inode, folio, pos, blen,
-						      &need_balance);
+				false,
+				is_inode_flag_set(inode, FI_PREALLOCATED_ALL),
+				&need_balance);
 	}
 	if (err) {
 		if (err == -EAGAIN) {
@@ -5566,6 +5597,7 @@ static int f2fs_write_end(const struct kiocb *iocb,
 			struct folio *folio, void *fsdata)
 {
 	struct inode *inode = folio->mapping->host;
+	loff_t old_size = i_size_read(inode);
 
 	trace_f2fs_write_end(inode, pos, len, copied);
 
@@ -5595,6 +5627,8 @@ static int f2fs_write_end(const struct kiocb *iocb,
 		if (pos + copied > i_size_read(inode) &&
 				!f2fs_verity_in_progress(inode))
 			f2fs_i_size_write(inode, pos + copied);
+		if (i_size_read(inode) > old_size)
+			pagecache_isize_extended(inode, old_size, pos);
 		return copied;
 	}
 #endif
@@ -5620,6 +5654,14 @@ static int f2fs_write_end(const struct kiocb *iocb,
 unlock_out:
 	f2fs_folio_put(folio, true);
 	f2fs_update_time(F2FS_I_SB(inode), REQ_TIME);
+
+	/*
+	 * The folio straddling the old EOF may still be mapped writable, and
+	 * the blocks between the old EOF and pos in it are not prepared.
+	 * Write-protect it so that mmap stores to them fault.
+	 */
+	if (i_size_read(inode) > old_size)
+		pagecache_isize_extended(inode, old_size, pos);
 	return copied;
 }
 
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index aab1095ad5ff..8e3224eacdb5 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -4094,7 +4094,7 @@ int f2fs_getattr(const struct mnt_idmap *idmap, const struct path *path,
 		 struct kstat *stat, u32 request_mask, unsigned int flags);
 int f2fs_setattr(const struct mnt_idmap *idmap, struct dentry *dentry,
 		 struct iattr *attr);
-int f2fs_truncate_hole(struct inode *inode, pgoff_t pg_start, pgoff_t pg_end);
+int f2fs_truncate_hole(struct inode *inode, pgoff_t blk_start, pgoff_t blk_end);
 void f2fs_truncate_data_blocks_range(struct dnode_of_data *dn, int count);
 int f2fs_do_shutdown(struct f2fs_sb_info *sbi, unsigned int flag,
 						bool readonly, bool need_lock);
@@ -4539,6 +4539,8 @@ void f2fs_ffs_clear_subrange_uptodate(struct folio *folio, size_t offset,
 				      size_t len);
 bool f2fs_ffs_dirty_blk_range(struct folio *folio, unsigned int from,
 			      unsigned int to, unsigned int *start, unsigned int *count);
+int f2fs_prepare_subpage_mkwrite(struct inode *inode, struct folio *folio,
+				 loff_t pos, unsigned int len);
 void f2fs_write_failed(struct inode *inode, loff_t to);
 void f2fs_invalidate_folio(struct folio *folio, size_t offset, size_t length);
 bool f2fs_release_folio(struct folio *folio, gfp_t wait);
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index be548f39e33e..e68553cef777 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -41,18 +41,19 @@ static int fill_zero(struct inode *inode, pgoff_t index,
 
 static int do_zero_post_eof_page(struct inode *inode, loff_t new_size)
 {
+	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
 	loff_t old_size = i_size_read(inode);
 	unsigned int offset, len;
-	pgoff_t index;
+	pgoff_t bidx;
 	int err;
 
-	offset = old_size & (PAGE_SIZE - 1);
+	offset = old_size & (F2FS_BLKSIZE(sbi) - 1);
 
 	if (!offset)
 		return 0;
 
-	len = min_t(loff_t, PAGE_SIZE - offset, new_size - old_size);
-	index = old_size >> PAGE_SHIFT;
+	len = min_t(loff_t, F2FS_BLKSIZE(sbi) - offset, new_size - old_size);
+	bidx = F2FS_BYTES_TO_BLK(sbi, old_size);
 
 	if (f2fs_has_inline_data(inode)) {
 		/* data post eof should be always zero */
@@ -63,7 +64,7 @@ static int do_zero_post_eof_page(struct inode *inode, loff_t new_size)
 			return err;
 	}
 
-	err = fill_zero(inode, index, offset, len);
+	err = fill_zero(inode, bidx, offset, len);
 	if (err)
 		return err;
 	return filemap_write_and_wait_range(inode->i_mapping,
@@ -144,11 +145,11 @@ static vm_fault_t f2fs_vm_page_mkwrite(struct vm_fault *vmf)
 	bool need_alloc = !f2fs_is_pinned_file(inode);
 	pgoff_t pidx = folio->index + folio_page_idx(folio, vmf->page);
 	loff_t pos = (loff_t)pidx << PAGE_SHIFT;
+	pgoff_t bidx = F2FS_BYTES_TO_BLK(sbi, pos + offset_in_page(vmf->address));
 	loff_t isize;
 	loff_t folio_start;
 	loff_t valid_end;
 	size_t dirty_len;
-	size_t subpage_off;
 	pgoff_t i, nr;
 	int err = 0;
 	vm_fault_t ret;
@@ -212,14 +213,12 @@ static vm_fault_t f2fs_vm_page_mkwrite(struct vm_fault *vmf)
 	folio_lock(folio);
 	isize = i_size_read(inode);
 	folio_start = folio_pos(folio);
-	subpage_off = offset_in_folio(folio, pos);
 	valid_end = min_t(loff_t, folio_start + folio_size(folio), isize);
 	dirty_len = valid_end - folio_start;
 
 	if (unlikely(folio->mapping != inode->i_mapping ||
 			pos >= isize ||
-			!f2fs_ffs_test_blk_uptodate(folio,
-			folio->index + (subpage_off >> PAGE_SHIFT)))) {
+			!f2fs_ffs_test_blk_uptodate(folio, bidx))) {
 		folio_unlock(folio);
 		err = -EFAULT;
 		goto out_sem;
@@ -240,6 +239,24 @@ static vm_fault_t f2fs_vm_page_mkwrite(struct vm_fault *vmf)
 
 	nr = DIV_ROUND_UP(dirty_len, PAGE_SIZE);
 
+	if (f2fs_has_subpage_blocks(sbi)) {
+		/*
+		 * A writable PTE covers the whole base folio.  Like ext4's
+		 * block_page_mkwrite(), prepare every filesystem block through EOF
+		 * before returning it writable, but dirty only those blocks.  This
+		 * prevents a later store in a sibling 4K block from bypassing block
+		 * allocation while also keeping blocks beyond i_size clean.
+		 */
+		f2fs_folio_wait_writeback(folio, false, true);
+		err = f2fs_prepare_subpage_mkwrite(inode, folio,
+						   folio_pos(folio), dirty_len);
+		if (err) {
+			folio_unlock(folio);
+			goto out_sem;
+		}
+		goto zero_tail;
+	}
+
 	for (i = 0; i < nr; i++) {
 		err = f2fs_get_block_mkwrite(inode, folio, folio->index + i,
 					     need_alloc);
@@ -249,6 +266,7 @@ static vm_fault_t f2fs_vm_page_mkwrite(struct vm_fault *vmf)
 		}
 	}
 
+zero_tail:
 	/* page is wholly or partially inside EOF */
 	if (folio_start + folio_size(folio) > isize) {
 		size_t offset = offset_in_folio(folio, isize);
@@ -256,8 +274,7 @@ static vm_fault_t f2fs_vm_page_mkwrite(struct vm_fault *vmf)
 		folio_zero_segment(folio, offset, folio_size(folio));
 	}
 
-	if (folio_test_large(folio))
-		f2fs_ffs_mark_subrange_dirty(folio, 0, dirty_len);
+	f2fs_ffs_mark_subrange_dirty(folio, 0, dirty_len);
 	folio_mark_dirty(folio);
 
 	f2fs_update_iostat(sbi, inode, APP_MAPPED_IO, dirty_len);
@@ -503,7 +520,9 @@ static bool __found_offset(struct address_space *mapping,
 {
 	block_t blkaddr = f2fs_data_blkaddr(dn);
 	struct inode *inode = mapping->host;
+	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
 	bool compressed_cluster = false;
+	bool dirty = false;
 
 	if (f2fs_compressed_file(inode)) {
 		block_t first_blkaddr = data_blkaddr(dn->inode, dn->node_entry,
@@ -512,12 +531,37 @@ static bool __found_offset(struct address_space *mapping,
 		compressed_cluster = first_blkaddr == COMPRESS_ADDR;
 	}
 
+	if (blkaddr == NEW_ADDR) {
+		pgoff_t f_index = f2fs_lblk_to_folio_index(sbi, index);
+
+		if (xa_get_mark(&mapping->i_pages, f_index, PAGECACHE_TAG_DIRTY)) {
+			struct folio *folio = filemap_get_folio(mapping, f_index);
+
+			if (!IS_ERR(folio)) {
+				/*
+				 * ffs is freed under the folio lock. We hold the
+				 * dnode, so only trylock the folio, and take the
+				 * block as dirty, as the dirty tag says, if the
+				 * folio is busy.
+				 */
+				if (folio_trylock(folio)) {
+					if (folio->mapping == mapping)
+						dirty = f2fs_ffs_test_blk_dirty(folio,
+									index);
+					folio_unlock(folio);
+				} else {
+					dirty = true;
+				}
+				f2fs_folio_put(folio, false);
+			}
+		}
+	}
+
 	switch (whence) {
 	case SEEK_DATA:
 		if (__is_valid_data_blkaddr(blkaddr))
 			return true;
-		if (blkaddr == NEW_ADDR &&
-		    xa_get_mark(&mapping->i_pages, index, PAGECACHE_TAG_DIRTY))
+		if (dirty)
 			return true;
 		if (compressed_cluster)
 			return true;
@@ -815,20 +859,23 @@ void f2fs_truncate_data_blocks_range(struct dnode_of_data *dn, int count)
 					 dn->ofs_in_node, nr_free);
 }
 
-static int truncate_partial_data_page(struct inode *inode, u64 from,
+static int truncate_partial_data_block(struct inode *inode, u64 from,
 								bool cache_only)
 {
-	pgoff_t index = from >> PAGE_SHIFT;
+	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
+	pgoff_t bidx = F2FS_BYTES_TO_BLK(sbi, from);
+	pgoff_t f_index = f2fs_has_subpage_blocks(sbi) ?
+		f2fs_lblk_to_folio_index(sbi, bidx) : (from >> PAGE_SHIFT);
 	struct address_space *mapping = inode->i_mapping;
 	struct folio *folio;
 	size_t folio_off;
 	size_t blk_end;
 
-	if (!(from & (PAGE_SIZE - 1)) && !cache_only)
+	if (!(from & (F2FS_BLKSIZE(sbi) - 1)) && !cache_only)
 		return 0;
 
 	if (cache_only) {
-		folio = filemap_lock_folio(mapping, index);
+		folio = filemap_lock_folio(mapping, f_index);
 		if (IS_ERR(folio))
 		       return 0;
 		if (folio_test_uptodate(folio))
@@ -837,7 +884,7 @@ static int truncate_partial_data_page(struct inode *inode, u64 from,
 		return 0;
 	}
 
-	folio = f2fs_get_lock_data_folio(inode, index, true);
+	folio = f2fs_get_lock_data_folio(inode, bidx, true);
 	if (IS_ERR(folio))
 		return PTR_ERR(folio) == -ENOENT ? 0 : PTR_ERR(folio);
 truncate_out:
@@ -848,14 +895,15 @@ static int truncate_partial_data_page(struct inode *inode, u64 from,
 	folio_zero_segment(folio, folio_off, blk_end);
 
 	/* An encrypted inode should have a key and truncate the last page. */
-	f2fs_bug_on(F2FS_I_SB(inode), cache_only && IS_ENCRYPTED(inode));
+	f2fs_bug_on(sbi, cache_only && IS_ENCRYPTED(inode));
 	if (!cache_only) {
 		/*
 		 * The folio was read back above, so the subpage is
-		 * already uptodate and dirty data stays valid.
+		 * already uptodate and dirty data stays valid. Mark only
+		 * the block holding the new EOF dirty.
 		 */
 		f2fs_ffs_mark_subrange_dirty(folio, folio_off,
-				blk_end - folio_off);
+			round_up(folio_off, F2FS_BLKSIZE(sbi)) - folio_off);
 		folio_mark_dirty(folio);
 	}
 	f2fs_folio_put(folio, true);
@@ -944,9 +992,9 @@ int f2fs_do_truncate_blocks(struct inode *inode, u64 from, bool lock)
 	if (lock)
 		f2fs_unlock_op(sbi, &lc);
 free_partial:
-	/* lastly zero out the first data page */
+	/* lastly zero out the first data block */
 	if (!err)
-		err = truncate_partial_data_page(inode, from, truncate_page);
+		err = truncate_partial_data_block(inode, from, truncate_page);
 out_err:
 	trace_f2fs_truncate_blocks_exit(inode, err);
 	return err;
@@ -1310,7 +1358,7 @@ const struct inode_operations f2fs_file_inode_operations = {
 	.fileattr_set	= f2fs_fileattr_set,
 };
 
-static int fill_zero(struct inode *inode, pgoff_t index,
+static int fill_zero(struct inode *inode, pgoff_t bidx,
 					loff_t start, loff_t len)
 {
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
@@ -1324,15 +1372,14 @@ static int fill_zero(struct inode *inode, pgoff_t index,
 	f2fs_balance_fs(sbi, true);
 
 	f2fs_lock_op(sbi, &lc);
-	folio = f2fs_get_new_data_folio(inode, NULL, index, false);
+	folio = f2fs_get_new_data_folio(inode, NULL, bidx, false);
 	f2fs_unlock_op(sbi, &lc);
 
 	if (IS_ERR(folio))
 		return PTR_ERR(folio);
 
 	f2fs_folio_wait_writeback(folio, true, true);
-	folio_off = offset_in_folio(folio,
-				   (loff_t)index << PAGE_SHIFT) + start;
+	folio_off = f2fs_folio_byte_offset(sbi, folio, bidx) + start;
 	folio_zero_range(folio, folio_off, len);
 	/*
 	 * This subpage must be uptodate here, which is guaranteed by
@@ -1344,41 +1391,68 @@ static int fill_zero(struct inode *inode, pgoff_t index,
 	return 0;
 }
 
-int f2fs_truncate_hole(struct inode *inode, pgoff_t pg_start, pgoff_t pg_end)
+int f2fs_truncate_hole(struct inode *inode, pgoff_t blk_start, pgoff_t blk_end)
 {
 	int err;
 
-	while (pg_start < pg_end) {
+	while (blk_start < blk_end) {
 		struct dnode_of_data dn;
 		pgoff_t end_offset, count;
 
 		set_new_dnode(&dn, inode, NULL, NULL, 0);
-		err = f2fs_get_dnode_of_data(&dn, pg_start, LOOKUP_NODE);
+		err = f2fs_get_dnode_of_data(&dn, blk_start, LOOKUP_NODE);
 		if (err) {
 			if (err == -ENOENT) {
-				pg_start = f2fs_get_next_block_offset(&dn,
-								pg_start);
+				blk_start = f2fs_get_next_block_offset(&dn,
+								blk_start);
 				continue;
 			}
 			return err;
 		}
 
 		end_offset = ADDRS_PER_PAGE(dn.node_entry, inode);
-		count = min(end_offset - dn.ofs_in_node, pg_end - pg_start);
+		count = min(end_offset - dn.ofs_in_node, blk_end - blk_start);
 
 		f2fs_bug_on(F2FS_I_SB(inode), count == 0 || count > end_offset);
 
 		f2fs_truncate_data_blocks_range(&dn, count);
 		f2fs_put_dnode(&dn);
 
-		pg_start += count;
+		blk_start += count;
 	}
 	return 0;
 }
 
+/*
+ * unmap_mapping_range() computes page count solely from holelen, which causes
+ * under-unmapping when start is not PAGE_SIZE aligned. Outward-align to PAGE_SIZE
+ * to guarantee all overlapping base pages are unmapped.
+ *
+ * Then truncate the page cache without truncate_pagecache_range(), whose own
+ * unmap underflows when the range ends in the first page and unmaps the rest
+ * of the file.
+ */
+static void f2fs_truncate_pagecache_range(struct inode *inode,
+					  loff_t start, loff_t end)
+{
+	struct address_space *mapping = inode->i_mapping;
+	loff_t unmap_start, unmap_len;
+
+	if (!f2fs_has_subpage_blocks(F2FS_I_SB(inode))) {
+		truncate_pagecache_range(inode, start, end - 1);
+		return;
+	}
+
+	unmap_start = round_down(start, PAGE_SIZE);
+	unmap_len = round_up(end, PAGE_SIZE) - unmap_start;
+	unmap_mapping_range(mapping, unmap_start, unmap_len, 0);
+	truncate_inode_pages_range(mapping, start, end - 1);
+}
+
 static int f2fs_punch_hole(struct inode *inode, loff_t offset, loff_t len)
 {
-	pgoff_t pg_start, pg_end;
+	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
+	pgoff_t blk_start, blk_end;
 	loff_t off_start, off_end;
 	int ret;
 
@@ -1390,47 +1464,46 @@ static int f2fs_punch_hole(struct inode *inode, loff_t offset, loff_t len)
 	if (ret)
 		return ret;
 
-	pg_start = ((unsigned long long) offset) >> PAGE_SHIFT;
-	pg_end = ((unsigned long long) offset + len) >> PAGE_SHIFT;
+	blk_start = F2FS_BYTES_TO_BLK(sbi, offset);
+	blk_end = F2FS_BYTES_TO_BLK(sbi, offset + len);
 
-	off_start = offset & (PAGE_SIZE - 1);
-	off_end = (offset + len) & (PAGE_SIZE - 1);
+	off_start = offset & F2FS_BLKSIZE_MASK(sbi);
+	off_end = (offset + len) & F2FS_BLKSIZE_MASK(sbi);
 
-	if (pg_start == pg_end) {
-		ret = fill_zero(inode, pg_start, off_start,
+	if (blk_start == blk_end) {
+		ret = fill_zero(inode, blk_start, off_start,
 						off_end - off_start);
 		if (ret)
 			return ret;
 	} else {
 		if (off_start) {
-			ret = fill_zero(inode, pg_start++, off_start,
-						PAGE_SIZE - off_start);
+			ret = fill_zero(inode, blk_start++, off_start,
+						F2FS_BLKSIZE(sbi) - off_start);
 			if (ret)
 				return ret;
 		}
 		if (off_end) {
-			ret = fill_zero(inode, pg_end, 0, off_end);
+			ret = fill_zero(inode, blk_end, 0, off_end);
 			if (ret)
 				return ret;
 		}
 
-		if (pg_start < pg_end) {
-			loff_t blk_start, blk_end;
-			struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
+		if (blk_start < blk_end) {
+			loff_t byte_start, byte_end;
 			struct f2fs_lock_context lc;
 
 			f2fs_balance_fs(sbi, true);
 
-			blk_start = (loff_t)pg_start << PAGE_SHIFT;
-			blk_end = (loff_t)pg_end << PAGE_SHIFT;
+			byte_start = F2FS_BLK_TO_BYTES(sbi, blk_start);
+			byte_end = F2FS_BLK_TO_BYTES(sbi, blk_end);
 
 			f2fs_down_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
 			filemap_invalidate_lock(inode->i_mapping);
 
-			truncate_pagecache_range(inode, blk_start, blk_end - 1);
+			f2fs_truncate_pagecache_range(inode, byte_start, byte_end);
 
 			f2fs_lock_op(sbi, &lc);
-			ret = f2fs_truncate_hole(inode, pg_start, pg_end);
+			ret = f2fs_truncate_hole(inode, blk_start, blk_end);
 			f2fs_unlock_op(sbi, &lc);
 
 			filemap_invalidate_unlock(inode->i_mapping);
@@ -1621,7 +1694,7 @@ static int __clone_blkaddrs(struct inode *src_inode, struct inode *dst_inode,
 			f2fs_folio_wait_writeback(fdst, true, true);
 			memcpy_folio(fdst, dst_off, fsrc, src_off,
 				    F2FS_BLKSIZE(sbi));
-			if (folio_test_large(fdst)) {
+			if (f2fs_is_multiblock_folio(sbi, fdst)) {
 				f2fs_ffs_mark_subrange_uptodate(fdst,
 						dst_off, F2FS_BLKSIZE(sbi));
 				f2fs_ffs_mark_subrange_dirty(fdst, dst_off,
@@ -1830,7 +1903,7 @@ static int f2fs_zero_range(struct inode *inode, loff_t offset, loff_t len,
 {
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
 	struct address_space *mapping = inode->i_mapping;
-	pgoff_t index, pg_start, pg_end;
+	pgoff_t blk_start, blk_end;
 	loff_t new_size = i_size_read(inode);
 	loff_t off_start, off_end;
 	int ret = 0;
@@ -1851,31 +1924,33 @@ static int f2fs_zero_range(struct inode *inode, loff_t offset, loff_t len,
 	if (ret)
 		return ret;
 
-	pg_start = ((unsigned long long) offset) >> PAGE_SHIFT;
-	pg_end = ((unsigned long long) offset + len) >> PAGE_SHIFT;
+	blk_start = F2FS_BYTES_TO_BLK(sbi, offset);
+	blk_end = F2FS_BYTES_TO_BLK(sbi, offset + len);
 
-	off_start = offset & (PAGE_SIZE - 1);
-	off_end = (offset + len) & (PAGE_SIZE - 1);
+	off_start = offset & F2FS_BLKSIZE_MASK(sbi);
+	off_end = (offset + len) & F2FS_BLKSIZE_MASK(sbi);
 
-	if (pg_start == pg_end) {
-		ret = fill_zero(inode, pg_start, off_start,
+	if (blk_start == blk_end) {
+		ret = fill_zero(inode, blk_start, off_start,
 						off_end - off_start);
 		if (ret)
 			return ret;
 
 		new_size = max_t(loff_t, new_size, offset + len);
 	} else {
+		pgoff_t index;
+
 		if (off_start) {
-			ret = fill_zero(inode, pg_start++, off_start,
-						PAGE_SIZE - off_start);
+			ret = fill_zero(inode, blk_start++, off_start,
+						F2FS_BLKSIZE(sbi) - off_start);
 			if (ret)
 				return ret;
 
 			new_size = max_t(loff_t, new_size,
-					(loff_t)pg_start << PAGE_SHIFT);
+					F2FS_BLK_TO_BYTES(sbi, blk_start));
 		}
 
-		for (index = pg_start; index < pg_end;) {
+		for (index = blk_start; index < blk_end;) {
 			struct dnode_of_data dn;
 			struct f2fs_lock_context lc;
 			unsigned int end_offset;
@@ -1884,9 +1959,9 @@ static int f2fs_zero_range(struct inode *inode, loff_t offset, loff_t len,
 			f2fs_down_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
 			filemap_invalidate_lock(mapping);
 
-			truncate_pagecache_range(inode,
-				(loff_t)index << PAGE_SHIFT,
-				((loff_t)pg_end << PAGE_SHIFT) - 1);
+			f2fs_truncate_pagecache_range(inode,
+				F2FS_BLK_TO_BYTES(sbi, index),
+				F2FS_BLK_TO_BYTES(sbi, blk_end));
 
 			f2fs_lock_op(sbi, &lc);
 
@@ -1900,7 +1975,7 @@ static int f2fs_zero_range(struct inode *inode, loff_t offset, loff_t len,
 			}
 
 			end_offset = ADDRS_PER_PAGE(dn.node_entry, inode);
-			end = min(pg_end, end_offset - dn.ofs_in_node + index);
+			end = min(blk_end, end_offset - dn.ofs_in_node + index);
 
 			ret = f2fs_do_zero_range(&dn, index, end);
 			f2fs_put_dnode(&dn);
@@ -1916,11 +1991,11 @@ static int f2fs_zero_range(struct inode *inode, loff_t offset, loff_t len,
 
 			index = end;
 			new_size = max_t(loff_t, new_size,
-					(loff_t)index << PAGE_SHIFT);
+					F2FS_BLK_TO_BYTES(sbi, index));
 		}
 
 		if (off_end) {
-			ret = fill_zero(inode, pg_end, 0, off_end);
+			ret = fill_zero(inode, blk_end, 0, off_end);
 			if (ret)
 				goto out;
 
@@ -1930,10 +2005,14 @@ static int f2fs_zero_range(struct inode *inode, loff_t offset, loff_t len,
 
 out:
 	if (new_size > i_size_read(inode)) {
-		if (mode & FALLOC_FL_KEEP_SIZE)
+		if (mode & FALLOC_FL_KEEP_SIZE) {
 			file_set_keep_isize(inode);
-		else
+		} else {
+			loff_t old_size = i_size_read(inode);
+
 			f2fs_i_size_write(inode, new_size);
+			pagecache_isize_extended(inode, old_size, new_size);
+		}
 	}
 	return ret;
 }
@@ -2034,7 +2113,7 @@ static int f2fs_expand_inode_data(struct inode *inode, loff_t offset,
 			.should_migrate_blocks = false,
 			.err_gc_skipped = true,
 			.nr_free_secs = 0 };
-	pgoff_t pg_start, pg_end;
+	pgoff_t blk_start, blk_end;
 	loff_t new_size;
 	loff_t off_end;
 	block_t expanded = 0;
@@ -2054,12 +2133,12 @@ static int f2fs_expand_inode_data(struct inode *inode, loff_t offset,
 
 	f2fs_balance_fs(sbi, true);
 
-	pg_start = ((unsigned long long)offset) >> PAGE_SHIFT;
-	pg_end = ((unsigned long long)offset + len) >> PAGE_SHIFT;
-	off_end = (offset + len) & (PAGE_SIZE - 1);
+	blk_start = F2FS_BYTES_TO_BLK(sbi, offset);
+	blk_end = F2FS_BYTES_TO_BLK(sbi, offset + len);
+	off_end = (offset + len) & F2FS_BLKSIZE_MASK(sbi);
 
-	map.m_lblk = pg_start;
-	map.m_len = pg_end - pg_start;
+	map.m_lblk = blk_start;
+	map.m_len = blk_end - blk_start;
 	if (off_end)
 		map.m_len++;
 
@@ -2071,9 +2150,9 @@ static int f2fs_expand_inode_data(struct inode *inode, loff_t offset,
 		block_t sec_len;
 
 		if (map.m_lblk % sec_blks) {
-			pg_start = rounddown(map.m_lblk, sec_blks);
-			map.m_lblk = pg_start;
-			map.m_len = pg_end - pg_start;
+			blk_start = rounddown(map.m_lblk, sec_blks);
+			map.m_lblk = blk_start;
+			map.m_len = blk_end - blk_start;
 			if (off_end)
 				map.m_len++;
 		}
@@ -2089,7 +2168,7 @@ static int f2fs_expand_inode_data(struct inode *inode, loff_t offset,
 				f2fs_warn_ratelimited(sbi,
 					"ino:%llu, start:%lu, end:%lu, need to trigger GC to "
 					"reclaim enough free segment when checkpoint is enabled",
-					inode->i_ino, pg_start, pg_end);
+					inode->i_ino, blk_start, blk_end);
 				goto out_err;
 			}
 		}
@@ -2135,20 +2214,24 @@ static int f2fs_expand_inode_data(struct inode *inode, loff_t offset,
 		if (!expanded)
 			return err;
 
-		last_off = pg_start + expanded - 1;
+		last_off = blk_start + expanded - 1;
 
 		/* update new size to the failed position */
-		new_size = (last_off == pg_end) ? offset + len :
-					(loff_t)(last_off + 1) << PAGE_SHIFT;
+		new_size = (last_off == blk_end) ? offset + len :
+					F2FS_BLK_TO_BYTES(sbi, last_off + 1);
 	} else {
-		new_size = ((loff_t)pg_end << PAGE_SHIFT) + off_end;
+		new_size = F2FS_BLK_TO_BYTES(sbi, blk_end) + off_end;
 	}
 
 	if (new_size > i_size_read(inode)) {
-		if (mode & FALLOC_FL_KEEP_SIZE)
+		if (mode & FALLOC_FL_KEEP_SIZE) {
 			file_set_keep_isize(inode);
-		else
+		} else {
+			loff_t old_size = i_size_read(inode);
+
 			f2fs_i_size_write(inode, new_size);
+			pagecache_isize_extended(inode, old_size, new_size);
+		}
 	}
 
 	return err;
@@ -5758,8 +5841,12 @@ static ssize_t f2fs_dio_write_iter(struct kiocb *iocb, struct iov_iter *from,
 
 	if (ret < 0)
 		goto out;
-	if (pos + ret > inode->i_size)
+	if (pos + ret > inode->i_size) {
+		loff_t old_size = inode->i_size;
+
 		f2fs_i_size_write(inode, pos + ret);
+		pagecache_isize_extended(inode, old_size, pos + ret);
+	}
 	if (!do_opu)
 		set_inode_flag(inode, FI_UPDATE_WRITE);
 
-- 
2.56.0.317.g454f8302e1-goog



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
