Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81CA7CC6B24
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 14 Oct 2026 06:45:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pEJSBV+nvmA2ULnOxSSjpfco8rHml5CquhdJ8ny/lx4=; b=k+1xeXJOLT/9toyG3M+BmCY9qu
	LPhfyHfLq2uKd2X9bw7ZPvBLuIE142/kVDgfApvmx+ZWgNAR/1lOQ0x6TYg984tSw9O+St1gjSvZe
	Zo/xFCOAsoK6/TOMQglnHLOJOJ6FGJ8ro+8EI2fGhFWf++K6gWToSu9ICJlpdr0wTpOQ=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xGskQ-00029v-Df;
	Wed, 14 Oct 2026 06:45:59 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <nzzhao.sigma@gmail.com>) id 1xGskO-00029l-Vm
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 14 Oct 2026 06:45:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=R8W+P5uWOAmQg30+yY6U07vbECkRnXGSCmzsawzI9Ic=; b=L23t8CbwWu8OdA6A9xG/NNJl2v
 C0ppp0HPGq8GTtnBvwMsewSm4VeiGsAlKY1VE8YUu2N+9bpvC21+5sVsvWmEb4QzAu5yIqMP/VVie
 iOU/otTiWj/DztyAemjtWH+hDBc+CP/n1LK4zv+uxqPhSpiIkLzndY80mvl5oJtGdsZo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=R8W+P5uWOAmQg30+yY6U07vbECkRnXGSCmzsawzI9Ic=; b=ikJbLLwLHcM+70zp1xIU2PU/X4
 FNXWBr7tshG/a2HZwejG2riYa3AI9eFzbEIAR8RumFghYBJh7bvMohwzzrBdGPto02ZA46Uxy8NJu
 wmK2HhNTT7q/PC0F+gTH6hdQqeIOlJMTFEy8bRg/neDphAXhW/T/fw6e0lQ7t98uC9pI=;
Received: from mail-pj2-f10.google.com ([74.125.227.138])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xGskN-0004LP-3l for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 14 Oct 2026 06:45:57 +0000
Received: by mail-pj2-f10.google.com with SMTP id
 98e67ed59e1d1-3ac69691963so97195a91.1
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 13 Oct 2026 23:45:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791960349; x=1792565149; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=R8W+P5uWOAmQg30+yY6U07vbECkRnXGSCmzsawzI9Ic=;
 b=BY/6GpFozEgxIPPVbdjsHqQJTADlmynfnsMxGCZiXcNkqRNKZaYXPxFK2RHx9Z+G5T
 Y3FEW4iUUKl0y4FKnYaVuXVD96sEAN6CuERo8u0wBIBE+MuNmXXMFycdZoHKaT5tZ75d
 E08jO1u5x/i+iHVtc43Hs2z8R5EqJ5UUcCU7RTRGIaVN4pv1tDB95TSR8qk6swlcBBc4
 yAedZKft4YxVI81Bpcg6fbF8UuhS6jYczQHbtr45BK7Ep9BiDtTgocFKcDYkBzXDLuNn
 7t9b+FN/qTRwg6lofuJ7SCA6pWZ3GKhLjQpmo6pFjKuUKEwkR+p6+CFJSO94/LD45FH0
 jdcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791960349; x=1792565149;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=R8W+P5uWOAmQg30+yY6U07vbECkRnXGSCmzsawzI9Ic=;
 b=QMdjQSQCGNCpG4HEvkCSPVkSJwJgRRuOBjxIctFsi5SpoSJJEdR5CMGU0hgAM3LK1n
 4UgwfNgUo/5BwEE3UXcMDHG1axH6zPZCUhO+8IdAzIGkXTqd2cFGziOTu4T8RCBhdwJr
 BXXU0ErBXo6V6EnkOVqHyI6PjijTGmI4wrjmrBYhlFxrAn9Q1wI8PIvD0SsPfxRLegAs
 CkGDMIJqohBxvy7Goqgh1FRB7ElTUG+xEzM9L5ju8I57vrchw4YIG3kim4QxgJQY0wQm
 j4MWwaHyF/vdtGsXxizzEyX7J23LUQzijBAwo09kWzDFsTY0PlHaCSz4ZkSyQ9jTYp10
 Z/KQ==
