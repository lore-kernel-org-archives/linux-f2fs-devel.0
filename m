Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F6B7606A88D
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 16 Nov 2026 04:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=gTdzC3GW;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=M2/wFeng;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=dA9rTKJ8;
	dkim=neutral header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0T/+8Z9Z
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:List-Owner;
	bh=w6xpttBI05rFDGehkmOECoAxixz+w22z1cL7GA+NBN0=; b=gTdzC3GWheDIpxjEsJiWfJc7qA
	9udx8klOIdDHiYR3GDCq7uAufWuyaqrtMCW8lBOwr4VbzKATz5QwDdD3LiIRq2e1r8G3sHpwPlkbi
	dwzANbtmIYi/3ltQexM9nlMhz8v6cMJWqAQ+NnEMAp74v9PQvNupR7bZ75usvMgTpr38=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xSo26-000000006e5-3Yd5;
	Mon, 16 Nov 2026 04:09:30 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <daeho43@gmail.com>) id 1xSo21-000000006cw-0zJR
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 16 Nov 2026 04:09:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=AMdUKRQlAJUKk0DcfTjI5nVHuAmHsiYW7/Tij+xmyXk=; b=M2/wFengfV2kGDanUSdqErIXVN
 r4Uk8NgKCGrzxx7N12owI61L5oa1sUH32S5t6dz6b2cZM9ezjNxdEmc3SI+RJ3CZm+Sn4bqP1N/w6
 Ge0ubIatAV1bef6ImBUy7N+tc5UTO7MDez3D+MQJqPI/zfucOEPo9RuKtOSeGjKnQMQc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=AMdUKRQlAJUKk0DcfTjI5nVHuAmHsiYW7/Tij+xmyXk=; b=dA9rTKJ8sqFIbkFw9d6VV+juD8
 wJydjEqasCL/XwkF9ADiPD9lLrR/tNmv1ArSnaFm8lnJpLMNM8nwl17jH81X0ok/+HI4WHrfI/Vs7
 rnGRlRzFYe2AjlXJUUPbTwUAkjA7k8fkx1qPPyPo3Ab1mo9kOPmfG3nyayVW+7ZILnUw=;
Received: from mail-pl1-f174.google.com ([209.85.214.174])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xSo1z-000000005gE-3iw9
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 16 Nov 2026 04:09:25 +0000
Received: by mail-pl1-f174.google.com with SMTP id
 d9443c01a7336-2ea7987517aso21931935ad.0
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Sun, 15 Nov 2026 20:09:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794802158; x=1795406958; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=AMdUKRQlAJUKk0DcfTjI5nVHuAmHsiYW7/Tij+xmyXk=;
 b=0T/+8Z9Zu+6+/vp0sjzd3DA5hfvmGhuxoOAltjrm2Zs1Zfcdgoi5yvCtHwxmL3PLTs
 Upc8knQilOfZ723a1q4nBKAHtAQwmo9cXUkoLsdIBnsGNijFcfH9iqUnoR9dSYedjObL
 maI0bg2AP5eQBjfAFt7h6cik/GltK4c2aIwEN71PsTw5H9L3723GKFBsVbMCdhSJJeyb
 uSPE2QL7m/GKUDDLWsyIWXrGEXD1G3C5JcJz8rPN1EFXmlu0lgFF2VY2GtOTMV4zokG/
 eJLxJodkFgI7fa/QOm50TQvRgRYd7Ex4/iQqLQmNlOPWXEMqWTT3TRADENPZN/k0LyFf
 U0UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794802158; x=1795406958;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=AMdUKRQlAJUKk0DcfTjI5nVHuAmHsiYW7/Tij+xmyXk=;
 b=zmxTVknAF2dUQDgnJtSySr155XVLqNCrlubcbxK7genAQgjulp6RHL2xJqhUnt0UdO
 Xv6VXULSyPTuksrT38oAkWmxyndBHRD1lYyq0rgN2r6yCMDVh1RLem91hS1On1Uq1my7
 pc9q8K1yk6J2CZ0jn/DQgMg+A9sHB2FkXzYpRoJqcICPoCietSxKRJ8s1ojImG68a4GE
 U/sTEMGYfy5NsABnza4HAoGL46DrZchq75FCttPdAq0SBSQW4/GswNlgoIFVRm7SBAun
 FPve23tyAQgmy0pp6TwsucduVg8zRc2GnHSuVL2FJZYrbkULFkSKwkf90+pszTiLUDrA
 R/3g==
