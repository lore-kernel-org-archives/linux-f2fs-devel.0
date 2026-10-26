Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32FBD606A31D
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 26 Oct 2026 03:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=iKaWLat8;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=RtKX+KPL;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=epZbeYwD;
	dkim=neutral header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=J2axxMPG
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:List-Owner;
	bh=sXcbC0vOW4FpeeJUdBRBoYGAWhpidBEW14obNsgIU4U=; b=iKaWLat8S0RUWqSCRz4r9aj20k
	L1SyFdvwD5Y3foR+RJ1ntKyuFymDjn3qln/jQ+PgDwlh2cBYUkX1W5ipSJhywiOi3VSVNz6EKkAhN
	qnvdcff9LIwg2sepvWaAAUuW+8W6epZSn0pf8OvUXTengBd9rXlhg8+nd96TclMWBJOU=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xLBXj-000000003HO-3rcd;
	Mon, 26 Oct 2026 03:38:39 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <nzzhao.sigma@gmail.com>) id 1xLBXh-000000003H3-1oIX
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 26 Oct 2026 03:38:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=7oDoEqU57PNNhoXy/np/pZwkE7ArsywdT3eDblPhuWE=; b=RtKX+KPL3QdYId50hObsfEy68U
 CZ0KgmWv6IGzGRSePsdSNSN/cFhqE1sBKtjor60gLgqZLayf5nFt23LZjA6U9US4jTe6Nfj5WOZOk
 rHCXDf+GShdJ44Z8j0JWbg2txE68EITY8DznVe6FdMaXQ7+Doam0fFs/w6I1WohMFrSc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=7oDoEqU57PNNhoXy/np/pZwkE7ArsywdT3eDblPhuWE=; b=epZbeYwDbG7MTaOoBRvAE05A8b
 lCSLffLwNF4k4gIqIdR24XfDV/RRVNa+Nb1+ZyYnYSDMGIKfTNAEPMKAmUxzaS+a+AR/yHsrFgc3f
 c9f57A4I/me89WRQ7d1XQNcOkr79EjGgKLIdeTAOJFKdcTXp5dHqIwiMLhCBgnpMm2/Y=;
Received: from mail-pj2-f6.google.com ([74.125.227.134])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xLBXf-000000000fP-378Q
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 26 Oct 2026 03:38:37 +0000
Received: by mail-pj2-f6.google.com with SMTP id
 98e67ed59e1d1-3ad211ad92bso577900a91.1
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Sun, 25 Oct 2026 20:38:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792985910; x=1793590710; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=7oDoEqU57PNNhoXy/np/pZwkE7ArsywdT3eDblPhuWE=;
 b=J2axxMPGFie4s1BRLqODeVbHqI7j+2heNK7RxmM2nWPeFHmQhWcaIlJ34jZDWWbWQp
 49EWVUq4SPPv7iGbMUpsCKYDIAEzj4rdPRdsKEG8+2vlVSIXG+Y0Ac7WPWHSlphTIM1L
 WpZ5BwqgyvNjp3lbammdRl2NTJG5IMS2EHt5frLA3uW4+9VqOvSRQo49calcqz5EDC3K
 46Vh/67E4XNafubkBHh/yvAijpNMZiSBCvoGVC5YHM36geGxXsSoOsXyJT/4BRRll8hE
 WbtoYBQFPEtLj4+ANUmJdXCQ1Je1gXyznM1ZtLMo/wNEAGVEXCgGOQOwdGe/FFIs14ME
 +azw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792985910; x=1793590710;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=7oDoEqU57PNNhoXy/np/pZwkE7ArsywdT3eDblPhuWE=;
 b=XWm+Ts3mjk3UOUxLgCPy/wOMYnXBKWCFLCy6HWU1MZvuK9rZSVbem67eZerx1d5jmA
 Df2Ms+n/G0TTWM+M2K+wbyYgwpQydGNLAZme59O+0P+hOvGtu3uJisvEYwYk6qQ2hC+W
 HGOw2WWVzhBgG628LZYRmIsc1GQ33eR62rZdnrrKSAr9Uz48udqsClKpqypdP/Tjz1ov
 D1U0Y57FYJsqxNVi3rDRHl5dw7/R9nQ3nq1ih/EkisRYxRquM5En/v/qKmowSLaYVHRd
 xkUPBSo1aW0K3seSonFGYOR9638tulg1DEqx8JX6kDVrI6PIQq9E6x32I75fedTarfw8
 atnQ==
