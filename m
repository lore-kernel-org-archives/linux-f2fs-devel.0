Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81F05606A329
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 22 Oct 2026 07:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=fnJNR2ja;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=Rt6HqA9q;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=f9kaq9GJ;
	dkim=neutral header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=NNlaL7hU
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:List-Owner;
	bh=qnp0MnuiD+4xVt6Y7ULwNRkY67Ewns8ff0NyJ86pwiU=; b=fnJNR2japLI/9l6LAy8a+1JfOL
	JUaFcYtwLlHn17W1eeUHRa1CdyzFZl/05W3gy+IZaxvpgOraSodfZmzuiQHhH0M2cDsUZb548emd3
	BB7iGw5kMKPRca9uwG/oZEPm4Zt+3CaY4haLuF3kqpqHttaSCo1BIiGQVBXwRitiUDNQ=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xJndH-000000000lw-11Co;
	Thu, 22 Oct 2026 07:54:39 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <nzzhao.sigma@gmail.com>) id 1xJndG-000000000jL-0TkQ
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 22 Oct 2026 07:54:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=QauIsZX6JiWa3K6jqc2gJX1n8wzSUPDmLzIwNz1k8Ho=; b=Rt6HqA9qpLth8t1e01zxPnAaaO
 TXNyxfA0T8T8ZGgzQn0an90ibPikBueE95dRCp5hIrxGuj3MhfpxtvTSsuVpCV24Bz+vsvwoO2DBz
 XgXYhdW18oUoyBrU2UJw2dAlU/jIldsoowm036t2D5gMiJ7nj8YADzxxPCdNynkWcgAE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=QauIsZX6JiWa3K6jqc2gJX1n8wzSUPDmLzIwNz1k8Ho=; b=f9kaq9GJ6AN66jrUGeZdWfLqnb
 stGdMHqfGlmwkvg7WlLa/fCwciioj2waOcB3fUqvIFKbWtJVIKy8ancR8xIY40wbo1b4N7duux0df
 L0cH0+J8MsVB2rowYvboQloZG7DMKz7W5XkuyKsFwOUwYEd8NtcgZJ4UhEWXHa/TXAvA=;
Received: from mail-pj2-f11.google.com ([74.125.227.139])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xJnd7-000000007or-2Smy
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 22 Oct 2026 07:54:30 +0000
Received: by mail-pj2-f11.google.com with SMTP id
 98e67ed59e1d1-3a0aa5e2b20so391344a91.1
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu, 22 Oct 2026 00:54:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792655664; x=1793260464; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=QauIsZX6JiWa3K6jqc2gJX1n8wzSUPDmLzIwNz1k8Ho=;
 b=NNlaL7hUyLXxvlFbU/67hnAqrsI91cjS4vRO4bEQZAlCfyPhy9pC6ZPhEm91tIlVTE
 NamnnEhH2PeRZix7s89/hHtIjQGYayuR10hDzPV26eIqtx0aDw1MPiv6h/rhj86JDDfo
 wSXjmH7u0aLzJXoQfq9AhPQYn3ka4WsE3NSx3y5whZttXH9gtdG6gz4TS+mghD8GHt5n
 awU+35lnTfhCrnwGXbl26T7hQ7u0Lewe39R+wpcmejbfdFQfi9gPgmE+76ggmhEPDajG
 Zq1QR+XtqZZ7QYyJ8X210lCk3JJzIi+SmKryem2KKVy3sZ28f4+LWyH2bjBVBDOd9XKG
 tUZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792655664; x=1793260464;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=QauIsZX6JiWa3K6jqc2gJX1n8wzSUPDmLzIwNz1k8Ho=;
 b=Nu51xjwfeKZE+9XJnmAP5wQn+aueI2+kFs4q8Yi0JzXjZpzsssE6WlzZalGVEiaUsj
 JaRGJhf3hX9rYdGxQ6q41Rz0LzK9cpAtRmYLPunvB420HPdk7D4fM5BeAVWcORt+uDvA
 3OgSI/DFCWXyLPFOY1SBXwRWpk13RbG3sbQQbG8vA845JNs3J8pYkbz/lX18Z0+0WARI
 +uZQ9cr/If8xvd9sgjnBEpLpM0/wkIf0NhQi7Otw4UKo5juAro0b6QmzW3Y++AePVfdX
 1ZHnWc5vwW42WonWUU5fKg3b4XVSg/xX0FUPWE4PNPTTsVHyE0bhdFlCKyR6kGbf3ztw
 6Lug==
X-Gm-Message-State: AFq9FYIuM2QEyidDN11Adh6wqImmea0cSKfUqlkAsBNl//p0OFnyAIAL
 JwDxUJO9M4cObz39Mo8NFOA8B+AxN+MgOGG3Bb5RPWzT81m/yEmzfodSZy4rbZxT
X-Gm-Gg: AYBFou2WRpUT63O5EkM5MBb2UVCyjSGT0KcLzR1k8qs8e6qdPz0ecIWUCnpyhNuYQAp
 jRNUgRz4SXkZ3VzEa753a6PBKi3ipHIHCujWB0Pt8x100dhceiJyPa0pryZpUDvtfyYtUEZpVhl
 o1AJOjs9CVK1VeZAsEkyBff/+AInnOkSs8qdhRKk1ZZyWyx5Z4h5xFU1Ky0FlvJOxgN6tP782ET
 W9zhQUa8LjMw6waDx7SugGPEwBfeJNOzXJl2pSyjDz1+jsMwpCAtrPSUeC1uPpg/sfnZ0HKApAw
 w7Tvw9lniWkmwGeiMkMzQQzM3rpKkg8KrcEaiOy4uTG3OfON6pcuKsOLzzfXHZL+fHyoWeiL1vi
 P9rbj/x9aF5GMeuVd3YAOjIsC/QaK4T3L5AxUFeo5qTCtnyIdOOaifiy6OmQeR0qoc6e6JvqDfH
 bEinvP1lVq0fHsj4WtrCY6F3XPR6wYH0MPAKDkT3xxitp38gYsW5rSfHqOAbvB2wM1NXwdFhI0g
 d/ZEiX62EJPrgQVkqgxCwdP1EykIz+8g2Uy/ZmLzbxOTvqJyZWBGGhvTjtArZHT4PEGsj4qcuA6
 BCN38Dsu3v4hDfhprLA=
