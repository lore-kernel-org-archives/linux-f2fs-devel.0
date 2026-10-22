Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27FB4606A324
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 22 Oct 2026 07:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=aqBVXsIo;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=c6QJRKkb;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=A9l4wRk4;
	dkim=neutral header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=EzqbORfs
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:List-Owner;
	bh=fOjtaAA0j5kQRCU+E9YvITJI1euO/gM3jz2DjWIBhPw=; b=aqBVXsIo+kTY8oLkp6lt8Wynli
	LH7pR+gV8tb72cjGcvdhWvhll5KcKdwpaeJXoegOGaU1ibKjp2sagTNeaH4OQRp1Ru0cWYcYCDMUh
	K7PWLa+jRpeYh6BAX40VuuhpbBrHbNWD1buuoIq24rGr14bUMLDQw9O0MJ2nW1iUi0OY=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xJndG-000000000lC-3fLu;
	Thu, 22 Oct 2026 07:54:38 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <nzzhao.sigma@gmail.com>) id 1xJncz-000000000h2-0INO
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 22 Oct 2026 07:54:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=/JtHQu1Eic1AjJMVNgSpoRhJKwz5IcHeSWlT6BMH2oY=; b=c6QJRKkb0p4IJPC5b9V8YE0dU4
 LSc5tm9bTCZbsIa004WxV9ViZV/E/r5MBfqrEmISEzQzAAkaJt1lI4Q6VSoAH9Dyms3oPzkQveASh
 W6ZxYFgrLQFGHXqFCkTO+vjJrmDEhPO9MEjGJJnAZgD3YqPhRiEZ6D7rwLGlzAHl/r2E=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=/JtHQu1Eic1AjJMVNgSpoRhJKwz5IcHeSWlT6BMH2oY=; b=A9l4wRk4f9On2jugy0wDMu5LYR
 btdPvJoiAmEQ16eav2MXmaTJ/8WZ/DB8Pwvhh8YRALTE13FnvuRimJN5N7361FtobvECyr6YDBg0W
 e5FS6Zded1jTbqAufkQNbwcma83LXHh7aBncDJjkDKO+tnBjSCnuVM3WBh8Z6SO5ztxE=;
Received: from mail-pj2-f8.google.com ([74.125.227.136])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xJncm-000000007oD-07ha
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 22 Oct 2026 07:54:09 +0000
Received: by mail-pj2-f8.google.com with SMTP id
 98e67ed59e1d1-3ac749e0719so421001a91.0
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu, 22 Oct 2026 00:54:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792655642; x=1793260442; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=/JtHQu1Eic1AjJMVNgSpoRhJKwz5IcHeSWlT6BMH2oY=;
 b=EzqbORfsQx0ugzu+UH782tCBCjzzkuiDVMdIRov5lQXUaSvHE8QRB6kKji0VG1Xs+t
 4mhKdIjxTZWO1/nwVke3JaXJ0O+s1pvhoBBuo2UBIP4JqvfgF0nHJaYlrp4jLmIueXgg
 O/nBzzoeJsZFshpzLIFyPNbtQ1kc58iBqunDhMqVIGO6jETAaszvf6zFIdoSeFYXCy+i
 45fj6adLDxfRczr4mno7hHD/228nYTkYIeZao9BGfJhXnWJP2xqc3OOQ2jJjeVxKdYBF
 CYOBUKHz5dZm+Zed12UOKYI4m+Ya8oVsnI2YpvxEfPKLOMhOkq25A7F+axNCAwNan5tw
 Dn5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792655642; x=1793260442;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=/JtHQu1Eic1AjJMVNgSpoRhJKwz5IcHeSWlT6BMH2oY=;
 b=aGpoPS1ZsUJbbsKIwIXMifByXd2LRIilOpAVQ3TZVoo5UNFGMuuMp1RQ8NOWPqdxmT
 EsJDc58bQIA4VdkPLDsizPAije4Gcbd/vsmECqLfPQJnusop+VZvH5YX/UDe3g5GcZ+N
 oqMen7Ay480NkC5avbhQqYwuwpcCg9XppU3XDChenzSgce6yzBpVvBd9qV4nsojxy57E
 i9GAzDrA7iRjazUDBp42ybwapyoVk3f9OXTCMvpwP0C/CRORuUDXkLpGOGo4L0Ek2rlD
 OhhD0ogqbNTPjXY0I3NrBwcmGW5yYGX3UfDmjMkWdRI9Cbj84qAv+t+rLtw4AoNMOVyr
 sMrw==