X-Gm-Message-State: AFq9FYI1xAVkLPi/m0Np1XjIgVxvf3WClXOfqaaBRbaSOihzGEenUdwj
 MQc5sLctMy8BmbCYRGvd45ENm6iFOZdOoumIwxJxPSywYket41WcJMJzdbyuDdH6rCxYkA==
X-Gm-Gg: AYBFou1gkbDTL4DpN2XGr3wZtW1+3BQdqY2BNqNDR/3bOxW0es0p1V3EJI+yLfa/mwL
 lKRclpA4Etv0kBgf6uNqxkxxLix0Tv8GUcDsKaC3i/GOGl9oFnGzAB2OE3UHSCeX34PjgSU3Zwd
 e8z1z0P3oUj0bUZKiR2FjN7LauZKC+A6/28cl507pGlRZWpTnDm3GpoewHlrqNlmKBfzOAubLi7
 WiBH66m0ZsqrdiAZm6D9y4+We+hz0M+aIS2pUUj4GBYuoNKWm/qUZxhWsKTUV9C4BLkngZd41yG
 B0UUi4yNfS/sSboPiK1OZr6lFFkEP0C5hywLR7mrLa0fd/vQMl/pXwlP5IqQ++HvFgRtAXX5S11
 uU30cmYP81TRpmjqlm6e/sDB/6TaCm5ycs2d4W4Bp5vtAyO1y/A8Fir5limcGBcOgZHVApLE9av
 Z9GrxHq0G77vC+yNRIdyHFuzT9oiTWHi2C/i3sotgeKTchqapVYutI4X1SD5YjdXgdhkXcZdqk+
 ixYp4DTs1GQGAR1nx1DAD3RcVs7RubmP+LvD0/fRCIa1CIdy8XdZsayvtu3yH+rF9SmX6dB4dQP
 fMsrQbmCn1SaAjqMibJ64zHVpzzhdmWTnqE7Boe3jflxLNyv2HPg1SuorfK/uDj1rx4=
X-Received: by 2002:a17:90b:35c6:b0:3ac:8897:7baa with SMTP id
 98e67ed59e1d1-3adeae64f23mr4224680a91.40.1792985909976; 
 Sun, 25 Oct 2026 20:38:29 -0700 (PDT)
Received: from nzzhao-ThinkCentre-M760t.mioffice.cn ([43.224.245.179])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3adebe8f0b2sm6409823a91.8.2026.10.25.20.38.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 Oct 2026 20:38:29 -0700 (PDT)
From: Nanzhe Zhao <nzzhao.sigma@gmail.com>
To: linux-f2fs-devel@lists.sourceforge.net, Jaegeuk Kim <jaegeuk@kernel.org>,
 Chao Yu <chao@kernel.org>
Date: Mon, 26 Oct 2026 11:37:38 +0800
Message-ID: <20261026033745.784107-9-nzzhao.sigma@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261026033745.784107-1-nzzhao.sigma@gmail.com>
References: <20261026033745.784107-1-nzzhao.sigma@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xLBXf-000000000fP-378Q
Subject: [f2fs-dev] [PATCH v7 08/15] f2fs: make GC migration large-folio
 aware
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

GC can operate on a 4K block that is cached inside a large folio.
The data lookup helpers therefore need to test and update uptodate
state for the addressed subpage instead of rejecting large folios or
treating the whole folio as the target block.

Let f2fs_get_read_data_folio() and f2fs_get_lock_data_folio() to use
subpage uptodate state. Submit single-block reads at the requested
folio offset and zero only the addressed 4K range for NEW_ADDR.

Also update `move_data_page` to mark, clear, and restore dirty
state for the target subpage, and submit write I/O with the subpage
offset recorded in f2fs_io_info.

The write_pages_pending reference is taken by f2fs_do_write_data_page()
and dropped from its common error path, so a block that is truncated
concurrently no longer leaks the counter.

