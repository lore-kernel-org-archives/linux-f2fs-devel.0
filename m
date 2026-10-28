Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF74A60A381C
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 28 Oct 2026 15:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=QDPOnzMb;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=nSouSa5C;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=cObgX4h/;
	dkim=neutral header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tbKucFbK
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:List-Owner;
	bh=/e2HwN7f4/GYprsIxMSnOEHakzgo0grzgSkf0KefkkM=; b=QDPOnzMbRrQ3vsARDKviD7uvoH
	8cszFzqqn5xYxphUIKiYuNbzp1RdnaYJb8/2Naf66uTM9n+CigrO4wwkiuB3p6HFyuLc+r7HgZb6G
	MhJqqsC8EEXYeswAFiB5dzmiD5EcnQUyCqsVFOuVW+8CAFcQ2G9dabPRr6FMYwTZ3EZk=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xM5pq-000000001t4-2ei9;
	Wed, 28 Oct 2026 15:45:06 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <nzzhao.sigma@gmail.com>) id 1xM5pp-000000001sr-2dXN
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 28 Oct 2026 15:45:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=vffwMS4HeaCkClJ+JwZt+OcdLFIE7CJ+0mO1DPsWdEc=; b=nSouSa5CGbWJjtZMw0Rl2KYKUi
 y+5CcZudp1fq54a7oI+jOrqBD21UKatFraGqZnuNcsI6hEJGQvVUfu1T+rXxXeN/zAgBwY4+vpLZA
 IAKkpu5h1D56LOYjS2V1lKbexqHL5j3cJhWG1n6ktDm8sYa4yFzjDF3eJgsMrxyyGJGc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=vffwMS4HeaCkClJ+JwZt+OcdLFIE7CJ+0mO1DPsWdEc=; b=cObgX4h/GJCvJf+JGCKiVgycCR
 cHCecbF2u6HwFzXYolQrAgDb8eGoRlXL/Ct4PY9erRsyhCSRVnN2Yx3LjgKv7qjtrowxfWfzYQpwo
 nCM/Zzi/mlEW7QxX11Q0xDmgE8mzPE/yzR5cqCaOLKq40ONV/oWe5MRNAxr2s2ccMX70=;
Received: from mail-pj2-f8.google.com ([74.125.227.136])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xM5pn-000000002Ms-0S1c
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 28 Oct 2026 15:45:05 +0000
Received: by mail-pj2-f8.google.com with SMTP id
 d9443c01a7336-2e609985789so3244735ad.1
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed, 28 Oct 2026 08:45:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793202297; x=1793807097; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=vffwMS4HeaCkClJ+JwZt+OcdLFIE7CJ+0mO1DPsWdEc=;
 b=tbKucFbKUThIwdX/rKn5rh4t6tx1NOLtzHdp63bd5xyTg5mbqMkFW+TXx2sG8M9RFi
 sz9pPla9Zx16r1eoxggDAD0I6R8LQ6KBYd39/3auSjjdJZdCdU2KxkqKeX0p6cldd9Kv
 5CstMxz436T7whOwktoU08s65lxM0pmCoWQOzl4YchjC0p4iSK4s2z5MNufd0IdRVML1
 NcSvTTGcU9DCITNRN4hM1gpsO3YMlxb38AkQEAsm8M7KF6EdyIlnpEX8ChltWkrCWPOU
 1e7N9PR9Ck5YSKEkblNOVEBEV+PyEnSFxegPuRpKb3jzfB/fpMJ3y2SpnqACONMxPgzy
 Hj/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793202297; x=1793807097;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=vffwMS4HeaCkClJ+JwZt+OcdLFIE7CJ+0mO1DPsWdEc=;
 b=x/cb4lUp9NOGZUNZdiPCkaJhmAlbsSV9tT9/lx1pRUHziRDasv9W2tYXZZCcFuGBNQ
 agX4jJs02LKDIVeJ5Pe+ofY1iZDmbTEHlqETsd88DJprr4ootb+1mfpD+Y71wcfLxnZd
 bkr1LzCsXdnCHcfcMF9nT7VnsXElKTn4Gy+jqQNhde1Pt/nAqLV12mpGNcwraOzy/qFr
 tTR3/x+jOtebQEuL4+fN07H1gr/zydCFuPd8hindLx3giYkY43GDg8C5vfFRvsCG/Asy
 2UMNsmIrkIsDJYwEAf6fBMy+jIr3so6NltUUcSeMvpU2iK4HRaazeE/HD0RNJ/vZ51FZ
 r1PQ==
