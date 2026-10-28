Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19604606C05C
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 28 Oct 2026 15:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=fGTpAMFA;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=ik9UlTL/;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=EFY/spCy;
	dkim=neutral header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Vedkqx4U
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:List-Owner;
	bh=wJPphBbP04eQ8vpZ6GfDNh5h+9wntDLGyC9i4Hut0dE=; b=fGTpAMFA+A/JvUC5CiJz7D/cMz
	QLD/4ff5HnJdIbRmjf8EKZn2f4HNz1WdI6xm1kSt/vtW+Ncyg9JizEaHV+ocTwKvE6LmqBwGgkln6
	HwvqMpMuZ8d2IBlEDWyPvJdsRgFVMPVUiNSyqp/M9WkRkbLZ82Wl5YFSN8gBIpOMLksc=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xM5pa-000000002kW-3UPY;
	Wed, 28 Oct 2026 15:44:50 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <nzzhao.sigma@gmail.com>) id 1xM5pZ-000000002kO-1ovB
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 28 Oct 2026 15:44:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=RnGNc+Ncv3PAPhA2y8pB7rHYUMviqJQ7ga8Bc0zRWFc=; b=ik9UlTL/H7RfXDkVrACeGH0ogk
 W+p4uaNLgbBeWvlP6MXsUKpqoTQ/jXKfA1BdLwRwHiDgUp7DPMVyutkgQSpRU/JflhFZTN5MhXVnG
 Fdml8caTpFBGAVjrz/YZTgrigtEXxj/vNfFu7Jv/IdjMTbiVmvwcYSR/0MSNABs10gCc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=RnGNc+Ncv3PAPhA2y8pB7rHYUMviqJQ7ga8Bc0zRWFc=; b=EFY/spCyBaaCidZjXnu0JUMcfx
 B1MI1V303FjA23oqANsESO/xIOpBUEUiyesdtZrRB66d2ki704VQxWmGZPPyI3l8By6JbJbxC2Iev
 wyU11HAmr+vG2ed+AtPKk/bpet9Q9KXJiqqdnTYaz6drVIniM0BzYcgwl2aEOnEPB2A0=;
Received: from mail-pj2-f3.google.com ([74.125.227.131])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xM5pY-000000002ML-0nVi
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 28 Oct 2026 15:44:49 +0000
Received: by mail-pj2-f3.google.com with SMTP id
 d9443c01a7336-2e831901331so8736055ad.1
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed, 28 Oct 2026 08:44:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793202282; x=1793807082; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=RnGNc+Ncv3PAPhA2y8pB7rHYUMviqJQ7ga8Bc0zRWFc=;
 b=Vedkqx4U1e1dgYx4zw/wegk5Y7T3SLYdSkzdWVyZbtZxKbrOUm/LjbmgLT+Oae6bcU
 PnZWE66x71CyJC8TTXrPtD0FylGWo7Rbig9fHOXCECA1WMlx3ajItmf8eGzTPscNFkYv
 L5g5V4gNjz2agB4CfEMwzZNpX3diSuBXIemV+LfDDgq8tFGEZUS1ZsLT7mEH/h7k3bDk
 X/23xEGeH0RAMNQ7wq1Il3zjppF/cZNRUELTPpqJAhGaFg+7XYib190aiPxyyXCdfNNd
 w/ovhMeXib1alOm7q4dmHXInd0l5epEZdecriU/RiS2CcIAi4DD2V+eJqPbwNNQNK3R1
 YdGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793202282; x=1793807082;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=RnGNc+Ncv3PAPhA2y8pB7rHYUMviqJQ7ga8Bc0zRWFc=;
 b=ADjqQuk/Nj+tUOgAqyvfNizFvGeFnjpBzSFyYeoxWRyHKNG+wDEUIzDbpeZWJSXUkD
 TefeimGZifhLynLtZe90Ki/txVlXvr/sybbv0Ee1oyFak8AYUh4U+zAa6jfROwDpLNS1
 5M5JHubm4EYiBbrdetaxh5TkYSlWLDcnZD/3HhKnfYFfvqMPPX6bEg9mMYUp0kSSBzbK
 71qtrZDc4jhpwiSVMku1l/WhInD9xUvG+GnU1effGZu3Z9+E8FJr/n9RyRbHsAzAlT48
 n0BiwBAlR662i6MTsu3xYdSnEkY7Bz7d4Z1Y8jwfmVRj6G4JIMi5dQH25hQlxKEvIwLb
 FBLA==
