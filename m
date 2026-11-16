Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EF8F606A32F
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 16 Nov 2026 04:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=dY1LwEP0;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=WkY/wxjV;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=hM7gVPvM;
	dkim=neutral header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZSS93pEn
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:List-Owner;
	bh=P+mxYUz4lfG84YtrN/wEFaRsTb1+benzBPCmS05mLRw=; b=dY1LwEP0txiLxwhHKZLezusaGA
	wKOylYqR5qkvsK7JhDAGdvFUP/ShPpirG7tsEildLlDxg4qMw5iaUSt8ZZV6TcSxrgsnZtA+YfdxP
	9GZPDnDgC+XeLKzNFPLzB8fPnTCf4YG86djz8JRyM/7Voo60ELWmH7fWGUpp84CLznCA=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xSo25-000000005AZ-3ZoN;
	Mon, 16 Nov 2026 04:09:29 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <daeho43@gmail.com>) id 1xSo23-000000005AK-3s4v
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 16 Nov 2026 04:09:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=AagTsPzwbD5V/tglpT6GiLpcgGuWwXDYr1AaQKIS/jI=; b=WkY/wxjVPuWvo3c9ol6fI67xp0
 JnFqYSNEFM7hnmTFefkzCRLXSQzUJgYu/nlwlF0tx+OTPk7ZDC8c6JIeGshA2Aor0aVM+RJ+xSnNR
 svM0n3X1LzEvBqApm4vxM8EKe/Ni/aga9V6DLphAMx7SQw6S6N9xcO0HpSA49yxZKOvQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=AagTsPzwbD5V/tglpT6GiLpcgGuWwXDYr1AaQKIS/jI=; b=hM7gVPvMNW7Vrv7GTPfRUH2NxL
 zq+GiPghcIZzQV2svl0qQFrdxDVZv5KcWn4RTFwcPVFtNbezl2xz941m0mgKI5Obdig1wYJZ9YYX+
 QPViVjTqEVSFAHhdR8lumqqLcuUvsS3dO6eP4N6461ByA7ZinRKLz++fNWWryAFLvxME=;
Received: from mail-pj1-f54.google.com ([209.85.216.54])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xSo1v-000000005g3-45Ts
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 16 Nov 2026 04:09:27 +0000
Received: by mail-pj1-f54.google.com with SMTP id
 98e67ed59e1d1-3b18717a193so1599592a91.1
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Sun, 15 Nov 2026 20:09:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794802154; x=1795406954; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=AagTsPzwbD5V/tglpT6GiLpcgGuWwXDYr1AaQKIS/jI=;
 b=ZSS93pEnhSYZIlUeHWKxRwj0U+jfifRvNYdLBAeRrIZa2XCaUn3/mJqplekbCag3ds
 M0HgywPMN7pqQ/jvxcmjGRN5s0VZji+8EofbJ9Fd62B3gydKJhFMNsQUSUE2Ul9xD/6x
 JBN0ZIz/R5v0fcPM01Q+hoKFtzBP79lYlZd4dafbNEDiwlyCHPkjdxq/0gNUBHghR1P9
 xjVIH9BY6Irr5DXRjBOHOajTA1HP0uOo5iem7YPWJL6sV1z42paB2uFbTdMWriVThuld
 rNxIYdMJPAGg6fNHvUxzILD9P0IuNIIbucq6YMBdkZwBpoZPtbb7uPWFQBc/PC9gfoj6
 QKGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794802154; x=1795406954;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=AagTsPzwbD5V/tglpT6GiLpcgGuWwXDYr1AaQKIS/jI=;
 b=qd1bM6ci3EkN17ppCvBhXMT/SHJeMb7jY/1xm3GNsJ/QKA8Pbq/rV0xNkQTu1Ep1ff
 Vr9ks9W7KVgc6IuYuCSv7cokXdSUjgy4ge6kpO5jnSTzAxTP+wkuSkjEaMT3SpsbYSIL
 bvAPrK4hyuyAysqhwPLa7vsFiNknVjQnvWoyvo8Z5A0C1gz6k7uqoLihQCga3UowtsN4
 eCW1VqSX+r7UdF38WFiYq8G6sWAzDSAWkUWKcZ6x/n7a19N6e3CNiqJSCHd69lbsxhxS
 0PvQDDN0ousdz2BjJbf09QulEaL1jfml4oQci0QD24lbNqOawWIGvmxBREhWGeUpnDRG
 5Ylw==
X-Forwarded-Encrypted: i=1;
 AL+hErFpd1tqJs3mfsArCSVQ+gMbKLq0aXwYIzrDsitzsZqok33ghx3U0uWJphUHGZHNe7qQebgp3aovOmtEWoOfsaDB@lists.sourceforge.net
X-Gm-Message-State: APuU4Z8ajW0ptoiHcj1Yut1nxP6A2SExccSB2bRoMysJb1RwZ9G0VmWc
 35+tfSGLpjHwmybkcGeRkOUBYWdOxvd7UNarR7bjfxgzXwlptsKpzOZngb3rlw==
X-Gm-Gg: AYBFou1scBA10mEpkUpTVVgCKQSyrM7aXFzRRzSnb0nBHXw/+Tncb+z08706cA3Wy8Z
 PsfTI8KRKGnwF+ICit6MuJSvhJtnnF/OfWi5te3K+uioj1OdjGQllHvnpCRx5XzQ0HCoev+3rVi
 4swX9nhugmEF7yCpj2lL108RYLchuXUW0Mz+cPh6RBizTcl5YTEd8+3lw8y55YhrQ2VpAKUzmAm
 YNXwJkLXfeEisgmLTc945lPBJK1ZwUZKZx0aK5b2vrumc0GORrNwxKBSGfU7ONqVLsXiLfW6B8F
 10TrGqp5TekOpyqRmLcvD2R2+TcknwqQefz5SvV5YF8R2eAApszStE5COMld2QK7bGqHoyb5DLJ
 qBxi3Z7z40HpeI1EpwFTOFBRkSUjowSmwrreBUXHRD4ELGIBfV247mNYZ+aS7ZBEEVgCTSKheHt
 bhlvRvEwZMtDAyTwsj7PBVOnIjf4W7rKIIuMe6m2GCMz++3z4CmveYvLJKnBkOEGHouCiU0J8qw
 5dbhnwqwNrkzTCLNXvpPOS5HFPC1uXgiAs3Rdtljuald7By9ArzJ8aX1jtLKCNq75gR2dTqXB2t
 jHHLlN44bXZS/OL7XMSp5vrbg5GLgNfBeXJYhjciv+fRqcmU8XKOqviXBvMDcrHbgQ+2USRrIS5
 1JsaevkHBFB/gfTkYJelJlPu4nqSUe5vauKSu16hCDxxYmrA=
X-Received: by 2002:a17:90b:1b06:b0:3ac:b44c:2d84 with SMTP id
 98e67ed59e1d1-3b1b0a0e8d1mr9785977a91.13.1794802153913; 
 Sun, 15 Nov 2026 20:09:13 -0800 (PST)
Received: from f2fs-test.c.googlers.com.com
 (193.67.125.34.bc.googleusercontent.com. [34.125.67.193])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b1b3f09b92sm7191989a91.4.2026.11.15.20.09.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Nov 2026 20:09:12 -0800 (PST)
From: Daeho Jeong <daeho43@gmail.com>
To: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 kernel-team@android.com
Date: Sun, 15 Nov 2026 20:08:38 -0800
Message-ID: <20261116040851.2849696-8-daeho43@gmail.com>
X-Mailer: git-send-email 2.56.0.611.g1030f0b940-goog
In-Reply-To: <20261116040851.2849696-1-daeho43@gmail.com>
References: <20261116040851.2849696-1-daeho43@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: 1.1 (+)
X-Headers-End: 1xSo1v-000000005g3-45Ts
Subject: [f2fs-dev] [PATCH v2 07/20] f2fs: support subpage blocks in data
 write path and writeback
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

With blocks smaller than PAGE_SIZE, a folio holds several blocks, so
write_begin, write_end and writeback have to handle individual blocks
instead of the whole folio.

- Read, zero and reserve the blocks touched by a write per block in
  write_begin, and mark only the written blocks dirty in write_end.
- Write back only the dirty blocks of a multi-block folio and complete
  write I/O per block. In subpage mode every inode is written back by
  f2fs_write_cache_folios(), which now handles dentry and quota folios
  and checkpoint errors as f2fs_write_single_data_page() does. Both use
  the new f2fs_cp_controlled_inode() and f2fs_wb_folio_action() helpers
  for these rules.
  It also resets the error for each folio, so that the remaining folios
  are still written back after an error, as writeback_iter() expects
  for integrity writeback, instead of redirtying them.
  f2fs_write_folio_dirty_range() cleans up each block where it is
  written or skipped, and advances last_disk_size only up to the last
  block it submitted. On an error, it clears the dirty state of the
  blocks before the failed one, so that only the failed block and the
  ones after it are written again.