X-Gm-Message-State: AFq9FYLfXtb1nIzWEMlykCWiDuQ6d983p6qJs3J/fx0uP618TTDCwLIU
 pIN0nQWaB8zhP5HMhUYUrYUuRgzkCH/5I9L8dLyDowswwmyjS5JVnGm3mjacpDC7d/s=
X-Gm-Gg: AYBFou3+Gq1rlyR3eskJLEUDdq+TSkppuqy8i4GFNK+TTfz7l7NminntpkbvbmIhcdw
 j8PTqnNO+znHV2Cxae6102DjNoDfsrpAZQzTIO6QY334huFc/qDxyGp1zHxJRKI/WJoxaIBs8l+
 WFcJCNwLdO0eYHyHiXAuFeum697R9QOnEGmBcbqCWj9Sb4OjaUjGhcpgpOI1a1Hd6BFhhcNjaRY
 Gj4VnnMjroyqVqs51aN9qoPIpNsSuPKEtkeIZ+z7J8hMAiQru4FC/ZIb8WnqTglaB3wyqqkqE9x
 xfEMOT1n08qh5ilemEPo3hBdB3jN4B74mE0JGIjCCCm8pP5epB35h0QQ25rZU6ld30qNVUNAbAO
 GxBKI+xamTwNqheGIYeUDaxvqInYuKUVHARlXv5v7w4K67lsOMgxFlbxfcioSdTmA1g7en8mfXh
 0T8t/qa1noKFg8bAok2jEFVOuvvdMsan4tHY0FrI8Erx3+jyp3hDBfjS1Izlo2MD9GfAt4hmlnT
 WUvIcwmo14zwJyfmfYTEc27prLyMh0VYoP8nobdXGhjqpfubdmm8byRRpVmusWUBMQKrsKFGMP5
 Xr4kyWunjUT7OptsCrW5atRMDBZLhOStuPr3aGmkIE3NzzQJZdWM567BbiChGJ3dBXY=
X-Received: by 2002:a17:903:2a83:b0:2e6:913:57ed with SMTP id
 d9443c01a7336-2eb004f318emr25410335ad.14.1793202297314; 
 Wed, 28 Oct 2026 08:44:57 -0700 (PDT)
Received: from nzzhao-ThinkCentre-M760t.mioffice.cn ([43.224.245.179])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2eae6be5105sm24111655ad.37.2026.10.28.08.44.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2026 08:44:56 -0700 (PDT)
From: Nanzhe Zhao <nzzhao.sigma@gmail.com>
To: linux-f2fs-devel@lists.sourceforge.net, Jaegeuk Kim <jaegeuk@kernel.org>,
 Chao Yu <chao@kernel.org>
Date: Wed, 28 Oct 2026 23:43:59 +0800
Message-ID: <20261028154407.1601430-9-nzzhao.sigma@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261028154407.1601430-1-nzzhao.sigma@gmail.com>
References: <20261028154407.1601430-1-nzzhao.sigma@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xM5pn-000000002Ms-0S1c
Subject: [f2fs-dev] [PATCH v8 08/15] f2fs: make GC migration large-folio
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
 kernel test robot <yi1.lai@intel.com>, Dev Jain <Dev.Jain@arm.com>,
 David Hildenbrand <David.Hildenbrand@arm.com>,
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
 fs/f2fs/data.c    | 72 ++++++++++++++++++++++++++++++++++-------------
 fs/f2fs/f2fs.h    |  2 ++
 fs/f2fs/file.c    |  3 ++
 fs/f2fs/gc.c      | 47 +++++++++++++++++++++++++++----
 fs/f2fs/segment.c |  2 +-
 5 files changed, 100 insertions(+), 26 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 6040bda749b7..039916bad57b 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -364,7 +364,7 @@ static void f2fs_cache_write_end_bio(struct bio *bio)
 	bio_put(bio);
 }
 