X-Forwarded-Encrypted: i=1;
 AL+hErGenui+z19YaWrFw8WvxDKRu1hueh4ryTpEAQd7D7pbYFCm+YZlGQZviUUNFjv3Jn0onixin4oblQqoIkr7ojtf@lists.sourceforge.net
X-Gm-Message-State: APuU4Z+IFhd2XjGTqLIMgpIIGQjc22eRs6jkVi6Nl59OSQBfkcCkPWjN
 QO7Kvg5KfNOZSF75xaRnO5BAzzzDfm/GfF99TFotzMOWlQQhRD+03UyC7oE4lw==
X-Gm-Gg: AYBFou3/TuzwZCD7ut1S9OYGCLMXXt+GiruhmGP/MlKO+iAB1LiEN9zxgFCZ4JKLRMi
 hEsfOvdJ1cQGKATXV8NoCVmrsIeCu7E1C7WkxL124Xzrqo47KnbHtMmf/8i8/STmSF2o4d1V/hL
 1H3ez/2kpeBvHgQ7ekjHmMlKJAyO6AYofnOQ6SSKr6Akd2qzUxqBq1kMrHBRbnSmpGBAGEirqza
 MzTIt66+IYPuizW/IeM34D2R1IpihrZeHQ/+0dghCPEdVf5HZ1Pa14TzzVGjSrWGGffrTiklH8q
 xGba0mYXVshmALwQp9fFjeZzEnnK3RwbMikMvq+dQ0LNs8iN4yHtUPzUdWWKHkhPAZfkf2x84CR
 9lUnjymlOVgQRoJIMsLytLwGI6WNN3PEmAqm25TeSteSTz98+KLDLugDYUlz+RowiZMOPw/ucHd
 GkIDfon8g0Yt7LfRJWuEvsdDKY3ENdrjOYoiVp2+vJiNe4y+EDBDqJT6anQxRFP4T1A9Up10y8m
 uZAkVTUUpV+P+NOmDlIc+n+33GDvG20YIGTItXHBs3n0S9K9cM0MkOq9K0HeTOQyShom0I60WD1
 w1Vseia5jed5ETWZKhKSVOJ5R2/6fUv8HRcWtqX/P7TB3AfDbQOZYv7WP37XYvCJZvJCbtyz4iT
 Ph75oO/3od65ntLsi2vy580rlptPpRIteEKraCp+LWtrcbaU=
X-Received: by 2002:a17:90b:2cc3:b0:3b0:9e42:b67c with SMTP id
 98e67ed59e1d1-3b1b0d800e0mr9276558a91.61.1794802157998; 
 Sun, 15 Nov 2026 20:09:17 -0800 (PST)
Received: from f2fs-test.c.googlers.com.com
 (193.67.125.34.bc.googleusercontent.com. [34.125.67.193])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b1b3f09b92sm7191989a91.4.2026.11.15.20.09.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Nov 2026 20:09:17 -0800 (PST)
From: Daeho Jeong <daeho43@gmail.com>
To: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 kernel-team@android.com
Date: Sun, 15 Nov 2026 20:08:41 -0800
Message-ID: <20261116040851.2849696-11-daeho43@gmail.com>
X-Mailer: git-send-email 2.56.0.611.g1030f0b940-goog
In-Reply-To: <20261116040851.2849696-1-daeho43@gmail.com>
References: <20261116040851.2849696-1-daeho43@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: 1.1 (+)
X-Headers-End: 1xSo1z-000000005gE-3iw9
Subject: [f2fs-dev] [PATCH v2 10/20] f2fs: support subpage blocks in
 collapse and insert range
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
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,
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

