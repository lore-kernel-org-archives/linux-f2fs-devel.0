Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D478C5B572
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 17 Aug 2026 11:19:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:Message-ID:Date:To:Sender:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=LJ2BwXNMvjAcPD1IeN+G2e+J2Rg+1RmAGcoYPAWgoBk=; b=eVT49EjYIzxXuC9GKU7TZ9X+T6
	NPbl7eMZ8vhpbDT4WD2UWai8FFREav7mi+jR4TAjLMrosB/Zq1RGc6RDrRXMy3bZgQAgDHtlAb4RM
	Z9rY0AmbRp9/jXsX/vVdMmy3kiWbWvfGZLwGby0JNO8hPHSsjTeUPObXOnDQAOG0arq4=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wvvNM-0006m7-Vx;
	Mon, 17 Aug 2026 11:19:33 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1wvvNL-0006lw-Py
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 17 Aug 2026 11:19:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=mNi0xWoD/VN3asREdWBPqz4rTGv6XvTP15MZcSxPEk8=; b=lytEdYGcUnN9QeMSOzCRw6jbll
 b4jDMU2UFnOxn6pO8M8BDWm+gFe0DKWGwf91S+saQ9iGNpeoWed9zjkMZ3wRNptxfc/f33LrW7Ppa
 z2iTexxVWY/MU9bUYg5B0PSuK3xvefLFgVT5SndjRJy/urOxKU3ZcE4RRy8kmNGXD3BQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=mNi0xWoD/VN3asREdWBPqz4rTGv6XvTP15MZcSxPEk8=; b=A
 2IzheXRCmof+zEEg5Vi4jGOKJYBedwvhpzfp5X+Y9k2IzHHTR4DydhCj6WdWHKO0Q3TwT67SPgp8c
 zPzF0+7f7m8m4HhDsL3WtVFMN/ELvAb2Ry+nHUq6ebIhZczyehmwDU3JnM3GU2pIUfM8jFxjko19S
 +mlnA0HQ0tiMyVJo=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wvvNO-0007pV-Hb for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 17 Aug 2026 11:19:32 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 99FF842A39
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 17 Aug 2026 11:19:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD0FE1F000E9;
 Mon, 17 Aug 2026 11:19:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786965565;
 bh=mNi0xWoD/VN3asREdWBPqz4rTGv6XvTP15MZcSxPEk8=;
 h=From:To:Cc:Subject:Date;
 b=bkC80uzAyLI5qYptQ8tOgnaCn5JcFgrcOpY6ADcCgJwqn0bIDVlsbOk3EZ2r7E9MA
 9ZQcvz0xvOQU6PnfUlmP4HsKiq/Iv2VDlzwvt1W77ujL3oWYj4AyAYnLtW2z5+eN2o
 Eh9dEqGeMmxGYZVmlk8rnrMnCygwPeOe5DEIlhPotziSiyZKs5i2xT+QPNLiuCI0sW
 IHKxAy3BPoVRX1NYvWdpFKjFAcEUvm3qvb8Zg9mLd5XiVf22IgbIRZ0fxhRGWwaaTm
 A2nbePmnamDkg2xPueju9k3fXpnrsL+KUA/IW/ycEDrbQ837Iwtkkeb7qbfDVPR3F7
 wL6HmSNb4CzLQ==
To: jaegeuk@kernel.org
Date: Mon, 17 Aug 2026 11:19:16 +0000
Message-ID: <20260817111916.1648354-1-chao@kernel.org>
X-Mailer: git-send-email 2.55.0.691.gc56d675ccc-goog
MIME-Version: 1.0
X-Headers-End: 1wvvNO-0007pV-Hb
Subject: [f2fs-dev] [PATCH] f2fs: use f2fs_{down, up}_(read,
 write}_trace() for nat_tree_lock
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
From: Chao Yu via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Chao Yu <chao@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Under heavy workloads or during background GC/fallocate operations,
nat_tree_lock can experience high lock contention between background
readers (e.g. f2fs_get_node_info() in gc_data_segment) and writers
(e.g. flush_nat_entries, set_node_addr, shrinker).

