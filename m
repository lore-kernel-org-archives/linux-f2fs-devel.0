Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC4BB606A897
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 16 Nov 2026 04:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=PMQeXgKV;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=PyZuTfUf;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=GAbGS7AQ;
	dkim=neutral header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FxobociM
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:List-Owner;
	bh=vR4yp3vTtW1VrQrUY5d5rcHUqUjblsWQGtgA/Q4IjJA=; b=PMQeXgKVUKY4ZshMNLymbRYp37
	vWNGyOu8O3HOCTrfmrFDBkXHEUPkLs5rnFR4lmHCZ/7h7mcMxq315O2W4GiJ2y+ajZR9LOZFYBY0+
	S/xfkzxWMb/zRS1N3oCnonCt4Uoi4Zr3jsIB/xLCfZrKlIod9hr+kaOYkE1KfREujN0Q=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xSo1u-000000007rC-2doS;
	Mon, 16 Nov 2026 04:09:18 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <daeho43@gmail.com>) id 1xSo1s-000000007qz-1uak
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 16 Nov 2026 04:09:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=TVesT5WTeyuZfbJVWZqEGh6jf17QAW5DDHWc+a+BLbM=; b=PyZuTfUfxCwSOBwfnDbaSS4+Zj
 p4ZLcB9TwI6bvOtujGspLHy3oRnIDbfqKT6sm3qjdjuEEhZtnGMFkGDBwl9U7HmTKCPYO0Q0Jbkw2
 AntnSkH7NHO6Wh4J0VlAj7bHY9ZoUgZ6RTMIS6q7ockQOXzwJ09I7+HYhTExuWZHnrJU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=TVesT5WTeyuZfbJVWZqEGh6jf17QAW5DDHWc+a+BLbM=; b=GAbGS7AQqlKlQeobyDtZd1PbuN
 VPRcklFsYfyWIa5Xvhkp28VWVwTf4TgxPrWcF/zGiiJia+Ya8EgXHpmrOx7X6F547c6S5j9DP8Vp7
 uVAvom9wcNmUYKVQLuaAmEYTsILLEOuYtzStzveY6ecIA+eeEquMuotZaVk5fFVL/pZM=;
Received: from mail-pj1-f43.google.com ([209.85.216.43])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xSo1r-000000007c3-0Og7
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 16 Nov 2026 04:09:16 +0000
Received: by mail-pj1-f43.google.com with SMTP id
 98e67ed59e1d1-3b16896b8ceso1330308a91.1
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Sun, 15 Nov 2026 20:09:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794802149; x=1795406949; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=TVesT5WTeyuZfbJVWZqEGh6jf17QAW5DDHWc+a+BLbM=;
 b=FxobociMa3ADbnp/DBKDjcrekQoxbW/vDsGSX22+MzSYwAPzhWVucF73WmfWU5zn2I
 mgO80TxqH5QNiBjsm2hz1huIA8akZh4NT572FT7KJydCm3hVNTF20a1oHlYWCfhOoaWd
 wv9JxL29/fqo+5npmCXoGmB3tuZWYefmEiegAMAvcUjm2WZMaTVlZC5VVQFlg5VvkX2t
 ZciXST032f8AgbINjDqUjiCVSroNu3MTI13J/fGkwSwL1+UJ7sHEf2QK3foMJ1z906o8
 JaFnLKE/Ojr0kCAE+Mtp7/SV1wJFPVHRtcN1xFOjEYfiowWDpd5Gw+m0n37YhLxcR/1M
 AXxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794802149; x=1795406949;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=TVesT5WTeyuZfbJVWZqEGh6jf17QAW5DDHWc+a+BLbM=;
 b=kn7Gwl5FfJj9xS3M8vaauexM9c9Xfq9MIv4FgGLnZoKow+BfNWwTH2P1yqZfe5zOtp
 mQXOE1p9Vxue0m86cvowQznEZtsSkxwrAPiCRdLlv/0fqWpjVpZGn1kFJCs1elUA13GL
 MA5tRv2S8UtDyUIT++OCwVy7BQhcIt7+sJjgVZB1w8/0K8M5h0CDunUvUrxD/e1DRIBa
 X0yCp6t6IH79fLhq412hqhc5JRRnMPOJoySeqftt7E+4So80fNt1CLir2Eaz2lcOu8bx
 G0jPAZDJ1SGGSyoKrR01OpgKQmlrTpaCjqx5UMbcewSnB/hEszf9wU7FF4PRw8fpx4D6
 ulvA==