X-Gm-Message-State: AFq9FYJU5erGk5wawpZ1U2QyblW8gnGQ9Rv78+ugEMp9OQow5xOdssOO
 VLmjYg4yWi3QeUMXRLOC/AGzHijEkP6pfIrhrex6G2y8XgQ/wMZtcMBM+o8T//01G/0=
X-Gm-Gg: AYBFou2qRt7+umjpdeymUdVjCqZJfmh1byjwjqWVQ0bMiphpi4gpkD5cid1ZWZFJn2n
 tdn619YLoLPYw2iAm1pwEtA2Ri18SI3WCkK43XFWa/pVd4Ces2sfbypFaILE+fZ0z51S9z1drAe
 maznRnb2IbNb42j/IC0wgpO87lihc1Kvq7hMB5RolsfUwIjW8dRPu6PLVZAhDHg8tK2/yOoYzpy
 xpc+YBKd2CXLvQ2LT3xVs/JYszAOWa2Pvh1pqI8jI6huX3fSOTbG19idN9soG/x3I5T2Cn9EBuk
 i2lWEiyggXsNwTd/uTvPbtPBwE71rcm30GUMXDhaqRnHs6+71c7ZKlJJUZINGDkcyYRUORVnMDz
 ZiQJnC3gj7VwXEKU7+mi2nbmCbKC1xNpKIQ3s3SL7vQbLYB9dhZbcIJCRalE8f/f7l79HcXTkxv
 Yvg9VxPhmSQrcquYyryc4JOS1Uzn1b3g8VU2+dcpD1BAz1zXRHipjaexHY/ep7HHB8RcwjjyMRw
 8pnLcm27dIr5eVQ0ylg2Tja/vAuNOID3ebs/ES+f24ZhKLL41NyG8MyM+YnLPw0czier3VRQAn7
 Td4rcwoz6qhEBAmkCoiQeg8Adg6L/F9IDRBlhTSZceUvFfDA0fZOMGmAVLDopPKcWWY=
X-Received: by 2002:a17:902:e946:b0:2e9:c569:7050 with SMTP id
 d9443c01a7336-2eb005772a7mr23369535ad.47.1793202282321; 
 Wed, 28 Oct 2026 08:44:42 -0700 (PDT)
Received: from nzzhao-ThinkCentre-M760t.mioffice.cn ([43.224.245.179])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2eae6be5105sm24111655ad.37.2026.10.28.08.44.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2026 08:44:41 -0700 (PDT)
From: Nanzhe Zhao <nzzhao.sigma@gmail.com>
To: linux-f2fs-devel@lists.sourceforge.net, Jaegeuk Kim <jaegeuk@kernel.org>,
 Chao Yu <chao@kernel.org>
Date: Wed, 28 Oct 2026 23:43:56 +0800
Message-ID: <20261028154407.1601430-6-nzzhao.sigma@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261028154407.1601430-1-nzzhao.sigma@gmail.com>
References: <20261028154407.1601430-1-nzzhao.sigma@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xM5pY-000000002ML-0nVi
Subject: [f2fs-dev] [PATCH v8 05/15] f2fs: support large folio writeback
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

Large folio can contain multiple dirty ranges.
Add a folio-based writeback path for large-folio mapping files
and keep the legacy f2fs_write_cache_pages() path unchanged for
non large-folio mapping files.

Signed-off-by: Nanzhe Zhao <zhaonanzhe@xiaomi.com>
---
 fs/f2fs/data.c    | 533 +++++++++++++++++++++++++++++++++++++++++++++-
 fs/f2fs/segment.c |   8 +-
 2 files changed, 533 insertions(+), 8 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index fbffe4c56090..1faff6f4621d 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -364,6 +364,49 @@ static void f2fs_cache_write_end_bio(struct bio *bio)
 	bio_put(bio);
 }
 