[375067.327986][T13777]  schedule+0x4c/0x114
[375067.327997][T13777]  f2fs_get_node_info+0x438/0x5c4
[375067.328002][T13777]  f2fs_get_inode_page+0x1e0/0x3f0
[375067.328013][T13777]  f2fs_iget+0x88/0x1180
[375067.328024][T13777]  f2fs_lookup+0x168/0x3a8
[375067.328035][T13777]  path_openat+0xa28/0x1b04
[375067.328046][T13777]  do_filp_open+0xac/0x130
[375067.328056][T13777]  do_sys_openat2+0x140/0x21c
[375067.328066][T13777]  __arm64_sys_openat+0x70/0x9c

[375067.330299][T13777]  schedule+0x4c/0x114
[375067.330310][T13777]  schedule_preempt_disabled+0x24/0x40
[375067.330321][T13777]  rwsem_down_write_slowpath+0x3b4/0x9d0
[375067.330332][T13777]  down_write+0x98/0x170
[375067.330343][T13777]  set_node_addr+0x74/0x4b4
[375067.330354][T13777]  f2fs_new_node_page+0xb0/0x280
[375067.330444][T13777]  f2fs_new_inode_page+0x3c/0x64
[375067.330455][T13777]  f2fs_init_inode_metadata+0x4c/0x47c
[375067.330461][T13777]  f2fs_add_regular_entry+0x258/0x5b8
[375067.330471][T13777]  f2fs_add_dentry+0x100/0x158
[375067.330476][T13777]  f2fs_do_add_link+0x84/0x140
[375067.330487][T13777]  f2fs_create+0xec/0x250

[375067.331759][T13777]  schedule+0x4c/0x114
[375067.331770][T13777]  f2fs_down_read+0x9c/0xc4
[375067.331781][T13777]  f2fs_need_inode_block_update+0x20/0x10c
[375067.331792][T13777]  f2fs_do_sync_file+0x478/0x830
[375067.331802][T13777]  f2fs_sync_file+0x2c/0x40

This patch converts nat_tree_lock to use the f2fs_{down,up}_{read,write}_trace
infrastructure.

Signed-off-by: Chao Yu <chao@kernel.org>
---
 Documentation/ABI/testing/sysfs-fs-f2fs |  1 +
 fs/f2fs/checkpoint.c                    |  1 +
 fs/f2fs/f2fs.h                          |  1 +
 fs/f2fs/node.c                          | 71 ++++++++++++++-----------
 include/trace/events/f2fs.h             |  3 +-
 5 files changed, 46 insertions(+), 31 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-fs-f2fs b/Documentation/ABI/testing/sysfs-fs-f2fs
index f4e6a7415cde..85194e4c7f01 100644
--- a/Documentation/ABI/testing/sysfs-fs-f2fs
+++ b/Documentation/ABI/testing/sysfs-fs-f2fs
@@ -986,6 +986,7 @@ Description:	This sysfs entry can be used to enable/disable to adjust priority f
 		0x00000008     gc_lock
 		0x00000010     cp_global
 		0x00000020     io_rwsem
+		0x00000040     nat_tree_lock
 		==========     ==================
 
 What:		/sys/fs/f2fs/<disk>/lock_duration_priority
diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index f81ba8cc861a..a7415fa0de7f 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -107,6 +107,7 @@ static bool need_uplift_priority(struct f2fs_rwsem *sem, bool is_write)
 	case LOCK_NAME_GC_LOCK:
 	case LOCK_NAME_CP_GLOBAL:
 	case LOCK_NAME_IO_RWSEM:
+	case LOCK_NAME_NAT_TREE_LOCK:
 		return true;
 	default:
 		f2fs_bug_on(sem->sbi, 1);
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 1b96d8718c5c..a1f5f375045a 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -193,6 +193,7 @@ enum f2fs_lock_name {
 	LOCK_NAME_GC_LOCK,
 	LOCK_NAME_CP_GLOBAL,
 	LOCK_NAME_IO_RWSEM,
+	LOCK_NAME_NAT_TREE_LOCK,
 	LOCK_NAME_MAX,
 };
 
diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 46bea52e35c3..968e5ed38816 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -401,15 +401,16 @@ bool f2fs_need_dentry_mark(struct f2fs_sb_info *sbi, nid_t nid)
 	struct f2fs_nm_info *nm_i = NM_I(sbi);
 	struct nat_entry *e;
 	bool need = false;
+	struct f2fs_lock_context lc;
 
-	f2fs_down_read(&nm_i->nat_tree_lock);
+	f2fs_down_read_trace(&nm_i->nat_tree_lock, &lc);
 	e = __lookup_nat_cache(nm_i, nid, false);
 	if (e) {
 		if (!get_nat_flag(e, IS_CHECKPOINTED) &&
 				!get_nat_flag(e, HAS_FSYNCED_INODE))
 			need = true;
 	}
-	f2fs_up_read(&nm_i->nat_tree_lock);
+	f2fs_up_read_trace(&nm_i->nat_tree_lock, &lc);
 	return need;
 }
 
@@ -418,12 +419,13 @@ bool f2fs_is_checkpointed_node(struct f2fs_sb_info *sbi, nid_t nid)
 	struct f2fs_nm_info *nm_i = NM_I(sbi);
 	struct nat_entry *e;
 	bool is_cp = true;
+	struct f2fs_lock_context lc;
 
-	f2fs_down_read(&nm_i->nat_tree_lock);
+	f2fs_down_read_trace(&nm_i->nat_tree_lock, &lc);
 	e = __lookup_nat_cache(nm_i, nid, false);
 	if (e && !get_nat_flag(e, IS_CHECKPOINTED))
 		is_cp = false;
-	f2fs_up_read(&nm_i->nat_tree_lock);
+	f2fs_up_read_trace(&nm_i->nat_tree_lock, &lc);
 	return is_cp;
 }
 
@@ -432,16 +434,16 @@ bool f2fs_need_inode_block_update(struct f2fs_sb_info *sbi, nid_t ino)
 	struct f2fs_nm_info *nm_i = NM_I(sbi);
 	struct nat_entry *e;
 	bool need_update = true;
-	struct f2fs_lock_context lc;
+	struct f2fs_lock_context lc, nlc;
 
 	f2fs_down_read_trace(&sbi->node_write, &lc);
-	f2fs_down_read(&nm_i->nat_tree_lock);
+	f2fs_down_read_trace(&nm_i->nat_tree_lock, &nlc);
 	e = __lookup_nat_cache(nm_i, ino, false);
 	if (e && get_nat_flag(e, HAS_LAST_FSYNC) &&
 			(get_nat_flag(e, IS_CHECKPOINTED) ||
 			 get_nat_flag(e, HAS_FSYNCED_INODE)))
 		need_update = false;
-	f2fs_up_read(&nm_i->nat_tree_lock);
+	f2fs_up_read_trace(&nm_i->nat_tree_lock, &nlc);
 	f2fs_up_read_trace(&sbi->node_write, &lc);
 	return need_update;
 }