Reported-by: kernel test robot <yi1.lai@intel.com>
Closes: https://lore.kernel.org/oe-lkp/202610081027.b13dcf10-lkp@intel.com
Signed-off-by: Nanzhe Zhao <zhaonanzhe@xiaomi.com>
---
 fs/f2fs/data.c    | 70 +++++++++++++++++++++++++++++++++--------------
 fs/f2fs/f2fs.h    |  1 +
 fs/f2fs/gc.c      | 28 +++++++++++++++----
 fs/f2fs/segment.c |  2 +-
 4 files changed, 75 insertions(+), 26 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index d027c949823b..b3ada22cb0cb 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -1679,20 +1679,16 @@ struct folio *f2fs_get_read_data_folio(struct inode *inode, pgoff_t index,
 	struct dnode_of_data dn;
 	struct folio *folio;
 	int err;
-retry:
+
 	folio = f2fs_grab_cache_folio(mapping, index, for_write);
 	if (IS_ERR(folio))
 		return folio;
 
 	if (folio_test_large(folio)) {
-		pgoff_t folio_index = mapping_align_index(mapping, index);
-		unsigned long nr_pages = folio_nr_pages(folio);
-
-		f2fs_folio_put(folio, true);
-		invalidate_inode_pages2_range(mapping, folio_index,
-				folio_index + nr_pages - 1);
-		f2fs_schedule_timeout(DEFAULT_SCHEDULE_TIMEOUT);
-		goto retry;
+		if (!f2fs_ffs_find_or_alloc(folio)) {
+			err = -ENOMEM;
+			goto put_err;
+		}
 	}
 
 	if (f2fs_lookup_read_extent_cache_block(inode, index,
@@ -1728,7 +1724,7 @@ struct folio *f2fs_get_read_data_folio(struct inode *inode, pgoff_t index,
 		goto put_err;
 	}
 got_it:
-	if (folio_test_uptodate(folio)) {
+	if (f2fs_ffs_test_blk_uptodate(folio, index)) {
 		folio_unlock(folio);
 		return folio;
 	}
@@ -1741,9 +1737,11 @@ struct folio *f2fs_get_read_data_folio(struct inode *inode, pgoff_t index,
 	 * f2fs_init_inode_metadata.
 	 */
 	if (dn.data_blkaddr == NEW_ADDR) {
-		folio_zero_segment(folio, 0, folio_size(folio));
-		if (!folio_test_uptodate(folio))
-			folio_mark_uptodate(folio);
+		size_t offset = offset_in_folio(folio,
+						(loff_t)index << PAGE_SHIFT);
+
+		folio_zero_segment(folio, offset, offset + PAGE_SIZE);
+		f2fs_ffs_mark_subrange_uptodate(folio, offset, PAGE_SIZE);
 		folio_unlock(folio);
 		return folio;
 	}
@@ -1803,7 +1801,6 @@ struct folio *f2fs_get_lock_data_folio(struct inode *inode, pgoff_t index,
 
 	/* wait for read completion */
 	folio_lock(folio);
-
 	if (unlikely(folio->mapping != mapping)) {
 		f2fs_folio_put(folio, true);
 		return ERR_PTR(-EIO);
@@ -1812,7 +1809,7 @@ struct folio *f2fs_get_lock_data_folio(struct inode *inode, pgoff_t index,
 	/*
 	 * ffs can be released while the folio was unlocked above.  Rebuild it
 	 * for a fully uptodate folio; a partially uptodate one cannot be
-	 * rebuilt and will fail the uptodate check below.
+	 * rebuilt and will fail the subpage check below.
 	 */
 	if (folio_test_large(folio) && !f2fs_folio_has_ffs(folio)) {
 		if (!f2fs_ffs_find_or_alloc(folio)) {
@@ -1821,7 +1818,7 @@ struct folio *f2fs_get_lock_data_folio(struct inode *inode, pgoff_t index,
 		}
 	}
 
-	if (unlikely(!folio_test_uptodate(folio))) {
+	if (unlikely(!f2fs_ffs_test_blk_uptodate(folio, index))) {
 		f2fs_folio_put(folio, true);
 		return ERR_PTR(-EIO);
 	}
@@ -2970,6 +2967,22 @@ static void f2fs_ffs_mark_subrange_uptodate(struct folio *folio, size_t offset,
 		folio_mark_uptodate(folio);
 }
 
+bool f2fs_ffs_test_blk_dirty(const struct folio *folio, pgoff_t index)
+{
+	struct f2fs_folio_state *ffs;
+	unsigned int idx, nr_subpages;
+
+	f2fs_bug_on(F2FS_F_SB(folio), !folio_contains(folio, index));
+
+	if (!f2fs_folio_has_ffs(folio))
+		return folio_test_dirty(folio);
+
+	ffs = (struct f2fs_folio_state *)folio->private;
+	nr_subpages = folio_nr_pages(folio);
+	idx = index - folio->index;
+	return test_bit(nr_subpages + idx, ffs->state);
+}
+
 static unsigned int __ffs_mark_subrange_dirty(struct folio *folio,
 			struct f2fs_folio_state *ffs, size_t offset, size_t len)
 {
@@ -3063,7 +3076,6 @@ bool f2fs_ffs_clear_subrange_dirty_and_test(struct folio *folio, size_t offset,
 
 	return dirty;
 }
-
 static unsigned int ffs_next_dirty_subpage(struct f2fs_folio_state *ffs,
 			const struct folio *folio, unsigned int start,
 			unsigned int end)
@@ -3561,7 +3573,7 @@ bool f2fs_should_update_outplace(struct inode *inode, struct f2fs_io_info *fio)
 		return true;
 
 	if (fio) {
-		if (page_private_gcing(fio->page))
+		if (folio_test_f2fs_gcing(fio->folio))
 			return true;
 		if (unlikely(is_sbi_flag_set(sbi, SBI_CP_DISABLED) &&
 			f2fs_is_checkpointed_data(sbi, fio->old_blkaddr)))
@@ -3587,8 +3599,11 @@ int f2fs_do_write_data_page(struct f2fs_io_info *fio)
 	struct dnode_of_data dn;
 	struct node_info ni;
 	struct f2fs_lock_context lc;
+	struct f2fs_folio_state *ffs;
 	bool ipu_force = false;
 	bool atomic_commit;
+	bool pending_added = false;
+	bool submitted = false;
 	int err = 0;
 
 	/* Use COW inode to make dnode_of_data for atomic write */
@@ -3617,8 +3632,11 @@ int f2fs_do_write_data_page(struct f2fs_io_info *fio)
 		return -EINVAL;
 
 	/* Deadlock due to between page->lock and f2fs_lock_op */
-	if (fio->need_lock == LOCK_REQ && !f2fs_trylock_op(fio->sbi, &lc))
+	if (fio->need_lock == LOCK_REQ && !f2fs_trylock_op(fio->sbi, &lc)) {
+		if (!f2fs_ffs_has_dirty_subpage(folio))
+			folio_clear_f2fs_gcing(folio);
 		return -EAGAIN;
+	}
 
 	err = f2fs_get_dnode_of_data(&dn, F2FS_FIO_LBLK(fio),
 				     LOOKUP_NODE);
@@ -3630,7 +3648,6 @@ int f2fs_do_write_data_page(struct f2fs_io_info *fio)
 	/* This page is already truncated */
 	if (fio->old_blkaddr == NULL_ADDR) {
 		folio_clear_uptodate(folio);
-		folio_clear_f2fs_gcing(folio);
 		goto out_writepage;
 	}
 got_it:
@@ -3680,6 +3697,11 @@ int f2fs_do_write_data_page(struct f2fs_io_info *fio)
 	fio->version = ni.version;
 
 	__folio_start_writeback(folio, folio_test_dirty(folio));
+	if (f2fs_folio_has_ffs(folio)) {
+		ffs = (struct f2fs_folio_state *)folio->private;
+		atomic_inc(&ffs->write_pages_pending);
+		pending_added = true;
+	}
 
 	if (fio->compr_blocks && fio->old_blkaddr == COMPRESS_ADDR)
 		f2fs_i_compr_blocks_update(inode, fio->compr_blocks - 1, false);
@@ -3694,6 +3716,7 @@ int f2fs_do_write_data_page(struct f2fs_io_info *fio)
 		err = -EIO;
 		goto out_writepage;
 	}
+	submitted = true;
 	set_inode_flag(inode, FI_APPEND_WRITE);
 	if (atomic_commit)
 		folio_clear_f2fs_atomic(folio);
@@ -3702,6 +3725,13 @@ int f2fs_do_write_data_page(struct f2fs_io_info *fio)
 out:
 	if (fio->need_lock == LOCK_REQ)
 		f2fs_unlock_op(fio->sbi, &lc);
+	if (!submitted) {
+		if (pending_added) {
+			f2fs_ffs_put_write_pending(folio, 1);
+		} else if (!f2fs_ffs_has_dirty_subpage(folio)) {
+			folio_clear_f2fs_gcing(folio);
+		}
+	}
 	return err;
 }
 
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 915ca72cf276..1b63dd961f15 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -4493,6 +4493,7 @@ int f2fs_write_single_data_page(struct folio *folio, int *submitted,
 				int compr_blocks, bool allow_balance);
 bool f2fs_ffs_test_blk_uptodate(const struct folio *folio, pgoff_t index);
 struct f2fs_folio_state *f2fs_ffs_find_or_alloc(struct folio *folio);
+bool f2fs_ffs_test_blk_dirty(const struct folio *folio, pgoff_t index);
 void f2fs_ffs_mark_subrange_dirty(struct folio *folio, size_t offset, size_t len);
 bool f2fs_ffs_clear_subrange_dirty_and_test(struct folio *folio, size_t offset,
 					    size_t len);
diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index c66ca03d0d5a..c3e01f6811b4 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -1520,12 +1520,19 @@ static int move_data_page(struct inode *inode, block_t bidx, int gc_type,
 						unsigned int segno, int off)
 {
 	struct folio *folio;
+	size_t foff = 0;
+	bool large = false;
 	int err = 0;
 
 	folio = f2fs_get_lock_data_folio(inode, bidx, true);
 	if (IS_ERR(folio))
 		return PTR_ERR(folio);
 
+	if (f2fs_folio_has_ffs(folio)) {
+		large = true;
+		foff = offset_in_folio(folio, (loff_t)bidx << PAGE_SHIFT);
+	}
+
 	if (!check_valid_map(F2FS_I_SB(inode), segno, off)) {
 		err = -ENOENT;
 		goto out;
@@ -1540,6 +1547,8 @@ static int move_data_page(struct inode *inode, block_t bidx, int gc_type,
 			err = -EAGAIN;
 			goto out;
 		}
+		if (large)
+			f2fs_ffs_mark_subrange_dirty(folio, foff, PAGE_SIZE);
 		folio_mark_dirty(folio);
 		folio_set_f2fs_gcing(folio);
 	} else {
@@ -1558,28 +1567,37 @@ static int move_data_page(struct inode *inode, block_t bidx, int gc_type,
 			.need_lock = LOCK_REQ,
 			.io_type = FS_GC_DATA_IO,
 		};
-		bool is_dirty = folio_test_dirty(folio);
+		bool is_dirty = f2fs_ffs_test_blk_dirty(folio, bidx);
 
 retry:
 		f2fs_folio_wait_writeback(folio, true, true);
 
+		if (large)
+			f2fs_ffs_mark_subrange_dirty(folio, foff, PAGE_SIZE);
 		folio_mark_dirty(folio);
 		if (folio_clear_dirty_for_io(folio)) {
-			inode_dec_dirty_block(inode);
-			f2fs_remove_dirty_inode(inode);
+			if (!large) {
+				inode_dec_dirty_block(inode);
+				f2fs_remove_dirty_inode(inode);
+			} else if (f2fs_ffs_clear_subrange_dirty_and_test(folio,
+							foff, PAGE_SIZE)) {
+				folio_mark_dirty(folio);
+			}
 		}
 
 		folio_set_f2fs_gcing(folio);
 
 		err = f2fs_do_write_data_page(&fio);
 		if (err) {
-			folio_clear_f2fs_gcing(folio);
 			if (err == -ENOMEM) {
 				memalloc_retry_wait(GFP_NOFS);
 				goto retry;
 			}
-			if (is_dirty)
+			if (is_dirty) {
+				if (large)
+					f2fs_ffs_mark_subrange_dirty(folio, foff, PAGE_SIZE);
 				folio_mark_dirty(folio);
+			}
 		}
 	}
 out:
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index cbb65e0343c8..e017a5f2a67f 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -3863,7 +3863,7 @@ static int __get_segment_type_6(struct f2fs_io_info *fio)
 		if (is_inode_flag_set(inode, FI_ALIGNED_WRITE))
 			return CURSEG_COLD_DATA_PINNED;
 
-		if (page_private_gcing(fio->page)) {
+		if (folio_test_f2fs_gcing(fio->folio)) {
 			if (fio->sbi->am.atgc_enabled &&
 				(fio->io_type == FS_DATA_IO) &&
 				(fio->sbi->gc_mode != GC_URGENT_HIGH) &&
-- 
2.43.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