X-Forwarded-Encrypted: i=1;
 AL+hErHmbaYAYds8I/gNRMd0KH8+cN5196aU92/ZNBLvITnvA9cKNjCHTrfmhtVFsEPu2810dEE9hgqPbGYBJcS820gG@lists.sourceforge.net
X-Gm-Message-State: APuU4Z8RJBtHW1CuIuz1DjD8N/xWqBrOSCVlLlaa/BZPhDHQaTZZ1kGa
 XTRVdX8u+9BC09Zdy2jRhPUXSl1WjYqhNi7OPofHFivVePKokxpT3oHgEjauZA==
X-Gm-Gg: AYBFou3dtsPeUaiThXKoYbNkdXbtIKsjMNVjyg6bvLFITxpjek/HZ6lHuAEDFpvw17H
 K5WZRxZXVvqLvDdXRnVdJPzNyhpROkATH8BawxapyQQD0RWpTZuYwDahH3oUSrUOKLFV3h1cgPB
 SvRMUuaC2xwt975ul8JsgQPbqWL2AI7QmDogyqfMYclXc4lP+liWAJcNbFFxn7szHvTgN0USfoB
 odXd4WVppcEBUyAcYxEAqV1EhdoXLiPob7KzWhh+g7uW41Y7GuxsvxLua8KTXXGIopG3tZjcmPi
 NkgBUmpRryxj+KQJSJnr+/ZXr67CeMBaq0RHhd5IwmUHUGlYdkKHG6UvoqdUqoXHhHrrakFhYsr
 zrATb+NnBM/Dy0Dw9lezic/o/EEbAAC5nZBJxGoOzGldu+zxRoTVmFQqj1Z9Xs2lIL8z7n4uEdZ
 0zBoZ9rBt+VfrS2l2L+Zxks2vsI0CLpuoY08gF1FsTWMluxN2HT7UrmAHqGkv6HfJlVNLh0HeKF
 9+wGUoH0d/dJJnzazrlUcG0CeII9pBbN0/dlM8FQYhCk6ZwNOvBwTzjnnA+UlLRKlgvM5AZyqkG
 KLmNanix1kutvEF/ff9VLM6j+wdFSA7Ln+TTZVLj9pmFnShaa2jOoleHmtrbVwaa62ikY04Xst3
 GBYerqNSqbbF8Hyl5G4723ZxdmW3gIq3QD+X3AIKhD6iDp7j2hUd811Idp+yD3GqvGecdow==
X-Received: by 2002:a17:90b:4f85:b0:3b0:91ce:6720 with SMTP id
 98e67ed59e1d1-3b1b0a1ef3emr8572099a91.30.1794802149076; 
 Sun, 15 Nov 2026 20:09:09 -0800 (PST)
Received: from f2fs-test.c.googlers.com.com
 (193.67.125.34.bc.googleusercontent.com. [34.125.67.193])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b1b3f09b92sm7191989a91.4.2026.11.15.20.09.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Nov 2026 20:09:08 -0800 (PST)
