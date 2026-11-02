Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAC706082BD2
	for <linux-f2fs-devel@archiver.kernel.org>; Mon,  2 Nov 2026 19:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=CCepAAgP;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=lvmHPDhc;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=gEKQM4Tu;
	dkim=neutral header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LeHxIoWH
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:List-Owner;
	bh=jErdtmCWvuA12SMfic973NW4jToY7OPoH+JRDy0d12g=; b=CCepAAgPbiVckqTbuP1ZQ4GfoB
	1ELNlbw6xz4QetUIAcfY+v6x/KLUA3EGjHkqzogRW6+icJCixeFJftMM6pI4Y/bQpGhyKda13wXN1
	RXt6ZGwarTqblcZjZaUDlBGaPxu9i+1prXxbv++lzI59b8ue+KcaZyZg+CedZ6xRvwrM=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xNxtR-000000006mb-23UV;
	Mon, 02 Nov 2026 19:40:33 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <daeho43@gmail.com>) id 1xNxtQ-000000006mN-2nfy
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 02 Nov 2026 19:40:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=y8IZnBsQxe10jjN/vGbP+pxieyV6s+i8M8IhvLraaUU=; b=lvmHPDhcsdzpg6UowbhIGdG8f4
 /0y6eBzfqBz025DYWAaEJfLL/InQRaOODpwSpMaqZWC8xvlvyokGsTXmBKGw58JgTGAN7w5EwIBuv
 bHFNwI6aZeoR85WoMiVMDXnaVKk3pVqMJQXeQpSTUCGztClfj5gdU2EuOGY5mvrQU8ic=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=y8IZnBsQxe10jjN/vGbP+pxieyV6s+i8M8IhvLraaUU=; b=gEKQM4TuzCElEpywDcFHergDxP
 1OAs07x6H2vFxg8BS2u4mtojRXd/l4b4equ1KVnDBXp16g3P+ItfG80Gab4/8BQPN+dL+UHrLxeml
 TO7D7c310svBCxbhSSfBa7yKDQSxdWRkPBd3J2LhAaCYsmWWW/qjRiHJ4eR3O6TOm1Ag=;
Received: from mail-pg1-f169.google.com ([209.85.215.169])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xNxtP-000000002DT-19eD
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 02 Nov 2026 19:40:32 +0000
Received: by mail-pg1-f169.google.com with SMTP id
 41be03b00d2f7-cd6a7e1f4e4so1431617a12.2
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 02 Nov 2026 11:40:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793648425; x=1794253225; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=y8IZnBsQxe10jjN/vGbP+pxieyV6s+i8M8IhvLraaUU=;
 b=LeHxIoWHugavChcrBZ9rWnVixc/d4IJJ6AyrlNnVuem0XMP7+uctw7L94CXOCVhTzI
 IM81RHx1J45lqMogqd0M+WnKcSX6OOyToPCJupvIclHDK7lQHDbXr0MRVfhM18pQ+X5K
 9ilq93L2e27Cih7RsonzbZ616oQY3lbcP7eCZDG8Y9lx0axeDtZdWOGfCaoZ4sLcXzx9
 kwh9ardIVfKnnPQqNyVDUDbHr9zY0yvXUJi1aKTGqPsFCP0LfmMSdThzehSmG0Jt5rmP
 cOisg56LWmw6IXJWQXAPZhatQbgC6MxHXirSFtw5l33c49MnKTr/AGbtIj9MduUTULAu
 GWTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793648425; x=1794253225;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=y8IZnBsQxe10jjN/vGbP+pxieyV6s+i8M8IhvLraaUU=;
 b=JLqKyzqZaF2qAetUAr/wp6u8MGACdhi7LCbaOwXI7OIzudmd5d0T9FFO4GgjTMI+h0
 vqs9FkJoaHlECerqviHIzXEUOTWbnBxRtWzRZDyUKK8F80iytiJTnQjlXr+AUrQJOhDv
 sGOBvDmAr+82x89P063uo660IZkW0aSCpTa53CSvczr2JA1M2dKVsY9pe8LIyzRDLLFi
 2DWjL9Nz49TrHvZchyqMiqWKRUys1uqNgZXS6Bb+TybODoycQC9kND2ZAvKzPMVysG0A
 rcQDNTWS26grJzjSXYCDpuHJBmRC2nvzMrdfdcNu7vcq/gM5sMywr26LAyDLW8s2cE7w
 5anA==
