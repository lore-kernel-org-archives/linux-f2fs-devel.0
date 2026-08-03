Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4306BC55196
	for <linux-f2fs-devel@archiver.kernel.org>; Mon,  3 Aug 2026 20:09:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-ID:Date:To:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=y/m3UjTkKl2TK/cGJq/uQHLyx18Wi05MxnGWA7xSm8A=; b=nHFx0TS7I9fauM76y5QrhyzTPE
	OIooTGx5tOndMvfzDMr2f3W1Jn5B8uJvecS/UhLqw1HJDqtbS5CLZZPMIKhwA6tMymo7tl8gADZaE
	sXlAc7LA6wjZf+e9P9tcRnZExCpjG2tVVNmhkd7fmXjsg4F8oZMtQi3ISnyVC/GjDtz0=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wqyyz-0007oH-4h;
	Mon, 03 Aug 2026 20:09:57 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <aalbersh@kernel.org>) id 1wqyyx-0007nz-LK
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 03 Aug 2026 20:09:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=YLfktdvMFUXHfwxmUbw7t3XeZC0JE9FQuUWHYRvt6uM=; b=VCvLLIMl6z5swo/cpfSTwIe3fg
 +yJ/1owFrbre9awcL1/phi3o4tcU6vp61/9IT9BherSXsOgf0+96eM0fcC2hhJJhLSkqmnC008Dgr
 r6KB13ICwtIUWm4LNLccvjiKWdL6jBOZZW2FtwjYPGxzVhyBNyn8giMXVsBWl7tce8E0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=YLfktdvMFUXHfwxmUbw7t3XeZC0JE9FQuUWHYRvt6uM=; b=h8da20DT+aQaY+KSfgLab8Hoc+
 WqtyM5nC9KXyVG+u/48nz/EVDLx5xuNJWhX45w2YJ2PzgHG8erjGIVZnSBq/ruJuN5Ikdmbu3k3EW
 9lLis9L6XaozBfdgDzvyTctNKB6OpZEf0xDJxl0R2dDTfWYeIF6d87M6tpWBJMC3NY2I=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wqyz1-0000wX-5W for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 03 Aug 2026 20:09:56 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id E7B4B43C4B;
 Mon,  3 Aug 2026 20:09:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F2151F00A3A;
 Mon,  3 Aug 2026 20:09:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785787789;
 bh=YLfktdvMFUXHfwxmUbw7t3XeZC0JE9FQuUWHYRvt6uM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=AdwwZrscNM+ern/9epzNkqqbXJk+82MwUlRkGhFbtcyu7bg98bTxYZomyCS6f4Z/j
 Tw7LnEGZ3ryYdRnMFujEIRjlgTzLOrXQvCbElJyOICUR9fimSchzSy/Nq9D9X9fTyS
 JIKb6tG5Ju3jMgc1dkphkcN8/tmaAXq8f563mN56y1AA+ohH+swdyD//0R5uN+hm5P
 F26pcvPs9pniUWfI33evcSCGrfyjZ97JI4/LtklsI1my54ZmmRnCH/k/EdjwEcAIpN
 k+2Zo56q8CqZHA2e1X56YCPjesyLUew9DqRgA6rjOEUElGKwk5JO2TezgsMlnKSOnc
 tWo1spsJ4q5wg==
To: linux-xfs@vger.kernel.org, fsverity@lists.linux.dev,
 linux-fsdevel@vger.kernel.org, ebiggers@kernel.org
Date: Mon,  3 Aug 2026 22:08:04 +0200
Message-ID: <20260803200820.393203-15-aalbersh@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260803200820.393203-1-aalbersh@kernel.org>
References: <20260803200820.393203-1-aalbersh@kernel.org>
MIME-Version: 1.0
X-Headers-End: 1wqyz1-0000wX-5W
Subject: [f2fs-dev] [PATCH v14 14/21] xfs: add flags to xfs_free_eofblocks()
 to pass down to block processing
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
From: Andrey Albershteyn via Linux-f2fs-devel
 <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Andrey Albershteyn <aalbersh@kernel.org>
