Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CDFD606A33D
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 16 Nov 2026 04:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=PuHkK0j7;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=T3eRMCyq;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=QjzU+DbF;
	dkim=neutral header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=n9t14MiI
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:List-Owner;
	bh=LleE2Sz4eQyEkoJAmc18NhSjlUGbZHEEgRY7LLvIU3o=; b=PuHkK0j7EOmz8P1RLWVGg9GCLA
	LN4CPQG5TGf80xDq2L5PIct1TuveIbiCkCTEC0lHJKJ7/oZVVTwPfqz5C2aVIgPHBq/jfz/rRvepV
	MwfQPK6HVz3KBxruPCznxVJyYdTcLv5ZRb4JE1Lk2vtLm9uYmBqeH8A38bPO6NmVBoyI=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xSo1r-000000006aE-1yUu;
	Mon, 16 Nov 2026 04:09:15 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <daeho43@gmail.com>) id 1xSo1i-000000006Zg-3tfK
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 16 Nov 2026 04:09:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=HHGzdMvP7cENbSof2g/6E89KuzOsStt6jRYxwHA+WjE=; b=T3eRMCyqbX9oAWUsHxd0ahBAOg
 TwwEgtRaqMu3WFUoHwHYyMuqPNefgdwleW/x0PIxQ57ZsjTQqVJ0tDzMJaGP3Hq+6RhiIdhs7L1IP
 2y4BOQM08HRGuCjgFDlnTCnDEHgX+dKs8MDvYwL2SvzholrIaJG7dYPC4MLMZbrEhK4A=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=HHGzdMvP7cENbSof2g/6E89KuzOsStt6jRYxwHA+WjE=; b=QjzU+DbFhgxZZMVuB5Q54n4EG2
 6SFdmoZKgQI9QBb5or52XBPTvCjOs13gaihwBs7PZOwy6ipt4NvMgvplUwh8j64+8ikuG8M7GrQ5e
 A5h9nsox52Og2LJ/G4NJCvNTbE+cgmFrXu8HyY2zGzhYUKCfDsPGEmc2DbKHSof6W3Lg=;
Received: from mail-pg1-f170.google.com ([209.85.215.170])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xSo1i-000000007bq-0hq9
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 16 Nov 2026 04:09:06 +0000
Received: by mail-pg1-f170.google.com with SMTP id
 41be03b00d2f7-ccca948203aso1287708a12.3
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Sun, 15 Nov 2026 20:09:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794802140; x=1795406940; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=HHGzdMvP7cENbSof2g/6E89KuzOsStt6jRYxwHA+WjE=;
 b=n9t14MiIwj4WLtybauJSZJ06ZYpogcrUQgqN7ZLV4q7x0NDJw+wxInbbnr+U0oMEBa
 0r6oPq9Y35OeLcs5B+LKcE4n2zSinE/gn4LSntBbH77eKu9/qIjxSF8dp+uTWlBa/hrn
 mqSXspvophjkGY+a+xMnxB2kkEzKS5/YbU/cHI19EEwwaCaKBmUVvBO52Mu9SJP5BnYD
 QAVIOal0WDkFXMxZQc/6kJjNkCbttIcMHc5cM8gL2rK5he1SPIdK6rR9rFoMrtfAR4a8
 7YR/YsJvYvaTOP4zVVgJ9ngc/07q265XsLRiFr8v2O93DgoEcWHK3rNbrjPITZeCEF5A
 ESGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794802140; x=1795406940;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=HHGzdMvP7cENbSof2g/6E89KuzOsStt6jRYxwHA+WjE=;
 b=CCs7CFNS1X/ibs+zdLjvPDrS+vbxOtJlEuTa7QW3VFxBExqLQkVtGrCAOLk5JLxRQY
 jp6TO+/RbnHLVPuz1d+xYmH+ou678Y/mOlStu5TK664ErIsXszTyIQPCr9hmIdgykkyn
 PTpYdpcLGLCOPkxpuXVCqLHY3MqeDvYtp8Re5ITtawNE5BWEU95vKU7KhTvdJ/pYC3mv
 7C9oNhOUa9ATvggTush5K3lMOzgeHB/c0FhvPRkhhWYTKrQAv4mgqQ3uUcAlxEkIbSpa
 jLHypQR2zEbhwu5hWi/qwaF20jNqMZXHU1t2HMnLsOA0iMbWkoinXgz3UmtnHuaRh/do
 hLkA==