X-Forwarded-Encrypted: i=1;
 AKwUvBx7TJZCmhTz9QNZ9I2n/Mg93mxJrsVHS0WhHSyVMAy09B5ouvTOpMBcnKyBwzh4f4dIL+Q7nuAE+3DAosmNGlNB@lists.sourceforge.net
X-Gm-Message-State: AFq9FYKELRjJRuQuZQdQih0+OgoKsqm4SFwGoWJn0bs1Xeq4UkKfeW7i
 Ss1bM/7umKXrumvA0hnp15MpD/lYtTvOQlYdykNqSNbCD3z8iOW1CgOO
X-Gm-Gg: AYBFou3KTUK2spwcFXBilGX/Gshte/hJ9FBvj7Bw3c2880gF8adeDAnYxb0fSVucGom
 E4CmPV0SHojTOu6FpNO16Et0yVyIW/w0b9b9IuCgyfyFCiEYakJ1a2cmqt2z+LSh41x5DOPvR31
 /7002JLtpPlxeTTk9y12jIsmSs7Rekl1exxcNN/0M8RyfThtEieUMQ6BMIyVf3kSotiGwjpyuwp
 Y5mOodD2zclPnptvBz9PACFAnnhlg+tLVswNwCMnDxVhtDPNvMYd1nVtwVB0JJ3gdKe5a/SmByi
 qo1yrrqGptr7CsS6D4agDp+LAT+3HfrXTH9yhQYttTmV/4DPMTTGppJlclVa690QAv9Xdzr3JzB
 F9Z/Fw0KTESO1dr1yVMVjqCsERChog/50fAc//wneRh/zoYVC4n0sFobKjsUlvnlOtP4AccVFRP
 riiqzR4P6dpbnvreftCOY63FWsYXKqSe0zD7zdzCB/35YPFFyjbHySYAljh99LnP1x6uW5T6Otk
 KcqNOM4r1HMqf2j7sjdfd94fD3/TRgye8Za+3E2RYv1084OgyrF2dAIWzhZzIa+hSB2WBd6HgmK
 fgsZL9DLByEdaNEoRGB1m5eL1V7wbQ23NFUgrRFA0uMH8iTaYqFdL9VjFN1Y9f9ewRziqmSCDV5
 5RrHgKn/G94Z0lFLayevg+0FK6UJCtpJCGBTQv4F3pgJV+Q==
X-Received: by 2002:a05:6a20:7f9f:b0:3e2:3222:2559 with SMTP id
 adf61e73a8af0-3e92908c5eamr9596022637.62.1793648425514; 
 Mon, 02 Nov 2026 11:40:25 -0800 (PST)
Received: from f2fs-test.c.googlers.com.com
 (193.67.125.34.bc.googleusercontent.com. [34.125.67.193])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cdb364c48d4sm241826a12.27.2026.11.02.11.40.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2026 11:40:24 -0800 (PST)
From: Daeho Jeong <daeho43@gmail.com>
To: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 kernel-team@android.com
Date: Mon,  2 Nov 2026 11:39:42 -0800
Message-ID: <20261102193952.3002018-11-daeho43@gmail.com>
X-Mailer: git-send-email 2.56.0.385.gac671c819a-goog
In-Reply-To: <20261102193952.3002018-1-daeho43@gmail.com>
References: <20261102193952.3002018-1-daeho43@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: 1.1 (+)
X-Headers-End: 1xNxtP-000000002DT-19eD
Subject: [f2fs-dev] [PATCH 10/20] f2fs: support subpage blocks in collapse
 and insert range
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

The folio holding offset may hold blocks before the shifted range.
Write back the page cache from the PAGE_SIZE boundary below offset
under invalidate_lock before truncating it from there, so that no
data is lost. Detect src and dst in the same folio by folio index
instead of block index, as a folio holds several blocks. Remove the
-EOPNOTSUPP check.