Also take i_gc_rwsem[WRITE] and invalidate_lock before that writeback
and keep them until the moved blocks are written back and the page
cache is dropped, as move range does. After the block exchange, the
page cache holds the old data of the source blocks until then. With
subpage blocks, page_mkwrite dirties every block of a folio up to EOF,
so a store to a neighbouring block in between writes the old data back,
over a hole or over the moved data. This also keeps GC away from the
inode until then, for any block size.

Signed-off-by: Daeho Jeong <daehojeong@google.com>
---
 fs/f2fs/file.c | 115 ++++++++++++++++++++++++++++---------------------
 1 file changed, 65 insertions(+), 50 deletions(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 72c601d240d4..d4472143dea0 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -1671,6 +1671,7 @@ static int __clone_blkaddrs(struct inode *src_inode, struct inode *dst_inode,
 		} else {
 			struct folio *fsrc, *fdst;
 			size_t src_off, dst_off;
+			pgoff_t dst_fidx = f2fs_lblk_to_folio_index(sbi, dst + i);
 			bool same_folio;
 
 			fsrc = f2fs_get_lock_data_folio(src_inode,
@@ -1683,11 +1684,11 @@ static int __clone_blkaddrs(struct inode *src_inode, struct inode *dst_inode,
 
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
 
@@ -1795,30 +1796,30 @@ static int f2fs_do_collapse(struct inode *inode, loff_t offset, loff_t len)
 {
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
 	struct f2fs_lock_context lc;
-	pgoff_t nrpages = F2FS_BLK_ALIGN(sbi, i_size_read(inode));
+	pgoff_t nrblocks = F2FS_BLK_ALIGN(sbi, i_size_read(inode));
 	pgoff_t start = F2FS_BYTES_TO_BLK(sbi, offset);
 	pgoff_t end = F2FS_BYTES_TO_BLK(sbi, offset + len);
 	int ret;
 
-	f2fs_balance_fs(sbi, true);
-
-	/* avoid gc operation during block exchange */
-	f2fs_down_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
-	filemap_invalidate_lock(inode->i_mapping);
+	/*
+	 * Write back under invalidate_lock, which blocks page_mkwrite, so
+	 * that truncate_pagecache() below cannot drop a racing mmap store to
+	 * the blocks before @offset in the head folio.
+	 */
+	ret = filemap_write_and_wait_range(inode->i_mapping,
+					   round_down(offset, PAGE_SIZE), LLONG_MAX);
+	if (ret)
+		return ret;
 
 	ret = f2fs_zero_post_eof_page(inode, offset + len, false, false);
 	if (ret)
-		goto out_unlock;
+		return ret;
 
 	f2fs_lock_op(sbi, &lc);
 	f2fs_drop_extent_tree(inode);
-	truncate_pagecache(inode, offset);
-	ret = __exchange_data_block(inode, inode, end, start, nrpages - end, true);
+	truncate_pagecache(inode, round_down(offset, PAGE_SIZE));
+	ret = __exchange_data_block(inode, inode, end, start, nrblocks - end, true);
 	f2fs_unlock_op(sbi, &lc);
-
-out_unlock:
-	filemap_invalidate_unlock(inode->i_mapping);
-	f2fs_up_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
 	return ret;
 }
 
@@ -1839,28 +1840,35 @@ static int f2fs_collapse_range(struct inode *inode, loff_t offset, loff_t len)
 	if (ret)
 		return ret;
 
-	/* write out all dirty pages from offset */
-	ret = filemap_write_and_wait_range(inode->i_mapping, offset, LLONG_MAX);
-	if (ret)
-		return ret;
+	f2fs_balance_fs(F2FS_I_SB(inode), true);
+
+	/*
+	 * Avoid GC during the block exchange, and keep both locks until the
+	 * moved blocks are written back and the page cache is dropped. Until
+	 * then, it holds the old data of the source blocks, which neither
+	 * page_mkwrite nor GC may write back.
+	 */
+	f2fs_down_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
+	filemap_invalidate_lock(inode->i_mapping);
 
 	ret = f2fs_do_collapse(inode, offset, len);
 	if (ret)
-		return ret;
+		goto out_unlock;
 
 	/* write out all moved pages, if possible */
-	filemap_invalidate_lock(inode->i_mapping);
-	ret = filemap_write_and_wait_range(inode->i_mapping, offset, LLONG_MAX);
+	ret = filemap_write_and_wait_range(inode->i_mapping,
+					   round_down(offset, PAGE_SIZE), LLONG_MAX);
 	if (ret)
 		goto out_unlock;
-	truncate_pagecache(inode, offset);
+	truncate_pagecache(inode, round_down(offset, PAGE_SIZE));
 
 	new_size = i_size_read(inode) - len;
 	ret = f2fs_truncate_blocks(inode, new_size, true);
-out_unlock:
-	filemap_invalidate_unlock(inode->i_mapping);
 	if (!ret)
 		f2fs_i_size_write(inode, new_size);
+out_unlock:
+	filemap_invalidate_unlock(inode->i_mapping);
+	f2fs_up_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
 	return ret;
 }
 
@@ -2040,7 +2048,7 @@ static int f2fs_insert_range(struct inode *inode, loff_t offset, loff_t len)
 {
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
 	struct address_space *mapping = inode->i_mapping;
-	pgoff_t nr, pg_start, pg_end, delta, idx;
+	pgoff_t nr, blk_start, blk_end, delta, idx;
 	loff_t new_size;
 	int ret = 0;
 
@@ -2053,8 +2061,8 @@ static int f2fs_insert_range(struct inode *inode, loff_t offset, loff_t len)
 		return -EINVAL;
 
 	/* insert range should be aligned to block size of f2fs. */
-	if (offset & F2FS_BLKSIZE_MASK(F2FS_I_SB(inode)) ||
-	    len & F2FS_BLKSIZE_MASK(F2FS_I_SB(inode)))
+	if (offset & F2FS_BLKSIZE_MASK(sbi) ||
+	    len & F2FS_BLKSIZE_MASK(sbi))
 		return -EINVAL;
 
 	ret = f2fs_convert_inline_inode(inode);
@@ -2069,29 +2077,34 @@ static int f2fs_insert_range(struct inode *inode, loff_t offset, loff_t len)
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
@@ -2103,20 +2116,23 @@ static int f2fs_insert_range(struct inode *inode, loff_t offset, loff_t len)
 					idx + delta, nr, false);
 		f2fs_unlock_op(sbi, &lc);
 	}
-out_unlock:
-	filemap_invalidate_unlock(mapping);
-	f2fs_up_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
 	if (ret)
-		return ret;
+		goto out_unlock;
 
-	/* write out all moved pages, if possible */
-	filemap_invalidate_lock(mapping);
-	ret = filemap_write_and_wait_range(mapping, offset, LLONG_MAX);
-	truncate_pagecache(inode, offset);
-	filemap_invalidate_unlock(mapping);
+	/*
+	 * Write out all moved pages, if possible. Keep both locks until the
+	 * page cache is dropped. Until then, it holds the old data of the
+	 * source blocks, which neither page_mkwrite nor GC may write back.
+	 */
+	ret = filemap_write_and_wait_range(mapping,
+					   round_down(offset, PAGE_SIZE), LLONG_MAX);
+	truncate_pagecache(inode, round_down(offset, PAGE_SIZE));
 
 	if (!ret)
 		f2fs_i_size_write(inode, new_size);
+out_unlock:
+	filemap_invalidate_unlock(mapping);
+	f2fs_up_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
 	return ret;
 }
 
@@ -2298,8 +2314,7 @@ static long f2fs_fallocate(struct file *file, int mode,
 	}
 
 	if (f2fs_has_subpage_blocks(F2FS_I_SB(inode))) {
-		if ((mode & (FALLOC_FL_COLLAPSE_RANGE | FALLOC_FL_INSERT_RANGE)) ||
-		    f2fs_is_atomic_file(inode) || f2fs_compressed_file(inode)) {
+		if (f2fs_is_atomic_file(inode) || f2fs_compressed_file(inode)) {
 			ret = -EOPNOTSUPP;
 			goto out;
 		}
-- 
2.56.0.611.g1030f0b940-goog



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