X-Gm-Message-State: AFq9FYIOqFLk6uzr4Xk+F79rYtO5o3xzjNwZbVc9KXyciInSRm7nVanf
 YRDHeLGkRxc+ZJZtG7nGUiGWVijN1utsqmgiEAFi9s+Rc0aozxfiT+KbsZo3ETCp
X-Gm-Gg: AYBFou3oViwD8oTGDRSvgl473gPxjcnspHdbTx6YKos12UwL9plKRHvD8df/Uw2mEzi
 nX4dQTjOqYi7xWWFk28W9TZEuISnLJvp8lg09pIXnsTs4CTjRRWqmYow3aoF765S9GtlseHrH13
 UgejeGm/Eg1mBZllpPAEHI1KVUybRo8K1NFPVxppdOLPpe7Czw0uvjJihTrKiiWu1oBAXVUlSwa
 IfqNqRnd1vuNVtZHn/r+3cW/i8FmKvDlJRdT1t1cDm4vj+jie1DRL7/BnsHpoymsrurvmS6A3uw
 fIfyObunGhOqoG+pj99vLUz+k+x7idLKIYdn3TSg+N3lxAPFfJFPNSTVTmwvp24NXsCtppPj90D
 ur9+ID/fyzE/ijQlZrZs869U8roLrM2kgv2qDPhv4i5+UCT8FUB1QlCSwefYPOUOisuWT+01nhx
 DwCuTmWWiFi1US/1DOX2Sw/waO1b2Xzpm+C2jyKE2a5+udzaGZDT5UI7LMg4tpU71T+nHqv8fBI
 HdSg9mGhaREldRRI6m4siYN8My819Y8e18eJBlBl3YssZQ+e1uRZ8sdf9rK/buXUhozQGM9zSf7
 3fCq2LeT50Np4OM2OA==
X-Received: by 2002:a17:90b:3cc7:b0:3ac:d19e:85f1 with SMTP id
 98e67ed59e1d1-3ad86d7e7b9mr3493557a91.53.1792655642162; 
 Thu, 22 Oct 2026 00:54:02 -0700 (PDT)
Received: from nzzhao-ThinkCentre-M760t.mioffice.cn ([43.224.245.179])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ada4896c71sm3202562a91.6.2026.10.22.00.53.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Oct 2026 00:54:01 -0700 (PDT)
From: Nanzhe Zhao <nzzhao.sigma@gmail.com>
To: linux-f2fs-devel@lists.sourceforge.net, Jaegeuk Kim <jaegeuk@kernel.org>,
 Chao Yu <chao@kernel.org>
Date: Thu, 22 Oct 2026 15:53:30 +0800
Message-ID: <20261022075343.3043003-4-nzzhao.sigma@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261022075343.3043003-1-nzzhao.sigma@gmail.com>
References: <20261022075343.3043003-1-nzzhao.sigma@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xJncm-000000007oD-07ha
Subject: [f2fs-dev] [PATCH v6 03/15] f2fs: support regular file buffered
 writes on large folios
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

To avoid the complexity of unlocking a large folio in write_begin,
preallocate partial blocks for inodes that can use large folios.
During write_begin, read only the partial head and tail 4K subpages
that need read-before-write, and skip read I/O for the full middle
subpages covered by the write.

Signed-off-by: Nanzhe Zhao <zhaonanzhe@xiaomi.com>
---
 fs/f2fs/data.c | 431 +++++++++++++++++++++++++++++++++++++++++++++----
 fs/f2fs/f2fs.h |   1 +
 fs/f2fs/file.c |  17 +-
 3 files changed, 412 insertions(+), 37 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 280ea6b72473..ffc25eb09a92 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -93,6 +93,20 @@ struct bio_post_read_ctx {
 	block_t fs_blkaddr;
 };
 