X-Forwarded-Encrypted: i=1;
 AL+hErGZfzCiE9ofthj3eZZEk0MZJRQdsJ9P4IJmHXFKAJF8sOCk8ixKfA0V+DPC9X+49M+oq3EeZEh/DlWu2KxOq76l@lists.sourceforge.net
X-Gm-Message-State: APuU4Z8p8xjXuzfbTrge9WKX1k2UCyqPvc2ubB9vWCsJZRh6eT7xCw3G
 FF6M3pNaJVdmC1L7VCdURrM8dDwBE7Xleyyv1sDH/rvfVYr/QV5aGD75IoMYhg==
X-Gm-Gg: AYBFou2M3ly92FEa1XEuJkunFwvVrlovkhmhy1/FYy+X6mpTaAVHAxKe7NEc1BmWipW
 8Vctg/Y8G4Kt69k/OfbzJY7sO99SGzkyYt4h8egg3FXY2nq/POW2sFC6101m732aWNWoXuNbWP2
 QI7aDo70Nf41GmwCAyqHQjaolRTVZiF2T9JVE1m2QnaNjqJUtmSPyVZ/42rdAd9yCJhErbyCdEE
 OqxBlGbSY/Y8VOXBV8OtCTMejKu18Hs8op9ipfqhjpXXi03eDavjYHSxp2lkjqodeXEOdmZknVy
 uaicrUJPFzxov5lE+johfDWxhQNj2oSmLJYH5iVYno8cp+NmmD9NJtvh0VWFx+ydGkLAIMoHvz/
 tHjaTiy3PgiWqtjPMAOnBm2AcAxUpIrehecHHMAybg8YG/ZkBj+Fg8LEAYZgawkvJEMcSQohi4/
 NexdiW34a8VLZjNhe/QiSJUVJjJBlSPSsOCLtMBBOMhkUY7Nk+A5KPUwddJRIn8b+vE1AkdxjXx
 4yTtyjtTje4lSDPpPwJdqZQ9Zs3l87j99XBFknU6KsYuREFRYV/cbMXyZPQn4mhqYauif0ujLGV
 Mf9JukGvBpSStZqXZEkXkRFiAvT1mZKdXXaPt0Jlo2i8/WJYImJsjXJ+IzAVuL4nOa0LJZkw3oc
 p4n9KhirWhhvdAwNZbZDPCPbrO7yJ0KDnhMe8fln+7RO3Whc=
X-Received: by 2002:a17:90b:54cb:b0:3b0:ac2c:1619 with SMTP id
 98e67ed59e1d1-3b1b0a5064cmr8588325a91.39.1794802140306; 
 Sun, 15 Nov 2026 20:09:00 -0800 (PST)
Received: from f2fs-test.c.googlers.com.com
 (193.67.125.34.bc.googleusercontent.com. [34.125.67.193])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b1b3f09b92sm7191989a91.4.2026.11.15.20.08.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Nov 2026 20:08:59 -0800 (PST)
From: Daeho Jeong <daeho43@gmail.com>
To: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 kernel-team@android.com
Date: Sun, 15 Nov 2026 20:08:32 -0800
Message-ID: <20261116040851.2849696-2-daeho43@gmail.com>
X-Mailer: git-send-email 2.56.0.611.g1030f0b940-goog
In-Reply-To: <20261116040851.2849696-1-daeho43@gmail.com>
References: <20261116040851.2849696-1-daeho43@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: 1.1 (+)
X-Headers-End: 1xSo1i-000000007bq-0hq9
Subject: [f2fs-dev] [PATCH v2 01/20] f2fs: use block-based index and size
 calculations in more paths
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

Several paths still convert between file offsets and block indices with
PAGE_SHIFT or PAGE_SIZE, assuming that a page holds exactly one
filesystem block. Use the F2FS_BLK_* helpers there so that they stay
correct when the block size is smaller than PAGE_SIZE.