+static bool f2fs_ffs_has_dirty_subpage(struct folio *folio)
+{
+	struct f2fs_folio_state *ffs;
+	unsigned long flags;
+	unsigned int nr_subpages;
+	bool dirty;
+
+	if (!f2fs_folio_has_ffs(folio))
+		return false;
+
+	ffs = (struct f2fs_folio_state *)folio->private;
+	nr_subpages = folio_nr_pages(folio);
+
+	spin_lock_irqsave(&ffs->state_lock, flags);
+	dirty = find_next_bit(ffs->state, 2 * nr_subpages,
+				nr_subpages) < 2 * nr_subpages;
+	spin_unlock_irqrestore(&ffs->state_lock, flags);
+
+	return dirty;
+}
+
+/*
+ * Drop a write page pending of @folio.  When the last pending is gone,
+ * clear PAGE_PRIVATE_GCING if no dirty subpage is left, and end
+ * writeback if it was started.
+ */
+static void f2fs_ffs_put_write_pending(struct folio *folio, unsigned int nr)
+{
+	struct f2fs_folio_state *ffs;
+
+	if (!f2fs_folio_has_ffs(folio))
+		goto release;
+
+	ffs = (struct f2fs_folio_state *)folio->private;
+	if (!atomic_sub_and_test(nr, &ffs->write_pages_pending))
+		return;
+release:
+	if (!f2fs_ffs_has_dirty_subpage(folio))
+		folio_clear_f2fs_gcing(folio);
+	if (folio_test_writeback(folio))
+		folio_end_writeback(folio);
+}
+
 static void f2fs_write_end_bio(struct bio *bio)
 {
 	struct f2fs_sb_info *sbi = bio->bi_private;
@@ -379,6 +422,8 @@ static void f2fs_write_end_bio(struct bio *bio)
 
 	bio_for_each_folio_all(fi, bio) {
 		struct folio *folio = fi.folio;
+		unsigned int nr_pages = fi.length >> PAGE_SHIFT;
+		unsigned int npages = nr_pages;
 		enum count_type type;
 
 #ifdef CONFIG_F2FS_FS_COMPRESSION
@@ -398,7 +443,8 @@ static void f2fs_write_end_bio(struct bio *bio)
 			}
 		}
 
