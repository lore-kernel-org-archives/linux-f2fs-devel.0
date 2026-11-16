Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B7F0606A33A
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 16 Nov 2026 04:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=VpCjM3wv;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=Qr4v492m;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=j/zhqnjQ;
	dkim=neutral header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RT1BPGPL
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:List-Owner;
	bh=GvN+g0HIDduA42KQ0qu0hi+5u7DjPQTjaShCw+UHSU8=; b=VpCjM3wvAmLigXGx7ycC1bgbIA
	HNg0yPqA05ET3p51ymNk2KepgCm2smG1DNCEILyOeKDDcQ0CmgDYPMXddyHB07abk1v/NczHKJuCY
	GXthq+pnsijaPfxNOm8hYWnitnFZ6m82nnwj85kZ4372QX2yN+w70JhMlnyEYKsK5f7Y=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xSo1r-000000006aM-2f1y;
	Mon, 16 Nov 2026 04:09:15 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <daeho43@gmail.com>) id 1xSo1q-000000006a2-2uqd
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 16 Nov 2026 04:09:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=jSfzEhwYtpo35rXzygaFWpN3gGzRX/jUUWEO+v3bhfI=; b=Qr4v492mCmM00weeebuvPFiLHo
 G9QGJzoWFhNymeKFvnEoma7MDj9rz1dhp9jrQ0wJsURoUv0rQ4xvJbaeBNAhbBF4qCqAb+9ijDCiH
 zF+2k8ZFwclOtXJHGsAbDjCCQGCQJmxv1pXDs0kEZehrRgqjjCCJnb6yrduXc1XruVvA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=jSfzEhwYtpo35rXzygaFWpN3gGzRX/jUUWEO+v3bhfI=; b=j/zhqnjQrpha7N5HQ/Rk+1P5k3
 EzDN6QFo/UGoZxVmC+/aAavHFf5GFskQFTlNGcyv6BwbfVtahoiFfAQ6lJgjGw+Wf2pDMJTwAAkr2
 +S3yPBwbl3pAer6BBRCG0epbTiLIiHh1DUigW1j5yY75ApWXUpGFKKzE+qZtpEhywYhg=;
Received: from mail-pl1-f170.google.com ([209.85.214.170])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xSo1p-000000005fs-1f0S
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 16 Nov 2026 04:09:14 +0000
Received: by mail-pl1-f170.google.com with SMTP id
 d9443c01a7336-2e9d7791b00so29930715ad.0
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Sun, 15 Nov 2026 20:09:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794802148; x=1795406948; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=jSfzEhwYtpo35rXzygaFWpN3gGzRX/jUUWEO+v3bhfI=;
 b=RT1BPGPLwiTlFXr392ptpift8IeNGgaat9tk/o0n3Z+zm8hjmjZ/2N7T1/bODmgQLu
 ED0pGtPNbz5PMwxyKiE/5DOK5+qIOvMEtZA9yQzvGfong+jg+phX7QrTYIobplGMK/te
 vrWYlAFOSPckkfETbW8Y5QS03+DCcnCD+rvmzJREgHcudpX7sACaR15BDtZIgEUoRyF2
 Up6NakrRNbo5VRNK4iEl/AiaF+6CAUMssKaBgVQhburlUlEJp1T9CYmEI58pEbFsHAFJ
 6YJxRFGQYPWbTpaJ10z9Cru6czqFxDfy8k/o0ZiHdG0QSUIuyAGyDKoBRbtnQ1/+i+Oj
 EmJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794802148; x=1795406948;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=jSfzEhwYtpo35rXzygaFWpN3gGzRX/jUUWEO+v3bhfI=;
 b=IjMwEd3sWqsuRE5NLPQIjvHQYJmIHDIxEvKL/M+xPUKa7uWWk/utXtzLOen4n7mSle
 +BEB5GEGWF90fPYy0L0JuTliUZRfONFsSCSuz6ZF6C+kQ4V+wgzsIg0GSuhFxCALlPLt
 ndPx3C9hyoJb1NnTUK4eGGwWxm08FKVzTMZmmyq9epwDJ3VxSCIdJ5sXi9BDTMCXC8+s
 Zohrx7dAWnKOKAXwgQ29En25W6RaibFwn5qHS+bkb9ZJf8Z7EqZp7DiMOgDkdGcg8UP1
 1/WWaTW/zdU3qD4W6vw/sb8irSX8yFJTdsJB42WrTWw0UlZqC1kU3mao+sjy3WO302qh
 tuBg==