No functional change when the block size equals PAGE_SIZE, except on
32-bit architectures: __complete_revoke_list() now computes the
truncation offset and __clone_blkaddrs() the new i_size in 64 bits, so
that they no longer overflow beyond 4GB.

Signed-off-by: Daeho Jeong <daehojeong@google.com>
---
 fs/f2fs/data.c    |  5 +++--
 fs/f2fs/dir.c     |  3 +--
 fs/f2fs/file.c    | 50 +++++++++++++++++++++++------------------------
 fs/f2fs/segment.c |  5 +++--
 4 files changed, 32 insertions(+), 31 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 4ae61138a003..aacc92839f61 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -1897,8 +1897,9 @@ struct folio *f2fs_get_new_data_folio(struct inode *inode,
 	}
 got_it:
 	if (new_i_size && i_size_read(inode) <
-				((loff_t)(index + 1) << PAGE_SHIFT))
-		f2fs_i_size_write(inode, ((loff_t)(index + 1) << PAGE_SHIFT));
+				F2FS_BLK_TO_BYTES(F2FS_I_SB(inode), index + 1))
+		f2fs_i_size_write(inode,
+				F2FS_BLK_TO_BYTES(F2FS_I_SB(inode), index + 1));
 	return folio;
 }
 
diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
index 70847313ca6a..a3cc3be88738 100644
--- a/fs/f2fs/dir.c
+++ b/fs/f2fs/dir.c
@@ -39,8 +39,7 @@ extern struct kmem_cache *f2fs_cf_name_slab;
 
 static unsigned long dir_blocks(struct inode *inode)
 {
-	return ((unsigned long long) (i_size_read(inode) + PAGE_SIZE - 1))
-							>> PAGE_SHIFT;
+	return F2FS_BLK_ALIGN(F2FS_I_SB(inode), i_size_read(inode));
 }
 
 static unsigned int dir_buckets(unsigned int level, int dir_level)
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 05061254c3b2..f8a444064ec8 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -1543,7 +1543,7 @@ static int __clone_blkaddrs(struct inode *src_inode, struct inode *dst_inode,
 		if (do_replace[i] || blkaddr[i] == NULL_ADDR) {
 			struct dnode_of_data dn;
 			struct node_info ni;
-			size_t new_size;
+			loff_t new_size;
 			pgoff_t ilen;
 
 			set_new_dnode(&dn, dst_inode, NULL, NULL, 0);
@@ -1576,7 +1576,7 @@ static int __clone_blkaddrs(struct inode *src_inode, struct inode *dst_inode,
 				}
 				dn.ofs_in_node++;
 				i++;
-				new_size = (loff_t)(dst + i) << PAGE_SHIFT;
+				new_size = F2FS_BLK_TO_BYTES(sbi, dst + i);
 				if (dst_inode->i_size < new_size)
 					f2fs_i_size_write(dst_inode, new_size);
 			} while (--ilen && (do_replace[i] || blkaddr[i] == NULL_ADDR));
@@ -1593,7 +1593,7 @@ static int __clone_blkaddrs(struct inode *src_inode, struct inode *dst_inode,
 				return PTR_ERR(fsrc);
 
 			src_off = offset_in_folio(fsrc,
-						(loff_t)(src + i) << PAGE_SHIFT);
+						F2FS_BLK_TO_BYTES(sbi, src + i));
 
 			/*
 			 * For same-inode operations (collapse/insert), src and
@@ -1623,10 +1623,10 @@ static int __clone_blkaddrs(struct inode *src_inode, struct inode *dst_inode,
 			}
 
 			dst_off = offset_in_folio(fdst,
-					(loff_t)(dst + i) << PAGE_SHIFT);
+					F2FS_BLK_TO_BYTES(sbi, dst + i));
 			f2fs_folio_wait_writeback(fdst, true, true);
 			memcpy_folio(fdst, dst_off, fsrc, src_off,
-				    PAGE_SIZE);
+				    F2FS_BLKSIZE(sbi));
 			if (folio_test_large(fdst)) {
 				if (!f2fs_ffs_find_or_alloc(fdst)) {
 					f2fs_folio_put(fdst, true);
@@ -1635,15 +1635,15 @@ static int __clone_blkaddrs(struct inode *src_inode, struct inode *dst_inode,
 					return -ENOMEM;
 				}
 				f2fs_ffs_mark_subrange_uptodate(fdst,
-							dst_off, PAGE_SIZE);
+						dst_off, F2FS_BLKSIZE(sbi));
 				f2fs_ffs_mark_subrange_dirty(fdst, dst_off,
-							    PAGE_SIZE);
+						F2FS_BLKSIZE(sbi));
 			}
 			folio_mark_dirty(fdst);
 			if (same_folio && i_size_read(dst_inode) <
-			    ((loff_t)(dst + i + 1) << PAGE_SHIFT))
+			    F2FS_BLK_TO_BYTES(sbi, dst + i + 1))
 				f2fs_i_size_write(dst_inode,
-					((loff_t)(dst + i + 1) << PAGE_SHIFT));
+					F2FS_BLK_TO_BYTES(sbi, dst + i + 1));
 			folio_set_f2fs_gcing(fdst);
 			f2fs_folio_put(fdst, true);
 			if (!same_folio)
@@ -1715,9 +1715,9 @@ static int f2fs_do_collapse(struct inode *inode, loff_t offset, loff_t len)
 {
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
 	struct f2fs_lock_context lc;
-	pgoff_t nrpages = DIV_ROUND_UP(i_size_read(inode), PAGE_SIZE);
-	pgoff_t start = offset >> PAGE_SHIFT;
-	pgoff_t end = (offset + len) >> PAGE_SHIFT;
+	pgoff_t nrpages = F2FS_BLK_ALIGN(sbi, i_size_read(inode));
+	pgoff_t start = F2FS_BYTES_TO_BLK(sbi, offset);
+	pgoff_t end = F2FS_BYTES_TO_BLK(sbi, offset + len);
 	int ret;
 
 	f2fs_balance_fs(sbi, true);
@@ -1988,10 +1988,10 @@ static int f2fs_insert_range(struct inode *inode, loff_t offset, loff_t len)
 	if (ret)
 		return ret;
 
-	pg_start = offset >> PAGE_SHIFT;
-	pg_end = (offset + len) >> PAGE_SHIFT;
+	pg_start = F2FS_BYTES_TO_BLK(sbi, offset);
+	pg_end = F2FS_BYTES_TO_BLK(sbi, offset + len);
 	delta = pg_end - pg_start;
-	idx = DIV_ROUND_UP(i_size_read(inode), PAGE_SIZE);
+	idx = F2FS_BLK_ALIGN(sbi, i_size_read(inode));
 
 	/* avoid gc operation during block exchange */
 	f2fs_down_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
@@ -3104,10 +3104,10 @@ static int f2fs_defragment_range(struct f2fs_sb_info *sbi,
 	f2fs_balance_fs(sbi, true);
 
 	inode_lock(inode);
-	pg_start = range->start >> PAGE_SHIFT;
+	pg_start = F2FS_BYTES_TO_BLK(sbi, range->start);
 	pg_end = min_t(pgoff_t,
-				(range->start + range->len) >> PAGE_SHIFT,
-				DIV_ROUND_UP(i_size_read(inode), PAGE_SIZE));
+				F2FS_BYTES_TO_BLK(sbi, range->start + range->len),
+				F2FS_BLK_ALIGN(sbi, i_size_read(inode)));
 
 	if (is_inode_flag_set(inode, FI_COMPRESS_RELEASED) ||
 		f2fs_is_atomic_file(inode)) {
@@ -3124,8 +3124,8 @@ static int f2fs_defragment_range(struct f2fs_sb_info *sbi,
 
 	/* writeback all dirty pages in the range */
 	err = filemap_write_and_wait_range(inode->i_mapping,
-						(loff_t)pg_start << PAGE_SHIFT,
-						((loff_t)pg_end << PAGE_SHIFT) - 1);
+						F2FS_BLK_TO_BYTES(sbi, pg_start),
+						F2FS_BLK_TO_BYTES(sbi, pg_end) - 1);
 	if (err)
 		goto out;
 
@@ -3249,7 +3249,7 @@ static int f2fs_defragment_range(struct f2fs_sb_info *sbi,
 unlock_out:
 	inode_unlock(inode);
 	if (!err) {
-		range->len = (u64)total << PAGE_SHIFT;
+		range->len = F2FS_BLK_TO_BYTES(sbi, total);
 		stat_inc_defrag_blk_count(sbi, total);
 	}
 	return err;
@@ -4354,7 +4354,7 @@ static int f2fs_release_compress_blocks(struct file *filp, unsigned long arg)
 	f2fs_down_write(&fi->i_gc_rwsem[WRITE]);
 	filemap_invalidate_lock(inode->i_mapping);
 
-	last_idx = DIV_ROUND_UP(i_size_read(inode), PAGE_SIZE);
+	last_idx = F2FS_BLK_ALIGN(sbi, i_size_read(inode));
 
 	while (page_idx < last_idx) {
 		struct dnode_of_data dn;
@@ -4532,7 +4532,7 @@ static int f2fs_reserve_compress_blocks(struct file *filp, unsigned long arg)
 	f2fs_down_write(&fi->i_gc_rwsem[WRITE]);
 	filemap_invalidate_lock(inode->i_mapping);
 
-	last_idx = DIV_ROUND_UP(i_size_read(inode), PAGE_SIZE);
+	last_idx = F2FS_BLK_ALIGN(sbi, i_size_read(inode));
 
 	while (page_idx < last_idx) {
 		struct dnode_of_data dn;
@@ -4997,7 +4997,7 @@ static int f2fs_ioc_decompress_file(struct file *filp)
 	if (!atomic_read(&fi->i_compr_blocks))
 		goto out;
 
-	last_idx = DIV_ROUND_UP(i_size_read(inode), PAGE_SIZE);
+	last_idx = F2FS_BLK_ALIGN(sbi, i_size_read(inode));
 	last_idx >>= fi->i_log_cluster_size;
 
 	for (cluster_idx = 0; cluster_idx < last_idx; cluster_idx++) {
@@ -5084,7 +5084,7 @@ static int f2fs_ioc_compress_file(struct file *filp)
 
 	set_inode_flag(inode, FI_ENABLE_COMPRESS);
 
-	last_idx = DIV_ROUND_UP(i_size_read(inode), PAGE_SIZE);
+	last_idx = F2FS_BLK_ALIGN(sbi, i_size_read(inode));
 	last_idx >>= fi->i_log_cluster_size;
 
 	for (cluster_idx = 0; cluster_idx < last_idx; cluster_idx++) {
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 31ac93a93021..2b0821c2c18b 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -285,6 +285,7 @@ static int __replace_atomic_write_block(struct inode *inode, pgoff_t index,
 static void __complete_revoke_list(struct inode *inode, struct list_head *head,
 					bool revoke)
 {
+	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
 	struct revoke_entry *cur, *tmp;
 	pgoff_t start_index = 0;
 	bool truncate = is_inode_flag_set(inode, FI_ATOMIC_REPLACE);
@@ -303,7 +304,7 @@ static void __complete_revoke_list(struct inode *inode, struct list_head *head,
 	}
 
 	if (!revoke && truncate)
-		f2fs_do_truncate_blocks(inode, start_index * PAGE_SIZE, false);
+		f2fs_do_truncate_blocks(inode, F2FS_BLK_TO_BYTES(sbi, start_index), false);
 }
 
 static int __f2fs_commit_atomic_write(struct inode *inode)
@@ -315,7 +316,7 @@ static int __f2fs_commit_atomic_write(struct inode *inode)
 	struct list_head revoke_list;
 	block_t blkaddr;
 	struct dnode_of_data dn;
-	pgoff_t len = DIV_ROUND_UP(i_size_read(inode), PAGE_SIZE);
+	pgoff_t len = F2FS_BLK_ALIGN(sbi, i_size_read(inode));
 	pgoff_t off = 0, blen, index;
 	int ret = 0, i;
 
-- 
2.56.0.611.g1030f0b940-goog



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