From: Daeho Jeong <daeho43@gmail.com>
To: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 kernel-team@android.com
Date: Sun, 15 Nov 2026 20:08:36 -0800
Message-ID: <20261116040851.2849696-6-daeho43@gmail.com>
X-Mailer: git-send-email 2.56.0.611.g1030f0b940-goog
In-Reply-To: <20261116040851.2849696-1-daeho43@gmail.com>
References: <20261116040851.2849696-1-daeho43@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: 1.1 (+)
X-Headers-End: 1xSo1r-000000007c3-0Og7
Subject: [f2fs-dev] [PATCH v2 05/20] f2fs: convert inode dirty page counters
 to dirty block counters
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

The per-inode dirty counter is compared against block based thresholds
such as min_fsync_blocks and BLKS_PER_SEG, and it already holds blocks:
its helpers take page counts and convert them. Rename it to
dirty_blocks and make the helpers take block counts, and convert to
pages where a counter is compared with page based values. The
conversions are no-ops when the block size equals PAGE_SIZE.

The callers that account one block for a folio are left as they are,
which is still correct when the block size equals PAGE_SIZE. Later
patches convert them.

Signed-off-by: Daeho Jeong <daehojeong@google.com>
---
 fs/f2fs/checkpoint.c |  4 ++--
 fs/f2fs/data.c       | 13 +++++++------
 fs/f2fs/f2fs.h       | 36 +++++++++++++++++-------------------
 fs/f2fs/file.c       | 16 ++++++++--------
 fs/f2fs/inode.c      |  2 +-
 fs/f2fs/node.c       |  3 ++-
 fs/f2fs/super.c      |  2 +-
 7 files changed, 38 insertions(+), 38 deletions(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index 158d97fc349a..1060ee651756 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -1316,7 +1316,7 @@ static void __remove_dirty_inode(struct inode *inode, enum inode_type type)
 {
 	int flag = (type == DIR_INODE) ? FI_DIRTY_DIR : FI_DIRTY_FILE;
 
-	if (get_dirty_pages(inode) || !is_inode_flag_set(inode, flag))
+	if (get_dirty_blocks(inode) || !is_inode_flag_set(inode, flag))
 		return;
 
 	list_del_init(&F2FS_I(inode)->dirty_list);
@@ -1325,7 +1325,7 @@ static void __remove_dirty_inode(struct inode *inode, enum inode_type type)
 }
 
 /*
- * Account @nr dirty pages (negative when dirtiness is cleared) for @inode.
+ * Account @nr dirty blocks (negative when dirtiness is cleared) for @inode.
  */
 void f2fs_account_dirty_blocks(struct inode *inode, int nr)
 {
diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index b913d53e96e7..ffa2233d66f2 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -4279,7 +4279,7 @@ static int f2fs_write_cache_pages(struct address_space *mapping,
 
 	folio_batch_init(&fbatch);
 
-	if (get_dirty_pages(mapping->host) <=
+	if (get_dirty_blocks(mapping->host) <=
 				SM_I(F2FS_M_SB(mapping))->min_hot_blocks)
 		set_inode_flag(mapping->host, FI_HOT_DATA);
 	else
@@ -4524,7 +4524,7 @@ static int f2fs_write_cache_folios(struct address_space *mapping,
 	bool op_locked = false;
 	bool retry = false;
 
-	if (get_dirty_pages(inode) <= SM_I(sbi)->min_hot_blocks)
+	if (get_dirty_blocks(inode) <= SM_I(sbi)->min_hot_blocks)
 		set_inode_flag(inode, FI_HOT_DATA);
 	else
 		clear_inode_flag(inode, FI_HOT_DATA);
@@ -4788,7 +4788,7 @@ static inline bool __should_serialize_io(struct inode *inode,
 		return true;
 	if (wbc->sync_mode != WB_SYNC_ALL)
 		return true;
-	if (get_dirty_pages(inode) >= SM_I(F2FS_I_SB(inode))->min_seq_blocks)
+	if (get_dirty_blocks(inode) >= SM_I(F2FS_I_SB(inode))->min_seq_blocks)
 		return true;
 	return false;
 }
@@ -4827,7 +4827,7 @@ static int __f2fs_write_data_pages(struct address_space *mapping,
 	bool locked = false;
 
 	/* skip writing if there is no dirty page in this inode */
-	if (!get_dirty_pages(inode) && wbc->sync_mode == WB_SYNC_NONE)
+	if (!get_dirty_blocks(inode) && wbc->sync_mode == WB_SYNC_NONE)
 		return 0;
 
 	/* during POR, we don't need to trigger writepage at all. */
@@ -4836,7 +4836,7 @@ static int __f2fs_write_data_pages(struct address_space *mapping,
 
 	if ((S_ISDIR(inode->i_mode) || IS_NOQUOTA(inode)) &&
 			wbc->sync_mode == WB_SYNC_NONE &&
-			get_dirty_pages(inode) < nr_caches_to_skip(sbi, DATA) &&
+			get_dirty_blocks(inode) < nr_caches_to_skip(sbi, DATA) &&
 			f2fs_available_free_memory(sbi, DIRTY_DENTS))
 		goto skip_write;
 
@@ -4895,7 +4895,8 @@ static int __f2fs_write_data_pages(struct address_space *mapping,
 	return ret;
 
 skip_write:
-	wbc->pages_skipped += get_dirty_pages(inode);
+	wbc->pages_skipped += get_dirty_blocks(inode) >>
+					F2FS_LOG_BLKS_PER_PAGE(sbi);
 	update_skipped_write(sbi, wbc);
 	trace_f2fs_writepages(mapping->host, wbc, DATA);
 	return 0;
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 876407cbdbb5..9cf9583a4428 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -957,7 +957,7 @@ struct f2fs_inode_info {
 	unsigned long flags[BITS_TO_LONGS(FI_MAX)];	/* use to pass per-file flags */
 	unsigned int ioprio_hint;	/* hint for IO priority */
 	struct f2fs_rwsem i_sem;	/* protect fi info */
-	atomic_t dirty_pages;		/* # of dirty pages */
+	atomic_t dirty_blocks;		/* # of dirty blocks */
 	f2fs_hash_t chash;		/* hash value of given file name */
 	unsigned int clevel;		/* maximum level of given file name */
 	struct task_struct *task;	/* lookup and create consistency */
@@ -2336,6 +2336,8 @@ static inline unsigned int f2fs_blocks_per_folio(struct f2fs_sb_info *sbi,
 	return F2FS_BYTES_TO_BLK(sbi, folio_size(folio));
 }
 
+#define F2FS_LOG_BLKS_PER_PAGE(sbi)	(PAGE_SHIFT - (sbi)->log_blocksize)
+
 static inline bool f2fs_has_subpage_blocks(struct f2fs_sb_info *sbi)
 {
 	return F2FS_BLKSIZE(sbi) < PAGE_SIZE;
@@ -2979,40 +2981,36 @@ static inline void dec_cache_count(struct f2fs_sb_info *sbi, int count_type)
 	sub_cache_counts(sbi, count_type, 1);
 }
 
-/*
- * Account @nr dirty pages for @inode; one page is
- * (PAGE_SIZE >> log_blocksize) filesystem blocks.
- */
-static inline void inode_add_dirty_blocks(struct inode *inode, int nr)
+static inline void inode_add_dirty_blocks(struct inode *inode,
+					  unsigned int nr_blocks)
 {
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
-	int blocks = nr * (PAGE_SIZE >> sbi->log_blocksize);
 
-	atomic_add(blocks, &F2FS_I(inode)->dirty_pages);
+	atomic_add(nr_blocks, &F2FS_I(inode)->dirty_blocks);
 	if (S_ISDIR(inode->i_mode))
-		add_cache_counts(sbi, F2FS_DIRTY_DENTS, blocks);
+		add_cache_counts(sbi, F2FS_DIRTY_DENTS, nr_blocks);
 	else
-		add_cache_counts(sbi, F2FS_DIRTY_DATA, blocks);
+		add_cache_counts(sbi, F2FS_DIRTY_DATA, nr_blocks);
 	if (IS_NOQUOTA(inode))
-		add_cache_counts(sbi, F2FS_DIRTY_QDATA, blocks);
+		add_cache_counts(sbi, F2FS_DIRTY_QDATA, nr_blocks);
 }
 
-static inline void inode_sub_dirty_blocks(struct inode *inode, int nr)
+static inline void inode_sub_dirty_blocks(struct inode *inode,
+					  unsigned int nr_blocks)
 {
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
-	int blocks = nr * (PAGE_SIZE >> sbi->log_blocksize);
 
 	if (!S_ISDIR(inode->i_mode) && !S_ISREG(inode->i_mode) &&
 			!S_ISLNK(inode->i_mode))
 		return;
 
-	atomic_sub(blocks, &F2FS_I(inode)->dirty_pages);
+	atomic_sub(nr_blocks, &F2FS_I(inode)->dirty_blocks);
 	if (S_ISDIR(inode->i_mode))
-		sub_cache_counts(sbi, F2FS_DIRTY_DENTS, blocks);
+		sub_cache_counts(sbi, F2FS_DIRTY_DENTS, nr_blocks);
 	else
-		sub_cache_counts(sbi, F2FS_DIRTY_DATA, blocks);
+		sub_cache_counts(sbi, F2FS_DIRTY_DATA, nr_blocks);
 	if (IS_NOQUOTA(inode))
-		sub_cache_counts(sbi, F2FS_DIRTY_QDATA, blocks);
+		sub_cache_counts(sbi, F2FS_DIRTY_QDATA, nr_blocks);
 }
 
 static inline void inode_inc_dirty_block(struct inode *inode)
@@ -3052,9 +3050,9 @@ static inline s64 get_nr_caches(struct f2fs_sb_info *sbi, int count_type)
 	return atomic_read(&sbi->nr_caches[count_type]);
 }
 
-static inline int get_dirty_pages(struct inode *inode)
+static inline int get_dirty_blocks(struct inode *inode)
 {
-	return atomic_read(&F2FS_I(inode)->dirty_pages);
+	return atomic_read(&F2FS_I(inode)->dirty_blocks);
 }
 
 static inline int get_blocktype_secs(struct f2fs_sb_info *sbi, int block_type)
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 28fccc735a39..e0d246397ad0 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -376,7 +376,7 @@ static int f2fs_do_sync_file(struct file *file, loff_t start, loff_t end,
 		goto go_write;
 
 	/* if fdatasync is triggered, let's do in-place-update */
-	if (datasync || get_dirty_pages(inode) <= SM_I(sbi)->min_fsync_blocks)
+	if (datasync || get_dirty_blocks(inode) <= SM_I(sbi)->min_fsync_blocks)
 		set_inode_flag(inode, FI_NEED_IPU);
 	ret = file_write_and_wait_range(file, start, end);
 	clear_inode_flag(inode, FI_NEED_IPU);
@@ -2495,9 +2495,9 @@ static int f2fs_ioc_start_atomic_write(struct file *filp, bool truncate)
 	 * Should wait end_io to count F2FS_WB_CP_DATA correctly by
 	 * f2fs_is_atomic_file.
 	 */
-	if (get_dirty_pages(inode))
-		f2fs_warn(sbi, "Unexpected flush for atomic writes: ino=%llu, npages=%u",
-			  inode->i_ino, get_dirty_pages(inode));
+	if (get_dirty_blocks(inode))
+		f2fs_warn(sbi, "Unexpected flush for atomic writes: ino=%llu, nblocks=%u",
+			  inode->i_ino, get_dirty_blocks(inode));
 	ret = filemap_write_and_wait_range(inode->i_mapping, 0, LLONG_MAX);
 	if (ret)
 		goto out_unlock;
@@ -2519,7 +2519,7 @@ static int f2fs_ioc_start_atomic_write(struct file *filp, bool truncate)
 		F2FS_I(fi->cow_inode)->atomic_inode = inode;
 	} else {
 		/* Reuse the already created COW inode */
-		f2fs_bug_on(sbi, get_dirty_pages(fi->cow_inode));
+		f2fs_bug_on(sbi, get_dirty_blocks(fi->cow_inode));
 
 		invalidate_mapping_pages(fi->cow_inode->i_mapping, 0, -1);
 
@@ -4877,7 +4877,7 @@ static int f2fs_ioc_set_compress_option(struct file *filp, unsigned long arg)
 		goto out;
 	}
 
-	if (f2fs_is_mmap_file(inode) || get_dirty_pages(inode)) {
+	if (f2fs_is_mmap_file(inode) || get_dirty_blocks(inode)) {
 		ret = -EBUSY;
 		goto out;
 	}
@@ -5033,7 +5033,7 @@ static int f2fs_ioc_decompress_file(struct file *filp)
 		if (ret < 0)
 			break;
 
-		if (get_dirty_pages(inode) >= BLKS_PER_SEG(sbi)) {
+		if (get_dirty_blocks(inode) >= BLKS_PER_SEG(sbi)) {
 			ret = filemap_fdatawrite(inode->i_mapping);
 			if (ret < 0)
 				break;
@@ -5123,7 +5123,7 @@ static int f2fs_ioc_compress_file(struct file *filp)
 		if (ret < 0)
 			break;
 
-		if (get_dirty_pages(inode) >= BLKS_PER_SEG(sbi)) {
+		if (get_dirty_blocks(inode) >= BLKS_PER_SEG(sbi)) {
 			ret = filemap_fdatawrite(inode->i_mapping);
 			if (ret < 0)
 				break;
diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
index f5a4dac98ef2..5c6a64b31b05 100644
--- a/fs/f2fs/inode.c
+++ b/fs/f2fs/inode.c
@@ -872,7 +872,7 @@ static void f2fs_pre_evict_inode(struct inode *inode)
 	    test_opt(sbi, COMPRESS_CACHE) && f2fs_compressed_file(inode))
 		f2fs_invalidate_compress_pages(sbi, inode->i_ino);
 
-	f2fs_bug_on(sbi, get_dirty_pages(inode));
+	f2fs_bug_on(sbi, get_dirty_blocks(inode));
 	f2fs_remove_dirty_inode(inode);
 	f2fs_remove_donate_inode(inode);
 
diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index e53871f32c35..cb8affb2c1e0 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -85,7 +85,8 @@ bool f2fs_available_free_memory(struct f2fs_sb_info *sbi, int type)
 	} else if (type == DIRTY_DENTS) {
 		if (bdi_wb_dirty_exceeded(sbi->sb->s_bdi))
 			return false;
-		mem_size = get_nr_caches(sbi, F2FS_DIRTY_DENTS);
+		mem_size = get_nr_caches(sbi, F2FS_DIRTY_DENTS) >>
+					F2FS_LOG_BLKS_PER_PAGE(sbi);
 		res = mem_size < ((avail_ram * nm_i->ram_thresh / 100) >> 1);
 	} else if (type == INO_ENTRIES) {
 		int i;
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index f17bae198fe5..9b01ead00edc 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -1855,7 +1855,7 @@ static struct inode *f2fs_alloc_inode(struct super_block *sb)
 	init_once((void *) fi);
 
 	/* Initialize f2fs-specific inode info */
-	atomic_set(&fi->dirty_pages, 0);
+	atomic_set(&fi->dirty_blocks, 0);
 	atomic_set(&fi->i_compr_blocks, 0);
 	atomic_set(&fi->open_count, 0);
 	atomic_set(&fi->writeback, 0);
-- 
2.56.0.611.g1030f0b940-goog



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