-		dec_cache_count(sbi, type);
+		while (nr_pages--)
+			dec_cache_count(sbi, type);
 
 		/*
 		 * we should access sbi before folio_end_writeback() to
@@ -408,8 +454,7 @@ static void f2fs_write_end_bio(struct bio *bio)
 				wq_has_sleeper(&sbi->cp_wait))
 			wake_up(&sbi->cp_wait);
 
-		folio_clear_f2fs_gcing(folio);
-		folio_end_writeback(folio);
+		f2fs_ffs_put_write_pending(folio, npages);
 	}
 
 	bio_put(bio);
@@ -2946,7 +2991,7 @@ static unsigned int __ffs_mark_subrange_dirty(struct folio *folio,
 	return bitmap_weight(ffs->state, 2 * nr_subpages) - before;
 }
 
-static void f2fs_ffs_mark_subrange_dirty(struct folio *folio,
+void f2fs_ffs_mark_subrange_dirty(struct folio *folio,
 				    size_t offset, size_t len)
 {
 	struct f2fs_folio_state *ffs;
@@ -2964,6 +3009,99 @@ static void f2fs_ffs_mark_subrange_dirty(struct folio *folio,
 	spin_unlock_irqrestore(&ffs->state_lock, flags);
 }
 
+static bool __ffs_clear_subrange_dirty(struct folio *folio,
+			struct f2fs_folio_state *ffs, size_t offset, size_t len)
+{
+	unsigned int nr_subpages = folio_nr_pages(folio);
+	unsigned int start, end;
+
+	start = offset >> PAGE_SHIFT;
+	end = (offset + len + PAGE_SIZE - 1) >> PAGE_SHIFT;
+	end = min(end, nr_subpages);
+
+	bitmap_clear(ffs->state, nr_subpages + start, end - start);
+	return find_next_bit(ffs->state, 2 * nr_subpages, nr_subpages) <
+			2 * nr_subpages;
+}
+
+/**
+ * f2fs_ffs_clear_subrange_dirty_and_test - clear dirty bits and test remaining
+ * @folio: the large folio
+ * @offset: start byte offset within the folio
+ * @len: byte length of the subrange
+ *
+ * Clear the dirty bits of the 4K subpages covered by [offset, offset + len),
+ * and return whether the folio still has any dirty subpage left.
+ */
+bool f2fs_ffs_clear_subrange_dirty_and_test(struct folio *folio, size_t offset,
+					    size_t len)
+{
+	struct f2fs_folio_state *ffs;
+	unsigned long flags;
+	bool dirty;
+
+	if (!f2fs_folio_has_ffs(folio))
+		return false;
+
+	ffs = (struct f2fs_folio_state *)folio->private;
+	spin_lock_irqsave(&ffs->state_lock, flags);
+	dirty = __ffs_clear_subrange_dirty(folio, ffs, offset, len);
+	spin_unlock_irqrestore(&ffs->state_lock, flags);
+
+	return dirty;
+}
+
+static unsigned int ffs_next_dirty_subpage(struct f2fs_folio_state *ffs,
+			const struct folio *folio, unsigned int start,
+			unsigned int end)
+{
+	unsigned int nr_subpages = folio_nr_pages(folio);
+
+	return find_next_bit(ffs->state, nr_subpages + end + 1,
+			nr_subpages + start) - nr_subpages;
+}
+
+static unsigned int ffs_next_clean_subpage(struct f2fs_folio_state *ffs,
+			const struct folio *folio, unsigned int start,
+			unsigned int end)
+{
+	unsigned int nr_subpages = folio_nr_pages(folio);
+
+	return find_next_zero_bit(ffs->state, nr_subpages + end + 1,
+			nr_subpages + start) - nr_subpages;
+}
+
+static unsigned int ffs_find_dirty_range(struct folio *folio,
+					u64 *range_start, u64 range_end)
+{
+	struct f2fs_folio_state *ffs;
+	unsigned int start, end, nr_pages;
+
+	if (*range_start >= range_end)
+		return 0;
+
+	if (!f2fs_folio_has_ffs(folio))
+		return range_end - *range_start;
+
+	ffs = (struct f2fs_folio_state *)folio->private;
+	start = offset_in_folio(folio, *range_start) >> PAGE_SHIFT;
+	end = DIV_ROUND_UP(min_not_zero(offset_in_folio(folio, range_end),
+					folio_size(folio)), PAGE_SIZE) - 1;
+
+	start = ffs_next_dirty_subpage(ffs, folio, start, end);
+	if (start > end)
+		return 0;
+
+	if (start == end)
+		nr_pages = 1;
+	else
+		nr_pages = ffs_next_clean_subpage(ffs, folio,
+						 start + 1, end) - start;
+
+	*range_start = folio_pos(folio) + ((u64)start << PAGE_SHIFT);
+	return (u64)nr_pages << PAGE_SHIFT;
+}
+
 static bool find_next_valid_block(const struct folio *folio,
 				  size_t orig_off, size_t *need_off,
 				  size_t len)