X-Gm-Message-State: AFq9FYIpwiWfqPT8SF1eI6TmmyL1uR6slvVkiep+i3VlNnfoOOM3xnfz
 yqTIl0GS4bRwtfkvJ5vkm+MGbcYZAKPqvwABx9LgzQAoAHnh83DSvGfyFm5M/vk4/pg=
X-Gm-Gg: AYBFou3Hq903p2v6pr9cVcw7K7zps/VdticKMGm8Pnz/ssI/uoXyPPUg36PlFj5jxo2
 Jf82+TbsTplobc+KVxrEvftu3wRsglvH+4IOkqd3C6AeI+MVqRM9TAt5Y95lmdMW/fdrihmLx5j
 3/yT/kfFyD6Tod1LXRiuiRjHx8GMV8MVWfDvQnuDmZqzRC3t3aQKSvITaJyKzB08UZS9WX7OUeB
 DqyehuJ0AkGUNj5Rbo3mNBBqg7fVOuJsZ0ZAGR5Qy5q2lCKn/SO4LFaD+u70S89iXOW9MGqr0N2
 sW82fW1VhQRYKdbUoftBZaDRzV6IzCCxi+WYxZvj9WNFQN7PALNqSK7QzwDXX/MVQtF2pfGhKnK
 NOjG2XHaJTuSNFoaoYuZMRI3UV3V8R37Ee7Ae3oIOisXNfmGguZ34GLLQGqSYvbKOnFI7CqBJH3
 zqqCKC/+6kRuwscIw1S5WWCRuV09QtyefhwhKtYVEGuA/J93hjdFhje/eW4FM/nExk3UESrFJ5g
 axEjFcVZF173eHLYd7fLvyvCU0RQt001FlC
X-Received: by 2002:a17:90b:5343:b0:3a4:e934:e85c with SMTP id
 98e67ed59e1d1-3ab3accfc54mr12696308a91.41.1791960349432; 
 Tue, 13 Oct 2026 23:45:49 -0700 (PDT)
Received: from nzzhao-ThinkCentre-M760t.mioffice.cn ([43.224.245.179])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ac5f04e324sm3236371a91.2.2026.10.13.23.45.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2026 23:45:49 -0700 (PDT)
From: Nanzhe Zhao <nzzhao.sigma@gmail.com>
X-Google-Original-From: Nanzhe Zhao <zhaonanzhe@xiaomi.com>
To: linux-f2fs-devel@lists.sourceforge.net, Jaegeuk Kim <jaegeuk@kernel.org>,
 Chao Yu <chao@kernel.org>
Date: Wed, 14 Oct 2026 14:44:37 +0800
Message-ID: <20261014064445.2835813-9-zhaonanzhe@xiaomi.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261014064445.2835813-1-zhaonanzhe@xiaomi.com>
References: <20261014064445.2835813-1-zhaonanzhe@xiaomi.com>
MIME-Version: 1.0
X-Headers-End: 1xGskN-0004LP-3l
Subject: [f2fs-dev] [PATCH v5 08/16] f2fs: make GC migration large-folio
 aware
X-BeenThere: linux-f2fs-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: Barry Song <baohua@kernel.org>, Juan Yescas <jyescas@google.com>,
 Daeho Jeong <daehojeong@google.com>, Pengfei Li <lipengfei28@xiaomi.com>,
 Dev Jain <Dev.Jain@arm.com>, David Hildenbrand <David.Hildenbrand@arm.com>,
 linux-kernel@vger.kernel.org, Bo Zhang <zhangbo56@xiaomi.com>,
 Kalesh Singh <kaleshsingh@google.com>, Nanzhe Zhao <nzzhao@126.com>,
 Nanzhe Zhao <zhaonanzhe@xiaomi.com>, Ryan Roberts <Ryan.Roberts@arm.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

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