X-Forwarded-Encrypted: i=1;
 AL+hErEA72WPcRytoJXxdoIEmBpvdWFhlQ7kI/Kgyr0zFNp1c5snCRELL3kkwEnbL4YjVVMrlT0IbuYubKjwWGaSsCTB@lists.sourceforge.net
X-Gm-Message-State: APuU4Z9WdIom2Eh0sxpQQtlLPOSA0H7gq5AuuS/5+yXY0ecHcLB1A+kE
 nsmqKOKHlWoPCpeORCS5o9z/wIzHBt8yqWayH6fnobXnWDtHDOItZSCa
X-Gm-Gg: AYBFou0IbLkE7ANoU5YtK643VwQWh3u+cXLRoWrpcugA8yihB5gOXrqJBbbJf3fGaj3
 O8XLgTxMG4wqSSK5mDAFHtvdVouX74LJEPAPA04erOUNy/Fkj4W7f7nEQxv2ZVpYCnCZ09dsn04
 l5fBO6iAwq/cC3TzJzy4S+PkctylnQisucxv7vr6EHSVB1TJzp5svZaQbrSsr1nLmBTCkyv1s2z
 uTZOiNKijzFq6wg1k38KfUm0coFit06BYaqvHah7vfJF/mPeFSWFZPA8pcEA+TORtYnSKkmGYDT
 OGhu8w3BL/4lDS9jSo3aAgSiNeXAqI/xcX6W4WMyexI2h9e3jhwUWiD2wP423wEpqHZJLiDqlKm
 m1cbDTwXw/AJlL8R5yifV5b9NirenPDfEtt1WsE3stgDcWu0Qv9+y4o7KpP4gUKpzZFSm3AJ3DE
 KB6zQXdcMSQgNtV0fFchzvx2Cd0KwEFyPnyLNzWhDgH6Cv/tEo1xvF/V8ctG0AU/Eoy1HjkusFb
 DSnBitM66ppBvU9aRQAjs2LEN1Rk5GoAtaH9KX8idZBgpWGyMk53dqyzk89YbQ2o+izz2R742C9
 OK10yo1xLFIcchTymjvnbMKdawwl7+cj+3irVe05mBIVsh3I/P93y+LZRh05NAWUp9LqtrIc53m
 kJM5O2Uo5s2uCx6WsX/I1w/xT8aQO5KGkFKad4D+szFa8gFYSSAG5yT7E/M7A65KK7z7K
X-Received: by 2002:a17:90b:1d45:b0:3a8:a98c:ea07 with SMTP id
 98e67ed59e1d1-3b1b09f3a60mr8656857a91.13.1794802147517; 
 Sun, 15 Nov 2026 20:09:07 -0800 (PST)
Received: from f2fs-test.c.googlers.com.com
 (193.67.125.34.bc.googleusercontent.com. [34.125.67.193])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b1b3f09b92sm7191989a91.4.2026.11.15.20.09.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Nov 2026 20:09:06 -0800 (PST)
From: Daeho Jeong <daeho43@gmail.com>
To: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 kernel-team@android.com
Date: Sun, 15 Nov 2026 20:08:35 -0800
Message-ID: <20261116040851.2849696-5-daeho43@gmail.com>
X-Mailer: git-send-email 2.56.0.611.g1030f0b940-goog
In-Reply-To: <20261116040851.2849696-1-daeho43@gmail.com>
References: <20261116040851.2849696-1-daeho43@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: 1.1 (+)
X-Headers-End: 1xSo1p-000000005fs-1f0S
Subject: [f2fs-dev] [PATCH v2 04/20] f2fs: support subpage blocks in
 directory operations
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

With subpage blocks, a directory folio holds several dentry blocks.
Address a dentry block within its folio by its block index, and mark
only the modified dentry block dirty. When an empty dentry block is
freed, clear only the state of that block and keep the folio dirty if
other blocks in it are still dirty. If no dirty block is left, clear the
gcing flag of the folio too.

Also read the name length in f2fs_delete_entry() under the folio lock,
so that the dentry bitmap is not updated with a value read without it.