@@ -3501,7 +3639,7 @@ int f2fs_do_write_data_page(struct f2fs_io_info *fio)
 	if (ipu_force ||
 		(__is_valid_data_blkaddr(fio->old_blkaddr) &&
 					need_inplace_update(fio))) {
-		folio_start_writeback(folio);
+		__folio_start_writeback(folio, folio_test_dirty(folio));
 		f2fs_put_dnode(&dn);
 		if (fio->need_lock == LOCK_REQ)
 			f2fs_unlock_op(fio->sbi, &lc);
@@ -3528,7 +3666,7 @@ int f2fs_do_write_data_page(struct f2fs_io_info *fio)
 
 	fio->version = ni.version;
 
-	folio_start_writeback(folio);
+	__folio_start_writeback(folio, folio_test_dirty(folio));
 
 	if (fio->compr_blocks && fio->old_blkaddr == COMPRESS_ADDR)
 		f2fs_i_compr_blocks_update(inode, fio->compr_blocks - 1, false);
@@ -3536,6 +3674,13 @@ int f2fs_do_write_data_page(struct f2fs_io_info *fio)
 	/* LFS mode write path */
 	f2fs_outplace_write_data(&dn, fio);
 	trace_f2fs_do_write_data_page(folio, OPU);
+	/*
+	 * The outplace write path failed to submit this block.
+	 */
+	if (!fio->submitted) {
+		err = -EIO;
+		goto out_writepage;
+	}
 	set_inode_flag(inode, FI_APPEND_WRITE);
 	if (atomic_commit)
 		folio_clear_f2fs_atomic(folio);
@@ -3547,6 +3692,144 @@ int f2fs_do_write_data_page(struct f2fs_io_info *fio)
 	return err;
 }
 