X-Received: by 2002:a17:90a:d883:b0:3ac:17c:6e74 with SMTP id
 98e67ed59e1d1-3ad86cc2074mr3264666a91.53.1792655663838; 
 Thu, 22 Oct 2026 00:54:23 -0700 (PDT)
Received: from nzzhao-ThinkCentre-M760t.mioffice.cn ([43.224.245.179])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ada4896c71sm3202562a91.6.2026.10.22.00.54.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Oct 2026 00:54:23 -0700 (PDT)
From: Nanzhe Zhao <nzzhao.sigma@gmail.com>
To: linux-f2fs-devel@lists.sourceforge.net, Jaegeuk Kim <jaegeuk@kernel.org>,
 Chao Yu <chao@kernel.org>
Date: Thu, 22 Oct 2026 15:53:35 +0800
Message-ID: <20261022075343.3043003-9-nzzhao.sigma@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261022075343.3043003-1-nzzhao.sigma@gmail.com>
References: <20261022075343.3043003-1-nzzhao.sigma@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xJnd7-000000007or-2Smy
Subject: [f2fs-dev] [PATCH v6 08/15] f2fs: make GC migration large-folio
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
 fs/f2fs/data.c    | 63 ++++++++++++++++++++++++++++++++++-------------
 fs/f2fs/f2fs.h    |  1 +
 fs/f2fs/gc.c      | 29 ++++++++++++++++++----
 fs/f2fs/segment.c |  2 +-
 4 files changed, 72 insertions(+), 23 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index f415c3eb4e78..5671395130b2 100644
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
@@ -1803,7 +1801,8 @@ struct folio *f2fs_get_lock_data_folio(struct inode *inode, pgoff_t index,
 
 	/* wait for read completion */
 	folio_lock(folio);
-	if (unlikely(folio->mapping != mapping || !folio_test_uptodate(folio))) {
+	if (unlikely(folio->mapping != mapping ||
+		    !f2fs_ffs_test_blk_uptodate(folio, index))) {
 		f2fs_folio_put(folio, true);
 		return ERR_PTR(-EIO);
 	}
@@ -2952,6 +2951,22 @@ static void f2fs_ffs_mark_subrange_uptodate(struct folio *folio, size_t offset,
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
@@ -3045,7 +3060,6 @@ bool f2fs_ffs_clear_subrange_dirty_and_test(struct folio *folio, size_t offset,
 
 	return dirty;
 }
-
 static unsigned int ffs_next_dirty_subpage(struct f2fs_folio_state *ffs,
 			const struct folio *folio, unsigned int start,
 			unsigned int end)
@@ -3543,7 +3557,7 @@ bool f2fs_should_update_outplace(struct inode *inode, struct f2fs_io_info *fio)
 		return true;
 
 	if (fio) {
-		if (page_private_gcing(fio->page))
+		if (folio_test_f2fs_gcing(fio->folio))
 			return true;
 		if (unlikely(is_sbi_flag_set(sbi, SBI_CP_DISABLED) &&
 			f2fs_is_checkpointed_data(sbi, fio->old_blkaddr)))
@@ -3569,8 +3583,11 @@ int f2fs_do_write_data_page(struct f2fs_io_info *fio)
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
@@ -3612,7 +3629,6 @@ int f2fs_do_write_data_page(struct f2fs_io_info *fio)
 	/* This page is already truncated */
 	if (fio->old_blkaddr == NULL_ADDR) {
 		folio_clear_uptodate(folio);
-		folio_clear_f2fs_gcing(folio);
 		goto out_writepage;
 	}
 got_it:
@@ -3662,6 +3678,11 @@ int f2fs_do_write_data_page(struct f2fs_io_info *fio)
 	fio->version = ni.version;
 
 	__folio_start_writeback(folio, folio_test_dirty(folio));
+	if (f2fs_folio_has_ffs(folio)) {
+		ffs = (struct f2fs_folio_state *)folio->private;
+		atomic_inc(&ffs->write_pages_pending);
+		pending_added = true;
+	}
 
 	if (fio->compr_blocks && fio->old_blkaddr == COMPRESS_ADDR)
 		f2fs_i_compr_blocks_update(inode, fio->compr_blocks - 1, false);
@@ -3676,6 +3697,7 @@ int f2fs_do_write_data_page(struct f2fs_io_info *fio)
 		err = -EIO;
 		goto out_writepage;
 	}
+	submitted = true;
 	set_inode_flag(inode, FI_APPEND_WRITE);
 	if (atomic_commit)
 		folio_clear_f2fs_atomic(folio);
@@ -3684,6 +3706,13 @@ int f2fs_do_write_data_page(struct f2fs_io_info *fio)
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
index 67a4224a5d75..c3e01f6811b4 100644
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
@@ -1552,33 +1561,43 @@ static int move_data_page(struct inode *inode, block_t bidx, int gc_type,
 			.op_flags = REQ_SYNC,
 			.old_blkaddr = NULL_ADDR,
 			.folio = folio,
+			.folio_offset = bidx - folio->index,
 			.folio_blkcnt = 1,
 			.encrypted_page = NULL,
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