- Count inode dirty blocks from the dirty bits of the folio state, and
  count every block of a folio dirtied without one, e.g. after a read
  of the whole folio or through folio_mark_dirty(). Attaching a folio
  state to a dirty folio converts its count to the dirty bits, so the
  counter stays balanced.
- ->dirty_folio() does not know which blocks were modified, so it marks
  the uptodate blocks of the folio within EOF dirty. Otherwise, a folio
  dirtied by mm after writeback cleared its dirty bits, e.g. through a
  pinned page, is cleaned without being written. The updates made by
  f2fs mark only the blocks they modify and dirty the folio with
  f2fs_folio_mark_dirty(), which keeps the other blocks clean.
- Compressed and atomic files are not supported yet in subpage mode:
  write_begin returns -EOPNOTSUPP for them. Inline data is converted
  first.

Some of these changes also apply to large folios when the block size
equals PAGE_SIZE.

Signed-off-by: Daeho Jeong <daehojeong@google.com>
---
 fs/f2fs/checkpoint.c |  65 ++---
 fs/f2fs/compress.c   |   2 +-
 fs/f2fs/data.c       | 583 ++++++++++++++++++++++++++-----------------
 fs/f2fs/dir.c        |   4 +-
 fs/f2fs/f2fs.h       |   3 +
 fs/f2fs/file.c       |  23 +-
 fs/f2fs/gc.c         |  20 +-
 fs/f2fs/inline.c     |  17 +-
 fs/f2fs/node.c       |  11 +-
 9 files changed, 433 insertions(+), 295 deletions(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index 1060ee651756..05edd76f5a81 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -1324,29 +1324,6 @@ static void __remove_dirty_inode(struct inode *inode, enum inode_type type)
 	stat_dec_dirty_inode(F2FS_I_SB(inode), type);
 }
 
-/*
- * Account @nr dirty blocks (negative when dirtiness is cleared) for @inode.
- */
-void f2fs_account_dirty_blocks(struct inode *inode, int nr)
-{
-	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
-	enum inode_type type = S_ISDIR(inode->i_mode) ? DIR_INODE : FILE_INODE;
-
-	if (!nr)
-		return;
-
-	spin_lock(&sbi->inode_lock[type]);
-	if (nr > 0) {
-		if (type != FILE_INODE || test_opt(sbi, DATA_FLUSH))
-			__add_dirty_inode(inode, type);
-		inode_add_dirty_blocks(inode, nr);
-	} else {
-		inode_sub_dirty_blocks(inode, -nr);
-		__remove_dirty_inode(inode, type);
-	}
-	spin_unlock(&sbi->inode_lock[type]);
-}
-
 void f2fs_update_dirty_folio(struct inode *inode, struct folio *folio)
 {
 	if (!S_ISDIR(inode->i_mode) && !S_ISREG(inode->i_mode) &&
@@ -1354,16 +1331,13 @@ void f2fs_update_dirty_folio(struct inode *inode, struct folio *folio)
 		return;
 
 	/*
-	 * Large folios have a subpage dirty bitmap, so defer their dirty accounting
-	 * to the f2fs_ffs_*subrange_dirty*() helpers.  This avoids nesting
-	 * ffs->state_lock with the inode dirty list lock.
+	 * The dirty blocks of a folio with a folio state are accounted when
+	 * their dirty bits are set. Without it, every block of the folio is
+	 * dirty.
 	 */
-	if (f2fs_folio_has_ffs(folio)) {
-		folio_set_f2fs_reference(folio);
-		return;
-	}
-
-	f2fs_account_dirty_blocks(inode, 1);
+	if (!f2fs_folio_has_ffs(folio))
+		f2fs_account_dirty_blocks(inode,
+			f2fs_blocks_per_folio(F2FS_I_SB(inode), folio));
 
 	folio_set_f2fs_reference(folio);
 }
@@ -1385,6 +1359,33 @@ void f2fs_remove_dirty_inode(struct inode *inode)
 	spin_unlock(&sbi->inode_lock[type]);
 }
 
+/*
+ * Account @nr dirty blocks (negative when they are cleaned) for @inode.
+ */
+void f2fs_account_dirty_blocks(struct inode *inode, int nr)
+{
+	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
+	enum inode_type type = S_ISDIR(inode->i_mode) ? DIR_INODE : FILE_INODE;
+
+	if (!nr)
+		return;
+
+	if (!S_ISDIR(inode->i_mode) && !S_ISREG(inode->i_mode) &&
+			!S_ISLNK(inode->i_mode))
+		return;
+
+	if (nr < 0) {
+		inode_sub_dirty_blocks(inode, -nr);
+		return;
+	}
+
+	spin_lock(&sbi->inode_lock[type]);
+	if (type != FILE_INODE || test_opt(sbi, DATA_FLUSH))
+		__add_dirty_inode(inode, type);
+	inode_add_dirty_blocks(inode, nr);
+	spin_unlock(&sbi->inode_lock[type]);
+}
+
 int f2fs_sync_dirty_inodes(struct f2fs_sb_info *sbi, enum inode_type type,
 						bool from_cp)
 {
diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
index 0b0f31af6626..c63622b6c49a 100644
--- a/fs/f2fs/compress.c
+++ b/fs/f2fs/compress.c
@@ -1090,7 +1090,7 @@ static void set_cluster_dirty(struct compress_ctx *cc)
 		if (!cc->rpages[i])
 			continue;
 		folio = page_folio(cc->rpages[i]);
-		folio_mark_dirty(folio);
+		f2fs_folio_mark_dirty(folio);
 		folio_set_f2fs_gcing(folio);
 	}
 }
diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 971d74d2f010..54b2024ece7b 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -389,7 +389,7 @@ bool f2fs_ffs_has_dirty_subpage(struct folio *folio)
  * clear F2FS_FOLIO_PRIVATE_ONGOING_MIGRATION if no dirty subpage is left,
  * and end writeback if it was started.
  */
-static void f2fs_ffs_put_write_pending(struct folio *folio, unsigned int nr)
+void f2fs_ffs_put_write_pending(struct folio *folio, unsigned int nr)
 {
 	struct f2fs_folio_state *ffs;
 
@@ -420,8 +420,7 @@ static void f2fs_write_end_bio(struct bio *bio)
 
 	bio_for_each_folio_all(fi, bio) {
 		struct folio *folio = fi.folio;
-		unsigned int nr_pages = fi.length >> PAGE_SHIFT;
-		unsigned int npages = nr_pages;
+		unsigned int nr_blocks = F2FS_BYTES_TO_BLK(sbi, fi.length);
 		enum count_type type;
 
 #ifdef CONFIG_F2FS_FS_COMPRESSION
@@ -441,8 +440,7 @@ static void f2fs_write_end_bio(struct bio *bio)
 			}
 		}
 