Signed-off-by: Daeho Jeong <daehojeong@google.com>
---
 fs/f2fs/file.c | 72 +++++++++++++++++++++++++++++---------------------
 1 file changed, 42 insertions(+), 30 deletions(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 36da0d558ef0..3ef810653bb2 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -1659,6 +1659,7 @@ static int __clone_blkaddrs(struct inode *src_inode, struct inode *dst_inode,
 		} else {
 			struct folio *fsrc, *fdst;
 			size_t src_off, dst_off;
+			pgoff_t dst_fidx = f2fs_lblk_to_folio_index(sbi, dst + i);
 			bool same_folio;
 
 			fsrc = f2fs_get_lock_data_folio(src_inode,
@@ -1671,11 +1672,11 @@ static int __clone_blkaddrs(struct inode *src_inode, struct inode *dst_inode,
 
 			/*
 			 * For same-inode operations (collapse/insert), src and
-			 * dst may fall within the same large folio. Detect this
+			 * dst may fall within the same folio. Detect this
 			 * to avoid self-deadlock on folio lock.
 			 */
 			same_folio = src_inode == dst_inode &&
-				     folio_contains(fsrc, dst + i);
+				     folio_contains(fsrc, dst_fidx);
 			if (same_folio) {
 				struct dnode_of_data dn;
 
@@ -1783,7 +1784,7 @@ static int f2fs_do_collapse(struct inode *inode, loff_t offset, loff_t len)
 {
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
 	struct f2fs_lock_context lc;
-	pgoff_t nrpages = F2FS_BLK_ALIGN(sbi, i_size_read(inode));
+	pgoff_t nrblocks = F2FS_BLK_ALIGN(sbi, i_size_read(inode));
 	pgoff_t start = F2FS_BYTES_TO_BLK(sbi, offset);
 	pgoff_t end = F2FS_BYTES_TO_BLK(sbi, offset + len);
 	int ret;
@@ -1794,14 +1795,24 @@ static int f2fs_do_collapse(struct inode *inode, loff_t offset, loff_t len)
 	f2fs_down_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
 	filemap_invalidate_lock(inode->i_mapping);
 
+	/*
+	 * Write back under invalidate_lock, which blocks page_mkwrite, so
+	 * that truncate_pagecache() below cannot drop a racing mmap store to
+	 * the blocks before @offset in the head folio.
+	 */
+	ret = filemap_write_and_wait_range(inode->i_mapping,
+					   round_down(offset, PAGE_SIZE), LLONG_MAX);
+	if (ret)
+		goto out_unlock;
+
 	ret = f2fs_zero_post_eof_page(inode, offset + len, false, false);
 	if (ret)
 		goto out_unlock;
 
 	f2fs_lock_op(sbi, &lc);
 	f2fs_drop_extent_tree(inode);
-	truncate_pagecache(inode, offset);
-	ret = __exchange_data_block(inode, inode, end, start, nrpages - end, true);
+	truncate_pagecache(inode, round_down(offset, PAGE_SIZE));
+	ret = __exchange_data_block(inode, inode, end, start, nrblocks - end, true);
 	f2fs_unlock_op(sbi, &lc);
 
 out_unlock:
@@ -1827,21 +1838,17 @@ static int f2fs_collapse_range(struct inode *inode, loff_t offset, loff_t len)
 	if (ret)
 		return ret;
 
-	/* write out all dirty pages from offset */
-	ret = filemap_write_and_wait_range(inode->i_mapping, offset, LLONG_MAX);
-	if (ret)
-		return ret;
-
 	ret = f2fs_do_collapse(inode, offset, len);
 	if (ret)
 		return ret;
 
 	/* write out all moved pages, if possible */
 	filemap_invalidate_lock(inode->i_mapping);
-	ret = filemap_write_and_wait_range(inode->i_mapping, offset, LLONG_MAX);
+	ret = filemap_write_and_wait_range(inode->i_mapping,
+					   round_down(offset, PAGE_SIZE), LLONG_MAX);
 	if (ret)
 		goto out_unlock;
-	truncate_pagecache(inode, offset);
+	truncate_pagecache(inode, round_down(offset, PAGE_SIZE));
 
 	new_size = i_size_read(inode) - len;
 	ret = f2fs_truncate_blocks(inode, new_size, true);
@@ -2028,7 +2035,7 @@ static int f2fs_insert_range(struct inode *inode, loff_t offset, loff_t len)
 {
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
 	struct address_space *mapping = inode->i_mapping;
-	pgoff_t nr, pg_start, pg_end, delta, idx;
+	pgoff_t nr, blk_start, blk_end, delta, idx;
 	loff_t new_size;
 	int ret = 0;
 
@@ -2041,8 +2048,8 @@ static int f2fs_insert_range(struct inode *inode, loff_t offset, loff_t len)
 		return -EINVAL;
 
 	/* insert range should be aligned to block size of f2fs. */
-	if (offset & F2FS_BLKSIZE_MASK(F2FS_I_SB(inode)) ||
-	    len & F2FS_BLKSIZE_MASK(F2FS_I_SB(inode)))
+	if (offset & F2FS_BLKSIZE_MASK(sbi) ||
+	    len & F2FS_BLKSIZE_MASK(sbi))
 		return -EINVAL;
 
 	ret = f2fs_convert_inline_inode(inode);
@@ -2057,29 +2064,34 @@ static int f2fs_insert_range(struct inode *inode, loff_t offset, loff_t len)
 	if (ret)
 		return ret;
 
-	/* write out all dirty pages from offset */
-	ret = filemap_write_and_wait_range(mapping, offset, LLONG_MAX);
-	if (ret)
-		return ret;
-
-	pg_start = F2FS_BYTES_TO_BLK(sbi, offset);
-	pg_end = F2FS_BYTES_TO_BLK(sbi, offset + len);
-	delta = pg_end - pg_start;
+	blk_start = F2FS_BYTES_TO_BLK(sbi, offset);
+	blk_end = F2FS_BYTES_TO_BLK(sbi, offset + len);
+	delta = blk_end - blk_start;
 	idx = F2FS_BLK_ALIGN(sbi, i_size_read(inode));
 
 	/* avoid gc operation during block exchange */
 	f2fs_down_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
 	filemap_invalidate_lock(mapping);
 
+	/*
+	 * Write back under invalidate_lock, which blocks page_mkwrite, so
+	 * that truncate_pagecache() below cannot drop a racing mmap store to
+	 * the blocks before @offset in the head folio.
+	 */
+	ret = filemap_write_and_wait_range(mapping,
+					   round_down(offset, PAGE_SIZE), LLONG_MAX);
+	if (ret)
+		goto out_unlock;
+
 	ret = f2fs_zero_post_eof_page(inode, offset + len, false, false);
 	if (ret)
 		goto out_unlock;
-	truncate_pagecache(inode, offset);
+	truncate_pagecache(inode, round_down(offset, PAGE_SIZE));
 
-	while (!ret && idx > pg_start) {
+	while (!ret && idx > blk_start) {
 		struct f2fs_lock_context lc;
 
-		nr = idx - pg_start;
+		nr = idx - blk_start;
 		if (nr > delta)
 			nr = delta;
 		idx -= nr;
@@ -2099,8 +2111,9 @@ static int f2fs_insert_range(struct inode *inode, loff_t offset, loff_t len)
 
 	/* write out all moved pages, if possible */
 	filemap_invalidate_lock(mapping);
-	ret = filemap_write_and_wait_range(mapping, offset, LLONG_MAX);
-	truncate_pagecache(inode, offset);
+	ret = filemap_write_and_wait_range(mapping,
+					   round_down(offset, PAGE_SIZE), LLONG_MAX);
+	truncate_pagecache(inode, round_down(offset, PAGE_SIZE));
 	filemap_invalidate_unlock(mapping);
 
 	if (!ret)
@@ -2286,8 +2299,7 @@ static long f2fs_fallocate(struct file *file, int mode,
 	}
 
 	if (f2fs_has_subpage_blocks(F2FS_I_SB(inode))) {
-		if ((mode & (FALLOC_FL_COLLAPSE_RANGE | FALLOC_FL_INSERT_RANGE)) ||
-		    f2fs_is_atomic_file(inode) || f2fs_compressed_file(inode)) {
+		if (f2fs_is_atomic_file(inode) || f2fs_compressed_file(inode)) {
 			ret = -EOPNOTSUPP;
 			goto out;
 		}
-- 
2.56.0.317.g454f8302e1-goog



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