+static int f2fs_write_folio_dirty_range(struct folio *folio, int *submitted,
+					struct writeback_control *wbc,
+					enum iostat_type io_type,
+					u64 *pos, u64 len)
+{
+	struct inode *inode = folio->mapping->host;
+	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
+	bool atomic_commit = f2fs_is_atomic_file(inode) &&
+				folio_test_f2fs_atomic(folio);
+	struct inode *dn_inode = atomic_commit ?
+				F2FS_I(inode)->cow_inode : inode;
+	struct f2fs_folio_state *ffs = NULL;
+	u64 folio_start = folio_pos(folio);
+	pgoff_t start_idx = (*pos - folio_start) >> PAGE_SHIFT;
+	pgoff_t end_idx = (*pos - folio_start + len - 1) >> PAGE_SHIFT;
+	int err = 0;
+
+	for (pgoff_t i = start_idx; i <= end_idx && !err; i++) {
+		struct dnode_of_data dn;
+		struct node_info ni;
+		pgoff_t data_idx = folio->index + i;
+		bool ipu_force = false;
+		bool dn_held = false;
+		bool submitted_blk = false;
+		struct f2fs_io_info fio = {
+			.sbi = sbi,
+			.ino = inode->i_ino,
+			.type = DATA,
+			.op = REQ_OP_WRITE,
+			.op_flags = wbc_to_write_flags(wbc),
+			.old_blkaddr = NULL_ADDR,
+			.folio = folio,
+			.folio_offset = i,
+			.folio_blkcnt = 1,
+			.encrypted_page = NULL,
+			.submitted = 0,
+			.need_lock = LOCK_DONE,
+			.meta_gc = f2fs_meta_inode_gc_required(inode) ? 1 : 0,
+			.io_type = io_type,
+			.io_wbc = wbc,
+		};
+
+		if (f2fs_folio_has_ffs(folio)) {
+			ffs = (struct f2fs_folio_state *)folio->private;
+			atomic_inc(&ffs->write_pages_pending);
+		}
+
+		set_new_dnode(&dn, dn_inode, NULL, NULL, 0);
+
+		if (need_inplace_update(&fio) &&
+		    f2fs_lookup_read_extent_cache_block(inode, data_idx,
+							&fio.old_blkaddr)) {
+			if (!f2fs_is_valid_blkaddr(sbi, fio.old_blkaddr,
+						   DATA_GENERIC_ENHANCE)) {
+				err = -EFSCORRUPTED;
+				goto block_done;
+			}
+			ipu_force = true;
+			goto got_it;
+		}
+
+		err = f2fs_get_dnode_of_data(&dn, data_idx, LOOKUP_NODE);
+		if (err)
+			goto block_done;
+		dn_held = true;
+
+		fio.old_blkaddr = dn.data_blkaddr;
+
+got_it:
+		if (__is_valid_data_blkaddr(fio.old_blkaddr) &&
+		    !f2fs_is_valid_blkaddr(sbi, fio.old_blkaddr,
+					   DATA_GENERIC_ENHANCE)) {
+			err = -EFSCORRUPTED;
+			goto block_done;
+		}
+
+		if (fio.meta_gc)
+			f2fs_wait_on_block_writeback(inode, fio.old_blkaddr);
+
+		if (ipu_force ||
+		    (__is_valid_data_blkaddr(fio.old_blkaddr) &&
+					    need_inplace_update(&fio))) {
+			f2fs_put_dnode(&dn);
+			dn_held = false;
+			err = f2fs_inplace_write_data(&fio);
+			trace_f2fs_do_write_data_page(folio, IPU);
+			if (err)
+				goto block_done;
+
+			if (submitted)
+				(*submitted)++;
+			submitted_blk = true;
+			set_inode_flag(inode, FI_UPDATE_WRITE);
+			goto block_done;
+		}
+
+		err = f2fs_get_node_info(sbi, dn.nid, &ni, false);
+		if (err)
+			goto block_done;
+
+		fio.version = ni.version;
+
+		f2fs_outplace_write_data(&dn, &fio);
+		/*
+		 * The outplace write path failed to submit this block.
+		 */
+		if (!fio.submitted) {
+			err = -EIO;
+			goto block_done;
+		}
+		if (submitted)
+			(*submitted)++;
+		submitted_blk = true;
+		set_inode_flag(inode, FI_APPEND_WRITE);
+		trace_f2fs_do_write_data_page(folio, OPU);
+block_done:
+		if (dn_held)
+			f2fs_put_dnode(&dn);
+		/*
+		 * If this block was not submitted, roll back its
+		 * write pages pending.
+		 */
+		if (!submitted_blk && ffs)
+			f2fs_ffs_put_write_pending(folio, 1);
+		if (!err) {
+			*pos = ((loff_t)data_idx + 1) << PAGE_SHIFT;
+			spin_lock(&F2FS_I(inode)->i_size_lock);
+			if (F2FS_I(inode)->last_disk_size < *pos)
+				F2FS_I(inode)->last_disk_size = *pos;
+			spin_unlock(&F2FS_I(inode)->i_size_lock);
+		} else {
+			file_set_keep_isize(inode);
+		}
+	}
+
+	return err;
+}
+
 int f2fs_write_single_data_page(struct folio *folio, int *submitted,
 				struct bio **bio,
 				sector_t *last_block,
@@ -3996,6 +4279,238 @@ static int f2fs_write_cache_pages(struct address_space *mapping,
 	return ret;
 }
 
+static int f2fs_write_cache_folios(struct address_space *mapping,
+				   struct writeback_control *wbc,
+				   enum iostat_type io_type)
+{
+	struct folio *folio = NULL;
+	struct inode *inode = mapping->host;
+	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
+	struct f2fs_lock_context lc;
+	u64 pos = 0;
+	u64 end_pos = 0;
+	u32 r_len = 0;
+	int err = 0;
+	int submitted = 0;
+	int nwritten = 0;
+	bool op_locked = false;
+	bool retry = false;
+
+	if (get_dirty_pages(inode) <= SM_I(sbi)->min_hot_blocks)
+		set_inode_flag(inode, FI_HOT_DATA);
+	else
+		clear_inode_flag(inode, FI_HOT_DATA);
+
+	while ((folio = writeback_iter(mapping, wbc, folio, &err))) {
+		struct f2fs_folio_state *ffs = NULL;
+		u64 isize;
+		size_t poff;
+		size_t clear_len;
+		pgoff_t end_index;
+		bool verity_in_progress;
+		int folio_submitted = 0;
+		bool bias_added = false;
+
+		submitted = 0;
+		retry = false;
+
+		if (err) {
+			folio_redirty_for_writepage(wbc, folio);
+			goto retry_out;
+		}
+
+		if (atomic_read(&sbi->wb_sync_req[DATA]) &&
+		    wbc->sync_mode == WB_SYNC_NONE) {
+			folio_redirty_for_writepage(wbc, folio);
+			/*
+			 * A WB_SYNC_ALL writeback is in progress, so defer
+			 * this writeback.  Mark the error as -EBUSY to let
+			 * writeback_iter() stop iterating.
+			 */
+			err = -EBUSY;
+			goto retry_out;
+		}
+
+		/*
+		 * Writing back one large folio performs multiple block allocations, so
+		 * best-effort balance the filesystem before writing it back.
+		 */
+		if (!F2FS_I(inode)->wb_task && has_not_enough_free_secs(sbi, 0, 0)) {
+			folio_redirty_for_writepage(wbc, folio);
+			retry = true;
+			folio_unlock(folio);
+			f2fs_balance_fs(sbi, true);
+			folio_lock(folio);
+			goto retry;
+		}
+retry:
+		pos = folio_pos(folio);
+		end_pos = pos + folio_size(folio);
+		isize = i_size_read(inode);
+		verity_in_progress = f2fs_verity_in_progress(inode);
+		poff = 0;
+		end_index = 0;
+
+		if (retry) {
+
+			if (unlikely(folio->mapping != mapping))
+				goto retry_out;
+
+			if (!folio_test_dirty(folio))
+				goto retry_out;
+
+			if (folio_test_writeback(folio)) {
+				if (wbc->sync_mode == WB_SYNC_NONE)
+					goto retry_out;
+				f2fs_folio_wait_writeback(folio, true, true);
+			}
+
+			if (!folio_clear_dirty_for_io(folio))
+				goto retry_out;
+		}
+
+		/*
+		 * If cp_error is set, all subpages of this folio are not
+		 * written back unless the filesystem is mounted with
+		 * errors=remount-ro.  The check is placed after the retry
+		 * block so it also covers cp_error being set while the folio
+		 * lock was dropped for f2fs_balance_fs() or for the trylock_op()
+		 * backoff.  PG_dirty is clear at this point, so both the
+		 * redirty and the drop below leave a coherent state.
+		 */
+		if (unlikely(f2fs_cp_error(sbi))) {
+			mapping_set_error(mapping, -EIO);
+			if (F2FS_OPTION(sbi).errors == MOUNT_ERRORS_READONLY) {
+				folio_redirty_for_writepage(wbc, folio);
+				goto retry_out;
+			}
+			goto out;
+		}
+
+		/* To avoid dealing with the complexity for one subrange is in bio
+		 * while we trylock_op failed before writing another subrange.
+		 * Try to lock_op before any subrange write for the folio.
+		 */
+		if (!op_locked) {
+			if (!f2fs_trylock_op(sbi, &lc)) {
+				folio_redirty_for_writepage(wbc, folio);
+				err = 0;
+				if (wbc->sync_mode != WB_SYNC_ALL)
+					goto retry_out;
+
+				retry = true;
+				folio_unlock(folio);
+				f2fs_io_schedule_timeout(DEFAULT_SCHEDULE_TIMEOUT);
+				folio_lock(folio);
+				goto retry;
+			}
+			op_locked = true;
+		}
+
+		if (!verity_in_progress) {
+			poff = offset_in_folio(folio, isize);
+			end_index = isize >> PAGE_SHIFT;
+
+			if (folio->index > end_index ||
+			    (folio->index == end_index && poff == 0))
+				goto out;
+
+			if (end_pos > isize) {
+				folio_zero_segment(folio, poff, folio_size(folio));
+				end_pos = isize;
+			}
+		}
+
+		folio_start_writeback(folio);
+
+		/*
+		 * Large folios can be submitted as multiple bios, which may
+		 * complete while we are still submitting the remaining dirty
+		 * ranges.  Hold a bias on write_pages_pending to prevent
+		 * folio_end_writeback() from being called early.
+		 */
+		if (!bias_added && f2fs_folio_has_ffs(folio)) {
+			ffs = (struct f2fs_folio_state *)folio->private;
+			WARN_ON_ONCE(atomic_read(&ffs->write_pages_pending) != 0);
+			atomic_inc(&ffs->write_pages_pending);
+			bias_added = true;
+		}
+
+		while ((r_len = ffs_find_dirty_range(folio, &pos, end_pos))) {
+			submitted = 0;
+			err = f2fs_write_folio_dirty_range(folio, &submitted,
+					wbc, io_type, &pos, r_len);
+			folio_submitted += submitted;
+			nwritten += submitted;
+			if (err)
+				goto out;
+		}
+
+		/* If none of the subpages of a folio is submitted, keep the atomic flag */
+		if (folio_submitted &&
+		    f2fs_is_atomic_file(inode) &&
+		    folio_test_f2fs_atomic(folio))
+			folio_clear_f2fs_atomic(folio);
+
+out:
+		/*
+		 * Clear the dirty state of the subranges that were written back.
+		 * If some subranges are still dirty (e.g. the folio was only
+		 * partially written back), or if the writeback failed, the
+		 * folio must stay dirty so that the remaining subranges are
+		 * written back later.
+		 *
+		 * On success, clear dirty bits of the whole folio rather than
+		 * up to isize: subpages beyond EOF can still carry dirty bits
+		 * (e.g. fill_zero() w/ FALLOC_FL_KEEP_SIZE, BG_GC on blocks
+		 * beyond EOF, or f2fs_ffs_find_or_alloc() on a dirty folio),
+		 * they will never be written back, and would keep the folio
+		 * redirtied forever.
+		 */
+		clear_len = err ? pos - folio_pos(folio) : folio_size(folio);
+		if (f2fs_ffs_clear_subrange_dirty_and_test(folio, 0,
+						clear_len) || err) {
+			folio_redirty_for_writepage(wbc, folio);
+		} else {
+			inode_dec_dirty_pages(inode);
+		}
+
+		/*
+		 * Release the bias taken above and we end writeback here if
+		 * no write bio is in flight.
+		 */
+		if (bias_added) {
+			f2fs_ffs_put_write_pending(folio, 1);
+		} else if (!folio_submitted && folio_test_writeback(folio)) {
+			/*
+			 * Order-0 folios take no bias, so end the writeback
+			 * if nothing was submitted.
+			 */
+			folio_end_writeback(folio);
+		}
+
+retry_out:
+		if (op_locked) {
+			f2fs_unlock_op(sbi, &lc);
+			op_locked = false;
+		}
+
+		folio_unlock(folio);
+	}
+
+	if (nwritten)
+		f2fs_submit_merged_write_cond(F2FS_M_SB(mapping), mapping->host,
+					       NULL);
+
+	/*
+	 * Prevent the -EBUSY error that stopped writeback_iter() from
+	 * propagating to the user.
+	 */
+	if (err == -EBUSY)
+		err = 0;
+	return err;
+}
+
 static inline bool __should_serialize_io(struct inode *inode,
 					struct writeback_control *wbc)
 {
@@ -4090,7 +4605,11 @@ static int __f2fs_write_data_pages(struct address_space *mapping,
 	account_writeback(inode, true);
 
 	blk_start_plug(&plug);
-	ret = f2fs_write_cache_pages(mapping, wbc, io_type);
+	if (mapping_large_folio_support(inode->i_mapping) &&
+	    !f2fs_has_inline_data(inode))
+		ret = f2fs_write_cache_folios(mapping, wbc, io_type);
+	else
+		ret = f2fs_write_cache_pages(mapping, wbc, io_type);
 	blk_finish_plug(&plug);
 
 	account_writeback(inode, false);
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 80f58c586e33..cbb65e0343c8 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -4173,7 +4173,13 @@ static void do_write_block(struct f2fs_summary *sum, struct f2fs_io_info *fio)
 				"%s Failed to allocate data block, ino:%u, index:%lu, type:%d, old_blkaddr:0x%x, new_blkaddr:0x%x, err:%d",
 				__func__, fio->ino, folio->index, type,
 				fio->old_blkaddr, fio->new_blkaddr, err);
-			folio_end_writeback(folio);
+			/*
+			 * For a large folio, the caller rolls back
+			 * write_pages_pending and ends writeback when the last
+			 * pending write is gone.
+			 */
+			if (!f2fs_folio_has_ffs(folio))
+				folio_end_writeback(folio);
 		}
 		f2fs_bug_on(fio->sbi, !is_set_ckpt_flags(fio->sbi,
 							CP_ERROR_FLAG));
-- 
2.43.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