-static bool f2fs_ffs_has_dirty_subpage(struct folio *folio)
+bool f2fs_ffs_has_dirty_subpage(struct folio *folio)
 {
 	struct f2fs_folio_state *ffs;
 	unsigned long flags;
@@ -1685,20 +1685,16 @@ struct folio *f2fs_get_read_data_folio(struct inode *inode, pgoff_t index,
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
@@ -1734,7 +1730,7 @@ struct folio *f2fs_get_read_data_folio(struct inode *inode, pgoff_t index,
 		goto put_err;
 	}
 got_it:
-	if (folio_test_uptodate(folio)) {
+	if (f2fs_ffs_test_blk_uptodate(folio, index)) {
 		folio_unlock(folio);
 		return folio;
 	}
@@ -1747,9 +1743,11 @@ struct folio *f2fs_get_read_data_folio(struct inode *inode, pgoff_t index,
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
@@ -1809,7 +1807,6 @@ struct folio *f2fs_get_lock_data_folio(struct inode *inode, pgoff_t index,
 
 	/* wait for read completion */
 	folio_lock(folio);
-
 	if (unlikely(folio->mapping != mapping)) {
 		f2fs_folio_put(folio, true);
 		return ERR_PTR(-EIO);
@@ -1818,7 +1815,7 @@ struct folio *f2fs_get_lock_data_folio(struct inode *inode, pgoff_t index,
 	/*
 	 * ffs can be released while the folio was unlocked above.  Rebuild it
 	 * for a fully uptodate folio; a partially uptodate one cannot be
-	 * rebuilt and will fail the uptodate check below.
+	 * rebuilt and will fail the subpage check below.
 	 */
 	if (folio_test_large(folio) && !f2fs_folio_has_ffs(folio)) {
 		if (!f2fs_ffs_find_or_alloc(folio)) {
@@ -1827,7 +1824,7 @@ struct folio *f2fs_get_lock_data_folio(struct inode *inode, pgoff_t index,
 		}
 	}
 
-	if (unlikely(!folio_test_uptodate(folio))) {
+	if (unlikely(!f2fs_ffs_test_blk_uptodate(folio, index))) {
 		f2fs_folio_put(folio, true);
 		return ERR_PTR(-EIO);
 	}
@@ -2976,6 +2973,22 @@ static void f2fs_ffs_mark_subrange_uptodate(struct folio *folio, size_t offset,
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
@@ -3069,7 +3082,6 @@ bool f2fs_ffs_clear_subrange_dirty_and_test(struct folio *folio, size_t offset,
 
 	return dirty;
 }
-
 static unsigned int ffs_next_dirty_subpage(struct f2fs_folio_state *ffs,
 			const struct folio *folio, unsigned int start,
 			unsigned int end)
@@ -3567,7 +3579,7 @@ bool f2fs_should_update_outplace(struct inode *inode, struct f2fs_io_info *fio)
 		return true;
 
 	if (fio) {
-		if (page_private_gcing(fio->page))
+		if (folio_test_f2fs_gcing(fio->folio))
 			return true;
 		if (unlikely(is_sbi_flag_set(sbi, SBI_CP_DISABLED) &&
 			f2fs_is_checkpointed_data(sbi, fio->old_blkaddr)))
@@ -3593,8 +3605,11 @@ int f2fs_do_write_data_page(struct f2fs_io_info *fio)
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
@@ -3636,7 +3651,8 @@ int f2fs_do_write_data_page(struct f2fs_io_info *fio)
 	/* This page is already truncated */
 	if (fio->old_blkaddr == NULL_ADDR) {
 		folio_clear_uptodate(folio);
-		folio_clear_f2fs_gcing(folio);
+		if (!f2fs_ffs_has_dirty_subpage(folio))
+			folio_clear_f2fs_gcing(folio);
 		goto out_writepage;
 	}
 got_it:
@@ -3686,6 +3702,11 @@ int f2fs_do_write_data_page(struct f2fs_io_info *fio)
 	fio->version = ni.version;
 
 	__folio_start_writeback(folio, folio_test_dirty(folio));
+	if (f2fs_folio_has_ffs(folio)) {
+		ffs = (struct f2fs_folio_state *)folio->private;
+		atomic_inc(&ffs->write_pages_pending);
+		pending_added = true;
+	}
 
 	if (fio->compr_blocks && fio->old_blkaddr == COMPRESS_ADDR)
 		f2fs_i_compr_blocks_update(inode, fio->compr_blocks - 1, false);
@@ -3700,6 +3721,7 @@ int f2fs_do_write_data_page(struct f2fs_io_info *fio)
 		err = -EIO;
 		goto out_writepage;
 	}
+	submitted = true;
 	set_inode_flag(inode, FI_APPEND_WRITE);
 	if (atomic_commit)
 		folio_clear_f2fs_atomic(folio);
@@ -3708,6 +3730,13 @@ int f2fs_do_write_data_page(struct f2fs_io_info *fio)
 out:
 	if (fio->need_lock == LOCK_REQ)
 		f2fs_unlock_op(fio->sbi, &lc);
+	/*
+	 * Do not clear gcing flag on failure here: the caller will redirty
+	 * the folio and keep the flag so that it can be guaranteed by
+	 * checkpoint, or drop the flag by itself, e.g. move_data_page().
+	 */
+	if (!submitted && pending_added)
+		f2fs_ffs_put_write_pending(folio, 1);
 	return err;
 }
 
@@ -5510,6 +5539,9 @@ static int f2fs_migrate_blocks(struct inode *inode, block_t start_blk,
 				goto done;
 			}
 
+			f2fs_ffs_mark_subrange_dirty(folio,
+				offset_in_folio(folio, (loff_t)blkidx << PAGE_SHIFT),
+				PAGE_SIZE);
 			folio_mark_dirty(folio);
 			f2fs_folio_put(folio, true);
 		}
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 328c3ff36b47..e20805d4a099 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -4504,7 +4504,9 @@ int f2fs_write_single_data_page(struct folio *folio, int *submitted,
 				int compr_blocks, bool allow_balance);
 bool f2fs_ffs_test_blk_uptodate(const struct folio *folio, pgoff_t index);
 struct f2fs_folio_state *f2fs_ffs_find_or_alloc(struct folio *folio);
+bool f2fs_ffs_test_blk_dirty(const struct folio *folio, pgoff_t index);
 void f2fs_ffs_mark_subrange_dirty(struct folio *folio, size_t offset, size_t len);
+bool f2fs_ffs_has_dirty_subpage(struct folio *folio);
 bool f2fs_ffs_clear_subrange_dirty_and_test(struct folio *folio, size_t offset,
 					    size_t len);
 void f2fs_write_failed(struct inode *inode, loff_t to);
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 33964da53584..ef9b9baa1a79 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -3182,6 +3182,9 @@ static int f2fs_defragment_range(struct f2fs_sb_info *sbi,
 
 			f2fs_folio_wait_writeback(folio, true, true);
 
+			f2fs_ffs_mark_subrange_dirty(folio,
+				offset_in_folio(folio, (loff_t)idx << PAGE_SHIFT),
+				PAGE_SIZE);
 			folio_mark_dirty(folio);
 			folio_set_f2fs_gcing(folio);
 			f2fs_folio_put(folio, true);
diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index c66ca03d0d5a..337ecf4df945 100644
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
@@ -1558,28 +1567,56 @@ static int move_data_page(struct inode *inode, block_t bidx, int gc_type,
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
+				/*
+				 * Keep gcing flag for redirtied folio, so that
+				 * it can be guaranteed by checkpoint.
+				 */
+				if (large)
+					f2fs_ffs_mark_subrange_dirty(folio, foff, PAGE_SIZE);
 				folio_mark_dirty(folio);
+				folio_set_f2fs_gcing(folio);
+			} else if (!f2fs_ffs_has_dirty_subpage(folio)) {
+				/* migrate this block in later GC */
+				folio_clear_f2fs_gcing(folio);
+			}
+		} else if (large && folio_test_dirty(folio)) {
+			/*
+			 * The folio is left both dirty and under writeback,
+			 * submit the cached bio before unlocking it, otherwise
+			 * a WB_SYNC_ALL writer may lock the folio and wait on
+			 * its writeback in folio_prepare_writeback(), while we
+			 * are blocked on folio_lock() for the next block of the
+			 * same folio, before the bio is submitted.
+			 */
+			f2fs_submit_merged_write_cond(F2FS_I_SB(inode), NULL,
+							folio);
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