Signed-off-by: Nanzhe Zhao <zhaonanzhe@xiaomi.com>
---
 fs/f2fs/data.c    | 46 ++++++++++++++++++++++++++++++----------------
 fs/f2fs/f2fs.h    |  1 +
 fs/f2fs/gc.c      | 36 ++++++++++++++++++++++++++++++++----
 fs/f2fs/segment.c |  2 +-
 4 files changed, 64 insertions(+), 21 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index b5c048134e00..710213fea7a6 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -1633,20 +1633,16 @@ struct folio *f2fs_get_read_data_folio(struct inode *inode, pgoff_t index,
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
@@ -1682,7 +1678,7 @@ struct folio *f2fs_get_read_data_folio(struct inode *inode, pgoff_t index,
 		goto put_err;
 	}
 got_it:
-	if (folio_test_uptodate(folio)) {
+	if (f2fs_ffs_test_blk_uptodate(folio, index)) {
 		folio_unlock(folio);
 		return folio;
 	}
@@ -1695,9 +1691,11 @@ struct folio *f2fs_get_read_data_folio(struct inode *inode, pgoff_t index,
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
@@ -1757,7 +1755,8 @@ struct folio *f2fs_get_lock_data_folio(struct inode *inode, pgoff_t index,
 
 	/* wait for read completion */
 	folio_lock(folio);
-	if (unlikely(folio->mapping != mapping || !folio_test_uptodate(folio))) {
+	if (unlikely(folio->mapping != mapping ||
+		    !f2fs_ffs_test_blk_uptodate(folio, index))) {
 		f2fs_folio_put(folio, true);
 		return ERR_PTR(-EIO);
 	}
@@ -2906,6 +2905,22 @@ static void f2fs_ffs_mark_subrange_uptodate(struct folio *folio, size_t offset,
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
@@ -2999,7 +3014,6 @@ bool f2fs_ffs_clear_subrange_dirty_and_test(struct folio *folio, size_t offset,
 
 	return dirty;
 }
-
 static unsigned int ffs_next_dirty_subpage(struct f2fs_folio_state *ffs,
 			const struct folio *folio, unsigned int start,
 			unsigned int end)
@@ -3497,7 +3511,7 @@ bool f2fs_should_update_outplace(struct inode *inode, struct f2fs_io_info *fio)
 		return true;
 
 	if (fio) {
-		if (page_private_gcing(fio->page))
+		if (folio_test_f2fs_gcing(fio->folio))
 			return true;
 		if (unlikely(is_sbi_flag_set(sbi, SBI_CP_DISABLED) &&
 			f2fs_is_checkpointed_data(sbi, fio->old_blkaddr)))
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index d976e6ad058b..36ec8266af69 100644
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
index d7fae1890835..5bb117e5e811 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -1512,12 +1512,19 @@ static int move_data_page(struct inode *inode, block_t bidx, int gc_type,
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
@@ -1532,6 +1539,8 @@ static int move_data_page(struct inode *inode, block_t bidx, int gc_type,
 			err = -EAGAIN;
 			goto out;
 		}
+		if (large)
+			f2fs_ffs_mark_subrange_dirty(folio, foff, PAGE_SIZE);
 		folio_mark_dirty(folio);
 		folio_set_f2fs_gcing(folio);
 	} else {
@@ -1544,32 +1553,51 @@ static int move_data_page(struct inode *inode, block_t bidx, int gc_type,
 			.op_flags = REQ_SYNC,
 			.old_blkaddr = NULL_ADDR,
 			.folio = folio,
+			.folio_offset = bidx - folio->index,
+			.folio_blkcnt = 1,
 			.encrypted_page = NULL,
 			.need_lock = LOCK_REQ,
 			.io_type = FS_GC_DATA_IO,
 		};
-		bool is_dirty = folio_test_dirty(folio);
+		struct f2fs_folio_state *ffs = NULL;
+		bool is_dirty = f2fs_ffs_test_blk_dirty(folio, bidx);
 
 retry:
 		f2fs_folio_wait_writeback(folio, true, true);
 
+		if (large) {
+			ffs = (struct f2fs_folio_state *)folio->private;
+			f2fs_ffs_mark_subrange_dirty(folio, foff, PAGE_SIZE);
+		}
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
 
+		if (large)
+			atomic_inc(&ffs->write_pages_pending);
 		folio_set_f2fs_gcing(folio);
 
 		err = f2fs_do_write_data_page(&fio);
 		if (err) {
 			folio_clear_f2fs_gcing(folio);
+			if (large)
+				atomic_dec(&ffs->write_pages_pending);
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
index 96bfb7d63692..06fb92fc8479 100644
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
