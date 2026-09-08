Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D490C79FA1
	for <linux-f2fs-devel@archiver.kernel.org>; Tue,  8 Sep 2026 10:01:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:Message-ID:Date:To:Sender:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=PIY0j0tVriU9CK7f5SgKt29aGXg9fifft5JVvmB8lmU=; b=H3a7iV2fJko649zmeo0RYTgcE0
	o6iEGDmqyqHRtRrDL7nufaNvKWkQu0aqeYJfYvPMqFJnortkVRPpXnp0XKS59ByO40RURVEpbIsok
	38zQA3mLHgMRAfOpBl0Al/HjxbPELQx55ci3fhGnoe0V1UpG+ta9QLtSlaMVb0NBixNo=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1x3sdg-000296-PC;
	Tue, 08 Sep 2026 10:01:14 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1x3sdN-00027T-Hj
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 08 Sep 2026 10:00:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=9n0OBzeeVafI+WAJuC2WRatpH8lscT7nNGlS08ATkbw=; b=WomrezkgbxKex4PmYyiwF/Nd8K
 AhJj0UjEPYc4HMwoe98p1gVOrZvKErHnEnqJdFlXSApQYqbr1MLtOoSdeP/VxxnYSvtjmP2dPfg8q
 CyB2Ym8bVLMRRQTbXlY01mZotp9ddQFaZ9GbIK2Fl8XwptDsDkGCg2eIrGj682NVsgcc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=9n0OBzeeVafI+WAJuC2WRatpH8lscT7nNGlS08ATkbw=; b=H
 Q2VyYVPejOLkk2CZH4o9ABVG06VzRJXdoXAd//rwzxcZDuIlq9sWf0NWd3LlaHTkeE8zzn6MgX3Pw
 /mPLUjTo2g8MucUa8yv05YICO12c0t6oDzn5SV4ElrdViyxrB7RHuMmYVyDsMW0e2CdWOzVG1+WgR
 78k21tRJM45qM3OU=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1x3sdB-0000kE-Hm for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 08 Sep 2026 10:00:49 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id CA99260A97
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue,  8 Sep 2026 10:00:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E52C1F00A3A;
 Tue,  8 Sep 2026 10:00:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788861639;
 bh=9n0OBzeeVafI+WAJuC2WRatpH8lscT7nNGlS08ATkbw=;
 h=From:To:Cc:Subject:Date;
 b=kyVNSXa7oHObL69ZMKypxB94I30AWTrtDXH20u/caVn3dwqBIC4oT7LmDrZQcYJPj
 L02nMCw02XVDQwk70qiYs1wxVvJY6eQyrNWSHt/QYW0JntZZ0ENUU5jdLf2JfwUUyV
 B8A7rtdrmlCINgsXgts/NQZ/uuCZvUB9S+j2E7/7FPyiwDQ3FV946HLrf93q9YvjZ7
 Nyblzs/gpE2Wnhz07SYbW4VWF/n7uoYXWW7wyB2tL5S6XI0miXKoenK4lPpgM4uNpc
 KEOpgLbyT0Yl9scd+FbaUBlxcPqYglL6FAj77r5shyRseGDuDXV61kiVqhKPV25l6l
 Fe4zThY10D/1g==
To: jaegeuk@kernel.org
Date: Tue,  8 Sep 2026 18:00:32 +0800
Message-ID: <20260908100032.3141988-1-chao@kernel.org>
X-Mailer: git-send-email 2.55.0.979.g7e5102b832-goog
MIME-Version: 1.0
X-Headers-End: 1x3sdB-0000kE-Hm
Subject: [f2fs-dev] [PATCH] f2fs: parameterize node helpers and macros
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

In gang-lookup loops such as last_fsync_dnode(), f2fs_sync_node_pages(),
and f2fs_fsync_node_pages(), candidate dirty node folios returned by
filemap_get_folios_tag() are inspected and filtered before acquiring
their folio locks:
- IS_DNODE
- is_cold_node
- ino_of_node
- ofs_of_node (called by IS_DNODE)

These helpers previously relied on F2FS_F_SB(folio) which dereferences
folio->mapping to obtain sbi. This can suffer a race condition with
concurrent node truncation, causing a NULL pointer dereference panic:

Thread A                            Thread B
- f2fs_sync_node_pages
  - filemap_get_folios_tag
                                    - truncate_node
                                      - invalidate_mapping_pages
                                        - filemap_remove_folio
                                          - folio->mapping = NULL
- IS_DNODE
  - F2FS_F_SB
    - folio->mapping->host (panic)

To resolve this race condition, pass struct f2fs_sb_info *sbi explicitly
to these helpers.

All these helpers fundamentally rely on F2FS_NODE_FOOTER(), which
dynamically locates the node footer at:
folio_address(folio) + F2FS_BLKSIZE(sbi) - sizeof(struct node_footer).
Consequently, F2FS_NODE_FOOTER() and its direct sibling footer accessors:
- IS_INODE
- nid_of_node
- cpver_of_node
- next_blkaddr_of_node
are also parameterized with struct f2fs_sb_info *sbi.

In get_dnode_base() and get_dnode_addr(), derive sbi safely via
`inode ? F2FS_I_SB(inode) : F2FS_F_SB(node_folio)` to support callers
passing NULL inode (e.g. is_alive()).

Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/data.c          |  14 ++---
 fs/f2fs/extent_cache.c  |   4 +-
 fs/f2fs/f2fs.h          |  29 ++++++----
 fs/f2fs/file.c          |   4 +-
 fs/f2fs/gc.c            |   4 +-
 fs/f2fs/inline.c        |   4 +-
 fs/f2fs/inode.c         |  16 +++---
 fs/f2fs/node.c          | 116 ++++++++++++++++++++--------------------
 fs/f2fs/node.h          | 104 +++++++++++++++++++----------------
 fs/f2fs/recovery.c      |  62 ++++++++++-----------
 fs/f2fs/segment.c       |   8 +--
 include/linux/f2fs_fs.h |   2 +-
 12 files changed, 195 insertions(+), 172 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index ebb0275aa8ff..93ed8416a289 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -362,7 +362,7 @@ static void f2fs_write_end_bio(struct bio *bio)
 		if (is_node_folio(folio)) {
 			f2fs_sanity_check_node_footer(sbi, folio,
 				folio->index, NODE_TYPE_REGULAR, true);
-			f2fs_bug_on(sbi, folio->index != nid_of_node(folio));
+			f2fs_bug_on(sbi, folio->index != nid_of_node(sbi, folio));
 		}
 		if (f2fs_in_warm_node_list(folio))
 			f2fs_del_fsync_node_entry(sbi, folio);
@@ -592,8 +592,8 @@ static void __submit_merged_bio(struct f2fs_bio_info *io)
 	io->bio = NULL;
 }
 