Cc: Andrey Albershteyn <aalbersh@kernel.org>, djwong@kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, linux-ext4@vger.kernel.org, hch@lst.de,
 linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Add a flags parameter to xfs_free_eofblocks() to support selective
extent unmapping. Add two flags for unmapping all extents (unwritten and
normal) and fsverity leftover extents (only unwritten ones, leaving
normal in place).

Signed-off-by: Andrey Albershteyn <aalbersh@kernel.org>
---
 fs/xfs/libxfs/xfs_bmap.c | 56 +++++++++++++++++++++++++++++-----------
 fs/xfs/libxfs/xfs_bmap.h |  6 ++++-
 fs/xfs/xfs_bmap_util.c   | 20 ++++++++++----
 fs/xfs/xfs_bmap_util.h   | 13 +++++++++-
 fs/xfs/xfs_file.c        |  2 +-
 fs/xfs/xfs_icache.c      |  2 +-
 fs/xfs/xfs_inode.c       |  2 +-
 7 files changed, 76 insertions(+), 25 deletions(-)

diff --git a/fs/xfs/libxfs/xfs_bmap.c b/fs/xfs/libxfs/xfs_bmap.c
index cc48f6e20e80..1d8d157a9dfa 100644
--- a/fs/xfs/libxfs/xfs_bmap.c
+++ b/fs/xfs/libxfs/xfs_bmap.c
@@ -6144,15 +6144,12 @@ xfs_bmap_validate_extent(
 			XFS_IS_REALTIME_INODE(ip), whichfork, irec);
 }
 
