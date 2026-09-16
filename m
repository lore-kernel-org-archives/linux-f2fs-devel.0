Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B776CC982C4
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 16 Sep 2026 01:55:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-ID:Date:To:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=e7eTm00NMGPyjjelcMK3RDTCrsFMD9VC2HeEXVWUMMI=; b=ltwjDVpR83IjwYS1rwICZJLIcv
	1H5Uwup2pQMqOrRtIrrVWWqBv45El/yooD6inN/j+iAQUusttaXL0vWRzEUEcRd0S9woUCWc10oIz
	qsYnFQ5GRLdW1ssXkjnRvDcNQFSST0w4uz7F+aJaJrHDHG/Gj4AsLUKvOseV58ygfGPM=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1x6erh-0002Am-Rg;
	Wed, 16 Sep 2026 01:55:11 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1x6erb-0002AC-K5
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 16 Sep 2026 01:55:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=+f9vmiE0wHzD9eQOo+Cugp7Qr4dcLEUUqOtW6Gfp7k4=; b=WSZamvsKfcWuJK/uMe9TSbgEl0
 DPWWMYz1RCciZ0lUiQuCYf8Uunv/oXi+crkd1pFsgmHqnoyJZuut++CN6wOU+Zd4+ju4A8B9aNHkj
 7fhGLPb0Zeff4KU84sKZ/vLgj5tFygPYolghC1HUddbPfkkxUUgUl7drWILNH/IX7n7I=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=+f9vmiE0wHzD9eQOo+Cugp7Qr4dcLEUUqOtW6Gfp7k4=; b=aY6/Ieh1o9JPRaOAhiEJ7fWKiO
 smoNfzWpu0pH4pczvpEao0bLbB0pM7TLjNF3VuJhWiERuDdVpY4u0yqrP+yS1i+BmdnCXM3y9T2z4
 +oKMvJ4qC+hFJpz7gzndmBFap+zVb1m4paC3O4TU2QzPRDEIGSv0fbxYZgzsntLJSOhM=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1x6erV-0004wM-3W for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 16 Sep 2026 01:55:05 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id C0F674182C
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed, 16 Sep 2026 01:54:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C0B41F000FF;
 Wed, 16 Sep 2026 01:54:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789523695;
 bh=+f9vmiE0wHzD9eQOo+Cugp7Qr4dcLEUUqOtW6Gfp7k4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=mNiq9BFIg+zfBYme+z7N3aYXTgzIZg2RmpblyPgIuSsI0PAlxrPR3SPnKtdGi/bx1
 V3t9etD1BfiyN7uIaL6sDJ3ibTUinOWKCQZxsBQRc62qyZRlG3g2CDm5S4l8hObzVo
 GLAUhH9BtcN7RtLD47AH6UQ/q/J+JW69ESf08bcP5v9PosI432NDecIgtqZs6XYI+S
 C4vufumgV3MxfifY+AVc1P//bFngLMMH7laiPROTbXQ47ju5wR05U4h9ffRJD4H3GL
 3IBHkkze/ndvBA+Nc9aiI/99DIiQ3f+iU5rXto3gLU0Ske2bZsy+LAA5iAdcM1wCnr
 p+08xDJ4E/7Lg==
To: jaegeuk@kernel.org
Date: Wed, 16 Sep 2026 09:54:35 +0800
Message-ID: <20260916015440.2232938-8-chao@kernel.org>
X-Mailer: git-send-email 2.55.0.1032.g73a4cd73de-goog
In-Reply-To: <20260916015440.2232938-1-chao@kernel.org>
References: <20260916015440.2232938-1-chao@kernel.org>
MIME-Version: 1.0
X-Headers-End: 1x6erV-0004wM-3W
Subject: [f2fs-dev] [PATCH v8 07/12] f2fs: cache: use node cache
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

From: Chao Yu <chao@kernel.org>

This patch migrates F2FS node block caching from the fake VFS inode
page cache (sbi->node_inode) to node cache (sbi->node_blocks).

It updates node related helpers to use node cache APIs and reference to
struct f2fs_cached_block, and removes sbi->node_inode, especially, unifies
inline and regular dentry block handling via struct f2fs_dentry_block_ref.

Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/acl.c           |  26 +-
 fs/f2fs/acl.h           |   8 +-
 fs/f2fs/cache.c         |   7 +-
 fs/f2fs/cache.h         |   3 +-
 fs/f2fs/checkpoint.c    |  17 +-
 fs/f2fs/compress.c      |  18 +-
 fs/f2fs/data.c          | 249 +++++------
 fs/f2fs/debug.c         |  12 +-
 fs/f2fs/dir.c           | 170 +++----
 fs/f2fs/extent_cache.c  |  14 +-
 fs/f2fs/f2fs.h          | 259 ++++++-----
 fs/f2fs/file.c          |  78 ++--
 fs/f2fs/gc.c            |  50 +--
 fs/f2fs/inline.c        | 279 ++++++------
 fs/f2fs/inode.c         | 167 ++++---
 fs/f2fs/namei.c         | 114 ++---
 fs/f2fs/node.c          | 953 +++++++++++++++++++---------------------
 fs/f2fs/node.h          | 108 ++---
 fs/f2fs/recovery.c      | 117 ++---
 fs/f2fs/segment.c       |  59 ++-
 fs/f2fs/segment.h       |  20 -
 fs/f2fs/shrinker.c      |   3 +-
 fs/f2fs/super.c         |  56 +--
 fs/f2fs/xattr.c         | 123 +++---
 fs/f2fs/xattr.h         |  12 +-
 include/linux/f2fs_fs.h |   1 -
 26 files changed, 1420 insertions(+), 1503 deletions(-)

diff --git a/fs/f2fs/acl.c b/fs/f2fs/acl.c
index d3253549173e..34c9aa279040 100644
--- a/fs/f2fs/acl.c
+++ b/fs/f2fs/acl.c
@@ -181,7 +181,7 @@ static void *f2fs_acl_to_disk(struct f2fs_sb_info *sbi,
 }
 
 static struct posix_acl *__f2fs_get_acl(struct inode *inode, int type,
-						struct folio *dfolio)
+						struct f2fs_cached_block *entry)
 {
 	int name_index = F2FS_XATTR_INDEX_POSIX_ACL_DEFAULT;
 	void *value = NULL;
@@ -191,13 +191,13 @@ static struct posix_acl *__f2fs_get_acl(struct inode *inode, int type,
 	if (type == ACL_TYPE_ACCESS)
 		name_index = F2FS_XATTR_INDEX_POSIX_ACL_ACCESS;
 
-	retval = f2fs_getxattr(inode, name_index, "", NULL, 0, dfolio);
+	retval = f2fs_getxattr(inode, name_index, "", NULL, 0, entry);
 	if (retval > 0) {
 		value = f2fs_kmalloc(F2FS_I_SB(inode), retval, GFP_F2FS_ZERO);
 		if (!value)
 			return ERR_PTR(-ENOMEM);
 		retval = f2fs_getxattr(inode, name_index, "", value,
-							retval, dfolio);
+							retval, entry);
 	}
 
 	if (retval > 0)
@@ -242,7 +242,7 @@ static int f2fs_acl_update_mode(struct mnt_idmap *idmap,
 
 static int __f2fs_set_acl(struct mnt_idmap *idmap,
 			struct inode *inode, int type,
-			struct posix_acl *acl, struct folio *ifolio)
+			struct posix_acl *acl, struct f2fs_cached_block *ientry)
 {
 	int name_index;
 	void *value = NULL;
@@ -253,7 +253,7 @@ static int __f2fs_set_acl(struct mnt_idmap *idmap,
 	switch (type) {
 	case ACL_TYPE_ACCESS:
 		name_index = F2FS_XATTR_INDEX_POSIX_ACL_ACCESS;
-		if (acl && !ifolio) {
+		if (acl && !ientry) {
 			error = f2fs_acl_update_mode(idmap, inode, &mode, &acl);
 			if (error)
 				return error;
@@ -279,7 +279,7 @@ static int __f2fs_set_acl(struct mnt_idmap *idmap,
 		}
 	}
 
-	error = f2fs_setxattr(inode, name_index, "", value, size, ifolio, 0);
+	error = f2fs_setxattr(inode, name_index, "", value, size, ientry, 0);
 
 	kfree(value);
 	if (!error)
@@ -374,7 +374,7 @@ static int f2fs_acl_create_masq(struct posix_acl *acl, umode_t *mode_p)
 
 static int f2fs_acl_create(struct inode *dir, umode_t *mode,
 		struct posix_acl **default_acl, struct posix_acl **acl,
-		struct folio *dfolio)
+		struct f2fs_cached_block *entry)
 {
 	struct posix_acl *p;
 	struct posix_acl *clone;
@@ -386,7 +386,7 @@ static int f2fs_acl_create(struct inode *dir, umode_t *mode,
 	if (S_ISLNK(*mode) || !IS_POSIXACL(dir))
 		return 0;
 
-	p = __f2fs_get_acl(dir, ACL_TYPE_DEFAULT, dfolio);
+	p = __f2fs_get_acl(dir, ACL_TYPE_DEFAULT, entry);
 	if (!p || p == ERR_PTR(-EOPNOTSUPP)) {
 		*mode &= ~current_umask();
 		return 0;
@@ -423,13 +423,13 @@ static int f2fs_acl_create(struct inode *dir, umode_t *mode,
 	return ret;
 }
 
-int f2fs_init_acl(struct inode *inode, struct inode *dir, struct folio *ifolio,
-							struct folio *dfolio)
+int f2fs_init_acl(struct inode *inode, struct inode *dir, struct f2fs_cached_block *ientry,
+							struct f2fs_cached_block *dentry)
 {
 	struct posix_acl *default_acl = NULL, *acl = NULL;
 	int error;
 
-	error = f2fs_acl_create(dir, &inode->i_mode, &default_acl, &acl, dfolio);
+	error = f2fs_acl_create(dir, &inode->i_mode, &default_acl, &acl, dentry);
 	if (error)
 		return error;
 
@@ -437,7 +437,7 @@ int f2fs_init_acl(struct inode *inode, struct inode *dir, struct folio *ifolio,
 
 	if (default_acl) {
 		error = __f2fs_set_acl(NULL, inode, ACL_TYPE_DEFAULT,
-				default_acl, ifolio);
+				default_acl, ientry);
 		posix_acl_release(default_acl);
 	} else {
 		inode->i_default_acl = NULL;
@@ -445,7 +445,7 @@ int f2fs_init_acl(struct inode *inode, struct inode *dir, struct folio *ifolio,
 	if (acl) {
 		if (!error)
 			error = __f2fs_set_acl(NULL, inode, ACL_TYPE_ACCESS,
-					acl, ifolio);
+					acl, ientry);
 		posix_acl_release(acl);
 	} else {
 		inode->i_acl = NULL;
diff --git a/fs/f2fs/acl.h b/fs/f2fs/acl.h
index 20e87e63c089..0f639367a0ab 100644
--- a/fs/f2fs/acl.h
+++ b/fs/f2fs/acl.h
@@ -36,14 +36,16 @@ struct f2fs_acl_header {
 struct posix_acl *f2fs_get_acl(struct inode *, int, bool);
 int f2fs_set_acl(struct mnt_idmap *, struct dentry *,
 			struct posix_acl *, int);
-int f2fs_init_acl(struct inode *, struct inode *, struct folio *ifolio,
-		struct folio *dfolio);
+int f2fs_init_acl(struct inode *inode, struct inode *dir,
+			struct f2fs_cached_block *ientry,
+			struct f2fs_cached_block *dentry);
 #else
 #define f2fs_get_acl	NULL
 #define f2fs_set_acl	NULL
 
 static inline int f2fs_init_acl(struct inode *inode, struct inode *dir,
-				struct folio *ifolio, struct folio *dfolio)
+				struct f2fs_cached_block *ientry,
+				struct f2fs_cached_block *dentry)
 {
 	return 0;
 }
diff --git a/fs/f2fs/cache.c b/fs/f2fs/cache.c
index 8ab5e0e46b4e..3abd469dc011 100644
--- a/fs/f2fs/cache.c
+++ b/fs/f2fs/cache.c
@@ -28,7 +28,7 @@ void f2fs_cache_wait_writeback_cond(struct f2fs_cached_block *entry,
 		return;
 
 	/* submit cached bio */
-	f2fs_submit_merged_write_cache(entry, type);
+	f2fs_submit_merged_write_cache(entry->cache->sbi, entry, 0, type);
 
 	wait_on_bit_io(&entry->state, F2FS_BLOCK_WRITEBACK,
 					TASK_UNINTERRUPTIBLE);
@@ -65,8 +65,8 @@ bool f2fs_mark_cache_dirty(struct f2fs_cached_block *entry)
 	f2fs_cache_set_uptodate(entry);
 
 #ifdef CONFIG_F2FS_CHECK_FS
-	if (cache->type == F2FS_NODE_CACHE && IS_INODE(cache->sbi, cache_folio(entry)))
-		f2fs_inode_chksum_set(cache->sbi, cache_folio(entry));
+	if (f2fs_is_node_cache(entry) && IS_INODE(cache->sbi, entry))
+		f2fs_inode_chksum_set(cache->sbi, entry);
 #endif
 
 	if (!f2fs_cache_test_and_set_dirty(entry)) {
@@ -665,6 +665,7 @@ static int f2fs_cache_writeback_kthread(void *data)
 			continue;
 
 		f2fs_write_meta_caches(sbi);
+		f2fs_write_node_caches(sbi);
 
 		sb_end_write(sbi->sb);
 	}
diff --git a/fs/f2fs/cache.h b/fs/f2fs/cache.h
index 1eabd787b4b7..a36ee57adb1a 100644
--- a/fs/f2fs/cache.h
+++ b/fs/f2fs/cache.h
@@ -48,6 +48,7 @@ struct f2fs_cached_block_list {
 };
 
 #define IS_META_CACHE(cache) ((cache)->type == F2FS_META_CACHE)
+#define IS_NODE_CACHE(cache) ((cache)->type == F2FS_NODE_CACHE)
 
 /* Flags for f2fs_cached_block state */
 enum f2fs_cached_state {
@@ -207,7 +208,7 @@ void f2fs_drop_cache_range(struct f2fs_cached_block_list *cache,
 	f2fs_grab_cache(NODE_CACHE(sbi), blkaddr,	\
 	F2FS_CACHE_LOCK_CREATE)
 #define f2fs_find_node_cache(sbi, blkaddr)		\
-	f2fs_find_cache(NODE_CACHE(sbi), blkaddr)
+	f2fs_find_cache(NODE_CACHE(sbi), blkaddr, F2FS_CACHE_ACCESS)
 #define f2fs_invalidate_node_cache(sbi, blkaddr)	\
 	f2fs_drop_cache_range(NODE_CACHE(sbi), blkaddr, 1, false)
 #define f2fs_truncate_node_caches(sbi, start, len)	\
diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index 8e524d9860a2..fe7e8bab644b 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -927,7 +927,7 @@ void f2fs_add_orphan_inode(struct inode *inode)
 {
 	/* add new orphan ino entry into list */
 	f2fs_add_ino_entry(F2FS_I_SB(inode), inode->i_ino, ORPHAN_INO);
-	f2fs_update_inode_page(inode);
+	f2fs_update_inode_cache(inode);
 }
 
 void f2fs_remove_orphan_inode(struct f2fs_sb_info *sbi, nid_t ino)
@@ -1428,7 +1428,7 @@ static int f2fs_sync_inode_meta(struct f2fs_sb_info *sbi)
 
 			/* it's on eviction */
 			if (is_inode_flag_set(inode, FI_DIRTY_INODE))
-				f2fs_update_inode_page(inode);
+				f2fs_update_inode_cache(inode);
 			iput(inode);
 		} else {
 			cond_resched();
@@ -1483,14 +1483,10 @@ static bool __need_flush_quota(struct f2fs_sb_info *sbi)
  */
 static int block_operations(struct f2fs_sb_info *sbi)
 {
-	struct writeback_control wbc = {
-		.sync_mode = WB_SYNC_ALL,
-		.nr_to_write = LONG_MAX,
-	};
 	int err = 0, cnt = 0;
 
 	/*
-	 * Let's flush inline_data in dirty node pages.
+	 * Let's flush inline_data in dirty node caches.
 	 */
 	f2fs_flush_inline_data(sbi);
 
@@ -1529,7 +1525,7 @@ static int block_operations(struct f2fs_sb_info *sbi)
 	}
 
 	/*
-	 * POR: we should ensure that there are no dirty node pages
+	 * POR: we should ensure that there are no dirty node caches
 	 * until finishing nat/sit flush. inode->i_blocks can be updated.
 	 */
 	f2fs_down_write(&sbi->node_change);
@@ -1550,7 +1546,8 @@ static int block_operations(struct f2fs_sb_info *sbi)
 	if (get_pages(sbi, F2FS_DIRTY_NODES)) {
 		f2fs_up_write(&sbi->node_write);
 		atomic_inc(&sbi->wb_sync_req[NODE]);
-		err = f2fs_sync_node_pages(sbi, &wbc, false, FS_CP_NODE_IO);
+		err = f2fs_writeback_node_caches(sbi, LONG_MAX,
+			true, false, FS_CP_NODE_IO);
 		atomic_dec(&sbi->wb_sync_req[NODE]);
 		if (err) {
 			f2fs_up_write(&sbi->node_change);
@@ -1900,7 +1897,7 @@ static int do_checkpoint(struct f2fs_sb_info *sbi, struct cp_control *cpc)
 	__set_cp_next_pack(sbi);
 
 	/*
-	 * redirty superblock if metadata like node page or inode cache is
+	 * redirty superblock if metadata like node caches or inode cache is
 	 * updated during writing checkpoint.
 	 */
 	if (get_pages(sbi, F2FS_DIRTY_NODES) ||
diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
index f85bbadde53f..d7f7c35e710f 100644
--- a/fs/f2fs/compress.c
+++ b/fs/f2fs/compress.c
@@ -909,7 +909,7 @@ bool f2fs_sanity_check_cluster(struct dnode_of_data *dn)
 	}
 
 	for (i = 1, count = 1; i < cluster_size; i++, count++) {
-		block_t blkaddr = data_blkaddr(dn->inode, dn->node_folio,
+		block_t blkaddr = data_blkaddr(dn->inode, dn->node_entry,
 							dn->ofs_in_node + i);
 
 		/* [COMPR_ADDR, ..., COMPR_ADDR] */
@@ -950,7 +950,7 @@ static int __f2fs_get_cluster_blocks(struct inode *inode,
 	int count, i;
 
 	for (i = 0, count = 0; i < cluster_size; i++) {
-		block_t blkaddr = data_blkaddr(dn->inode, dn->node_folio,
+		block_t blkaddr = data_blkaddr(dn->inode, dn->node_entry,
 							dn->ofs_in_node + i);
 
 		if (__is_valid_data_blkaddr(blkaddr))
@@ -1146,7 +1146,7 @@ static int prepare_compress_overwrite(struct compress_ctx *cc,
 			goto release_and_retry;
 		}
 
-		f2fs_folio_wait_writeback(folio, DATA, true, true);
+		f2fs_folio_wait_writeback(folio, true, true);
 		f2fs_compress_ctx_add_page(cc, folio);
 
 		if (!folio_test_uptodate(folio)) {
@@ -1322,7 +1322,7 @@ static int f2fs_write_compressed_pages(struct compress_ctx *cc,
 		goto out_unlock_op;
 
 	for (i = 0; i < cc->cluster_size; i++) {
-		if (data_blkaddr(dn.inode, dn.node_folio,
+		if (data_blkaddr(dn.inode, dn.node_entry,
 					dn.ofs_in_node + i) == NULL_ADDR)
 			goto out_put_dnode;
 	}
@@ -1354,7 +1354,7 @@ static int f2fs_write_compressed_pages(struct compress_ctx *cc,
 				page_folio(cc->rpages[i + 1])->index, cic);
 		fio.compressed_page = cc->cpages[i];
 
-		fio.old_blkaddr = data_blkaddr(dn.inode, dn.node_folio,
+		fio.old_blkaddr = data_blkaddr(dn.inode, dn.node_entry,
 						dn.ofs_in_node + i + 1);
 
 		/* wait for GCed page writeback via generic cache */
@@ -1542,7 +1542,7 @@ static int f2fs_write_raw_pages(struct compress_ctx *cc,
 		if (folio_test_writeback(folio)) {
 			if (wbc->sync_mode == WB_SYNC_NONE)
 				goto continue_unlock;
-			f2fs_folio_wait_writeback(folio, DATA, true, true);
+			f2fs_folio_wait_writeback(folio, true, true);
 		}
 
 		if (!folio_clear_dirty_for_io(folio))
@@ -1874,14 +1874,14 @@ void f2fs_put_folio_dic(struct folio *folio, bool in_task)
 unsigned int f2fs_cluster_blocks_are_contiguous(struct dnode_of_data *dn,
 						unsigned int ofs_in_node)
 {
-	bool compressed = data_blkaddr(dn->inode, dn->node_folio,
+	bool compressed = data_blkaddr(dn->inode, dn->node_entry,
 					ofs_in_node) == COMPRESS_ADDR;
 	int i = compressed ? 1 : 0;
-	block_t first_blkaddr = data_blkaddr(dn->inode, dn->node_folio,
+	block_t first_blkaddr = data_blkaddr(dn->inode, dn->node_entry,
 							ofs_in_node + i);
 
 	for (i += 1; i < F2FS_I(dn->inode)->i_cluster_size; i++) {
-		block_t blkaddr = data_blkaddr(dn->inode, dn->node_folio,
+		block_t blkaddr = data_blkaddr(dn->inode, dn->node_entry,
 							ofs_in_node + i);
 
 		if (!__is_valid_data_blkaddr(blkaddr))
diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 674d1b8e33d8..9a1d31df5f4f 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -58,13 +58,10 @@ bool f2fs_is_cp_guaranteed(const struct folio *folio)
 {
 	struct address_space *mapping = folio->mapping;
 	struct inode *inode;
-	struct f2fs_sb_info *sbi;
 
 	inode = mapping->host;
-	sbi = F2FS_I_SB(inode);
 
-	if (inode->i_ino == F2FS_NODE_INO(sbi) ||
-			S_ISDIR(inode->i_mode))
+	if (S_ISDIR(inode->i_mode))
 		return true;
 
 	if ((S_ISREG(inode->i_mode) && IS_NOQUOTA(inode)) ||
@@ -73,20 +70,6 @@ bool f2fs_is_cp_guaranteed(const struct folio *folio)
 	return false;
 }
 
-static enum count_type __read_io_type(struct folio *folio)
-{
-	struct address_space *mapping = folio->mapping;
-
-	if (mapping) {
-		struct inode *inode = mapping->host;
-		struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
-
-		if (inode->i_ino == F2FS_NODE_INO(sbi))
-			return F2FS_RD_NODE;
-	}
-	return F2FS_RD_DATA;
-}
-
 /* postprocessing steps for read bios */
 enum bio_post_read_step {
 #ifdef CONFIG_F2FS_FS_COMPRESSION
@@ -160,14 +143,7 @@ static void f2fs_finish_read_bio(struct bio *bio, bool in_task)
 		}
 
 		while (nr_pages--)
-			dec_page_count(F2FS_F_SB(folio), __read_io_type(folio));
-
-		if (bio->bi_status == BLK_STS_OK &&
-			F2FS_F_SB(folio)->node_inode &&
-			is_node_folio(F2FS_F_SB(folio), folio) &&
-			f2fs_sanity_check_node_footer(F2FS_F_SB(folio),
-				folio, folio->index, NODE_TYPE_REGULAR, true))
-			bio->bi_status = BLK_STS_IOERR;
+			dec_page_count(F2FS_F_SB(folio), F2FS_RD_DATA);
 
 		if (finished)
 			folio_end_read(folio, bio->bi_status == BLK_STS_OK);
@@ -351,14 +327,6 @@ static void f2fs_write_end_bio(struct bio *bio)
 			}
 		}
 
-		if (is_node_folio(sbi, folio)) {
-			f2fs_sanity_check_node_footer(sbi, folio,
-				folio->index, NODE_TYPE_REGULAR, true);
-			f2fs_bug_on(sbi, folio->index != nid_of_node(sbi, folio));
-		}
-		if (f2fs_in_warm_node_list(sbi, folio))
-			f2fs_del_fsync_node_entry(sbi, folio);
-
 		dec_page_count(sbi, type);
 
 		/*
@@ -419,6 +387,12 @@ static void f2fs_cache_read_end_io(struct bio *bio)
 		next = entry->next_entry;
 		entry->next_entry = NULL;
 
+		if (bio->bi_status == BLK_STS_OK &&
+			f2fs_is_node_cache(entry) &&
+			f2fs_sanity_check_node_footer(sbi, entry,
+				entry->index, NODE_TYPE_REGULAR, true))
+			bio->bi_status = BLK_STS_IOERR;
+
 		if (bio->bi_status == BLK_STS_OK)
 			f2fs_cache_set_uptodate(entry);
 
@@ -449,6 +423,14 @@ static void f2fs_cache_write_end_io(struct bio *bio)
 		next = entry->next_entry;
 		entry->next_entry = NULL;
 
+		if (f2fs_is_node_cache(entry)) {
+			f2fs_sanity_check_node_footer(sbi, entry,
+				entry->index, NODE_TYPE_REGULAR, true);
+			f2fs_bug_on(sbi, entry->index != nid_of_node(sbi, entry));
+		}
+		if (f2fs_in_warm_node_list(sbi, entry))
+			f2fs_del_fsync_node_entry(sbi, entry);
+
 		dec_page_count(sbi, F2FS_WB_CP_DATA);
 
 		if (!get_pages(sbi, F2FS_WB_CP_DATA) &&
@@ -655,15 +637,15 @@ static void __submit_merged_bio(struct f2fs_bio_info *io)
 	io->bio = NULL;
 }
 
-static bool __has_merged_page(struct f2fs_sb_info *sbi, struct bio *bio,
-			struct inode *inode, struct folio *folio, nid_t ino)
+static bool __has_merged_page(struct bio *bio, struct inode *inode,
+						struct folio *folio)
 {
 	struct folio_iter fi;
 
 	if (!bio)
 		return false;
 
-	if (!inode && !folio && !ino)
+	if (!inode && !folio)
 		return true;
 
 	if (f2fs_is_cache_bio(bio))
@@ -682,8 +664,6 @@ static bool __has_merged_page(struct f2fs_sb_info *sbi, struct bio *bio,
 			return true;
 		if (folio && folio == target)
 			return true;
-		if (ino && ino == ino_of_node(sbi, target))
-			return true;
 	}
 
 	return false;
@@ -752,24 +732,23 @@ static void __f2fs_submit_merged_write(struct f2fs_sb_info *sbi,
 
 static void __submit_merged_write_cond(struct f2fs_sb_info *sbi,
 				struct inode *inode, struct folio *folio,
-				nid_t ino, enum page_type type, bool writeback)
+				bool writeback)
 {
 	enum temp_type temp;
 	bool ret = true;
-	bool force = !inode && !folio && !ino;
+	bool force = !inode && !folio;
 
 	for (temp = HOT; temp < NR_TEMP_TYPE; temp++) {
-		if (!force)	{
-			enum page_type btype = PAGE_TYPE_OF_BIO(type);
-			struct f2fs_bio_info *io = sbi->write_io[btype] + temp;
+		if (!force) {
+			struct f2fs_bio_info *io = sbi->write_io[DATA] + temp;
 			struct f2fs_lock_context lc;
 
 			f2fs_down_read_trace(&io->io_rwsem, &lc);
-			ret = __has_merged_page(io->sbi, io->bio, inode, folio, ino);
+			ret = __has_merged_page(io->bio, inode, folio);
 			f2fs_up_read_trace(&io->io_rwsem, &lc);
 		}
 		if (ret) {
-			__f2fs_submit_merged_write(sbi, type, temp);
+			__f2fs_submit_merged_write(sbi, DATA, temp);
 			/*
 			 * For waitting writebck case, if the bio owned by the
 			 * folio is already submitted, we do not need to submit
@@ -778,33 +757,23 @@ static void __submit_merged_write_cond(struct f2fs_sb_info *sbi,
 			if (writeback)
 				break;
 		}
-
-		/* TODO: use HOT temp only for meta pages now. */
-		if (type >= META)
-			break;
 	}
 }
 
-void f2fs_submit_merged_write(struct f2fs_sb_info *sbi, enum page_type type)
-{
-	__submit_merged_write_cond(sbi, NULL, NULL, 0, type, false);
-}
-
 void f2fs_submit_merged_write_cond(struct f2fs_sb_info *sbi,
-				struct inode *inode, struct folio *folio,
-				nid_t ino, enum page_type type)
+				struct inode *inode, struct folio *folio)
 {
-	__submit_merged_write_cond(sbi, inode, folio, ino, type, false);
+	__submit_merged_write_cond(sbi, inode, folio, false);
 }
 
 void f2fs_submit_merged_write_folio(struct f2fs_sb_info *sbi,
-				struct folio *folio, enum page_type type)
+				struct folio *folio)
 {
-	__submit_merged_write_cond(sbi, NULL, folio, 0, type, true);
+	__submit_merged_write_cond(sbi, NULL, folio, true);
 }
 
-static bool __has_merged_cache(struct bio *bio,
-		struct f2fs_cached_block *target)
+static bool __has_merged_cache(struct f2fs_sb_info *sbi, struct bio *bio,
+		struct f2fs_cached_block *target, nid_t ino)
 {
 	struct f2fs_cached_block *entry;
 
@@ -816,27 +785,39 @@ static bool __has_merged_cache(struct bio *bio,
 	while (entry) {
 		if (target && entry == target)
 			return true;
+
+		if (ino) {
+			if (likely(f2fs_is_node_cache(entry))) {
+				if (ino_of_node(sbi, entry) == ino)
+					return true;
+			} else {
+				WARN_ON_ONCE(1);
+			}
+		}
 		entry = entry->next_entry;
 	}
 	return false;
 }
 
-bool f2fs_submit_merged_write_cache(struct f2fs_cached_block *entry,
-				enum page_type type)
+bool f2fs_submit_merged_write_cache(struct f2fs_sb_info *sbi,
+				struct f2fs_cached_block *entry,
+				nid_t ino, enum page_type type)
 {
-	struct f2fs_sb_info *sbi = entry->cache->sbi;
 	enum temp_type temp;
 	bool ret = false;
+	bool force = !entry && !ino;
 
 	for (temp = HOT; temp < NR_TEMP_TYPE; temp++) {
 		enum page_type btype = PAGE_TYPE_OF_BIO(type);
 		struct f2fs_bio_info *io = sbi->write_io[btype] + temp;
 		struct f2fs_lock_context lc;
-		bool merged;
+		bool merged = true;
 
-		f2fs_down_read_trace(&io->io_rwsem, &lc);
-		merged = __has_merged_cache(io->bio, entry);
-		f2fs_up_read_trace(&io->io_rwsem, &lc);
+		if (!force) {
+			f2fs_down_read_trace(&io->io_rwsem, &lc);
+			merged = __has_merged_cache(sbi, io->bio, entry, ino);
+			f2fs_up_read_trace(&io->io_rwsem, &lc);
+		}
 
 		if (merged) {
 			__f2fs_submit_merged_write(sbi, type, temp);
@@ -850,6 +831,14 @@ bool f2fs_submit_merged_write_cache(struct f2fs_cached_block *entry,
 	return ret;
 }
 
+void f2fs_submit_merged_write(struct f2fs_sb_info *sbi, enum page_type type)
+{
+	if (type == DATA)
+		__submit_merged_write_cond(sbi, NULL, NULL, false);
+	else
+		f2fs_submit_merged_write_cache(sbi, NULL, 0, type);
+}
+
 void f2fs_flush_merged_writes(struct f2fs_sb_info *sbi)
 {
 	f2fs_submit_merged_write(sbi, DATA);
@@ -886,7 +875,7 @@ int f2fs_submit_page_bio(struct f2fs_io_info *fio)
 		wbc_account_cgroup_owner(fio->io_wbc, fio_folio, PAGE_SIZE);
 
 	inc_page_count(fio->sbi, is_read_io(fio->op) ?
-			__read_io_type(data_folio) : WB_DATA_TYPE(fio->folio, false));
+			F2FS_RD_DATA : WB_DATA_TYPE(fio->folio, false));
 
 	if (is_read_io(bio_op(bio)))
 		f2fs_submit_read_bio(fio->sbi, bio, fio->type);
@@ -1022,8 +1011,8 @@ void f2fs_submit_merged_ipu_write(struct f2fs_sb_info *sbi,
 			if (target)
 				found = (target == be->bio);
 			else
-				found = __has_merged_page(sbi, be->bio, NULL,
-							folio, 0);
+				found = __has_merged_page(be->bio,
+							NULL, folio);
 			if (found)
 				break;
 		}
@@ -1039,8 +1028,8 @@ void f2fs_submit_merged_ipu_write(struct f2fs_sb_info *sbi,
 			if (target)
 				found = (target == be->bio);
 			else
-				found = __has_merged_page(sbi, be->bio, NULL,
-							folio, 0);
+				found = __has_merged_page(be->bio,
+							NULL, folio);
 			if (found) {
 				target = be->bio;
 				del_bio_entry(be);
@@ -1427,7 +1416,7 @@ static void f2fs_submit_page_read(struct inode *inode, struct fsverity_info *vi,
 
 static void __set_data_blkaddr(struct dnode_of_data *dn, block_t blkaddr)
 {
-	__le32 *addr = get_dnode_addr(dn->inode, dn->node_folio);
+	__le32 *addr = get_dnode_addr(dn->inode, dn->node_entry);
 
 	dn->data_blkaddr = blkaddr;
 	addr[dn->ofs_in_node] = cpu_to_le32(dn->data_blkaddr);
@@ -1441,9 +1430,9 @@ static void __set_data_blkaddr(struct dnode_of_data *dn, block_t blkaddr)
  */
 void f2fs_set_data_blkaddr(struct dnode_of_data *dn, block_t blkaddr)
 {
-	f2fs_folio_wait_writeback(dn->node_folio, NODE, true, true);
+	f2fs_cache_wait_writeback(dn->node_entry);
 	__set_data_blkaddr(dn, blkaddr);
-	if (folio_mark_dirty(dn->node_folio))
+	if (f2fs_mark_cache_dirty(dn->node_entry))
 		dn->node_changed = true;
 }
 
@@ -1471,7 +1460,7 @@ int f2fs_reserve_new_blocks(struct dnode_of_data *dn, blkcnt_t count)
 	trace_f2fs_reserve_new_blocks(dn->inode, dn->nid,
 						dn->ofs_in_node, count);
 
-	f2fs_folio_wait_writeback(dn->node_folio, NODE, true, true);
+	f2fs_cache_wait_writeback(dn->node_entry);
 
 	for (; count > 0; dn->ofs_in_node++) {
 		block_t blkaddr = f2fs_data_blkaddr(dn);
@@ -1482,7 +1471,7 @@ int f2fs_reserve_new_blocks(struct dnode_of_data *dn, blkcnt_t count)
 		}
 	}
 
-	if (folio_mark_dirty(dn->node_folio))
+	if (f2fs_mark_cache_dirty(dn->node_entry))
 		dn->node_changed = true;
 	return 0;
 }
@@ -1500,7 +1489,7 @@ int f2fs_reserve_new_block(struct dnode_of_data *dn)
 
 int f2fs_reserve_block(struct dnode_of_data *dn, pgoff_t index)
 {
-	bool need_put = dn->inode_folio ? false : true;
+	bool need_put = dn->inode_entry ? false : true;
 	int err;
 
 	err = f2fs_get_dnode_of_data(dn, index, ALLOC_NODE);
@@ -1666,11 +1655,11 @@ struct folio *f2fs_get_lock_data_folio(struct inode *inode, pgoff_t index,
  *
  * Also, caller should grab and release a rwsem by calling f2fs_lock_op() and
  * f2fs_unlock_op().
- * Note that, ifolio is set only by make_empty_dir, and if any error occur,
- * ifolio should be released by this function.
+ * Note that, ientry is set only by make_empty_dir, and if any error occur,
+ * ientry should be released by this function.
  */
 struct folio *f2fs_get_new_data_folio(struct inode *inode,
-		struct folio *ifolio, pgoff_t index, bool new_i_size)
+		struct f2fs_cached_block *ientry, pgoff_t index, bool new_i_size)
 {
 	struct address_space *mapping = inode->i_mapping;
 	struct folio *folio;
@@ -1680,20 +1669,20 @@ struct folio *f2fs_get_new_data_folio(struct inode *inode,
 	folio = f2fs_grab_cache_folio(mapping, index, true);
 	if (IS_ERR(folio)) {
 		/*
-		 * before exiting, we should make sure ifolio will be released
+		 * before exiting, we should make sure ientry will be released
 		 * if any error occur.
 		 */
-		f2fs_folio_put(ifolio, true);
+		f2fs_put_cache(ientry, true);
 		return ERR_PTR(-ENOMEM);
 	}
 
-	set_new_dnode(&dn, inode, ifolio, NULL, 0);
+	set_new_dnode(&dn, inode, ientry, NULL, 0);
 	err = f2fs_reserve_block(&dn, index);
 	if (err) {
 		f2fs_folio_put(folio, true);
 		return ERR_PTR(err);
 	}
-	if (!ifolio)
+	if (!ientry)
 		f2fs_put_dnode(&dn);
 
 	if (folio_test_uptodate(folio))
@@ -1706,8 +1695,8 @@ struct folio *f2fs_get_new_data_folio(struct inode *inode,
 	} else {
 		f2fs_folio_put(folio, true);
 
-		/* if ifolio exists, blkaddr should be NEW_ADDR */
-		f2fs_bug_on(F2FS_I_SB(inode), ifolio);
+		/* if ientry exists, blkaddr should be NEW_ADDR */
+		f2fs_bug_on(F2FS_I_SB(inode), ientry);
 		folio = f2fs_get_lock_data_folio(inode, index, true);
 		if (IS_ERR(folio))
 			return folio;
@@ -1744,7 +1733,7 @@ static int __allocate_data_block(struct dnode_of_data *dn, int seg_type)
 
 	set_summary(&sum, dn->nid, dn->ofs_in_node, ni.version);
 	old_blkaddr = dn->data_blkaddr;
-	err = f2fs_allocate_data_block(sbi, NULL, old_blkaddr,
+	err = f2fs_allocate_data_block(sbi, old_blkaddr,
 				&dn->data_blkaddr, &sum, seg_type, NULL);
 	if (err) {
 		if (old_blkaddr == NULL_ADDR)
@@ -1956,7 +1945,7 @@ int f2fs_map_blocks(struct inode *inode, struct f2fs_map_blocks *map, int flag)
 	start_pgofs = pgofs;
 	prealloc = 0;
 	last_ofs_in_node = ofs_in_node = dn.ofs_in_node;
-	end_offset = ADDRS_PER_PAGE(dn.node_folio, inode);
+	end_offset = ADDRS_PER_PAGE(dn.node_entry, inode);
 
 next_block:
 	blkaddr = f2fs_data_blkaddr(&dn);
@@ -2207,15 +2196,15 @@ static int f2fs_xattr_fiemap(struct inode *inode,
 
 	if (f2fs_has_inline_xattr(inode)) {
 		int offset;
-		struct folio *folio = f2fs_grab_cache_folio(NODE_MAPPING(sbi),
-				inode->i_ino, false);
+		struct f2fs_cached_block *entry =
+				f2fs_grab_node_cache(sbi, inode->i_ino);
 
-		if (IS_ERR(folio))
-			return PTR_ERR(folio);
+		if (IS_ERR(entry))
+			return PTR_ERR(entry);
 
 		err = f2fs_get_node_info(sbi, inode->i_ino, &ni, false);
 		if (err) {
-			f2fs_folio_put(folio, true);
+			f2fs_put_cache(entry, true);
 			return err;
 		}
 
@@ -2227,7 +2216,7 @@ static int f2fs_xattr_fiemap(struct inode *inode,
 		phys += offset;
 		len = inline_xattr_size(inode);
 
-		f2fs_folio_put(folio, true);
+		f2fs_put_cache(entry, true);
 
 		flags = FIEMAP_EXTENT_DATA_INLINE | FIEMAP_EXTENT_NOT_ALIGNED;
 
@@ -2241,22 +2230,22 @@ static int f2fs_xattr_fiemap(struct inode *inode,
 	}
 
 	if (xnid) {
-		struct folio *folio = f2fs_grab_cache_folio(NODE_MAPPING(sbi),
-				xnid, false);
+		struct f2fs_cached_block *entry =
+				f2fs_grab_node_cache(sbi, xnid);
 
-		if (IS_ERR(folio))
-			return PTR_ERR(folio);
+		if (IS_ERR(entry))
+			return PTR_ERR(entry);
 
 		err = f2fs_get_node_info(sbi, xnid, &ni, false);
 		if (err) {
-			f2fs_folio_put(folio, true);
+			f2fs_put_cache(entry, true);
 			return err;
 		}
 
 		phys = F2FS_BLK_TO_BYTES(sbi, ni.blk_addr);
 		len = inode->i_sb->s_blocksize;
 
-		f2fs_folio_put(folio, true);
+		f2fs_put_cache(entry, true);
 
 		flags = FIEMAP_EXTENT_LAST;
 	}
@@ -2619,7 +2608,7 @@ int f2fs_read_multi_pages(struct compress_ctx *cc, struct bio **bio_ret,
 	for (i = 1; i < cc->cluster_size; i++) {
 		block_t blkaddr;
 
-		blkaddr = from_dnode ? data_blkaddr(dn.inode, dn.node_folio,
+		blkaddr = from_dnode ? data_blkaddr(dn.inode, dn.node_entry,
 					dn.ofs_in_node + i) :
 					ei.blk + i - 1;
 
@@ -2653,7 +2642,7 @@ int f2fs_read_multi_pages(struct compress_ctx *cc, struct bio **bio_ret,
 		block_t blkaddr;
 		struct bio_post_read_ctx *ctx;
 
-		blkaddr = from_dnode ? data_blkaddr(dn.inode, dn.node_folio,
+		blkaddr = from_dnode ? data_blkaddr(dn.inode, dn.node_entry,
 					dn.ofs_in_node + i + 1) :
 					ei.blk + i;
 
@@ -3646,7 +3635,7 @@ static int f2fs_write_cache_pages(struct address_space *mapping,
 			if (folio_test_writeback(folio)) {
 				if (wbc->sync_mode == WB_SYNC_NONE)
 					goto continue_unlock;
-				f2fs_folio_wait_writeback(folio, DATA, true, true);
+				f2fs_folio_wait_writeback(folio, true, true);
 			}
 
 			if (!folio_clear_dirty_for_io(folio))
@@ -3728,8 +3717,8 @@ static int f2fs_write_cache_pages(struct address_space *mapping,
 		mapping->writeback_index = done_index;
 
 	if (nwritten)
-		f2fs_submit_merged_write_cond(F2FS_M_SB(mapping), mapping->host,
-								NULL, 0, DATA);
+		f2fs_submit_merged_write_cond(F2FS_M_SB(mapping),
+					mapping->host, NULL);
 	/* submit cached bio of IPU write */
 	if (bio)
 		f2fs_submit_merged_ipu_write(sbi, &bio, NULL);
@@ -3907,7 +3896,7 @@ static int prepare_write_begin(struct f2fs_sb_info *sbi,
 	pgoff_t index = folio->index;
 	struct dnode_of_data dn;
 	struct f2fs_lock_context lc;
-	struct folio *ifolio;
+	struct f2fs_cached_block *ientry;
 	bool locked = false;
 	int flag = F2FS_GET_BLOCK_PRE_AIO;
 	int err = 0;
@@ -3938,20 +3927,20 @@ static int prepare_write_begin(struct f2fs_sb_info *sbi,
 
 restart:
 	/* check inline_data */
-	ifolio = f2fs_get_inode_folio(sbi, inode->i_ino);
-	if (IS_ERR(ifolio)) {
-		err = PTR_ERR(ifolio);
+	ientry = f2fs_get_inode_cache(sbi, inode->i_ino);
+	if (IS_ERR(ientry)) {
+		err = PTR_ERR(ientry);
 		goto unlock_out;
 	}
 
-	set_new_dnode(&dn, inode, ifolio, ifolio, 0);
+	set_new_dnode(&dn, inode, ientry, ientry, 0);
 
 	if (f2fs_has_inline_data(inode)) {
 		if (pos + len <= MAX_INLINE_DATA(inode)) {
-			f2fs_do_read_inline_data(folio, ifolio);
+			f2fs_do_read_inline_data(folio, ientry);
 			set_inode_flag(inode, FI_DATA_EXIST);
 			if (inode->i_nlink)
-				folio_set_f2fs_inline(ifolio);
+				f2fs_cache_set_inline(ientry);
 			goto out;
 		}
 		err = f2fs_convert_inline_folio(&dn, folio);
@@ -3998,14 +3987,14 @@ static int __find_data_block(struct inode *inode, pgoff_t index,
 				block_t *blk_addr)
 {
 	struct dnode_of_data dn;
-	struct folio *ifolio;
+	struct f2fs_cached_block *ientry;
 	int err = 0;
 
-	ifolio = f2fs_get_inode_folio(F2FS_I_SB(inode), inode->i_ino);
-	if (IS_ERR(ifolio))
-		return PTR_ERR(ifolio);
+	ientry = f2fs_get_inode_cache(F2FS_I_SB(inode), inode->i_ino);
+	if (IS_ERR(ientry))
+		return PTR_ERR(ientry);
 
-	set_new_dnode(&dn, inode, ifolio, ifolio, 0);
+	set_new_dnode(&dn, inode, ientry, ientry, 0);
 
 	if (!f2fs_lookup_read_extent_cache_block(inode, index,
 						 &dn.data_blkaddr)) {
@@ -4027,17 +4016,17 @@ static int __reserve_data_block(struct inode *inode, pgoff_t index,
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
 	struct dnode_of_data dn;
 	struct f2fs_lock_context lc;
-	struct folio *ifolio;
+	struct f2fs_cached_block *ientry;
 	int err = 0;
 
 	f2fs_map_lock(sbi, &lc, F2FS_GET_BLOCK_PRE_AIO);
 
-	ifolio = f2fs_get_inode_folio(sbi, inode->i_ino);
-	if (IS_ERR(ifolio)) {
-		err = PTR_ERR(ifolio);
+	ientry = f2fs_get_inode_cache(sbi, inode->i_ino);
+	if (IS_ERR(ientry)) {
+		err = PTR_ERR(ientry);
 		goto unlock_out;
 	}
-	set_new_dnode(&dn, inode, ifolio, ifolio, 0);
+	set_new_dnode(&dn, inode, ientry, ientry, 0);
 
 	if (!f2fs_lookup_read_extent_cache_block(dn.inode, index,
 						&dn.data_blkaddr))
@@ -4193,7 +4182,7 @@ static int f2fs_write_begin(const struct kiocb *iocb,
 		}
 	}
 
-	f2fs_folio_wait_writeback(folio, DATA, false, true);
+	f2fs_folio_wait_writeback(folio, false, true);
 
 	if (len == folio_size(folio) || folio_test_uptodate(folio))
 		return 0;
@@ -4310,12 +4299,8 @@ void f2fs_invalidate_folio(struct folio *folio, size_t offset, size_t length)
 		return;
 
 	if (folio_test_dirty(folio)) {
-		if (inode->i_ino == F2FS_NODE_INO(sbi)) {
-			dec_page_count(sbi, F2FS_DIRTY_NODES);
-		} else {
-			inode_dec_dirty_pages(inode);
-			f2fs_remove_dirty_inode(inode);
-		}
+		inode_dec_dirty_pages(inode);
+		f2fs_remove_dirty_inode(inode);
 	}
 
 	if (offset || length != folio_size(folio))
diff --git a/fs/f2fs/debug.c b/fs/f2fs/debug.c
index 24819d4c0d55..c09c5f700c89 100644
--- a/fs/f2fs/debug.c
+++ b/fs/f2fs/debug.c
@@ -222,8 +222,7 @@ static void update_general_status(struct f2fs_sb_info *sbi)
 	si->free_secs = free_sections(sbi);
 	si->prefree_count = prefree_segments(sbi);
 	si->dirty_count = dirty_segments(sbi);
-	if (sbi->node_inode)
-		si->node_pages = NODE_MAPPING(sbi)->nrpages;
+	si->node_caches = NODE_CACHE(sbi)->num_entries;
 	si->meta_caches = META_CACHE(sbi)->num_entries;
 #ifdef CONFIG_F2FS_FS_COMPRESSION
 	if (sbi->compress_inode) {
@@ -382,13 +381,10 @@ static void update_mem_info(struct f2fs_sb_info *sbi)
 	}
 
 	si->page_mem = 0;
-	if (sbi->node_inode) {
-		unsigned long npages = NODE_MAPPING(sbi)->nrpages;
-
-		si->page_mem += (unsigned long long)npages << PAGE_SHIFT;
-	}
 	si->page_mem += (unsigned long long)META_CACHE(sbi)->num_entries << PAGE_SHIFT;
 	si->cache_mem += META_CACHE(sbi)->num_entries * sizeof(struct f2fs_cached_block);
+	si->page_mem += (unsigned long long)NODE_CACHE(sbi)->num_entries << PAGE_SHIFT;
+	si->cache_mem += NODE_CACHE(sbi)->num_entries * sizeof(struct f2fs_cached_block);
 #ifdef CONFIG_F2FS_FS_COMPRESSION
 	if (sbi->compress_inode) {
 		unsigned long npages = COMPRESS_MAPPING(sbi)->nrpages;
@@ -696,7 +692,7 @@ static int stat_show(struct seq_file *s, void *v)
 			   si->aw_cnt, si->max_aw_cnt);
 		seq_printf(s, "  - compress: %4d, hit:%8d\n", si->compress_pages, si->compress_page_hit);
 		seq_printf(s, "  - nodes: %4d in %4d\n",
-			   si->ndirty_node, si->node_pages);
+			   si->ndirty_node, si->node_caches);
 		seq_printf(s, "  - dents: %4d in dirs:%4d (%4d)\n",
 			   si->ndirty_dent, si->ndirty_dirs, si->ndirty_all);
 		seq_printf(s, "  - data: %4d in files:%4d\n",
diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
index 75ff36a13f60..97f7fef6b068 100644
--- a/fs/f2fs/dir.c
+++ b/fs/f2fs/dir.c
@@ -282,7 +282,7 @@ struct f2fs_dir_entry *f2fs_find_target_dentry(const struct f2fs_dentry_ptr *d,
 static struct f2fs_dir_entry *find_in_level(struct inode *dir,
 					unsigned int level,
 					const struct f2fs_filename *fname,
-					struct folio **res_folio,
+					void **dentry_block,
 					bool use_hash)
 {
 	int s = GET_DENTRY_SLOTS(fname->disk_name.len);
@@ -313,7 +313,7 @@ static struct f2fs_dir_entry *find_in_level(struct inode *dir,
 				bidx = next_pgofs;
 				continue;
 			} else {
-				*res_folio = dentry_folio;
+				*dentry_block = dentry_folio;
 				break;
 			}
 		}
@@ -321,11 +321,11 @@ static struct f2fs_dir_entry *find_in_level(struct inode *dir,
 		de = find_in_block(dir, dentry_folio, fname, &max_slots, use_hash);
 		if (IS_ERR(de)) {
 			f2fs_folio_put(dentry_folio, false);
-			*res_folio = ERR_CAST(de);
+			*dentry_block = ERR_CAST(de);
 			de = NULL;
 			break;
 		} else if (de) {
-			*res_folio = dentry_folio;
+			*dentry_block = dentry_folio;
 			break;
 		}
 
@@ -352,7 +352,7 @@ static struct f2fs_dir_entry *find_in_level(struct inode *dir,
 
 struct f2fs_dir_entry *__f2fs_find_entry(struct inode *dir,
 					 const struct f2fs_filename *fname,
-					 struct folio **res_folio)
+					 void **dentry_block)
 {
 	unsigned long npages = dir_blocks(dir);
 	struct f2fs_dir_entry *de = NULL;
@@ -360,13 +360,13 @@ struct f2fs_dir_entry *__f2fs_find_entry(struct inode *dir,
 	unsigned int level;
 	bool use_hash = true;
 
-	*res_folio = NULL;
+	*dentry_block = NULL;
 
 #if IS_ENABLED(CONFIG_UNICODE)
 start_find_entry:
 #endif
 	if (f2fs_has_inline_dentry(dir)) {
-		de = f2fs_find_in_inline_dir(dir, fname, res_folio, use_hash);
+		de = f2fs_find_in_inline_dir(dir, fname, dentry_block, use_hash);
 		goto out;
 	}
 
@@ -382,8 +382,8 @@ struct f2fs_dir_entry *__f2fs_find_entry(struct inode *dir,
 	}
 
 	for (level = 0; level < max_depth; level++) {
-		de = find_in_level(dir, level, fname, res_folio, use_hash);
-		if (de || IS_ERR(*res_folio))
+		de = find_in_level(dir, level, fname, dentry_block, use_hash);
+		if (de || IS_ERR(*dentry_block))
 			break;
 	}
 
@@ -408,7 +408,7 @@ struct f2fs_dir_entry *__f2fs_find_entry(struct inode *dir,
  * Entry is guaranteed to be valid.
  */
 struct f2fs_dir_entry *f2fs_find_entry(struct inode *dir,
-			const struct qstr *child, struct folio **res_folio)
+			const struct qstr *child, void **dentry_block)
 {
 	struct f2fs_dir_entry *de = NULL;
 	struct f2fs_filename fname;
@@ -417,67 +417,78 @@ struct f2fs_dir_entry *f2fs_find_entry(struct inode *dir,
 	err = f2fs_setup_filename(dir, child, 1, &fname);
 	if (err) {
 		if (err == -ENOENT)
-			*res_folio = NULL;
+			*dentry_block = NULL;
 		else
-			*res_folio = ERR_PTR(err);
+			*dentry_block = ERR_PTR(err);
 		return NULL;
 	}
 
-	de = __f2fs_find_entry(dir, &fname, res_folio);
+	de = __f2fs_find_entry(dir, &fname, dentry_block);
 
 	f2fs_free_filename(&fname);
 	return de;
 }
 
-struct f2fs_dir_entry *f2fs_parent_dir(struct inode *dir, struct folio **f)
+struct f2fs_dir_entry *f2fs_parent_dir(struct inode *dir, void **dentry_block)
 {
-	return f2fs_find_entry(dir, &dotdot_name, f);
+	return f2fs_find_entry(dir, &dotdot_name, dentry_block);
 }
 
 ino_t f2fs_inode_by_name(struct inode *dir, const struct qstr *qstr,
-							struct folio **folio)
+							void **dentry_block)
 {
 	ino_t res = 0;
 	struct f2fs_dir_entry *de;
 
-	de = f2fs_find_entry(dir, qstr, folio);
+	de = f2fs_find_entry(dir, qstr, dentry_block);
 	if (de) {
 		res = le32_to_cpu(de->ino);
-		f2fs_folio_put(*folio, false);
+		f2fs_put_dentry_block(*dentry_block, false);
 	}
 
 	return res;
 }
 
 void f2fs_set_link(struct inode *dir, struct f2fs_dir_entry *de,
-		struct folio *folio, struct inode *inode)
+		void *dentry_block, struct inode *inode)
 {
-	enum page_type type = f2fs_has_inline_dentry(dir) ? NODE : DATA;
+	if (f2fs_dentry_is_cache(dentry_block)) {
+		struct f2fs_cached_block *entry =
+				f2fs_dentry_cache(dentry_block);
+
+		f2fs_lock_cache(entry);
+		f2fs_cache_wait_writeback(entry);
+		de->ino = cpu_to_le32(inode->i_ino);
+		de->file_type = fs_umode_to_ftype(inode->i_mode);
+		f2fs_mark_cache_dirty(entry);
+	} else {
+		struct folio *folio = f2fs_dentry_folio(dentry_block);
 
-	folio_lock(folio);
-	f2fs_folio_wait_writeback(folio, type, true, true);
-	de->ino = cpu_to_le32(inode->i_ino);
-	de->file_type = fs_umode_to_ftype(inode->i_mode);
-	folio_mark_dirty(folio);
+		folio_lock(folio);
+		f2fs_folio_wait_writeback(folio, true, true);
+		de->ino = cpu_to_le32(inode->i_ino);
+		de->file_type = fs_umode_to_ftype(inode->i_mode);
+		folio_mark_dirty(folio);
+	}
 
 	inode_set_mtime_to_ts(dir, inode_set_ctime_current(dir));
 	f2fs_mark_inode_dirty_sync(dir, true);
-	f2fs_folio_put(folio, true);
+	f2fs_put_dentry_block(dentry_block, true);
 }
 
 static void init_dent_inode(struct inode *dir, struct inode *inode,
 			    const struct f2fs_filename *fname,
-			    struct folio *ifolio)
+			    struct f2fs_cached_block *ientry)
 {
 	struct f2fs_inode *ri;
 
 	if (!fname) /* tmpfile case? */
 		return;
 
-	f2fs_folio_wait_writeback(ifolio, NODE, true, true);
+	f2fs_cache_wait_writeback(ientry);
 
 	/* copy name info. to this inode folio */
-	ri = F2FS_INODE(ifolio);
+	ri = F2FS_INODE(ientry);
 	ri->i_namelen = cpu_to_le32(fname->disk_name.len);
 	memcpy(ri->i_name, fname->disk_name.name, fname->disk_name.len);
 	if (IS_ENCRYPTED(dir)) {
@@ -498,7 +509,7 @@ static void init_dent_inode(struct inode *dir, struct inode *inode,
 				file_lost_pino(inode);
 		}
 	}
-	folio_mark_dirty(ifolio);
+	f2fs_mark_cache_dirty(ientry);
 }
 
 void f2fs_do_make_empty_dir(struct inode *inode, struct inode *parent,
@@ -515,16 +526,16 @@ void f2fs_do_make_empty_dir(struct inode *inode, struct inode *parent,
 }
 
 static int make_empty_dir(struct inode *inode,
-		struct inode *parent, struct folio *folio)
+		struct inode *parent, struct f2fs_cached_block *ientry)
 {
 	struct folio *dentry_folio;
 	void *dentry_blk;
 	struct f2fs_dentry_ptr d;
 
 	if (f2fs_has_inline_dentry(inode))
-		return f2fs_make_empty_inline_dir(inode, parent, folio);
+		return f2fs_make_empty_inline_dir(inode, parent, ientry);
 
-	dentry_folio = f2fs_get_new_data_folio(inode, folio, 0, true);
+	dentry_folio = f2fs_get_new_data_folio(inode, ientry, 0, true);
 	if (IS_ERR(dentry_folio))
 		return PTR_ERR(dentry_folio);
 
@@ -538,50 +549,50 @@ static int make_empty_dir(struct inode *inode,
 	return 0;
 }
 
-struct folio *f2fs_init_inode_metadata(struct inode *inode, struct inode *dir,
-		const struct f2fs_filename *fname, struct folio *dfolio)
+struct f2fs_cached_block *f2fs_init_inode_metadata(struct inode *inode, struct inode *dir,
+		const struct f2fs_filename *fname, struct f2fs_cached_block *dentry)
 {
-	struct folio *folio;
+	struct f2fs_cached_block *ientry;
 	int err;
 
 	if (is_inode_flag_set(inode, FI_NEW_INODE)) {
-		folio = f2fs_new_inode_folio(inode);
-		if (IS_ERR(folio))
-			return folio;
+		ientry = f2fs_new_inode_cache(inode);
+		if (IS_ERR(ientry))
+			return ientry;
 
 		if (S_ISDIR(inode->i_mode)) {
 			/* in order to handle error case */
-			folio_get(folio);
-			err = make_empty_dir(inode, dir, folio);
+			f2fs_cache_get(ientry);
+			err = make_empty_dir(inode, dir, ientry);
 			if (err) {
-				folio_lock(folio);
+				f2fs_lock_cache(ientry);
 				goto put_error;
 			}
-			folio_put(folio);
+			f2fs_put_cache(ientry, false);
 		}
 
-		err = f2fs_init_acl(inode, dir, folio, dfolio);
+		err = f2fs_init_acl(inode, dir, ientry, dentry);
 		if (err)
 			goto put_error;
 
 		err = f2fs_init_security(inode, dir,
 					 fname ? fname->usr_fname : NULL,
-					 folio);
+					 ientry);
 		if (err)
 			goto put_error;
 
 		if (IS_ENCRYPTED(inode)) {
-			err = fscrypt_set_context(inode, folio);
+			err = fscrypt_set_context(inode, ientry);
 			if (err)
 				goto put_error;
 		}
 	} else {
-		folio = f2fs_get_inode_folio(F2FS_I_SB(dir), inode->i_ino);
-		if (IS_ERR(folio))
-			return folio;
+		ientry = f2fs_get_inode_cache(F2FS_I_SB(dir), inode->i_ino);
+		if (IS_ERR(ientry))
+			return ientry;
 	}
 
-	init_dent_inode(dir, inode, fname, folio);
+	init_dent_inode(dir, inode, fname, ientry);
 
 	/*
 	 * This file should be checkpointed during fsync.
@@ -598,12 +609,12 @@ struct folio *f2fs_init_inode_metadata(struct inode *inode, struct inode *dir,
 			f2fs_remove_orphan_inode(F2FS_I_SB(dir), inode->i_ino);
 		f2fs_i_links_write(inode, true);
 	}
-	return folio;
+	return ientry;
 
 put_error:
 	clear_nlink(inode);
-	f2fs_update_inode(inode, folio);
-	f2fs_folio_put(folio, true);
+	f2fs_update_inode(inode, ientry);
+	f2fs_put_cache(ientry, true);
 	return ERR_PTR(err);
 }
 
@@ -645,14 +656,14 @@ int f2fs_room_for_filename(const void *bitmap, int slots, int max_slots)
 	goto next;
 }
 
-bool f2fs_has_enough_room(struct inode *dir, struct folio *ifolio,
+bool f2fs_has_enough_room(struct inode *dir, struct f2fs_cached_block *ientry,
 			  const struct f2fs_filename *fname)
 {
 	struct f2fs_dentry_ptr d;
 	unsigned int bit_pos;
 	int slots = GET_DENTRY_SLOTS(fname->disk_name.len);
 
-	make_dentry_ptr_inline(dir, &d, inline_data_addr(dir, ifolio));
+	make_dentry_ptr_inline(dir, &d, inline_data_addr(dir, ientry));
 
 	bit_pos = f2fs_room_for_filename(d.bitmap, slots, d.max);
 
@@ -692,7 +703,7 @@ int f2fs_add_regular_entry(struct inode *dir, const struct f2fs_filename *fname,
 	struct folio *dentry_folio = NULL;
 	void *dentry_blk = NULL;
 	struct f2fs_dentry_ptr d;
-	struct folio *folio = NULL;
+	struct f2fs_cached_block *entry = NULL;
 	int slots, err = 0;
 
 	level = 0;
@@ -739,13 +750,13 @@ int f2fs_add_regular_entry(struct inode *dir, const struct f2fs_filename *fname,
 	++level;
 	goto start;
 add_dentry:
-	f2fs_folio_wait_writeback(dentry_folio, DATA, true, true);
+	f2fs_folio_wait_writeback(dentry_folio, true, true);
 
 	if (inode) {
 		f2fs_down_write(&F2FS_I(inode)->i_sem);
-		folio = f2fs_init_inode_metadata(inode, dir, fname, NULL);
-		if (IS_ERR(folio)) {
-			err = PTR_ERR(folio);
+		entry = f2fs_init_inode_metadata(inode, dir, fname, NULL);
+		if (IS_ERR(entry)) {
+			err = PTR_ERR(entry);
 			goto fail;
 		}
 	}
@@ -760,9 +771,9 @@ int f2fs_add_regular_entry(struct inode *dir, const struct f2fs_filename *fname,
 
 		/* synchronize inode page's data from inode cache */
 		if (is_inode_flag_set(inode, FI_NEW_INODE))
-			f2fs_update_inode(inode, folio);
+			f2fs_update_inode(inode, entry);
 
-		f2fs_folio_put(folio, true);
+		f2fs_put_cache(entry, true);
 	}
 
 	f2fs_update_parent_metadata(dir, inode, current_depth);
@@ -804,7 +815,7 @@ int f2fs_do_add_link(struct inode *dir, const struct qstr *name,
 				struct inode *inode, nid_t ino, umode_t mode)
 {
 	struct f2fs_filename fname;
-	struct folio *folio = NULL;
+	void *dentry_blk = NULL;
 	struct f2fs_dir_entry *de = NULL;
 	int err;
 
@@ -820,14 +831,14 @@ int f2fs_do_add_link(struct inode *dir, const struct qstr *name,
 	 * consistency more.
 	 */
 	if (current != F2FS_I(dir)->task) {
-		de = __f2fs_find_entry(dir, &fname, &folio);
+		de = __f2fs_find_entry(dir, &fname, &dentry_blk);
 		F2FS_I(dir)->task = NULL;
 	}
 	if (de) {
-		f2fs_folio_put(folio, false);
+		f2fs_put_dentry_block(dentry_blk, false);
 		err = -EEXIST;
-	} else if (IS_ERR(folio)) {
-		err = PTR_ERR(folio);
+	} else if (IS_ERR(dentry_blk)) {
+		err = PTR_ERR(dentry_blk);
 	} else {
 		err = f2fs_add_dentry(dir, &fname, inode, ino, mode);
 	}
@@ -838,16 +849,16 @@ int f2fs_do_add_link(struct inode *dir, const struct qstr *name,
 int f2fs_do_tmpfile(struct inode *inode, struct inode *dir,
 					struct f2fs_filename *fname)
 {
-	struct folio *folio;
+	struct f2fs_cached_block *ientry;
 	int err = 0;
 
 	f2fs_down_write(&F2FS_I(inode)->i_sem);
-	folio = f2fs_init_inode_metadata(inode, dir, fname, NULL);
-	if (IS_ERR(folio)) {
-		err = PTR_ERR(folio);
+	ientry = f2fs_init_inode_metadata(inode, dir, fname, NULL);
+	if (IS_ERR(ientry)) {
+		err = PTR_ERR(ientry);
 		goto fail;
 	}
-	f2fs_folio_put(folio, true);
+	f2fs_put_cache(ientry, true);
 
 	clear_inode_flag(inode, FI_NEW_INODE);
 	f2fs_update_time(F2FS_I_SB(inode), REQ_TIME);
@@ -883,14 +894,15 @@ void f2fs_drop_nlink(struct inode *dir, struct inode *inode)
  * It only removes the dentry from the dentry page, corresponding name
  * entry in name page does not need to be touched during deletion.
  */
-void f2fs_delete_entry(struct f2fs_dir_entry *dentry, struct folio *folio,
+void f2fs_delete_entry(struct f2fs_dir_entry *dentry, void *dentry_block,
 					struct inode *dir, struct inode *inode)
 {
 	void *dentry_blk;
 	struct f2fs_dentry_ptr d;
+	struct folio *folio;
 	unsigned int bit_pos;
 	int slots = GET_DENTRY_SLOTS(le16_to_cpu(dentry->name_len));
-	pgoff_t index = folio->index;
+	pgoff_t index;
 	int i;
 
 	f2fs_update_time(F2FS_I_SB(dir), REQ_TIME);
@@ -899,10 +911,14 @@ void f2fs_delete_entry(struct f2fs_dir_entry *dentry, struct folio *folio,
 		f2fs_add_ino_entry(F2FS_I_SB(dir), dir->i_ino, TRANS_DIR_INO);
 
 	if (f2fs_has_inline_dentry(dir))
-		return f2fs_delete_inline_entry(dentry, folio, dir, inode);
+		return f2fs_delete_inline_entry(dentry,
+				f2fs_dentry_cache(dentry_block), dir, inode);
+
+	folio = f2fs_dentry_folio(dentry_block);
+	index = folio->index;
 
 	folio_lock(folio);
-	f2fs_folio_wait_writeback(folio, DATA, true, true);
+	f2fs_folio_wait_writeback(folio, true, true);
 
 	dentry_blk = folio_address(folio);
 	make_dentry_ptr_block(dir, &d, dentry_blk);
@@ -1050,7 +1066,7 @@ int f2fs_fill_dentries(struct dir_context *ctx, struct f2fs_dentry_ptr *d,
 		}
 
 		if (readdir_ra)
-			f2fs_ra_node_page(sbi, le32_to_cpu(de->ino));
+			f2fs_ra_node_cache(sbi, le32_to_cpu(de->ino));
 
 		ctx->pos = start_pos + bit_pos;
 		found_valid_dirent = true;
diff --git a/fs/f2fs/extent_cache.c b/fs/f2fs/extent_cache.c
index 40cd87940961..5a944428aca0 100644
--- a/fs/f2fs/extent_cache.c
+++ b/fs/f2fs/extent_cache.c
@@ -20,10 +20,10 @@
 #include "segment.h"
 #include <trace/events/f2fs.h>
 
-bool sanity_check_extent_cache(struct inode *inode, struct folio *ifolio)
+bool sanity_check_extent_cache(struct inode *inode, struct f2fs_cached_block *ientry)
 {
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
-	struct f2fs_extent *i_ext = &F2FS_INODE(ifolio)->i_ext;
+	struct f2fs_extent *i_ext = &F2FS_INODE(ientry)->i_ext;
 	struct extent_info ei;
 	int devi;
 
@@ -416,11 +416,11 @@ static void __drop_largest_extent(struct extent_tree *et,
 	}
 }
 
-void f2fs_init_read_extent_tree(struct inode *inode, struct folio *ifolio)
+void f2fs_init_read_extent_tree(struct inode *inode, struct f2fs_cached_block *ientry)
 {
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
 	struct extent_tree_info *eti = &sbi->extent_tree[EX_READ];
-	struct f2fs_extent *i_ext = &F2FS_INODE(ifolio)->i_ext;
+	struct f2fs_extent *i_ext = &F2FS_INODE(ientry)->i_ext;
 	struct extent_tree *et;
 	struct extent_node *en;
 	struct extent_info ei = {0};
@@ -428,9 +428,9 @@ void f2fs_init_read_extent_tree(struct inode *inode, struct folio *ifolio)
 	if (!__may_extent_tree(inode, EX_READ)) {
 		/* drop largest read extent */
 		if (i_ext->len) {
-			f2fs_folio_wait_writeback(ifolio, NODE, true, true);
+			f2fs_cache_wait_writeback(ientry);
 			i_ext->len = 0;
-			folio_mark_dirty(ifolio);
+			f2fs_mark_cache_dirty(ientry);
 		}
 		set_inode_flag(inode, FI_NO_EXTENT);
 		return;
@@ -958,7 +958,7 @@ static void __update_extent_cache(struct dnode_of_data *dn, enum extent_type typ
 		return;
 
 	ei.fofs = f2fs_start_bidx_of_node(ofs_of_node(F2FS_I_SB(dn->inode),
-				dn->node_folio), dn->inode) + dn->ofs_in_node;
+				dn->node_entry), dn->inode) + dn->ofs_in_node;
 	ei.len = 1;
 
 	if (type == EX_READ) {
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 51c191c514bc..d6681276708e 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -418,7 +418,7 @@ struct inode_entry {
 
 struct fsync_node_entry {
 	struct list_head list;	/* list head */
-	struct folio *folio;	/* warm node folio pointer */
+	struct f2fs_cached_block *entry; /* warm node cache entry pointer */
 	unsigned int seq_id;	/* sequence id */
 };
 
@@ -1116,11 +1116,11 @@ struct f2fs_nm_info {
  */
 struct dnode_of_data {
 	struct inode *inode;		/* vfs inode pointer */
-	struct folio *inode_folio;	/* its inode folio, NULL is possible */
-	struct folio *node_folio;	/* cached direct node folio */
+	struct f2fs_cached_block *inode_entry; /* generic cache inode entry */
+	struct f2fs_cached_block *node_entry;  /* generic cache node entry */
 	nid_t nid;			/* node id of the direct node block */
 	unsigned int ofs_in_node;	/* data offset in the node page */
-	bool inode_folio_locked;	/* inode folio is locked or not */
+	bool inode_entry_locked;	/* inode entry is locked or not */
 	bool node_changed;		/* is node block changed */
 	char cur_level;			/* level of hole node page */
 	char max_level;			/* level of current page located */
@@ -1128,12 +1128,12 @@ struct dnode_of_data {
 };
 
 static inline void set_new_dnode(struct dnode_of_data *dn, struct inode *inode,
-		struct folio *ifolio, struct folio *nfolio, nid_t nid)
+		struct f2fs_cached_block *ientry, struct f2fs_cached_block *nentry, nid_t nid)
 {
 	memset(dn, 0, sizeof(*dn));
 	dn->inode = inode;
-	dn->inode_folio = ifolio;
-	dn->node_folio = nfolio;
+	dn->inode_entry = ientry;
+	dn->node_entry = nentry;
 	dn->nid = nid;
 }
 
@@ -1614,10 +1614,9 @@ static inline void f2fs_clear_bit(unsigned int nr, char *addr);
  * | bit0 = 1 | bit1 | bit2 | ... | bit MAX | private data .... |
  * bit 0	PAGE_PRIVATE_NOT_POINTER
  * bit 1	PAGE_PRIVATE_ONGOING_MIGRATION
- * bit 2	PAGE_PRIVATE_INLINE_INODE
- * bit 3	PAGE_PRIVATE_REF_RESOURCE
- * bit 4	PAGE_PRIVATE_ATOMIC_WRITE
- * bit 5-	f2fs private data
+ * bit 2	PAGE_PRIVATE_REF_RESOURCE
+ * bit 3	PAGE_PRIVATE_ATOMIC_WRITE
+ * bit 4-	f2fs private data
  *
  * Layout B: lowest bit should be 0
  * page.private is a wrapped pointer.
@@ -1625,7 +1624,6 @@ static inline void f2fs_clear_bit(unsigned int nr, char *addr);
 enum {
 	PAGE_PRIVATE_NOT_POINTER,		/* private contains non-pointer data */
 	PAGE_PRIVATE_ONGOING_MIGRATION,		/* data page which is on-going migrating */
-	PAGE_PRIVATE_INLINE_INODE,		/* inode page contains inline data */
 	PAGE_PRIVATE_REF_RESOURCE,		/* dirty page has referenced resources */
 	PAGE_PRIVATE_ATOMIC_WRITE,		/* data page from atomic write path */
 	PAGE_PRIVATE_MAX
@@ -1802,7 +1800,6 @@ struct f2fs_sb_info {
 
 	/* for node-related operations */
 	struct f2fs_nm_info *nm_info;		/* node manager */
-	struct inode *node_inode;		/* cache node blocks */
 
 	/* for segment-related operations */
 	struct f2fs_sm_info *sm_info;		/* segment manager */
@@ -2327,28 +2324,29 @@ static inline struct f2fs_checkpoint *F2FS_CKPT(struct f2fs_sb_info *sbi)
 }
 
 static inline struct node_footer *F2FS_NODE_FOOTER(struct f2fs_sb_info *sbi,
-						const struct folio *folio)
+						const struct f2fs_cached_block *entry)
 {
-	return folio_address(folio) + F2FS_BLKSIZE(sbi) -
-		sizeof(struct node_footer);
+	return (struct node_footer *)(cache_address(entry) +
+		F2FS_BLKSIZE(sbi) - sizeof(struct node_footer));
 }
 
-static inline struct f2fs_node *F2FS_NODE(const struct folio *folio)
+static inline struct f2fs_node *F2FS_NODE(const struct f2fs_cached_block *entry)
 {
-	return (struct f2fs_node *)folio_address(folio);
+	return (struct f2fs_node *)CACHED_NODE(entry);
 }
 
-static inline struct f2fs_inode *F2FS_INODE(const struct folio *folio)
+static inline struct f2fs_inode *F2FS_INODE(const struct f2fs_cached_block *entry)
 {
-	return &((struct f2fs_node *)folio_address(folio))->i;
+	return &CACHED_NODE(entry)->i;
 }
 
 static inline __le32 *F2FS_INODE_NIDS(struct f2fs_sb_info *sbi,
-						const struct folio *folio)
+						const struct f2fs_cached_block *entry)
 {
-	return folio_address(folio) + F2FS_BLKSIZE(sbi) -
+	return (__le32 *)(cache_address(entry) +
+		F2FS_BLKSIZE(sbi) -
 		sizeof(struct node_footer) -
-		SIZE_OF_I_NID;
+		SIZE_OF_I_NID);
 }
 
 static inline struct f2fs_nm_info *NM_I(struct f2fs_sb_info *sbi)
@@ -2381,14 +2379,9 @@ static inline bool f2fs_is_meta_cache(struct f2fs_cached_block *entry)
 	return entry->cache && entry->cache == META_CACHE(entry->cache->sbi);
 }
 
-static inline struct address_space *NODE_MAPPING(struct f2fs_sb_info *sbi)
+static inline bool f2fs_is_node_cache(struct f2fs_cached_block *entry)
 {
-	return sbi->node_inode->i_mapping;
-}
-
-static inline bool is_node_folio(struct f2fs_sb_info *sbi, struct folio *folio)
-{
-	return folio->mapping == NODE_MAPPING(sbi);
+	return entry->cache && entry->cache == NODE_CACHE(entry->cache->sbi);
 }
 
 static inline struct f2fs_bio *F2FS_BIO(struct bio *bio)
@@ -2812,17 +2805,14 @@ static inline void clear_page_private_##name(struct page *page) \
 }
 
 PAGE_PRIVATE_GET_FUNC(nonpointer, NOT_POINTER);
-PAGE_PRIVATE_GET_FUNC(inline, INLINE_INODE);
 PAGE_PRIVATE_GET_FUNC(gcing, ONGOING_MIGRATION);
 PAGE_PRIVATE_GET_FUNC(atomic, ATOMIC_WRITE);
 
 PAGE_PRIVATE_SET_FUNC(reference, REF_RESOURCE);
-PAGE_PRIVATE_SET_FUNC(inline, INLINE_INODE);
 PAGE_PRIVATE_SET_FUNC(gcing, ONGOING_MIGRATION);
 PAGE_PRIVATE_SET_FUNC(atomic, ATOMIC_WRITE);
 
 PAGE_PRIVATE_CLEAR_FUNC(reference, REF_RESOURCE);
-PAGE_PRIVATE_CLEAR_FUNC(inline, INLINE_INODE);
 PAGE_PRIVATE_CLEAR_FUNC(gcing, ONGOING_MIGRATION);
 PAGE_PRIVATE_CLEAR_FUNC(atomic, ATOMIC_WRITE);
 
@@ -3231,14 +3221,51 @@ static inline void f2fs_put_page(struct page *page, bool unlock)
 	f2fs_folio_put(page_folio(page), unlock);
 }
 
+#define F2FS_DENTRY_TAG_CACHE	1UL
+#define F2FS_DENTRY_TAG_MASK	1UL
+
+static inline void *f2fs_cache_make_dentry_block(struct f2fs_cached_block *entry)
+{
+	if (IS_ERR_OR_NULL(entry))
+		return entry;
+	return (void *)((unsigned long)entry | F2FS_DENTRY_TAG_CACHE);
+}
+
+static inline bool f2fs_dentry_is_cache(void *dentry_block)
+{
+	return ((unsigned long)dentry_block & F2FS_DENTRY_TAG_MASK) ==
+						F2FS_DENTRY_TAG_CACHE;
+}
+
+static inline struct f2fs_cached_block *f2fs_dentry_cache(void *dentry_block)
+{
+	return (struct f2fs_cached_block *)
+		((unsigned long)dentry_block & ~F2FS_DENTRY_TAG_MASK);
+}
+
+static inline struct folio *f2fs_dentry_folio(void *dentry_block)
+{
+	return (struct folio *)dentry_block;
+}
+
+static inline void f2fs_put_dentry_block(void *dentry_block, bool unlock)
+{
+	if (IS_ERR_OR_NULL(dentry_block))
+		return;
+	if (f2fs_dentry_is_cache(dentry_block))
+		f2fs_put_cache(f2fs_dentry_cache(dentry_block), unlock);
+	else
+		f2fs_folio_put(f2fs_dentry_folio(dentry_block), unlock);
+}
+
 static inline void f2fs_put_dnode(struct dnode_of_data *dn)
 {
-	if (dn->node_folio)
-		f2fs_folio_put(dn->node_folio, true);
-	if (dn->inode_folio && dn->node_folio != dn->inode_folio)
-		f2fs_folio_put(dn->inode_folio, false);
-	dn->node_folio = NULL;
-	dn->inode_folio = NULL;
+	if (dn->node_entry)
+		f2fs_put_cache(dn->node_entry, true);
+	if (dn->inode_entry && dn->node_entry != dn->inode_entry)
+		f2fs_put_cache(dn->inode_entry, false);
+	dn->node_entry = NULL;
+	dn->inode_entry = NULL;
 }
 
 static inline struct kmem_cache *f2fs_kmem_cache_create(const char *name,
@@ -3327,9 +3354,9 @@ static inline void f2fs_radix_tree_insert(struct radix_tree_root *root,
 		cond_resched();
 }
 
-static inline bool IS_INODE(struct f2fs_sb_info *sbi, const struct folio *folio)
+static inline bool IS_INODE(struct f2fs_sb_info *sbi, const struct f2fs_cached_block *entry)
 {
-	struct node_footer *footer = F2FS_NODE_FOOTER(sbi, folio);
+	struct node_footer *footer = F2FS_NODE_FOOTER(sbi, entry);
 
 	return footer->nid == footer->ino;
 }
@@ -3341,46 +3368,44 @@ static inline int offset_in_addr(struct f2fs_inode *i)
 }
 
 static inline __le32 *blkaddr_in_node(struct f2fs_sb_info *sbi,
-						const struct folio *folio)
+						const struct f2fs_cached_block *entry)
 {
-	struct f2fs_node *node = F2FS_NODE(folio);
+	struct f2fs_node *node = F2FS_NODE(entry);
 
-	return IS_INODE(sbi, folio) ? node->i.i_addr : node->dn.addr;
+	return IS_INODE(sbi, entry) ? node->i.i_addr : node->dn.addr;
 }
 
 static inline int f2fs_has_extra_attr(struct inode *inode);
+
 static inline unsigned int get_dnode_base(struct inode *inode,
-					struct folio *node_folio)
+					const struct f2fs_cached_block *entry)
 {
-	struct f2fs_sb_info *sbi = inode ? F2FS_I_SB(inode) :
-					F2FS_F_SB(node_folio);
-
-	if (!IS_INODE(sbi, node_folio))
+	if (!IS_INODE(inode ? F2FS_I_SB(inode) : entry->cache->sbi, entry))
 		return 0;
 
 	return inode ? get_extra_isize(inode) :
-			offset_in_addr(&F2FS_NODE(node_folio)->i);
+			offset_in_addr(&CACHED_NODE(entry)->i);
 }
 
 static inline __le32 *get_dnode_addr(struct inode *inode,
-					struct folio *node_folio)
+					const struct f2fs_cached_block *entry)
 {
-	struct f2fs_sb_info *sbi = inode ? F2FS_I_SB(inode) :
-					F2FS_F_SB(node_folio);
+	struct f2fs_sb_info *sbi = inode ? F2FS_I_SB(inode) : entry->cache->sbi;
 
-	return blkaddr_in_node(sbi, node_folio) +
-			get_dnode_base(inode, node_folio);
+	return blkaddr_in_node(sbi, entry) +
+			get_dnode_base(inode, entry);
 }
 
 static inline block_t data_blkaddr(struct inode *inode,
-			struct folio *node_folio, unsigned int offset)
+			const struct f2fs_cached_block *entry,
+			unsigned int offset)
 {
-	return le32_to_cpu(*(get_dnode_addr(inode, node_folio) + offset));
+	return le32_to_cpu(*(get_dnode_addr(inode, entry) + offset));
 }
 
 static inline block_t f2fs_data_blkaddr(struct dnode_of_data *dn)
 {
-	return data_blkaddr(dn->inode, dn->node_folio, dn->ofs_in_node);
+	return data_blkaddr(dn->inode, dn->node_entry, dn->ofs_in_node);
 }
 
 static inline int f2fs_test_bit(unsigned int nr, char *addr)
@@ -3697,10 +3722,10 @@ static inline unsigned int cur_addrs_per_inode(struct inode *inode)
 	return DEF_ADDRS_PER_INODE(F2FS_I_SB(inode)) - get_extra_isize(inode);
 }
 
-static inline
-void *inline_xattr_addr(struct inode *inode, const struct folio *folio)
+static inline void *inline_xattr_addr(struct inode *inode,
+				const struct f2fs_cached_block *entry)
 {
-	struct f2fs_inode *ri = F2FS_INODE(folio);
+	struct f2fs_inode *ri = F2FS_INODE(entry);
 
 	return (void *)&(ri->i_addr[DEF_ADDRS_PER_INODE(F2FS_I_SB(inode)) -
 					get_inline_xattr_addrs(inode)]);
@@ -3747,9 +3772,10 @@ static inline bool f2fs_is_cow_file(struct inode *inode)
 	return is_inode_flag_set(inode, FI_COW_FILE);
 }
 
-static inline void *inline_data_addr(struct inode *inode, struct folio *folio)
+static inline void *inline_data_addr(struct inode *inode,
+			const struct f2fs_cached_block *entry)
 {
-	__le32 *addr = get_dnode_addr(inode, folio);
+	__le32 *addr = get_dnode_addr(inode, entry);
 
 	return (void *)(addr + DEF_INLINE_RESERVED_SIZE);
 }
@@ -3959,13 +3985,13 @@ int f2fs_pin_file_control(struct inode *inode, bool inc);
  * inode.c
  */
 void f2fs_set_inode_flags(struct inode *inode);
-bool f2fs_inode_chksum_verify(struct f2fs_sb_info *sbi, struct folio *folio);
-void f2fs_inode_chksum_set(struct f2fs_sb_info *sbi, struct folio *folio);
+bool f2fs_inode_chksum_verify(struct f2fs_sb_info *sbi, struct f2fs_cached_block *entry);
+void f2fs_inode_chksum_set(struct f2fs_sb_info *sbi, struct f2fs_cached_block *entry);
 struct inode *f2fs_iget(struct super_block *sb, unsigned long ino);
 struct inode *f2fs_iget_retry(struct super_block *sb, unsigned long ino);
 int f2fs_try_to_free_nats(struct f2fs_sb_info *sbi, int nr_shrink);
-void f2fs_update_inode(struct inode *inode, struct folio *node_folio);
-void f2fs_update_inode_page(struct inode *inode);
+void f2fs_update_inode(struct inode *inode, struct f2fs_cached_block *entry);
+void f2fs_update_inode_cache(struct inode *inode);
 int f2fs_write_inode(struct inode *inode, struct writeback_control *wbc);
 void f2fs_remove_donate_inode(struct inode *inode);
 void f2fs_evict_inode(struct inode *inode);
@@ -4014,22 +4040,22 @@ int f2fs_fill_dentries(struct dir_context *ctx, struct f2fs_dentry_ptr *d,
 			unsigned int start_pos, struct fscrypt_str *fstr);
 void f2fs_do_make_empty_dir(struct inode *inode, struct inode *parent,
 			struct f2fs_dentry_ptr *d);
-struct folio *f2fs_init_inode_metadata(struct inode *inode, struct inode *dir,
-		const struct f2fs_filename *fname, struct folio *dfolio);
+struct f2fs_cached_block *f2fs_init_inode_metadata(struct inode *inode, struct inode *dir,
+		const struct f2fs_filename *fname, struct f2fs_cached_block *dentry);
 void f2fs_update_parent_metadata(struct inode *dir, struct inode *inode,
 			unsigned int current_depth);
 int f2fs_room_for_filename(const void *bitmap, int slots, int max_slots);
 void f2fs_drop_nlink(struct inode *dir, struct inode *inode);
 struct f2fs_dir_entry *__f2fs_find_entry(struct inode *dir,
-		const struct f2fs_filename *fname, struct folio **res_folio);
+		const struct f2fs_filename *fname, void **dentry_block);
 struct f2fs_dir_entry *f2fs_find_entry(struct inode *dir,
-			const struct qstr *child, struct folio **res_folio);
-struct f2fs_dir_entry *f2fs_parent_dir(struct inode *dir, struct folio **f);
+			const struct qstr *child, void **dentry_block);
+struct f2fs_dir_entry *f2fs_parent_dir(struct inode *dir, void **dentry_block);
 ino_t f2fs_inode_by_name(struct inode *dir, const struct qstr *qstr,
-			struct folio **folio);
+			void **dentry_block);
 void f2fs_set_link(struct inode *dir, struct f2fs_dir_entry *de,
-			struct folio *folio, struct inode *inode);
-bool f2fs_has_enough_room(struct inode *dir, struct folio *ifolio,
+			void *dentry_blk, struct inode *inode);
+bool f2fs_has_enough_room(struct inode *dir, struct f2fs_cached_block *ientry,
 			  const struct f2fs_filename *fname);
 void f2fs_update_dentry(nid_t ino, umode_t mode, struct f2fs_dentry_ptr *d,
 			const struct fscrypt_str *name, f2fs_hash_t name_hash,
@@ -4040,7 +4066,7 @@ int f2fs_add_dentry(struct inode *dir, const struct f2fs_filename *fname,
 			struct inode *inode, nid_t ino, umode_t mode);
 int f2fs_do_add_link(struct inode *dir, const struct qstr *name,
 			struct inode *inode, nid_t ino, umode_t mode);
-void f2fs_delete_entry(struct f2fs_dir_entry *dentry, struct folio *folio,
+void f2fs_delete_entry(struct f2fs_dir_entry *dentry, void *dentry_blk,
 			struct inode *dir, struct inode *inode);
 int f2fs_do_tmpfile(struct inode *inode, struct inode *dir,
 					struct f2fs_filename *fname);
@@ -4083,9 +4109,9 @@ enum node_type;
 
 int f2fs_check_nid_range(struct f2fs_sb_info *sbi, nid_t nid);
 bool f2fs_available_free_memory(struct f2fs_sb_info *sbi, int type);
-bool f2fs_in_warm_node_list(struct f2fs_sb_info *sbi, struct folio *folio);
+bool f2fs_in_warm_node_list(struct f2fs_sb_info *sbi, struct f2fs_cached_block *entry);
 void f2fs_init_fsync_node_info(struct f2fs_sb_info *sbi);
-void f2fs_del_fsync_node_entry(struct f2fs_sb_info *sbi, struct folio *folio);
+void f2fs_del_fsync_node_entry(struct f2fs_sb_info *sbi, struct f2fs_cached_block *entry);
 void f2fs_reset_fsync_node_info(struct f2fs_sb_info *sbi);
 bool f2fs_need_dentry_mark(struct f2fs_sb_info *sbi, nid_t nid);
 bool f2fs_is_checkpointed_node(struct f2fs_sb_info *sbi, nid_t nid);
@@ -4096,29 +4122,28 @@ pgoff_t f2fs_get_next_page_offset(struct dnode_of_data *dn, pgoff_t pgofs);
 int f2fs_get_dnode_of_data(struct dnode_of_data *dn, pgoff_t index, int mode);
 int f2fs_truncate_inode_blocks(struct inode *inode, pgoff_t from);
 int f2fs_truncate_xattr_node(struct inode *inode);
-int f2fs_wait_on_node_pages_writeback(struct f2fs_sb_info *sbi,
+int f2fs_wait_on_node_caches_writeback(struct f2fs_sb_info *sbi,
 					unsigned int seq_id);
-int f2fs_remove_inode_page(struct inode *inode);
-struct folio *f2fs_new_inode_folio(struct inode *inode);
-struct folio *f2fs_new_node_folio(struct dnode_of_data *dn, unsigned int ofs);
-void f2fs_ra_node_page(struct f2fs_sb_info *sbi, nid_t nid);
-struct folio *f2fs_get_node_folio(struct f2fs_sb_info *sbi, pgoff_t nid,
+int f2fs_write_node_caches(struct f2fs_sb_info *sbi);
+int f2fs_remove_inode_cache(struct inode *inode);
+struct f2fs_cached_block *f2fs_new_inode_cache(struct inode *inode);
+struct f2fs_cached_block *f2fs_new_node_cache(struct dnode_of_data *dn, unsigned int ofs);
+void f2fs_ra_node_cache(struct f2fs_sb_info *sbi, nid_t nid);
+struct f2fs_cached_block *f2fs_get_node_cache(struct f2fs_sb_info *sbi, pgoff_t nid,
 						enum node_type node_type);
 int f2fs_sanity_check_node_footer(struct f2fs_sb_info *sbi,
-					struct folio *folio, pgoff_t nid,
+					struct f2fs_cached_block *entry, pgoff_t nid,
 					enum node_type ntype, bool in_irq);
-struct folio *f2fs_get_inode_folio(struct f2fs_sb_info *sbi, pgoff_t ino);
-struct folio *f2fs_get_xnode_folio(struct f2fs_sb_info *sbi, pgoff_t xnid);
-int f2fs_write_single_node_folio(struct folio *node_folio, int sync_mode,
+struct f2fs_cached_block *f2fs_get_inode_cache(struct f2fs_sb_info *sbi, pgoff_t ino);
+struct f2fs_cached_block *f2fs_get_xnode_cache(struct f2fs_sb_info *sbi, pgoff_t xnid);
+int f2fs_write_node_cache(struct f2fs_cached_block *entry, int sync_mode,
 			bool mark_dirty, enum iostat_type io_type);
-int f2fs_move_node_folio(struct folio *node_folio, int gc_type);
+int f2fs_move_node_cache(struct f2fs_cached_block *entry, int gc_type);
 void f2fs_flush_inline_data(struct f2fs_sb_info *sbi);
-int f2fs_fsync_node_pages(struct f2fs_sb_info *sbi, struct inode *inode,
-			struct writeback_control *wbc, bool atomic,
-			unsigned int *seq_id);
-int f2fs_sync_node_pages(struct f2fs_sb_info *sbi,
-			struct writeback_control *wbc,
-			bool do_balance, enum iostat_type io_type);
+int f2fs_fsync_node_caches(struct f2fs_sb_info *sbi, struct inode *inode,
+					bool atomic, unsigned int *seq_id);
+int f2fs_writeback_node_caches(struct f2fs_sb_info *sbi, long nr_to_write,
+			bool sync, bool do_balance, enum iostat_type io_type);
 int f2fs_build_free_nids(struct f2fs_sb_info *sbi, bool sync, bool mount);
 bool f2fs_alloc_nid(struct f2fs_sb_info *sbi, nid_t *nid);
 void f2fs_alloc_nid_done(struct f2fs_sb_info *sbi, nid_t nid);
@@ -4126,7 +4151,8 @@ void f2fs_alloc_nid_failed(struct f2fs_sb_info *sbi, nid_t nid);
 int f2fs_try_to_free_nids(struct f2fs_sb_info *sbi, int nr_shrink);
 int f2fs_recover_inline_xattr(struct inode *inode, struct f2fs_cached_block *entry);
 int f2fs_recover_xattr_data(struct inode *inode, struct f2fs_cached_block *entry);
-int f2fs_recover_inode_page(struct f2fs_sb_info *sbi, struct f2fs_cached_block *entry);
+int f2fs_recover_inode_cache(struct f2fs_sb_info *sbi,
+			struct f2fs_cached_block *entry);
 int f2fs_restore_node_summary(struct f2fs_sb_info *sbi,
 			unsigned int segno, struct f2fs_summary_block *sum);
 int f2fs_flush_nat_entries(struct f2fs_sb_info *sbi, struct cp_control *cpc);
@@ -4185,7 +4211,7 @@ void f2fs_update_meta_block(struct f2fs_sb_info *sbi, void *src,
 void f2fs_do_write_meta_cache(struct f2fs_sb_info *sbi,
 			struct f2fs_cached_block *entry,
 			enum iostat_type io_type);
-void f2fs_do_write_node_page(unsigned int nid, struct f2fs_io_info *fio);
+void f2fs_do_write_node_cache(unsigned int nid, struct f2fs_io_info *fio);
 void f2fs_outplace_write_data(struct dnode_of_data *dn,
 			struct f2fs_io_info *fio);
 int f2fs_inplace_write_data(struct f2fs_io_info *fio);
@@ -4199,14 +4225,13 @@ void f2fs_replace_block(struct f2fs_sb_info *sbi, struct dnode_of_data *dn,
 			bool recover_newaddr);
 enum temp_type f2fs_get_segment_temp(struct f2fs_sb_info *sbi,
 						enum log_type seg_type);
-int f2fs_allocate_data_block(struct f2fs_sb_info *sbi, struct folio *folio,
+int f2fs_allocate_data_block(struct f2fs_sb_info *sbi,
 			block_t old_blkaddr, block_t *new_blkaddr,
 			struct f2fs_summary *sum, int type,
 			struct f2fs_io_info *fio);
 void f2fs_update_device_state(struct f2fs_sb_info *sbi, nid_t ino,
 					block_t blkaddr, unsigned int blkcnt);
-void f2fs_folio_wait_writeback(struct folio *folio, enum page_type type,
-		bool ordered, bool locked);
+void f2fs_folio_wait_writeback(struct folio *folio, bool ordered, bool locked);
 void f2fs_wait_on_block_writeback(struct inode *inode, block_t blkaddr);
 void f2fs_wait_on_block_writeback_range(struct inode *inode, block_t blkaddr,
 								block_t len);
@@ -4327,14 +4352,14 @@ void f2fs_destroy_bio_entry_cache(void);
 void f2fs_submit_read_bio(struct f2fs_sb_info *sbi, struct bio *bio,
 			  enum page_type type);
 int f2fs_init_write_merge_io(struct f2fs_sb_info *sbi);
-void f2fs_submit_merged_write(struct f2fs_sb_info *sbi, enum page_type type);
 void f2fs_submit_merged_write_cond(struct f2fs_sb_info *sbi,
-				struct inode *inode, struct folio *folio,
-				nid_t ino, enum page_type type);
+				struct inode *inode, struct folio *folio);
 void f2fs_submit_merged_write_folio(struct f2fs_sb_info *sbi,
-				struct folio *folio, enum page_type type);
-bool f2fs_submit_merged_write_cache(struct f2fs_cached_block *entry,
-				enum page_type type);
+				struct folio *folio);
+bool f2fs_submit_merged_write_cache(struct f2fs_sb_info *sbi,
+				struct f2fs_cached_block *entry,
+				nid_t ino, enum page_type type);
+void f2fs_submit_merged_write(struct f2fs_sb_info *sbi, enum page_type type);
 void f2fs_submit_merged_ipu_write(struct f2fs_sb_info *sbi,
 					struct bio **bio, struct folio *folio);
 void f2fs_submit_all_merged_ipu_writes(struct f2fs_sb_info *sbi);
@@ -4360,7 +4385,7 @@ struct folio *f2fs_find_data_folio(struct inode *inode, pgoff_t index,
 struct folio *f2fs_get_lock_data_folio(struct inode *inode, pgoff_t index,
 			bool for_write);
 struct folio *f2fs_get_new_data_folio(struct inode *inode,
-			struct folio *ifolio, pgoff_t index, bool new_i_size);
+			struct f2fs_cached_block *ientry, pgoff_t index, bool new_i_size);
 int f2fs_do_write_data_page(struct f2fs_io_info *fio);
 int f2fs_map_blocks(struct inode *inode, struct f2fs_map_blocks *map, int flag);
 int f2fs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
@@ -4472,7 +4497,7 @@ struct f2fs_stat_info {
 	unsigned int bimodal, avg_vblocks;
 	int util_free, util_valid, util_invalid;
 	int rsvd_segs, overp_segs;
-	int dirty_count, node_pages, meta_caches, compress_pages;
+	int dirty_count, node_caches, meta_caches, compress_pages;
 	int compress_page_hit;
 	int prefree_count, free_segs, free_secs;
 	int cp_call_count[MAX_CALL_TYPE], cp_count;
@@ -4673,7 +4698,6 @@ extern const struct file_operations f2fs_dir_operations;
 extern const struct file_operations f2fs_file_operations;
 extern const struct inode_operations f2fs_file_inode_operations;
 extern const struct address_space_operations f2fs_dblock_aops;
-extern const struct address_space_operations f2fs_node_aops;
 extern const struct inode_operations f2fs_dir_inode_operations;
 extern const struct inode_operations f2fs_symlink_inode_operations;
 extern const struct inode_operations f2fs_encrypted_symlink_inode_operations;
@@ -4684,10 +4708,10 @@ extern struct kmem_cache *f2fs_inode_entry_slab;
  * inline.c
  */
 bool f2fs_may_inline_data(struct inode *inode);
-bool f2fs_sanity_check_inline_data(struct inode *inode, struct folio *ifolio);
+bool f2fs_sanity_check_inline_data(struct inode *inode, struct f2fs_cached_block *ientry);
 bool f2fs_may_inline_dentry(struct inode *inode);
-void f2fs_do_read_inline_data(struct folio *folio, struct folio *ifolio);
-void f2fs_truncate_inline_inode(struct inode *inode, struct folio *ifolio,
+void f2fs_do_read_inline_data(struct folio *folio, struct f2fs_cached_block *ientry);
+void f2fs_truncate_inline_inode(struct inode *inode, struct f2fs_cached_block *ientry,
 		u64 from);
 int f2fs_read_inline_data(struct inode *inode, struct folio *folio);
 int f2fs_convert_inline_folio(struct dnode_of_data *dn, struct folio *folio);
@@ -4696,14 +4720,15 @@ int f2fs_try_convert_inline_dir(struct inode *dir, struct dentry *dentry);
 int f2fs_write_inline_data(struct inode *inode, struct folio *folio);
 int f2fs_recover_inline_data(struct inode *inode, struct f2fs_cached_block *entry);
 struct f2fs_dir_entry *f2fs_find_in_inline_dir(struct inode *dir,
-		const struct f2fs_filename *fname, struct folio **res_folio,
+		const struct f2fs_filename *fname, void **dentry_block,
 		bool use_hash);
 int f2fs_make_empty_inline_dir(struct inode *inode, struct inode *parent,
-			struct folio *ifolio);
+			struct f2fs_cached_block *ientry);
 int f2fs_add_inline_entry(struct inode *dir, const struct f2fs_filename *fname,
 			struct inode *inode, nid_t ino, umode_t mode);
 void f2fs_delete_inline_entry(struct f2fs_dir_entry *dentry,
-		struct folio *folio, struct inode *dir, struct inode *inode);
+		struct f2fs_cached_block *ientry, struct inode *dir,
+		struct inode *inode);
 bool f2fs_empty_inline_dir(struct inode *dir);
 int f2fs_read_inline_dir(struct file *file, struct dir_context *ctx,
 			struct fscrypt_str *fstr);
@@ -4726,7 +4751,7 @@ void f2fs_leave_shrinker(struct f2fs_sb_info *sbi);
 /*
  * extent_cache.c
  */
-bool sanity_check_extent_cache(struct inode *inode, struct folio *ifolio);
+bool sanity_check_extent_cache(struct inode *inode, struct f2fs_cached_block *ientry);
 void f2fs_init_extent_tree(struct inode *inode);
 void f2fs_drop_extent_tree(struct inode *inode);
 void f2fs_destroy_extent_node(struct inode *inode);
@@ -4736,7 +4761,7 @@ int __init f2fs_create_extent_cache(void);
 void f2fs_destroy_extent_cache(void);
 
 /* read extent cache ops */
-void f2fs_init_read_extent_tree(struct inode *inode, struct folio *ifolio);
+void f2fs_init_read_extent_tree(struct inode *inode, struct f2fs_cached_block *ientry);
 bool f2fs_lookup_read_extent_cache(struct inode *inode, pgoff_t pgofs,
 			struct extent_info *ei);
 bool f2fs_lookup_read_extent_cache_block(struct inode *inode, pgoff_t index,
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 7c2bfa0e63d2..6f4287fe180d 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -213,7 +213,7 @@ static vm_fault_t f2fs_vm_page_mkwrite(struct vm_fault *vmf)
 		goto out_sem;
 	}
 
-	f2fs_folio_wait_writeback(folio, DATA, false, true);
+	f2fs_folio_wait_writeback(folio, false, true);
 
 	/* wait for GCed page writeback via generic cache */
 	f2fs_wait_on_block_writeback(inode, dn.data_blkaddr);
@@ -308,13 +308,13 @@ static inline enum cp_reason_type need_do_checkpoint(struct inode *inode)
 
 static bool need_inode_page_update(struct f2fs_sb_info *sbi, nid_t ino)
 {
-	struct folio *i = filemap_get_folio(NODE_MAPPING(sbi), ino);
+	struct f2fs_cached_block *entry = f2fs_find_node_cache(sbi, ino);
 	bool ret = false;
 	/* But we need to avoid that there are some inode updates */
-	if ((!IS_ERR(i) && folio_test_dirty(i)) ||
+	if ((!IS_ERR(entry) && f2fs_cache_test_dirty(entry)) ||
 	    f2fs_need_inode_block_update(sbi, ino))
 		ret = true;
-	f2fs_folio_put(i, false);
+	f2fs_put_cache(entry, false);
 	return ret;
 }
 
@@ -340,10 +340,6 @@ static int f2fs_do_sync_file(struct file *file, loff_t start, loff_t end,
 	nid_t ino = inode->i_ino;
 	int ret = 0;
 	enum cp_reason_type cp_reason = 0;
-	struct writeback_control wbc = {
-		.sync_mode = WB_SYNC_ALL,
-		.nr_to_write = LONG_MAX,
-	};
 	unsigned int seq_id = 0;
 
 	if (unlikely(f2fs_readonly(inode->i_sb)))
@@ -422,7 +418,7 @@ static int f2fs_do_sync_file(struct file *file, loff_t start, loff_t end,
 	}
 sync_nodes:
 	atomic_inc(&sbi->wb_sync_req[NODE]);
-	ret = f2fs_fsync_node_pages(sbi, inode, &wbc, atomic, &seq_id);
+	ret = f2fs_fsync_node_caches(sbi, inode, atomic, &seq_id);
 	atomic_dec(&sbi->wb_sync_req[NODE]);
 	if (ret)
 		goto out;
@@ -448,7 +444,7 @@ static int f2fs_do_sync_file(struct file *file, loff_t start, loff_t end,
 	 * given fsync mark.
 	 */
 	if (!atomic) {
-		ret = f2fs_wait_on_node_pages_writeback(sbi, seq_id);
+		ret = f2fs_wait_on_node_caches_writeback(sbi, seq_id);
 		if (ret)
 			goto out;
 	}
@@ -485,7 +481,7 @@ static bool __found_offset(struct address_space *mapping,
 	bool compressed_cluster = false;
 
 	if (f2fs_compressed_file(inode)) {
-		block_t first_blkaddr = data_blkaddr(dn->inode, dn->node_folio,
+		block_t first_blkaddr = data_blkaddr(dn->inode, dn->node_entry,
 		    ALIGN_DOWN(dn->ofs_in_node, F2FS_I(inode)->i_cluster_size));
 
 		compressed_cluster = first_blkaddr == COMPRESS_ADDR;
@@ -557,7 +553,7 @@ static loff_t f2fs_seek_block(struct file *file, loff_t offset, int whence)
 			}
 		}
 
-		end_offset = ADDRS_PER_PAGE(dn.node_folio, inode);
+		end_offset = ADDRS_PER_PAGE(dn.node_entry, inode);
 
 		/* find data/hole in dnode block */
 		for (; dn.ofs_in_node < end_offset;
@@ -720,7 +716,7 @@ void f2fs_truncate_data_blocks_range(struct dnode_of_data *dn, int count)
 	block_t blkstart;
 	int blklen = 0;
 
-	addr = get_dnode_addr(dn->inode, dn->node_folio) + ofs;
+	addr = get_dnode_addr(dn->inode, dn->node_entry) + ofs;
 	blkstart = le32_to_cpu(*addr);
 
 	/* Assumption: truncation starts with cluster */
@@ -784,7 +780,7 @@ void f2fs_truncate_data_blocks_range(struct dnode_of_data *dn, int count)
 		 * once we invalidate valid blkaddr in range [ofs, ofs + count],
 		 * we will invalidate all blkaddr in the whole range.
 		 */
-		fofs = f2fs_start_bidx_of_node(ofs_of_node(sbi, dn->node_folio),
+		fofs = f2fs_start_bidx_of_node(ofs_of_node(sbi, dn->node_entry),
 							dn->inode) + ofs;
 		f2fs_update_read_extent_cache_range(dn, fofs, 0, len);
 		f2fs_update_age_extent_cache_range(dn, fofs, len);
@@ -822,7 +818,7 @@ static int truncate_partial_data_page(struct inode *inode, u64 from,
 	if (IS_ERR(folio))
 		return PTR_ERR(folio) == -ENOENT ? 0 : PTR_ERR(folio);
 truncate_out:
-	f2fs_folio_wait_writeback(folio, DATA, true, true);
+	f2fs_folio_wait_writeback(folio, true, true);
 	folio_zero_segment(folio, offset, folio_size(folio));
 
 	/* An encrypted inode should have a key and truncate the last page. */
@@ -840,7 +836,7 @@ int f2fs_do_truncate_blocks(struct inode *inode, u64 from, bool lock)
 	struct f2fs_lock_context lc;
 	pgoff_t free_from;
 	int count = 0, err = 0;
-	struct folio *ifolio;
+	struct f2fs_cached_block *ientry;
 	bool truncate_page = false;
 
 	trace_f2fs_truncate_blocks_enter(inode, from);
@@ -858,9 +854,9 @@ int f2fs_do_truncate_blocks(struct inode *inode, u64 from, bool lock)
 	if (lock)
 		f2fs_lock_op(sbi, &lc);
 
-	ifolio = f2fs_get_inode_folio(sbi, inode->i_ino);
-	if (IS_ERR(ifolio)) {
-		err = PTR_ERR(ifolio);
+	ientry = f2fs_get_inode_cache(sbi, inode->i_ino);
+	if (IS_ERR(ientry)) {
+		err = PTR_ERR(ientry);
 		goto out;
 	}
 
@@ -879,18 +875,18 @@ int f2fs_do_truncate_blocks(struct inode *inode, u64 from, bool lock)
 
 		f2fs_drop_extent_tree(inode);
 
-		f2fs_folio_put(ifolio, true);
+		f2fs_put_cache(ientry, true);
 		goto out;
 	}
 
 	if (f2fs_has_inline_data(inode)) {
-		f2fs_truncate_inline_inode(inode, ifolio, from);
-		f2fs_folio_put(ifolio, true);
+		f2fs_truncate_inline_inode(inode, ientry, from);
+		f2fs_put_cache(ientry, true);
 		truncate_page = true;
 		goto out;
 	}
 
-	set_new_dnode(&dn, inode, ifolio, NULL, 0);
+	set_new_dnode(&dn, inode, ientry, NULL, 0);
 	err = f2fs_get_dnode_of_data(&dn, free_from, LOOKUP_NODE_RA);
 	if (err) {
 		if (err == -ENOENT)
@@ -898,12 +894,12 @@ int f2fs_do_truncate_blocks(struct inode *inode, u64 from, bool lock)
 		goto out;
 	}
 
-	count = ADDRS_PER_PAGE(dn.node_folio, inode);
+	count = ADDRS_PER_PAGE(dn.node_entry, inode);
 
 	count -= dn.ofs_in_node;
 	f2fs_bug_on(sbi, count < 0);
 
-	if (dn.ofs_in_node || IS_INODE(sbi, dn.node_folio)) {
+	if (dn.ofs_in_node || IS_INODE(sbi, dn.node_entry)) {
 		f2fs_truncate_data_blocks_range(&dn, count);
 		free_from += count;
 	}
@@ -1309,7 +1305,7 @@ static int fill_zero(struct inode *inode, pgoff_t index,
 	if (IS_ERR(folio))
 		return PTR_ERR(folio);
 
-	f2fs_folio_wait_writeback(folio, DATA, true, true);
+	f2fs_folio_wait_writeback(folio, true, true);
 	folio_zero_range(folio, start, len);
 	folio_mark_dirty(folio);
 	f2fs_folio_put(folio, true);
@@ -1335,7 +1331,7 @@ int f2fs_truncate_hole(struct inode *inode, pgoff_t pg_start, pgoff_t pg_end)
 			return err;
 		}
 
-		end_offset = ADDRS_PER_PAGE(dn.node_folio, inode);
+		end_offset = ADDRS_PER_PAGE(dn.node_entry, inode);
 		count = min(end_offset - dn.ofs_in_node, pg_end - pg_start);
 
 		f2fs_bug_on(F2FS_I_SB(inode), count == 0 || count > end_offset);
@@ -1435,7 +1431,7 @@ static int __read_out_blkaddrs(struct inode *inode, block_t *blkaddr,
 		goto next;
 	}
 
-	done = min((pgoff_t)ADDRS_PER_PAGE(dn.node_folio, inode) -
+	done = min((pgoff_t)ADDRS_PER_PAGE(dn.node_entry, inode) -
 							dn.ofs_in_node, len);
 	for (i = 0; i < done; i++, blkaddr++, do_replace++, dn.ofs_in_node++) {
 		*blkaddr = f2fs_data_blkaddr(&dn);
@@ -1524,7 +1520,7 @@ static int __clone_blkaddrs(struct inode *src_inode, struct inode *dst_inode,
 			}
 
 			ilen = min((pgoff_t)
-				ADDRS_PER_PAGE(dn.node_folio, dst_inode) -
+				ADDRS_PER_PAGE(dn.node_entry, dst_inode) -
 						dn.ofs_in_node, len - i);
 			do {
 				dn.data_blkaddr = f2fs_data_blkaddr(&dn);
@@ -1562,7 +1558,7 @@ static int __clone_blkaddrs(struct inode *src_inode, struct inode *dst_inode,
 				return PTR_ERR(fdst);
 			}
 
-			f2fs_folio_wait_writeback(fdst, DATA, true, true);
+			f2fs_folio_wait_writeback(fdst, true, true);
 
 			memcpy_folio(fdst, 0, fsrc, 0, PAGE_SIZE);
 			folio_mark_dirty(fdst);
@@ -1832,7 +1828,7 @@ static int f2fs_zero_range(struct inode *inode, loff_t offset, loff_t len,
 				goto out;
 			}
 
-			end_offset = ADDRS_PER_PAGE(dn.node_folio, inode);
+			end_offset = ADDRS_PER_PAGE(dn.node_entry, inode);
 			end = min(pg_end, end_offset - dn.ofs_in_node + index);
 
 			ret = f2fs_do_zero_range(&dn, index, end);
@@ -3133,7 +3129,7 @@ static int f2fs_defragment_range(struct f2fs_sb_info *sbi,
 				goto clear_out;
 			}
 
-			f2fs_folio_wait_writeback(folio, DATA, true, true);
+			f2fs_folio_wait_writeback(folio, true, true);
 
 			folio_mark_dirty(folio);
 			folio_set_f2fs_gcing(folio);
@@ -3856,7 +3852,7 @@ static int f2fs_ioc_reserve_dev_alias(struct file *filp)
 	f2fs_reserve_device_alias(sbi, ei.blk, ei.len);
 
 	i_size_write(inode, (loff_t)ei.len << sbi->log_blocksize);
-	f2fs_update_inode_page(inode);
+	f2fs_update_inode_cache(inode);
 
 	spin_lock(&FREE_I(sbi)->segmap_lock);
 	FDEV(f2fs_target_device_index(sbi, ei.blk)).is_reserving = false;
@@ -3950,7 +3946,7 @@ static int f2fs_ioc_release_dev_alias(struct file *filp)
 		goto out_inode_unlock;
 	}
 
-	f2fs_update_inode_page(inode);
+	f2fs_update_inode_cache(inode);
 
 	f2fs_unlock_op(sbi, &lc);
 	f2fs_up_write_trace(&sbi->gc_lock, &glc);
@@ -4169,7 +4165,7 @@ static int release_compress_blocks(struct dnode_of_data *dn, pgoff_t count)
 	int i;
 
 	for (i = 0; i < count; i++) {
-		blkaddr = data_blkaddr(dn->inode, dn->node_folio,
+		blkaddr = data_blkaddr(dn->inode, dn->node_entry,
 						dn->ofs_in_node + i);
 
 		if (!__is_valid_data_blkaddr(blkaddr))
@@ -4288,7 +4284,7 @@ static int f2fs_release_compress_blocks(struct file *filp, unsigned long arg)
 			break;
 		}
 
-		end_offset = ADDRS_PER_PAGE(dn.node_folio, inode);
+		end_offset = ADDRS_PER_PAGE(dn.node_entry, inode);
 		count = min(end_offset - dn.ofs_in_node, last_idx - page_idx);
 		count = round_up(count, fi->i_cluster_size);
 
@@ -4339,7 +4335,7 @@ static int reserve_compress_blocks(struct dnode_of_data *dn, pgoff_t count,
 	int i;
 
 	for (i = 0; i < count; i++) {
-		blkaddr = data_blkaddr(dn->inode, dn->node_folio,
+		blkaddr = data_blkaddr(dn->inode, dn->node_entry,
 						dn->ofs_in_node + i);
 
 		if (!__is_valid_data_blkaddr(blkaddr))
@@ -4356,7 +4352,7 @@ static int reserve_compress_blocks(struct dnode_of_data *dn, pgoff_t count,
 		int ret;
 
 		for (i = 0; i < cluster_size; i++) {
-			blkaddr = data_blkaddr(dn->inode, dn->node_folio,
+			blkaddr = data_blkaddr(dn->inode, dn->node_entry,
 						dn->ofs_in_node + i);
 
 			if (i == 0) {
@@ -4467,7 +4463,7 @@ static int f2fs_reserve_compress_blocks(struct file *filp, unsigned long arg)
 			break;
 		}
 
-		end_offset = ADDRS_PER_PAGE(dn.node_folio, inode);
+		end_offset = ADDRS_PER_PAGE(dn.node_entry, inode);
 		count = min(end_offset - dn.ofs_in_node, last_idx - page_idx);
 		count = round_up(count, fi->i_cluster_size);
 
@@ -4633,7 +4629,7 @@ static int f2fs_sec_trim_file(struct file *filp, unsigned long arg)
 			goto out;
 		}
 
-		end_offset = ADDRS_PER_PAGE(dn.node_folio, inode);
+		end_offset = ADDRS_PER_PAGE(dn.node_entry, inode);
 		count = min(end_offset - dn.ofs_in_node, pg_end - index);
 		for (i = 0; i < count; i++, index++, dn.ofs_in_node++) {
 			struct block_device *cur_bdev;
@@ -4829,7 +4825,7 @@ static int redirty_blocks(struct inode *inode, pgoff_t page_idx, int len)
 		/* It will never fail, when folio has pinned above */
 		f2fs_bug_on(F2FS_I_SB(inode), IS_ERR(folio));
 
-		f2fs_folio_wait_writeback(folio, DATA, true, true);
+		f2fs_folio_wait_writeback(folio, true, true);
 
 		folio_mark_dirty(folio);
 		folio_set_f2fs_gcing(folio);
diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index bed9056d6b6e..a35d15b97d5b 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -1054,7 +1054,7 @@ static int gc_node_segment(struct f2fs_sb_info *sbi,
 
 	for (off = 0; off < usable_blks_in_seg; off++, entry++) {
 		nid_t nid = le32_to_cpu(entry->nid);
-		struct folio *node_folio;
+		struct f2fs_cached_block *node_entry;
 		struct node_info ni;
 		int err;
 
@@ -1072,32 +1072,32 @@ static int gc_node_segment(struct f2fs_sb_info *sbi,
 		}
 
 		if (phase == 1) {
-			f2fs_ra_node_page(sbi, nid);
+			f2fs_ra_node_cache(sbi, nid);
 			continue;
 		}
 
 		/* phase == 2 */
-		node_folio = f2fs_get_node_folio(sbi, nid, NODE_TYPE_REGULAR);
-		if (IS_ERR(node_folio))
+		node_entry = f2fs_get_node_cache(sbi, nid, NODE_TYPE_REGULAR);
+		if (IS_ERR(node_entry))
 			continue;
 
 		/* block may become invalid during f2fs_get_node_folio */
 		if (check_valid_map(sbi, segno, off) == 0) {
-			f2fs_folio_put(node_folio, true);
+			f2fs_put_cache(node_entry, true);
 			continue;
 		}
 
 		if (f2fs_get_node_info(sbi, nid, &ni, false)) {
-			f2fs_folio_put(node_folio, true);
+			f2fs_put_cache(node_entry, true);
 			continue;
 		}
 
 		if (ni.blk_addr != start_addr + off) {
-			f2fs_folio_put(node_folio, true);
+			f2fs_put_cache(node_entry, true);
 			continue;
 		}
 
-		err = f2fs_move_node_folio(node_folio, gc_type);
+		err = f2fs_move_node_cache(node_entry, gc_type);
 		if (!err && gc_type == FG_GC)
 			submitted++;
 		stat_inc_node_blk_count(sbi, 1, gc_type);
@@ -1148,7 +1148,7 @@ block_t f2fs_start_bidx_of_node(unsigned int node_ofs, struct inode *inode)
 static bool is_alive(struct f2fs_sb_info *sbi, struct f2fs_summary *sum,
 		struct node_info *dni, block_t blkaddr, unsigned int *nofs)
 {
-	struct folio *node_folio;
+	struct f2fs_cached_block *node_entry;
 	nid_t nid;
 	unsigned int ofs_in_node, max_addrs, base;
 	block_t source_blkaddr;
@@ -1156,12 +1156,12 @@ static bool is_alive(struct f2fs_sb_info *sbi, struct f2fs_summary *sum,
 	nid = le32_to_cpu(sum->nid);
 	ofs_in_node = le16_to_cpu(sum->ofs_in_node);
 
-	node_folio = f2fs_get_node_folio(sbi, nid, NODE_TYPE_REGULAR);
-	if (IS_ERR(node_folio))
+	node_entry = f2fs_get_node_cache(sbi, nid, NODE_TYPE_REGULAR);
+	if (IS_ERR(node_entry))
 		return false;
 
 	if (f2fs_get_node_info(sbi, nid, dni, false)) {
-		f2fs_folio_put(node_folio, true);
+		f2fs_put_cache(node_entry, true);
 		return false;
 	}
 
@@ -1172,12 +1172,12 @@ static bool is_alive(struct f2fs_sb_info *sbi, struct f2fs_summary *sum,
 	}
 
 	if (f2fs_check_nid_range(sbi, dni->ino)) {
-		f2fs_folio_put(node_folio, true);
+		f2fs_put_cache(node_entry, true);
 		return false;
 	}
 
-	if (IS_INODE(sbi, node_folio)) {
-		base = offset_in_addr(F2FS_INODE(node_folio));
+	if (IS_INODE(sbi, node_entry)) {
+		base = offset_in_addr(F2FS_INODE(node_entry));
 		max_addrs = DEF_ADDRS_PER_INODE(sbi);
 	} else {
 		base = 0;
@@ -1187,13 +1187,13 @@ static bool is_alive(struct f2fs_sb_info *sbi, struct f2fs_summary *sum,
 	if (base + ofs_in_node >= max_addrs) {
 		f2fs_err(sbi, "Inconsistent blkaddr offset: base:%u, ofs_in_node:%u, max:%u, ino:%u, nid:%u",
 			base, ofs_in_node, max_addrs, dni->ino, dni->nid);
-		f2fs_folio_put(node_folio, true);
+		f2fs_put_cache(node_entry, true);
 		return false;
 	}
 
-	*nofs = ofs_of_node(sbi, node_folio);
-	source_blkaddr = data_blkaddr(NULL, node_folio, ofs_in_node);
-	f2fs_folio_put(node_folio, true);
+	*nofs = ofs_of_node(sbi, node_entry);
+	source_blkaddr = data_blkaddr(NULL, node_entry, ofs_in_node);
+	f2fs_put_cache(node_entry, true);
 
 	if (source_blkaddr != blkaddr) {
 #ifdef CONFIG_F2FS_CHECK_FS
@@ -1285,7 +1285,7 @@ static int ra_data_block(struct inode *inode, pgoff_t index)
 	 * don't cache encrypted data into meta inode until previous dirty
 	 * data were writebacked to avoid racing between GC and flush.
 	 */
-	f2fs_folio_wait_writeback(folio, DATA, true, true);
+	f2fs_folio_wait_writeback(folio, true, true);
 
 	f2fs_wait_on_block_writeback(inode, dn.data_blkaddr);
 
@@ -1396,7 +1396,7 @@ static int move_data_block(struct inode *inode, block_t bidx,
 	 * don't cache encrypted data into meta inode until previous dirty
 	 * data were writebacked to avoid racing between GC and flush.
 	 */
-	f2fs_folio_wait_writeback(folio, DATA, true, true);
+	f2fs_folio_wait_writeback(folio, true, true);
 
 	f2fs_wait_on_block_writeback(inode, dn.data_blkaddr);
 
@@ -1445,7 +1445,7 @@ static int move_data_block(struct inode *inode, block_t bidx,
 	set_summary(&sum, dn.nid, dn.ofs_in_node, ni.version);
 
 	/* allocate block address */
-	err = f2fs_allocate_data_block(fio.sbi, NULL, fio.old_blkaddr, &newaddr,
+	err = f2fs_allocate_data_block(fio.sbi, fio.old_blkaddr, &newaddr,
 				&sum, type, NULL);
 	if (err) {
 		f2fs_put_cache(sentry, true);
@@ -1549,7 +1549,7 @@ static int move_data_page(struct inode *inode, block_t bidx, int gc_type,
 		bool is_dirty = folio_test_dirty(folio);
 
 retry:
-		f2fs_folio_wait_writeback(folio, DATA, true, true);
+		f2fs_folio_wait_writeback(folio, true, true);
 
 		folio_mark_dirty(folio);
 		if (folio_clear_dirty_for_io(folio)) {
@@ -1626,7 +1626,7 @@ static int gc_data_segment(struct f2fs_sb_info *sbi, struct f2fs_summary *sum,
 		}
 
 		if (phase == 1) {
-			f2fs_ra_node_page(sbi, nid);
+			f2fs_ra_node_cache(sbi, nid);
 			continue;
 		}
 
@@ -1635,7 +1635,7 @@ static int gc_data_segment(struct f2fs_sb_info *sbi, struct f2fs_summary *sum,
 			continue;
 
 		if (phase == 2) {
-			f2fs_ra_node_page(sbi, dni.ino);
+			f2fs_ra_node_cache(sbi, dni.ino);
 			continue;
 		}
 
diff --git a/fs/f2fs/inline.c b/fs/f2fs/inline.c
index d10acb5042e3..273b6428c9f9 100644
--- a/fs/f2fs/inline.c
+++ b/fs/f2fs/inline.c
@@ -34,7 +34,7 @@ bool f2fs_may_inline_data(struct inode *inode)
 	return !f2fs_post_read_required(inode);
 }
 
-static bool inode_has_blocks(struct inode *inode, struct folio *ifolio)
+static bool inode_has_blocks(struct inode *inode, struct f2fs_cached_block *ientry)
 {
 	int i;
 
@@ -42,18 +42,18 @@ static bool inode_has_blocks(struct inode *inode, struct folio *ifolio)
 		return true;
 
 	for (i = 0; i < DEF_NIDS_PER_INODE; i++) {
-		if (F2FS_INODE_NIDS(F2FS_I_SB(inode), ifolio)[i])
+		if (F2FS_INODE_NIDS(F2FS_I_SB(inode), ientry)[i])
 			return true;
 	}
 	return false;
 }
 
-bool f2fs_sanity_check_inline_data(struct inode *inode, struct folio *ifolio)
+bool f2fs_sanity_check_inline_data(struct inode *inode, struct f2fs_cached_block *ientry)
 {
 	if (!f2fs_has_inline_data(inode))
 		return false;
 
-	if (inode_has_blocks(inode, ifolio))
+	if (inode_has_blocks(inode, ientry))
 		return false;
 
 	if (!support_inline_data(inode))
@@ -79,7 +79,7 @@ bool f2fs_may_inline_dentry(struct inode *inode)
 	return true;
 }
 
-void f2fs_do_read_inline_data(struct folio *folio, struct folio *ifolio)
+void f2fs_do_read_inline_data(struct folio *folio, struct f2fs_cached_block *ientry)
 {
 	struct inode *inode = folio->mapping->host;
 
@@ -91,13 +91,13 @@ void f2fs_do_read_inline_data(struct folio *folio, struct folio *ifolio)
 	folio_zero_segment(folio, MAX_INLINE_DATA(inode), folio_size(folio));
 
 	/* Copy the whole inline data block */
-	memcpy_to_folio(folio, 0, inline_data_addr(inode, ifolio),
+	memcpy_to_folio(folio, 0, inline_data_addr(inode, ientry),
 		       MAX_INLINE_DATA(inode));
 	if (!folio_test_uptodate(folio))
 		folio_mark_uptodate(folio);
 }
 
-void f2fs_truncate_inline_inode(struct inode *inode, struct folio *ifolio,
+void f2fs_truncate_inline_inode(struct inode *inode, struct f2fs_cached_block *ientry,
 		u64 from)
 {
 	void *addr;
@@ -105,11 +105,11 @@ void f2fs_truncate_inline_inode(struct inode *inode, struct folio *ifolio,
 	if (from >= MAX_INLINE_DATA(inode))
 		return;
 
-	addr = inline_data_addr(inode, ifolio);
+	addr = inline_data_addr(inode, ientry);
 
-	f2fs_folio_wait_writeback(ifolio, NODE, true, true);
+	f2fs_cache_wait_writeback(ientry);
 	memset(addr + from, 0, MAX_INLINE_DATA(inode) - from);
-	folio_mark_dirty(ifolio);
+	f2fs_mark_cache_dirty(ientry);
 
 	if (from == 0)
 		clear_inode_flag(inode, FI_DATA_EXIST);
@@ -117,27 +117,27 @@ void f2fs_truncate_inline_inode(struct inode *inode, struct folio *ifolio,
 
 int f2fs_read_inline_data(struct inode *inode, struct folio *folio)
 {
-	struct folio *ifolio;
+	struct f2fs_cached_block *ientry;
 
-	ifolio = f2fs_get_inode_folio(F2FS_I_SB(inode), inode->i_ino);
-	if (IS_ERR(ifolio)) {
+	ientry = f2fs_get_inode_cache(F2FS_I_SB(inode), inode->i_ino);
+	if (IS_ERR(ientry)) {
 		folio_unlock(folio);
-		return PTR_ERR(ifolio);
+		return PTR_ERR(ientry);
 	}
 
 	if (!f2fs_has_inline_data(inode)) {
-		f2fs_folio_put(ifolio, true);
+		f2fs_put_cache(ientry, true);
 		return -EAGAIN;
 	}
 
 	if (folio->index)
 		folio_zero_segment(folio, 0, folio_size(folio));
 	else
-		f2fs_do_read_inline_data(folio, ifolio);
+		f2fs_do_read_inline_data(folio, ientry);
 
 	if (!folio_test_uptodate(folio))
 		folio_mark_uptodate(folio);
-	f2fs_folio_put(ifolio, true);
+	f2fs_put_cache(ientry, true);
 	folio_unlock(folio);
 	return 0;
 }
@@ -185,7 +185,7 @@ int f2fs_convert_inline_folio(struct dnode_of_data *dn, struct folio *folio)
 
 	f2fs_bug_on(F2FS_F_SB(folio), folio_test_writeback(folio));
 
-	f2fs_do_read_inline_data(folio, dn->inode_folio);
+	f2fs_do_read_inline_data(folio, dn->inode_entry);
 	folio_mark_dirty(folio);
 
 	/* clear dirty state */
@@ -196,7 +196,7 @@ int f2fs_convert_inline_folio(struct dnode_of_data *dn, struct folio *folio)
 	fio.old_blkaddr = dn->data_blkaddr;
 	set_inode_flag(dn->inode, FI_HOT_DATA);
 	f2fs_outplace_write_data(dn, &fio);
-	f2fs_folio_wait_writeback(folio, DATA, true, true);
+	f2fs_folio_wait_writeback(folio, true, true);
 	if (dirty) {
 		inode_dec_dirty_pages(dn->inode);
 		f2fs_remove_dirty_inode(dn->inode);
@@ -206,8 +206,8 @@ int f2fs_convert_inline_folio(struct dnode_of_data *dn, struct folio *folio)
 	set_inode_flag(dn->inode, FI_APPEND_WRITE);
 
 	/* clear inline data and flag after data writeback */
-	f2fs_truncate_inline_inode(dn->inode, dn->inode_folio, 0);
-	folio_clear_f2fs_inline(dn->inode_folio);
+	f2fs_truncate_inline_inode(dn->inode, dn->inode_entry, 0);
+	f2fs_cache_clear_inline(dn->inode_entry);
 clear_out:
 	stat_dec_inline_inode(dn->inode);
 	clear_inode_flag(dn->inode, FI_INLINE_DATA);
@@ -220,7 +220,8 @@ int f2fs_convert_inline_inode(struct inode *inode)
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
 	struct dnode_of_data dn;
 	struct f2fs_lock_context lc;
-	struct folio *ifolio, *folio;
+	struct f2fs_cached_block *ientry;
+	struct folio *folio;
 	int err = 0;
 
 	if (f2fs_hw_is_readonly(sbi) || f2fs_readonly(sbi->sb))
@@ -239,13 +240,13 @@ int f2fs_convert_inline_inode(struct inode *inode)
 
 	f2fs_lock_op(sbi, &lc);
 
-	ifolio = f2fs_get_inode_folio(sbi, inode->i_ino);
-	if (IS_ERR(ifolio)) {
-		err = PTR_ERR(ifolio);
+	ientry = f2fs_get_inode_cache(sbi, inode->i_ino);
+	if (IS_ERR(ientry)) {
+		err = PTR_ERR(ientry);
 		goto out;
 	}
 
-	set_new_dnode(&dn, inode, ifolio, ifolio, 0);
+	set_new_dnode(&dn, inode, ientry, ientry, 0);
 
 	if (f2fs_has_inline_data(inode))
 		err = f2fs_convert_inline_folio(&dn, folio);
@@ -265,31 +266,31 @@ int f2fs_convert_inline_inode(struct inode *inode)
 int f2fs_write_inline_data(struct inode *inode, struct folio *folio)
 {
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
-	struct folio *ifolio;
+	struct f2fs_cached_block *ientry;
 
-	ifolio = f2fs_get_inode_folio(sbi, inode->i_ino);
-	if (IS_ERR(ifolio))
-		return PTR_ERR(ifolio);
+	ientry = f2fs_get_inode_cache(sbi, inode->i_ino);
+	if (IS_ERR(ientry))
+		return PTR_ERR(ientry);
 
 	if (!f2fs_has_inline_data(inode)) {
-		f2fs_folio_put(ifolio, true);
+		f2fs_put_cache(ientry, true);
 		return -EAGAIN;
 	}
 
 	f2fs_bug_on(F2FS_I_SB(inode), folio->index);
 
-	f2fs_folio_wait_writeback(ifolio, NODE, true, true);
-	memcpy_from_folio(inline_data_addr(inode, ifolio),
+	f2fs_cache_wait_writeback(ientry);
+	memcpy_from_folio(inline_data_addr(inode, ientry),
 			 folio, 0, MAX_INLINE_DATA(inode));
-	folio_mark_dirty(ifolio);
+	f2fs_mark_cache_dirty(ientry);
 
 	f2fs_clear_page_cache_dirty_tag(folio);
 
 	set_inode_flag(inode, FI_APPEND_WRITE);
 	set_inode_flag(inode, FI_DATA_EXIST);
 
-	folio_clear_f2fs_inline(ifolio);
-	f2fs_folio_put(ifolio, true);
+	f2fs_cache_clear_inline(ientry);
+	f2fs_put_cache(ientry, true);
 	return 0;
 }
 
@@ -307,40 +308,41 @@ int f2fs_recover_inline_data(struct inode *inode, struct f2fs_cached_block *entr
 	 *    x       o  -> remove data blocks, and then recover inline_data
 	 *    x       x  -> recover data blocks
 	 */
-	if (IS_INODE(sbi, cache_folio(entry)))
+	if (IS_INODE(F2FS_I_SB(inode), entry))
 		ri = &CACHED_NODE(entry)->i;
 
 	if (f2fs_has_inline_data(inode) &&
 			ri && (ri->i_inline & F2FS_INLINE_DATA)) {
-		struct folio *ifolio;
+		struct f2fs_cached_block *ientry;
 
 process_inline:
-		ifolio = f2fs_get_inode_folio(sbi, inode->i_ino);
-		if (IS_ERR(ifolio))
-			return PTR_ERR(ifolio);
+		ientry = f2fs_get_inode_cache(sbi, inode->i_ino);
+		if (IS_ERR(ientry))
+			return PTR_ERR(ientry);
 
-		f2fs_folio_wait_writeback(ifolio, NODE, true, true);
+		f2fs_cache_wait_writeback(ientry);
 
-		src_addr = inline_data_addr(inode, cache_folio(entry));
-		dst_addr = inline_data_addr(inode, ifolio);
+		src_addr = inline_data_addr(inode, entry);
+		dst_addr = inline_data_addr(inode, ientry);
 		memcpy(dst_addr, src_addr, MAX_INLINE_DATA(inode));
 
 		set_inode_flag(inode, FI_INLINE_DATA);
 		set_inode_flag(inode, FI_DATA_EXIST);
 
-		folio_mark_dirty(ifolio);
-		f2fs_folio_put(ifolio, true);
+		f2fs_mark_cache_dirty(ientry);
+		f2fs_put_cache(ientry, true);
 		return 1;
 	}
 
 	if (f2fs_has_inline_data(inode)) {
-		struct folio *ifolio = f2fs_get_inode_folio(sbi, inode->i_ino);
-		if (IS_ERR(ifolio))
-			return PTR_ERR(ifolio);
-		f2fs_truncate_inline_inode(inode, ifolio, 0);
+		struct f2fs_cached_block *ientry = f2fs_get_inode_cache(sbi, inode->i_ino);
+
+		if (IS_ERR(ientry))
+			return PTR_ERR(ientry);
+		f2fs_truncate_inline_inode(inode, ientry, 0);
 		stat_dec_inline_inode(inode);
 		clear_inode_flag(inode, FI_INLINE_DATA);
-		f2fs_folio_put(ifolio, true);
+		f2fs_put_cache(ientry, true);
 	} else if (ri && (ri->i_inline & F2FS_INLINE_DATA)) {
 		int ret;
 
@@ -355,50 +357,50 @@ int f2fs_recover_inline_data(struct inode *inode, struct f2fs_cached_block *entr
 
 struct f2fs_dir_entry *f2fs_find_in_inline_dir(struct inode *dir,
 					const struct f2fs_filename *fname,
-					struct folio **res_folio,
+					void **dentry_block,
 					bool use_hash)
 {
 	struct f2fs_sb_info *sbi = F2FS_SB(dir->i_sb);
 	struct f2fs_dir_entry *de;
 	struct f2fs_dentry_ptr d;
-	struct folio *ifolio;
+	struct f2fs_cached_block *ientry;
 	void *inline_dentry;
 
-	ifolio = f2fs_get_inode_folio(sbi, dir->i_ino);
-	if (IS_ERR(ifolio)) {
-		*res_folio = ifolio;
+	ientry = f2fs_get_inode_cache(sbi, dir->i_ino);
+	if (IS_ERR(ientry)) {
+		*dentry_block = ientry;
 		return NULL;
 	}
 
-	inline_dentry = inline_data_addr(dir, ifolio);
+	inline_dentry = inline_data_addr(dir, ientry);
 
 	make_dentry_ptr_inline(dir, &d, inline_dentry);
 	de = f2fs_find_target_dentry(&d, fname, NULL, use_hash);
-	folio_unlock(ifolio);
+	f2fs_unlock_cache(ientry);
 	if (IS_ERR(de)) {
-		*res_folio = ERR_CAST(de);
+		*dentry_block = ERR_CAST(de);
 		de = NULL;
 	}
 	if (de)
-		*res_folio = ifolio;
+		*dentry_block = f2fs_cache_make_dentry_block(ientry);
 	else
-		f2fs_folio_put(ifolio, false);
+		f2fs_put_cache(ientry, false);
 
 	return de;
 }
 
 int f2fs_make_empty_inline_dir(struct inode *inode, struct inode *parent,
-							struct folio *ifolio)
+					struct f2fs_cached_block *ientry)
 {
 	struct f2fs_dentry_ptr d;
 	void *inline_dentry;
 
-	inline_dentry = inline_data_addr(inode, ifolio);
+	inline_dentry = inline_data_addr(inode, ientry);
 
 	make_dentry_ptr_inline(inode, &d, inline_dentry);
 	f2fs_do_make_empty_dir(inode, parent, &d);
 
-	folio_mark_dirty(ifolio);
+	f2fs_mark_cache_dirty(ientry);
 
 	/* update i_size to MAX_INLINE_DATA */
 	if (i_size_read(inode) < MAX_INLINE_DATA(inode))
@@ -410,8 +412,9 @@ int f2fs_make_empty_inline_dir(struct inode *inode, struct inode *parent,
  * NOTE: ipage is grabbed by caller, but if any error occurs, we should
  * release ipage in this function.
  */
-static int f2fs_move_inline_dirents(struct inode *dir, struct folio *ifolio,
-							void *inline_dentry)
+static int f2fs_move_inline_dirents(struct inode *dir,
+			struct f2fs_cached_block *ientry,
+			void *inline_dentry)
 {
 	struct folio *folio;
 	struct dnode_of_data dn;
@@ -421,11 +424,11 @@ static int f2fs_move_inline_dirents(struct inode *dir, struct folio *ifolio,
 
 	folio = f2fs_grab_cache_folio(dir->i_mapping, 0, true);
 	if (IS_ERR(folio)) {
-		f2fs_folio_put(ifolio, true);
+		f2fs_put_cache(ientry, true);
 		return PTR_ERR(folio);
 	}
 
-	set_new_dnode(&dn, dir, ifolio, NULL, 0);
+	set_new_dnode(&dn, dir, ientry, NULL, 0);
 	err = f2fs_reserve_block(&dn, 0);
 	if (err)
 		goto out;
@@ -441,7 +444,7 @@ static int f2fs_move_inline_dirents(struct inode *dir, struct folio *ifolio,
 		goto out;
 	}
 
-	f2fs_folio_wait_writeback(folio, DATA, true, true);
+	f2fs_folio_wait_writeback(folio, true, true);
 
 	dentry_blk = folio_address(folio);
 
@@ -464,7 +467,7 @@ static int f2fs_move_inline_dirents(struct inode *dir, struct folio *ifolio,
 	folio_mark_dirty(folio);
 
 	/* clear inline dir and flag after data writeback */
-	f2fs_truncate_inline_inode(dir, ifolio, 0);
+	f2fs_truncate_inline_inode(dir, ientry, 0);
 
 	stat_dec_inline_dir(dir);
 	clear_inode_flag(dir, FI_INLINE_DENTRY);
@@ -544,8 +547,8 @@ static int f2fs_add_inline_entries(struct inode *dir, void *inline_dentry)
 	return err;
 }
 
-static int f2fs_move_rehashed_dirents(struct inode *dir, struct folio *ifolio,
-							void *inline_dentry)
+static int f2fs_move_rehashed_dirents(struct inode *dir,
+		struct f2fs_cached_block *ientry, void *inline_dentry)
 {
 	void *backup_dentry;
 	int err;
@@ -553,20 +556,20 @@ static int f2fs_move_rehashed_dirents(struct inode *dir, struct folio *ifolio,
 	backup_dentry = f2fs_kmalloc(F2FS_I_SB(dir),
 				MAX_INLINE_DATA(dir), GFP_F2FS_ZERO);
 	if (!backup_dentry) {
-		f2fs_folio_put(ifolio, true);
+		f2fs_put_cache(ientry, true);
 		return -ENOMEM;
 	}
 
 	memcpy(backup_dentry, inline_dentry, MAX_INLINE_DATA(dir));
-	f2fs_truncate_inline_inode(dir, ifolio, 0);
+	f2fs_truncate_inline_inode(dir, ientry, 0);
 
-	folio_unlock(ifolio);
+	f2fs_unlock_cache(ientry);
 
 	err = f2fs_add_inline_entries(dir, backup_dentry);
 	if (err)
 		goto recover;
 
-	folio_lock(ifolio);
+	f2fs_lock_cache(ientry);
 
 	stat_dec_inline_dir(dir);
 	clear_inode_flag(dir, FI_INLINE_DENTRY);
@@ -582,31 +585,31 @@ static int f2fs_move_rehashed_dirents(struct inode *dir, struct folio *ifolio,
 	kfree(backup_dentry);
 	return 0;
 recover:
-	folio_lock(ifolio);
-	f2fs_folio_wait_writeback(ifolio, NODE, true, true);
+	f2fs_lock_cache(ientry);
+	f2fs_cache_wait_writeback(ientry);
 	memcpy(inline_dentry, backup_dentry, MAX_INLINE_DATA(dir));
 	f2fs_i_depth_write(dir, 0);
 	f2fs_i_size_write(dir, MAX_INLINE_DATA(dir));
-	folio_mark_dirty(ifolio);
-	f2fs_folio_put(ifolio, true);
+	f2fs_mark_cache_dirty(ientry);
+	f2fs_put_cache(ientry, true);
 
 	kfree(backup_dentry);
 	return err;
 }
 
-static int do_convert_inline_dir(struct inode *dir, struct folio *ifolio,
-							void *inline_dentry)
+static int do_convert_inline_dir(struct inode *dir,
+		struct f2fs_cached_block *ientry, void *inline_dentry)
 {
 	if (!F2FS_I(dir)->i_dir_level)
-		return f2fs_move_inline_dirents(dir, ifolio, inline_dentry);
+		return f2fs_move_inline_dirents(dir, ientry, inline_dentry);
 	else
-		return f2fs_move_rehashed_dirents(dir, ifolio, inline_dentry);
+		return f2fs_move_rehashed_dirents(dir, ientry, inline_dentry);
 }
 
 int f2fs_try_convert_inline_dir(struct inode *dir, struct dentry *dentry)
 {
 	struct f2fs_sb_info *sbi = F2FS_I_SB(dir);
-	struct folio *ifolio;
+	struct f2fs_cached_block *ientry;
 	struct f2fs_filename fname;
 	struct f2fs_lock_context lc;
 	void *inline_dentry = NULL;
@@ -621,22 +624,22 @@ int f2fs_try_convert_inline_dir(struct inode *dir, struct dentry *dentry)
 	if (err)
 		goto out;
 
-	ifolio = f2fs_get_inode_folio(sbi, dir->i_ino);
-	if (IS_ERR(ifolio)) {
-		err = PTR_ERR(ifolio);
+	ientry = f2fs_get_inode_cache(sbi, dir->i_ino);
+	if (IS_ERR(ientry)) {
+		err = PTR_ERR(ientry);
 		goto out_fname;
 	}
 
-	if (f2fs_has_enough_room(dir, ifolio, &fname)) {
-		f2fs_folio_put(ifolio, true);
+	if (f2fs_has_enough_room(dir, ientry, &fname)) {
+		f2fs_put_cache(ientry, true);
 		goto out_fname;
 	}
 
-	inline_dentry = inline_data_addr(dir, ifolio);
+	inline_dentry = inline_data_addr(dir, ientry);
 
-	err = do_convert_inline_dir(dir, ifolio, inline_dentry);
+	err = do_convert_inline_dir(dir, ientry, inline_dentry);
 	if (!err)
-		f2fs_folio_put(ifolio, true);
+		f2fs_put_cache(ientry, true);
 out_fname:
 	f2fs_free_filename(&fname);
 out:
@@ -648,24 +651,24 @@ int f2fs_add_inline_entry(struct inode *dir, const struct f2fs_filename *fname,
 			  struct inode *inode, nid_t ino, umode_t mode)
 {
 	struct f2fs_sb_info *sbi = F2FS_I_SB(dir);
-	struct folio *ifolio;
+	struct f2fs_cached_block *ientry;
 	unsigned int bit_pos;
 	void *inline_dentry = NULL;
 	struct f2fs_dentry_ptr d;
 	int slots = GET_DENTRY_SLOTS(fname->disk_name.len);
-	struct folio *folio = NULL;
+	struct f2fs_cached_block *nentry = NULL;
 	int err = 0;
 
-	ifolio = f2fs_get_inode_folio(sbi, dir->i_ino);
-	if (IS_ERR(ifolio))
-		return PTR_ERR(ifolio);
+	ientry = f2fs_get_inode_cache(sbi, dir->i_ino);
+	if (IS_ERR(ientry))
+		return PTR_ERR(ientry);
 
-	inline_dentry = inline_data_addr(dir, ifolio);
+	inline_dentry = inline_data_addr(dir, ientry);
 	make_dentry_ptr_inline(dir, &d, inline_dentry);
 
 	bit_pos = f2fs_room_for_filename(d.bitmap, slots, d.max);
 	if (bit_pos >= d.max) {
-		err = do_convert_inline_dir(dir, ifolio, inline_dentry);
+		err = do_convert_inline_dir(dir, ientry, inline_dentry);
 		if (err)
 			return err;
 		err = -EAGAIN;
@@ -675,19 +678,19 @@ int f2fs_add_inline_entry(struct inode *dir, const struct f2fs_filename *fname,
 	if (inode) {
 		f2fs_down_write_nested(&F2FS_I(inode)->i_sem,
 						SINGLE_DEPTH_NESTING);
-		folio = f2fs_init_inode_metadata(inode, dir, fname, ifolio);
-		if (IS_ERR(folio)) {
-			err = PTR_ERR(folio);
+		nentry = f2fs_init_inode_metadata(inode, dir, fname, ientry);
+		if (IS_ERR(nentry)) {
+			err = PTR_ERR(nentry);
 			goto fail;
 		}
 	}
 
-	f2fs_folio_wait_writeback(ifolio, NODE, true, true);
+	f2fs_cache_wait_writeback(ientry);
 
 	f2fs_update_dentry(ino, mode, &d, &fname->disk_name, fname->hash,
 			   bit_pos);
 
-	folio_mark_dirty(ifolio);
+	f2fs_mark_cache_dirty(ientry);
 
 	/* we don't need to mark_inode_dirty now */
 	if (inode) {
@@ -695,9 +698,9 @@ int f2fs_add_inline_entry(struct inode *dir, const struct f2fs_filename *fname,
 
 		/* synchronize inode page's data from inode cache */
 		if (is_inode_flag_set(inode, FI_NEW_INODE))
-			f2fs_update_inode(inode, folio);
+			f2fs_update_inode(inode, nentry);
 
-		f2fs_folio_put(folio, true);
+		f2fs_put_cache(nentry, true);
 	}
 
 	f2fs_update_parent_metadata(dir, inode, 0);
@@ -705,12 +708,12 @@ int f2fs_add_inline_entry(struct inode *dir, const struct f2fs_filename *fname,
 	if (inode)
 		f2fs_up_write(&F2FS_I(inode)->i_sem);
 out:
-	f2fs_folio_put(ifolio, true);
+	f2fs_put_cache(ientry, true);
 	return err;
 }
 
 void f2fs_delete_inline_entry(struct f2fs_dir_entry *dentry,
-		struct folio *folio, struct inode *dir, struct inode *inode)
+		struct f2fs_cached_block *ientry, struct inode *dir, struct inode *inode)
 {
 	struct f2fs_dentry_ptr d;
 	void *inline_dentry;
@@ -718,18 +721,18 @@ void f2fs_delete_inline_entry(struct f2fs_dir_entry *dentry,
 	unsigned int bit_pos;
 	int i;
 
-	folio_lock(folio);
-	f2fs_folio_wait_writeback(folio, NODE, true, true);
+	f2fs_lock_cache(ientry);
+	f2fs_cache_wait_writeback(ientry);
 
-	inline_dentry = inline_data_addr(dir, folio);
+	inline_dentry = inline_data_addr(dir, ientry);
 	make_dentry_ptr_inline(dir, &d, inline_dentry);
 
 	bit_pos = dentry - d.dentry;
 	for (i = 0; i < slots; i++)
 		__clear_bit_le(bit_pos + i, d.bitmap);
 
-	folio_mark_dirty(folio);
-	f2fs_folio_put(folio, true);
+	f2fs_mark_cache_dirty(ientry);
+	f2fs_put_cache(ientry, true);
 
 	inode_set_mtime_to_ts(dir, inode_set_ctime_current(dir));
 	f2fs_mark_inode_dirty_sync(dir, true);
@@ -741,21 +744,21 @@ void f2fs_delete_inline_entry(struct f2fs_dir_entry *dentry,
 bool f2fs_empty_inline_dir(struct inode *dir)
 {
 	struct f2fs_sb_info *sbi = F2FS_I_SB(dir);
-	struct folio *ifolio;
+	struct f2fs_cached_block *ientry;
 	unsigned int bit_pos = 2;
 	void *inline_dentry;
 	struct f2fs_dentry_ptr d;
 
-	ifolio = f2fs_get_inode_folio(sbi, dir->i_ino);
-	if (IS_ERR(ifolio))
+	ientry = f2fs_get_inode_cache(sbi, dir->i_ino);
+	if (IS_ERR(ientry))
 		return false;
 
-	inline_dentry = inline_data_addr(dir, ifolio);
+	inline_dentry = inline_data_addr(dir, ientry);
 	make_dentry_ptr_inline(dir, &d, inline_dentry);
 
 	bit_pos = find_next_bit_le(d.bitmap, d.max, bit_pos);
 
-	f2fs_folio_put(ifolio, true);
+	f2fs_put_cache(ientry, true);
 
 	if (bit_pos < d.max)
 		return false;
@@ -767,7 +770,7 @@ int f2fs_read_inline_dir(struct file *file, struct dir_context *ctx,
 				struct fscrypt_str *fstr)
 {
 	struct inode *inode = file_inode(file);
-	struct folio *ifolio = NULL;
+	struct f2fs_cached_block *ientry = NULL;
 	struct f2fs_dentry_ptr d;
 	void *inline_dentry = NULL;
 	int err;
@@ -777,17 +780,17 @@ int f2fs_read_inline_dir(struct file *file, struct dir_context *ctx,
 	if (ctx->pos == d.max)
 		return 0;
 
-	ifolio = f2fs_get_inode_folio(F2FS_I_SB(inode), inode->i_ino);
-	if (IS_ERR(ifolio))
-		return PTR_ERR(ifolio);
+	ientry = f2fs_get_inode_cache(F2FS_I_SB(inode), inode->i_ino);
+	if (IS_ERR(ientry))
+		return PTR_ERR(ientry);
 
 	/*
 	 * f2fs_readdir was protected by inode.i_rwsem, it is safe to access
 	 * ipage without page's lock held.
 	 */
-	folio_unlock(ifolio);
+	f2fs_unlock_cache(ientry);
 
-	inline_dentry = inline_data_addr(inode, ifolio);
+	inline_dentry = inline_data_addr(inode, ientry);
 
 	make_dentry_ptr_inline(inode, &d, inline_dentry);
 
@@ -795,7 +798,7 @@ int f2fs_read_inline_dir(struct file *file, struct dir_context *ctx,
 	if (!err)
 		ctx->pos = d.max;
 
-	f2fs_folio_put(ifolio, false);
+	f2fs_put_cache(ientry, false);
 	return err < 0 ? err : 0;
 }
 
@@ -806,12 +809,12 @@ int f2fs_inline_data_fiemap(struct inode *inode,
 	__u32 flags = FIEMAP_EXTENT_DATA_INLINE | FIEMAP_EXTENT_NOT_ALIGNED |
 		FIEMAP_EXTENT_LAST;
 	struct node_info ni;
-	struct folio *ifolio;
+	struct f2fs_cached_block *ientry;
 	int err = 0;
 
-	ifolio = f2fs_get_inode_folio(F2FS_I_SB(inode), inode->i_ino);
-	if (IS_ERR(ifolio))
-		return PTR_ERR(ifolio);
+	ientry = f2fs_get_inode_cache(F2FS_I_SB(inode), inode->i_ino);
+	if (IS_ERR(ientry))
+		return PTR_ERR(ientry);
 
 	if ((S_ISREG(inode->i_mode) || S_ISLNK(inode->i_mode)) &&
 				!f2fs_has_inline_data(inode)) {
@@ -825,13 +828,13 @@ int f2fs_inline_data_fiemap(struct inode *inode,
 	}
 
 	if (fieinfo->fi_flags & FIEMAP_FLAG_SYNC) {
-		err = f2fs_write_single_node_folio(ifolio, true, false, FS_NODE_IO);
+		err = f2fs_write_node_cache(ientry, true, false, FS_NODE_IO);
 		if (err)
 			return err;
-		ifolio = f2fs_get_inode_folio(F2FS_I_SB(inode), inode->i_ino);
-		if (IS_ERR(ifolio))
-			return PTR_ERR(ifolio);
-		f2fs_folio_wait_writeback(ifolio, NODE, true, true);
+		ientry = f2fs_get_inode_cache(F2FS_I_SB(inode), inode->i_ino);
+		if (IS_ERR(ientry))
+			return PTR_ERR(ientry);
+		f2fs_cache_wait_writeback(ientry);
 	}
 	ilen = min_t(size_t, MAX_INLINE_DATA(inode), i_size_read(inode));
 	if (start >= ilen)
@@ -846,8 +849,8 @@ int f2fs_inline_data_fiemap(struct inode *inode,
 
 	if (__is_valid_data_blkaddr(ni.blk_addr)) {
 		byteaddr = (__u64)ni.blk_addr << inode->i_sb->s_blocksize_bits;
-		byteaddr += (char *)inline_data_addr(inode, ifolio) -
-						(char *)F2FS_INODE(ifolio);
+		byteaddr += (char *)inline_data_addr(inode, ientry) -
+						(char *)F2FS_INODE(ientry);
 	} else {
 		f2fs_bug_on(F2FS_I_SB(inode), ni.blk_addr != NEW_ADDR);
 		flags |= FIEMAP_EXTENT_DELALLOC | FIEMAP_EXTENT_UNKNOWN;
@@ -855,6 +858,6 @@ int f2fs_inline_data_fiemap(struct inode *inode,
 	err = fiemap_fill_next_extent(fieinfo, start, byteaddr, ilen, flags);
 	trace_f2fs_fiemap(inode, start, byteaddr, ilen, flags, err);
 out:
-	f2fs_folio_put(ifolio, true);
+	f2fs_put_cache(ientry, true);
 	return err;
 }
diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
index f2e1d8b50f8c..c822ca2dce20 100644
--- a/fs/f2fs/inode.c
+++ b/fs/f2fs/inode.c
@@ -82,9 +82,9 @@ void f2fs_set_inode_flags(struct inode *inode)
 			S_ENCRYPTED|S_VERITY|S_CASEFOLD);
 }
 
-static void __get_inode_rdev(struct inode *inode, struct folio *node_folio)
+static void __get_inode_rdev(struct inode *inode, struct f2fs_cached_block *ientry)
 {
-	__le32 *addr = get_dnode_addr(inode, node_folio);
+	__le32 *addr = get_dnode_addr(inode, ientry);
 
 	if (S_ISCHR(inode->i_mode) || S_ISBLK(inode->i_mode) ||
 			S_ISFIFO(inode->i_mode) || S_ISSOCK(inode->i_mode)) {
@@ -95,9 +95,9 @@ static void __get_inode_rdev(struct inode *inode, struct folio *node_folio)
 	}
 }
 
-static void __set_inode_rdev(struct inode *inode, struct folio *node_folio)
+static void __set_inode_rdev(struct inode *inode, struct f2fs_cached_block *ientry)
 {
-	__le32 *addr = get_dnode_addr(inode, node_folio);
+	__le32 *addr = get_dnode_addr(inode, ientry);
 
 	if (S_ISCHR(inode->i_mode) || S_ISBLK(inode->i_mode)) {
 		if (old_valid_dev(inode->i_rdev)) {
@@ -111,34 +111,33 @@ static void __set_inode_rdev(struct inode *inode, struct folio *node_folio)
 	}
 }
 
-static void __recover_inline_status(struct inode *inode, struct folio *ifolio)
+static void __recover_inline_status(struct inode *inode, struct f2fs_cached_block *ientry)
 {
-	void *inline_data = inline_data_addr(inode, ifolio);
+	void *inline_data = inline_data_addr(inode, ientry);
 	__le32 *start = inline_data;
 	__le32 *end = start + MAX_INLINE_DATA(inode) / sizeof(__le32);
 
 	while (start < end) {
 		if (*start++) {
-			f2fs_folio_wait_writeback(ifolio, NODE, true, true);
+			f2fs_cache_wait_writeback(ientry);
 
 			set_inode_flag(inode, FI_DATA_EXIST);
-			set_raw_inline(inode, F2FS_INODE(ifolio));
-			folio_mark_dirty(ifolio);
+			set_raw_inline(inode, F2FS_INODE(ientry));
+			f2fs_mark_cache_dirty(ientry);
 			return;
 		}
 	}
 	return;
 }
 
-static
-bool f2fs_enable_inode_chksum(struct f2fs_sb_info *sbi, struct folio *folio)
+static bool f2fs_enable_inode_chksum(struct f2fs_sb_info *sbi, struct f2fs_cached_block *entry)
 {
-	struct f2fs_inode *ri = &F2FS_NODE(folio)->i;
+	struct f2fs_inode *ri = F2FS_INODE(entry);
 
 	if (!f2fs_sb_has_inode_chksum(sbi))
 		return false;
 
-	if (!IS_INODE(sbi, folio) || !(ri->i_inline & F2FS_EXTRA_ATTR))
+	if (!IS_INODE(sbi, entry) || !(ri->i_inline & F2FS_EXTRA_ATTR))
 		return false;
 
 	if (!F2FS_FITS_IN_INODE(ri, le16_to_cpu(ri->i_extra_isize),
@@ -148,10 +147,10 @@ bool f2fs_enable_inode_chksum(struct f2fs_sb_info *sbi, struct folio *folio)
 	return true;
 }
 
-static __u32 f2fs_inode_chksum(struct f2fs_sb_info *sbi, struct folio *folio)
+static __u32 f2fs_inode_chksum(struct f2fs_sb_info *sbi, struct f2fs_cached_block *entry)
 {
-	struct f2fs_inode *ri = F2FS_INODE(folio);
-	__le32 ino = F2FS_NODE_FOOTER(sbi, folio)->ino;
+	struct f2fs_inode *ri = F2FS_INODE(entry);
+	__le32 ino = F2FS_NODE_FOOTER(sbi, entry)->ino;
 	__le32 gen = ri->i_generation;
 	__u32 chksum, chksum_seed;
 	__u32 dummy_cs = 0;
@@ -169,7 +168,7 @@ static __u32 f2fs_inode_chksum(struct f2fs_sb_info *sbi, struct folio *folio)
 	return chksum;
 }
 
-bool f2fs_inode_chksum_verify(struct f2fs_sb_info *sbi, struct folio *folio)
+bool f2fs_inode_chksum_verify(struct f2fs_sb_info *sbi, struct f2fs_cached_block *entry)
 {
 	struct f2fs_inode *ri;
 	__u32 provided, calculated;
@@ -177,35 +176,33 @@ bool f2fs_inode_chksum_verify(struct f2fs_sb_info *sbi, struct folio *folio)
 	if (unlikely(is_sbi_flag_set(sbi, SBI_IS_SHUTDOWN)))
 		return true;
 
-#ifdef CONFIG_F2FS_CHECK_FS
-	if (!f2fs_enable_inode_chksum(sbi, folio))
-#else
-	if (!f2fs_enable_inode_chksum(sbi, folio) ||
-			folio_test_dirty(folio) ||
-			folio_test_writeback(folio))
-#endif
+	if (!f2fs_enable_inode_chksum(sbi, entry))
 		return true;
+#ifndef CONFIG_F2FS_CHECK_FS
+	if (f2fs_cache_test_dirty(entry) || f2fs_cache_test_writeback(entry))
+		return true;
+#endif
 
-	ri = &F2FS_NODE(folio)->i;
+	ri = F2FS_INODE(entry);
 	provided = le32_to_cpu(ri->i_inode_checksum);
-	calculated = f2fs_inode_chksum(sbi, folio);
+	calculated = f2fs_inode_chksum(sbi, entry);
 
 	if (provided != calculated)
-		f2fs_warn(sbi, "checksum invalid, nid = %lu, ino_of_node = %x, %x vs. %x",
-			  folio->index, ino_of_node(sbi, folio),
+		f2fs_warn(sbi, "checksum invalid, nid = %lu, ino_of_node = %u, %x vs. %x",
+			  entry->index, ino_of_node(sbi, entry),
 			  provided, calculated);
 
 	return provided == calculated;
 }
 
-void f2fs_inode_chksum_set(struct f2fs_sb_info *sbi, struct folio *folio)
+void f2fs_inode_chksum_set(struct f2fs_sb_info *sbi, struct f2fs_cached_block *entry)
 {
-	struct f2fs_inode *ri = &F2FS_NODE(folio)->i;
+	struct f2fs_inode *ri = F2FS_INODE(entry);
 
-	if (!f2fs_enable_inode_chksum(sbi, folio))
+	if (!f2fs_enable_inode_chksum(sbi, entry))
 		return;
 
-	ri->i_inode_checksum = cpu_to_le32(f2fs_inode_chksum(sbi, folio));
+	ri->i_inode_checksum = cpu_to_le32(f2fs_inode_chksum(sbi, entry));
 }
 
 static bool sanity_check_compress_inode(struct inode *inode,
@@ -280,28 +277,29 @@ static bool sanity_check_compress_inode(struct inode *inode,
 	return false;
 }
 
-static bool sanity_check_inode(struct inode *inode, struct folio *node_folio)
+static bool sanity_check_inode(struct inode *inode,
+			struct f2fs_cached_block *node_entry)
 {
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
 	struct f2fs_inode_info *fi = F2FS_I(inode);
-	struct f2fs_inode *ri = F2FS_INODE(node_folio);
+	struct f2fs_inode *ri = F2FS_INODE(node_entry);
 	unsigned long long iblocks;
 
-	iblocks = le64_to_cpu(F2FS_INODE(node_folio)->i_blocks);
+	iblocks = le64_to_cpu(ri->i_blocks);
 	if (!iblocks) {
 		f2fs_warn(sbi, "%s: corrupted inode i_blocks i_ino=%llx iblocks=%llu, run fsck to fix.",
 			  __func__, inode->i_ino, iblocks);
 		return false;
 	}
 
-	if (ino_of_node(sbi, node_folio) != nid_of_node(sbi, node_folio)) {
+	if (ino_of_node(sbi, node_entry) != nid_of_node(sbi, node_entry)) {
 		f2fs_warn(sbi, "%s: corrupted inode footer i_ino=%llx, ino,nid: [%u, %u] run fsck to fix.",
 			  __func__, inode->i_ino,
-			  ino_of_node(sbi, node_folio), nid_of_node(sbi, node_folio));
+			  ino_of_node(sbi, node_entry), nid_of_node(sbi, node_entry));
 		return false;
 	}
 
-	if (ino_of_node(sbi, node_folio) == fi->i_xattr_nid) {
+	if (ino_of_node(sbi, node_entry) == fi->i_xattr_nid) {
 		f2fs_warn(sbi, "%s: corrupted inode i_ino=%llx, xnid=%x, run fsck to fix.",
 			  __func__, inode->i_ino, fi->i_xattr_nid);
 		return false;
@@ -375,7 +373,7 @@ static bool sanity_check_inode(struct inode *inode, struct folio *node_folio)
 		}
 	}
 
-	if (f2fs_sanity_check_inline_data(inode, node_folio)) {
+	if (f2fs_sanity_check_inline_data(inode, node_entry)) {
 		f2fs_warn(sbi, "%s: inode (ino=%llx, mode=%u) should not have inline_data, run fsck to fix",
 			  __func__, inode->i_ino, inode->i_mode);
 		return false;
@@ -428,7 +426,7 @@ static int do_read_inode(struct inode *inode)
 {
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
 	struct f2fs_inode_info *fi = F2FS_I(inode);
-	struct folio *node_folio;
+	struct f2fs_cached_block *node_entry;
 	struct f2fs_inode *ri;
 	projid_t i_projid;
 
@@ -436,11 +434,11 @@ static int do_read_inode(struct inode *inode)
 	if (f2fs_check_nid_range(sbi, inode->i_ino))
 		return -EINVAL;
 
-	node_folio = f2fs_get_inode_folio(sbi, inode->i_ino);
-	if (IS_ERR(node_folio))
-		return PTR_ERR(node_folio);
+	node_entry = f2fs_get_inode_cache(sbi, inode->i_ino);
+	if (IS_ERR(node_entry))
+		return PTR_ERR(node_entry);
 
-	ri = F2FS_INODE(node_folio);
+	ri = F2FS_INODE(node_entry);
 
 	inode->i_mode = le16_to_cpu(ri->i_mode);
 	i_uid_write(inode, le32_to_cpu(ri->i_uid));
@@ -491,8 +489,8 @@ static int do_read_inode(struct inode *inode)
 		fi->i_inline_xattr_size = 0;
 	}
 
-	if (!sanity_check_inode(inode, node_folio)) {
-		f2fs_folio_put(node_folio, true);
+	if (!sanity_check_inode(inode, node_entry)) {
+		f2fs_put_cache(node_entry, true);
 		set_sbi_flag(sbi, SBI_NEED_FSCK);
 		f2fs_handle_error(sbi, ERROR_CORRUPTED_INODE);
 		fserror_report_file_metadata(inode, -EFSCORRUPTED, GFP_NOFS);
@@ -501,17 +499,17 @@ static int do_read_inode(struct inode *inode)
 
 	/* check data exist */
 	if (f2fs_has_inline_data(inode) && !f2fs_exist_data(inode))
-		__recover_inline_status(inode, node_folio);
+		__recover_inline_status(inode, node_entry);
 
 	/* try to recover cold bit for non-dir inode */
-	if (!S_ISDIR(inode->i_mode) && !is_cold_node(sbi, node_folio)) {
-		f2fs_folio_wait_writeback(node_folio, NODE, true, true);
-		set_cold_node(sbi, node_folio, false);
-		folio_mark_dirty(node_folio);
+	if (!S_ISDIR(inode->i_mode) && !is_cold_node(sbi, node_entry)) {
+		f2fs_cache_wait_writeback(node_entry);
+		set_cold_node(sbi, node_entry, false);
+		f2fs_mark_cache_dirty(node_entry);
 	}
 
 	/* get rdev by using inline_info */
-	__get_inode_rdev(inode, node_folio);
+	__get_inode_rdev(inode, node_entry);
 
 	if (!f2fs_need_inode_block_update(sbi, inode->i_ino))
 		fi->last_disk_size = inode->i_size;
@@ -554,18 +552,18 @@ static int do_read_inode(struct inode *inode)
 
 	init_idisk_time(inode);
 
-	if (!sanity_check_extent_cache(inode, node_folio)) {
-		f2fs_folio_put(node_folio, true);
+	if (!sanity_check_extent_cache(inode, node_entry)) {
+		f2fs_put_cache(node_entry, true);
 		f2fs_handle_error(sbi, ERROR_CORRUPTED_INODE);
 		fserror_report_file_metadata(inode, -EFSCORRUPTED, GFP_NOFS);
 		return -EFSCORRUPTED;
 	}
 
 	/* Need all the flag bits */
-	f2fs_init_read_extent_tree(inode, node_folio);
+	f2fs_init_read_extent_tree(inode, node_entry);
 	f2fs_init_age_extent_tree(inode);
 
-	f2fs_folio_put(node_folio, true);
+	f2fs_put_cache(node_entry, true);
 
 	stat_inc_inline_xattr(inode);
 	stat_inc_inline_inode(inode);
@@ -578,8 +576,6 @@ static int do_read_inode(struct inode *inode)
 
 static bool is_meta_ino(struct f2fs_sb_info *sbi, unsigned int ino)
 {
-	if (ino == F2FS_NODE_INO(sbi))
-		return true;
 #ifdef CONFIG_F2FS_FS_COMPRESSION
 	if (test_opt(sbi, COMPRESS_CACHE) && ino == F2FS_COMPRESS_INO(sbi))
 		return true;
@@ -622,10 +618,7 @@ struct inode *f2fs_iget(struct super_block *sb, unsigned long ino)
 make_now:
 	f2fs_set_inode_flags(inode);
 
-	if (ino == F2FS_NODE_INO(sbi)) {
-		inode->i_mapping->a_ops = &f2fs_node_aops;
-		mapping_set_gfp_mask(inode->i_mapping, GFP_NOFS);
-	} else if (ino == F2FS_COMPRESS_INO(sbi)) {
+	if (ino == F2FS_COMPRESS_INO(sbi)) {
 #ifdef CONFIG_F2FS_FS_COMPRESSION
 		inode->i_mapping->a_ops = &f2fs_compress_aops;
 		/*
@@ -692,19 +685,20 @@ struct inode *f2fs_iget_retry(struct super_block *sb, unsigned long ino)
 	return inode;
 }
 
-void f2fs_update_inode(struct inode *inode, struct folio *node_folio)
+void f2fs_update_inode(struct inode *inode,
+		struct f2fs_cached_block *node_entry)
 {
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
 	struct f2fs_inode_info *fi = F2FS_I(inode);
 	struct f2fs_inode *ri;
 	struct extent_tree *et = fi->extent_tree[EX_READ];
 
-	f2fs_folio_wait_writeback(node_folio, NODE, true, true);
-	folio_mark_dirty(node_folio);
+	f2fs_cache_wait_writeback(node_entry);
+	f2fs_mark_cache_dirty(node_entry);
 
 	f2fs_inode_synced(inode);
 
-	ri = F2FS_INODE(node_folio);
+	ri = F2FS_INODE(node_entry);
 
 	ri->i_mode = cpu_to_le16(inode->i_mode);
 	ri->i_advise = fi->i_advise;
@@ -780,27 +774,27 @@ void f2fs_update_inode(struct inode *inode, struct folio *node_folio)
 		}
 	}
 
-	__set_inode_rdev(inode, node_folio);
+	__set_inode_rdev(inode, node_entry);
 
 	/* deleted inode */
 	if (inode->i_nlink == 0)
-		folio_clear_f2fs_inline(node_folio);
+		f2fs_cache_clear_inline(node_entry);
 
 	init_idisk_time(inode);
 #ifdef CONFIG_F2FS_CHECK_FS
-	f2fs_inode_chksum_set(F2FS_I_SB(inode), node_folio);
+	f2fs_inode_chksum_set(F2FS_I_SB(inode), node_entry);
 #endif
 }
 
-void f2fs_update_inode_page(struct inode *inode)
+void f2fs_update_inode_cache(struct inode *inode)
 {
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
-	struct folio *node_folio;
+	struct f2fs_cached_block *node_entry;
 	int count = 0;
 retry:
-	node_folio = f2fs_get_inode_folio(sbi, inode->i_ino);
-	if (IS_ERR(node_folio)) {
-		int err = PTR_ERR(node_folio);
+	node_entry = f2fs_get_inode_cache(sbi, inode->i_ino);
+	if (IS_ERR(node_entry)) {
+		int err = PTR_ERR(node_entry);
 
 		/* The node block was truncated. */
 		if (err == -ENOENT)
@@ -816,17 +810,14 @@ void f2fs_update_inode_page(struct inode *inode)
 		f2fs_stop_checkpoint(sbi, false, STOP_CP_REASON_UPDATE_INODE);
 		return;
 	}
-	f2fs_update_inode(inode, node_folio);
-	f2fs_folio_put(node_folio, true);
+	f2fs_update_inode(inode, node_entry);
+	f2fs_put_cache(node_entry, true);
 }
 
 int f2fs_write_inode(struct inode *inode, struct writeback_control *wbc)
 {
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
 
-	if (inode->i_ino == F2FS_NODE_INO(sbi))
-		return 0;
-
 	/*
 	 * atime could be updated without dirtying f2fs inode in lazytime mode
 	 */
@@ -850,7 +841,7 @@ int f2fs_write_inode(struct inode *inode, struct writeback_control *wbc)
 	 * We need to balance fs here to prevent from producing dirty node pages
 	 * during the urgent cleaning time when running out of free sections.
 	 */
-	f2fs_update_inode_page(inode);
+	f2fs_update_inode_cache(inode);
 	if (wbc && wbc->nr_to_write)
 		f2fs_balance_fs(sbi, true);
 	return 0;
@@ -917,8 +908,7 @@ static bool f2fs_pre_evict_inode(struct inode *inode)
 	    test_opt(sbi, COMPRESS_CACHE) && f2fs_compressed_file(inode))
 		f2fs_invalidate_compress_pages(sbi, inode->i_ino);
 
-	if (inode->i_ino == F2FS_NODE_INO(sbi) ||
-	    inode->i_ino == F2FS_COMPRESS_INO(sbi))
+	if (inode->i_ino == F2FS_COMPRESS_INO(sbi))
 		return true;
 
 	f2fs_bug_on(sbi, get_dirty_pages(inode));
@@ -962,7 +952,7 @@ static void f2fs_delete_inode(struct inode *inode)
 		goto error_check;
 
 	f2fs_lock_op(sbi, &lc);
-	err = f2fs_remove_inode_page(inode);
+	err = f2fs_remove_inode_cache(inode);
 	f2fs_unlock_op(sbi, &lc);
 
 	if (err == -ENOENT) {
@@ -994,13 +984,13 @@ static void f2fs_delete_inode(struct inode *inode)
 	if (!err)
 		goto unfreeze_out;
 
-	f2fs_update_inode_page(inode);
+	f2fs_update_inode_cache(inode);
 
 	if (dquot_initialize_needed(inode))
 		set_sbi_flag(sbi, SBI_QUOTA_NEED_REPAIR);
 
 	/*
-	 * If both f2fs_truncate() and f2fs_update_inode_page() failed
+	 * If both f2fs_truncate() and f2fs_update_inode_cache() failed
 	 * due to fuzzed corrupted inode, call f2fs_inode_synced() to
 	 * avoid triggering later f2fs_bug_on().
 	 */
@@ -1044,10 +1034,9 @@ static void f2fs_post_evict_inode(struct inode *inode)
 
 	/* for the case f2fs_new_inode() was failed, .i_ino is zero, skip it */
 	if (inode->i_ino)
-		invalidate_mapping_pages(NODE_MAPPING(sbi), inode->i_ino,
-							inode->i_ino);
+		f2fs_invalidate_node_cache(sbi, inode->i_ino);
 	if (xnid)
-		invalidate_mapping_pages(NODE_MAPPING(sbi), xnid, xnid);
+		f2fs_invalidate_node_cache(sbi, xnid);
 
 	if (!inode->i_nlink)
 		goto skip_record;
@@ -1122,7 +1111,7 @@ void f2fs_handle_failed_inode(struct inode *inode,
 	 * we must call this to avoid inode being remained as dirty, resulting
 	 * in a panic when flushing dirty inodes in gdirty_list.
 	 */
-	f2fs_update_inode_page(inode);
+	f2fs_update_inode_cache(inode);
 	f2fs_inode_synced(inode);
 
 	/* don't make bad inode, since it becomes a regular file. */
diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
index ff86ee07290d..38fcea8b72bf 100644
--- a/fs/f2fs/namei.c
+++ b/fs/f2fs/namei.c
@@ -473,12 +473,13 @@ static int f2fs_link(struct dentry *old_dentry, struct inode *dir,
 
 struct dentry *f2fs_get_parent(struct dentry *child)
 {
-	struct folio *folio;
-	unsigned long ino = f2fs_inode_by_name(d_inode(child), &dotdot_name, &folio);
+	void *dentry_block = NULL;
+	unsigned long ino = f2fs_inode_by_name(d_inode(child),
+					&dotdot_name, &dentry_block);
 
 	if (!ino) {
-		if (IS_ERR(folio))
-			return ERR_CAST(folio);
+		if (IS_ERR(dentry_block))
+			return ERR_CAST(dentry_block);
 		return ERR_PTR(-ENOENT);
 	}
 	return d_obtain_alias(f2fs_iget(child->d_sb, ino));
@@ -489,7 +490,7 @@ static struct dentry *f2fs_lookup(struct inode *dir, struct dentry *dentry,
 {
 	struct inode *inode = NULL;
 	struct f2fs_dir_entry *de;
-	struct folio *folio;
+	void *dentry_block = NULL;
 	struct dentry *new;
 	nid_t ino = -1;
 	int err = 0;
@@ -507,12 +508,12 @@ static struct dentry *f2fs_lookup(struct inode *dir, struct dentry *dentry,
 		goto out_splice;
 	if (err)
 		goto out;
-	de = __f2fs_find_entry(dir, &fname, &folio);
+	de = __f2fs_find_entry(dir, &fname, &dentry_block);
 	f2fs_free_filename(&fname);
 
 	if (!de) {
-		if (IS_ERR(folio)) {
-			err = PTR_ERR(folio);
+		if (IS_ERR(dentry_block)) {
+			err = PTR_ERR(dentry_block);
 			goto out;
 		}
 		err = -ENOENT;
@@ -520,7 +521,7 @@ static struct dentry *f2fs_lookup(struct inode *dir, struct dentry *dentry,
 	}
 
 	ino = le32_to_cpu(de->ino);
-	f2fs_folio_put(folio, false);
+	f2fs_put_dentry_block(dentry_block, false);
 
 	inode = f2fs_iget(dir->i_sb, ino);
 	if (IS_ERR(inode)) {
@@ -572,7 +573,7 @@ static int __do_unlink(struct inode *dir, struct inode *inode,
 	struct f2fs_sb_info *sbi = F2FS_I_SB(dir);
 	struct f2fs_dir_entry *de;
 	struct f2fs_lock_context lc;
-	struct folio *folio;
+	void *dentry_block = NULL;
 	int err;
 
 	if (IS_DEVICE_ALIASING(inode))
@@ -588,9 +589,9 @@ static int __do_unlink(struct inode *dir, struct inode *inode,
 	if (err)
 		return err;
 
-	de = f2fs_find_entry(dir, name, &folio);
+	de = f2fs_find_entry(dir, name, &dentry_block);
 	if (!de)
-		return IS_ERR(folio) ? PTR_ERR(folio) : 0;
+		return IS_ERR(dentry_block) ? PTR_ERR(dentry_block) : 0;
 
 	if (unlikely(inode->i_nlink == 0)) {
 		f2fs_warn(sbi, "%s: inode (ino=%llx) has zero i_nlink",
@@ -610,7 +611,7 @@ static int __do_unlink(struct inode *dir, struct inode *inode,
 		f2fs_unlock_op(sbi, &lc);
 		goto err_out;
 	}
-	f2fs_delete_entry(de, folio, dir, inode);
+	f2fs_delete_entry(de, dentry_block, dir, inode);
 	f2fs_unlock_op(sbi, &lc);
 	return 0;
 
@@ -618,7 +619,7 @@ static int __do_unlink(struct inode *dir, struct inode *inode,
 	err = -EFSCORRUPTED;
 	set_sbi_flag(sbi, SBI_NEED_FSCK);
 err_out:
-	f2fs_folio_put(folio, false);
+	f2fs_put_dentry_block(dentry_block, false);
 	return err;
 }
 
@@ -967,8 +968,9 @@ static int f2fs_rename(struct mnt_idmap *idmap, struct inode *old_dir,
 	struct inode *old_inode = d_inode(old_dentry);
 	struct inode *new_inode = d_inode(new_dentry);
 	struct inode *whiteout = NULL;
-	struct folio *old_dir_folio = NULL;
-	struct folio *old_folio, *new_folio = NULL;
+	void *old_dir_block = NULL;
+	void *old_block = NULL;
+	void *new_block = NULL;
 	struct f2fs_dir_entry *old_dir_entry = NULL;
 	struct f2fs_dir_entry *old_entry;
 	struct f2fs_dir_entry *new_entry;
@@ -1032,18 +1034,18 @@ static int f2fs_rename(struct mnt_idmap *idmap, struct inode *old_dir,
 	}
 
 	err = -ENOENT;
-	old_entry = f2fs_find_entry(old_dir, &old_dentry->d_name, &old_folio);
+	old_entry = f2fs_find_entry(old_dir, &old_dentry->d_name, &old_block);
 	if (!old_entry) {
-		if (IS_ERR(old_folio))
-			err = PTR_ERR(old_folio);
+		if (IS_ERR(old_block))
+			err = PTR_ERR(old_block);
 		goto out;
 	}
 
 	if (old_is_dir && old_dir != new_dir) {
-		old_dir_entry = f2fs_parent_dir(old_inode, &old_dir_folio);
+		old_dir_entry = f2fs_parent_dir(old_inode, &old_dir_block);
 		if (!old_dir_entry) {
-			if (IS_ERR(old_dir_folio))
-				err = PTR_ERR(old_dir_folio);
+			if (IS_ERR(old_dir_block))
+				err = PTR_ERR(old_dir_block);
 			goto out_old;
 		}
 	}
@@ -1060,10 +1062,10 @@ static int f2fs_rename(struct mnt_idmap *idmap, struct inode *old_dir,
 
 		err = -ENOENT;
 		new_entry = f2fs_find_entry(new_dir, &new_dentry->d_name,
-						&new_folio);
+						&new_block);
 		if (!new_entry) {
-			if (IS_ERR(new_folio))
-				err = PTR_ERR(new_folio);
+			if (IS_ERR(new_block))
+				err = PTR_ERR(new_block);
 			goto out_dir;
 		}
 
@@ -1075,8 +1077,8 @@ static int f2fs_rename(struct mnt_idmap *idmap, struct inode *old_dir,
 		if (err)
 			goto put_out_dir;
 
-		f2fs_set_link(new_dir, new_entry, new_folio, old_inode);
-		new_folio = NULL;
+		f2fs_set_link(new_dir, new_entry, new_block, old_inode);
+		new_block = NULL;
 
 		inode_set_ctime_current(new_inode);
 		f2fs_down_write(&F2FS_I(new_inode)->i_sem);
@@ -1115,8 +1117,8 @@ static int f2fs_rename(struct mnt_idmap *idmap, struct inode *old_dir,
 	inode_set_ctime_current(old_inode);
 	f2fs_mark_inode_dirty_sync(old_inode, true);
 
-	f2fs_delete_entry(old_entry, old_folio, old_dir, NULL);
-	old_folio = NULL;
+	f2fs_delete_entry(old_entry, old_block, old_dir, NULL);
+	old_block = NULL;
 
 	if (whiteout) {
 		set_inode_flag(whiteout, FI_INC_LINK);
@@ -1134,7 +1136,7 @@ static int f2fs_rename(struct mnt_idmap *idmap, struct inode *old_dir,
 	}
 
 	if (old_dir_entry)
-		f2fs_set_link(old_inode, old_dir_entry, old_dir_folio, new_dir);
+		f2fs_set_link(old_inode, old_dir_entry, old_dir_block, new_dir);
 	if (old_is_dir)
 		f2fs_i_links_write(old_dir, false);
 
@@ -1158,12 +1160,12 @@ static int f2fs_rename(struct mnt_idmap *idmap, struct inode *old_dir,
 
 put_out_dir:
 	f2fs_unlock_op(sbi, &lc);
-	f2fs_folio_put(new_folio, false);
+	f2fs_put_dentry_block(new_block, false);
 out_dir:
 	if (old_dir_entry)
-		f2fs_folio_put(old_dir_folio, false);
+		f2fs_put_dentry_block(old_dir_block, false);
 out_old:
-	f2fs_folio_put(old_folio, false);
+	f2fs_put_dentry_block(old_block, false);
 out:
 	iput(whiteout);
 	return err;
@@ -1175,8 +1177,10 @@ static int f2fs_cross_rename(struct inode *old_dir, struct dentry *old_dentry,
 	struct f2fs_sb_info *sbi = F2FS_I_SB(old_dir);
 	struct inode *old_inode = d_inode(old_dentry);
 	struct inode *new_inode = d_inode(new_dentry);
-	struct folio *old_dir_folio, *new_dir_folio;
-	struct folio *old_folio, *new_folio;
+	void *old_dir_block = NULL;
+	void *new_dir_block = NULL;
+	void *old_block = NULL;
+	void *new_block = NULL;
 	struct f2fs_dir_entry *old_dir_entry = NULL, *new_dir_entry = NULL;
 	struct f2fs_dir_entry *old_entry, *new_entry;
 	struct f2fs_lock_context lc;
@@ -1208,17 +1212,17 @@ static int f2fs_cross_rename(struct inode *old_dir, struct dentry *old_dentry,
 		goto out;
 
 	err = -ENOENT;
-	old_entry = f2fs_find_entry(old_dir, &old_dentry->d_name, &old_folio);
+	old_entry = f2fs_find_entry(old_dir, &old_dentry->d_name, &old_block);
 	if (!old_entry) {
-		if (IS_ERR(old_folio))
-			err = PTR_ERR(old_folio);
+		if (IS_ERR(old_block))
+			err = PTR_ERR(old_block);
 		goto out;
 	}
 
-	new_entry = f2fs_find_entry(new_dir, &new_dentry->d_name, &new_folio);
+	new_entry = f2fs_find_entry(new_dir, &new_dentry->d_name, &new_block);
 	if (!new_entry) {
-		if (IS_ERR(new_folio))
-			err = PTR_ERR(new_folio);
+		if (IS_ERR(new_block))
+			err = PTR_ERR(new_block);
 		goto out_old;
 	}
 
@@ -1226,20 +1230,20 @@ static int f2fs_cross_rename(struct inode *old_dir, struct dentry *old_dentry,
 	if (old_dir != new_dir) {
 		if (S_ISDIR(old_inode->i_mode)) {
 			old_dir_entry = f2fs_parent_dir(old_inode,
-							&old_dir_folio);
+							&old_dir_block);
 			if (!old_dir_entry) {
-				if (IS_ERR(old_dir_folio))
-					err = PTR_ERR(old_dir_folio);
+				if (IS_ERR(old_dir_block))
+					err = PTR_ERR(old_dir_block);
 				goto out_new;
 			}
 		}
 
 		if (S_ISDIR(new_inode->i_mode)) {
 			new_dir_entry = f2fs_parent_dir(new_inode,
-							&new_dir_folio);
+							&new_dir_block);
 			if (!new_dir_entry) {
-				if (IS_ERR(new_dir_folio))
-					err = PTR_ERR(new_dir_folio);
+				if (IS_ERR(new_dir_block))
+					err = PTR_ERR(new_dir_block);
 				goto out_old_dir;
 			}
 		}
@@ -1266,14 +1270,14 @@ static int f2fs_cross_rename(struct inode *old_dir, struct dentry *old_dentry,
 
 	/* update ".." directory entry info of old dentry */
 	if (old_dir_entry)
-		f2fs_set_link(old_inode, old_dir_entry, old_dir_folio, new_dir);
+		f2fs_set_link(old_inode, old_dir_entry, old_dir_block, new_dir);
 
 	/* update ".." directory entry info of new dentry */
 	if (new_dir_entry)
-		f2fs_set_link(new_inode, new_dir_entry, new_dir_folio, old_dir);
+		f2fs_set_link(new_inode, new_dir_entry, new_dir_block, old_dir);
 
 	/* update directory entry info of old dir inode */
-	f2fs_set_link(old_dir, old_entry, old_folio, new_inode);
+	f2fs_set_link(old_dir, old_entry, old_block, new_inode);
 
 	f2fs_down_write(&F2FS_I(old_inode)->i_sem);
 	if (!old_dir_entry)
@@ -1292,7 +1296,7 @@ static int f2fs_cross_rename(struct inode *old_dir, struct dentry *old_dentry,
 	f2fs_mark_inode_dirty_sync(old_dir, true);
 
 	/* update directory entry info of new dir inode */
-	f2fs_set_link(new_dir, new_entry, new_folio, old_inode);
+	f2fs_set_link(new_dir, new_entry, new_block, old_inode);
 
 	f2fs_down_write(&F2FS_I(new_inode)->i_sem);
 	if (!new_dir_entry)
@@ -1327,16 +1331,16 @@ static int f2fs_cross_rename(struct inode *old_dir, struct dentry *old_dentry,
 	return 0;
 out_new_dir:
 	if (new_dir_entry) {
-		f2fs_folio_put(new_dir_folio, false);
+		f2fs_put_dentry_block(new_dir_block, false);
 	}
 out_old_dir:
 	if (old_dir_entry) {
-		f2fs_folio_put(old_dir_folio, false);
+		f2fs_put_dentry_block(old_dir_block, false);
 	}
 out_new:
-	f2fs_folio_put(new_folio, false);
+	f2fs_put_dentry_block(new_block, false);
 out_old:
-	f2fs_folio_put(old_folio, false);
+	f2fs_put_dentry_block(old_block, false);
 out:
 	return err;
 }
diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 197ce2f5149a..1af118858fd1 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -7,12 +7,12 @@
  */
 #include <linux/fs.h>
 #include <linux/f2fs_fs.h>
-#include <linux/mpage.h>
 #include <linux/sched/mm.h>
 #include <linux/blkdev.h>
 #include <linux/folio_batch.h>
 #include <linux/swap.h>
 #include <linux/fserror.h>
+#include <linux/freezer.h>
 
 #include "f2fs.h"
 #include "node.h"
@@ -130,16 +130,6 @@ bool f2fs_available_free_memory(struct f2fs_sb_info *sbi, int type)
 	return res;
 }
 
-static void clear_node_folio_dirty(struct folio *folio)
-{
-	if (folio_test_dirty(folio)) {
-		f2fs_clear_page_cache_dirty_tag(folio);
-		folio_clear_dirty_for_io(folio);
-		dec_page_count(F2FS_F_SB(folio), F2FS_DIRTY_NODES);
-	}
-	folio_clear_uptodate(folio);
-}
-
 static struct f2fs_cached_block *get_current_nat_cache(struct f2fs_sb_info *sbi,
 		nid_t nid)
 {
@@ -330,10 +320,11 @@ static unsigned int __gang_lookup_nat_set(struct f2fs_nm_info *nm_i,
 							start, nr);
 }
 
-bool f2fs_in_warm_node_list(struct f2fs_sb_info *sbi, struct folio *folio)
+bool f2fs_in_warm_node_list(struct f2fs_sb_info *sbi,
+				struct f2fs_cached_block *entry)
 {
-	return is_node_folio(sbi, folio) && IS_DNODE(sbi, folio) &&
-					is_cold_node(sbi, folio);
+	return f2fs_is_node_cache(entry) &&
+		IS_DNODE(sbi, entry) && is_cold_node(sbi, entry);
 }
 
 void f2fs_init_fsync_node_info(struct f2fs_sb_info *sbi)
@@ -345,7 +336,7 @@ void f2fs_init_fsync_node_info(struct f2fs_sb_info *sbi)
 }
 
 static unsigned int f2fs_add_fsync_node_entry(struct f2fs_sb_info *sbi,
-		struct folio *folio)
+		struct f2fs_cached_block *entry)
 {
 	struct fsync_node_entry *fn;
 	unsigned long flags;
@@ -354,8 +345,8 @@ static unsigned int f2fs_add_fsync_node_entry(struct f2fs_sb_info *sbi,
 	fn = f2fs_kmem_cache_alloc(fsync_node_entry_slab,
 					GFP_NOFS, true, NULL);
 
-	folio_get(folio);
-	fn->folio = folio;
+	f2fs_cache_get(entry);
+	fn->entry = entry;
 	INIT_LIST_HEAD(&fn->list);
 
 	spin_lock_irqsave(&sbi->fsync_node_lock, flags);
@@ -368,19 +359,19 @@ static unsigned int f2fs_add_fsync_node_entry(struct f2fs_sb_info *sbi,
 	return seq_id;
 }
 
-void f2fs_del_fsync_node_entry(struct f2fs_sb_info *sbi, struct folio *folio)
+void f2fs_del_fsync_node_entry(struct f2fs_sb_info *sbi, struct f2fs_cached_block *entry)
 {
 	struct fsync_node_entry *fn;
 	unsigned long flags;
 
 	spin_lock_irqsave(&sbi->fsync_node_lock, flags);
 	list_for_each_entry(fn, &sbi->fsync_node_list, list) {
-		if (fn->folio == folio) {
+		if (fn->entry == entry) {
 			list_del(&fn->list);
 			sbi->fsync_node_num--;
 			spin_unlock_irqrestore(&sbi->fsync_node_lock, flags);
+			f2fs_put_cache(fn->entry, false);
 			kmem_cache_free(fsync_node_entry_slab, fn);
-			folio_put(folio);
 			return;
 		}
 	}
@@ -677,11 +668,11 @@ int f2fs_get_node_info(struct f2fs_sb_info *sbi, nid_t nid,
 }
 
 /*
- * readahead MAX_RA_NODE number of node pages.
+ * readahead MAX_RA_NODE number of node caches.
  */
-static void f2fs_ra_node_pages(struct folio *parent, int start, int n)
+static void f2fs_ra_node_caches(struct f2fs_cached_block *parent, int start, int n)
 {
-	struct f2fs_sb_info *sbi = F2FS_F_SB(parent);
+	struct f2fs_sb_info *sbi = parent->cache->sbi;
 	struct blk_plug plug;
 	int i, end;
 	nid_t nid;
@@ -693,7 +684,7 @@ static void f2fs_ra_node_pages(struct folio *parent, int start, int n)
 	end = min_t(int, end, NIDS_PER_BLOCK(sbi));
 	for (i = start; i < end; i++) {
 		nid = get_nid(sbi, parent, i, false);
-		f2fs_ra_node_page(sbi, nid);
+		f2fs_ra_node_cache(sbi, nid);
 	}
 
 	blk_finish_plug(&plug);
@@ -814,7 +805,8 @@ static int get_node_path(struct inode *inode, long block,
 	return level;
 }
 
-static struct folio *f2fs_get_node_folio_ra(struct folio *parent, int start);
+static struct f2fs_cached_block *f2fs_get_node_cache_ra(
+		struct f2fs_cached_block *parent, int start);
 
 /*
  * Caller should call f2fs_put_dnode(dn).
@@ -824,8 +816,8 @@ static struct folio *f2fs_get_node_folio_ra(struct folio *parent, int start);
 int f2fs_get_dnode_of_data(struct dnode_of_data *dn, pgoff_t index, int mode)
 {
 	struct f2fs_sb_info *sbi = F2FS_I_SB(dn->inode);
-	struct folio *nfolio[4];
-	struct folio *parent = NULL;
+	struct f2fs_cached_block *nentry[4];
+	struct f2fs_cached_block *parent = NULL;
 	int offset[4];
 	unsigned int noffset[4];
 	nid_t nids[4];
@@ -838,26 +830,26 @@ int f2fs_get_dnode_of_data(struct dnode_of_data *dn, pgoff_t index, int mode)
 
 	nids[0] = dn->inode->i_ino;
 
-	if (!dn->inode_folio) {
-		nfolio[0] = f2fs_get_inode_folio(sbi, nids[0]);
-		if (IS_ERR(nfolio[0]))
-			return PTR_ERR(nfolio[0]);
+	if (!dn->inode_entry) {
+		nentry[0] = f2fs_get_inode_cache(sbi, nids[0]);
+		if (IS_ERR(nentry[0]))
+			return PTR_ERR(nentry[0]);
 	} else {
-		nfolio[0] = dn->inode_folio;
+		nentry[0] = dn->inode_entry;
 	}
 
 	/* if inline_data is set, should not report any block indices */
 	if (f2fs_has_inline_data(dn->inode) && index) {
 		err = -ENOENT;
-		f2fs_folio_put(nfolio[0], true);
+		f2fs_put_cache(nentry[0], true);
 		goto release_out;
 	}
 
-	parent = nfolio[0];
+	parent = nentry[0];
 	if (level != 0)
 		nids[1] = get_nid(sbi, parent, offset[0], true);
-	dn->inode_folio = nfolio[0];
-	dn->inode_folio_locked = true;
+	dn->inode_entry = nentry[0];
+	dn->inode_entry_locked = true;
 
 	/* get indirect or direct nodes */
 	for (i = 1; i <= level; i++) {
@@ -870,59 +862,59 @@ int f2fs_get_dnode_of_data(struct dnode_of_data *dn, pgoff_t index, int mode)
 				"ino:%llu, nid:%u, level:%d, offset:%d",
 				dn->inode->i_ino, nids[i], level, offset[level]);
 			set_sbi_flag(sbi, SBI_NEED_FSCK);
-			goto release_pages;
+			goto release_caches;
 		}
 
 		if (!nids[i] && mode == ALLOC_NODE) {
 			/* alloc new node */
 			if (!f2fs_alloc_nid(sbi, &(nids[i]))) {
 				err = -ENOSPC;
-				goto release_pages;
+				goto release_caches;
 			}
 
 			dn->nid = nids[i];
-			nfolio[i] = f2fs_new_node_folio(dn, noffset[i]);
-			if (IS_ERR(nfolio[i])) {
+			nentry[i] = f2fs_new_node_cache(dn, noffset[i]);
+			if (IS_ERR(nentry[i])) {
 				f2fs_alloc_nid_failed(sbi, nids[i]);
-				err = PTR_ERR(nfolio[i]);
-				goto release_pages;
+				err = PTR_ERR(nentry[i]);
+				goto release_caches;
 			}
 
 			set_nid(sbi, parent, offset[i - 1], nids[i], i == 1);
 			f2fs_alloc_nid_done(sbi, nids[i]);
 			done = true;
 		} else if (mode == LOOKUP_NODE_RA && i == level && level > 1) {
-			nfolio[i] = f2fs_get_node_folio_ra(parent, offset[i - 1]);
-			if (IS_ERR(nfolio[i])) {
-				err = PTR_ERR(nfolio[i]);
-				goto release_pages;
+			nentry[i] = f2fs_get_node_cache_ra(parent, offset[i - 1]);
+			if (IS_ERR(nentry[i])) {
+				err = PTR_ERR(nentry[i]);
+				goto release_caches;
 			}
 			done = true;
 		}
 		if (i == 1) {
-			dn->inode_folio_locked = false;
-			folio_unlock(parent);
+			dn->inode_entry_locked = false;
+			f2fs_unlock_cache(parent);
 		} else {
-			f2fs_folio_put(parent, true);
+			f2fs_put_cache(parent, true);
 		}
 
 		if (!done) {
-			nfolio[i] = f2fs_get_node_folio(sbi, nids[i],
+			nentry[i] = f2fs_get_node_cache(sbi, nids[i],
 						NODE_TYPE_NON_INODE);
-			if (IS_ERR(nfolio[i])) {
-				err = PTR_ERR(nfolio[i]);
-				f2fs_folio_put(nfolio[0], false);
+			if (IS_ERR(nentry[i])) {
+				err = PTR_ERR(nentry[i]);
+				f2fs_put_cache(nentry[0], false);
 				goto release_out;
 			}
 		}
 		if (i < level) {
-			parent = nfolio[i];
+			parent = nentry[i];
 			nids[i + 1] = get_nid(sbi, parent, offset[i], false);
 		}
 	}
 	dn->nid = nids[level];
 	dn->ofs_in_node = offset[level];
-	dn->node_folio = nfolio[level];
+	dn->node_entry = nentry[level];
 	dn->data_blkaddr = f2fs_data_blkaddr(dn);
 
 	if (is_inode_flag_set(dn->inode, FI_COMPRESSED_FILE) &&
@@ -943,9 +935,9 @@ int f2fs_get_dnode_of_data(struct dnode_of_data *dn, pgoff_t index, int mode)
 		if (!c_len)
 			goto out;
 
-		blkaddr = data_blkaddr(dn->inode, dn->node_folio, ofs_in_node);
+		blkaddr = data_blkaddr(dn->inode, dn->node_entry, ofs_in_node);
 		if (blkaddr == COMPRESS_ADDR)
-			blkaddr = data_blkaddr(dn->inode, dn->node_folio,
+			blkaddr = data_blkaddr(dn->inode, dn->node_entry,
 						ofs_in_node + 1);
 
 		f2fs_update_read_extent_tree_range_compressed(dn->inode,
@@ -954,13 +946,13 @@ int f2fs_get_dnode_of_data(struct dnode_of_data *dn, pgoff_t index, int mode)
 out:
 	return 0;
 
-release_pages:
-	f2fs_folio_put(parent, true);
+release_caches:
+	f2fs_put_cache(parent, true);
 	if (i > 1)
-		f2fs_folio_put(nfolio[0], false);
+		f2fs_put_cache(nentry[0], false);
 release_out:
-	dn->inode_folio = NULL;
-	dn->node_folio = NULL;
+	dn->inode_entry = NULL;
+	dn->node_entry = NULL;
 	if (err == -ENOENT) {
 		dn->cur_level = i;
 		dn->max_level = level;
@@ -1001,16 +993,15 @@ static int truncate_node(struct dnode_of_data *dn)
 		f2fs_inode_synced(dn->inode);
 	}
 
-	clear_node_folio_dirty(dn->node_folio);
+	f2fs_drop_cache_dirty(dn->node_entry);
 	set_sbi_flag(sbi, SBI_IS_DIRTY);
 
-	index = dn->node_folio->index;
-	f2fs_folio_put(dn->node_folio, true);
+	index = dn->node_entry->index;
+	f2fs_put_cache(dn->node_entry, true);
 
-	invalidate_mapping_pages(NODE_MAPPING(sbi),
-			index, index);
+	f2fs_invalidate_node_cache(sbi, index);
 
-	dn->node_folio = NULL;
+	dn->node_entry = NULL;
 	trace_f2fs_truncate_node(dn->inode, dn->nid, ni.blk_addr);
 
 	return 0;
@@ -1019,35 +1010,35 @@ static int truncate_node(struct dnode_of_data *dn)
 static int truncate_dnode(struct dnode_of_data *dn)
 {
 	struct f2fs_sb_info *sbi = F2FS_I_SB(dn->inode);
-	struct folio *folio;
+	struct f2fs_cached_block *entry;
 	int err;
 
 	if (dn->nid == 0)
 		return 1;
 
 	/* get direct node */
-	folio = f2fs_get_node_folio(sbi, dn->nid, NODE_TYPE_NON_INODE);
-	if (PTR_ERR(folio) == -ENOENT)
+	entry = f2fs_get_node_cache(sbi, dn->nid, NODE_TYPE_NON_INODE);
+	if (PTR_ERR(entry) == -ENOENT)
 		return 1;
-	else if (IS_ERR(folio))
-		return PTR_ERR(folio);
+	else if (IS_ERR(entry))
+		return PTR_ERR(entry);
 
-	if (IS_INODE(sbi, folio) || ino_of_node(sbi, folio) != dn->inode->i_ino) {
+	if (IS_INODE(sbi, entry) || ino_of_node(sbi, entry) != dn->inode->i_ino) {
 		f2fs_err(sbi, "incorrect node reference, ino: %llu, nid: %u, ino_of_node: %u",
-				dn->inode->i_ino, dn->nid, ino_of_node(sbi, folio));
+				dn->inode->i_ino, dn->nid, ino_of_node(sbi, entry));
 		set_sbi_flag(sbi, SBI_NEED_FSCK);
 		f2fs_handle_error(sbi, ERROR_INVALID_NODE_REFERENCE);
-		f2fs_folio_put(folio, true);
+		f2fs_put_cache(entry, true);
 		return -EFSCORRUPTED;
 	}
 
 	/* Make dnode_of_data for parameter */
-	dn->node_folio = folio;
+	dn->node_entry = entry;
 	dn->ofs_in_node = 0;
 	f2fs_truncate_data_blocks_range(dn, ADDRS_PER_BLOCK(dn->inode));
 	err = truncate_node(dn);
 	if (err) {
-		f2fs_folio_put(folio, true);
+		f2fs_put_cache(entry, true);
 		return err;
 	}
 
@@ -1059,7 +1050,7 @@ static int truncate_nodes(struct dnode_of_data *dn, unsigned int nofs,
 {
 	struct f2fs_sb_info *sbi = F2FS_I_SB(dn->inode);
 	struct dnode_of_data rdn = *dn;
-	struct folio *folio;
+	struct f2fs_cached_block *entry;
 	struct f2fs_node *rn;
 	nid_t child_nid;
 	unsigned int child_nofs;
@@ -1071,16 +1062,16 @@ static int truncate_nodes(struct dnode_of_data *dn, unsigned int nofs,
 
 	trace_f2fs_truncate_nodes_enter(dn->inode, dn->nid, dn->data_blkaddr);
 
-	folio = f2fs_get_node_folio(F2FS_I_SB(dn->inode), dn->nid,
+	entry = f2fs_get_node_cache(F2FS_I_SB(dn->inode), dn->nid,
 						NODE_TYPE_NON_INODE);
-	if (IS_ERR(folio)) {
-		trace_f2fs_truncate_nodes_exit(dn->inode, PTR_ERR(folio));
-		return PTR_ERR(folio);
+	if (IS_ERR(entry)) {
+		trace_f2fs_truncate_nodes_exit(dn->inode, PTR_ERR(entry));
+		return PTR_ERR(entry);
 	}
 
-	f2fs_ra_node_pages(folio, ofs, NIDS_PER_BLOCK(sbi));
+	f2fs_ra_node_caches(entry, ofs, NIDS_PER_BLOCK(sbi));
 
-	rn = F2FS_NODE(folio);
+	rn = CACHED_NODE(entry);
 	if (depth < 3) {
 		for (i = ofs; i < NIDS_PER_BLOCK(sbi); i++, freed++) {
 			child_nid = le32_to_cpu(rn->in.nid[i]);
@@ -1090,7 +1081,7 @@ static int truncate_nodes(struct dnode_of_data *dn, unsigned int nofs,
 			ret = truncate_dnode(&rdn);
 			if (ret < 0)
 				goto out_err;
-			if (set_nid(sbi, folio, i, 0, false))
+			if (set_nid(sbi, entry, i, 0, false))
 				dn->node_changed = true;
 		}
 	} else {
@@ -1104,7 +1095,7 @@ static int truncate_nodes(struct dnode_of_data *dn, unsigned int nofs,
 			rdn.nid = child_nid;
 			ret = truncate_nodes(&rdn, child_nofs, 0, depth - 1);
 			if (ret == (NIDS_PER_BLOCK(sbi) + 1)) {
-				if (set_nid(sbi, folio, i, 0, false))
+				if (set_nid(sbi, entry, i, 0, false))
 					dn->node_changed = true;
 				child_nofs += ret;
 			} else if (ret < 0 && ret != -ENOENT) {
@@ -1116,19 +1107,19 @@ static int truncate_nodes(struct dnode_of_data *dn, unsigned int nofs,
 
 	if (!ofs) {
 		/* remove current indirect node */
-		dn->node_folio = folio;
+		dn->node_entry = entry;
 		ret = truncate_node(dn);
 		if (ret)
 			goto out_err;
 		freed++;
 	} else {
-		f2fs_folio_put(folio, true);
+		f2fs_put_cache(entry, true);
 	}
 	trace_f2fs_truncate_nodes_exit(dn->inode, freed);
 	return freed;
 
 out_err:
-	f2fs_folio_put(folio, true);
+	f2fs_put_cache(entry, true);
 	trace_f2fs_truncate_nodes_exit(dn->inode, ret);
 	return ret;
 }
@@ -1136,63 +1127,62 @@ static int truncate_nodes(struct dnode_of_data *dn, unsigned int nofs,
 static int truncate_partial_nodes(struct dnode_of_data *dn,
 			int *offset, int depth)
 {
-	struct f2fs_sb_info *sbi = F2FS_I_SB(dn->inode);
-	struct folio *folios[2];
+	struct f2fs_cached_block *entries[2];
 	nid_t nid[3];
 	nid_t child_nid;
 	int err = 0;
 	int i;
 	int idx = depth - 2;
 
-	nid[0] = get_nid(sbi, dn->inode_folio, offset[0], true);
+	nid[0] = get_nid(F2FS_I_SB(dn->inode), dn->inode_entry, offset[0], true);
 	if (!nid[0])
 		return 0;
 
 	/* get indirect nodes in the path */
 	for (i = 0; i < idx + 1; i++) {
 		/* reference count'll be increased */
-		folios[i] = f2fs_get_node_folio(F2FS_I_SB(dn->inode), nid[i],
+		entries[i] = f2fs_get_node_cache(F2FS_I_SB(dn->inode), nid[i],
 							NODE_TYPE_NON_INODE);
-		if (IS_ERR(folios[i])) {
-			err = PTR_ERR(folios[i]);
+		if (IS_ERR(entries[i])) {
+			err = PTR_ERR(entries[i]);
 			idx = i - 1;
 			goto fail;
 		}
-		nid[i + 1] = get_nid(sbi, folios[i], offset[i + 1], false);
+		nid[i + 1] = get_nid(F2FS_I_SB(dn->inode), entries[i], offset[i + 1], false);
 	}
 
-	f2fs_ra_node_pages(folios[idx], offset[idx + 1],
+	f2fs_ra_node_caches(entries[idx], offset[idx + 1],
 			   NIDS_PER_BLOCK(F2FS_I_SB(dn->inode)));
 
 	/* free direct nodes linked to a partial indirect node */
 	for (i = offset[idx + 1];
 			i < NIDS_PER_BLOCK(F2FS_I_SB(dn->inode)); i++) {
-		child_nid = get_nid(sbi, folios[idx], i, false);
+		child_nid = get_nid(F2FS_I_SB(dn->inode), entries[idx], i, false);
 		if (!child_nid)
 			continue;
 		dn->nid = child_nid;
 		err = truncate_dnode(dn);
 		if (err < 0)
 			goto fail;
-		if (set_nid(sbi, folios[idx], i, 0, false))
+		if (set_nid(F2FS_I_SB(dn->inode), entries[idx], i, 0, false))
 			dn->node_changed = true;
 	}
 
 	if (offset[idx + 1] == 0) {
-		dn->node_folio = folios[idx];
+		dn->node_entry = entries[idx];
 		dn->nid = nid[idx];
 		err = truncate_node(dn);
 		if (err)
 			goto fail;
 	} else {
-		f2fs_folio_put(folios[idx], true);
+		f2fs_put_cache(entries[idx], true);
 	}
 	offset[idx]++;
 	offset[idx + 1] = 0;
 	idx--;
 fail:
 	for (i = idx; i >= 0; i--)
-		f2fs_folio_put(folios[i], true);
+		f2fs_put_cache(entries[i], true);
 
 	trace_f2fs_truncate_partial_nodes(dn->inode, nid, depth, err);
 
@@ -1211,7 +1201,7 @@ int f2fs_truncate_inode_blocks(struct inode *inode, pgoff_t from)
 	int level, offset[4], noffset[4];
 	unsigned int nofs = 0;
 	struct dnode_of_data dn;
-	struct folio *folio;
+	struct f2fs_cached_block *entry;
 
 	trace_f2fs_truncate_inode_blocks_enter(inode, from);
 
@@ -1228,14 +1218,14 @@ int f2fs_truncate_inode_blocks(struct inode *inode, pgoff_t from)
 		return level;
 	}
 
-	folio = f2fs_get_inode_folio(sbi, inode->i_ino);
-	if (IS_ERR(folio)) {
-		trace_f2fs_truncate_inode_blocks_exit(inode, PTR_ERR(folio));
-		return PTR_ERR(folio);
+	entry = f2fs_get_inode_cache(sbi, inode->i_ino);
+	if (IS_ERR(entry)) {
+		trace_f2fs_truncate_inode_blocks_exit(inode, PTR_ERR(entry));
+		return PTR_ERR(entry);
 	}
 
-	set_new_dnode(&dn, inode, folio, NULL, 0);
-	folio_unlock(folio);
+	set_new_dnode(&dn, inode, entry, NULL, 0);
+	f2fs_unlock_cache(entry);
 
 	switch (level) {
 	case 0:
@@ -1265,7 +1255,7 @@ int f2fs_truncate_inode_blocks(struct inode *inode, pgoff_t from)
 
 skip_partial:
 	while (cont) {
-		dn.nid = get_nid(sbi, folio, offset[0], true);
+		dn.nid = get_nid(sbi, entry, offset[0], true);
 		if (offset[0] == NODE_DIR1_BLOCK(sbi) ||
 		    offset[0] == NODE_DIR2_BLOCK(sbi)) {
 			err = truncate_dnode(&dn);
@@ -1292,42 +1282,42 @@ int f2fs_truncate_inode_blocks(struct inode *inode, pgoff_t from)
 		}
 		if (err < 0)
 			goto fail;
-		if (offset[1] == 0 && get_nid(sbi, folio, offset[0], true)) {
-			folio_lock(folio);
-			BUG_ON(!is_node_folio(sbi, folio));
-			set_nid(sbi, folio, offset[0], 0, true);
-			folio_unlock(folio);
+		if (offset[1] == 0 && get_nid(sbi, entry, offset[0], true)) {
+			f2fs_lock_cache(entry);
+			f2fs_bug_on(sbi, !f2fs_is_node_cache(entry));
+			set_nid(sbi, entry, offset[0], 0, true);
+			f2fs_unlock_cache(entry);
 		}
 		offset[1] = 0;
 		offset[0]++;
 		nofs += err;
 	}
 fail:
-	f2fs_folio_put(folio, false);
+	f2fs_put_cache(entry, false);
 	trace_f2fs_truncate_inode_blocks_exit(inode, err);
 	return err > 0 ? 0 : err;
 }
 
-/* caller must lock inode page */
+/* caller must lock inode cached block */
 int f2fs_truncate_xattr_node(struct inode *inode)
 {
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
 	nid_t nid = F2FS_I(inode)->i_xattr_nid;
 	struct dnode_of_data dn;
-	struct folio *nfolio;
+	struct f2fs_cached_block *nentry;
 	int err;
 
 	if (!nid)
 		return 0;
 
-	nfolio = f2fs_get_xnode_folio(sbi, nid);
-	if (IS_ERR(nfolio))
-		return PTR_ERR(nfolio);
+	nentry = f2fs_get_xnode_cache(sbi, nid);
+	if (IS_ERR(nentry))
+		return PTR_ERR(nentry);
 
-	set_new_dnode(&dn, inode, NULL, nfolio, nid);
+	set_new_dnode(&dn, inode, NULL, nentry, nid);
 	err = truncate_node(&dn);
 	if (err) {
-		f2fs_folio_put(nfolio, true);
+		f2fs_put_cache(nentry, true);
 		return err;
 	}
 
@@ -1340,7 +1330,7 @@ int f2fs_truncate_xattr_node(struct inode *inode)
  * Caller should grab and release a rwsem by calling f2fs_lock_op() and
  * f2fs_unlock_op().
  */
-int f2fs_remove_inode_page(struct inode *inode)
+int f2fs_remove_inode_cache(struct inode *inode)
 {
 	struct dnode_of_data dn;
 	int err;
@@ -1370,12 +1360,12 @@ int f2fs_remove_inode_page(struct inode *inode)
 
 	if (unlikely(inode->i_blocks != 0 && inode->i_blocks != 8)) {
 		f2fs_warn(F2FS_I_SB(inode),
-			"f2fs_remove_inode_page: inconsistent i_blocks, ino:%llu, iblocks:%llu",
+			"f2fs_remove_inode_cache: inconsistent i_blocks, ino:%llu, iblocks:%llu",
 			inode->i_ino, (unsigned long long)inode->i_blocks);
 		set_sbi_flag(F2FS_I_SB(inode), SBI_NEED_FSCK);
 	}
 
-	/* will put inode & node pages */
+	/* will put inode & node cached blocks */
 	err = truncate_node(&dn);
 	if (err) {
 		f2fs_put_dnode(&dn);
@@ -1384,30 +1374,30 @@ int f2fs_remove_inode_page(struct inode *inode)
 	return 0;
 }
 
-struct folio *f2fs_new_inode_folio(struct inode *inode)
+struct f2fs_cached_block *f2fs_new_inode_cache(struct inode *inode)
 {
 	struct dnode_of_data dn;
 
-	/* allocate inode page for new inode */
+	/* allocate inode block for new inode */
 	set_new_dnode(&dn, inode, NULL, NULL, inode->i_ino);
 
-	/* caller should f2fs_folio_put(folio, true); */
-	return f2fs_new_node_folio(&dn, 0);
+	/* caller should f2fs_put_cache(entry, true); */
+	return f2fs_new_node_cache(&dn, 0);
 }
 
-struct folio *f2fs_new_node_folio(struct dnode_of_data *dn, unsigned int ofs)
+struct f2fs_cached_block *f2fs_new_node_cache(struct dnode_of_data *dn, unsigned int ofs)
 {
 	struct f2fs_sb_info *sbi = F2FS_I_SB(dn->inode);
 	struct node_info new_ni;
-	struct folio *folio;
+	struct f2fs_cached_block *entry;
 	int err;
 
 	if (unlikely(is_inode_flag_set(dn->inode, FI_NO_ALLOC)))
 		return ERR_PTR(-EPERM);
 
-	folio = f2fs_grab_cache_folio(NODE_MAPPING(sbi), dn->nid, false);
-	if (IS_ERR(folio))
-		return folio;
+	entry = f2fs_grab_node_cache(sbi, dn->nid);
+	if (IS_ERR(entry))
+		return entry;
 
 	if (unlikely((err = inc_valid_node_count(sbi, dn->inode, !ofs))))
 		goto fail;
@@ -1423,7 +1413,7 @@ struct folio *f2fs_new_node_folio(struct dnode_of_data *dn, unsigned int ofs)
 		dec_valid_node_count(sbi, dn->inode, !ofs);
 		set_sbi_flag(sbi, SBI_NEED_FSCK);
 		f2fs_warn_ratelimited(sbi,
-			"f2fs_new_node_folio: inconsistent nat entry, "
+			"f2fs_new_node_cache: inconsistent nat entry, "
 			"ino:%u, nid:%u, blkaddr:%u, ver:%u, flag:%u",
 			new_ni.ino, new_ni.nid, new_ni.blk_addr,
 			new_ni.version, new_ni.flag);
@@ -1438,12 +1428,11 @@ struct folio *f2fs_new_node_folio(struct dnode_of_data *dn, unsigned int ofs)
 	new_ni.version = 0;
 	set_node_addr(sbi, &new_ni, NEW_ADDR, false);
 
-	f2fs_folio_wait_writeback(folio, NODE, true, true);
-	fill_node_footer(sbi, folio, dn->nid, dn->inode->i_ino, ofs, true);
-	set_cold_node(sbi, folio, S_ISDIR(dn->inode->i_mode));
-	if (!folio_test_uptodate(folio))
-		folio_mark_uptodate(folio);
-	if (folio_mark_dirty(folio))
+	f2fs_cache_wait_writeback(entry);
+	fill_node_footer(sbi, entry, dn->nid, dn->inode->i_ino, ofs, true);
+	set_cold_node(sbi, entry, S_ISDIR(dn->inode->i_mode));
+	f2fs_cache_set_uptodate(entry);
+	if (f2fs_mark_cache_dirty(entry))
 		dn->node_changed = true;
 
 	if (f2fs_has_xattr_block(ofs))
@@ -1451,54 +1440,54 @@ struct folio *f2fs_new_node_folio(struct dnode_of_data *dn, unsigned int ofs)
 
 	if (ofs == 0)
 		inc_valid_inode_count(sbi);
-	return folio;
+	return entry;
 fail:
-	clear_node_folio_dirty(folio);
-	f2fs_folio_put(folio, true);
+	f2fs_drop_cache_dirty(entry);
+	f2fs_put_cache(entry, true);
 	return ERR_PTR(err);
 }
 
 /*
  * Caller should do after getting the following values.
- * 0: f2fs_folio_put(folio, false)
- * LOCKED_PAGE or error: f2fs_folio_put(folio, true)
+ * 0: f2fs_put_cache(cache, false)
+ * LOCKED_CACHE or error: f2fs_put_cache(entry, true)
  */
-static int read_node_folio(struct folio *folio, blk_opf_t op_flags)
+static int read_node_cache(struct f2fs_cached_block *entry, blk_opf_t op_flags)
 {
-	struct f2fs_sb_info *sbi = F2FS_F_SB(folio);
+	struct f2fs_sb_info *sbi = entry->cache->sbi;
 	struct node_info ni;
 	struct f2fs_io_info fio = {
 		.sbi = sbi,
 		.type = NODE,
 		.op = REQ_OP_READ,
 		.op_flags = op_flags,
-		.folio = folio,
 		.encrypted_page = NULL,
+		.cache_entry = entry,
+		.is_cache = 1,
 	};
 	int err;
 
-	if (folio_test_uptodate(folio)) {
-		if (!f2fs_inode_chksum_verify(sbi, folio)) {
-			folio_clear_uptodate(folio);
+	if (f2fs_cache_test_uptodate(entry)) {
+		if (!f2fs_inode_chksum_verify(sbi, entry)) {
+			f2fs_cache_clear_uptodate(entry);
 			return -EFSBADCRC;
 		}
-		return LOCKED_PAGE;
+		return LOCKED_CACHE;
 	}
 
-	err = f2fs_get_node_info(sbi, folio->index, &ni, false);
+	err = f2fs_get_node_info(sbi, entry->index, &ni, false);
 	if (err)
 		return err;
 
-	/* NEW_ADDR can be seen, after cp_error drops some dirty node pages */
+	/* NEW_ADDR can be seen, after cp_error drops some dirty node caches */
 	if (unlikely(ni.blk_addr == NULL_ADDR || ni.blk_addr == NEW_ADDR)) {
-		folio_clear_uptodate(folio);
+		f2fs_cache_clear_uptodate(entry);
 		return -ENOENT;
 	}
 
 	fio.new_blkaddr = fio.old_blkaddr = ni.blk_addr;
 
-	err = f2fs_submit_page_bio(&fio);
-
+	err = f2fs_submit_cache_read(&fio);
 	if (!err)
 		f2fs_update_iostat(sbi, NULL, FS_NODE_READ_IO,
 				   F2FS_BLKSIZE(sbi));
@@ -1507,11 +1496,11 @@ static int read_node_folio(struct folio *folio, blk_opf_t op_flags)
 }
 
 /*
- * Readahead a node page
+ * Readahead a node cache
  */
-void f2fs_ra_node_page(struct f2fs_sb_info *sbi, nid_t nid)
+void f2fs_ra_node_cache(struct f2fs_sb_info *sbi, nid_t nid)
 {
-	struct folio *afolio;
+	struct f2fs_cached_block *entry;
 	int err;
 
 	if (!nid)
@@ -1519,29 +1508,29 @@ void f2fs_ra_node_page(struct f2fs_sb_info *sbi, nid_t nid)
 	if (f2fs_check_nid_range(sbi, nid))
 		return;
 
-	afolio = xa_load(&NODE_MAPPING(sbi)->i_pages, nid);
-	if (afolio)
+	entry = xa_load(&NODE_CACHE(sbi)->root, nid);
+	if (entry)
 		return;
 
-	afolio = f2fs_grab_cache_folio(NODE_MAPPING(sbi), nid, false);
-	if (IS_ERR(afolio))
+	entry = f2fs_grab_node_cache(sbi, nid);
+	if (IS_ERR(entry))
 		return;
 
-	err = read_node_folio(afolio, REQ_RAHEAD);
-	f2fs_folio_put(afolio, err ? true : false);
+	err = read_node_cache(entry, REQ_RAHEAD);
+	f2fs_put_cache(entry, err ? true : false);
 }
 
 int f2fs_sanity_check_node_footer(struct f2fs_sb_info *sbi,
-					struct folio *folio, pgoff_t nid,
+					struct f2fs_cached_block *entry, pgoff_t nid,
 					enum node_type ntype, bool in_irq)
 {
 	bool is_inode, is_xnode;
 
-	if (unlikely(nid != nid_of_node(sbi, folio)))
+	if (unlikely(nid != nid_of_node(sbi, entry)))
 		goto out_err;
 
-	is_inode = IS_INODE(sbi, folio);
-	is_xnode = f2fs_has_xattr_block(ofs_of_node(sbi, folio));
+	is_inode = IS_INODE(sbi, entry);
+	is_xnode = f2fs_has_xattr_block(ofs_of_node(sbi, entry));
 
 	switch (ntype) {
 	case NODE_TYPE_REGULAR:
@@ -1574,20 +1563,20 @@ int f2fs_sanity_check_node_footer(struct f2fs_sb_info *sbi,
 	set_sbi_flag(sbi, SBI_NEED_FSCK);
 	f2fs_warn_ratelimited(sbi, "inconsistent node block, node_type:%d, nid:%lu, "
 		"node_footer[nid:%u,ino:%u,ofs:%u,cpver:%llu,blkaddr:%u]",
-		ntype, nid, nid_of_node(sbi, folio), ino_of_node(sbi, folio),
-		ofs_of_node(sbi, folio), cpver_of_node(sbi, folio),
-		next_blkaddr_of_node(sbi, folio));
+		ntype, nid, nid_of_node(sbi, entry), ino_of_node(sbi, entry),
+		ofs_of_node(sbi, entry), cpver_of_node(sbi, entry),
+		next_blkaddr_of_node(sbi, entry));
 
 	f2fs_handle_error(sbi, ERROR_INCONSISTENT_FOOTER);
-	fserror_report_file_metadata(folio->mapping->host,
-			-EFSCORRUPTED, in_irq ? GFP_NOWAIT : GFP_NOFS);
+	fserror_report_metadata(sbi->sb, -EFSCORRUPTED,
+				in_irq ? GFP_NOWAIT : GFP_NOFS);
 	return -EFSCORRUPTED;
 }
 
-static struct folio *__get_node_folio(struct f2fs_sb_info *sbi, pgoff_t nid,
-		struct folio *parent, int start, enum node_type ntype)
+static struct f2fs_cached_block *__get_node_cache(struct f2fs_sb_info *sbi, pgoff_t nid,
+		struct f2fs_cached_block *parent, int start, enum node_type ntype)
 {
-	struct folio *folio;
+	struct f2fs_cached_block *entry;
 	int err;
 
 	if (!nid)
@@ -1595,71 +1584,71 @@ static struct folio *__get_node_folio(struct f2fs_sb_info *sbi, pgoff_t nid,
 	if (f2fs_check_nid_range(sbi, nid))
 		return ERR_PTR(-EINVAL);
 repeat:
-	folio = f2fs_grab_cache_folio(NODE_MAPPING(sbi), nid, false);
-	if (IS_ERR(folio))
-		return folio;
+	entry = f2fs_grab_node_cache(sbi, nid);
+	if (IS_ERR(entry))
+		return entry;
 
-	err = read_node_folio(folio, 0);
+	err = read_node_cache(entry, 0);
 	if (err < 0)
 		goto out_put_err;
-	if (err == LOCKED_PAGE)
-		goto page_hit;
+	if (err == LOCKED_CACHE)
+		goto entry_hit;
 
 	if (parent)
-		f2fs_ra_node_pages(parent, start + 1, MAX_RA_NODE);
+		f2fs_ra_node_caches(parent, start + 1, MAX_RA_NODE);
 
-	folio_lock(folio);
+	f2fs_lock_cache(entry);
 
-	if (unlikely(!is_node_folio(sbi, folio))) {
-		f2fs_folio_put(folio, true);
+	if (unlikely(!f2fs_is_node_cache(entry))) {
+		f2fs_put_cache(entry, true);
 		goto repeat;
 	}
 
-	if (unlikely(!folio_test_uptodate(folio))) {
+	if (unlikely(!f2fs_cache_test_uptodate(entry))) {
 		err = -EIO;
 		goto out_put_err;
 	}
 
-	if (!f2fs_inode_chksum_verify(sbi, folio)) {
+	if (!f2fs_inode_chksum_verify(sbi, entry)) {
 		err = -EFSBADCRC;
 		goto out_err;
 	}
-page_hit:
-	err = f2fs_sanity_check_node_footer(sbi, folio, nid, ntype, false);
+entry_hit:
+	err = f2fs_sanity_check_node_footer(sbi, entry, nid, ntype, false);
 	if (!err)
-		return folio;
+		return entry;
 out_err:
-	clear_node_folio_dirty(folio);
+	f2fs_drop_cache_dirty(entry);
 out_put_err:
 	/* ENOENT comes from read_node_folio which is not an error. */
 	if (err != -ENOENT)
-		f2fs_handle_page_eio(sbi, folio->index, NODE);
-	f2fs_folio_put(folio, true);
+		f2fs_handle_page_eio(sbi, entry->index, NODE);
+	f2fs_put_cache(entry, true);
 	return ERR_PTR(err);
 }
 
-struct folio *f2fs_get_node_folio(struct f2fs_sb_info *sbi, pgoff_t nid,
+struct f2fs_cached_block *f2fs_get_node_cache(struct f2fs_sb_info *sbi, pgoff_t nid,
 						enum node_type node_type)
 {
-	return __get_node_folio(sbi, nid, NULL, 0, node_type);
+	return __get_node_cache(sbi, nid, NULL, 0, node_type);
 }
 
-struct folio *f2fs_get_inode_folio(struct f2fs_sb_info *sbi, pgoff_t ino)
+struct f2fs_cached_block *f2fs_get_inode_cache(struct f2fs_sb_info *sbi, pgoff_t ino)
 {
-	return __get_node_folio(sbi, ino, NULL, 0, NODE_TYPE_INODE);
+	return __get_node_cache(sbi, ino, NULL, 0, NODE_TYPE_INODE);
 }
 
-struct folio *f2fs_get_xnode_folio(struct f2fs_sb_info *sbi, pgoff_t xnid)
+struct f2fs_cached_block *f2fs_get_xnode_cache(struct f2fs_sb_info *sbi, pgoff_t xnid)
 {
-	return __get_node_folio(sbi, xnid, NULL, 0, NODE_TYPE_XATTR);
+	return __get_node_cache(sbi, xnid, NULL, 0, NODE_TYPE_XATTR);
 }
 
-static struct folio *f2fs_get_node_folio_ra(struct folio *parent, int start)
+static struct f2fs_cached_block *f2fs_get_node_cache_ra(struct f2fs_cached_block *parent, int start)
 {
-	struct f2fs_sb_info *sbi = F2FS_F_SB(parent);
+	struct f2fs_sb_info *sbi = parent->cache->sbi;
 	nid_t nid = get_nid(sbi, parent, start, false);
 
-	return __get_node_folio(sbi, nid, parent, start, NODE_TYPE_NON_IXNODE);
+	return __get_node_cache(sbi, nid, parent, start, NODE_TYPE_NON_IXNODE);
 }
 
 static void flush_inline_data(struct f2fs_sb_info *sbi, nid_t ino)
@@ -1698,110 +1687,106 @@ static void flush_inline_data(struct f2fs_sb_info *sbi, nid_t ino)
 	iput(inode);
 }
 
-static struct folio *last_fsync_dnode(struct f2fs_sb_info *sbi, nid_t ino)
+static struct f2fs_cached_block *last_fsync_dnode(struct f2fs_sb_info *sbi, nid_t ino)
 {
-	pgoff_t index;
-	struct folio_batch fbatch;
-	struct folio *last_folio = NULL;
-	int nr_folios;
-
-	folio_batch_init(&fbatch);
-	index = 0;
+	pgoff_t index = 0;
+	struct f2fs_cached_block *entries[F2FS_ONSTACK_CACHES];
+	struct f2fs_cached_block *last_entry = NULL;
+	unsigned int nr;
 
-	while ((nr_folios = filemap_get_folios_tag(NODE_MAPPING(sbi), &index,
-					(pgoff_t)-1, PAGECACHE_TAG_DIRTY,
-					&fbatch))) {
+	while ((nr = f2fs_cache_gang_lookup_tag(NODE_CACHE(sbi),
+				entries, &index, F2FS_ONSTACK_CACHES,
+				F2FS_CACHE_TAG_DIRTY))) {
 		int i;
 
-		for (i = 0; i < nr_folios; i++) {
-			struct folio *folio = fbatch.folios[i];
+		for (i = 0; i < nr; i++) {
+			struct f2fs_cached_block *entry = entries[i];
 
 			if (unlikely(f2fs_cp_error(sbi))) {
-				f2fs_folio_put(last_folio, false);
-				folio_batch_release(&fbatch);
+				f2fs_put_cache(last_entry, false);
+				f2fs_cache_gang_release(entries, nr);
 				return ERR_PTR(-EIO);
 			}
 
-			if (!IS_DNODE(sbi, folio) || !is_cold_node(sbi, folio))
+			if (!IS_DNODE(sbi, entry) || !is_cold_node(sbi, entry))
 				continue;
-			if (ino_of_node(sbi, folio) != ino)
+			if (ino_of_node(sbi, entry) != ino)
 				continue;
 
-			folio_lock(folio);
+			f2fs_lock_cache(entry);
 
-			if (unlikely(!is_node_folio(sbi, folio))) {
+			if (unlikely(!f2fs_is_node_cache(entry))) {
 continue_unlock:
-				folio_unlock(folio);
+				f2fs_unlock_cache(entry);
 				continue;
 			}
-			if (ino_of_node(sbi, folio) != ino)
+			if (ino_of_node(sbi, entry) != ino)
 				goto continue_unlock;
 
-			if (!folio_test_dirty(folio)) {
+			if (!f2fs_cache_test_dirty(entry)) {
 				/* someone wrote it for us */
 				goto continue_unlock;
 			}
 
-			if (last_folio)
-				f2fs_folio_put(last_folio, false);
+			if (last_entry)
+				f2fs_put_cache(last_entry, false);
 
-			folio_get(folio);
-			last_folio = folio;
-			folio_unlock(folio);
+			f2fs_cache_get(entry);
+			last_entry = entry;
+			f2fs_unlock_cache(entry);
 		}
-		folio_batch_release(&fbatch);
+		f2fs_cache_gang_release(entries, nr);
 		cond_resched();
 	}
-	return last_folio;
+	return last_entry;
 }
 
-static bool __write_node_folio(struct folio *folio, bool atomic, bool do_fsync,
-				bool *submitted, struct writeback_control *wbc,
-				bool do_balance, enum iostat_type io_type,
-				unsigned int *seq_id)
+static bool __write_node_cache(struct f2fs_cached_block *entry,
+				bool atomic, bool do_fsync, bool *submitted,
+				bool sync, bool do_balance,
+				enum iostat_type io_type, unsigned int *seq_id)
 {
-	struct f2fs_sb_info *sbi = F2FS_F_SB(folio);
+	struct f2fs_sb_info *sbi = entry->cache->sbi;
 	nid_t nid;
 	struct node_info ni;
 	struct f2fs_io_info fio = {
 		.sbi = sbi,
-		.ino = ino_of_node(sbi, folio),
+		.ino = ino_of_node(sbi, entry),
 		.type = NODE,
 		.op = REQ_OP_WRITE,
-		.op_flags = wbc_to_write_flags(wbc),
-		.folio = folio,
+		.op_flags = sync ? REQ_SYNC : REQ_BACKGROUND,
+		.cache_entry = entry,
 		.encrypted_page = NULL,
 		.submitted = 0,
 		.io_type = io_type,
-		.io_wbc = wbc,
+		.is_cache = true,
 	};
 	struct f2fs_lock_context lc;
 	unsigned int seq;
 
-	trace_f2fs_writepage(folio, NODE);
-
 	if (unlikely(f2fs_cp_error(sbi))) {
-		/* keep node pages in remount-ro mode */
+		/* keep node caches in remount-ro mode */
 		if (F2FS_OPTION(sbi).errors == MOUNT_ERRORS_READONLY)
 			goto redirty_out;
-		folio_clear_uptodate(folio);
-		dec_page_count(sbi, F2FS_DIRTY_NODES);
-		folio_unlock(folio);
+		f2fs_cache_clear_uptodate(entry);
+		f2fs_cache_update_tag(entry, F2FS_CACHE_TAG_DIRTY,
+					F2FS_CACHE_TAG_NONE);
+		dec_page_count(entry->cache->sbi, F2FS_DIRTY_NODES);
+		f2fs_unlock_cache(entry);
 		return true;
 	}
 
 	if (unlikely(is_sbi_flag_set(sbi, SBI_POR_DOING)))
 		goto redirty_out;
 
-	if (!is_sbi_flag_set(sbi, SBI_CP_DISABLED) &&
-			wbc->sync_mode == WB_SYNC_NONE &&
-			IS_DNODE(sbi, folio) && is_cold_node(sbi, folio))
+	if (!is_sbi_flag_set(sbi, SBI_CP_DISABLED) && !sync &&
+			IS_DNODE(sbi, entry) && is_cold_node(sbi, entry))
 		goto redirty_out;
 
-	/* get old block addr of this node page */
-	nid = nid_of_node(sbi, folio);
+	/* get old block addr of this node cache */
+	nid = nid_of_node(sbi, entry);
 
-	if (f2fs_sanity_check_node_footer(sbi, folio, folio->index,
+	if (f2fs_sanity_check_node_footer(sbi, entry, entry->index,
 					NODE_TYPE_REGULAR, false)) {
 		fserror_report_metadata(sbi->sb, -EFSCORRUPTED, GFP_NOFS);
 		f2fs_stop_checkpoint(sbi, false, STOP_CP_REASON_CORRUPTED_NID);
@@ -1813,12 +1798,14 @@ static bool __write_node_folio(struct folio *folio, bool atomic, bool do_fsync,
 
 	f2fs_down_read_trace(&sbi->node_write, &lc);
 
-	/* This page is already truncated */
+	/* This cache is already truncated */
 	if (unlikely(ni.blk_addr == NULL_ADDR)) {
-		folio_clear_uptodate(folio);
-		dec_page_count(sbi, F2FS_DIRTY_NODES);
+		f2fs_cache_clear_uptodate(entry);
+		f2fs_cache_update_tag(entry, F2FS_CACHE_TAG_DIRTY,
+					F2FS_CACHE_TAG_NONE);
+		dec_page_count(entry->cache->sbi, F2FS_DIRTY_NODES);
 		f2fs_up_read_trace(&sbi->node_write, &lc);
-		folio_unlock(folio);
+		f2fs_unlock_cache(entry);
 		return true;
 	}
 
@@ -1832,28 +1819,28 @@ static bool __write_node_folio(struct folio *folio, bool atomic, bool do_fsync,
 	if (atomic && !test_opt(sbi, NOBARRIER))
 		fio.op_flags |= REQ_PREFLUSH | REQ_FUA;
 
-	set_dentry_mark(sbi, folio, false);
-	set_fsync_mark(sbi, folio, do_fsync);
-	if (IS_INODE(sbi, folio) && (atomic || is_fsync_dnode(sbi, folio)))
-		set_dentry_mark(sbi, folio,
-				f2fs_need_dentry_mark(sbi, ino_of_node(sbi, folio)));
+	set_dentry_mark(sbi, entry, false);
+	set_fsync_mark(sbi, entry, do_fsync);
+	if (IS_INODE(sbi, entry) && (atomic || is_fsync_dnode(sbi, entry)))
+		set_dentry_mark(sbi, entry,
+			f2fs_need_dentry_mark(sbi, ino_of_node(sbi, entry)));
 
-	/* should add to global list before clearing PAGECACHE status */
-	if (f2fs_in_warm_node_list(sbi, folio)) {
-		seq = f2fs_add_fsync_node_entry(sbi, folio);
+	/* should add to global list before clearing CACHE status */
+	if (f2fs_in_warm_node_list(sbi, entry)) {
+		seq = f2fs_add_fsync_node_entry(sbi, entry);
 		if (seq_id)
 			*seq_id = seq;
 	}
 
-	folio_start_writeback(folio);
+	f2fs_start_cache_writeback(entry);
 
 	fio.old_blkaddr = ni.blk_addr;
-	f2fs_do_write_node_page(nid, &fio);
-	set_node_addr(sbi, &ni, fio.new_blkaddr, is_fsync_dnode(sbi, folio));
+	f2fs_do_write_node_cache(nid, &fio);
+	set_node_addr(sbi, &ni, fio.new_blkaddr, is_fsync_dnode(sbi, entry));
 	dec_page_count(sbi, F2FS_DIRTY_NODES);
 	f2fs_up_read_trace(&sbi->node_write, &lc);
 
-	folio_unlock(folio);
+	f2fs_unlock_cache(entry);
 
 	if (unlikely(f2fs_cp_error(sbi))) {
 		f2fs_submit_merged_write(sbi, NODE);
@@ -1867,176 +1854,171 @@ static bool __write_node_folio(struct folio *folio, bool atomic, bool do_fsync,
 	return true;
 
 redirty_out:
-	folio_redirty_for_writepage(wbc, folio);
-	folio_unlock(folio);
+	f2fs_cache_set_dirty(entry);
+	f2fs_unlock_cache(entry);
 	return false;
 }
 
-int f2fs_write_single_node_folio(struct folio *node_folio, int sync_mode,
+int f2fs_write_node_cache(struct f2fs_cached_block *node_entry, int sync_mode,
 			bool mark_dirty, enum iostat_type io_type)
 {
 	int err = 0;
-	struct writeback_control wbc = {
-		.sync_mode = WB_SYNC_ALL,
-		.nr_to_write = 1,
-	};
 
 	if (!sync_mode) {
-		/* set page dirty and write it */
-		if (!folio_test_writeback(node_folio))
-			folio_mark_dirty(node_folio);
-		goto out_folio;
+		/* set cache dirty and write it */
+		if (!f2fs_cache_test_writeback(node_entry))
+			f2fs_mark_cache_dirty(node_entry);
+		goto out_entry;
 	}
 
-	f2fs_folio_wait_writeback(node_folio, NODE, true, true);
+	f2fs_cache_wait_writeback(node_entry);
 
 	if (mark_dirty)
-		folio_mark_dirty(node_folio);
-	else if (!folio_test_dirty(node_folio))
-		goto out_folio;
+		f2fs_mark_cache_dirty(node_entry);
+	else if (!f2fs_cache_test_dirty(node_entry))
+		goto out_entry;
 
-	if (!folio_clear_dirty_for_io(node_folio)) {
+	if (!f2fs_cache_test_and_clear_dirty(node_entry)) {
 		err = -EAGAIN;
-		goto out_folio;
+		goto out_entry;
 	}
 
-	if (!__write_node_folio(node_folio, false, false, NULL,
-				&wbc, false, io_type, NULL))
+	if (!__write_node_cache(node_entry, false, false, NULL,
+				true, false, io_type, NULL))
 		err = -EAGAIN;
-	goto release_folio;
-out_folio:
-	folio_unlock(node_folio);
-release_folio:
-	f2fs_folio_put(node_folio, false);
+	goto release_entry;
+out_entry:
+	f2fs_unlock_cache(node_entry);
+release_entry:
+	f2fs_put_cache(node_entry, false);
 	return err;
 }
 
-int f2fs_move_node_folio(struct folio *node_folio, int gc_type)
+int f2fs_move_node_cache(struct f2fs_cached_block *entry, int gc_type)
 {
-	return f2fs_write_single_node_folio(node_folio, gc_type == FG_GC,
+	return f2fs_write_node_cache(entry, gc_type == FG_GC,
 			true, FS_GC_NODE_IO);
 }
 
-int f2fs_fsync_node_pages(struct f2fs_sb_info *sbi, struct inode *inode,
-			struct writeback_control *wbc, bool atomic,
-			unsigned int *seq_id)
+int f2fs_fsync_node_caches(struct f2fs_sb_info *sbi, struct inode *inode,
+					bool atomic, unsigned int *seq_id)
 {
 	pgoff_t index;
-	struct folio_batch fbatch;
+	struct f2fs_cached_block *entries[F2FS_ONSTACK_CACHES];
 	int ret = 0;
-	struct folio *last_folio = NULL;
+	struct f2fs_cached_block *last_entry = NULL;
 	bool marked = false;
 	nid_t ino = inode->i_ino;
-	int nr_folios;
+	int nr;
 	int nwritten = 0;
 
 	if (atomic) {
-		last_folio = last_fsync_dnode(sbi, ino);
-		if (IS_ERR_OR_NULL(last_folio))
-			return PTR_ERR_OR_ZERO(last_folio);
+		last_entry = last_fsync_dnode(sbi, ino);
+		if (IS_ERR_OR_NULL(last_entry))
+			return PTR_ERR_OR_ZERO(last_entry);
 	}
 retry:
-	folio_batch_init(&fbatch);
 	index = 0;
 
-	while ((nr_folios = filemap_get_folios_tag(NODE_MAPPING(sbi), &index,
-					(pgoff_t)-1, PAGECACHE_TAG_DIRTY,
-					&fbatch))) {
+	while ((nr = f2fs_cache_gang_lookup_tag(NODE_CACHE(sbi),
+				entries, &index, F2FS_ONSTACK_CACHES,
+				F2FS_CACHE_TAG_DIRTY))) {
 		int i;
 
-		for (i = 0; i < nr_folios; i++) {
-			struct folio *folio = fbatch.folios[i];
+		for (i = 0; i < nr; i++) {
+			struct f2fs_cached_block *entry = entries[i];
 			bool submitted = false;
 			bool do_fsync = false;
 
 			if (unlikely(f2fs_cp_error(sbi))) {
-				f2fs_folio_put(last_folio, false);
-				folio_batch_release(&fbatch);
+				f2fs_put_cache(last_entry, false);
+				f2fs_cache_gang_release(entries, nr);
 				ret = -EIO;
 				goto out;
 			}
 
-			if (!IS_DNODE(sbi, folio) || !is_cold_node(sbi, folio))
+			if (!IS_DNODE(sbi, entry) || !is_cold_node(sbi, entry))
 				continue;
-			if (ino_of_node(sbi, folio) != ino)
+			if (ino_of_node(sbi, entry) != ino)
 				continue;
 
-			folio_lock(folio);
+			f2fs_lock_cache(entry);
 
-			if (unlikely(!is_node_folio(sbi, folio))) {
+			if (unlikely(!f2fs_is_node_cache(entry))) {
 continue_unlock:
-				folio_unlock(folio);
+				f2fs_unlock_cache(entry);
 				continue;
 			}
-			if (ino_of_node(sbi, folio) != ino)
+			if (ino_of_node(sbi, entry) != ino)
 				goto continue_unlock;
 
-			if (!folio_test_dirty(folio) && folio != last_folio) {
+			if (!f2fs_cache_test_dirty(entry) && entry != last_entry) {
 				/* someone wrote it for us */
 				goto continue_unlock;
 			}
 
-			f2fs_folio_wait_writeback(folio, NODE, true, true);
+			f2fs_cache_wait_writeback(entry);
 
-			if (!atomic || folio == last_folio) {
+			if (!atomic || entry == last_entry) {
 				do_fsync = true;
 				percpu_counter_inc(&sbi->rf_node_block_count);
-				if (IS_INODE(sbi, folio)) {
+				if (IS_INODE(sbi, entry)) {
 					if (is_inode_flag_set(inode,
 								FI_DIRTY_INODE))
-						f2fs_update_inode(inode, folio);
+						f2fs_update_inode(inode, entry);
 				}
 				/* may be written by other thread */
-				if (!folio_test_dirty(folio))
-					folio_mark_dirty(folio);
+				if (!f2fs_cache_test_dirty(entry))
+					f2fs_mark_cache_dirty(entry);
 			}
 
-			if (!folio_clear_dirty_for_io(folio))
+			if (!f2fs_cache_test_and_clear_dirty(entry))
 				goto continue_unlock;
 
-			if (!__write_node_folio(folio, atomic &&
-						folio == last_folio,
+			if (!__write_node_cache(entry, atomic &&
+						entry == last_entry,
 						do_fsync, &submitted,
-						wbc, true, FS_NODE_IO,
+						true, true, FS_NODE_IO,
 						seq_id)) {
-				f2fs_folio_put(last_folio, false);
-				folio_batch_release(&fbatch);
+				f2fs_put_cache(last_entry, false);
+				f2fs_cache_gang_release(entries, nr);
 				ret = -EIO;
 				goto out;
 			}
 			if (submitted)
 				nwritten++;
 
-			if (folio == last_folio) {
-				f2fs_folio_put(folio, false);
-				folio_batch_release(&fbatch);
+			if (entry == last_entry) {
+				f2fs_put_cache(entry, false);
+				f2fs_cache_gang_release(entries, nr);
 				marked = true;
 				goto out;
 			}
 		}
-		folio_batch_release(&fbatch);
+		f2fs_cache_gang_release(entries, nr);
 		cond_resched();
 	}
 	if (atomic && !marked) {
 		f2fs_debug(sbi, "Retry to write fsync mark: ino=%u, idx=%lx",
-			   ino, last_folio->index);
-		folio_lock(last_folio);
-		if (unlikely(!is_node_folio(sbi, last_folio))) {
-			f2fs_folio_put(last_folio, true);
+			   ino, last_entry->index);
+		f2fs_lock_cache(last_entry);
+		if (unlikely(!f2fs_is_node_cache(last_entry))) {
+			f2fs_put_cache(last_entry, true);
 			ret = -EAGAIN;
 			goto out;
 		}
-		f2fs_folio_wait_writeback(last_folio, NODE, true, true);
-		folio_mark_dirty(last_folio);
-		folio_unlock(last_folio);
+		f2fs_cache_wait_writeback(last_entry);
+		f2fs_mark_cache_dirty(last_entry);
+		f2fs_unlock_cache(last_entry);
 		goto retry;
 	}
 out:
 	if (nwritten)
-		f2fs_submit_merged_write_cond(sbi, NULL, NULL, ino, NODE);
+		f2fs_submit_merged_write_cache(sbi, NULL, ino, NODE);
 	return ret;
 }
 
+
 static int f2fs_match_ino(struct inode *inode, u64 ino, void *data)
 {
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
@@ -2061,18 +2043,18 @@ static int f2fs_match_ino(struct inode *inode, u64 ino, void *data)
 	return 1;
 }
 
-static bool flush_dirty_inode(struct folio *folio)
+static bool flush_dirty_cache_inode(struct f2fs_cached_block *entry)
 {
-	struct f2fs_sb_info *sbi = F2FS_F_SB(folio);
+	struct f2fs_sb_info *sbi = entry->cache->sbi;
 	struct inode *inode;
-	nid_t ino = ino_of_node(sbi, folio);
+	nid_t ino = ino_of_node(sbi, entry);
 
 	inode = find_inode_nowait(sbi->sb, ino, f2fs_match_ino, NULL);
 	if (!inode)
 		return false;
 
-	f2fs_update_inode(inode, folio);
-	folio_unlock(folio);
+	f2fs_update_inode(inode, entry);
+	f2fs_unlock_cache(entry);
 
 	iput(inode);
 	return true;
@@ -2081,72 +2063,72 @@ static bool flush_dirty_inode(struct folio *folio)
 void f2fs_flush_inline_data(struct f2fs_sb_info *sbi)
 {
 	pgoff_t index = 0;
-	struct folio_batch fbatch;
-	int nr_folios;
-
-	folio_batch_init(&fbatch);
+	struct f2fs_cached_block *entries[F2FS_ONSTACK_CACHES];
+	unsigned int nr;
 
-	while ((nr_folios = filemap_get_folios_tag(NODE_MAPPING(sbi), &index,
-					(pgoff_t)-1, PAGECACHE_TAG_DIRTY,
-					&fbatch))) {
+	while ((nr = f2fs_cache_gang_lookup_tag(NODE_CACHE(sbi),
+				entries, &index, F2FS_ONSTACK_CACHES,
+				F2FS_CACHE_TAG_DIRTY))) {
 		int i;
 
-		for (i = 0; i < nr_folios; i++) {
-			struct folio *folio = fbatch.folios[i];
+		for (i = 0; i < nr; i++) {
+			struct f2fs_cached_block *entry = entries[i];
 
-			if (!IS_INODE(sbi, folio))
-				continue;
-
-			folio_lock(folio);
+			f2fs_lock_cache(entry);
 
-			if (unlikely(!is_node_folio(sbi, folio)))
+			if (unlikely(!f2fs_is_node_cache(entry)))
 				goto unlock;
-			if (!folio_test_dirty(folio))
+			if (!IS_INODE(sbi, entry))
+				goto unlock;
+			if (!f2fs_cache_test_dirty(entry))
 				goto unlock;
 
 			/* flush inline_data, if it's async context. */
-			if (folio_test_f2fs_inline(folio)) {
-				folio_clear_f2fs_inline(folio);
-				folio_unlock(folio);
-				flush_inline_data(sbi, ino_of_node(sbi, folio));
+			if (f2fs_cache_test_inline(entry)) {
+				nid_t ino = ino_of_node(sbi, entry);
+
+				f2fs_cache_clear_inline(entry);
+				f2fs_unlock_cache(entry);
+				flush_inline_data(sbi, ino);
 				continue;
 			}
 unlock:
-			folio_unlock(folio);
+			f2fs_unlock_cache(entry);
 		}
-		folio_batch_release(&fbatch);
+		f2fs_cache_gang_release(entries, nr);
 		cond_resched();
 	}
 }
 
-int f2fs_sync_node_pages(struct f2fs_sb_info *sbi,
-				struct writeback_control *wbc,
-				bool do_balance, enum iostat_type io_type)
+int f2fs_writeback_node_caches(struct f2fs_sb_info *sbi, long nr_to_write,
+			bool sync, bool do_balance, enum iostat_type io_type)
 {
 	pgoff_t index;
-	struct folio_batch fbatch;
+	struct f2fs_cached_block *entries[F2FS_ONSTACK_CACHES];
 	int step = 0;
 	int nwritten = 0;
 	int ret = 0;
-	int nr_folios, done = 0;
-
-	folio_batch_init(&fbatch);
+	int nr, done = 0;
 
 next_step:
 	index = 0;
 
-	while (!done && (nr_folios = filemap_get_folios_tag(NODE_MAPPING(sbi),
-				&index, (pgoff_t)-1, PAGECACHE_TAG_DIRTY,
-				&fbatch))) {
+	while (!done && (nr = f2fs_cache_gang_lookup_tag(NODE_CACHE(sbi),
+				entries, &index, F2FS_ONSTACK_CACHES,
+				F2FS_CACHE_TAG_DIRTY))) {
 		int i;
 
-		for (i = 0; i < nr_folios; i++) {
-			struct folio *folio = fbatch.folios[i];
+		for (i = 0; i < nr; i++) {
+			struct f2fs_cached_block *entry = entries[i];
 			bool submitted = false;
 
+			if (!sync && unlikely(freezing(current))) {
+				done = 1;
+				break;
+			}
+
 			/* give a priority to WB_SYNC threads */
-			if (atomic_read(&sbi->wb_sync_req[NODE]) &&
-					wbc->sync_mode == WB_SYNC_NONE) {
+			if (atomic_read(&sbi->wb_sync_req[NODE]) && !sync) {
 				done = 1;
 				break;
 			}
@@ -2157,27 +2139,27 @@ int f2fs_sync_node_pages(struct f2fs_sb_info *sbi,
 			 * 1. dentry dnodes
 			 * 2. file dnodes
 			 */
-			if (step == 0 && IS_DNODE(sbi, folio))
+			if (step == 0 && IS_DNODE(sbi, entry))
 				continue;
-			if (step == 1 && (!IS_DNODE(sbi, folio) ||
-						is_cold_node(sbi, folio)))
+			if (step == 1 && (!IS_DNODE(sbi, entry) ||
+						is_cold_node(sbi, entry)))
 				continue;
-			if (step == 2 && (!IS_DNODE(sbi, folio) ||
-						!is_cold_node(sbi, folio)))
+			if (step == 2 && (!IS_DNODE(sbi, entry) ||
+						!is_cold_node(sbi, entry)))
 				continue;
 lock_node:
-			if (wbc->sync_mode == WB_SYNC_ALL)
-				folio_lock(folio);
-			else if (!folio_trylock(folio))
+			if (sync)
+				f2fs_lock_cache(entry);
+			else if (!f2fs_trylock_cache(entry))
 				continue;
 
-			if (unlikely(!is_node_folio(sbi, folio))) {
+			if (unlikely(!f2fs_is_node_cache(entry))) {
 continue_unlock:
-				folio_unlock(folio);
+				f2fs_unlock_cache(entry);
 				continue;
 			}
 
-			if (!folio_test_dirty(folio)) {
+			if (!f2fs_cache_test_dirty(entry)) {
 				/* someone wrote it for us */
 				goto continue_unlock;
 			}
@@ -2187,38 +2169,38 @@ int f2fs_sync_node_pages(struct f2fs_sb_info *sbi,
 				goto write_node;
 
 			/* flush inline_data */
-			if (folio_test_f2fs_inline(folio)) {
-				folio_clear_f2fs_inline(folio);
-				folio_unlock(folio);
-				flush_inline_data(sbi, ino_of_node(sbi, folio));
+			if (f2fs_cache_test_inline(entry)) {
+				f2fs_cache_clear_inline(entry);
+				f2fs_unlock_cache(entry);
+				flush_inline_data(sbi, ino_of_node(sbi, entry));
 				goto lock_node;
 			}
 
 			/* flush dirty inode */
-			if (IS_INODE(sbi, folio) && flush_dirty_inode(folio))
+			if (IS_INODE(sbi, entry) && flush_dirty_cache_inode(entry))
 				goto lock_node;
 write_node:
-			f2fs_folio_wait_writeback(folio, NODE, true, true);
+			f2fs_cache_wait_writeback(entry);
 
-			if (!folio_clear_dirty_for_io(folio))
+			if (!f2fs_cache_test_and_clear_dirty(entry))
 				goto continue_unlock;
 
-			if (!__write_node_folio(folio, false, false, &submitted,
-					wbc, do_balance, io_type, NULL)) {
-				folio_batch_release(&fbatch);
+			if (!__write_node_cache(entry, false, false, &submitted,
+					sync, do_balance, io_type, NULL)) {
+				f2fs_cache_gang_release(entries, nr);
 				ret = -EIO;
 				goto out;
 			}
 			if (submitted)
 				nwritten++;
 
-			if (--wbc->nr_to_write == 0)
+			if (--nr_to_write == 0)
 				break;
 		}
-		folio_batch_release(&fbatch);
+		f2fs_cache_gang_release(entries, nr);
 		cond_resched();
 
-		if (wbc->nr_to_write == 0) {
+		if (nr_to_write == 0) {
 			step = 2;
 			break;
 		}
@@ -2226,7 +2208,7 @@ int f2fs_sync_node_pages(struct f2fs_sb_info *sbi,
 
 	if (step < 2) {
 		if (!is_sbi_flag_set(sbi, SBI_CP_DISABLED) &&
-				wbc->sync_mode == WB_SYNC_NONE && step == 1)
+				!sync && step == 1)
 			goto out;
 		step++;
 		goto next_step;
@@ -2240,7 +2222,7 @@ int f2fs_sync_node_pages(struct f2fs_sb_info *sbi,
 	return ret;
 }
 
-int f2fs_wait_on_node_pages_writeback(struct f2fs_sb_info *sbi,
+int f2fs_wait_on_node_caches_writeback(struct f2fs_sb_info *sbi,
 						unsigned int seq_id)
 {
 	struct fsync_node_entry *fn;
@@ -2249,7 +2231,7 @@ int f2fs_wait_on_node_pages_writeback(struct f2fs_sb_info *sbi,
 	unsigned int cur_seq_id = 0;
 
 	while (seq_id && cur_seq_id < seq_id) {
-		struct folio *folio;
+		struct f2fs_cached_block *entry;
 
 		spin_lock_irqsave(&sbi->fsync_node_lock, flags);
 		if (list_empty(head)) {
@@ -2262,94 +2244,49 @@ int f2fs_wait_on_node_pages_writeback(struct f2fs_sb_info *sbi,
 			break;
 		}
 		cur_seq_id = fn->seq_id;
-		folio = fn->folio;
-		folio_get(folio);
+		entry = fn->entry;
+		f2fs_cache_get(entry);
 		spin_unlock_irqrestore(&sbi->fsync_node_lock, flags);
 
-		f2fs_folio_wait_writeback(folio, NODE, true, false);
+		f2fs_lock_cache(entry);
+		f2fs_cache_wait_writeback(entry);
 
-		folio_put(folio);
+		f2fs_put_cache(entry, true);
 	}
 
-	return filemap_check_errors(NODE_MAPPING(sbi));
+	return f2fs_cp_error(sbi) ? -EIO : 0;
 }
 
-static int f2fs_write_node_pages(struct address_space *mapping,
-			    struct writeback_control *wbc)
+int f2fs_write_node_caches(struct f2fs_sb_info *sbi)
 {
-	struct f2fs_sb_info *sbi = F2FS_M_SB(mapping);
 	struct blk_plug plug;
-	long diff;
+	long nr_to_write = LONG_MAX;
 
 	if (unlikely(is_sbi_flag_set(sbi, SBI_POR_DOING)))
-		goto skip_write;
+		return -EAGAIN;
 
 	/* balancing f2fs's metadata in background */
 	f2fs_balance_fs_bg(sbi, true);
 
-	/* collect a number of dirty node pages and write together */
-	if (wbc->sync_mode != WB_SYNC_ALL &&
-			get_pages(sbi, F2FS_DIRTY_NODES) <
+	/* collect a number of dirty node caches and write together */
+	if (get_pages(sbi, F2FS_DIRTY_NODES) <
 					nr_pages_to_skip(sbi, NODE))
-		goto skip_write;
+		return -EAGAIN;
 
-	if (wbc->sync_mode == WB_SYNC_ALL)
-		atomic_inc(&sbi->wb_sync_req[NODE]);
-	else if (atomic_read(&sbi->wb_sync_req[NODE])) {
+	if (atomic_read(&sbi->wb_sync_req[NODE])) {
 		/* to avoid potential deadlock */
 		if (current->plug)
 			blk_finish_plug(current->plug);
-		goto skip_write;
+		return -EAGAIN;
 	}
 
-	trace_f2fs_writepages(mapping->host, wbc, NODE);
-
-	diff = nr_pages_to_write(sbi, NODE, wbc);
+	nr_to_write = adjust_flush_cache_number(sbi, NODE);
 	blk_start_plug(&plug);
-	f2fs_sync_node_pages(sbi, wbc, true, FS_NODE_IO);
+	f2fs_writeback_node_caches(sbi, nr_to_write, false, true, FS_NODE_IO);
 	blk_finish_plug(&plug);
-	wbc->nr_to_write = max((long)0, wbc->nr_to_write - diff);
-
-	if (wbc->sync_mode == WB_SYNC_ALL)
-		atomic_dec(&sbi->wb_sync_req[NODE]);
-	return 0;
-
-skip_write:
-	wbc->pages_skipped += get_pages(sbi, F2FS_DIRTY_NODES);
-	trace_f2fs_writepages(mapping->host, wbc, NODE);
 	return 0;
 }
 
-static bool f2fs_dirty_node_folio(struct address_space *mapping,
-		struct folio *folio)
-{
-	trace_f2fs_set_page_dirty(folio, NODE);
-
-	if (!folio_test_uptodate(folio))
-		folio_mark_uptodate(folio);
-#ifdef CONFIG_F2FS_CHECK_FS
-	if (IS_INODE(F2FS_M_SB(mapping), folio))
-		f2fs_inode_chksum_set(F2FS_M_SB(mapping), folio);
-#endif
-	if (filemap_dirty_folio(mapping, folio)) {
-		inc_page_count(F2FS_M_SB(mapping), F2FS_DIRTY_NODES);
-		folio_set_f2fs_reference(folio);
-		return true;
-	}
-	return false;
-}
-
-/*
- * Structure of the f2fs node operations
- */
-const struct address_space_operations f2fs_node_aops = {
-	.writepages	= f2fs_write_node_pages,
-	.dirty_folio	= f2fs_dirty_node_folio,
-	.invalidate_folio = f2fs_invalidate_folio,
-	.release_folio	= f2fs_release_folio,
-	.migrate_folio	= filemap_migrate_folio,
-};
-
 static struct free_nid *__lookup_free_nid_list(struct f2fs_nm_info *nm_i,
 						nid_t n)
 {
@@ -2850,12 +2787,12 @@ int f2fs_recover_inline_xattr(struct inode *inode, struct f2fs_cached_block *ent
 {
 	void *src_addr, *dst_addr;
 	size_t inline_size;
-	struct folio *ifolio;
+	struct f2fs_cached_block *ientry;
 	struct f2fs_inode *ri;
 
-	ifolio = f2fs_get_inode_folio(F2FS_I_SB(inode), inode->i_ino);
-	if (IS_ERR(ifolio))
-		return PTR_ERR(ifolio);
+	ientry = f2fs_get_inode_cache(F2FS_I_SB(inode), inode->i_ino);
+	if (IS_ERR(ientry))
+		return PTR_ERR(ientry);
 
 	ri = &CACHED_NODE(entry)->i;
 	if (ri->i_inline & F2FS_INLINE_XATTR) {
@@ -2871,15 +2808,15 @@ int f2fs_recover_inline_xattr(struct inode *inode, struct f2fs_cached_block *ent
 		goto update_inode;
 	}
 
-	dst_addr = inline_xattr_addr(inode, ifolio);
-	src_addr = inline_xattr_addr(inode, cache_folio(entry));
+	dst_addr = inline_xattr_addr(inode, ientry);
+	src_addr = inline_xattr_addr(inode, entry);
 	inline_size = inline_xattr_size(inode);
 
-	f2fs_folio_wait_writeback(ifolio, NODE, true, true);
+	f2fs_cache_wait_writeback(ientry);
 	memcpy(dst_addr, src_addr, inline_size);
 update_inode:
-	f2fs_update_inode(inode, ifolio);
-	f2fs_folio_put(ifolio, true);
+	f2fs_update_inode(inode, ientry);
+	f2fs_put_cache(ientry, true);
 	return 0;
 }
 
@@ -2890,7 +2827,7 @@ int f2fs_recover_xattr_data(struct inode *inode, struct f2fs_cached_block *entry
 	nid_t new_xnid;
 	struct dnode_of_data dn;
 	struct node_info ni;
-	struct folio *xfolio;
+	struct f2fs_cached_block *xentry;
 	int err;
 
 	if (!prev_xnid)
@@ -2911,32 +2848,33 @@ int f2fs_recover_xattr_data(struct inode *inode, struct f2fs_cached_block *entry
 		return -ENOSPC;
 
 	set_new_dnode(&dn, inode, NULL, NULL, new_xnid);
-	xfolio = f2fs_new_node_folio(&dn, XATTR_NODE_OFFSET);
-	if (IS_ERR(xfolio)) {
+	xentry = f2fs_new_node_cache(&dn, XATTR_NODE_OFFSET);
+	if (IS_ERR(xentry)) {
 		f2fs_alloc_nid_failed(sbi, new_xnid);
-		return PTR_ERR(xfolio);
+		return PTR_ERR(xentry);
 	}
 
 	f2fs_alloc_nid_done(sbi, new_xnid);
-	f2fs_update_inode_page(inode);
+	f2fs_update_inode_cache(inode);
 
-	/* 3: update and set xattr node page dirty */
+	/* 3: update and set xattr node cache dirty */
 	if (entry) {
-		memcpy(F2FS_NODE(xfolio), CACHED_NODE(entry),
+		memcpy(CACHED_NODE(xentry), CACHED_NODE(entry),
 				VALID_XATTR_BLOCK_SIZE(inode));
-		folio_mark_dirty(xfolio);
+		f2fs_mark_cache_dirty(xentry);
 	}
-	f2fs_folio_put(xfolio, true);
+	f2fs_put_cache(xentry, true);
 
 	return 0;
 }
 
-int f2fs_recover_inode_page(struct f2fs_sb_info *sbi, struct f2fs_cached_block *entry)
+int f2fs_recover_inode_cache(struct f2fs_sb_info *sbi,
+				struct f2fs_cached_block *entry)
 {
 	struct f2fs_inode *src, *dst;
-	nid_t ino = ino_of_node(sbi, cache_folio(entry));
+	nid_t ino = ino_of_node(sbi, entry);
 	struct node_info old_ni, new_ni;
-	struct folio *ifolio;
+	struct f2fs_cached_block *ientry;
 	int err;
 
 	err = f2fs_get_node_info(sbi, ino, &old_ni, false);
@@ -2946,8 +2884,8 @@ int f2fs_recover_inode_page(struct f2fs_sb_info *sbi, struct f2fs_cached_block *
 	if (unlikely(old_ni.blk_addr != NULL_ADDR))
 		return -EINVAL;
 retry:
-	ifolio = f2fs_grab_cache_folio(NODE_MAPPING(sbi), ino, false);
-	if (IS_ERR(ifolio)) {
+	ientry = f2fs_grab_node_cache(sbi, ino);
+	if (IS_ERR(ientry)) {
 		memalloc_retry_wait(GFP_NOFS);
 		goto retry;
 	}
@@ -2955,13 +2893,12 @@ int f2fs_recover_inode_page(struct f2fs_sb_info *sbi, struct f2fs_cached_block *
 	/* Should not use this inode from free nid list */
 	remove_free_nid(sbi, ino);
 
-	if (!folio_test_uptodate(ifolio))
-		folio_mark_uptodate(ifolio);
-	fill_node_footer(sbi, ifolio, ino, ino, 0, true);
-	set_cold_node(sbi, ifolio, false);
+	f2fs_cache_set_uptodate(ientry);
+	fill_node_footer(sbi, ientry, ino, ino, 0, true);
+	set_cold_node(sbi, ientry, false);
 
 	src = &CACHED_NODE(entry)->i;
-	dst = F2FS_INODE(ifolio);
+	dst = F2FS_INODE(ientry);
 
 	memcpy(dst, src, offsetof(struct f2fs_inode, i_ext));
 	dst->i_size = 0;
@@ -2997,8 +2934,8 @@ int f2fs_recover_inode_page(struct f2fs_sb_info *sbi, struct f2fs_cached_block *
 		WARN_ON(1);
 	set_node_addr(sbi, &new_ni, NEW_ADDR, false);
 	inc_valid_inode_count(sbi);
-	folio_mark_dirty(ifolio);
-	f2fs_folio_put(ifolio, true);
+	f2fs_mark_cache_dirty(ientry);
+	f2fs_put_cache(ientry, true);
 	return 0;
 }
 
@@ -3027,7 +2964,9 @@ int f2fs_restore_node_summary(struct f2fs_sb_info *sbi,
 			if (IS_ERR(entry))
 				return PTR_ERR(entry);
 
-			sum_entry->nid = F2FS_NODE_FOOTER(sbi, cache_folio(entry))->nid;
+			struct node_footer *footer = (struct node_footer *)(cache_address(entry) +
+				F2FS_BLKSIZE(sbi) - sizeof(struct node_footer));
+			sum_entry->nid = footer->nid;
 			sum_entry->version = 0;
 			sum_entry->ofs_in_node = 0;
 			sum_entry++;
diff --git a/fs/f2fs/node.h b/fs/f2fs/node.h
index e37fb0d63120..c8d66ca54e94 100644
--- a/fs/f2fs/node.h
+++ b/fs/f2fs/node.h
@@ -44,8 +44,8 @@ static inline nid_t f2fs_start_nid(struct f2fs_sb_info *sbi, nid_t nid)
 /* vector size for gang look-up from nat cache that consists of radix tree */
 #define NAT_VEC_SIZE	32
 
-/* return value for read_node_page */
-#define LOCKED_PAGE	1
+/* return value for read_node_cache */
+#define LOCKED_CACHE	1
 
 /* check pinned file's alignment status of physical blocks */
 #define FILE_NOT_ALIGNED	1
@@ -249,42 +249,42 @@ static inline void set_to_next_nat(struct f2fs_sb_info *sbi,
 }
 
 static inline nid_t ino_of_node(struct f2fs_sb_info *sbi,
-				const struct folio *node_folio)
+				const struct f2fs_cached_block *entry)
 {
-	return le32_to_cpu(F2FS_NODE_FOOTER(sbi, node_folio)->ino);
+	return le32_to_cpu(F2FS_NODE_FOOTER(sbi, entry)->ino);
 }
 
 static inline nid_t nid_of_node(struct f2fs_sb_info *sbi,
-				const struct folio *node_folio)
+				const struct f2fs_cached_block *entry)
 {
-	return le32_to_cpu(F2FS_NODE_FOOTER(sbi, node_folio)->nid);
+	return le32_to_cpu(F2FS_NODE_FOOTER(sbi, entry)->nid);
 }
 
 static inline unsigned int ofs_of_node(struct f2fs_sb_info *sbi,
-				const struct folio *node_folio)
+				const struct f2fs_cached_block *entry)
 {
-	unsigned int flag = le32_to_cpu(F2FS_NODE_FOOTER(sbi, node_folio)->flag);
+	unsigned int flag = le32_to_cpu(F2FS_NODE_FOOTER(sbi, entry)->flag);
 	return flag >> OFFSET_BIT_SHIFT;
 }
 
 static inline __u64 cpver_of_node(struct f2fs_sb_info *sbi,
-				const struct folio *node_folio)
+				const struct f2fs_cached_block *entry)
 {
-	return le64_to_cpu(F2FS_NODE_FOOTER(sbi, node_folio)->cp_ver);
+	return le64_to_cpu(F2FS_NODE_FOOTER(sbi, entry)->cp_ver);
 }
 
 static inline block_t next_blkaddr_of_node(struct f2fs_sb_info *sbi,
-				const struct folio *node_folio)
+				const struct f2fs_cached_block *entry)
 {
-	return le32_to_cpu(F2FS_NODE_FOOTER(sbi, node_folio)->next_blkaddr);
+	return le32_to_cpu(F2FS_NODE_FOOTER(sbi, entry)->next_blkaddr);
 }
 
 static inline void fill_node_footer(struct f2fs_sb_info *sbi,
-				const struct folio *folio, nid_t nid,
+				struct f2fs_cached_block *entry, nid_t nid,
 				nid_t ino, unsigned int ofs, bool reset)
 {
-	struct f2fs_node *rn = F2FS_NODE(folio);
-	struct node_footer *footer = F2FS_NODE_FOOTER(sbi, folio);
+	struct f2fs_node *rn = CACHED_NODE(entry);
+	struct node_footer *footer = F2FS_NODE_FOOTER(sbi, entry);
 	unsigned int old_flag = 0;
 
 	if (reset)
@@ -292,6 +292,7 @@ static inline void fill_node_footer(struct f2fs_sb_info *sbi,
 	else
 		old_flag = le32_to_cpu(footer->flag);
 
+	memset(footer, 0, sizeof(*footer));
 	footer->nid = cpu_to_le32(nid);
 	footer->ino = cpu_to_le32(ino);
 
@@ -301,17 +302,18 @@ static inline void fill_node_footer(struct f2fs_sb_info *sbi,
 }
 
 static inline void copy_node_footer(struct f2fs_sb_info *sbi,
-		const struct folio *dst, const struct folio *src)
+		struct f2fs_cached_block *dst,
+		const struct f2fs_cached_block *src)
 {
 	memcpy(F2FS_NODE_FOOTER(sbi, dst), F2FS_NODE_FOOTER(sbi, src),
 	       sizeof(struct node_footer));
 }
 
 static inline void fill_node_footer_blkaddr(struct f2fs_sb_info *sbi,
-				struct folio *folio, block_t blkaddr)
+				struct f2fs_cached_block *entry, block_t blkaddr)
 {
 	struct f2fs_checkpoint *ckpt = F2FS_CKPT(sbi);
-	struct node_footer *footer = F2FS_NODE_FOOTER(sbi, folio);
+	struct node_footer *footer = F2FS_NODE_FOOTER(sbi, entry);
 	__u64 cp_ver = cur_cp_version(ckpt);
 
 	if (__is_set_ckpt_flags(ckpt, CP_CRC_RECOVERY_FLAG))
@@ -321,19 +323,20 @@ static inline void fill_node_footer_blkaddr(struct f2fs_sb_info *sbi,
 	footer->next_blkaddr = cpu_to_le32(blkaddr);
 }
 
-static inline bool is_recoverable_dnode(struct f2fs_sb_info *sbi, const struct folio *folio)
+static inline bool is_recoverable_dnode(struct f2fs_sb_info *sbi,
+				const struct f2fs_cached_block *entry)
 {
 	struct f2fs_checkpoint *ckpt = F2FS_CKPT(sbi);
 	__u64 cp_ver = cur_cp_version(ckpt);
 
 	/* Don't care crc part, if fsck.f2fs sets it. */
 	if (__is_set_ckpt_flags(ckpt, CP_NOCRC_RECOVERY_FLAG))
-		return (cp_ver << 32) == (cpver_of_node(sbi, folio) << 32);
+		return (cp_ver << 32) == (cpver_of_node(sbi, entry) << 32);
 
 	if (__is_set_ckpt_flags(ckpt, CP_CRC_RECOVERY_FLAG))
 		cp_ver |= (cur_cp_crc(ckpt) << 32);
 
-	return cp_ver == cpver_of_node(sbi, folio);
+	return cp_ver == cpver_of_node(sbi, entry);
 }
 
 /*
@@ -358,9 +361,9 @@ static inline bool is_recoverable_dnode(struct f2fs_sb_info *sbi, const struct f
  *                       `- direct node
  */
 static inline bool IS_DNODE(struct f2fs_sb_info *sbi,
-					const struct folio *node_folio)
+				const struct f2fs_cached_block *entry)
 {
-	unsigned int ofs = ofs_of_node(sbi, node_folio);
+	unsigned int ofs = ofs_of_node(sbi, entry);
 
 	if (f2fs_has_xattr_block(ofs))
 		return true;
@@ -376,27 +379,27 @@ static inline bool IS_DNODE(struct f2fs_sb_info *sbi,
 	return true;
 }
 
-static inline int set_nid(struct f2fs_sb_info *sbi,
-				struct folio *folio, int off, nid_t nid, bool i)
+static inline bool set_nid(struct f2fs_sb_info *sbi,
+			struct f2fs_cached_block *entry, int off, nid_t nid, bool i)
 {
-	struct f2fs_node *rn = F2FS_NODE(folio);
-	__le32 *inode_nids = F2FS_INODE_NIDS(sbi, folio);
+	struct f2fs_node *rn = CACHED_NODE(entry);
+	__le32 *inode_nids = F2FS_INODE_NIDS(sbi, entry);
+	__le32 *addr = i ? &inode_nids[off - NODE_DIR1_BLOCK(sbi)] : &rn->in.nid[off];
 
-	f2fs_folio_wait_writeback(folio, NODE, true, true);
+	f2fs_cache_wait_writeback(entry);
+	if (*addr == cpu_to_le32(nid))
+		return false;
 
-	if (i)
-		inode_nids[off - NODE_DIR1_BLOCK(sbi)] =
-			cpu_to_le32(nid);
-	else
-		rn->in.nid[off] = cpu_to_le32(nid);
-	return folio_mark_dirty(folio);
+	*addr = cpu_to_le32(nid);
+	f2fs_mark_cache_dirty(entry);
+	return true;
 }
 
 static inline nid_t get_nid(struct f2fs_sb_info *sbi,
-				const struct folio *folio, int off, bool i)
+			const struct f2fs_cached_block *entry, int off, bool i)
 {
-	struct f2fs_node *rn = F2FS_NODE(folio);
-	const __le32 *inode_nids = F2FS_INODE_NIDS(sbi, folio);
+	struct f2fs_node *rn = CACHED_NODE(entry);
+	const __le32 *inode_nids = F2FS_INODE_NIDS(sbi, entry);
 	int nid_index = off - NODE_DIR1_BLOCK(sbi);
 
 	if (i)
@@ -412,20 +415,21 @@ static inline nid_t get_nid(struct f2fs_sb_info *sbi,
  */
 
 static inline int is_node(struct f2fs_sb_info *sbi,
-				const struct folio *folio, int type)
+			const struct f2fs_cached_block *entry, int type)
 {
-	return le32_to_cpu(F2FS_NODE_FOOTER(sbi, folio)->flag) & BIT(type);
+	return le32_to_cpu(F2FS_NODE_FOOTER(sbi, entry)->flag) & BIT(type);
 }
 
-#define is_cold_node(sbi, folio)	is_node(sbi, folio, COLD_BIT_SHIFT)
-#define is_fsync_dnode(sbi, folio)	is_node(sbi, folio, FSYNC_BIT_SHIFT)
-#define is_dent_dnode(sbi, folio)	is_node(sbi, folio, DENT_BIT_SHIFT)
+#define is_cold_node(sbi, entry)	is_node(sbi, entry, COLD_BIT_SHIFT)
+#define is_fsync_dnode(sbi, entry)	is_node(sbi, entry, FSYNC_BIT_SHIFT)
+#define is_dent_dnode(sbi, entry)	is_node(sbi, entry, DENT_BIT_SHIFT)
 
 static inline void __set_mark(struct f2fs_sb_info *sbi,
-				const struct folio *folio, bool mark, int type)
+			struct f2fs_cached_block *entry, bool mark, int type)
 {
-	struct node_footer *footer = F2FS_NODE_FOOTER(sbi, folio);
+	struct node_footer *footer = F2FS_NODE_FOOTER(sbi, entry);
 	unsigned int flag = le32_to_cpu(footer->flag);
+
 	if (mark)
 		flag |= BIT(type);
 	else
@@ -434,19 +438,19 @@ static inline void __set_mark(struct f2fs_sb_info *sbi,
 }
 
 static inline void set_cold_node(struct f2fs_sb_info *sbi,
-				const struct folio *folio, bool is_dir)
+			struct f2fs_cached_block *entry, bool is_dir)
 {
-	__set_mark(sbi, folio, !is_dir, COLD_BIT_SHIFT);
+	__set_mark(sbi, entry, !is_dir, COLD_BIT_SHIFT);
 }
 
 static inline void set_mark(struct f2fs_sb_info *sbi,
-				struct folio *folio, bool mark, int type)
+			struct f2fs_cached_block *entry, bool mark, int type)
 {
-	__set_mark(sbi, folio, mark, type);
-
+	__set_mark(sbi, entry, mark, type);
 #ifdef CONFIG_F2FS_CHECK_FS
-	f2fs_inode_chksum_set(sbi, folio);
+	f2fs_inode_chksum_set(sbi, entry);
 #endif
 }
-#define set_dentry_mark(sbi, folio, mark)	set_mark(sbi, folio, mark, DENT_BIT_SHIFT)
-#define set_fsync_mark(sbi, folio, mark)	set_mark(sbi, folio, mark, FSYNC_BIT_SHIFT)
+
+#define set_dentry_mark(sbi, entry, mark)	set_mark(sbi, entry, mark, DENT_BIT_SHIFT)
+#define set_fsync_mark(sbi, entry, mark)	set_mark(sbi, entry, mark, FSYNC_BIT_SHIFT)
diff --git a/fs/f2fs/recovery.c b/fs/f2fs/recovery.c
index 93564e532f2f..54b5246609de 100644
--- a/fs/f2fs/recovery.c
+++ b/fs/f2fs/recovery.c
@@ -190,7 +190,7 @@ static int recover_dentry(struct inode *inode, struct f2fs_cached_block *entry,
 	struct f2fs_dir_entry *de;
 	struct f2fs_filename fname;
 	struct qstr usr_fname;
-	struct folio *folio;
+	void *dentry_blk = NULL;
 	struct inode *dir, *einode;
 	struct fsync_inode_entry *fsync_entry;
 	int err = 0;
@@ -213,7 +213,8 @@ static int recover_dentry(struct inode *inode, struct f2fs_cached_block *entry,
 	if (err)
 		goto out;
 retry:
-	de = __f2fs_find_entry(dir, &fname, &folio);
+	dentry_blk = NULL;
+	de = __f2fs_find_entry(dir, &fname, &dentry_blk);
 	if (de && inode->i_ino == le32_to_cpu(de->ino))
 		goto out_put;
 
@@ -238,11 +239,11 @@ static int recover_dentry(struct inode *inode, struct f2fs_cached_block *entry,
 			iput(einode);
 			goto out_put;
 		}
-		f2fs_delete_entry(de, folio, dir, einode);
+		f2fs_delete_entry(de, dentry_blk, dir, einode);
 		iput(einode);
 		goto retry;
-	} else if (IS_ERR(folio)) {
-		err = PTR_ERR(folio);
+	} else if (IS_ERR(dentry_blk)) {
+		err = PTR_ERR(dentry_blk);
 	} else {
 		err = f2fs_add_dentry(dir, &fname, inode,
 					inode->i_ino, inode->i_mode);
@@ -252,11 +253,11 @@ static int recover_dentry(struct inode *inode, struct f2fs_cached_block *entry,
 	goto out;
 
 out_put:
-	f2fs_folio_put(folio, false);
+	f2fs_put_dentry_block(dentry_blk, false);
 out:
 	name = recover_printable_name(inode, raw_inode, &name_len);
 	f2fs_notice(F2FS_I_SB(inode), "%s: ino = %x, name = %.*s, dir = %llu, err = %d",
-		    __func__, ino_of_node(F2FS_I_SB(inode), cache_folio(entry)), name_len, name,
+		    __func__, ino_of_node(F2FS_I_SB(inode), entry), name_len, name,
 		    IS_ERR(dir) ? 0 : dir->i_ino, err);
 	return err;
 }
@@ -357,7 +358,7 @@ static int recover_inode(struct inode *inode, struct f2fs_cached_block *entry)
 	name = recover_printable_name(inode, raw, &name_len);
 
 	f2fs_notice(F2FS_I_SB(inode), "%s: ino = %x, name = %.*s, inline = %x",
-		    __func__, ino_of_node(F2FS_I_SB(inode), cache_folio(entry)), name_len, name,
+		    __func__, ino_of_node(F2FS_I_SB(inode), entry), name_len, name,
 		    raw->i_inline);
 	return 0;
 }
@@ -397,16 +398,16 @@ static int sanity_check_node_chain(struct f2fs_sb_info *sbi, block_t blkaddr,
 		if (IS_ERR(entry))
 			return PTR_ERR(entry);
 
-		if (!is_recoverable_dnode(sbi, cache_folio(entry))) {
+		if (!is_recoverable_dnode(sbi, entry)) {
 			f2fs_put_cache(entry, true);
 			*is_detecting = false;
 			return 0;
 		}
 
 		ra_blocks = adjust_por_ra_blocks(sbi, ra_blocks, *blkaddr_fast,
-					next_blkaddr_of_node(sbi, cache_folio(entry)));
+					next_blkaddr_of_node(sbi, entry));
 
-		*blkaddr_fast = next_blkaddr_of_node(sbi, cache_folio(entry));
+		*blkaddr_fast = next_blkaddr_of_node(sbi, entry);
 		f2fs_put_cache(entry, true);
 
 		f2fs_ra_meta_caches_cond(sbi, *blkaddr_fast, ra_blocks);
@@ -446,22 +447,22 @@ static int find_fsync_dnodes(struct f2fs_sb_info *sbi, struct list_head *head,
 			break;
 		}
 
-		if (!is_recoverable_dnode(sbi, cache_folio(entry))) {
+		if (!is_recoverable_dnode(sbi, entry)) {
 			f2fs_put_cache(entry, true);
 			break;
 		}
 
-		if (!is_fsync_dnode(sbi, cache_folio(entry)))
+		if (!is_fsync_dnode(sbi, entry))
 			goto next;
 
-		fsync_entry = get_fsync_inode(head, ino_of_node(sbi, cache_folio(entry)));
+		fsync_entry = get_fsync_inode(head, ino_of_node(sbi, entry));
 		if (!fsync_entry) {
 			bool quota_inode = false;
 
 			if (!check_only &&
-					IS_INODE(sbi, cache_folio(entry)) &&
-					is_dent_dnode(sbi, cache_folio(entry))) {
-				err = f2fs_recover_inode_page(sbi, entry);
+					IS_INODE(sbi, entry) &&
+					is_dent_dnode(sbi, entry)) {
+				err = f2fs_recover_inode_cache(sbi, entry);
 				if (err) {
 					f2fs_put_cache(entry, true);
 					break;
@@ -469,7 +470,7 @@ static int find_fsync_dnodes(struct f2fs_sb_info *sbi, struct list_head *head,
 				quota_inode = true;
 			}
 
-			fsync_entry = add_fsync_inode(sbi, head, ino_of_node(sbi, cache_folio(entry)),
+			fsync_entry = add_fsync_inode(sbi, head, ino_of_node(sbi, entry),
 								quota_inode);
 			if (IS_ERR(fsync_entry)) {
 				err = PTR_ERR(fsync_entry);
@@ -488,11 +489,11 @@ static int find_fsync_dnodes(struct f2fs_sb_info *sbi, struct list_head *head,
 		}
 		fsync_entry->blkaddr = blkaddr;
 
-		if (IS_INODE(sbi, cache_folio(entry)) && is_dent_dnode(sbi, cache_folio(entry)))
+		if (IS_INODE(sbi, entry) && is_dent_dnode(sbi, entry))
 			fsync_entry->last_dentry = blkaddr;
 next:
 		/* check next segment */
-		blkaddr = next_blkaddr_of_node(sbi, cache_folio(entry));
+		blkaddr = next_blkaddr_of_node(sbi, entry);
 		f2fs_put_cache(entry, true);
 
 		err = sanity_check_node_chain(sbi, blkaddr, &blkaddr_fast,
@@ -520,7 +521,7 @@ static int check_index_in_prev_nodes(struct f2fs_sb_info *sbi,
 	struct f2fs_summary_block *sum_node;
 	struct f2fs_summary sum;
 	struct f2fs_cached_block *entry = NULL;
-	struct folio *node_folio;
+	struct f2fs_cached_block *node_entry;
 	struct dnode_of_data tdn = *dn;
 	nid_t ino, nid;
 	struct inode *inode;
@@ -553,7 +554,7 @@ static int check_index_in_prev_nodes(struct f2fs_sb_info *sbi,
 	nid = le32_to_cpu(sum.nid);
 	ofs_in_node = le16_to_cpu(sum.ofs_in_node);
 
-	max_addrs = ADDRS_PER_PAGE(dn->node_folio, dn->inode);
+	max_addrs = ADDRS_PER_PAGE(dn->node_entry, dn->inode);
 	if (ofs_in_node >= max_addrs) {
 		f2fs_err(sbi, "Inconsistent ofs_in_node:%u in summary, ino:%llu, nid:%u, max:%u",
 			ofs_in_node, dn->inode->i_ino, nid, max_addrs);
@@ -563,9 +564,9 @@ static int check_index_in_prev_nodes(struct f2fs_sb_info *sbi,
 
 	if (dn->inode->i_ino == nid) {
 		tdn.nid = nid;
-		if (!dn->inode_folio_locked)
-			folio_lock(dn->inode_folio);
-		tdn.node_folio = dn->inode_folio;
+		if (!dn->inode_entry_locked)
+			f2fs_lock_cache(dn->inode_entry);
+		tdn.node_entry = dn->inode_entry;
 		tdn.ofs_in_node = ofs_in_node;
 		goto truncate_out;
 	} else if (dn->nid == nid) {
@@ -574,13 +575,13 @@ static int check_index_in_prev_nodes(struct f2fs_sb_info *sbi,
 	}
 
 	/* Get the node page */
-	node_folio = f2fs_get_node_folio(sbi, nid, NODE_TYPE_REGULAR);
-	if (IS_ERR(node_folio))
-		return PTR_ERR(node_folio);
+	node_entry = f2fs_get_node_cache(sbi, nid, NODE_TYPE_REGULAR);
+	if (IS_ERR(node_entry))
+		return PTR_ERR(node_entry);
 
-	offset = ofs_of_node(sbi, node_folio);
-	ino = ino_of_node(sbi, node_folio);
-	f2fs_folio_put(node_folio, true);
+	offset = ofs_of_node(sbi, node_entry);
+	ino = ino_of_node(sbi, node_entry);
+	f2fs_put_cache(node_entry, true);
 
 	if (ino != dn->inode->i_ino) {
 		int ret;
@@ -606,8 +607,8 @@ static int check_index_in_prev_nodes(struct f2fs_sb_info *sbi,
 	 * if inode page is locked, unlock temporarily, but its reference
 	 * count keeps alive.
 	 */
-	if (ino == dn->inode->i_ino && dn->inode_folio_locked)
-		folio_unlock(dn->inode_folio);
+	if (ino == dn->inode->i_ino && dn->inode_entry_locked)
+		f2fs_unlock_cache(dn->inode_entry);
 
 	set_new_dnode(&tdn, inode, NULL, NULL, 0);
 	if (f2fs_get_dnode_of_data(&tdn, bidx, LOOKUP_NODE))
@@ -620,15 +621,15 @@ static int check_index_in_prev_nodes(struct f2fs_sb_info *sbi,
 out:
 	if (ino != dn->inode->i_ino)
 		iput(inode);
-	else if (dn->inode_folio_locked)
-		folio_lock(dn->inode_folio);
+	else if (dn->inode_entry_locked)
+		f2fs_lock_cache(dn->inode_entry);
 	return 0;
 
 truncate_out:
 	if (f2fs_data_blkaddr(&tdn) == blkaddr)
 		f2fs_truncate_data_blocks_range(&tdn, 1);
-	if (dn->inode->i_ino == nid && !dn->inode_folio_locked)
-		folio_unlock(dn->inode_folio);
+	if (dn->inode->i_ino == nid && !dn->inode_entry_locked)
+		f2fs_unlock_cache(dn->inode_entry);
 	return 0;
 }
 
@@ -654,11 +655,11 @@ static int do_recover_data(struct f2fs_sb_info *sbi, struct inode *inode,
 	int err = 0, recovered = 0;
 
 	/* step 1: recover xattr */
-	if (IS_INODE(sbi, cache_folio(entry))) {
+	if (IS_INODE(sbi, entry)) {
 		err = f2fs_recover_inline_xattr(inode, entry);
 		if (err)
 			goto out;
-	} else if (f2fs_has_xattr_block(ofs_of_node(sbi, cache_folio(entry)))) {
+	} else if (f2fs_has_xattr_block(ofs_of_node(sbi, entry))) {
 		err = f2fs_recover_xattr_data(inode, entry);
 		if (!err)
 			recovered++;
@@ -674,8 +675,8 @@ static int do_recover_data(struct f2fs_sb_info *sbi, struct inode *inode,
 	}
 
 	/* step 3: recover data indices */
-	start = f2fs_start_bidx_of_node(ofs_of_node(sbi, cache_folio(entry)), inode);
-	end = start + addrs_per_page(inode, IS_INODE(sbi, cache_folio(entry)));
+	start = f2fs_start_bidx_of_node(ofs_of_node(sbi, entry), inode);
+	end = start + addrs_per_page(inode, IS_INODE(sbi, entry));
 
 	set_new_dnode(&dn, inode, NULL, NULL, 0);
 retry_dn:
@@ -688,18 +689,18 @@ static int do_recover_data(struct f2fs_sb_info *sbi, struct inode *inode,
 		goto out;
 	}
 
-	f2fs_folio_wait_writeback(dn.node_folio, NODE, true, true);
+	f2fs_cache_wait_writeback(dn.node_entry);
 
 	err = f2fs_get_node_info(sbi, dn.nid, &ni, false);
 	if (err)
 		goto err;
 
-	f2fs_bug_on(sbi, ni.ino != ino_of_node(sbi, cache_folio(entry)));
+	f2fs_bug_on(sbi, ni.ino != ino_of_node(sbi, entry));
 
-	if (ofs_of_node(sbi, dn.node_folio) != ofs_of_node(sbi, cache_folio(entry))) {
+	if (ofs_of_node(sbi, dn.node_entry) != ofs_of_node(sbi, entry)) {
 		f2fs_warn(sbi, "Inconsistent ofs_of_node, ino:%llu, ofs:%u, %u",
-			  inode->i_ino, ofs_of_node(sbi, dn.node_folio),
-			  ofs_of_node(sbi, cache_folio(entry)));
+			  inode->i_ino, ofs_of_node(sbi, dn.node_entry),
+			  ofs_of_node(sbi, entry));
 		err = -EFSCORRUPTED;
 		f2fs_handle_error(sbi, ERROR_INCONSISTENT_FOOTER);
 		fserror_report_file_metadata(dn.inode, err, GFP_NOFS);
@@ -710,7 +711,7 @@ static int do_recover_data(struct f2fs_sb_info *sbi, struct inode *inode,
 		block_t src, dest;
 
 		src = f2fs_data_blkaddr(&dn);
-		dest = data_blkaddr(dn.inode, cache_folio(entry), dn.ofs_in_node);
+		dest = data_blkaddr(dn.inode, entry, dn.ofs_in_node);
 
 		if (__is_valid_data_blkaddr(src) &&
 			!f2fs_is_valid_blkaddr(sbi, src, META_POR)) {
@@ -785,16 +786,16 @@ static int do_recover_data(struct f2fs_sb_info *sbi, struct inode *inode,
 		}
 	}
 
-	copy_node_footer(sbi, dn.node_folio, cache_folio(entry));
-	fill_node_footer(sbi, dn.node_folio, dn.nid, ni.ino,
-					ofs_of_node(sbi, cache_folio(entry)), false);
-	folio_mark_dirty(dn.node_folio);
+	copy_node_footer(sbi, dn.node_entry, entry);
+	fill_node_footer(sbi, dn.node_entry, dn.nid, ni.ino,
+					ofs_of_node(sbi, entry), false);
+	f2fs_mark_cache_dirty(dn.node_entry);
 err:
 	f2fs_put_dnode(&dn);
 out:
 	f2fs_notice(sbi, "recover_data: ino = %llx, nid = %x (i_size: %s), "
 		    "range (%u, %u), recovered = %d, err = %d",
-		    inode->i_ino, nid_of_node(sbi, cache_folio(entry)),
+		    inode->i_ino, nid_of_node(sbi, entry),
 		    file_keep_isize(inode) ? "keep" : "recover",
 		    start, end, recovered, err);
 	return err;
@@ -833,13 +834,13 @@ static int recover_data(struct f2fs_sb_info *sbi, struct list_head *inode_list,
 			break;
 		}
 
-		if (!is_recoverable_dnode(sbi, cache_folio(entry))) {
+		if (!is_recoverable_dnode(sbi, entry)) {
 			f2fs_put_cache(entry, true);
 			break;
 		}
 		recoverable_dnode++;
 
-		fsync_entry = get_fsync_inode(inode_list, ino_of_node(sbi, cache_folio(entry)));
+		fsync_entry = get_fsync_inode(inode_list, ino_of_node(sbi, entry));
 		if (!fsync_entry)
 			goto next;
 		fsynced_dnode++;
@@ -848,7 +849,7 @@ static int recover_data(struct f2fs_sb_info *sbi, struct list_head *inode_list,
 		 * In this case, we can lose the latest inode(x).
 		 * So, call recover_inode for the inode update.
 		 */
-		if (IS_INODE(sbi, cache_folio(entry))) {
+		if (IS_INODE(sbi, entry)) {
 			err = recover_inode(fsync_entry->inode, entry);
 			if (err) {
 				f2fs_put_cache(entry, true);
@@ -875,10 +876,10 @@ static int recover_data(struct f2fs_sb_info *sbi, struct list_head *inode_list,
 			list_move_tail(&fsync_entry->list, tmp_inode_list);
 next:
 		ra_blocks = adjust_por_ra_blocks(sbi, ra_blocks, blkaddr,
-					next_blkaddr_of_node(sbi, cache_folio(entry)));
+					next_blkaddr_of_node(sbi, entry));
 
 		/* check next segment */
-		blkaddr = next_blkaddr_of_node(sbi, cache_folio(entry));
+		blkaddr = next_blkaddr_of_node(sbi, entry);
 		f2fs_put_cache(entry, true);
 
 		f2fs_ra_meta_caches_cond(sbi, blkaddr, ra_blocks);
@@ -941,7 +942,7 @@ int f2fs_recover_fsync_data(struct f2fs_sb_info *sbi, bool check_only)
 	f2fs_truncate_meta_caches(sbi, MAIN_BLKADDR(sbi),
 				MAX_BLKADDR(sbi) - MAIN_BLKADDR(sbi));
 	if (err) {
-		truncate_inode_pages_final(NODE_MAPPING(sbi));
+		f2fs_truncate_node_caches(sbi, 0, ULONG_MAX);
 		f2fs_truncate_meta_caches(sbi, 0, ULONG_MAX);
 	}
 
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 9d08e762b131..87e24d0306e8 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -335,8 +335,8 @@ static int __f2fs_commit_atomic_write(struct inode *inode)
 			goto next;
 		}
 
-		blen = min((pgoff_t)ADDRS_PER_PAGE(dn.node_folio, cow_inode),
-				len);
+		blen = min((pgoff_t)addrs_per_page(cow_inode,
+				IS_INODE(F2FS_I_SB(cow_inode), dn.node_entry)), len);
 		index = off;
 		for (i = 0; i < blen; i++, dn.ofs_in_node++, index++) {
 			blkaddr = f2fs_data_blkaddr(&dn);
@@ -3826,7 +3826,8 @@ static int __get_segment_type_4(struct f2fs_io_info *fio)
 		else
 			return CURSEG_COLD_DATA;
 	} else {
-		if (IS_DNODE(fio->sbi, fio->folio) && is_cold_node(fio->sbi, fio->folio))
+		f2fs_bug_on(fio->sbi, !fio->is_cache);
+		if (IS_DNODE(fio->sbi, fio->cache_entry) && is_cold_node(fio->sbi, fio->cache_entry))
 			return CURSEG_WARM_NODE;
 		else
 			return CURSEG_COLD_NODE;
@@ -3884,9 +3885,9 @@ static int __get_segment_type_6(struct f2fs_io_info *fio)
 		return f2fs_rw_hint_to_seg_type(F2FS_I_SB(inode),
 						inode->i_write_hint);
 	} else {
-		if (IS_DNODE(fio->sbi, fio->folio))
-			return is_cold_node(fio->sbi, fio->folio) ? CURSEG_WARM_NODE :
-						CURSEG_HOT_NODE;
+		f2fs_bug_on(fio->sbi, !fio->is_cache);
+		if (IS_DNODE(fio->sbi, fio->cache_entry))
+			return is_cold_node(fio->sbi, fio->cache_entry) ? CURSEG_WARM_NODE : CURSEG_HOT_NODE;
 		return CURSEG_COLD_NODE;
 	}
 }
@@ -3953,7 +3954,7 @@ static void f2fs_randomize_chunk(struct f2fs_sb_info *sbi,
 		get_random_u32_inclusive(1, sbi->max_fragment_hole);
 }
 
-int f2fs_allocate_data_block(struct f2fs_sb_info *sbi, struct folio *folio,
+int f2fs_allocate_data_block(struct f2fs_sb_info *sbi,
 		block_t old_blkaddr, block_t *new_blkaddr,
 		struct f2fs_summary *sum, int type,
 		struct f2fs_io_info *fio)
@@ -4061,10 +4062,10 @@ int f2fs_allocate_data_block(struct f2fs_sb_info *sbi, struct folio *folio,
 
 	up_write(&sit_i->sentry_lock);
 
-	if (folio && IS_NODESEG(curseg->seg_type)) {
-		fill_node_footer_blkaddr(sbi, folio, NEXT_FREE_BLKADDR(sbi, curseg));
-
-		f2fs_inode_chksum_set(sbi, folio);
+	if (fio && fio->is_cache && IS_NODESEG(curseg->seg_type)) {
+		fill_node_footer_blkaddr(sbi, fio->cache_entry,
+				NEXT_FREE_BLKADDR(sbi, curseg));
+		f2fs_inode_chksum_set(sbi, fio->cache_entry);
 	}
 
 	if (fio) {
@@ -4152,16 +4153,24 @@ static void do_write_block(struct f2fs_summary *sum, struct f2fs_io_info *fio)
 	if (keep_order)
 		f2fs_down_read(&fio->sbi->io_order_lock);
 
-	err = f2fs_allocate_data_block(fio->sbi, folio, fio->old_blkaddr,
+	err = f2fs_allocate_data_block(fio->sbi, fio->old_blkaddr,
 			&fio->new_blkaddr, sum, type, fio);
 	if (unlikely(err)) {
-		f2fs_err_ratelimited(fio->sbi,
-			"%s Failed to allocate data block, ino:%u, index:%lu, type:%d, old_blkaddr:0x%x, new_blkaddr:0x%x, err:%d",
-			__func__, fio->ino, folio->index, type,
-			fio->old_blkaddr, fio->new_blkaddr, err);
-		folio_end_writeback(folio);
-		if (f2fs_in_warm_node_list(fio->sbi, folio))
-			f2fs_del_fsync_node_entry(fio->sbi, folio);
+		if (fio->is_cache) {
+			f2fs_err_ratelimited(fio->sbi,
+				"%s Failed to allocate data block, ino:%u, index:%lu, type:%d, old_blkaddr:0x%x, new_blkaddr:0x%x, err:%d",
+				__func__, fio->ino, fio->cache_entry->index, type,
+				fio->old_blkaddr, fio->new_blkaddr, err);
+			if (f2fs_in_warm_node_list(fio->sbi, fio->cache_entry))
+				f2fs_del_fsync_node_entry(fio->sbi, fio->cache_entry);
+			f2fs_end_cache_writeback(fio->cache_entry);
+		} else {
+			f2fs_err_ratelimited(fio->sbi,
+				"%s Failed to allocate data block, ino:%u, index:%lu, type:%d, old_blkaddr:0x%x, new_blkaddr:0x%x, err:%d",
+				__func__, fio->ino, folio->index, type,
+				fio->old_blkaddr, fio->new_blkaddr, err);
+			folio_end_writeback(folio);
+		}
 		f2fs_bug_on(fio->sbi, !is_set_ckpt_flags(fio->sbi,
 							CP_ERROR_FLAG));
 		goto out;
@@ -4174,7 +4183,10 @@ static void do_write_block(struct f2fs_summary *sum, struct f2fs_io_info *fio)
 		f2fs_invalidate_internal_cache(fio->sbi, fio->old_blkaddr, 1);
 
 	/* writeout dirty page into bdev */
-	f2fs_submit_page_write(fio);
+	if (fio->is_cache)
+		f2fs_submit_cache_write(fio);
+	else
+		f2fs_submit_page_write(fio);
 
 	f2fs_update_device_state(fio->sbi, fio->ino, fio->new_blkaddr, 1);
 out:
@@ -4210,7 +4222,7 @@ void f2fs_do_write_meta_cache(struct f2fs_sb_info *sbi,
 	f2fs_update_iostat(sbi, NULL, io_type, F2FS_BLKSIZE(sbi));
 }
 
-void f2fs_do_write_node_page(unsigned int nid, struct f2fs_io_info *fio)
+void f2fs_do_write_node_cache(unsigned int nid, struct f2fs_io_info *fio)
 {
 	struct f2fs_summary sum;
 
@@ -4409,14 +4421,13 @@ void f2fs_replace_block(struct f2fs_sb_info *sbi, struct dnode_of_data *dn,
 	f2fs_update_data_blkaddr(dn, new_addr);
 }
 
-void f2fs_folio_wait_writeback(struct folio *folio, enum page_type type,
-		bool ordered, bool locked)
+void f2fs_folio_wait_writeback(struct folio *folio, bool ordered, bool locked)
 {
 	if (folio_test_writeback(folio)) {
 		struct f2fs_sb_info *sbi = F2FS_F_SB(folio);
 
 		/* submit cached LFS IO */
-		f2fs_submit_merged_write_folio(sbi, folio, type);
+		f2fs_submit_merged_write_folio(sbi, folio);
 		/* submit cached IPU IO */
 		f2fs_submit_merged_ipu_write(sbi, NULL, folio);
 		if (ordered) {
diff --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h
index 3083069c9092..b11461acc520 100644
--- a/fs/f2fs/segment.h
+++ b/fs/f2fs/segment.h
@@ -1019,26 +1019,6 @@ static inline long adjust_flush_cache_number(struct f2fs_sb_info *sbi, int type)
 	return nr_to_write;
 }
 
-/*
- * When writing pages, it'd better align nr_to_write for segment size.
- */
-static inline long nr_pages_to_write(struct f2fs_sb_info *sbi, int type,
-					struct writeback_control *wbc)
-{
-	long nr_to_write, desired;
-
-	if (wbc->sync_mode != WB_SYNC_NONE)
-		return 0;
-
-	nr_to_write = wbc->nr_to_write;
-	desired = BIO_MAX_VECS;
-	if (type == NODE)
-		desired <<= 1;
-
-	wbc->nr_to_write = desired;
-	return desired - nr_to_write;
-}
-
 static inline void wake_up_discard_thread(struct f2fs_sb_info *sbi, bool force)
 {
 	struct discard_cmd_control *dcc = SM_I(sbi)->dcc_info;
diff --git a/fs/f2fs/shrinker.c b/fs/f2fs/shrinker.c
index baa09bc63585..499717cd693c 100644
--- a/fs/f2fs/shrinker.c
+++ b/fs/f2fs/shrinker.c
@@ -39,7 +39,8 @@ static unsigned long __count_extent_cache(struct f2fs_sb_info *sbi,
 
 static unsigned long __count_cache(struct f2fs_sb_info *sbi)
 {
-	return META_CACHE(sbi)->num_entries;
+	return META_CACHE(sbi)->num_entries +
+		NODE_CACHE(sbi)->num_entries;
 }
 
 unsigned long f2fs_shrink_count(struct shrinker *shrink,
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index fa19152cd4da..bf42fbffa348 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -1872,20 +1872,8 @@ static struct inode *f2fs_alloc_inode(struct super_block *sb)
 
 static int f2fs_drop_inode(struct inode *inode)
 {
-	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
 	int ret;
 
-	/*
-	 * during filesystem shutdown, if checkpoint is disabled,
-	 * drop useless meta/node dirty pages.
-	 */
-	if (unlikely(is_sbi_flag_set(sbi, SBI_CP_DISABLED))) {
-		if (inode->i_ino == F2FS_NODE_INO(sbi)) {
-			trace_f2fs_drop_inode(inode, 1);
-			return 1;
-		}
-	}
-
 	/*
 	 * This is to avoid a deadlock condition like below.
 	 * writeback_single_inode(inode)
@@ -1906,7 +1894,7 @@ static int f2fs_drop_inode(struct inode *inode)
 			f2fs_i_size_write(inode, 0);
 
 			f2fs_submit_merged_write_cond(F2FS_I_SB(inode),
-					inode, NULL, 0, DATA);
+							inode, NULL);
 			truncate_inode_pages_final(inode->i_mapping);
 
 			if (F2FS_HAS_BLOCKS(inode))
@@ -1980,11 +1968,6 @@ void f2fs_inode_synced(struct inode *inode)
  */
 static void f2fs_dirty_inode(struct inode *inode, int flags)
 {
-	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
-
-	if (inode->i_ino == F2FS_NODE_INO(sbi))
-		return;
-
 	if (is_inode_flag_set(inode, FI_AUTO_RECOVER))
 		clear_inode_flag(inode, FI_AUTO_RECOVER);
 
@@ -2080,7 +2063,7 @@ static void f2fs_put_super(struct super_block *sb)
 
 	if (err || f2fs_cp_error(sbi) ||
 		unlikely(is_sbi_flag_set(sbi, SBI_CP_DISABLED))) {
-		truncate_inode_pages_final(NODE_MAPPING(sbi));
+		f2fs_truncate_node_caches(sbi, 0, ULONG_MAX);
 		f2fs_truncate_meta_caches(sbi, 0, ULONG_MAX);
 	}
 
@@ -2088,11 +2071,8 @@ static void f2fs_put_super(struct super_block *sb)
 
 	f2fs_destroy_compress_inode(sbi);
 
-	iput(sbi->node_inode);
-	sbi->node_inode = NULL;
-
-	f2fs_destroy_cache(META_CACHE(sbi));
 	f2fs_destroy_cache(NODE_CACHE(sbi));
+	f2fs_destroy_cache(META_CACHE(sbi));
 
 	/* Should check the page counts after dropping all node/meta pages */
 	for (i = 0; i < NR_COUNT_TYPE; i++) {
@@ -4445,7 +4425,6 @@ static void init_sb_info(struct f2fs_sb_info *sbi)
 	sbi->allocate_section_hint = le32_to_cpu(raw_super->section_count);
 	sbi->allocate_section_policy = ALLOCATE_FORWARD_NOHINT;
 	F2FS_ROOT_INO(sbi) = le32_to_cpu(raw_super->root_ino);
-	F2FS_NODE_INO(sbi) = le32_to_cpu(raw_super->node_ino);
 	sbi->cur_victim_sec = NULL_SECNO;
 	sbi->gc_mode = GC_NORMAL;
 	sbi->next_victim_seg[BG_GC] = NULL_SEGNO;
@@ -5096,7 +5075,7 @@ static void f2fs_restore_device_alias(struct f2fs_sb_info *sbi)
 {
 	struct inode *root = d_inode(sbi->sb->s_root);
 	struct f2fs_dir_entry *de;
-	struct folio *folio;
+	void *dentry_block = NULL;
 	int i;
 
 	if (!f2fs_sb_has_device_alias(sbi))
@@ -5111,7 +5090,7 @@ static void f2fs_restore_device_alias(struct f2fs_sb_info *sbi)
 		qstr.name = name;
 		qstr.len = strlen(name);
 
-		de = f2fs_find_entry(root, &qstr, &folio);
+		de = f2fs_find_entry(root, &qstr, &dentry_block);
 		if (!de)
 			continue;
 
@@ -5121,7 +5100,7 @@ static void f2fs_restore_device_alias(struct f2fs_sb_info *sbi)
 				FDEV(i).has_alias = true;
 			iput(inode);
 		}
-		f2fs_folio_put(folio, 0);
+		f2fs_put_dentry_block(dentry_block, false);
 	}
 }
 
@@ -5385,33 +5364,25 @@ static int f2fs_fill_super(struct super_block *sb, struct fs_context *fc)
 	if (err)
 		goto free_nm;
 
-	/* get an inode for node space */
-	sbi->node_inode = f2fs_iget(sb, F2FS_NODE_INO(sbi));
-	if (IS_ERR(sbi->node_inode)) {
-		f2fs_err(sbi, "Failed to read node inode");
-		err = PTR_ERR(sbi->node_inode);
-		goto free_stats;
-	}
-
 	/* read root inode and dentry */
 	root = f2fs_iget(sb, F2FS_ROOT_INO(sbi));
 	if (IS_ERR(root)) {
 		f2fs_err(sbi, "Failed to read root inode");
 		err = PTR_ERR(root);
-		goto free_node_inode;
+		goto free_ino_entry;
 	}
 	if (!S_ISDIR(root->i_mode) || !root->i_blocks ||
 			!root->i_size || !root->i_nlink) {
 		iput(root);
 		err = -EINVAL;
-		goto free_node_inode;
+		goto free_ino_entry;
 	}
 
 	generic_set_sb_d_ops(sb);
 	sb->s_root = d_make_root(root); /* allocate root dentry */
 	if (!sb->s_root) {
 		err = -ENOMEM;
-		goto free_node_inode;
+		goto free_ino_entry;
 	}
 
 	err = f2fs_init_compress_inode(sbi);
@@ -5582,7 +5553,7 @@ static int f2fs_fill_super(struct super_block *sb, struct fs_context *fc)
 	 * Some dirty meta pages can be produced by f2fs_recover_orphan_inodes()
 	 * failed by EIO. Then, iput(node_inode) can trigger balance_fs_bg()
 	 * followed by f2fs_write_checkpoint() through f2fs_write_node_pages(), which
-	 * falls into an infinite loop in f2fs_sync_meta_pages().
+	 * falls into an infinite loop in f2fs_sync_meta_caches().
 	 */
 	f2fs_truncate_meta_caches(sbi, 0, ULONG_MAX);
 	/* evict some inodes being cached by GC */
@@ -5593,12 +5564,9 @@ static int f2fs_fill_super(struct super_block *sb, struct fs_context *fc)
 free_root_inode:
 	dput(sb->s_root);
 	sb->s_root = NULL;
-free_node_inode:
+free_ino_entry:
 	f2fs_release_ino_entry(sbi, true);
-	truncate_inode_pages_final(NODE_MAPPING(sbi));
-	iput(sbi->node_inode);
-	sbi->node_inode = NULL;
-free_stats:
+	f2fs_truncate_node_caches(sbi, 0, ULONG_MAX);
 	f2fs_destroy_stats(sbi);
 free_nm:
 	/* stop discard thread before destroying node manager */
diff --git a/fs/f2fs/xattr.c b/fs/f2fs/xattr.c
index 98059e583b09..4328c9d9de45 100644
--- a/fs/f2fs/xattr.c
+++ b/fs/f2fs/xattr.c
@@ -138,7 +138,7 @@ static int f2fs_xattr_advise_set(const struct xattr_handler *handler,
 
 #ifdef CONFIG_F2FS_FS_SECURITY
 static int f2fs_initxattrs(struct inode *inode, const struct xattr *xattr_array,
-		void *folio)
+		void *fs_data)
 {
 	const struct xattr *xattr;
 	int err = 0;
@@ -146,7 +146,7 @@ static int f2fs_initxattrs(struct inode *inode, const struct xattr *xattr_array,
 	for (xattr = xattr_array; xattr->name != NULL; xattr++) {
 		err = f2fs_setxattr(inode, F2FS_XATTR_INDEX_SECURITY,
 				xattr->name, xattr->value,
-				xattr->value_len, folio, 0);
+				xattr->value_len, fs_data, 0);
 		if (err < 0)
 			break;
 	}
@@ -154,10 +154,10 @@ static int f2fs_initxattrs(struct inode *inode, const struct xattr *xattr_array,
 }
 
 int f2fs_init_security(struct inode *inode, struct inode *dir,
-				const struct qstr *qstr, struct folio *ifolio)
+				const struct qstr *qstr, struct f2fs_cached_block *ientry)
 {
 	return security_inode_init_security(inode, dir, qstr,
-				f2fs_initxattrs, ifolio);
+				f2fs_initxattrs, ientry);
 }
 #endif
 
@@ -273,25 +273,25 @@ static struct f2fs_xattr_entry *__find_inline_xattr(struct inode *inode,
 	return entry;
 }
 
-static int read_inline_xattr(struct inode *inode, struct folio *ifolio,
+static int read_inline_xattr(struct inode *inode, struct f2fs_cached_block *ientry,
 							void *txattr_addr)
 {
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
 	unsigned int inline_size = inline_xattr_size(inode);
-	struct folio *folio = NULL;
+	struct f2fs_cached_block *in_entry = NULL;
 	void *inline_addr;
 
-	if (ifolio) {
-		inline_addr = inline_xattr_addr(inode, ifolio);
+	if (ientry) {
+		inline_addr = inline_xattr_addr(inode, ientry);
 	} else {
-		folio = f2fs_get_inode_folio(sbi, inode->i_ino);
-		if (IS_ERR(folio))
-			return PTR_ERR(folio);
+		in_entry = f2fs_get_inode_cache(sbi, inode->i_ino);
+		if (IS_ERR(in_entry))
+			return PTR_ERR(in_entry);
 
-		inline_addr = inline_xattr_addr(inode, folio);
+		inline_addr = inline_xattr_addr(inode, in_entry);
 	}
 	memcpy(txattr_addr, inline_addr, inline_size);
-	f2fs_folio_put(folio, true);
+	f2fs_put_cache(in_entry, true);
 
 	return 0;
 }
@@ -301,23 +301,23 @@ static int read_xattr_block(struct inode *inode, void *txattr_addr)
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
 	nid_t xnid = F2FS_I(inode)->i_xattr_nid;
 	unsigned int inline_size = inline_xattr_size(inode);
-	struct folio *xfolio;
+	struct f2fs_cached_block *xentry;
 	void *xattr_addr;
 
 	/* The inode already has an extended attribute block. */
-	xfolio = f2fs_get_xnode_folio(sbi, xnid);
-	if (IS_ERR(xfolio))
-		return PTR_ERR(xfolio);
+	xentry = f2fs_get_xnode_cache(sbi, xnid);
+	if (IS_ERR(xentry))
+		return PTR_ERR(xentry);
 
-	xattr_addr = folio_address(xfolio);
+	xattr_addr = cache_address(xentry);
 	memcpy(txattr_addr + inline_size, xattr_addr,
 	       VALID_XATTR_BLOCK_SIZE(inode));
-	f2fs_folio_put(xfolio, true);
+	f2fs_put_cache(xentry, true);
 
 	return 0;
 }
 
-static int lookup_all_xattrs(struct inode *inode, struct folio *ifolio,
+static int lookup_all_xattrs(struct inode *inode, struct f2fs_cached_block *ientry,
 				unsigned int index, unsigned int len,
 				const char *name, struct f2fs_xattr_entry **xe,
 				void **base_addr, int *base_size,
@@ -341,7 +341,7 @@ static int lookup_all_xattrs(struct inode *inode, struct folio *ifolio,
 
 	/* read from inline xattr */
 	if (inline_size) {
-		err = read_inline_xattr(inode, ifolio, txattr_addr);
+		err = read_inline_xattr(inode, ientry, txattr_addr);
 		if (err)
 			goto out;
 
@@ -389,7 +389,7 @@ static int lookup_all_xattrs(struct inode *inode, struct folio *ifolio,
 	return err;
 }
 
-static int read_all_xattrs(struct inode *inode, struct folio *ifolio,
+static int read_all_xattrs(struct inode *inode, struct f2fs_cached_block *ientry,
 							void **base_addr)
 {
 	struct f2fs_xattr_header *header;
@@ -406,7 +406,7 @@ static int read_all_xattrs(struct inode *inode, struct folio *ifolio,
 
 	/* read from inline xattr */
 	if (inline_size) {
-		err = read_inline_xattr(inode, ifolio, txattr_addr);
+		err = read_inline_xattr(inode, ientry, txattr_addr);
 		if (err)
 			goto fail;
 	}
@@ -433,14 +433,14 @@ static int read_all_xattrs(struct inode *inode, struct folio *ifolio,
 }
 
 static inline int write_all_xattrs(struct inode *inode, __u32 hsize,
-				void *txattr_addr, struct folio *ifolio)
+				void *txattr_addr, struct f2fs_cached_block *ientry)
 {
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
 	size_t inline_size = inline_xattr_size(inode);
-	struct folio *in_folio = NULL;
+	struct f2fs_cached_block *in_entry = NULL;
 	void *xattr_addr;
 	void *inline_addr = NULL;
-	struct folio *xfolio;
+	struct f2fs_cached_block *xentry;
 	nid_t new_nid = 0;
 	int err = 0;
 
@@ -450,56 +450,55 @@ static inline int write_all_xattrs(struct inode *inode, __u32 hsize,
 
 	/* write to inline xattr */
 	if (inline_size) {
-		if (ifolio) {
-			inline_addr = inline_xattr_addr(inode, ifolio);
+		if (ientry) {
+			inline_addr = inline_xattr_addr(inode, ientry);
 		} else {
-			in_folio = f2fs_get_inode_folio(sbi, inode->i_ino);
-			if (IS_ERR(in_folio)) {
+			in_entry = f2fs_get_inode_cache(sbi, inode->i_ino);
+			if (IS_ERR(in_entry)) {
 				f2fs_alloc_nid_failed(sbi, new_nid);
-				return PTR_ERR(in_folio);
+				return PTR_ERR(in_entry);
 			}
-			inline_addr = inline_xattr_addr(inode, in_folio);
+			inline_addr = inline_xattr_addr(inode, in_entry);
 		}
 
-		f2fs_folio_wait_writeback(ifolio ? ifolio : in_folio,
-							NODE, true, true);
+		f2fs_cache_wait_writeback(ientry ? ientry : in_entry);
 		/* no need to use xattr node block */
 		if (hsize <= inline_size) {
 			err = f2fs_truncate_xattr_node(inode);
 			f2fs_alloc_nid_failed(sbi, new_nid);
 			if (err) {
-				f2fs_folio_put(in_folio, true);
+				f2fs_put_cache(in_entry, true);
 				return err;
 			}
 			memcpy(inline_addr, txattr_addr, inline_size);
-			folio_mark_dirty(ifolio ? ifolio : in_folio);
+			f2fs_mark_cache_dirty(ientry ? ientry : in_entry);
 			goto in_page_out;
 		}
 	}
 
 	/* write to xattr node block */
 	if (F2FS_I(inode)->i_xattr_nid) {
-		xfolio = f2fs_get_xnode_folio(sbi, F2FS_I(inode)->i_xattr_nid);
-		if (IS_ERR(xfolio)) {
-			err = PTR_ERR(xfolio);
+		xentry = f2fs_get_xnode_cache(sbi, F2FS_I(inode)->i_xattr_nid);
+		if (IS_ERR(xentry)) {
+			err = PTR_ERR(xentry);
 			f2fs_alloc_nid_failed(sbi, new_nid);
 			goto in_page_out;
 		}
 		f2fs_bug_on(sbi, new_nid);
-		f2fs_folio_wait_writeback(xfolio, NODE, true, true);
+		f2fs_cache_wait_writeback(xentry);
 	} else {
 		struct dnode_of_data dn;
 
 		set_new_dnode(&dn, inode, NULL, NULL, new_nid);
-		xfolio = f2fs_new_node_folio(&dn, XATTR_NODE_OFFSET);
-		if (IS_ERR(xfolio)) {
-			err = PTR_ERR(xfolio);
+		xentry = f2fs_new_node_cache(&dn, XATTR_NODE_OFFSET);
+		if (IS_ERR(xentry)) {
+			err = PTR_ERR(xentry);
 			f2fs_alloc_nid_failed(sbi, new_nid);
 			goto in_page_out;
 		}
 		f2fs_alloc_nid_done(sbi, new_nid);
 	}
-	xattr_addr = folio_address(xfolio);
+	xattr_addr = cache_address(xentry);
 
 	if (inline_size)
 		memcpy(inline_addr, txattr_addr, inline_size);
@@ -507,19 +506,19 @@ static inline int write_all_xattrs(struct inode *inode, __u32 hsize,
 	       VALID_XATTR_BLOCK_SIZE(inode));
 
 	if (inline_size)
-		folio_mark_dirty(ifolio ? ifolio : in_folio);
-	folio_mark_dirty(xfolio);
+		f2fs_mark_cache_dirty(ientry ? ientry : in_entry);
+	f2fs_mark_cache_dirty(xentry);
 
-	f2fs_folio_put(xfolio, true);
+	f2fs_put_cache(xentry, true);
 in_page_out:
-	f2fs_folio_put(in_folio, true);
+	f2fs_put_cache(in_entry, true);
 	return err;
 }
 
 int f2fs_getxattr(struct inode *inode, int index, const char *name,
-		void *buffer, size_t buffer_size, struct folio *ifolio)
+		void *buffer, size_t buffer_size, struct f2fs_cached_block *ientry)
 {
-	struct f2fs_xattr_entry *entry = NULL;
+	struct f2fs_xattr_entry *xe = NULL;
 	int error;
 	unsigned int size, len;
 	void *base_addr = NULL;
@@ -533,16 +532,16 @@ int f2fs_getxattr(struct inode *inode, int index, const char *name,
 	if (len > F2FS_NAME_LEN)
 		return -ERANGE;
 
-	if (!ifolio)
+	if (!ientry)
 		f2fs_down_read(&F2FS_I(inode)->i_xattr_sem);
-	error = lookup_all_xattrs(inode, ifolio, index, len, name,
-				&entry, &base_addr, &base_size, &is_inline);
-	if (!ifolio)
+	error = lookup_all_xattrs(inode, ientry, index, len, name,
+				&xe, &base_addr, &base_size, &is_inline);
+	if (!ientry)
 		f2fs_up_read(&F2FS_I(inode)->i_xattr_sem);
 	if (error)
 		return error;
 
-	size = le16_to_cpu(entry->e_value_size);
+	size = le16_to_cpu(xe->e_value_size);
 
 	if (buffer && size > buffer_size) {
 		error = -ERANGE;
@@ -550,7 +549,7 @@ int f2fs_getxattr(struct inode *inode, int index, const char *name,
 	}
 
 	if (buffer) {
-		char *pval = entry->e_name + entry->e_name_len;
+		char *pval = xe->e_name + xe->e_name_len;
 
 		if (base_size - (pval - (char *)base_addr) < size) {
 			error = -ERANGE;
@@ -634,7 +633,7 @@ static bool f2fs_xattr_value_same(struct f2fs_xattr_entry *entry,
 
 static int __f2fs_setxattr(struct inode *inode, int index,
 			const char *name, const void *value, size_t size,
-			struct folio *ifolio, int flags)
+			struct f2fs_cached_block *ientry, int flags)
 {
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
 	struct f2fs_xattr_entry *here, *last;
@@ -658,7 +657,7 @@ static int __f2fs_setxattr(struct inode *inode, int index,
 	if (size > MAX_VALUE_LEN(inode))
 		return -E2BIG;
 retry:
-	error = read_all_xattrs(inode, ifolio, &base_addr);
+	error = read_all_xattrs(inode, ientry, &base_addr);
 	if (error)
 		return error;
 
@@ -775,7 +774,7 @@ static int __f2fs_setxattr(struct inode *inode, int index,
 		*(u32 *)((u8 *)last + newsize) = 0;
 	}
 
-	error = write_all_xattrs(inode, new_hsize, base_addr, ifolio);
+	error = write_all_xattrs(inode, new_hsize, base_addr, ientry);
 	if (error)
 		goto exit;
 
@@ -809,7 +808,7 @@ static int __f2fs_setxattr(struct inode *inode, int index,
 
 int f2fs_setxattr(struct inode *inode, int index, const char *name,
 				const void *value, size_t size,
-				struct folio *ifolio, int flags)
+				struct f2fs_cached_block *ientry, int flags)
 {
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
 	struct f2fs_lock_context lc;
@@ -825,9 +824,9 @@ int f2fs_setxattr(struct inode *inode, int index, const char *name,
 		return err;
 
 	/* this case is only from f2fs_init_inode_metadata */
-	if (ifolio)
+	if (ientry)
 		return __f2fs_setxattr(inode, index, name, value,
-						size, ifolio, flags);
+						size, ientry, flags);
 	f2fs_balance_fs(sbi, true);
 
 	f2fs_lock_op(sbi, &lc);
diff --git a/fs/f2fs/xattr.h b/fs/f2fs/xattr.h
index 75beab2d1ee3..870524b667ed 100644
--- a/fs/f2fs/xattr.h
+++ b/fs/f2fs/xattr.h
@@ -131,9 +131,9 @@ extern const struct xattr_handler f2fs_xattr_security_handler;
 extern const struct xattr_handler * const f2fs_xattr_handlers[];
 
 int f2fs_setxattr(struct inode *, int, const char *, const void *,
-		size_t, struct folio *, int);
+		size_t, struct f2fs_cached_block *, int);
 int f2fs_getxattr(struct inode *, int, const char *, void *,
-		size_t, struct folio *);
+		size_t, struct f2fs_cached_block *);
 ssize_t f2fs_listxattr(struct dentry *, char *, size_t);
 int __init f2fs_init_xattr_cache(void);
 void f2fs_destroy_xattr_cache(void);
@@ -143,13 +143,13 @@ void f2fs_destroy_xattr_cache(void);
 #define f2fs_listxattr		NULL
 static inline int f2fs_setxattr(struct inode *inode, int index,
 		const char *name, const void *value, size_t size,
-		struct folio *folio, int flags)
+		struct f2fs_cached_block *ientry, int flags)
 {
 	return -EOPNOTSUPP;
 }
 static inline int f2fs_getxattr(struct inode *inode, int index,
 			const char *name, void *buffer,
-			size_t buffer_size, struct folio *dfolio)
+			size_t buffer_size, struct f2fs_cached_block *ientry)
 {
 	return -EOPNOTSUPP;
 }
@@ -159,10 +159,10 @@ static inline void f2fs_destroy_xattr_cache(void) { }
 
 #ifdef CONFIG_F2FS_FS_SECURITY
 int f2fs_init_security(struct inode *, struct inode *,
-				const struct qstr *, struct folio *);
+				const struct qstr *, struct f2fs_cached_block *);
 #else
 static inline int f2fs_init_security(struct inode *inode, struct inode *dir,
-				const struct qstr *qstr, struct folio *ifolio)
+				const struct qstr *qstr, struct f2fs_cached_block *ientry)
 {
 	return 0;
 }
diff --git a/include/linux/f2fs_fs.h b/include/linux/f2fs_fs.h
index c325904f461e..ac87446cc086 100644
--- a/include/linux/f2fs_fs.h
+++ b/include/linux/f2fs_fs.h
@@ -43,7 +43,6 @@
 #define F2FS_RESERVED_NODE_NUM		3
 
 #define F2FS_ROOT_INO(sbi)	((sbi)->root_ino_num)
-#define F2FS_NODE_INO(sbi)	((sbi)->node_ino_num)
 #define F2FS_COMPRESS_INO(sbi)	(NM_I(sbi)->max_nid)
 
 #define F2FS_MAX_QUOTAS		3
-- 
2.49.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