@@ -452,6 +454,7 @@ static void cache_nat_entry(struct f2fs_sb_info *sbi, nid_t nid,
 {
 	struct f2fs_nm_info *nm_i = NM_I(sbi);
 	struct nat_entry *new, *e;
+	struct f2fs_lock_context lc;
 
 	/* Let's mitigate lock contention of nat_tree_lock during checkpoint */
 	if (f2fs_rwsem_is_locked(&sbi->cp_global_sem))
@@ -461,7 +464,7 @@ static void cache_nat_entry(struct f2fs_sb_info *sbi, nid_t nid,
 	if (!new)
 		return;
 
-	f2fs_down_write(&nm_i->nat_tree_lock);
+	f2fs_down_write_trace(&nm_i->nat_tree_lock, &lc);
 	e = __lookup_nat_cache(nm_i, nid, false);
 	if (!e)
 		e = __init_nat_entry(nm_i, new, ne, false, false);
@@ -470,7 +473,7 @@ static void cache_nat_entry(struct f2fs_sb_info *sbi, nid_t nid,
 				nat_get_blkaddr(e) !=
 					le32_to_cpu(ne->block_addr) ||
 				nat_get_version(e) != ne->version);
-	f2fs_up_write(&nm_i->nat_tree_lock);
+	f2fs_up_write_trace(&nm_i->nat_tree_lock, &lc);
 	if (e != new)
 		__free_nat_entry(new);
 }
@@ -482,8 +485,9 @@ static void set_node_addr(struct f2fs_sb_info *sbi, struct node_info *ni,
 	struct nat_entry *e;
 	struct nat_entry *new = __alloc_nat_entry(sbi, ni->nid, true);
 	bool init_dirty = false;
+	struct f2fs_lock_context lc;
 
-	f2fs_down_write(&nm_i->nat_tree_lock);
+	f2fs_down_write_trace(&nm_i->nat_tree_lock, &lc);
 	e = __lookup_nat_cache(nm_i, ni->nid, true);
 	if (!e) {
 		init_dirty = true;
@@ -533,15 +537,16 @@ static void set_node_addr(struct f2fs_sb_info *sbi, struct node_info *ni,
 			set_nat_flag(e, HAS_FSYNCED_INODE, true);
 		set_nat_flag(e, HAS_LAST_FSYNC, fsync_done);
 	}
-	f2fs_up_write(&nm_i->nat_tree_lock);
+	f2fs_up_write_trace(&nm_i->nat_tree_lock, &lc);
 }
 
 int f2fs_try_to_free_nats(struct f2fs_sb_info *sbi, int nr_shrink)
 {
 	struct f2fs_nm_info *nm_i = NM_I(sbi);
 	int nr = nr_shrink;
+	struct f2fs_lock_context lc;
 
-	if (!f2fs_down_write_trylock(&nm_i->nat_tree_lock))
+	if (!f2fs_down_write_trylock_trace(&nm_i->nat_tree_lock, &lc))
 		return 0;
 
 	spin_lock(&nm_i->nat_list_lock);
@@ -563,7 +568,7 @@ int f2fs_try_to_free_nats(struct f2fs_sb_info *sbi, int nr_shrink)
 	}
 	spin_unlock(&nm_i->nat_list_lock);
 
-	f2fs_up_write(&nm_i->nat_tree_lock);
+	f2fs_up_write_trace(&nm_i->nat_tree_lock, &lc);
 	return nr - nr_shrink;
 }
 
@@ -581,18 +586,19 @@ int f2fs_get_node_info(struct f2fs_sb_info *sbi, nid_t nid,
 	pgoff_t index;
 	int i;
 	bool need_cache = true;
+	struct f2fs_lock_context lc;
 
 	ni->flag = 0;
 	ni->nid = nid;
 retry:
 	/* Check nat cache */
-	f2fs_down_read(&nm_i->nat_tree_lock);
+	f2fs_down_read_trace(&nm_i->nat_tree_lock, &lc);
 	e = __lookup_nat_cache(nm_i, nid, false);
 	if (e) {
 		ni->ino = nat_get_ino(e);
 		ni->blk_addr = nat_get_blkaddr(e);
 		ni->version = nat_get_version(e);
-		f2fs_up_read(&nm_i->nat_tree_lock);
+		f2fs_up_read_trace(&nm_i->nat_tree_lock, &lc);
 		if (IS_ENABLED(CONFIG_F2FS_CHECK_FS)) {
 			need_cache = false;
 			goto sanity_check;
@@ -610,7 +616,7 @@ int f2fs_get_node_info(struct f2fs_sb_info *sbi, nid_t nid,
 		down_read(&curseg->journal_rwsem);
 	} else if (f2fs_rwsem_is_contended(&nm_i->nat_tree_lock) ||
 				!down_read_trylock(&curseg->journal_rwsem)) {
-		f2fs_up_read(&nm_i->nat_tree_lock);
+		f2fs_up_read_trace(&nm_i->nat_tree_lock, &lc);
 		goto retry;
 	}
 
@@ -621,13 +627,13 @@ int f2fs_get_node_info(struct f2fs_sb_info *sbi, nid_t nid,
 	}
 	up_read(&curseg->journal_rwsem);
 	if (i >= 0) {
-		f2fs_up_read(&nm_i->nat_tree_lock);
+		f2fs_up_read_trace(&nm_i->nat_tree_lock, &lc);
 		goto sanity_check;
 	}
 
 	/* Fill node_info from nat page */
 	index = current_nat_addr(sbi, nid);
-	f2fs_up_read(&nm_i->nat_tree_lock);
+	f2fs_up_read_trace(&nm_i->nat_tree_lock, &lc);
 
 	folio = f2fs_get_meta_folio(sbi, index);
 	if (IS_ERR(folio))
@@ -2567,8 +2573,9 @@ static void scan_free_nid_bits(struct f2fs_sb_info *sbi)
 	struct f2fs_nm_info *nm_i = NM_I(sbi);
 	unsigned int i, idx;
 	nid_t nid;
+	struct f2fs_lock_context lc;
 
-	f2fs_down_read(&nm_i->nat_tree_lock);
+	f2fs_down_read_trace(&nm_i->nat_tree_lock, &lc);
 
 	for (i = 0; i < nm_i->nat_blocks; i++) {
 		if (!test_bit_le(i, nm_i->nat_block_bitmap))
@@ -2591,7 +2598,7 @@ static void scan_free_nid_bits(struct f2fs_sb_info *sbi)
 out:
 	scan_curseg_cache(sbi);
 
-	f2fs_up_read(&nm_i->nat_tree_lock);
+	f2fs_up_read_trace(&nm_i->nat_tree_lock, &lc);
 }
 
 static int __f2fs_build_free_nids(struct f2fs_sb_info *sbi,
@@ -2600,6 +2607,7 @@ static int __f2fs_build_free_nids(struct f2fs_sb_info *sbi,
 	struct f2fs_nm_info *nm_i = NM_I(sbi);
 	int i = 0, ret;
 	nid_t nid = nm_i->next_scan_nid;
+	struct f2fs_lock_context lc;
 
 	if (unlikely(nid >= nm_i->max_nid))
 		nid = 0;
@@ -2626,7 +2634,7 @@ static int __f2fs_build_free_nids(struct f2fs_sb_info *sbi,
 	f2fs_ra_meta_pages(sbi, NAT_BLOCK_OFFSET(nid), FREE_NID_PAGES,
 							META_NAT, true);
 
-	f2fs_down_read(&nm_i->nat_tree_lock);
+	f2fs_down_read_trace(&nm_i->nat_tree_lock, &lc);
 
 	while (1) {
 		if (!test_bit_le(NAT_BLOCK_OFFSET(nid),
@@ -2642,7 +2650,7 @@ static int __f2fs_build_free_nids(struct f2fs_sb_info *sbi,
 			}
 
 			if (ret) {
-				f2fs_up_read(&nm_i->nat_tree_lock);
+				f2fs_up_read_trace(&nm_i->nat_tree_lock, &lc);
 
 				if (ret == -EFSCORRUPTED) {
 					f2fs_err(sbi, "NAT is corrupt, run fsck to fix it");
@@ -2669,7 +2677,7 @@ static int __f2fs_build_free_nids(struct f2fs_sb_info *sbi,
 	/* find free nids from current sum_pages */
 	scan_curseg_cache(sbi);
 
-	f2fs_up_read(&nm_i->nat_tree_lock);
+	f2fs_up_read_trace(&nm_i->nat_tree_lock, &lc);
 
 	f2fs_ra_meta_pages(sbi, NAT_BLOCK_OFFSET(nm_i->next_scan_nid),
 					nm_i->ra_nid_pages, META_NAT, false);
@@ -3206,21 +3214,22 @@ int f2fs_flush_nat_entries(struct f2fs_sb_info *sbi, struct cp_control *cpc)
 	nid_t set_idx = 0;
 	LIST_HEAD(sets);
 	int err = 0;
+	struct f2fs_lock_context lc;
 
 	/*
 	 * during unmount, let's flush nat_bits before checking
 	 * nat_cnt[DIRTY_NAT].
 	 */
 	if (enabled_nat_bits(sbi, cpc)) {
-		f2fs_down_write(&nm_i->nat_tree_lock);
+		f2fs_down_write_trace(&nm_i->nat_tree_lock, &lc);
 		remove_nats_in_journal(sbi);
-		f2fs_up_write(&nm_i->nat_tree_lock);
+		f2fs_up_write_trace(&nm_i->nat_tree_lock, &lc);
 	}
 
 	if (!nm_i->nat_cnt[DIRTY_NAT])
 		return 0;
 
-	f2fs_down_write(&nm_i->nat_tree_lock);
+	f2fs_down_write_trace(&nm_i->nat_tree_lock, &lc);
 
 	/*
 	 * if there are no enough space in journal to store dirty nat
@@ -3261,7 +3270,7 @@ int f2fs_flush_nat_entries(struct f2fs_sb_info *sbi, struct cp_control *cpc)
 			break;
 	}
 
-	f2fs_up_write(&nm_i->nat_tree_lock);
+	f2fs_up_write_trace(&nm_i->nat_tree_lock, &lc);
 	/* Allow dirty nats by node block allocation in write_begin */
 
 	return err;
@@ -3380,7 +3389,8 @@ static int init_node_manager(struct f2fs_sb_info *sbi)
 
 	mutex_init(&nm_i->build_lock);
 	spin_lock_init(&nm_i->nid_list_lock);
-	init_f2fs_rwsem(&nm_i->nat_tree_lock);
+	init_f2fs_rwsem_trace(&nm_i->nat_tree_lock, sbi,
+						LOCK_NAME_NAT_TREE_LOCK);
 
 	nm_i->next_scan_nid = le32_to_cpu(sbi->ckpt->next_free_nid);
 	nm_i->bitmap_size = __bitmap_size(sbi, NAT_BITMAP);
@@ -3472,6 +3482,7 @@ void f2fs_destroy_node_manager(struct f2fs_sb_info *sbi)
 	struct nat_entry_set **setvec = (struct nat_entry_set **)vec;
 	nid_t nid = 0;
 	unsigned int found;
+	struct f2fs_lock_context lc;
 
 	if (!nm_i)
 		return;
@@ -3490,7 +3501,7 @@ void f2fs_destroy_node_manager(struct f2fs_sb_info *sbi)
 	spin_unlock(&nm_i->nid_list_lock);
 
 	/* destroy nat cache */
-	f2fs_down_write(&nm_i->nat_tree_lock);
+	f2fs_down_write_trace(&nm_i->nat_tree_lock, &lc);
 	while ((found = __gang_lookup_nat_cache(nm_i,
 					nid, NAT_VEC_SIZE, natvec))) {
 		unsigned idx;
@@ -3521,7 +3532,7 @@ void f2fs_destroy_node_manager(struct f2fs_sb_info *sbi)
 			kmem_cache_free(nat_entry_set_slab, setvec[idx]);
 		}
 	}
-	f2fs_up_write(&nm_i->nat_tree_lock);
+	f2fs_up_write_trace(&nm_i->nat_tree_lock, &lc);
 
 	kvfree(nm_i->nat_block_bitmap);
 	if (nm_i->free_nid_bitmap) {
diff --git a/include/trace/events/f2fs.h b/include/trace/events/f2fs.h
index 1dd9fc5afc46..d53be932df01 100644
--- a/include/trace/events/f2fs.h
+++ b/include/trace/events/f2fs.h
@@ -191,7 +191,8 @@ TRACE_DEFINE_ENUM(CP_PHASE_FINISH_CHECKPOINT);
 		{ LOCK_NAME_NODE_WRITE,		"node_write" },		\
 		{ LOCK_NAME_GC_LOCK,		"gc_lock" },		\
 		{ LOCK_NAME_CP_GLOBAL,		"cp_global" },		\
-		{ LOCK_NAME_IO_RWSEM,		"io_rwsem" })
+		{ LOCK_NAME_IO_RWSEM,		"io_rwsem" },		\
+		{ LOCK_NAME_NAT_TREE_LOCK,	"nat_tree_lock" })
 
 struct f2fs_sb_info;
 struct f2fs_io_info;
-- 
2.49.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