-static bool __has_merged_page(struct bio *bio, struct inode *inode,
-						struct folio *folio, nid_t ino)
+static bool __has_merged_page(struct f2fs_sb_info *sbi, struct bio *bio,
+			struct inode *inode, struct folio *folio, nid_t ino)
 {
 	struct folio_iter fi;
 
@@ -616,7 +616,7 @@ static bool __has_merged_page(struct bio *bio, struct inode *inode,
 			return true;
 		if (folio && folio == target)
 			return true;
-		if (ino && ino == ino_of_node(target))
+		if (ino && ino == ino_of_node(sbi, target))
 			return true;
 	}
 
@@ -699,7 +699,7 @@ static void __submit_merged_write_cond(struct f2fs_sb_info *sbi,
 			struct f2fs_lock_context lc;
 
 			f2fs_down_read_trace(&io->io_rwsem, &lc);
-			ret = __has_merged_page(io->bio, inode, folio, ino);
+			ret = __has_merged_page(io->sbi, io->bio, inode, folio, ino);
 			f2fs_up_read_trace(&io->io_rwsem, &lc);
 		}
 		if (ret) {
@@ -907,7 +907,7 @@ void f2fs_submit_merged_ipu_write(struct f2fs_sb_info *sbi,
 			if (target)
 				found = (target == be->bio);
 			else
-				found = __has_merged_page(be->bio, NULL,
+				found = __has_merged_page(sbi, be->bio, NULL,
 							folio, 0);
 			if (found)
 				break;
@@ -924,7 +924,7 @@ void f2fs_submit_merged_ipu_write(struct f2fs_sb_info *sbi,
 			if (target)
 				found = (target == be->bio);
 			else
-				found = __has_merged_page(be->bio, NULL,
+				found = __has_merged_page(sbi, be->bio, NULL,
 							folio, 0);
 			if (found) {
 				target = be->bio;
diff --git a/fs/f2fs/extent_cache.c b/fs/f2fs/extent_cache.c
index 57217dc5b310..40cd87940961 100644
--- a/fs/f2fs/extent_cache.c
+++ b/fs/f2fs/extent_cache.c
@@ -957,8 +957,8 @@ static void __update_extent_cache(struct dnode_of_data *dn, enum extent_type typ
 	if (!__may_extent_tree(dn->inode, type))
 		return;
 
-	ei.fofs = f2fs_start_bidx_of_node(ofs_of_node(dn->node_folio), dn->inode) +
-								dn->ofs_in_node;
+	ei.fofs = f2fs_start_bidx_of_node(ofs_of_node(F2FS_I_SB(dn->inode),
+				dn->node_folio), dn->inode) + dn->ofs_in_node;
 	ei.len = 1;
 
 	if (type == EX_READ) {
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 62efc25cd107..693153cbd8a0 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -2311,9 +2311,10 @@ static inline struct f2fs_checkpoint *F2FS_CKPT(struct f2fs_sb_info *sbi)
 	return (struct f2fs_checkpoint *)(sbi->ckpt);
 }
 
-static inline struct node_footer *F2FS_NODE_FOOTER(const struct folio *folio)
+static inline struct node_footer *F2FS_NODE_FOOTER(struct f2fs_sb_info *sbi,
+						const struct folio *folio)
 {
-	return folio_address(folio) + F2FS_BLKSIZE(F2FS_F_SB(folio)) -
+	return folio_address(folio) + F2FS_BLKSIZE(sbi) -
 		sizeof(struct node_footer);
 }
 
@@ -2327,9 +2328,10 @@ static inline struct f2fs_inode *F2FS_INODE(const struct folio *folio)
 	return &((struct f2fs_node *)folio_address(folio))->i;
 }
 
-static inline __le32 *F2FS_INODE_NIDS(const struct folio *folio)
+static inline __le32 *F2FS_INODE_NIDS(struct f2fs_sb_info *sbi,
+						const struct folio *folio)
 {
-	return folio_address(folio) + F2FS_BLKSIZE(F2FS_F_SB(folio)) -
+	return folio_address(folio) + F2FS_BLKSIZE(sbi) -
 		sizeof(struct node_footer) -
 		SIZE_OF_I_NID;
 }
@@ -3305,9 +3307,9 @@ static inline void f2fs_radix_tree_insert(struct radix_tree_root *root,
 		cond_resched();
 }
 
-static inline bool IS_INODE(const struct folio *folio)
+static inline bool IS_INODE(struct f2fs_sb_info *sbi, const struct folio *folio)
 {
-	struct node_footer *footer = F2FS_NODE_FOOTER(folio);
+	struct node_footer *footer = F2FS_NODE_FOOTER(sbi, folio);
 
 	return footer->nid == footer->ino;
 }
@@ -3318,18 +3320,22 @@ static inline int offset_in_addr(struct f2fs_inode *i)
 			(le16_to_cpu(i->i_extra_isize) / sizeof(__le32)) : 0;
 }
 
-static inline __le32 *blkaddr_in_node(const struct folio *folio)
+static inline __le32 *blkaddr_in_node(struct f2fs_sb_info *sbi,
+						const struct folio *folio)
 {
 	struct f2fs_node *node = F2FS_NODE(folio);
 
-	return IS_INODE(folio) ? node->i.i_addr : node->dn.addr;
+	return IS_INODE(sbi, folio) ? node->i.i_addr : node->dn.addr;
 }
 
 static inline int f2fs_has_extra_attr(struct inode *inode);
 static inline unsigned int get_dnode_base(struct inode *inode,
 					struct folio *node_folio)
 {
-	if (!IS_INODE(node_folio))
+	struct f2fs_sb_info *sbi = inode ? F2FS_I_SB(inode) :
+					F2FS_F_SB(node_folio);
+
+	if (!IS_INODE(sbi, node_folio))
 		return 0;
 
 	return inode ? get_extra_isize(inode) :
@@ -3339,7 +3345,10 @@ static inline unsigned int get_dnode_base(struct inode *inode,
 static inline __le32 *get_dnode_addr(struct inode *inode,
 					struct folio *node_folio)
 {
-	return blkaddr_in_node(node_folio) +
+	struct f2fs_sb_info *sbi = inode ? F2FS_I_SB(inode) :
+					F2FS_F_SB(node_folio);
+
+	return blkaddr_in_node(sbi, node_folio) +
 			get_dnode_base(inode, node_folio);
 }
 
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index c763fb972e8a..b0bdc7a977b9 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -784,7 +784,7 @@ void f2fs_truncate_data_blocks_range(struct dnode_of_data *dn, int count)
 		 * once we invalidate valid blkaddr in range [ofs, ofs + count],
 		 * we will invalidate all blkaddr in the whole range.
 		 */
-		fofs = f2fs_start_bidx_of_node(ofs_of_node(dn->node_folio),
+		fofs = f2fs_start_bidx_of_node(ofs_of_node(sbi, dn->node_folio),
 							dn->inode) + ofs;
 		f2fs_update_read_extent_cache_range(dn, fofs, 0, len);
 		f2fs_update_age_extent_cache_range(dn, fofs, len);
@@ -903,7 +903,7 @@ int f2fs_do_truncate_blocks(struct inode *inode, u64 from, bool lock)
 	count -= dn.ofs_in_node;
 	f2fs_bug_on(sbi, count < 0);
 
-	if (dn.ofs_in_node || IS_INODE(dn.node_folio)) {
+	if (dn.ofs_in_node || IS_INODE(sbi, dn.node_folio)) {
 		f2fs_truncate_data_blocks_range(&dn, count);
 		free_from += count;
 	}
diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index bc22dde1cb30..aedb45c8ee4a 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -1176,7 +1176,7 @@ static bool is_alive(struct f2fs_sb_info *sbi, struct f2fs_summary *sum,
 		return false;
 	}
 
-	if (IS_INODE(node_folio)) {
+	if (IS_INODE(sbi, node_folio)) {
 		base = offset_in_addr(F2FS_INODE(node_folio));
 		max_addrs = DEF_ADDRS_PER_INODE(sbi);
 	} else {
@@ -1191,7 +1191,7 @@ static bool is_alive(struct f2fs_sb_info *sbi, struct f2fs_summary *sum,
 		return false;
 	}
 
-	*nofs = ofs_of_node(node_folio);
+	*nofs = ofs_of_node(sbi, node_folio);
 	source_blkaddr = data_blkaddr(NULL, node_folio, ofs_in_node);
 	f2fs_folio_put(node_folio, true);
 
diff --git a/fs/f2fs/inline.c b/fs/f2fs/inline.c
index 3e0b9449ffba..925bdaad013c 100644
--- a/fs/f2fs/inline.c
+++ b/fs/f2fs/inline.c
@@ -42,7 +42,7 @@ static bool inode_has_blocks(struct inode *inode, struct folio *ifolio)
 		return true;
 
 	for (i = 0; i < DEF_NIDS_PER_INODE; i++) {
-		if (F2FS_INODE_NIDS(ifolio)[i])
+		if (F2FS_INODE_NIDS(F2FS_I_SB(inode), ifolio)[i])
 			return true;
 	}
 	return false;
@@ -307,7 +307,7 @@ int f2fs_recover_inline_data(struct inode *inode, struct folio *nfolio)
 	 *    x       o  -> remove data blocks, and then recover inline_data
 	 *    x       x  -> recover data blocks
 	 */
-	if (IS_INODE(nfolio))
+	if (IS_INODE(F2FS_I_SB(inode), nfolio))
 		ri = F2FS_INODE(nfolio);
 
 	if (f2fs_has_inline_data(inode) &&
diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
index 82ebcb338b0c..50f00286020b 100644
--- a/fs/f2fs/inode.c
+++ b/fs/f2fs/inode.c
@@ -138,7 +138,7 @@ bool f2fs_enable_inode_chksum(struct f2fs_sb_info *sbi, struct folio *folio)
 	if (!f2fs_sb_has_inode_chksum(sbi))
 		return false;
 
-	if (!IS_INODE(folio) || !(ri->i_inline & F2FS_EXTRA_ATTR))
+	if (!IS_INODE(sbi, folio) || !(ri->i_inline & F2FS_EXTRA_ATTR))
 		return false;
 
 	if (!F2FS_FITS_IN_INODE(ri, le16_to_cpu(ri->i_extra_isize),
@@ -151,7 +151,7 @@ bool f2fs_enable_inode_chksum(struct f2fs_sb_info *sbi, struct folio *folio)
 static __u32 f2fs_inode_chksum(struct f2fs_sb_info *sbi, struct folio *folio)
 {
 	struct f2fs_inode *ri = F2FS_INODE(folio);
-	__le32 ino = F2FS_NODE_FOOTER(folio)->ino;
+	__le32 ino = F2FS_NODE_FOOTER(sbi, folio)->ino;
 	__le32 gen = ri->i_generation;
 	__u32 chksum, chksum_seed;
 	__u32 dummy_cs = 0;
@@ -192,7 +192,7 @@ bool f2fs_inode_chksum_verify(struct f2fs_sb_info *sbi, struct folio *folio)
 
 	if (provided != calculated)
 		f2fs_warn(sbi, "checksum invalid, nid = %lu, ino_of_node = %x, %x vs. %x",
-			  folio->index, ino_of_node(folio),
+			  folio->index, ino_of_node(sbi, folio),
 			  provided, calculated);
 
 	return provided == calculated;
@@ -294,14 +294,14 @@ static bool sanity_check_inode(struct inode *inode, struct folio *node_folio)
 		return false;
 	}
 
-	if (ino_of_node(node_folio) != nid_of_node(node_folio)) {
+	if (ino_of_node(sbi, node_folio) != nid_of_node(sbi, node_folio)) {
 		f2fs_warn(sbi, "%s: corrupted inode footer i_ino=%llx, ino,nid: [%u, %u] run fsck to fix.",
 			  __func__, inode->i_ino,
-			  ino_of_node(node_folio), nid_of_node(node_folio));
+			  ino_of_node(sbi, node_folio), nid_of_node(sbi, node_folio));
 		return false;
 	}
 
-	if (ino_of_node(node_folio) == fi->i_xattr_nid) {
+	if (ino_of_node(sbi, node_folio) == fi->i_xattr_nid) {
 		f2fs_warn(sbi, "%s: corrupted inode i_ino=%llx, xnid=%x, run fsck to fix.",
 			  __func__, inode->i_ino, fi->i_xattr_nid);
 		return false;
@@ -504,9 +504,9 @@ static int do_read_inode(struct inode *inode)
 		__recover_inline_status(inode, node_folio);
 
 	/* try to recover cold bit for non-dir inode */
-	if (!S_ISDIR(inode->i_mode) && !is_cold_node(node_folio)) {
+	if (!S_ISDIR(inode->i_mode) && !is_cold_node(sbi, node_folio)) {
 		f2fs_folio_wait_writeback(node_folio, NODE, true, true);
-		set_cold_node(node_folio, false);
+		set_cold_node(sbi, node_folio, false);
 		folio_mark_dirty(node_folio);
 	}
 
diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 68a95d703c4a..8c150d4966e5 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -334,7 +334,8 @@ static unsigned int __gang_lookup_nat_set(struct f2fs_nm_info *nm_i,
 
 bool f2fs_in_warm_node_list(struct folio *folio)
 {
-	return is_node_folio(folio) && IS_DNODE(folio) && is_cold_node(folio);
+	return is_node_folio(folio) && IS_DNODE(F2FS_F_SB(folio), folio) &&
+					is_cold_node(F2FS_F_SB(folio), folio);
 }
 
 void f2fs_init_fsync_node_info(struct f2fs_sb_info *sbi)
@@ -693,7 +694,7 @@ static void f2fs_ra_node_pages(struct folio *parent, int start, int n)
 	end = start + n;
 	end = min_t(int, end, NIDS_PER_BLOCK(sbi));
 	for (i = start; i < end; i++) {
-		nid = get_nid(parent, i, false);
+		nid = get_nid(sbi, parent, i, false);
 		f2fs_ra_node_page(sbi, nid);
 	}
 
@@ -856,7 +857,7 @@ int f2fs_get_dnode_of_data(struct dnode_of_data *dn, pgoff_t index, int mode)
 
 	parent = nfolio[0];
 	if (level != 0)
-		nids[1] = get_nid(parent, offset[0], true);
+		nids[1] = get_nid(sbi, parent, offset[0], true);
 	dn->inode_folio = nfolio[0];
 	dn->inode_folio_locked = true;
 
@@ -889,7 +890,7 @@ int f2fs_get_dnode_of_data(struct dnode_of_data *dn, pgoff_t index, int mode)
 				goto release_pages;
 			}
 
-			set_nid(parent, offset[i - 1], nids[i], i == 1);
+			set_nid(sbi, parent, offset[i - 1], nids[i], i == 1);
 			f2fs_alloc_nid_done(sbi, nids[i]);
 			done = true;
 		} else if (mode == LOOKUP_NODE_RA && i == level && level > 1) {
@@ -918,7 +919,7 @@ int f2fs_get_dnode_of_data(struct dnode_of_data *dn, pgoff_t index, int mode)
 		}
 		if (i < level) {
 			parent = nfolio[i];
-			nids[i + 1] = get_nid(parent, offset[i], false);
+			nids[i + 1] = get_nid(sbi, parent, offset[i], false);
 		}
 	}
 	dn->nid = nids[level];
@@ -1033,9 +1034,9 @@ static int truncate_dnode(struct dnode_of_data *dn)
 	else if (IS_ERR(folio))
 		return PTR_ERR(folio);
 
-	if (IS_INODE(folio) || ino_of_node(folio) != dn->inode->i_ino) {
+	if (IS_INODE(sbi, folio) || ino_of_node(sbi, folio) != dn->inode->i_ino) {
 		f2fs_err(sbi, "incorrect node reference, ino: %llu, nid: %u, ino_of_node: %u",
-				dn->inode->i_ino, dn->nid, ino_of_node(folio));
+				dn->inode->i_ino, dn->nid, ino_of_node(sbi, folio));
 		set_sbi_flag(sbi, SBI_NEED_FSCK);
 		f2fs_handle_error(sbi, ERROR_INVALID_NODE_REFERENCE);
 		f2fs_folio_put(folio, true);
@@ -1091,7 +1092,7 @@ static int truncate_nodes(struct dnode_of_data *dn, unsigned int nofs,
 			ret = truncate_dnode(&rdn);
 			if (ret < 0)
 				goto out_err;
-			if (set_nid(folio, i, 0, false))
+			if (set_nid(sbi, folio, i, 0, false))
 				dn->node_changed = true;
 		}
 	} else {
@@ -1105,7 +1106,7 @@ static int truncate_nodes(struct dnode_of_data *dn, unsigned int nofs,
 			rdn.nid = child_nid;
 			ret = truncate_nodes(&rdn, child_nofs, 0, depth - 1);
 			if (ret == (NIDS_PER_BLOCK(sbi) + 1)) {
-				if (set_nid(folio, i, 0, false))
+				if (set_nid(sbi, folio, i, 0, false))
 					dn->node_changed = true;
 				child_nofs += ret;
 			} else if (ret < 0 && ret != -ENOENT) {
@@ -1137,6 +1138,7 @@ static int truncate_nodes(struct dnode_of_data *dn, unsigned int nofs,
 static int truncate_partial_nodes(struct dnode_of_data *dn,
 			int *offset, int depth)
 {
+	struct f2fs_sb_info *sbi = F2FS_I_SB(dn->inode);
 	struct folio *folios[2];
 	nid_t nid[3];
 	nid_t child_nid;
@@ -1144,7 +1146,7 @@ static int truncate_partial_nodes(struct dnode_of_data *dn,
 	int i;
 	int idx = depth - 2;
 
-	nid[0] = get_nid(dn->inode_folio, offset[0], true);
+	nid[0] = get_nid(sbi, dn->inode_folio, offset[0], true);
 	if (!nid[0])
 		return 0;
 
@@ -1158,7 +1160,7 @@ static int truncate_partial_nodes(struct dnode_of_data *dn,
 			idx = i - 1;
 			goto fail;
 		}
-		nid[i + 1] = get_nid(folios[i], offset[i + 1], false);
+		nid[i + 1] = get_nid(sbi, folios[i], offset[i + 1], false);
 	}
 
 	f2fs_ra_node_pages(folios[idx], offset[idx + 1],
@@ -1167,14 +1169,14 @@ static int truncate_partial_nodes(struct dnode_of_data *dn,
 	/* free direct nodes linked to a partial indirect node */
 	for (i = offset[idx + 1];
 			i < NIDS_PER_BLOCK(F2FS_I_SB(dn->inode)); i++) {
-		child_nid = get_nid(folios[idx], i, false);
+		child_nid = get_nid(sbi, folios[idx], i, false);
 		if (!child_nid)
 			continue;
 		dn->nid = child_nid;
 		err = truncate_dnode(dn);
 		if (err < 0)
 			goto fail;
-		if (set_nid(folios[idx], i, 0, false))
+		if (set_nid(sbi, folios[idx], i, 0, false))
 			dn->node_changed = true;
 	}
 
@@ -1265,7 +1267,7 @@ int f2fs_truncate_inode_blocks(struct inode *inode, pgoff_t from)
 
 skip_partial:
 	while (cont) {
-		dn.nid = get_nid(folio, offset[0], true);
+		dn.nid = get_nid(sbi, folio, offset[0], true);
 		if (offset[0] == NODE_DIR1_BLOCK(sbi) ||
 		    offset[0] == NODE_DIR2_BLOCK(sbi)) {
 			err = truncate_dnode(&dn);
@@ -1279,7 +1281,7 @@ int f2fs_truncate_inode_blocks(struct inode *inode, pgoff_t from)
 			BUG();
 		}
 		if (err == -ENOENT) {
-			set_sbi_flag(F2FS_F_SB(folio), SBI_NEED_FSCK);
+			set_sbi_flag(sbi, SBI_NEED_FSCK);
 			f2fs_handle_error(sbi, ERROR_INVALID_BLKADDR);
 			fserror_report_file_metadata(dn.inode, -EFSCORRUPTED,
 								GFP_NOFS);
@@ -1292,10 +1294,10 @@ int f2fs_truncate_inode_blocks(struct inode *inode, pgoff_t from)
 		}
 		if (err < 0)
 			goto fail;
-		if (offset[1] == 0 && get_nid(folio, offset[0], true)) {
+		if (offset[1] == 0 && get_nid(sbi, folio, offset[0], true)) {
 			folio_lock(folio);
 			BUG_ON(!is_node_folio(folio));
-			set_nid(folio, offset[0], 0, true);
+			set_nid(sbi, folio, offset[0], 0, true);
 			folio_unlock(folio);
 		}
 		offset[1] = 0;
@@ -1439,8 +1441,8 @@ struct folio *f2fs_new_node_folio(struct dnode_of_data *dn, unsigned int ofs)
 	set_node_addr(sbi, &new_ni, NEW_ADDR, false);
 
 	f2fs_folio_wait_writeback(folio, NODE, true, true);
-	fill_node_footer(folio, dn->nid, dn->inode->i_ino, ofs, true);
-	set_cold_node(folio, S_ISDIR(dn->inode->i_mode));
+	fill_node_footer(sbi, folio, dn->nid, dn->inode->i_ino, ofs, true);
+	set_cold_node(sbi, folio, S_ISDIR(dn->inode->i_mode));
 	if (!folio_test_uptodate(folio))
 		folio_mark_uptodate(folio);
 	if (folio_mark_dirty(folio))
@@ -1537,11 +1539,11 @@ int f2fs_sanity_check_node_footer(struct f2fs_sb_info *sbi,
 {
 	bool is_inode, is_xnode;
 
-	if (unlikely(nid != nid_of_node(folio)))
+	if (unlikely(nid != nid_of_node(sbi, folio)))
 		goto out_err;
 
-	is_inode = IS_INODE(folio);
-	is_xnode = f2fs_has_xattr_block(ofs_of_node(folio));
+	is_inode = IS_INODE(sbi, folio);
+	is_xnode = f2fs_has_xattr_block(ofs_of_node(sbi, folio));
 
 	switch (ntype) {
 	case NODE_TYPE_REGULAR:
@@ -1574,9 +1576,9 @@ int f2fs_sanity_check_node_footer(struct f2fs_sb_info *sbi,
 	set_sbi_flag(sbi, SBI_NEED_FSCK);
 	f2fs_warn_ratelimited(sbi, "inconsistent node block, node_type:%d, nid:%lu, "
 		"node_footer[nid:%u,ino:%u,ofs:%u,cpver:%llu,blkaddr:%u]",
-		ntype, nid, nid_of_node(folio), ino_of_node(folio),
-		ofs_of_node(folio), cpver_of_node(folio),
-		next_blkaddr_of_node(folio));
+		ntype, nid, nid_of_node(sbi, folio), ino_of_node(sbi, folio),
+		ofs_of_node(sbi, folio), cpver_of_node(sbi, folio),
+		next_blkaddr_of_node(sbi, folio));
 
 	f2fs_handle_error(sbi, ERROR_INCONSISTENT_FOOTER);
 	fserror_report_file_metadata(folio->mapping->host,
@@ -1657,7 +1659,7 @@ struct folio *f2fs_get_xnode_folio(struct f2fs_sb_info *sbi, pgoff_t xnid)
 static struct folio *f2fs_get_node_folio_ra(struct folio *parent, int start)
 {
 	struct f2fs_sb_info *sbi = F2FS_F_SB(parent);
-	nid_t nid = get_nid(parent, start, false);
+	nid_t nid = get_nid(sbi, parent, start, false);
 
 	return __get_node_folio(sbi, nid, parent, start, NODE_TYPE_NON_IXNODE);
 }
@@ -1722,9 +1724,9 @@ static struct folio *last_fsync_dnode(struct f2fs_sb_info *sbi, nid_t ino)
 				return ERR_PTR(-EIO);
 			}
 
-			if (!IS_DNODE(folio) || !is_cold_node(folio))
+			if (!IS_DNODE(sbi, folio) || !is_cold_node(sbi, folio))
 				continue;
-			if (ino_of_node(folio) != ino)
+			if (ino_of_node(sbi, folio) != ino)
 				continue;
 
 			folio_lock(folio);
@@ -1734,7 +1736,7 @@ static struct folio *last_fsync_dnode(struct f2fs_sb_info *sbi, nid_t ino)
 				folio_unlock(folio);
 				continue;
 			}
-			if (ino_of_node(folio) != ino)
+			if (ino_of_node(sbi, folio) != ino)
 				goto continue_unlock;
 
 			if (!folio_test_dirty(folio)) {
@@ -1765,7 +1767,7 @@ static bool __write_node_folio(struct folio *folio, bool atomic, bool do_fsync,
 	struct node_info ni;
 	struct f2fs_io_info fio = {
 		.sbi = sbi,
-		.ino = ino_of_node(folio),
+		.ino = ino_of_node(sbi, folio),
 		.type = NODE,
 		.op = REQ_OP_WRITE,
 		.op_flags = wbc_to_write_flags(wbc),
@@ -1795,11 +1797,11 @@ static bool __write_node_folio(struct folio *folio, bool atomic, bool do_fsync,
 
 	if (!is_sbi_flag_set(sbi, SBI_CP_DISABLED) &&
 			wbc->sync_mode == WB_SYNC_NONE &&
-			IS_DNODE(folio) && is_cold_node(folio))
+			IS_DNODE(sbi, folio) && is_cold_node(sbi, folio))
 		goto redirty_out;
 
 	/* get old block addr of this node page */
-	nid = nid_of_node(folio);
+	nid = nid_of_node(sbi, folio);
 
 	if (f2fs_sanity_check_node_footer(sbi, folio, folio->index,
 					NODE_TYPE_REGULAR, false)) {
@@ -1832,11 +1834,11 @@ static bool __write_node_folio(struct folio *folio, bool atomic, bool do_fsync,
 	if (atomic && !test_opt(sbi, NOBARRIER))
 		fio.op_flags |= REQ_PREFLUSH | REQ_FUA;
 
-	set_dentry_mark(folio, false);
-	set_fsync_mark(folio, do_fsync);
-	if (IS_INODE(folio) && (atomic || is_fsync_dnode(folio)))
-		set_dentry_mark(folio,
-				f2fs_need_dentry_mark(sbi, ino_of_node(folio)));
+	set_dentry_mark(sbi, folio, false);
+	set_fsync_mark(sbi, folio, do_fsync);
+	if (IS_INODE(sbi, folio) && (atomic || is_fsync_dnode(sbi, folio)))
+		set_dentry_mark(sbi, folio,
+				f2fs_need_dentry_mark(sbi, ino_of_node(sbi, folio)));
 
 	/* should add to global list before clearing PAGECACHE status */
 	if (f2fs_in_warm_node_list(folio)) {
@@ -1849,7 +1851,7 @@ static bool __write_node_folio(struct folio *folio, bool atomic, bool do_fsync,
 
 	fio.old_blkaddr = ni.blk_addr;
 	f2fs_do_write_node_page(nid, &fio);
-	set_node_addr(sbi, &ni, fio.new_blkaddr, is_fsync_dnode(folio));
+	set_node_addr(sbi, &ni, fio.new_blkaddr, is_fsync_dnode(sbi, folio));
 	dec_page_count(sbi, F2FS_DIRTY_NODES);
 	f2fs_up_read_trace(&sbi->node_write, &lc);
 
@@ -1956,9 +1958,9 @@ int f2fs_fsync_node_pages(struct f2fs_sb_info *sbi, struct inode *inode,
 				goto out;
 			}
 
-			if (!IS_DNODE(folio) || !is_cold_node(folio))
+			if (!IS_DNODE(sbi, folio) || !is_cold_node(sbi, folio))
 				continue;
-			if (ino_of_node(folio) != ino)
+			if (ino_of_node(sbi, folio) != ino)
 				continue;
 
 			folio_lock(folio);
@@ -1968,7 +1970,7 @@ int f2fs_fsync_node_pages(struct f2fs_sb_info *sbi, struct inode *inode,
 				folio_unlock(folio);
 				continue;
 			}
-			if (ino_of_node(folio) != ino)
+			if (ino_of_node(sbi, folio) != ino)
 				goto continue_unlock;
 
 			if (!folio_test_dirty(folio) && folio != last_folio) {
@@ -1981,7 +1983,7 @@ int f2fs_fsync_node_pages(struct f2fs_sb_info *sbi, struct inode *inode,
 			if (!atomic || folio == last_folio) {
 				do_fsync = true;
 				percpu_counter_inc(&sbi->rf_node_block_count);
-				if (IS_INODE(folio)) {
+				if (IS_INODE(sbi, folio)) {
 					if (is_inode_flag_set(inode,
 								FI_DIRTY_INODE))
 						f2fs_update_inode(inode, folio);
@@ -2065,7 +2067,7 @@ static bool flush_dirty_inode(struct folio *folio)
 {
 	struct f2fs_sb_info *sbi = F2FS_F_SB(folio);
 	struct inode *inode;
-	nid_t ino = ino_of_node(folio);
+	nid_t ino = ino_of_node(sbi, folio);
 
 	inode = find_inode_nowait(sbi->sb, ino, f2fs_match_ino, NULL);
 	if (!inode)
@@ -2094,7 +2096,7 @@ void f2fs_flush_inline_data(struct f2fs_sb_info *sbi)
 		for (i = 0; i < nr_folios; i++) {
 			struct folio *folio = fbatch.folios[i];
 
-			if (!IS_INODE(folio))
+			if (!IS_INODE(sbi, folio))
 				continue;
 
 			folio_lock(folio);
@@ -2108,7 +2110,7 @@ void f2fs_flush_inline_data(struct f2fs_sb_info *sbi)
 			if (folio_test_f2fs_inline(folio)) {
 				folio_clear_f2fs_inline(folio);
 				folio_unlock(folio);
-				flush_inline_data(sbi, ino_of_node(folio));
+				flush_inline_data(sbi, ino_of_node(sbi, folio));
 				continue;
 			}
 unlock:
@@ -2157,13 +2159,13 @@ int f2fs_sync_node_pages(struct f2fs_sb_info *sbi,
 			 * 1. dentry dnodes
 			 * 2. file dnodes
 			 */
-			if (step == 0 && IS_DNODE(folio))
+			if (step == 0 && IS_DNODE(sbi, folio))
 				continue;
-			if (step == 1 && (!IS_DNODE(folio) ||
-						is_cold_node(folio)))
+			if (step == 1 && (!IS_DNODE(sbi, folio) ||
+						is_cold_node(sbi, folio)))
 				continue;
-			if (step == 2 && (!IS_DNODE(folio) ||
-						!is_cold_node(folio)))
+			if (step == 2 && (!IS_DNODE(sbi, folio) ||
+						!is_cold_node(sbi, folio)))
 				continue;
 lock_node:
 			if (wbc->sync_mode == WB_SYNC_ALL)
@@ -2190,12 +2192,12 @@ int f2fs_sync_node_pages(struct f2fs_sb_info *sbi,
 			if (folio_test_f2fs_inline(folio)) {
 				folio_clear_f2fs_inline(folio);
 				folio_unlock(folio);
-				flush_inline_data(sbi, ino_of_node(folio));
+				flush_inline_data(sbi, ino_of_node(sbi, folio));
 				goto lock_node;
 			}
 
 			/* flush dirty inode */
-			if (IS_INODE(folio) && flush_dirty_inode(folio))
+			if (IS_INODE(sbi, folio) && flush_dirty_inode(folio))
 				goto lock_node;
 write_node:
 			f2fs_folio_wait_writeback(folio, NODE, true, true);
@@ -2328,7 +2330,7 @@ static bool f2fs_dirty_node_folio(struct address_space *mapping,
 	if (!folio_test_uptodate(folio))
 		folio_mark_uptodate(folio);
 #ifdef CONFIG_F2FS_CHECK_FS
-	if (IS_INODE(folio))
+	if (IS_INODE(F2FS_M_SB(mapping), folio))
 		f2fs_inode_chksum_set(F2FS_M_SB(mapping), folio);
 #endif
 	if (filemap_dirty_folio(mapping, folio)) {
@@ -2933,7 +2935,7 @@ int f2fs_recover_xattr_data(struct inode *inode, struct folio *folio)
 int f2fs_recover_inode_page(struct f2fs_sb_info *sbi, struct folio *folio)
 {
 	struct f2fs_inode *src, *dst;
-	nid_t ino = ino_of_node(folio);
+	nid_t ino = ino_of_node(sbi, folio);
 	struct node_info old_ni, new_ni;
 	struct folio *ifolio;
 	int err;
@@ -2956,8 +2958,8 @@ int f2fs_recover_inode_page(struct f2fs_sb_info *sbi, struct folio *folio)
 
 	if (!folio_test_uptodate(ifolio))
 		folio_mark_uptodate(ifolio);
-	fill_node_footer(ifolio, ino, ino, 0, true);
-	set_cold_node(ifolio, false);
+	fill_node_footer(sbi, ifolio, ino, ino, 0, true);
+	set_cold_node(sbi, ifolio, false);
 
 	src = F2FS_INODE(folio);
 	dst = F2FS_INODE(ifolio);
@@ -3025,7 +3027,7 @@ int f2fs_restore_node_summary(struct f2fs_sb_info *sbi,
 			if (IS_ERR(folio))
 				return PTR_ERR(folio);
 
-			sum_entry->nid = F2FS_NODE_FOOTER(folio)->nid;
+			sum_entry->nid = F2FS_NODE_FOOTER(sbi, folio)->nid;
 			sum_entry->version = 0;
 			sum_entry->ofs_in_node = 0;
 			sum_entry++;
diff --git a/fs/f2fs/node.h b/fs/f2fs/node.h
index c265739f2105..901b9e60fed5 100644
--- a/fs/f2fs/node.h
+++ b/fs/f2fs/node.h
@@ -248,41 +248,47 @@ static inline void set_to_next_nat(struct f2fs_sb_info *sbi,
 #endif
 }
 
-static inline nid_t ino_of_node(const struct folio *node_folio)
+static inline nid_t ino_of_node(struct f2fs_sb_info *sbi,
+				const struct folio *node_folio)
 {
-	return le32_to_cpu(F2FS_NODE_FOOTER(node_folio)->ino);
+	return le32_to_cpu(F2FS_NODE_FOOTER(sbi, node_folio)->ino);
 }
 
-static inline nid_t nid_of_node(const struct folio *node_folio)
+static inline nid_t nid_of_node(struct f2fs_sb_info *sbi,
+				const struct folio *node_folio)
 {
-	return le32_to_cpu(F2FS_NODE_FOOTER(node_folio)->nid);
+	return le32_to_cpu(F2FS_NODE_FOOTER(sbi, node_folio)->nid);
 }
 
-static inline unsigned int ofs_of_node(const struct folio *node_folio)
+static inline unsigned int ofs_of_node(struct f2fs_sb_info *sbi,
+				const struct folio *node_folio)
 {
-	unsigned int flag = le32_to_cpu(F2FS_NODE_FOOTER(node_folio)->flag);
+	unsigned int flag = le32_to_cpu(F2FS_NODE_FOOTER(sbi, node_folio)->flag);
 	return flag >> OFFSET_BIT_SHIFT;
 }
 
-static inline __u64 cpver_of_node(const struct folio *node_folio)
+static inline __u64 cpver_of_node(struct f2fs_sb_info *sbi,
+				const struct folio *node_folio)
 {
-	return le64_to_cpu(F2FS_NODE_FOOTER(node_folio)->cp_ver);
+	return le64_to_cpu(F2FS_NODE_FOOTER(sbi, node_folio)->cp_ver);
 }
 
-static inline block_t next_blkaddr_of_node(const struct folio *node_folio)
+static inline block_t next_blkaddr_of_node(struct f2fs_sb_info *sbi,
+				const struct folio *node_folio)
 {
-	return le32_to_cpu(F2FS_NODE_FOOTER(node_folio)->next_blkaddr);
+	return le32_to_cpu(F2FS_NODE_FOOTER(sbi, node_folio)->next_blkaddr);
 }
 
-static inline void fill_node_footer(const struct folio *folio, nid_t nid,
+static inline void fill_node_footer(struct f2fs_sb_info *sbi,
+				const struct folio *folio, nid_t nid,
 				nid_t ino, unsigned int ofs, bool reset)
 {
 	struct f2fs_node *rn = F2FS_NODE(folio);
-	struct node_footer *footer = F2FS_NODE_FOOTER(folio);
+	struct node_footer *footer = F2FS_NODE_FOOTER(sbi, folio);
 	unsigned int old_flag = 0;
 
 	if (reset)
-		memset(rn, 0, F2FS_BLKSIZE(F2FS_F_SB(folio)));
+		memset(rn, 0, F2FS_BLKSIZE(sbi));
 	else
 		old_flag = le32_to_cpu(footer->flag);
 
@@ -294,17 +300,18 @@ static inline void fill_node_footer(const struct folio *folio, nid_t nid,
 					(old_flag & OFFSET_BIT_MASK));
 }
 
-static inline void copy_node_footer(const struct folio *dst,
-		const struct folio *src)
+static inline void copy_node_footer(struct f2fs_sb_info *sbi,
+		const struct folio *dst, const struct folio *src)
 {
-	memcpy(F2FS_NODE_FOOTER(dst), F2FS_NODE_FOOTER(src),
+	memcpy(F2FS_NODE_FOOTER(sbi, dst), F2FS_NODE_FOOTER(sbi, src),
 	       sizeof(struct node_footer));
 }
 
-static inline void fill_node_footer_blkaddr(struct folio *folio, block_t blkaddr)
+static inline void fill_node_footer_blkaddr(struct f2fs_sb_info *sbi,
+				struct folio *folio, block_t blkaddr)
 {
-	struct f2fs_checkpoint *ckpt = F2FS_CKPT(F2FS_F_SB(folio));
-	struct node_footer *footer = F2FS_NODE_FOOTER(folio);
+	struct f2fs_checkpoint *ckpt = F2FS_CKPT(sbi);
+	struct node_footer *footer = F2FS_NODE_FOOTER(sbi, folio);
 	__u64 cp_ver = cur_cp_version(ckpt);
 
 	if (__is_set_ckpt_flags(ckpt, CP_CRC_RECOVERY_FLAG))
@@ -314,19 +321,19 @@ static inline void fill_node_footer_blkaddr(struct folio *folio, block_t blkaddr
 	footer->next_blkaddr = cpu_to_le32(blkaddr);
 }
 
-static inline bool is_recoverable_dnode(const struct folio *folio)
+static inline bool is_recoverable_dnode(struct f2fs_sb_info *sbi, const struct folio *folio)
 {
-	struct f2fs_checkpoint *ckpt = F2FS_CKPT(F2FS_F_SB(folio));
+	struct f2fs_checkpoint *ckpt = F2FS_CKPT(sbi);
 	__u64 cp_ver = cur_cp_version(ckpt);
 
 	/* Don't care crc part, if fsck.f2fs sets it. */
 	if (__is_set_ckpt_flags(ckpt, CP_NOCRC_RECOVERY_FLAG))
-		return (cp_ver << 32) == (cpver_of_node(folio) << 32);
+		return (cp_ver << 32) == (cpver_of_node(sbi, folio) << 32);
 
 	if (__is_set_ckpt_flags(ckpt, CP_CRC_RECOVERY_FLAG))
 		cp_ver |= (cur_cp_crc(ckpt) << 32);
 
-	return cp_ver == cpver_of_node(folio);
+	return cp_ver == cpver_of_node(sbi, folio);
 }
 
 /*
@@ -350,10 +357,10 @@ static inline bool is_recoverable_dnode(const struct folio *folio)
  *                 `- indirect node ((6 + 2N) + (N - 1)(N + 1))
  *                       `- direct node
  */
-static inline bool IS_DNODE(const struct folio *node_folio)
+static inline bool IS_DNODE(struct f2fs_sb_info *sbi,
+					const struct folio *node_folio)
 {
-	struct f2fs_sb_info *sbi = F2FS_F_SB(node_folio);
-	unsigned int ofs = ofs_of_node(node_folio);
+	unsigned int ofs = ofs_of_node(sbi, node_folio);
 
 	if (f2fs_has_xattr_block(ofs))
 		return true;
@@ -369,11 +376,11 @@ static inline bool IS_DNODE(const struct folio *node_folio)
 	return true;
 }
 
-static inline int set_nid(struct folio *folio, int off, nid_t nid, bool i)
+static inline int set_nid(struct f2fs_sb_info *sbi,
+				struct folio *folio, int off, nid_t nid, bool i)
 {
-	struct f2fs_sb_info *sbi = F2FS_F_SB(folio);
 	struct f2fs_node *rn = F2FS_NODE(folio);
-	__le32 *inode_nids = F2FS_INODE_NIDS(folio);
+	__le32 *inode_nids = F2FS_INODE_NIDS(sbi, folio);
 
 	f2fs_folio_wait_writeback(folio, NODE, true, true);
 
@@ -385,11 +392,12 @@ static inline int set_nid(struct folio *folio, int off, nid_t nid, bool i)
 	return folio_mark_dirty(folio);
 }
 
-static inline nid_t get_nid(const struct folio *folio, int off, bool i)
+static inline nid_t get_nid(struct f2fs_sb_info *sbi,
+				const struct folio *folio, int off, bool i)
 {
 	struct f2fs_node *rn = F2FS_NODE(folio);
-	const __le32 *inode_nids = F2FS_INODE_NIDS(folio);
-	int nid_index = off - NODE_DIR1_BLOCK(F2FS_F_SB(folio));
+	const __le32 *inode_nids = F2FS_INODE_NIDS(sbi, folio);
+	int nid_index = off - NODE_DIR1_BLOCK(sbi);
 
 	if (i)
 		return le32_to_cpu(inode_nids[nid_index]);
@@ -403,18 +411,20 @@ static inline nid_t get_nid(const struct folio *folio, int off, bool i)
  *  - Mark cold data pages in page cache
  */
 
-static inline int is_node(const struct folio *folio, int type)
+static inline int is_node(struct f2fs_sb_info *sbi,
+				const struct folio *folio, int type)
 {
-	return le32_to_cpu(F2FS_NODE_FOOTER(folio)->flag) & BIT(type);
+	return le32_to_cpu(F2FS_NODE_FOOTER(sbi, folio)->flag) & BIT(type);
 }
 
-#define is_cold_node(folio)	is_node(folio, COLD_BIT_SHIFT)
-#define is_fsync_dnode(folio)	is_node(folio, FSYNC_BIT_SHIFT)
-#define is_dent_dnode(folio)	is_node(folio, DENT_BIT_SHIFT)
+#define is_cold_node(sbi, folio)	is_node(sbi, folio, COLD_BIT_SHIFT)
+#define is_fsync_dnode(sbi, folio)	is_node(sbi, folio, FSYNC_BIT_SHIFT)
+#define is_dent_dnode(sbi, folio)	is_node(sbi, folio, DENT_BIT_SHIFT)
 
-static inline void __set_mark(const struct folio *folio, bool mark, int type)
+static inline void __set_mark(struct f2fs_sb_info *sbi,
+				const struct folio *folio, bool mark, int type)
 {
-	struct node_footer *footer = F2FS_NODE_FOOTER(folio);
+	struct node_footer *footer = F2FS_NODE_FOOTER(sbi, folio);
 	unsigned int flag = le32_to_cpu(footer->flag);
 	if (mark)
 		flag |= BIT(type);
@@ -423,18 +433,20 @@ static inline void __set_mark(const struct folio *folio, bool mark, int type)
 	footer->flag = cpu_to_le32(flag);
 }
 
-static inline void set_cold_node(const struct folio *folio, bool is_dir)
+static inline void set_cold_node(struct f2fs_sb_info *sbi,
+				const struct folio *folio, bool is_dir)
 {
-	__set_mark(folio, !is_dir, COLD_BIT_SHIFT);
+	__set_mark(sbi, folio, !is_dir, COLD_BIT_SHIFT);
 }
 
-static inline void set_mark(struct folio *folio, bool mark, int type)
+static inline void set_mark(struct f2fs_sb_info *sbi,
+				struct folio *folio, bool mark, int type)
 {
-	__set_mark(folio, mark, type);
+	__set_mark(sbi, folio, mark, type);
 
 #ifdef CONFIG_F2FS_CHECK_FS
-	f2fs_inode_chksum_set(F2FS_F_SB(folio), folio);
+	f2fs_inode_chksum_set(sbi, folio);
 #endif
 }
-#define set_dentry_mark(folio, mark)	set_mark(folio, mark, DENT_BIT_SHIFT)
-#define set_fsync_mark(folio, mark)	set_mark(folio, mark, FSYNC_BIT_SHIFT)
+#define set_dentry_mark(sbi, folio, mark)	set_mark(sbi, folio, mark, DENT_BIT_SHIFT)
+#define set_fsync_mark(sbi, folio, mark)	set_mark(sbi, folio, mark, FSYNC_BIT_SHIFT)
diff --git a/fs/f2fs/recovery.c b/fs/f2fs/recovery.c
index b52718741ddc..ba3649e6190e 100644
--- a/fs/f2fs/recovery.c
+++ b/fs/f2fs/recovery.c
@@ -256,7 +256,7 @@ static int recover_dentry(struct inode *inode, struct folio *ifolio,
 out:
 	name = recover_printable_name(inode, raw_inode, &name_len);
 	f2fs_notice(F2FS_I_SB(inode), "%s: ino = %x, name = %.*s, dir = %llu, err = %d",
-		    __func__, ino_of_node(ifolio), name_len, name,
+		    __func__, ino_of_node(F2FS_I_SB(inode), ifolio), name_len, name,
 		    IS_ERR(dir) ? 0 : dir->i_ino, err);
 	return err;
 }
@@ -357,7 +357,7 @@ static int recover_inode(struct inode *inode, struct folio *folio)
 	name = recover_printable_name(inode, raw, &name_len);
 
 	f2fs_notice(F2FS_I_SB(inode), "%s: ino = %x, name = %.*s, inline = %x",
-		    __func__, ino_of_node(folio), name_len, name,
+		    __func__, ino_of_node(F2FS_I_SB(inode), folio), name_len, name,
 		    raw->i_inline);
 	return 0;
 }
@@ -397,16 +397,16 @@ static int sanity_check_node_chain(struct f2fs_sb_info *sbi, block_t blkaddr,
 		if (IS_ERR(folio))
 			return PTR_ERR(folio);
 
-		if (!is_recoverable_dnode(folio)) {
+		if (!is_recoverable_dnode(sbi, folio)) {
 			f2fs_folio_put(folio, true);
 			*is_detecting = false;
 			return 0;
 		}
 
 		ra_blocks = adjust_por_ra_blocks(sbi, ra_blocks, *blkaddr_fast,
-					next_blkaddr_of_node(folio));
+					next_blkaddr_of_node(sbi, folio));
 
-		*blkaddr_fast = next_blkaddr_of_node(folio);
+		*blkaddr_fast = next_blkaddr_of_node(sbi, folio);
 		f2fs_folio_put(folio, true);
 
 		f2fs_ra_meta_pages_cond(sbi, *blkaddr_fast, ra_blocks);
@@ -446,21 +446,21 @@ static int find_fsync_dnodes(struct f2fs_sb_info *sbi, struct list_head *head,
 			break;
 		}
 
-		if (!is_recoverable_dnode(folio)) {
+		if (!is_recoverable_dnode(sbi, folio)) {
 			f2fs_folio_put(folio, true);
 			break;
 		}
 
-		if (!is_fsync_dnode(folio))
+		if (!is_fsync_dnode(sbi, folio))
 			goto next;
 
-		entry = get_fsync_inode(head, ino_of_node(folio));
+		entry = get_fsync_inode(head, ino_of_node(sbi, folio));
 		if (!entry) {
 			bool quota_inode = false;
 
 			if (!check_only &&
-					IS_INODE(folio) &&
-					is_dent_dnode(folio)) {
+					IS_INODE(sbi, folio) &&
+					is_dent_dnode(sbi, folio)) {
 				err = f2fs_recover_inode_page(sbi, folio);
 				if (err) {
 					f2fs_folio_put(folio, true);
@@ -469,7 +469,7 @@ static int find_fsync_dnodes(struct f2fs_sb_info *sbi, struct list_head *head,
 				quota_inode = true;
 			}
 
-			entry = add_fsync_inode(sbi, head, ino_of_node(folio),
+			entry = add_fsync_inode(sbi, head, ino_of_node(sbi, folio),
 								quota_inode);
 			if (IS_ERR(entry)) {
 				err = PTR_ERR(entry);
@@ -488,11 +488,11 @@ static int find_fsync_dnodes(struct f2fs_sb_info *sbi, struct list_head *head,
 		}
 		entry->blkaddr = blkaddr;
 
-		if (IS_INODE(folio) && is_dent_dnode(folio))
+		if (IS_INODE(sbi, folio) && is_dent_dnode(sbi, folio))
 			entry->last_dentry = blkaddr;
 next:
 		/* check next segment */
-		blkaddr = next_blkaddr_of_node(folio);
+		blkaddr = next_blkaddr_of_node(sbi, folio);
 		f2fs_folio_put(folio, true);
 
 		err = sanity_check_node_chain(sbi, blkaddr, &blkaddr_fast,
@@ -577,8 +577,8 @@ static int check_index_in_prev_nodes(struct f2fs_sb_info *sbi,
 	if (IS_ERR(node_folio))
 		return PTR_ERR(node_folio);
 
-	offset = ofs_of_node(node_folio);
-	ino = ino_of_node(node_folio);
+	offset = ofs_of_node(sbi, node_folio);
+	ino = ino_of_node(sbi, node_folio);
 	f2fs_folio_put(node_folio, true);
 
 	if (ino != dn->inode->i_ino) {
@@ -653,11 +653,11 @@ static int do_recover_data(struct f2fs_sb_info *sbi, struct inode *inode,
 	int err = 0, recovered = 0;
 
 	/* step 1: recover xattr */
-	if (IS_INODE(folio)) {
+	if (IS_INODE(sbi, folio)) {
 		err = f2fs_recover_inline_xattr(inode, folio);
 		if (err)
 			goto out;
-	} else if (f2fs_has_xattr_block(ofs_of_node(folio))) {
+	} else if (f2fs_has_xattr_block(ofs_of_node(sbi, folio))) {
 		err = f2fs_recover_xattr_data(inode, folio);
 		if (!err)
 			recovered++;
@@ -673,7 +673,7 @@ static int do_recover_data(struct f2fs_sb_info *sbi, struct inode *inode,
 	}
 
 	/* step 3: recover data indices */
-	start = f2fs_start_bidx_of_node(ofs_of_node(folio), inode);
+	start = f2fs_start_bidx_of_node(ofs_of_node(sbi, folio), inode);
 	end = start + ADDRS_PER_PAGE(folio, inode);
 
 	set_new_dnode(&dn, inode, NULL, NULL, 0);
@@ -693,12 +693,12 @@ static int do_recover_data(struct f2fs_sb_info *sbi, struct inode *inode,
 	if (err)
 		goto err;
 
-	f2fs_bug_on(sbi, ni.ino != ino_of_node(folio));
+	f2fs_bug_on(sbi, ni.ino != ino_of_node(sbi, folio));
 
-	if (ofs_of_node(dn.node_folio) != ofs_of_node(folio)) {
+	if (ofs_of_node(sbi, dn.node_folio) != ofs_of_node(sbi, folio)) {
 		f2fs_warn(sbi, "Inconsistent ofs_of_node, ino:%llu, ofs:%u, %u",
-			  inode->i_ino, ofs_of_node(dn.node_folio),
-			  ofs_of_node(folio));
+			  inode->i_ino, ofs_of_node(sbi, dn.node_folio),
+			  ofs_of_node(sbi, folio));
 		err = -EFSCORRUPTED;
 		f2fs_handle_error(sbi, ERROR_INCONSISTENT_FOOTER);
 		fserror_report_file_metadata(dn.inode, err, GFP_NOFS);
@@ -784,16 +784,16 @@ static int do_recover_data(struct f2fs_sb_info *sbi, struct inode *inode,
 		}
 	}
 
-	copy_node_footer(dn.node_folio, folio);
-	fill_node_footer(dn.node_folio, dn.nid, ni.ino,
-					ofs_of_node(folio), false);
+	copy_node_footer(sbi, dn.node_folio, folio);
+	fill_node_footer(sbi, dn.node_folio, dn.nid, ni.ino,
+					ofs_of_node(sbi, folio), false);
 	folio_mark_dirty(dn.node_folio);
 err:
 	f2fs_put_dnode(&dn);
 out:
 	f2fs_notice(sbi, "recover_data: ino = %llx, nid = %x (i_size: %s), "
 		    "range (%u, %u), recovered = %d, err = %d",
-		    inode->i_ino, nid_of_node(folio),
+		    inode->i_ino, nid_of_node(sbi, folio),
 		    file_keep_isize(inode) ? "keep" : "recover",
 		    start, end, recovered, err);
 	return err;
@@ -832,13 +832,13 @@ static int recover_data(struct f2fs_sb_info *sbi, struct list_head *inode_list,
 			break;
 		}
 
-		if (!is_recoverable_dnode(folio)) {
+		if (!is_recoverable_dnode(sbi, folio)) {
 			f2fs_folio_put(folio, true);
 			break;
 		}
 		recoverable_dnode++;
 
-		entry = get_fsync_inode(inode_list, ino_of_node(folio));
+		entry = get_fsync_inode(inode_list, ino_of_node(sbi, folio));
 		if (!entry)
 			goto next;
 		fsynced_dnode++;
@@ -847,7 +847,7 @@ static int recover_data(struct f2fs_sb_info *sbi, struct list_head *inode_list,
 		 * In this case, we can lose the latest inode(x).
 		 * So, call recover_inode for the inode update.
 		 */
-		if (IS_INODE(folio)) {
+		if (IS_INODE(sbi, folio)) {
 			err = recover_inode(entry->inode, folio);
 			if (err) {
 				f2fs_folio_put(folio, true);
@@ -874,10 +874,10 @@ static int recover_data(struct f2fs_sb_info *sbi, struct list_head *inode_list,
 			list_move_tail(&entry->list, tmp_inode_list);
 next:
 		ra_blocks = adjust_por_ra_blocks(sbi, ra_blocks, blkaddr,
-					next_blkaddr_of_node(folio));
+					next_blkaddr_of_node(sbi, folio));
 
 		/* check next segment */
-		blkaddr = next_blkaddr_of_node(folio);
+		blkaddr = next_blkaddr_of_node(sbi, folio);
 		f2fs_folio_put(folio, true);
 
 		f2fs_ra_meta_pages_cond(sbi, blkaddr, ra_blocks);
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 2d0f49745626..0b6267d0354e 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -3827,7 +3827,7 @@ static int __get_segment_type_4(struct f2fs_io_info *fio)
 		else
 			return CURSEG_COLD_DATA;
 	} else {
-		if (IS_DNODE(fio->folio) && is_cold_node(fio->folio))
+		if (IS_DNODE(fio->sbi, fio->folio) && is_cold_node(fio->sbi, fio->folio))
 			return CURSEG_WARM_NODE;
 		else
 			return CURSEG_COLD_NODE;
@@ -3885,8 +3885,8 @@ static int __get_segment_type_6(struct f2fs_io_info *fio)
 		return f2fs_rw_hint_to_seg_type(F2FS_I_SB(inode),
 						inode->i_write_hint);
 	} else {
-		if (IS_DNODE(fio->folio))
-			return is_cold_node(fio->folio) ? CURSEG_WARM_NODE :
+		if (IS_DNODE(fio->sbi, fio->folio))
+			return is_cold_node(fio->sbi, fio->folio) ? CURSEG_WARM_NODE :
 						CURSEG_HOT_NODE;
 		return CURSEG_COLD_NODE;
 	}
@@ -4063,7 +4063,7 @@ int f2fs_allocate_data_block(struct f2fs_sb_info *sbi, struct folio *folio,
 	up_write(&sit_i->sentry_lock);
 
 	if (folio && IS_NODESEG(curseg->seg_type)) {
-		fill_node_footer_blkaddr(folio, NEXT_FREE_BLKADDR(sbi, curseg));
+		fill_node_footer_blkaddr(sbi, folio, NEXT_FREE_BLKADDR(sbi, curseg));
 
 		f2fs_inode_chksum_set(sbi, folio);
 	}
diff --git a/include/linux/f2fs_fs.h b/include/linux/f2fs_fs.h
index 92a11e984d7a..f38558279e86 100644
--- a/include/linux/f2fs_fs.h
+++ b/include/linux/f2fs_fs.h
@@ -283,7 +283,7 @@ struct node_footer {
 #define ADDRS_PER_INODE(inode)	addrs_per_page(inode, true)
 /* Address Pointers in a Direct Block */
 #define ADDRS_PER_BLOCK(inode)	addrs_per_page(inode, false)
-#define ADDRS_PER_PAGE(folio, inode)	(addrs_per_page(inode, IS_INODE(folio)))
+#define ADDRS_PER_PAGE(folio, inode)	(addrs_per_page(inode, IS_INODE(F2FS_I_SB(inode), folio)))
 
 #define F2FS_INLINE_XATTR	0x01	/* file inline xattr flag */
 #define F2FS_INLINE_DATA	0x02	/* file inline data flag */
-- 
2.49.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