+static bool __ffs_mark_subrange_uptodate(struct folio *folio,
+		struct f2fs_folio_state *ffs, size_t offset, size_t len)
+{
+	unsigned int nr_subpages = folio_nr_pages(folio);
+	unsigned int start, end;
+
+	start = offset >> PAGE_SHIFT;
+	end = (offset + len + PAGE_SIZE - 1) >> PAGE_SHIFT;
+	end = min(end, nr_subpages);
+
+	bitmap_set(ffs->state, start, end - start);
+	return bitmap_full(ffs->state, nr_subpages);
+}
+
 /*
  * Update and unlock a bio's pages, and free the bio.
  *
@@ -107,6 +121,23 @@ struct bio_post_read_ctx {
  * called (i.e., I/O error or decryption error, but *not* verity error), and
  * release the bio's reference to the decompress_io_ctx of the page's cluster.
  */
+/*
+ * Update read_pages_pending.
+ */
+static inline void f2fs_update_read_folio_pending(struct folio *folio, int nr)
+{
+	struct f2fs_folio_state *ffs;
+	unsigned long flags;
+
+	if (!f2fs_folio_has_ffs(folio))
+		return;
+
+	ffs = (struct f2fs_folio_state *)folio->private;
+	spin_lock_irqsave(&ffs->state_lock, flags);
+	ffs->read_pages_pending += nr;
+	spin_unlock_irqrestore(&ffs->state_lock, flags);
+}
+
 static void f2fs_finish_read_bio(struct bio *bio, bool in_task)
 {
 	struct folio_iter fi;
@@ -128,7 +159,8 @@ static void f2fs_finish_read_bio(struct bio *bio, bool in_task)
 		}
 
 		if (folio_test_large(folio)) {
-			struct f2fs_folio_state *ffs = folio->private;
+			struct f2fs_folio_state *ffs =
+				(struct f2fs_folio_state *)folio->private;
 
 			spin_lock_irqsave(&ffs->state_lock, flags);
 			ffs->read_pages_pending -= nr_pages;
@@ -1437,19 +1469,26 @@ static struct bio *f2fs_grab_read_bio(struct inode *inode,
 
 /* This can handle encryption stuffs */
 static void f2fs_submit_page_read(struct inode *inode, struct fsverity_info *vi,
-				  struct folio *folio, block_t blkaddr,
-				  blk_opf_t op_flags, bool for_write)
+				  struct folio *folio, pgoff_t index,
+				  block_t blkaddr, blk_opf_t op_flags,
+				  bool for_write)
 {
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
 	struct bio *bio;
+	size_t offset = 0;
+
+	if (f2fs_folio_has_ffs(folio)) {
+		offset = offset_in_folio(folio, (loff_t)index << PAGE_SHIFT);
+		f2fs_update_read_folio_pending(folio, 1);
+	}
 
-	bio = f2fs_grab_read_bio(inode, vi, blkaddr, 1, op_flags, folio->index,
+	bio = f2fs_grab_read_bio(inode, vi, blkaddr, 1, op_flags, index,
 				 for_write);
 
 	/* wait for GCed page writeback via generic cache */
 	f2fs_wait_on_block_writeback(inode, blkaddr);
 
-	if (!bio_add_folio(bio, folio, PAGE_SIZE, 0))
+	if (!bio_add_folio(bio, folio, PAGE_SIZE, offset))
 		f2fs_bug_on(sbi, 1);
 
 	inc_cache_count(sbi, F2FS_RD_DATA);
@@ -1457,6 +1496,40 @@ static void f2fs_submit_page_read(struct inode *inode, struct fsverity_info *vi,
 	f2fs_submit_read_bio(sbi, bio, DATA);
 }
 
+/*
+ * Synchronously read a single 4K subpage by reusing f2fs_submit_page_read()
+ * so that iostat, trace, blk-crypto and post-read handling are all preserved.
+ * The caller must have already allocated ffs for the folio.
+ */
+static int f2fs_submit_page_read_sync(struct inode *inode, struct folio *folio,
+				      pgoff_t index, block_t blkaddr)
+{
+	struct f2fs_folio_state *ffs =
+		(struct f2fs_folio_state *)folio->private;
+
+	/* Add bias so end_io does not call folio_end_read(). */
+	f2fs_update_read_folio_pending(folio, 1);
+
+	/*
+	 * We are holding the folio lock, so use GFP_NOIO for the bio
+	 * allocation to avoid entering mm reclaim.
+	 */
+	f2fs_submit_page_read(inode, NULL, folio, index, blkaddr,
+			      REQ_OP_READ, true);
+
+	/* Wait until all bios have completed (pending drops back to our bias). */
+	while (READ_ONCE(ffs->read_pages_pending) != 1)
+		f2fs_io_schedule_timeout(DEFAULT_SCHEDULE_TIMEOUT);
+
+	/* Remove the bias. */
+	f2fs_update_read_folio_pending(folio, -1);
+
+	if (!f2fs_ffs_test_blk_uptodate(folio, index))
+		return -EIO;
+
+	return 0;
+}
+
 static void __set_data_blkaddr(struct dnode_of_data *dn, block_t blkaddr)
 {
 	__le32 *addr = get_dnode_addr(dn->inode, dn->node_entry);
@@ -1630,8 +1703,8 @@ struct folio *f2fs_get_read_data_folio(struct inode *inode, pgoff_t index,
 		return folio;
 	}
 
-	f2fs_submit_page_read(inode, f2fs_need_verity(inode, folio->index),
-			      folio, dn.data_blkaddr, op_flags, for_write);
+	f2fs_submit_page_read(inode, f2fs_need_verity(inode, index),
+			      folio, index, dn.data_blkaddr, op_flags, for_write);
 	return folio;
 
 put_err:
@@ -2793,6 +2866,110 @@ static void ffs_detach_free(struct folio *folio)
 	kfree(ffs);
 }
 
+bool f2fs_ffs_test_blk_uptodate(const struct folio *folio, pgoff_t index)
+{
+	struct f2fs_folio_state *ffs;
+	unsigned int idx;
+
+	f2fs_bug_on(F2FS_F_SB(folio), !folio_contains(folio, index));
+
+	if (folio_test_uptodate(folio))
+		return true;
+
+	if (!f2fs_folio_has_ffs(folio))
+		return false;
+
+	ffs = (struct f2fs_folio_state *)folio->private;
+	idx = index - folio->index;
+	return test_bit(idx, ffs->state);
+}
+
+static void f2fs_ffs_mark_subrange_uptodate(struct folio *folio, size_t offset,
+				       size_t len)
+{
+	struct f2fs_folio_state *ffs;
+	unsigned long flags;
+	bool mark_uptodate = false;
+
+	f2fs_bug_on(F2FS_F_SB(folio), offset + len > folio_size(folio));
+
+	if (!f2fs_folio_has_ffs(folio)) {
+		folio_mark_uptodate(folio);
+		return;
+	}
+
+	ffs = (struct f2fs_folio_state *)folio->private;
+	spin_lock_irqsave(&ffs->state_lock, flags);
+	mark_uptodate = __ffs_mark_subrange_uptodate(folio, ffs, offset, len) &&
+			!ffs->read_pages_pending;
+	spin_unlock_irqrestore(&ffs->state_lock, flags);
+	if (mark_uptodate)
+		folio_mark_uptodate(folio);
+}
+
+static unsigned int __ffs_mark_subrange_dirty(struct folio *folio,
+			struct f2fs_folio_state *ffs, size_t offset, size_t len)
+{
+	unsigned int nr_subpages = folio_nr_pages(folio);
+	unsigned int start, end, before;
+
+	start = offset >> PAGE_SHIFT;
+	end = (offset + len + PAGE_SIZE - 1) >> PAGE_SHIFT;
+	end = min(end, nr_subpages);
+
+	before = bitmap_weight(ffs->state, 2 * nr_subpages);
+	bitmap_set(ffs->state, nr_subpages + start, end - start);
+	return bitmap_weight(ffs->state, 2 * nr_subpages) - before;
+}
+
+static void f2fs_ffs_mark_subrange_dirty(struct folio *folio,
+				    size_t offset, size_t len)
+{
+	struct f2fs_folio_state *ffs;
+	unsigned long flags;
+
+	f2fs_bug_on(F2FS_F_SB(folio), offset + len > folio_size(folio));
+
+	if (!f2fs_folio_has_ffs(folio))
+		return;
+
+	ffs = (struct f2fs_folio_state *)folio->private;
+
+	spin_lock_irqsave(&ffs->state_lock, flags);
+	__ffs_mark_subrange_dirty(folio, ffs, offset, len);
+	spin_unlock_irqrestore(&ffs->state_lock, flags);
+}
+
+static bool find_next_valid_block(const struct folio *folio,
+				  size_t orig_off, size_t *need_off,
+				  size_t len)
+{
+	size_t start = orig_off;
+	size_t end = start + len;
+	size_t head, tail;
+	pgoff_t index;
+
+	if (start & (PAGE_SIZE - 1)) {
+		head = round_down(start, PAGE_SIZE);
+		index = folio->index + (head >> PAGE_SHIFT);
+		if (!f2fs_ffs_test_blk_uptodate(folio, index)) {
+			*need_off = head;
+			return true;
+		}
+	}
+
+	if (end & (PAGE_SIZE - 1)) {
+		tail = round_down(end, PAGE_SIZE);
+		index = folio->index + (tail >> PAGE_SHIFT);
+		if (!f2fs_ffs_test_blk_uptodate(folio, index)) {
+			*need_off = tail;
+			return true;
+		}
+	}
+
+	return false;
+}
+
 static int f2fs_read_data_large_folio(struct inode *inode,
 		struct fsverity_info *vi,
 		struct readahead_control *rac, struct folio *folio)
@@ -4158,6 +4335,151 @@ static int prepare_atomic_write_begin(struct f2fs_sb_info *sbi,
 	return 0;
 }
 
+/*
+ * Drop the folio lock when a node was changed, then balance the
+ * filesystem and reacquire the lock.
+ *
+ * Return: true if the folio became unusable while unlocked (being
+ * truncated), false if the folio is still usable.
+ */
+static bool f2fs_balance_fs_folio_locked(struct folio *folio,
+		struct address_space *mapping, bool node_changed)
+{
+	struct inode *inode = folio->mapping->host;
+	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
+	unsigned int orig_order;
+	bool had_ffs;
+
+	if (!node_changed || IS_NOQUOTA(inode) ||
+			!has_not_enough_free_secs(sbi, 0, 0))
+		return false;
+
+	had_ffs = f2fs_folio_has_ffs(folio);
+	orig_order = folio_order(folio);
+	folio_unlock(folio);
+	f2fs_balance_fs(sbi, true);
+	folio_lock(folio);
+
+	/*
+	 * Writeback may have started on the folio during the unlock
+	 * window, so wait for it before the caller proceeds.
+	 */
+	f2fs_folio_wait_writeback(folio, true, true);
+
+	if (folio->mapping != mapping)
+		return true;
+
+	if (folio_order(folio) != orig_order)
+		return true;
+
+	/* large folio was released */
+	if (had_ffs && !f2fs_folio_has_ffs(folio))
+		return true;
+
+	return false;
+}
+
+static int prepare_large_folio_write_begin(struct inode *inode,
+					  struct folio *folio, loff_t pos,
+					  unsigned int len)
+{
+	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
+	struct f2fs_folio_state *ffs;
+	size_t ori_off = offset_in_folio(folio, pos);
+	size_t need_off = ori_off;
+	int err = 0;
+
+	/*
+	 * when the write did not come through f2fs_write_iter, we preallocate all
+	 * blocks in the write range here.
+	 */
+	if (!is_inode_flag_set(inode, FI_PREALLOCATED_ALL) &&
+	    !IS_DEVICE_ALIASING(inode)) {
+		pgoff_t first = F2FS_BYTES_TO_BLK(sbi, pos);
+		pgoff_t last = F2FS_BLK_ALIGN(sbi, pos + len);
+		pgoff_t idx;
+
+		for (idx = first; idx < last; idx++) {
+			block_t blkaddr = NULL_ADDR;
+			bool node_changed = false;
+
+			err = __reserve_data_block(inode, idx, &blkaddr,
+						   &node_changed);
+			if (err)
+				return err;
+			if (f2fs_balance_fs_folio_locked(folio, folio->mapping,
+						   node_changed))
+				return -EAGAIN;
+		}
+	}
+
+	ffs = f2fs_ffs_find_or_alloc(folio);
+	if (!ffs)
+		return -ENOMEM;
+
+	/* Skip read if the folio is already fully uptodate or the write
+	 * covers the entire folio.
+	 */
+	if (folio_test_uptodate(folio) || len == folio_size(folio))
+		return 0;
+
+	if (!f2fs_verity_in_progress(inode) &&
+	    !(pos & (PAGE_SIZE - 1)) && (pos + len) >= i_size_read(inode)) {
+		size_t zoff = ori_off + len;
+
+		if (zoff < folio_size(folio))
+			folio_zero_segment(folio, zoff, folio_size(folio));
+		return 0;
+	}
+
+	/* Inline data must have been converted before reaching here. */
+	f2fs_bug_on(sbi, f2fs_has_inline_data(inode));
+
+	while (find_next_valid_block(folio, ori_off,
+				     &need_off, len)) {
+		struct dnode_of_data dn;
+		pgoff_t index = folio->index + (need_off >> PAGE_SHIFT);
+		block_t blkaddr;
+
+		if (!f2fs_lookup_read_extent_cache_block(inode, index,
+							&blkaddr)) {
+			if (IS_DEVICE_ALIASING(inode))
+				return -ENODATA;
+
+			set_new_dnode(&dn, inode, NULL, NULL, 0);
+			err = f2fs_get_dnode_of_data(&dn, index, LOOKUP_NODE);
+			if (err)
+				return err;
+			blkaddr = dn.data_blkaddr;
+			f2fs_put_dnode(&dn);
+
+			if (blkaddr == NEW_ADDR) {
+				size_t off = offset_in_folio(folio,
+							     (loff_t)index << PAGE_SHIFT);
+
+				folio_zero_segment(folio, off, off + PAGE_SIZE);
+				f2fs_ffs_mark_subrange_uptodate(folio, off,
+							       PAGE_SIZE);
+				continue;
+			}
+		}
+
+		/*
+		 * The read extent cache only validates the first and last
+		 * block of i_ext, so check both the cached and dnode paths.
+		 */
+		if (!f2fs_is_valid_blkaddr(sbi, blkaddr,
+					  DATA_GENERIC_ENHANCE_READ))
+			return -EFSCORRUPTED;
+
+		err = f2fs_submit_page_read_sync(inode, folio, index, blkaddr);
+		if (err)
+			return err;
+	}
+
+	return 0;
+}
+
 static int f2fs_write_begin(const struct kiocb *iocb,
 			    struct address_space *mapping,
 			    loff_t pos, unsigned len, struct folio **foliop,
@@ -4169,6 +4491,8 @@ static int f2fs_write_begin(const struct kiocb *iocb,
 	pgoff_t index = pos >> PAGE_SHIFT;
 	bool need_balance = false;
 	block_t blkaddr = NULL_ADDR;
+	fgf_t fgp = FGP_LOCK | FGP_WRITE | FGP_CREAT;
+	unsigned int blen;
 	int err = 0;
 
 	trace_f2fs_write_begin(inode, pos, len);
@@ -4216,9 +4540,15 @@ static int f2fs_write_begin(const struct kiocb *iocb,
 	 * Do not use FGP_STABLE to avoid deadlock.
 	 * Will wait that below with our IO control.
 	 */
-	folio = f2fs_filemap_get_folio(mapping, index,
-				FGP_LOCK | FGP_WRITE | FGP_CREAT,
-				mapping_gfp_mask(mapping));
+	/*
+	 * Inline data is carried in the first subpage.  Keep the index #0
+	 * folio order-0 so that the existing inline read/convert paths
+	 * (prepare_write_begin()) still apply; large folios are used from
+	 * the second folio on.
+	 */
+	fgp |= fgf_set_order(f2fs_has_inline_data(inode) ? PAGE_SIZE : len);
+	folio = f2fs_filemap_get_folio(mapping, index, fgp,
+				      mapping_gfp_mask(mapping));
 	if (IS_ERR(folio)) {
 		err = PTR_ERR(folio);
 		goto fail;
@@ -4228,31 +4558,42 @@ static int f2fs_write_begin(const struct kiocb *iocb,
 
 	*foliop = folio;
 
+	/* Clamp the write length to the folio size. */
+	blen = min_t(unsigned int, len,
+		     folio_size(folio) - offset_in_folio(folio, pos));
+
+	/*
+	 * Flush the cached IO of this folio before touching it, especially
+	 * for the large folio prepare below which reads and updates subpage
+	 * states.
+	 */
+	f2fs_folio_wait_writeback(folio, false, true);
+
 	if (f2fs_is_atomic_file(inode))
 		err = prepare_atomic_write_begin(sbi, folio, pos, len,
 					&blkaddr, &need_balance);
-	else
-		err = prepare_write_begin(sbi, folio, pos, len,
+	else if (!folio_test_large(folio))
+		err = prepare_write_begin(sbi, folio, pos, blen,
 					&blkaddr, &need_balance);
-	if (err)
-		goto put_folio;
-
-	if (need_balance && !IS_NOQUOTA(inode) &&
-			has_not_enough_free_secs(sbi, 0, 0)) {
-		folio_unlock(folio);
-		f2fs_balance_fs(sbi, true);
-		folio_lock(folio);
-		if (folio->mapping != mapping) {
-			/* The folio got truncated from under us */
-			folio_unlock(folio);
-			folio_put(folio);
+	else
+		err = prepare_large_folio_write_begin(inode, folio, pos, blen);
+	if (err) {
+		if (err == -EAGAIN) {
+			f2fs_folio_put(folio, true);
 			goto repeat;
 		}
+		goto put_folio;
 	}
 
-	f2fs_folio_wait_writeback(folio, false, true);
+	if (f2fs_balance_fs_folio_locked(folio, mapping, need_balance)) {
+		f2fs_folio_put(folio, true);
+		goto repeat;
+	}
+
+	if (folio_test_large(folio))
+		return 0;
 
-	if (len == folio_size(folio) || folio_test_uptodate(folio))
+	if (blen == folio_size(folio) || folio_test_uptodate(folio))
 		return 0;
 
 	if (!(pos & (PAGE_SIZE - 1)) && (pos + len) >= i_size_read(inode) &&
@@ -4280,7 +4621,7 @@ static int f2fs_write_begin(const struct kiocb *iocb,
 		 */
 		f2fs_submit_page_read(inode,
 				      NULL, /* can't write to fsverity files */
-				      folio, blkaddr, 0, true);
+				      folio, index, blkaddr, 0, true);
 
 		folio_lock(folio);
 		if (unlikely(folio->mapping != mapping)) {
@@ -4312,15 +4653,20 @@ static int f2fs_write_end(const struct kiocb *iocb,
 	trace_f2fs_write_end(inode, pos, len, copied);
 
 	/*
-	 * This should be come from len == PAGE_SIZE, and we expect copied
-	 * should be PAGE_SIZE. Otherwise, we treat it with zero copied and
-	 * let generic_perform_write() try to copy data again through copied=0.
+	 * If a short copy happens on a folio that isn't uptodate, we treat
+	 * it with zero copied and let generic_perform_write() try to copy
+	 * data again through copied=0.
 	 */
 	if (!folio_test_uptodate(folio)) {
-		if (unlikely(copied != len))
+		if (unlikely(copied != len)) {
 			copied = 0;
-		else
+		} else if (folio_test_large(folio)) {
+			f2fs_ffs_mark_subrange_uptodate(folio,
+					offset_in_folio(folio, pos), len);
+		} else {
+			/* This should be come from len == PAGE_SIZE */
 			folio_mark_uptodate(folio);
+		}
 	}
 
 #ifdef CONFIG_F2FS_FS_COMPRESSION
@@ -4339,6 +4685,9 @@ static int f2fs_write_end(const struct kiocb *iocb,
 	if (!copied)
 		goto unlock_out;
 
+	if (folio_test_large(folio))
+		f2fs_ffs_mark_subrange_dirty(folio, offset_in_folio(folio, pos),
+								   copied);
 	folio_mark_dirty(folio);
 
 	if (f2fs_is_atomic_file(inode))
@@ -4395,8 +4744,22 @@ static bool f2fs_dirty_data_folio(struct address_space *mapping,
 
 	trace_f2fs_set_page_dirty(folio, DATA);
 
-	if (!folio_test_uptodate(folio))
-		folio_mark_uptodate(folio);
+	if (!folio_test_uptodate(folio)) {
+		bool uptodate = true;
+
+		if (f2fs_folio_has_ffs(folio)) {
+			struct f2fs_folio_state *ffs =
+				(struct f2fs_folio_state *)folio->private;
+			unsigned long flags;
+
+			spin_lock_irqsave(&ffs->state_lock, flags);
+			uptodate = bitmap_full(ffs->state, folio_nr_pages(folio)) &&
+				   !ffs->read_pages_pending;
+			spin_unlock_irqrestore(&ffs->state_lock, flags);
+		}
+		if (uptodate)
+			folio_mark_uptodate(folio);
+	}
 	BUG_ON(folio_test_swapcache(folio));
 
 	if (filemap_dirty_folio(mapping, folio)) {
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 62117de4b404..df0091591ff5 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -4454,6 +4454,7 @@ int f2fs_write_single_data_page(struct folio *folio, int *submitted,
 				struct writeback_control *wbc,
 				enum iostat_type io_type,
 				int compr_blocks, bool allow_balance);
+bool f2fs_ffs_test_blk_uptodate(const struct folio *folio, pgoff_t index);
 void f2fs_write_failed(struct inode *inode, loff_t to);
 void f2fs_invalidate_folio(struct folio *folio, size_t offset, size_t length);
 bool f2fs_release_folio(struct folio *folio, gfp_t wait);
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index b077e4eb790d..85b4f1a2ff0d 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -5420,9 +5420,20 @@ static int f2fs_preallocate_blocks(struct kiocb *iocb, struct iov_iter *iter,
 			return ret;
 	}
 
-	/* Do not preallocate blocks that will be written partially in 4KB. */
-	map.m_lblk = F2FS_BLK_ALIGN(sbi, pos);
-	map.m_len = F2FS_BYTES_TO_BLK(sbi, pos + count);
+	if (!dio && mapping_large_folio_support(inode->i_mapping)) {
+		/*
+		 * Preallocate all blocks touched by a large-folio buffered write so
+		 * the regular write_begin path does not need to unlock the folio for
+		 * f2fs_balance_fs().  Rechecking large-folio state after unlock is
+		 * unreliable since partial truncation can split the folio.
+		 */
+		map.m_lblk = F2FS_BYTES_TO_BLK(sbi, pos);
+		map.m_len = F2FS_BLK_ALIGN(sbi, pos + count);
+	} else {
+		/* Do not preallocate blocks that will be written partially in 4KB. */
+		map.m_lblk = F2FS_BLK_ALIGN(sbi, pos);
+		map.m_len = F2FS_BYTES_TO_BLK(sbi, pos + count);
+	}
 	if (map.m_len > map.m_lblk)
 		map.m_len -= map.m_lblk;
 	else
-- 
2.43.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