Signed-off-by: Daeho Jeong <daehojeong@google.com>
---
 fs/f2fs/dir.c    | 123 +++++++++++++++++++++++++++++++++--------------
 fs/f2fs/f2fs.h   |   2 +
 fs/f2fs/inline.c |   6 +--
 3 files changed, 91 insertions(+), 40 deletions(-)

diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
index a3cc3be88738..91929c250085 100644
--- a/fs/f2fs/dir.c
+++ b/fs/f2fs/dir.c
@@ -37,6 +37,29 @@ static inline bool f2fs_should_fallback_to_linear(struct inode *dir)
 extern struct kmem_cache *f2fs_cf_name_slab;
 #endif
 
+static inline pgoff_t f2fs_dentry_to_lblk(struct f2fs_sb_info *sbi,
+					  struct folio *folio, void *de)
+{
+	return f2fs_folio_lblk(sbi, folio) +
+		F2FS_BYTES_TO_BLK(sbi, de - folio_address(folio));
+}
+
+void f2fs_mark_dentry_folio_dirty(struct inode *dir, struct folio *folio,
+				  pgoff_t bidx)
+{
+	struct f2fs_sb_info *sbi = F2FS_I_SB(dir);
+
+	if (f2fs_has_subpage_blocks(sbi)) {
+		size_t off = f2fs_folio_byte_offset(sbi, folio, bidx);
+
+		f2fs_ffs_mark_subrange_uptodate(folio, off, F2FS_BLKSIZE(sbi));
+		f2fs_ffs_mark_subrange_dirty(folio, off, F2FS_BLKSIZE(sbi));
+	} else if (!folio_test_uptodate(folio)) {
+		folio_mark_uptodate(folio);
+	}
+	folio_mark_dirty(folio);
+}
+
 static unsigned long dir_blocks(struct inode *inode)
 {
 	return F2FS_BLK_ALIGN(F2FS_I_SB(inode), i_size_read(inode));
@@ -189,15 +212,16 @@ static unsigned long dir_block_index(unsigned int level,
 }
 
 static struct f2fs_dir_entry *find_in_block(struct inode *dir,
-				struct folio *dentry_folio,
+				struct folio *dentry_folio, pgoff_t bidx,
 				const struct f2fs_filename *fname,
 				int *max_slots,
 				bool use_hash)
 {
+	struct f2fs_sb_info *sbi = F2FS_I_SB(dir);
 	void *dentry_blk;
 	struct f2fs_dentry_ptr d;
 
-	dentry_blk = folio_address(dentry_folio);
+	dentry_blk = f2fs_folio_lblk_address(sbi, dentry_folio, bidx);
 
 	make_dentry_ptr_block(dir, &d, dentry_blk);
 	return f2fs_find_target_dentry(&d, fname, max_slots, use_hash);
@@ -288,7 +312,7 @@ static struct f2fs_dir_entry *find_in_level(struct inode *dir,
 	unsigned int nbucket, nblock;
 	unsigned int bidx, end_block, bucket_no;
 	struct f2fs_dir_entry *de = NULL;
-	pgoff_t next_pgofs;
+	pgoff_t next_blkofs;
 	bool room = false;
 	int max_slots;
 
@@ -305,11 +329,11 @@ static struct f2fs_dir_entry *find_in_level(struct inode *dir,
 	while (bidx < end_block) {
 		/* no need to allocate new dentry pages to all the indices */
 		struct folio *dentry_folio;
-		dentry_folio = f2fs_find_data_folio(dir, bidx, &next_pgofs);
+		dentry_folio = f2fs_find_data_folio(dir, bidx, &next_blkofs);
 		if (IS_ERR(dentry_folio)) {
 			if (PTR_ERR(dentry_folio) == -ENOENT) {
 				room = true;
-				bidx = next_pgofs;
+				bidx = next_blkofs;
 				continue;
 			} else {
 				*dentry_block = dentry_folio;
@@ -317,7 +341,8 @@ static struct f2fs_dir_entry *find_in_level(struct inode *dir,
 			}
 		}
 
-		de = find_in_block(dir, dentry_folio, fname, &max_slots, use_hash);
+		de = find_in_block(dir, dentry_folio, bidx, fname, &max_slots,
+				   use_hash);
 		if (IS_ERR(de)) {
 			f2fs_folio_put(dentry_folio, false);
 			*dentry_block = ERR_CAST(de);
@@ -353,7 +378,7 @@ struct f2fs_dir_entry *__f2fs_find_entry(struct inode *dir,
 					 const struct f2fs_filename *fname,
 					 void **dentry_block)
 {
-	unsigned long npages = dir_blocks(dir);
+	unsigned long nblocks = dir_blocks(dir);
 	struct f2fs_dir_entry *de = NULL;
 	unsigned int max_depth;
 	unsigned int level;
@@ -369,7 +394,7 @@ struct f2fs_dir_entry *__f2fs_find_entry(struct inode *dir,
 		goto out;
 	}
 
-	if (npages == 0)
+	if (nblocks == 0)
 		goto out;
 
 	max_depth = F2FS_I(dir)->i_current_depth;
@@ -467,7 +492,8 @@ void f2fs_set_link(struct inode *dir, struct f2fs_dir_entry *de,
 		f2fs_folio_wait_writeback(folio, true, true);
 		de->ino = cpu_to_le32(inode->i_ino);
 		de->file_type = fs_umode_to_ftype(inode->i_mode);
-		folio_mark_dirty(folio);
+		f2fs_mark_dentry_folio_dirty(dir, folio,
+				f2fs_dentry_to_lblk(F2FS_I_SB(dir), folio, de));
 	}
 
 	inode_set_mtime_to_ts(dir, inode_set_ctime_current(dir));
@@ -538,12 +564,12 @@ static int make_empty_dir(struct inode *inode,
 	if (IS_ERR(dentry_folio))
 		return PTR_ERR(dentry_folio);
 
-	dentry_blk = folio_address(dentry_folio);
+	dentry_blk = f2fs_folio_lblk_address(F2FS_I_SB(inode), dentry_folio, 0);
 
 	make_dentry_ptr_block(inode, &d, dentry_blk);
 	f2fs_do_make_empty_dir(inode, parent, &d);
 
-	folio_mark_dirty(dentry_folio);
+	f2fs_mark_dentry_folio_dirty(inode, dentry_folio, 0);
 	f2fs_folio_put(dentry_folio, true);
 	return 0;
 }
@@ -736,7 +762,8 @@ int f2fs_add_regular_entry(struct inode *dir, const struct f2fs_filename *fname,
 		if (IS_ERR(dentry_folio))
 			return PTR_ERR(dentry_folio);
 
-		dentry_blk = folio_address(dentry_folio);
+		dentry_blk = f2fs_folio_lblk_address(F2FS_I_SB(dir),
+						     dentry_folio, block);
 		make_dentry_ptr_block(dir, &d, dentry_blk);
 		bit_pos = f2fs_room_for_filename(d.bitmap, slots, d.max);
 		if (bit_pos < d.max)
@@ -763,7 +790,7 @@ int f2fs_add_regular_entry(struct inode *dir, const struct f2fs_filename *fname,
 	f2fs_update_dentry(ino, mode, &d, &fname->disk_name, fname->hash,
 			   bit_pos);
 
-	folio_mark_dirty(dentry_folio);
+	f2fs_mark_dentry_folio_dirty(dir, dentry_folio, block);
 
 	if (inode) {
 		f2fs_i_pino_write(inode, dir->i_ino);
@@ -900,26 +927,29 @@ void f2fs_delete_entry(struct f2fs_dir_entry *dentry, void *dentry_block,
 	struct f2fs_dentry_ptr d;
 	struct folio *folio;
 	unsigned int bit_pos;
-	int slots = GET_DENTRY_SLOTS(le16_to_cpu(dentry->name_len));
+	int slots;
+	struct f2fs_sb_info *sbi = F2FS_I_SB(dir);
 	pgoff_t index;
 	int i;
 
-	f2fs_update_time(F2FS_I_SB(dir), REQ_TIME);
+	f2fs_update_time(sbi, REQ_TIME);
 
-	if (F2FS_OPTION(F2FS_I_SB(dir)).fsync_mode == FSYNC_MODE_STRICT)
-		f2fs_add_ino_entry(F2FS_I_SB(dir), dir->i_ino, TRANS_DIR_INO);
+	if (F2FS_OPTION(sbi).fsync_mode == FSYNC_MODE_STRICT)
+		f2fs_add_ino_entry(sbi, dir->i_ino, TRANS_DIR_INO);
 
 	if (f2fs_has_inline_dentry(dir))
 		return f2fs_delete_inline_entry(dentry,
 				f2fs_dentry_cache(dentry_block), dir, inode);
 
 	folio = f2fs_dentry_folio(dentry_block);
-	index = folio->index;
 
 	folio_lock(folio);
 	f2fs_folio_wait_writeback(folio, true, true);
 
-	dentry_blk = folio_address(folio);
+	/* Read the dentry under the folio lock. */
+	slots = GET_DENTRY_SLOTS(le16_to_cpu(dentry->name_len));
+	index = f2fs_dentry_to_lblk(sbi, folio, dentry);
+	dentry_blk = f2fs_folio_lblk_address(sbi, folio, index);
 	make_dentry_ptr_block(dir, &d, dentry_blk);
 	bit_pos = dentry - d.dentry;
 	for (i = 0; i < slots; i++)
@@ -927,18 +957,34 @@ void f2fs_delete_entry(struct f2fs_dir_entry *dentry, void *dentry_block,
 
 	/* Let's check and deallocate this dentry page */
 	bit_pos = find_next_bit_le(d.bitmap, d.max, 0);
-	folio_mark_dirty(folio);
+	f2fs_mark_dentry_folio_dirty(dir, folio, index);
 
 	if (bit_pos == d.max &&
 	    !f2fs_truncate_hole(dir, index, index + 1)) {
+		if (f2fs_has_subpage_blocks(sbi)) {
+			size_t off = f2fs_folio_byte_offset(sbi, folio, index);
+			bool dirty;
+
+			dirty = f2fs_ffs_clear_subrange_dirty_and_test(folio,
+					off, F2FS_BLKSIZE(sbi));
+			f2fs_ffs_clear_subrange_uptodate(folio, off,
+							 F2FS_BLKSIZE(sbi));
+			if (dirty)
+				goto keep_dirty;
+			/* No dirty block is left to be written for GC. */
+			folio_clear_f2fs_gcing(folio);
+		}
 		f2fs_clear_page_cache_dirty_tag(folio);
 		folio_clear_dirty_for_io(folio);
-		folio_clear_uptodate(folio);
-		folio_detach_private(folio);
+		if (!f2fs_has_subpage_blocks(sbi)) {
+			folio_clear_uptodate(folio);
+			folio_detach_private(folio);
+			inode_dec_dirty_block(dir);
+		}
 
-		inode_dec_dirty_block(dir);
 		f2fs_remove_dirty_inode(dir);
 	}
+keep_dirty:
 	f2fs_folio_put(folio, true);
 
 	inode_set_mtime_to_ts(dir, inode_set_ctime_current(dir));
@@ -960,20 +1006,21 @@ bool f2fs_empty_dir(struct inode *dir)
 		return f2fs_empty_inline_dir(dir);
 
 	while (bidx < nblock) {
-		pgoff_t next_pgofs;
+		pgoff_t next_blkofs;
 		struct folio *dentry_folio;
 
-		dentry_folio = f2fs_find_data_folio(dir, bidx, &next_pgofs);
+		dentry_folio = f2fs_find_data_folio(dir, bidx, &next_blkofs);
 		if (IS_ERR(dentry_folio)) {
 			if (PTR_ERR(dentry_folio) == -ENOENT) {
-				bidx = next_pgofs;
+				bidx = next_blkofs;
 				continue;
 			} else {
 				return false;
 			}
 		}
 
-		dentry_blk = folio_address(dentry_folio);
+		dentry_blk = f2fs_folio_lblk_address(F2FS_I_SB(dir),
+						     dentry_folio, bidx);
 		make_dentry_ptr_block(dir, &d, dentry_blk);
 		if (bidx == 0)
 			bit_pos = 2;
@@ -1079,7 +1126,7 @@ int f2fs_fill_dentries(struct dir_context *ctx, struct f2fs_dentry_ptr *d,
 static int f2fs_readdir(struct file *file, struct dir_context *ctx)
 {
 	struct inode *inode = file_inode(file);
-	unsigned long npages = dir_blocks(inode);
+	unsigned long nblocks = dir_blocks(inode);
 	void *dentry_blk = NULL;
 	struct file_ra_state *ra = &file->f_ra;
 	loff_t start_pos = ctx->pos;
@@ -1088,6 +1135,8 @@ static int f2fs_readdir(struct file *file, struct dir_context *ctx)
 	unsigned int n = (unsigned long)ctx->pos / entries;
 	struct f2fs_dentry_ptr d;
 	struct fscrypt_str fstr = FSTR_INIT(NULL, 0);
+	pgoff_t f_last = nblocks ? f2fs_lblk_to_folio_index(sbi, nblocks - 1) : 0;
+	pgoff_t f_index, ra_pages;
 	int err = 0;
 
 	if (IS_ENCRYPTED(inode)) {
@@ -1105,9 +1154,9 @@ static int f2fs_readdir(struct file *file, struct dir_context *ctx)
 		goto out_free;
 	}
 
-	for (; n < npages; ctx->pos = n * entries) {
+	for (; n < nblocks; ctx->pos = n * entries) {
 		struct folio *dentry_folio;
-		pgoff_t next_pgofs;
+		pgoff_t next_blkofs;
 
 		/* allow readdir() to be interrupted */
 		if (fatal_signal_pending(current)) {
@@ -1117,23 +1166,25 @@ static int f2fs_readdir(struct file *file, struct dir_context *ctx)
 		cond_resched();
 
 		/* readahead for multi pages of dir */
-		if (npages - n > 1 && !ra_has_index(ra, n))
-			page_cache_sync_readahead(inode->i_mapping, ra, file, n,
-				min(npages - n, (pgoff_t)MAX_DIR_RA_PAGES));
+		f_index = f2fs_lblk_to_folio_index(sbi, n);
+		ra_pages = f_last - f_index + 1;
+		if (nblocks - n > 1 && !ra_has_index(ra, f_index))
+			page_cache_sync_readahead(inode->i_mapping, ra, file, f_index,
+				min(ra_pages, (pgoff_t)MAX_DIR_RA_PAGES));
 
-		dentry_folio = f2fs_find_data_folio(inode, n, &next_pgofs);
+		dentry_folio = f2fs_find_data_folio(inode, n, &next_blkofs);
 		if (IS_ERR(dentry_folio)) {
 			err = PTR_ERR(dentry_folio);
 			if (err == -ENOENT) {
 				err = 0;
-				n = next_pgofs;
+				n = next_blkofs;
 				continue;
 			} else {
 				goto out_free;
 			}
 		}
 
-		dentry_blk = folio_address(dentry_folio);
+		dentry_blk = f2fs_folio_lblk_address(sbi, dentry_folio, n);
 
 		make_dentry_ptr_block(inode, &d, dentry_blk);
 
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 249c962434b5..876407cbdbb5 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -4193,6 +4193,8 @@ void f2fs_delete_entry(struct f2fs_dir_entry *dentry, void *dentry_blk,
 int f2fs_do_tmpfile(struct inode *inode, struct inode *dir,
 					struct f2fs_filename *fname);
 bool f2fs_empty_dir(struct inode *dir);
+void f2fs_mark_dentry_folio_dirty(struct inode *dir, struct folio *folio,
+				  pgoff_t bidx);
 
 static inline int f2fs_add_link(struct dentry *dentry, struct inode *inode)
 {
diff --git a/fs/f2fs/inline.c b/fs/f2fs/inline.c
index 49905aa08418..ba0aff8e5643 100644
--- a/fs/f2fs/inline.c
+++ b/fs/f2fs/inline.c
@@ -463,10 +463,6 @@ static int f2fs_move_inline_dirents(struct inode *dir,
 	memcpy(dst.dentry, src.dentry, SIZE_OF_DIR_ENTRY * src.max);
 	memcpy(dst.filename, src.filename, src.max * F2FS_SLOT_LEN);
 
-	if (!folio_test_uptodate(folio))
-		folio_mark_uptodate(folio);
-	folio_mark_dirty(folio);
-
 	/* clear inline dir and flag after data writeback */
 	f2fs_truncate_inline_inode(dir, ientry, 0);
 
@@ -484,6 +480,8 @@ static int f2fs_move_inline_dirents(struct inode *dir,
 	f2fs_i_depth_write(dir, 1);
 	if (i_size_read(dir) < F2FS_BLKSIZE(F2FS_I_SB(dir)))
 		f2fs_i_size_write(dir, F2FS_BLKSIZE(F2FS_I_SB(dir)));
+
+	f2fs_mark_dentry_folio_dirty(dir, folio, 0);
 out:
 	f2fs_folio_put(folio, true);
 	return err;
-- 
2.56.0.611.g1030f0b940-goog



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