-		while (nr_pages--)
-			dec_cache_count(sbi, type);
+		sub_cache_counts(sbi, type, nr_blocks);
 
 		/*
 		 * we should access sbi before folio_end_writeback() to
@@ -452,7 +450,7 @@ static void f2fs_write_end_bio(struct bio *bio)
 				wq_has_sleeper(&sbi->cp_wait))
 			wake_up(&sbi->cp_wait);
 
-		f2fs_ffs_put_write_pending(folio, npages);
+		f2fs_ffs_put_write_pending(folio, nr_blocks);
 	}
 
 	bio_put(bio);
@@ -2906,12 +2904,29 @@ int f2fs_read_multi_pages(struct compress_ctx *cc, struct bio **bio_ret,
 }
 #endif
 
+/* The blocks of @folio which can be dirty, i.e. the ones within EOF. */
+static unsigned int f2fs_folio_valid_blocks(struct inode *inode,
+					    struct folio *folio)
+{
+	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
+	unsigned int nr_blocks = f2fs_blocks_per_folio(sbi, folio);
+	pgoff_t last_lblk = F2FS_BLK_ALIGN(sbi, i_size_read(inode));
+	pgoff_t first_lblk = f2fs_folio_lblk(sbi, folio);
+
+	if (f2fs_verity_in_progress(inode))
+		return nr_blocks;
+	if (first_lblk < last_lblk)
+		return min_t(pgoff_t, nr_blocks, last_lblk - first_lblk);
+	return 0;
+}
+
 struct f2fs_folio_state *f2fs_ffs_find_or_alloc(struct folio *folio)
 {
 	struct f2fs_sb_info *sbi = F2FS_F_SB(folio);
 	struct f2fs_folio_state *ffs = folio->private;
 	unsigned int nr_blocks;
 	unsigned long private_flags;
+	int dirty_blocks = 0;
 
 	if (f2fs_folio_has_ffs(folio))
 		return ffs;
@@ -2929,29 +2944,29 @@ struct f2fs_folio_state *f2fs_ffs_find_or_alloc(struct folio *folio)
 	if (folio_test_uptodate(folio))
 		bitmap_set(ffs->state, 0, nr_blocks);
 	if (folio_test_dirty(folio)) {
-		struct inode *inode = folio->mapping->host;
-		pgoff_t last_lblk = F2FS_BLK_ALIGN(sbi, i_size_read(inode));
-		pgoff_t first_lblk = f2fs_folio_lblk(sbi, folio);
-		pgoff_t valid_blocks = 0;
-
-		if (f2fs_verity_in_progress(inode))
-			valid_blocks = nr_blocks;
-		else if (first_lblk < last_lblk)
-			valid_blocks = min_t(pgoff_t, nr_blocks,
-					     last_lblk - first_lblk);
+		unsigned int valid_blocks = f2fs_folio_valid_blocks(
+						folio->mapping->host, folio);
 
 		if (valid_blocks)
 			bitmap_set(ffs->state, nr_blocks, valid_blocks);
+		/*
+		 * A folio dirtied without a folio state was accounted as a
+		 * whole. Its dirty bits are accounted from now on.
+		 */
+		dirty_blocks = (int)valid_blocks - (int)nr_blocks;
 	}
 
 	folio_detach_private(folio);
 	folio_attach_private(folio, ffs);
+	if (dirty_blocks)
+		f2fs_account_dirty_blocks(folio->mapping->host, dirty_blocks);
 	return ffs;
 }
 
 static void ffs_detach_free(struct folio *folio)
 {
 	struct f2fs_folio_state *ffs;
+	unsigned int nr_blocks;
 
 	if (!f2fs_folio_has_ffs(folio)) {
 		folio_detach_private(folio);
@@ -2964,6 +2979,10 @@ static void ffs_detach_free(struct folio *folio)
 
 	WARN_ON_ONCE(ffs->read_blocks_pending != 0);
 	WARN_ON_ONCE(atomic_read(&ffs->write_blocks_pending));
+	/* The dirty blocks must have been cleaned and unaccounted. */
+	nr_blocks = f2fs_blocks_per_folio(F2FS_F_SB(folio), folio);
+	WARN_ON_ONCE(find_next_bit(ffs->state, 2 * nr_blocks, nr_blocks) <
+							2 * nr_blocks);
 	ffs->magic = 0;
 	kfree(ffs);
 }
@@ -3031,7 +3050,7 @@ static void f2fs_clear_truncated_page_state(struct folio *folio, pgoff_t i)
 {
 	struct f2fs_sb_info *sbi = F2FS_F_SB(folio);
 
-	if (f2fs_folio_has_ffs(folio)) {
+	if (f2fs_is_multiblock_folio(sbi, folio)) {
 		f2fs_ffs_clear_subrange_uptodate(folio,
 				F2FS_BLK_TO_BYTES(sbi, i), F2FS_BLKSIZE(sbi));
 	} else {
@@ -3059,21 +3078,6 @@ bool f2fs_ffs_test_blk_dirty(const struct folio *folio, pgoff_t index)
 	return test_bit(nr_blocks + offset, ffs->state);
 }
 
-static unsigned int __ffs_mark_subrange_dirty(struct folio *folio,
-			struct f2fs_folio_state *ffs, size_t offset, size_t len)
-{
-	struct f2fs_sb_info *sbi = F2FS_F_SB(folio);
-	unsigned int nr_blocks = f2fs_blocks_per_folio(sbi, folio);
-	unsigned int start, end, before;
-
-	start = F2FS_BYTES_TO_BLK(sbi, offset);
-	end = min_t(unsigned int, F2FS_BLK_ALIGN(sbi, offset + len), nr_blocks);
-
-	before = bitmap_weight(ffs->state, 2 * nr_blocks);
-	bitmap_set(ffs->state, nr_blocks + start, end - start);
-	return bitmap_weight(ffs->state, 2 * nr_blocks) - before;
-}
-
 /*
  * Mark the given range dirty for writeback.
  *
@@ -3086,7 +3090,8 @@ void f2fs_ffs_mark_subrange_dirty(struct folio *folio,
 {
 	struct f2fs_sb_info *sbi = F2FS_F_SB(folio);
 	struct f2fs_folio_state *ffs;
-	unsigned int set;
+	unsigned int nr_blocks;
+	unsigned int start, end, before, set;
 	unsigned long flags;
 
 	f2fs_bug_on(F2FS_F_SB(folio), offset + len > folio_size(folio));
@@ -3095,11 +3100,17 @@ void f2fs_ffs_mark_subrange_dirty(struct folio *folio,
 		return;
 
 	ffs = f2fs_ffs_find_or_alloc(folio);
+	nr_blocks = f2fs_blocks_per_folio(sbi, folio);
+	start = F2FS_BYTES_TO_BLK(sbi, offset);
+	end = min_t(unsigned int, F2FS_BLK_ALIGN(sbi, offset + len), nr_blocks);
 
 	spin_lock_irqsave(&ffs->state_lock, flags);
-	set = __ffs_mark_subrange_dirty(folio, ffs, offset, len);
+	before = bitmap_weight(ffs->state, 2 * nr_blocks);
+	bitmap_set(ffs->state, start + nr_blocks, end - start);
+	set = bitmap_weight(ffs->state, 2 * nr_blocks) - before;
 	spin_unlock_irqrestore(&ffs->state_lock, flags);
 
+	/* Outside ffs->state_lock, which the I/O completion takes. */
 	if (set)
 		f2fs_account_dirty_blocks(folio->mapping->host, set);
 }
@@ -3161,8 +3172,7 @@ static bool __ffs_clear_subrange_dirty(struct folio *folio,
  * @len: byte length of the subrange
  *
  * Clear the dirty bits of the 4K subpages covered by [offset, offset + len),
- * account the cleared subpages against the inode dirty counters, and return
- * whether the folio still has any dirty subpage left.
+ * and return whether the folio still has any dirty subpage left.
  */
 bool f2fs_ffs_clear_subrange_dirty_and_test(struct folio *folio, size_t offset,
 					    size_t len)
@@ -3190,11 +3200,28 @@ bool f2fs_ffs_clear_subrange_dirty_and_test(struct folio *folio, size_t offset,
 	spin_unlock_irqrestore(&ffs->state_lock, flags);
 
 	if (cleared)
-		f2fs_account_dirty_blocks(folio->mapping->host, -cleared);
+		f2fs_account_dirty_blocks(folio->mapping->host, -(int)cleared);
 
 	return dirty;
 }
 
+/*
+ * All blocks of @folio are clean now, e.g. written back or truncated. Clear
+ * its dirty bits, or without a folio state, unaccount all of its blocks if
+ * it was @dirty.
+ */
+void f2fs_folio_clear_dirty_blocks(struct folio *folio, bool dirty)
+{
+	struct inode *inode = folio->mapping->host;
+
+	if (f2fs_folio_has_ffs(folio))
+		f2fs_ffs_clear_subrange_dirty_and_test(folio, 0,
+						       folio_size(folio));
+	else if (dirty)
+		f2fs_account_dirty_blocks(inode,
+			-(int)f2fs_blocks_per_folio(F2FS_I_SB(inode), folio));
+}
+
 bool f2fs_ffs_dirty_blk_range(struct folio *folio, unsigned int from,
 			      unsigned int to, unsigned int *start,
 			      unsigned int *count)
@@ -3954,7 +3981,7 @@ int f2fs_do_write_data_page(struct f2fs_io_info *fio)
 static int f2fs_write_folio_dirty_range(struct folio *folio, int *submitted,
 					struct writeback_control *wbc,
 					enum iostat_type io_type,
-					u64 *pos, u64 len)
+					u64 start, u64 end)
 {
 	struct inode *inode = folio->mapping->host;
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
@@ -3962,19 +3989,19 @@ static int f2fs_write_folio_dirty_range(struct folio *folio, int *submitted,
 				folio_test_f2fs_atomic(folio);
 	struct inode *dn_inode = atomic_commit ?
 				F2FS_I(inode)->cow_inode : inode;
-	struct f2fs_folio_state *ffs = NULL;
-	u64 folio_start = folio_pos(folio);
-	pgoff_t start_idx = (*pos - folio_start) >> PAGE_SHIFT;
-	pgoff_t end_idx = (*pos - folio_start + len - 1) >> PAGE_SHIFT;
+	u64 pos = folio_pos(folio);
+	pgoff_t start_idx = F2FS_BYTES_TO_BLK(sbi, start - pos);
+	pgoff_t end_idx = F2FS_BYTES_TO_BLK(sbi, end - 1 - pos);
+	pgoff_t last_idx = 0;
+	pgoff_t i;
+	int local_submitted = 0;
 	int err = 0;
 
-	for (pgoff_t i = start_idx; i <= end_idx && !err; i++) {
+	for (i = start_idx; i <= end_idx; i++) {
 		struct dnode_of_data dn;
 		struct node_info ni;
-		pgoff_t data_idx = folio->index + i;
+		pgoff_t data_idx = f2fs_folio_lblk(sbi, folio) + i;
 		bool ipu_force = false;
-		bool dn_held = false;
-		bool submitted_blk = false;
 		struct f2fs_io_info fio = {
 			.sbi = sbi,
 			.ino = inode->i_ino,
@@ -3994,7 +4021,12 @@ static int f2fs_write_folio_dirty_range(struct folio *folio, int *submitted,
 		};
 
 		if (f2fs_folio_has_ffs(folio)) {
-			ffs = (struct f2fs_folio_state *)folio->private;
+			struct f2fs_folio_state *ffs =
+				(struct f2fs_folio_state *)folio->private;
+
+			/* Write only dirty blocks */
+			if (!f2fs_ffs_test_blk_dirty(folio, data_idx))
+				continue;
 			atomic_inc(&ffs->write_blocks_pending);
 		}
 
@@ -4006,7 +4038,7 @@ static int f2fs_write_folio_dirty_range(struct folio *folio, int *submitted,
 			if (!f2fs_is_valid_blkaddr(sbi, fio.old_blkaddr,
 						   DATA_GENERIC_ENHANCE)) {
 				err = -EFSCORRUPTED;
-				goto block_done;
+				goto skip_block;
 			}
 			ipu_force = true;
 			goto got_it;
@@ -4026,24 +4058,22 @@ static int f2fs_write_folio_dirty_range(struct folio *folio, int *submitted,
 						     LOOKUP_NODE);
 		}
 		if (err && err != -ENOENT)
-			goto block_done;
-		dn_held = true;
+			goto skip_block;
 
-		fio.old_blkaddr = dn.data_blkaddr;
-
-		/* This page is already truncated */
-		if (err == -ENOENT || fio.old_blkaddr == NULL_ADDR) {
-			f2fs_clear_truncated_page_state(folio, i);
+		/* This block is already truncated */
+		if (err || dn.data_blkaddr == NULL_ADDR) {
 			err = 0;
-			goto block_done;
+			f2fs_clear_truncated_page_state(folio, i);
+			goto skip_block;
 		}
 
+		fio.old_blkaddr = dn.data_blkaddr;
 got_it:
 		if (__is_valid_data_blkaddr(fio.old_blkaddr) &&
 		    !f2fs_is_valid_blkaddr(sbi, fio.old_blkaddr,
 					   DATA_GENERIC_ENHANCE)) {
 			err = -EFSCORRUPTED;
-			goto block_done;
+			goto skip_block;
 		}
 
 		if (fio.meta_gc)
@@ -4053,61 +4083,109 @@ static int f2fs_write_folio_dirty_range(struct folio *folio, int *submitted,
 		    (__is_valid_data_blkaddr(fio.old_blkaddr) &&
 					    need_inplace_update(&fio))) {
 			f2fs_put_dnode(&dn);
-			dn_held = false;
 			err = f2fs_inplace_write_data(&fio);
-			trace_f2fs_do_write_data_page(folio, IPU);
 			if (err)
-				goto block_done;
+				goto skip_block_no_dnode;
 
-			if (submitted)
-				(*submitted)++;
-			submitted_blk = true;
+			local_submitted++;
+			last_idx = data_idx;
 			set_inode_flag(inode, FI_UPDATE_WRITE);
-			goto block_done;
+			trace_f2fs_do_write_data_page(folio, IPU);
+			continue;
 		}
 
 		err = f2fs_get_node_info(sbi, dn.nid, &ni, false);
 		if (err)
-			goto block_done;
+			goto skip_block;
 
 		fio.version = ni.version;
 
 		f2fs_outplace_write_data(&dn, &fio);
-		/*
-		 * The outplace write path failed to submit this block.
-		 */
+		f2fs_put_dnode(&dn);
+		/* The outplace write path failed to submit this block. */
 		if (!fio.submitted) {
 			err = -EIO;
-			goto block_done;
+			goto skip_block_no_dnode;
 		}
-		if (submitted)
-			(*submitted)++;
-		submitted_blk = true;
+		local_submitted++;
+		last_idx = data_idx;
 		set_inode_flag(inode, FI_APPEND_WRITE);
 		trace_f2fs_do_write_data_page(folio, OPU);
-block_done:
-		if (dn_held)
-			f2fs_put_dnode(&dn);
+		continue;
+
+skip_block:
+		f2fs_put_dnode(&dn);
+skip_block_no_dnode:
+		if (f2fs_folio_has_ffs(folio))
+			f2fs_ffs_put_write_pending(folio, 1);
+		if (err)
+			break;
+	}
+
+	if (err) {
 		/*
-		 * If this block was not submitted, roll back its
-		 * write pages pending.
+		 * The blocks before the failed one were written or skipped, so
+		 * keep only the failed block and the ones after it dirty.
 		 */
-		if (!submitted_blk && ffs)
-			f2fs_ffs_put_write_pending(folio, 1);
-		if (!err) {
-			*pos = ((loff_t)data_idx + 1) << PAGE_SHIFT;
-			spin_lock(&F2FS_I(inode)->i_size_lock);
-			if (F2FS_I(inode)->last_disk_size < *pos)
-				F2FS_I(inode)->last_disk_size = *pos;
-			spin_unlock(&F2FS_I(inode)->i_size_lock);
-		} else {
-			file_set_keep_isize(inode);
+		if (i > start_idx) {
+			size_t len = F2FS_BLK_TO_BYTES(sbi, i - start_idx);
+
+			f2fs_ffs_clear_subrange_dirty_and_test(folio,
+							       start - pos, len);
 		}
+		file_set_keep_isize(inode);
+	} else if (local_submitted) {
+		loff_t psize = F2FS_BLK_TO_BYTES(sbi, last_idx + 1);
+
+		if (psize > i_size_read(inode))
+			psize = i_size_read(inode);
+
+		spin_lock(&F2FS_I(inode)->i_size_lock);
+		if (F2FS_I(inode)->last_disk_size < psize)
+			F2FS_I(inode)->last_disk_size = psize;
+		spin_unlock(&F2FS_I(inode)->i_size_lock);
 	}
 
+	if (submitted)
+		*submitted = local_submitted;
 	return err;
 }
 
+/* Dentry and quota blocks are controlled by checkpoint. */
+static bool f2fs_cp_controlled_inode(struct inode *inode)
+{
+	return S_ISDIR(inode->i_mode) || IS_NOQUOTA(inode);
+}
+
+enum f2fs_wb_action {
+	F2FS_WB_WRITE,		/* write back the folio */
+	F2FS_WB_REDIRTY,	/* keep the folio dirty */
+	F2FS_WB_DROP,		/* drop the dirty data */
+};
+
+/* Decide what to do with a dirty data folio before writing it back. */
+static enum f2fs_wb_action f2fs_wb_folio_action(struct f2fs_sb_info *sbi,
+						struct inode *inode)
+{
+	/* we should bypass data pages to proceed the kworker jobs */
+	if (unlikely(f2fs_cp_error(sbi))) {
+		mapping_set_error(inode->i_mapping, -EIO);
+		/*
+		 * Keep dirty dentry folios for the latest directory structure,
+		 * and keep data folios in remount-ro mode.
+		 */
+		if ((S_ISDIR(inode->i_mode) &&
+		     !is_sbi_flag_set(sbi, SBI_IS_CLOSE)) ||
+		    F2FS_OPTION(sbi).errors == MOUNT_ERRORS_READONLY)
+			return F2FS_WB_REDIRTY;
+		return F2FS_WB_DROP;
+	}
+
+	if (unlikely(is_sbi_flag_set(sbi, SBI_POR_DOING)))
+		return F2FS_WB_REDIRTY;
+	return F2FS_WB_WRITE;
+}
+
 int f2fs_write_single_data_page(struct folio *folio, int *submitted,
 				struct bio **bio,
 				sector_t *last_block,
@@ -4148,26 +4226,15 @@ int f2fs_write_single_data_page(struct folio *folio, int *submitted,
 
 	trace_f2fs_writepage(folio, DATA);
 
-	/* we should bypass data pages to proceed the kworker jobs */
-	if (unlikely(f2fs_cp_error(sbi))) {
-		mapping_set_error(folio->mapping, -EIO);
-		/*
-		 * don't drop any dirty dentry pages for keeping lastest
-		 * directory structure.
-		 */
-		if (S_ISDIR(inode->i_mode) &&
-				!is_sbi_flag_set(sbi, SBI_IS_CLOSE))
-			goto redirty_out;
-
-		/* keep data pages in remount-ro mode */
-		if (F2FS_OPTION(sbi).errors == MOUNT_ERRORS_READONLY)
-			goto redirty_out;
+	switch (f2fs_wb_folio_action(sbi, inode)) {
+	case F2FS_WB_REDIRTY:
+		goto redirty_out;
+	case F2FS_WB_DROP:
 		goto out;
+	case F2FS_WB_WRITE:
+		break;
 	}
 
-	if (unlikely(is_sbi_flag_set(sbi, SBI_POR_DOING)))
-		goto redirty_out;
-
 	if (folio->index < end_index ||
 			f2fs_verity_in_progress(inode) ||
 			compr_blocks)
@@ -4183,8 +4250,7 @@ int f2fs_write_single_data_page(struct folio *folio, int *submitted,
 
 	folio_zero_segment(folio, offset, folio_size(folio));
 write:
-	/* Dentry/quota blocks are controlled by checkpoint */
-	if (S_ISDIR(inode->i_mode) || quota_inode) {
+	if (f2fs_cp_controlled_inode(inode)) {
 		struct f2fs_lock_context lc;
 
 		/*
@@ -4235,14 +4301,14 @@ int f2fs_write_single_data_page(struct folio *folio, int *submitted,
 		goto redirty_out;
 
 out:
-	inode_dec_dirty_block(inode);
+	f2fs_folio_clear_dirty_blocks(folio, true);
 	if (err) {
 		folio_clear_uptodate(folio);
 		folio_clear_f2fs_gcing(folio);
 	}
 	folio_unlock(folio);
-	if (!S_ISDIR(inode->i_mode) && !IS_NOQUOTA(inode) &&
-			!F2FS_I(inode)->wb_task && allow_balance)
+	if (!f2fs_cp_controlled_inode(inode) &&
+	    !F2FS_I(inode)->wb_task && allow_balance)
 		f2fs_balance_fs(sbi, need_balance_fs);
 
 	if (unlikely(f2fs_cp_error(sbi))) {
@@ -4571,6 +4637,7 @@ static int f2fs_write_cache_folios(struct address_space *mapping,
 	int submitted = 0;
 	int nwritten = 0;
 	bool op_locked = false;
+	bool node_locked = false;
 	bool retry = false;
 
 	if (get_dirty_blocks(inode) <= SM_I(sbi)->min_hot_blocks)
@@ -4582,20 +4649,15 @@ static int f2fs_write_cache_folios(struct address_space *mapping,
 		struct f2fs_folio_state *ffs = NULL;
 		u64 isize;
 		size_t poff;
-		size_t clear_len;
 		pgoff_t end_index;
 		bool verity_in_progress;
 		int folio_submitted = 0;
 		bool bias_added = false;
 
 		submitted = 0;
+		err = 0;
 		retry = false;
 
-		if (err) {
-			folio_redirty_for_writepage(wbc, folio);
-			goto retry_out;
-		}
-
 		if (atomic_read(&sbi->wb_sync_req[DATA]) &&
 		    wbc->sync_mode == WB_SYNC_NONE) {
 			folio_redirty_for_writepage(wbc, folio);
@@ -4608,11 +4670,22 @@ static int f2fs_write_cache_folios(struct address_space *mapping,
 			goto retry_out;
 		}
 
+		if (f2fs_has_subpage_blocks(sbi) &&
+		    (f2fs_compressed_file(inode) || f2fs_is_atomic_file(inode))) {
+			WARN_ON_ONCE(1);
+			mapping_set_error(mapping, -EOPNOTSUPP);
+			folio_clear_dirty_for_io(folio);
+			f2fs_folio_clear_dirty_blocks(folio, true);
+			err = -EOPNOTSUPP;
+			goto retry_out;
+		}
+
 		/*
 		 * Writing back one large folio performs multiple block allocations, so
 		 * best-effort balance the filesystem before writing it back.
 		 */
-		if (!F2FS_I(inode)->wb_task && has_not_enough_free_secs(sbi, 0, 0)) {
+		if (!f2fs_cp_controlled_inode(inode) &&
+		    !F2FS_I(inode)->wb_task && has_not_enough_free_secs(sbi, 0, 0)) {
 			folio_redirty_for_writepage(wbc, folio);
 			retry = true;
 			folio_unlock(folio);
@@ -4647,31 +4720,37 @@ static int f2fs_write_cache_folios(struct address_space *mapping,
 		}
 
 		/*
-		 * If cp_error is set, all subpages of this folio are not
-		 * written back unless the filesystem is mounted with
-		 * errors=remount-ro.  The check is placed after the retry
-		 * block so it also covers cp_error being set while the folio
-		 * lock was dropped for f2fs_balance_fs() or for the trylock_op()
-		 * backoff.  PG_dirty is clear at this point, so both the
-		 * redirty and the drop below leave a coherent state.
+		 * Checked after the retry block, so that it also covers cp_error
+		 * being set while the folio lock was dropped for f2fs_balance_fs()
+		 * or for the trylock_op() backoff.
 		 */
-		if (unlikely(f2fs_cp_error(sbi))) {
-			mapping_set_error(mapping, -EIO);
-			if (F2FS_OPTION(sbi).errors == MOUNT_ERRORS_READONLY) {
-				folio_redirty_for_writepage(wbc, folio);
-				goto retry_out;
-			}
-			goto out;
+		switch (f2fs_wb_folio_action(sbi, inode)) {
+		case F2FS_WB_REDIRTY:
+			folio_redirty_for_writepage(wbc, folio);
+			goto retry_out;
+		case F2FS_WB_DROP:
+			f2fs_folio_clear_dirty_blocks(folio, true);
+			goto retry_out;
+		case F2FS_WB_WRITE:
+			break;
 		}
 
-		/* To avoid dealing with the complexity for one subrange is in bio
-		 * while we trylock_op failed before writing another subrange.
-		 * Try to lock_op before any subrange write for the folio.
-		 */
-		if (!op_locked) {
+		if (f2fs_cp_controlled_inode(inode)) {
+			/*
+			 * Quota writes need node_write to avoid block
+			 * allocation during checkpoint.
+			 */
+			if (IS_NOQUOTA(inode)) {
+				f2fs_down_read_trace(&sbi->node_write, &lc);
+				node_locked = true;
+			}
+		} else {
+			/* To avoid dealing with the complexity for one subrange is in bio
+			 * while we trylock_op failed before writing another subrange.
+			 * Try to lock_op before any subrange write for the folio.
+			 */
 			if (!f2fs_trylock_op(sbi, &lc)) {
 				folio_redirty_for_writepage(wbc, folio);
-				err = 0;
 				if (wbc->sync_mode != WB_SYNC_ALL)
 					goto retry_out;
 
@@ -4701,59 +4780,44 @@ static int f2fs_write_cache_folios(struct address_space *mapping,
 		folio_start_writeback(folio);
 
 		/*
-		 * PG_dirty was already cleared by writeback_iter(), and a
-		 * single-block folio has no ffs dirty bitmap, so the dirty
-		 * range cannot be derived. Write the whole folio.
+		 * PG_dirty was already cleared by writeback_iter(). A single-block
+		 * folio has no ffs, so its whole folio is written.
 		 */
-		if (!folio_test_large(folio)) {
-			err = f2fs_write_folio_dirty_range(folio, &submitted,
-					wbc, io_type, &pos, end_pos - pos);
-			folio_submitted += submitted;
-			nwritten += submitted;
-			if (err)
-				goto out;
-			goto written;
-		}
-
-		if (!f2fs_folio_has_ffs(folio)) {
-			ffs = f2fs_ffs_find_or_alloc(folio);
-			f2fs_ffs_mark_subrange_dirty(folio, 0, end_pos - pos);
-		} else {
+		if (f2fs_is_multiblock_folio(sbi, folio)) {
+			if (!f2fs_folio_has_ffs(folio)) {
+				/*
+				 * PG_dirty, which was cleared for writeback,
+				 * covered every block and the folio was
+				 * accounted as a whole. Account its dirty
+				 * bits instead.
+				 */
+				WARN_ON_ONCE(folio_test_dirty(folio));
+				f2fs_ffs_mark_subrange_dirty(folio, 0, end_pos - pos);
+				f2fs_account_dirty_blocks(inode,
+					-(int)f2fs_blocks_per_folio(sbi, folio));
+			}
 			ffs = (struct f2fs_folio_state *)folio->private;
-		}
-		/*
-		 * Large folios can be submitted as multiple bios, which may
-		 * complete while we are still submitting the remaining dirty
-		 * ranges.  Hold a bias on write_blocks_pending to prevent
-		 * folio_end_writeback() from being called early.
-		 */
-		if (!bias_added) {
-			WARN_ON_ONCE(atomic_read(&ffs->write_blocks_pending) != 0);
-			atomic_inc(&ffs->write_blocks_pending);
-			bias_added = true;
+			/*
+			 * Multiblock folios can be submitted as multiple bios,
+			 * which may complete while we are still submitting the
+			 * remaining dirty ranges.  Hold a bias on
+			 * write_blocks_pending to prevent folio_end_writeback()
+			 * from being called early.
+			 */
+			if (!bias_added) {
+				WARN_ON_ONCE(atomic_read(&ffs->write_blocks_pending) != 0);
+				atomic_inc(&ffs->write_blocks_pending);
+				bias_added = true;
+			}
 		}
 
-		unsigned int from = 0, start, count;
-		unsigned int nr_blocks = f2fs_blocks_per_folio(sbi, folio);
-		unsigned int to_blk = min_t(unsigned int,
-				F2FS_BLK_ALIGN(sbi, end_pos - folio_pos(folio)),
-				nr_blocks);
-
-		while (f2fs_ffs_dirty_blk_range(folio, from, to_blk,
-						&start, &count)) {
-			submitted = 0;
-			pos = folio_pos(folio) + F2FS_BLK_TO_BYTES(sbi, start);
-			err = f2fs_write_folio_dirty_range(folio, &submitted,
-					wbc, io_type, &pos,
-					F2FS_BLK_TO_BYTES(sbi, count));
-			folio_submitted += submitted;
-			nwritten += submitted;
-			if (err)
-				goto out;
-			from = start + count;
-		}
+		err = f2fs_write_folio_dirty_range(folio, &submitted, wbc, io_type,
+						   pos, end_pos);
+		folio_submitted += submitted;
+		nwritten += submitted;
+		if (err)
+			goto out;
 
-written:
 		/* If none of the subpages of a folio is submitted, keep the atomic flag */
 		if (folio_submitted &&
 		    f2fs_is_atomic_file(inode) &&
@@ -4761,27 +4825,10 @@ static int f2fs_write_cache_folios(struct address_space *mapping,
 			folio_clear_f2fs_atomic(folio);
 
 out:
-		/*
-		 * Clear the dirty state of the subranges that were written back.
-		 * If some subranges are still dirty (e.g. the folio was only
-		 * partially written back), or if the writeback failed, the
-		 * folio must stay dirty so that the remaining subranges are
-		 * written back later.
-		 *
-		 * On success, clear dirty bits of the whole folio rather than
-		 * up to isize: subpages beyond EOF can still carry dirty bits
-		 * (e.g. fill_zero() w/ FALLOC_FL_KEEP_SIZE, BG_GC on blocks
-		 * beyond EOF, or f2fs_ffs_find_or_alloc() on a dirty folio),
-		 * they will never be written back, and would keep the folio
-		 * redirtied forever.
-		 */
-		clear_len = err ? pos - folio_pos(folio) : folio_size(folio);
-		if (f2fs_ffs_clear_subrange_dirty_and_test(folio, 0,
-						clear_len) || err) {
+		if (!err)
+			f2fs_folio_clear_dirty_blocks(folio, true);
+		else
 			folio_redirty_for_writepage(wbc, folio);
-		} else if (!f2fs_folio_has_ffs(folio)) {
-			inode_dec_dirty_block(inode);
-		}
 
 		/*
 		 * Release the bias taken above and we end writeback here if
@@ -4791,7 +4838,7 @@ static int f2fs_write_cache_folios(struct address_space *mapping,
 			f2fs_ffs_put_write_pending(folio, 1);
 		} else if (!folio_submitted && folio_test_writeback(folio)) {
 			/*
-			 * Order-0 folios take no bias, so end the writeback
+			 * Single-block folios take no bias, so end the writeback
 			 * if nothing was submitted.
 			 */
 			folio_end_writeback(folio);
@@ -4803,6 +4850,11 @@ static int f2fs_write_cache_folios(struct address_space *mapping,
 			op_locked = false;
 		}
 
+		if (node_locked) {
+			f2fs_up_read_trace(&sbi->node_write, &lc);
+			node_locked = false;
+		}
+
 		folio_unlock(folio);
 	}
 
@@ -4883,10 +4935,10 @@ static int __f2fs_write_data_pages(struct address_space *mapping,
 	if (unlikely(is_sbi_flag_set(sbi, SBI_POR_DOING)))
 		goto skip_write;
 
-	if ((S_ISDIR(inode->i_mode) || IS_NOQUOTA(inode)) &&
-			wbc->sync_mode == WB_SYNC_NONE &&
-			get_dirty_blocks(inode) < nr_caches_to_skip(sbi, DATA) &&
-			f2fs_available_free_memory(sbi, DIRTY_DENTS))
+	if (f2fs_cp_controlled_inode(inode) &&
+	    wbc->sync_mode == WB_SYNC_NONE &&
+	    get_dirty_blocks(inode) < nr_caches_to_skip(sbi, DATA) &&
+	    f2fs_available_free_memory(sbi, DIRTY_DENTS))
 		goto skip_write;
 
 	/* skip writing in file defragment preparing stage */
@@ -4913,7 +4965,7 @@ static int __f2fs_write_data_pages(struct address_space *mapping,
 	account_writeback(inode, true);
 
 	blk_start_plug(&plug);
-	if (mapping_large_folio_support(inode->i_mapping) &&
+	if (f2fs_has_multiblock_folios(inode) &&
 	    !f2fs_has_inline_data(inode))
 		ret = f2fs_write_cache_folios(mapping, wbc, io_type);
 	else
@@ -5147,7 +5199,7 @@ static int prepare_atomic_write_begin(struct f2fs_sb_info *sbi,
 	int err = 0;
 	block_t ori_blk_addr = NULL_ADDR;
 	bool cow_has_reserved_block = false;
-	bool append = ((loff_t)index << PAGE_SHIFT) >= i_size_read(inode);
+	bool append = F2FS_BLK_TO_BYTES(sbi, index) >= i_size_read(inode);
 
 	/*
 	 * On the first attempt, an append write can skip the COW lookup and
@@ -5244,6 +5296,10 @@ static int prepare_large_folio_write_begin(struct inode *inode,
 	size_t need_off = ori_off;
 	int err = 0;
 
+	if (f2fs_has_subpage_blocks(sbi) &&
+	    (f2fs_compressed_file(inode) || f2fs_is_atomic_file(inode)))
+		return -EOPNOTSUPP;
+
 	/*
 	 * when the write did not come through f2fs_write_iter, we preallocate all
 	 * blocks in the write range here.
@@ -5276,8 +5332,12 @@ static int prepare_large_folio_write_begin(struct inode *inode,
 	if (folio_test_uptodate(folio) || len == folio_size(folio))
 		return 0;
 
+	/*
+	 * Skip read if the write starts at a block boundary and reaches EOF,
+	 * and zero the rest of the folio instead.
+	 */
 	if (!f2fs_verity_in_progress(inode) &&
-	    !(pos & (PAGE_SIZE - 1)) && (pos + len) >= i_size_read(inode)) {
+	    !(pos & F2FS_BLKSIZE_MASK(sbi)) && (pos + len) >= i_size_read(inode)) {
 		size_t zoff = ori_off + len;
 
 		if (zoff < folio_size(folio))
@@ -5291,7 +5351,8 @@ static int prepare_large_folio_write_begin(struct inode *inode,
 	while (find_next_valid_block(folio, ori_off,
 				     &need_off, len)) {
 		struct dnode_of_data dn;
-		pgoff_t index = folio->index + (need_off >> PAGE_SHIFT);
+		pgoff_t index = f2fs_folio_lblk(sbi, folio) +
+				F2FS_BYTES_TO_BLK(sbi, need_off);
 		block_t blkaddr;
 
 		if (!f2fs_lookup_read_extent_cache_block(inode, index,
@@ -5307,12 +5368,13 @@ static int prepare_large_folio_write_begin(struct inode *inode,
 			f2fs_put_dnode(&dn);
 
 			if (blkaddr == NEW_ADDR) {
-				size_t off = offset_in_folio(folio,
-							     (loff_t)index << PAGE_SHIFT);
+				size_t off = f2fs_folio_byte_offset(sbi,
+								folio, index);
 
-				folio_zero_segment(folio, off, off + PAGE_SIZE);
+				folio_zero_segment(folio, off,
+						   off + F2FS_BLKSIZE(sbi));
 				f2fs_ffs_mark_subrange_uptodate(folio, off,
-							       PAGE_SIZE);
+							       F2FS_BLKSIZE(sbi));
 				continue;
 			}
 		}
@@ -5410,12 +5472,18 @@ static int f2fs_write_begin(const struct kiocb *iocb,
 		goto fail;
 	}
 
+	if (f2fs_has_subpage_blocks(sbi) &&
+	    (f2fs_compressed_file(inode) || f2fs_is_atomic_file(inode))) {
+		err = -EOPNOTSUPP;
+		goto fail;
+	}
+
 	/*
 	 * We should check this at this moment to avoid deadlock on inode page
 	 * and #0 page. The locking rule for inline_data conversion should be:
 	 * folio_lock(folio #0) -> folio_lock(inode_page)
 	 */
-	if (index != 0) {
+	if (index != 0 || f2fs_has_subpage_blocks(sbi)) {
 		err = f2fs_convert_inline_inode(inode);
 		if (err)
 			goto fail;
@@ -5445,6 +5513,7 @@ static int f2fs_write_begin(const struct kiocb *iocb,
 #endif
 
 repeat:
+	need_balance = false;
 	/*
 	 * Do not use FGP_STABLE to avoid deadlock.
 	 * Will wait that below with our IO control.
@@ -5478,17 +5547,18 @@ static int f2fs_write_begin(const struct kiocb *iocb,
 	 */
 	f2fs_folio_wait_writeback(folio, false, true);
 
-	if (f2fs_is_atomic_file(inode) && !folio_test_large(folio))
+	if (f2fs_is_atomic_file(inode) && !f2fs_is_multiblock_folio(sbi, folio)) {
 		err = prepare_atomic_write_begin(sbi, inode, folio->index,
 					&blkaddr, &need_balance, retried);
-	else if (!folio_test_large(folio))
+	} else if (!f2fs_is_multiblock_folio(sbi, folio)) {
 		err = prepare_write_begin(sbi, folio, pos, blen,
 					&blkaddr, &need_balance);
-	else if (f2fs_is_atomic_file(inode))
+	} else if (f2fs_is_atomic_file(inode)) {
 		err = prepare_large_folio_atomic_write_begin(inode,
 					mapping, folio, pos, len, retried);
-	else
+	} else {
 		err = prepare_large_folio_write_begin(inode, folio, pos, blen);
+	}
 	if (err) {
 		if (err == -EAGAIN) {
 			retried = true;
@@ -5504,7 +5574,7 @@ static int f2fs_write_begin(const struct kiocb *iocb,
 		goto repeat;
 	}
 
-	if (folio_test_large(folio))
+	if (f2fs_is_multiblock_folio(sbi, folio))
 		return 0;
 
 	if (blen == folio_size(folio) || folio_test_uptodate(folio))
@@ -5574,7 +5644,7 @@ static int f2fs_write_end(const struct kiocb *iocb,
 	if (!folio_test_uptodate(folio)) {
 		if (unlikely(copied != len)) {
 			copied = 0;
-		} else if (folio_test_large(folio)) {
+		} else if (f2fs_is_multiblock_folio(F2FS_I_SB(inode), folio)) {
 			f2fs_ffs_mark_subrange_uptodate(folio,
 					offset_in_folio(folio, pos), len);
 		} else {
@@ -5599,10 +5669,10 @@ static int f2fs_write_end(const struct kiocb *iocb,
 	if (!copied)
 		goto unlock_out;
 
-	if (folio_test_large(folio))
+	if (f2fs_is_multiblock_folio(F2FS_I_SB(inode), folio))
 		f2fs_ffs_mark_subrange_dirty(folio, offset_in_folio(folio, pos),
 								   copied);
-	folio_mark_dirty(folio);
+	f2fs_folio_mark_dirty(folio);
 
 	if (f2fs_is_atomic_file(inode))
 		folio_set_f2fs_atomic(folio);
@@ -5655,6 +5725,7 @@ void f2fs_invalidate_folio(struct folio *folio, size_t offset, size_t length)
 		 * dirty state.
 		 */
 		if (!dirty && folio_test_dirty(folio)) {
+			f2fs_remove_dirty_inode(inode);
 			f2fs_clear_page_cache_dirty_tag(folio);
 			folio_cancel_dirty(folio);
 		}
@@ -5663,11 +5734,8 @@ void f2fs_invalidate_folio(struct folio *folio, size_t offset, size_t length)
 		return;
 	}
 
-	if (f2fs_folio_has_ffs(folio)) {
-		f2fs_ffs_clear_subrange_dirty_and_test(folio, 0,
-							folio_size(folio));
-	} else if (folio_test_dirty(folio)) {
-		inode_dec_dirty_block(inode);
+	if (f2fs_folio_has_ffs(folio) || folio_test_dirty(folio)) {
+		f2fs_folio_clear_dirty_blocks(folio, true);
 		f2fs_remove_dirty_inode(inode);
 	}
 
@@ -5698,7 +5766,7 @@ bool f2fs_release_folio(struct folio *folio, gfp_t wait)
 	return true;
 }
 
-static bool f2fs_dirty_data_folio(struct address_space *mapping,
+static bool __f2fs_dirty_data_folio(struct address_space *mapping,
 		struct folio *folio)
 {
 	struct inode *inode = mapping->host;
@@ -5731,6 +5799,55 @@ static bool f2fs_dirty_data_folio(struct address_space *mapping,
 	return false;
 }
 
+/*
+ * Dirty @folio for an update made by f2fs itself, which has marked the
+ * dirty blocks of a multi-block folio with f2fs_ffs_mark_subrange_dirty().
+ */
+bool f2fs_folio_mark_dirty(struct folio *folio)
+{
+	return __f2fs_dirty_data_folio(folio->mapping, folio);
+}
+
+/*
+ * mm dirtied @folio without telling which blocks were modified, e.g. through
+ * a writable mapping or a pinned page: mark its uptodate blocks within EOF
+ * dirty.
+ */
+static void f2fs_ffs_mark_uptodate_blocks_dirty(struct inode *inode,
+						struct folio *folio)
+{
+	struct f2fs_folio_state *ffs = folio->private;
+	unsigned int nr_blocks = f2fs_blocks_per_folio(F2FS_I_SB(inode), folio);
+	unsigned int valid_blocks = f2fs_folio_valid_blocks(inode, folio);
+	unsigned int i, set = 0;
+	unsigned long flags;
+
+	spin_lock_irqsave(&ffs->state_lock, flags);
+	for (i = 0; i < valid_blocks; i++) {
+		if (test_bit(i, ffs->state) &&
+		    !__test_and_set_bit(nr_blocks + i, ffs->state))
+			set++;
+	}
+	spin_unlock_irqrestore(&ffs->state_lock, flags);
+
+	if (set)
+		f2fs_account_dirty_blocks(inode, set);
+}
+
+static bool f2fs_dirty_data_folio(struct address_space *mapping,
+		struct folio *folio)
+{
+	struct inode *inode = mapping->host;
+
+	if (f2fs_folio_has_ffs(folio))
+		f2fs_ffs_mark_uptodate_blocks_dirty(inode, folio);
+	else
+		/* A folio state is attached under the folio lock. */
+		WARN_ON_ONCE(!folio_test_locked(folio) &&
+			f2fs_is_multiblock_folio(F2FS_I_SB(inode), folio));
+	return __f2fs_dirty_data_folio(mapping, folio);
+}
+
 
 static sector_t f2fs_bmap_compress(struct inode *inode, sector_t block)
 {
@@ -5847,7 +5964,7 @@ static int f2fs_migrate_blocks(struct inode *inode, block_t start_blk,
 			f2fs_ffs_mark_subrange_dirty(folio,
 				offset_in_folio(folio, (loff_t)blkidx << PAGE_SHIFT),
 				PAGE_SIZE);
-			folio_mark_dirty(folio);
+			f2fs_folio_mark_dirty(folio);
 			f2fs_folio_put(folio, true);
 		}
 
diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
index 91929c250085..c4ca8ba8cd03 100644
--- a/fs/f2fs/dir.c
+++ b/fs/f2fs/dir.c
@@ -57,7 +57,7 @@ void f2fs_mark_dentry_folio_dirty(struct inode *dir, struct folio *folio,
 	} else if (!folio_test_uptodate(folio)) {
 		folio_mark_uptodate(folio);
 	}
-	folio_mark_dirty(folio);
+	f2fs_folio_mark_dirty(folio);
 }
 
 static unsigned long dir_blocks(struct inode *inode)
@@ -979,9 +979,9 @@ void f2fs_delete_entry(struct f2fs_dir_entry *dentry, void *dentry_block,
 		if (!f2fs_has_subpage_blocks(sbi)) {
 			folio_clear_uptodate(folio);
 			folio_detach_private(folio);
-			inode_dec_dirty_block(dir);
 		}
 
+		f2fs_folio_clear_dirty_blocks(folio, true);
 		f2fs_remove_dirty_inode(dir);
 	}
 keep_dirty:
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index f7234283d33d..449f8c672810 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -4531,7 +4531,10 @@ int f2fs_write_single_data_page(struct folio *folio, int *submitted,
 				int compr_blocks, bool allow_balance);
 bool f2fs_ffs_test_blk_uptodate(const struct folio *folio, pgoff_t index);
 struct f2fs_folio_state *f2fs_ffs_find_or_alloc(struct folio *folio);
+bool f2fs_folio_mark_dirty(struct folio *folio);
+void f2fs_folio_clear_dirty_blocks(struct folio *folio, bool dirty);
 bool f2fs_ffs_test_blk_dirty(const struct folio *folio, pgoff_t index);
+void f2fs_ffs_put_write_pending(struct folio *folio, unsigned int nr);
 void f2fs_ffs_mark_subrange_dirty(struct folio *folio, size_t offset, size_t len);
 bool f2fs_ffs_has_dirty_subpage(struct folio *folio);
 bool f2fs_ffs_clear_subrange_dirty_and_test(struct folio *folio, size_t offset,
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index b5fa4df9f2e3..4c4eb02eb486 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -258,7 +258,7 @@ static vm_fault_t f2fs_vm_page_mkwrite(struct vm_fault *vmf)
 
 	if (folio_test_large(folio))
 		f2fs_ffs_mark_subrange_dirty(folio, 0, dirty_len);
-	folio_mark_dirty(folio);
+	f2fs_folio_mark_dirty(folio);
 
 	f2fs_update_iostat(sbi, inode, APP_MAPPED_IO, dirty_len);
 	f2fs_update_time(sbi, REQ_TIME);
@@ -856,7 +856,7 @@ static int truncate_partial_data_page(struct inode *inode, u64 from,
 		 */
 		f2fs_ffs_mark_subrange_dirty(folio, folio_off,
 				blk_end - folio_off);
-		folio_mark_dirty(folio);
+		f2fs_folio_mark_dirty(folio);
 	}
 	f2fs_folio_put(folio, true);
 	return 0;
@@ -1339,7 +1339,7 @@ static int fill_zero(struct inode *inode, pgoff_t index,
 	 * f2fs_get_new_data_folio() above.
 	 */
 	f2fs_ffs_mark_subrange_dirty(folio, folio_off, len);
-	folio_mark_dirty(folio);
+	f2fs_folio_mark_dirty(folio);
 	f2fs_folio_put(folio, true);
 	return 0;
 }
@@ -1627,7 +1627,7 @@ static int __clone_blkaddrs(struct inode *src_inode, struct inode *dst_inode,
 				f2fs_ffs_mark_subrange_dirty(fdst, dst_off,
 						F2FS_BLKSIZE(sbi));
 			}
-			folio_mark_dirty(fdst);
+			f2fs_folio_mark_dirty(fdst);
 			if (same_folio && i_size_read(dst_inode) <
 			    F2FS_BLK_TO_BYTES(sbi, dst + i + 1))
 				f2fs_i_size_write(dst_inode,
@@ -3222,7 +3222,7 @@ static int f2fs_defragment_range(struct f2fs_sb_info *sbi,
 			f2fs_ffs_mark_subrange_dirty(folio,
 				offset_in_folio(folio, (loff_t)idx << PAGE_SHIFT),
 				PAGE_SIZE);
-			folio_mark_dirty(folio);
+			f2fs_folio_mark_dirty(folio);
 			folio_set_f2fs_gcing(folio);
 			f2fs_folio_put(folio, true);
 
@@ -4967,7 +4967,7 @@ static int redirty_blocks(struct inode *inode, pgoff_t page_idx, int len)
 			f2fs_ffs_mark_subrange_dirty(folio, off, dlen);
 		}
 
-		folio_mark_dirty(folio);
+		f2fs_folio_mark_dirty(folio);
 		folio_set_f2fs_gcing(folio);
 		redirty_idx = folio_next_index(folio);
 		folio_unlock(folio);
@@ -5561,12 +5561,13 @@ static int f2fs_preallocate_blocks(struct kiocb *iocb, struct iov_iter *iter,
 			return ret;
 	}
 
-	if (!dio && mapping_large_folio_support(inode->i_mapping)) {
+	if (!dio && f2fs_has_multiblock_folios(inode)) {
 		/*
-		 * Preallocate all blocks touched by a large-folio buffered write so
-		 * the regular write_begin path does not need to unlock the folio for
-		 * f2fs_balance_fs().  Rechecking large-folio state after unlock is
-		 * unreliable since partial truncation can split the folio.
+		 * Preallocate all blocks touched by a multiblock-folio buffered
+		 * write so the regular write_begin path does not need to unlock
+		 * the folio for f2fs_balance_fs().  Rechecking large-folio
+		 * state after unlock is unreliable since partial truncation can
+		 * split the folio.
 		 */
 		map.m_lblk = F2FS_BYTES_TO_BLK(sbi, pos);
 		map.m_len = F2FS_BLK_ALIGN(sbi, pos + count);
diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index 274c86511cde..c681f3558e85 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -1586,7 +1586,7 @@ static int move_data_cache_block(struct inode *inode, block_t bidx, int gc_type,
 		}
 		if (has_ffs)
 			f2fs_ffs_mark_subrange_dirty(folio, foff, F2FS_BLKSIZE(sbi));
-		folio_mark_dirty(folio);
+		f2fs_folio_mark_dirty(folio);
 		folio_set_f2fs_gcing(folio);
 	} else {
 		struct f2fs_io_info fio = {
@@ -1611,15 +1611,15 @@ static int move_data_cache_block(struct inode *inode, block_t bidx, int gc_type,
 
 		if (has_ffs)
 			f2fs_ffs_mark_subrange_dirty(folio, foff, F2FS_BLKSIZE(sbi));
-		folio_mark_dirty(folio);
+		f2fs_folio_mark_dirty(folio);
 		if (folio_clear_dirty_for_io(folio)) {
-			if (!has_ffs) {
-				inode_dec_dirty_block(inode);
-				f2fs_remove_dirty_inode(inode);
-			} else if (f2fs_ffs_clear_subrange_dirty_and_test(folio,
-						foff, F2FS_BLKSIZE(sbi))) {
-				folio_mark_dirty(folio);
-			}
+			/* The other dirty blocks keep the folio dirty. */
+			if (!has_ffs)
+				f2fs_folio_clear_dirty_blocks(folio, true);
+			else if (f2fs_ffs_clear_subrange_dirty_and_test(folio,
+						foff, F2FS_BLKSIZE(sbi)))
+				f2fs_folio_mark_dirty(folio);
+			f2fs_remove_dirty_inode(inode);
 		}
 
 		folio_set_f2fs_gcing(folio);
@@ -1638,7 +1638,7 @@ static int move_data_cache_block(struct inode *inode, block_t bidx, int gc_type,
 				if (has_ffs)
 					f2fs_ffs_mark_subrange_dirty(folio, foff,
 							F2FS_BLKSIZE(sbi));
-				folio_mark_dirty(folio);
+				f2fs_folio_mark_dirty(folio);
 				folio_set_f2fs_gcing(folio);
 			} else if (!f2fs_ffs_has_dirty_subpage(folio)) {
 				/* migrate this block in later GC */
diff --git a/fs/f2fs/inline.c b/fs/f2fs/inline.c
index ba0aff8e5643..032c1cf8c615 100644
--- a/fs/f2fs/inline.c
+++ b/fs/f2fs/inline.c
@@ -187,7 +187,7 @@ int f2fs_convert_inline_folio(struct dnode_of_data *dn, struct folio *folio)
 	f2fs_bug_on(F2FS_F_SB(folio), folio_test_writeback(folio));
 
 	f2fs_do_read_inline_data(folio, dn->inode_entry);
-	folio_mark_dirty(folio);
+	f2fs_folio_mark_dirty(folio);
 
 	/* clear dirty state */
 	dirty = folio_clear_dirty_for_io(folio);
@@ -196,10 +196,23 @@ int f2fs_convert_inline_folio(struct dnode_of_data *dn, struct folio *folio)
 	folio_start_writeback(folio);
 	fio.old_blkaddr = dn->data_blkaddr;
 	set_inode_flag(dn->inode, FI_HOT_DATA);
+	if (f2fs_is_multiblock_folio(fio.sbi, folio)) {
+		struct f2fs_folio_state *ffs = f2fs_ffs_find_or_alloc(folio);
+
+		atomic_inc(&ffs->write_blocks_pending);
+	}
 	f2fs_outplace_write_data(dn, &fio);
+	/* Drop the pending write that a failed submission leaves behind. */
+	if (!fio.submitted && f2fs_is_multiblock_folio(fio.sbi, folio))
+		f2fs_ffs_put_write_pending(folio, 1);
 	f2fs_folio_wait_writeback(folio, true, true);
 	if (dirty) {
-		inode_dec_dirty_block(dn->inode);
+		/*
+		 * The folio of inline data was dirtied without a folio state,
+		 * so it was accounted as a whole.
+		 */
+		f2fs_account_dirty_blocks(dn->inode,
+				-(int)f2fs_blocks_per_folio(fio.sbi, folio));
 		f2fs_remove_dirty_inode(dn->inode);
 	}
 
diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index c48b12208e20..f1eae132c4d3 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1700,10 +1700,13 @@ static void flush_inline_data(struct f2fs_sb_info *sbi, nid_t ino)
 		goto folio_out;
 
 	ret = f2fs_write_inline_data(inode, folio);
-	inode_dec_dirty_block(inode);
-	f2fs_remove_dirty_inode(inode);
-	if (ret)
-		folio_mark_dirty(folio);
+	if (ret) {
+		/* Keep it dirty as it was, with its dirty blocks accounted. */
+		filemap_dirty_folio(folio->mapping, folio);
+	} else {
+		f2fs_folio_clear_dirty_blocks(folio, true);
+		f2fs_remove_dirty_inode(inode);
+	}
 folio_out:
 	f2fs_folio_put(folio, true);
 iput_out:
-- 
2.56.0.611.g1030f0b940-goog



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