-/*
- * Used in xfs_itruncate_extents().  This is the maximum number of extents
- * freed from a file in a single transaction.
- */
-#define	XFS_ITRUNC_MAX_EXTENTS	2
-
 /*
  * Unmap every extent in part of an inode's fork.  We don't do any higher level
  * invalidation work at all.
+ *
+ * The XFS_BMAPI_UNWRITTEN could be passed to remove only unwritten extents,
+ * leaving out normal extents in place.
  */
 int
 xfs_bunmapi_range(
@@ -6162,23 +6159,52 @@ xfs_bunmapi_range(
 	xfs_fileoff_t		startoff,
 	xfs_fileoff_t		endoff)
 {
-	xfs_filblks_t		unmap_len = endoff - startoff + 1;
 	int			error = 0;
+	int			nimaps = 1;
+	int			done = 0;
+	struct xfs_bmbt_irec	imap;
+	int			read_flags =
+			flags & (XFS_BMAPI_ATTRFORK | XFS_BMAPI_ENTIRE);
+	xfs_exntst_t		exntst = XFS_EXT_NORM;
 
 	xfs_assert_ilocked(ip, XFS_ILOCK_EXCL);
 
-	while (unmap_len > 0) {
-		ASSERT((*tpp)->t_highest_agno == NULLAGNUMBER);
-		error = __xfs_bunmapi(*tpp, ip, startoff, &unmap_len, flags,
-				XFS_ITRUNC_MAX_EXTENTS);
+	if (flags & XFS_BMAPI_UNWRITTEN)
+		exntst = XFS_EXT_UNWRITTEN;
+
+	while (startoff < endoff) {
+		nimaps = 1;
+
+		error = xfs_bmapi_read(ip, startoff, endoff - startoff + 1,
+				&imap, &nimaps, read_flags);
 		if (error)
 			goto out;
 
-		/* free the just unmapped extents */
-		error = xfs_defer_finish(tpp);
-		if (error)
+		if (nimaps == 0)
 			goto out;
-		cond_resched();
+
+		if ((exntst == XFS_EXT_UNWRITTEN) &&
+				(imap.br_state != exntst)) {
+			startoff = imap.br_startoff + imap.br_blockcount;
+			continue;
+		}
+
+		done = 0;
+		while (!done) {
+			ASSERT((*tpp)->t_highest_agno == NULLAGNUMBER);
+			error = xfs_bunmapi(*tpp, ip, imap.br_startoff,
+					imap.br_blockcount, flags, 0, &done);
+			if (error)
+				goto out;
+
+			/* free the just unmapped extent */
+			error = xfs_defer_finish(tpp);
+			if (error)
+				goto out;
+			cond_resched();
+		}
+
+		startoff = imap.br_startoff + imap.br_blockcount;
 	}
 out:
 	return error;
diff --git a/fs/xfs/libxfs/xfs_bmap.h b/fs/xfs/libxfs/xfs_bmap.h
index d5f2729305fa..0f36431d9936 100644
--- a/fs/xfs/libxfs/xfs_bmap.h
+++ b/fs/xfs/libxfs/xfs_bmap.h
@@ -90,6 +90,9 @@ struct xfs_bmalloca {
 /* Try to align allocations to the extent size hint */
 #define XFS_BMAPI_EXTSZALIGN	(1u << 11)
 
+/* Process unwritten extents only. Used for unmapping */
+#define XFS_BMAPI_UNWRITTEN	(1u << 12)
+
 #define XFS_BMAPI_FLAGS \
 	{ XFS_BMAPI_ENTIRE,	"ENTIRE" }, \
 	{ XFS_BMAPI_METADATA,	"METADATA" }, \
@@ -102,7 +105,8 @@ struct xfs_bmalloca {
 	{ XFS_BMAPI_COWFORK,	"COWFORK" }, \
 	{ XFS_BMAPI_NODISCARD,	"NODISCARD" }, \
 	{ XFS_BMAPI_NORMAP,	"NORMAP" },\
-	{ XFS_BMAPI_EXTSZALIGN,	"EXTSZALIGN" }
+	{ XFS_BMAPI_EXTSZALIGN,	"EXTSZALIGN" }, \
+	{ XFS_BMAPI_UNWRITTEN,	"UNWRITTEN" }
 
 
 static inline int xfs_bmapi_aflag(int w)
diff --git a/fs/xfs/xfs_bmap_util.c b/fs/xfs/xfs_bmap_util.c
index c88b9ade7389..6323eac48fc8 100644
--- a/fs/xfs/xfs_bmap_util.c
+++ b/fs/xfs/xfs_bmap_util.c
@@ -574,11 +574,13 @@ xfs_can_free_eofblocks(
  */
 int
 xfs_free_eofblocks(
-	struct xfs_inode	*ip)
+	struct xfs_inode	*ip,
+	int			flags)
 {
 	struct xfs_trans	*tp;
 	struct xfs_mount	*mp = ip->i_mount;
 	int			error;
+	int			bmapi_flags = XFS_BMAPI_NODISCARD;
 
 	/* Attach the dquots to the inode up front. */
 	error = xfs_qm_dqattach(ip);
@@ -593,15 +595,20 @@ xfs_free_eofblocks(
 	 *
 	 * Note that this means we also leave speculative preallocations in
 	 * place for preallocated files.
+	 *
+	 * Clean up delalloc reservations for fsverity too as those won't be
+	 * used
 	 */
-	if (ip->i_diflags & (XFS_DIFLAG_PREALLOC | XFS_DIFLAG_APPEND)) {
+	if (ip->i_diflags & (XFS_DIFLAG_PREALLOC | XFS_DIFLAG_APPEND) ||
+			(flags & XFS_FREE_FSVERITY)) {
 		if (ip->i_delayed_blks) {
 			xfs_bmap_punch_delalloc_range(ip, XFS_DATA_FORK,
 				round_up(XFS_ISIZE(ip), mp->m_sb.sb_blocksize),
 				LLONG_MAX, NULL);
 		}
 		xfs_inode_clear_eofblocks_tag(ip);
-		return 0;
+		if (!(flags & XFS_FREE_FSVERITY))
+			return 0;
 	}
 
 	error = xfs_trans_alloc(mp, &M_RES(mp)->tr_itruncate, 0, 0, 0, &tp);
@@ -613,6 +620,9 @@ xfs_free_eofblocks(
 	xfs_ilock(ip, XFS_ILOCK_EXCL);
 	xfs_trans_ijoin(tp, ip, 0);
 
+	if (flags & XFS_FREE_FSVERITY)
+		bmapi_flags |= XFS_BMAPI_UNWRITTEN;
+
 	/*
 	 * Do not update the on-disk file size.  If we update the on-disk file
 	 * size and then the system crashes before the contents of the file are
@@ -620,7 +630,7 @@ xfs_free_eofblocks(
 	 * bug).
 	 */
 	error = xfs_itruncate_extents_flags(&tp, ip, XFS_DATA_FORK,
-				XFS_ISIZE(ip), XFS_BMAPI_NODISCARD);
+				XFS_ISIZE(ip), bmapi_flags);
 	if (error)
 		goto err_cancel;
 
@@ -928,7 +938,7 @@ xfs_prepare_shift(
 	 * into the accessible region of the file.
 	 */
 	if (xfs_can_free_eofblocks(ip)) {
-		error = xfs_free_eofblocks(ip);
+		error = xfs_free_eofblocks(ip, XFS_FREE_ALL);
 		if (error)
 			return error;
 	}
diff --git a/fs/xfs/xfs_bmap_util.h b/fs/xfs/xfs_bmap_util.h
index eaaf094154b9..9ea3000466cc 100644
--- a/fs/xfs/xfs_bmap_util.h
+++ b/fs/xfs/xfs_bmap_util.h
@@ -64,9 +64,20 @@ int	xfs_collapse_file_space(struct xfs_inode *, xfs_off_t offset,
 int	xfs_insert_file_space(struct xfs_inode *, xfs_off_t offset,
 		xfs_off_t len);
 
+/*
+ * Remove all extents and reservations beyond EOF
+ */
+#define XFS_FREE_ALL		0
+
+/*
+ * Do the normal post EOF cleaning except don't remove normal extents, in other
+ * words, remove unwritten, delayed allocation and cow reservations
+ */
+#define XFS_FREE_FSVERITY	1
+
 /* EOF block manipulation functions */
 bool	xfs_can_free_eofblocks(struct xfs_inode *ip);
-int	xfs_free_eofblocks(struct xfs_inode *ip);
+int	xfs_free_eofblocks(struct xfs_inode *ip, int flags);
 
 int	xfs_swap_extents(struct xfs_inode *ip, struct xfs_inode *tip,
 			 struct xfs_swapext *sx);
diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
index e9927688086d..43b8fd5a25c5 100644
--- a/fs/xfs/xfs_file.c
+++ b/fs/xfs/xfs_file.c
@@ -1827,7 +1827,7 @@ xfs_file_release(
 	    xfs_ilock_nowait(ip, XFS_IOLOCK_EXCL)) {
 		if (xfs_can_free_eofblocks(ip) &&
 		    !xfs_iflags_test_and_set(ip, XFS_EOFBLOCKS_RELEASED))
-			xfs_free_eofblocks(ip);
+			xfs_free_eofblocks(ip, XFS_FREE_ALL);
 		xfs_iunlock(ip, XFS_IOLOCK_EXCL);
 	}
 
diff --git a/fs/xfs/xfs_icache.c b/fs/xfs/xfs_icache.c
index 9d8dd30bd927..2b3601bb28c9 100644
--- a/fs/xfs/xfs_icache.c
+++ b/fs/xfs/xfs_icache.c
@@ -1261,7 +1261,7 @@ xfs_inode_free_eofblocks(
 	*lockflags |= XFS_IOLOCK_EXCL;
 
 	if (xfs_can_free_eofblocks(ip))
-		return xfs_free_eofblocks(ip);
+		return xfs_free_eofblocks(ip, XFS_FREE_ALL);
 
 	/* inode could be preallocated */
 	trace_xfs_inode_free_eofblocks_invalid(ip);
diff --git a/fs/xfs/xfs_inode.c b/fs/xfs/xfs_inode.c
index 15279d22a894..63f346e2f1d5 100644
--- a/fs/xfs/xfs_inode.c
+++ b/fs/xfs/xfs_inode.c
@@ -1436,7 +1436,7 @@ xfs_inactive(
 		 * reference to the inode at this point anyways.
 		 */
 		if (xfs_can_free_eofblocks(ip))
-			error = xfs_free_eofblocks(ip);
+			error = xfs_free_eofblocks(ip, XFS_FREE_ALL);
 
 		goto out;
 	}
-- 
2.54.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
