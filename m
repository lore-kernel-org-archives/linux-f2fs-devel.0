Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 765F4606D80A
	for <linux-f2fs-devel@archiver.kernel.org>; Thu,  5 Nov 2026 11:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=Tb/Sz7dB;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=kebmxDlZ;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=IkmL1fgc;
	dkim=neutral header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fumQCCvo
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-ID:Date:To:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=Q6jPgnBW8wFPYFLpO5PKXW/bHB0767j2u2s1uGKdM5Y=; b=Tb/Sz7dBe4uoBJNtQWIZnjKTgm
	50r1zWZ2ygIp65+PVOe5FRg6mqZWbJdHC2IQLAwUYThAAUeJ3W40Ghd25vjUwEEscvjRWv2o01ljv
	w5an3jMAfkyp/THhXcGXMBCDjFmSudl+vaJlSvqDHbD/jcGLaTiY3BaGZkkv2r9ya8TY=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xOw5i-0000000033A-0qza;
	Thu, 05 Nov 2026 11:57:14 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <aalbersh@kernel.org>) id 1xOw5X-0000000031z-22Xv
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 05 Nov 2026 11:57:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=+IrPC0FHgxyuSqXIoEfYMR7j75cyEud/FZQj+mfi+S8=; b=kebmxDlZT3yfQcELg/Q9j/CBFT
 7Yjxwn22v3hlJk2oRDGi9pMxbxrbVAnmkPp5HVZ8RH2AMLIg58+VfY5WY3jgELvVIqttfsIyVt+MP
 TjF3QfE34Q6De8iclIOecHDBFTiERoTaeqhPdCqN6BPyYf1D0yQjF+UrcuAaQQJc07cI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=+IrPC0FHgxyuSqXIoEfYMR7j75cyEud/FZQj+mfi+S8=; b=IkmL1fgcJM7Ghj70Ux3UtS7J2q
 kOfP3OZv7BEVjgdQfP6Oi8+MLLgt5+la801yIYMyT8FkXrylokM2eIa77pMt4cFqmZ0b660XpWpxN
 SDwhtLByh+fOm9FCoFOvHOhdiVZzMdc2FGwk+iQ4TI0qO+qwf9pZmHWq+o14h2PvXEPg=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xOw5V-000000007jA-3ksH
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 05 Nov 2026 11:57:03 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 9381343B65;
 Thu,  5 Nov 2026 11:56:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EFB21F0093A;
 Thu,  5 Nov 2026 11:56:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793879816;
 bh=+IrPC0FHgxyuSqXIoEfYMR7j75cyEud/FZQj+mfi+S8=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=fumQCCvouI1SvEB8bhxwQ9qqO+ILxo1Okiu1ebut8FhArs5p9WuAnSjyHf4MGM4Rt
 WKZ3GMr0neoGVqmt98VByDBZi1Xa0XSfUVbeMozKaU8tMXKWef+wwlqOFPHSzsZEz6
 K2vL512BS3/Cg3YUmLFO/j8MDPguoqMb1vIte7MPUI2fXt7kl/Mc6QnKhU9aCU81rY
 Rfl8c2pKcXtqSQn+KZGIWnwAtnrYyK66/h4JsP2ZPgFdkojHRaFg8cmZgbvCVuNZgS
 cShSEEkyHWiK92kgmg6EbdfeiKzGVo1q80vRCNPve43L/w9CRut9pzDZ9hMpZFqftz
 7O1JzNo95Bdkg==
To: ebiggers@kernel.org, hch@lst.de, fsverity@lists.linux.dev, dsterba@suse.com
Date: Thu,  5 Nov 2026 12:55:29 +0100
Message-ID: <20261105115532.613467-5-aalbersh@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261105115532.613467-1-aalbersh@kernel.org>
References: <20261105115532.613467-1-aalbersh@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xOw5V-000000007jA-3ksH
Subject: [f2fs-dev] [PATCH v2 4/5] ext4: use I_VERITY_BUILDING instead of
 private flags
X-BeenThere: linux-f2fs-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
From: Andrey Albershteyn via Linux-f2fs-devel
 <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Andrey Albershteyn <aalbersh@kernel.org>
Cc: tytso@mit.edu, brauner@kernel.org, Andrey Albershteyn <aalbersh@kernel.org>,
 linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org,
 viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org, jaegeuk@kernel.org,
 linux-ext4@vger.kernel.org, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Now that the VFS tracks an inode whose Merkle tree is under construction
via I_VERITY_BUILDING and handles the concurrent-enable guard in the
generic fs-verity enable path, drop the per-filesystem runtime flags that
duplicated this state.

Replace ext4 own helper ext4_verity_in_progress() with
fsverity_is_building(), and remove the EXT4_STATE_VERITY_IN_PROGRESS
flags. The IS_ENABLED() guard is fine to remove now as
fsverity_is_building() has stub for disabled fsverity.

Signed-off-by: Andrey Albershteyn <aalbersh@kernel.org>
---
 fs/ext4/ext4.h   |  7 -------
 fs/ext4/file.c   |  2 +-
 fs/ext4/inode.c  | 17 +++++++++--------
 fs/ext4/ioctl.c  |  3 +--
 fs/ext4/verity.c | 18 +++++-------------
 5 files changed, 16 insertions(+), 31 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index f38fec3167fb..bc624ed58353 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -2049,7 +2049,6 @@ enum {
 	EXT4_STATE_MAY_INLINE_DATA,	/* may have in-inode data */
 	EXT4_STATE_EXT_PRECACHED,	/* extents have been precached */
 	EXT4_STATE_LUSTRE_EA_INODE,	/* Lustre-style ea_inode */
-	EXT4_STATE_VERITY_IN_PROGRESS,	/* building fs-verity Merkle tree */
 	EXT4_STATE_FC_COMMITTING,	/* Fast commit ongoing */
 	EXT4_STATE_FC_FLUSHING_DATA,	/* Fast commit flushing data */
 	EXT4_STATE_ORPHAN_FILE,		/* Inode orphaned in orphan file */
@@ -2128,12 +2127,6 @@ static inline int ext4_inode_state_wait_bit(int bit)
 #define EXT4_SB(sb)	(sb)
 #endif
 
-static inline bool ext4_verity_in_progress(struct inode *inode)
-{
-	return IS_ENABLED(CONFIG_FS_VERITY) &&
-	       ext4_test_inode_state(inode, EXT4_STATE_VERITY_IN_PROGRESS);
-}
-
 #define NEXT_ORPHAN(inode) EXT4_I(inode)->i_dtime
 
 /*
diff --git a/fs/ext4/file.c b/fs/ext4/file.c
index 50d3c92709c8..109dea94c6e3 100644
--- a/fs/ext4/file.c
+++ b/fs/ext4/file.c
@@ -318,7 +318,7 @@ static ssize_t ext4_write_checks(struct kiocb *iocb, struct iov_iter *from)
 	 * partial block that beyond the existing EOF, as it may contains
 	 * stale data written through mmap.
 	 */
-	if (iocb->ki_pos > old_size && !ext4_verity_in_progress(inode)) {
+	if (iocb->ki_pos > old_size && !fsverity_is_building(inode)) {
 		if (iocb->ki_flags & IOCB_NOWAIT)
 			return -EAGAIN;
 
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 10cd85d4c721..171028185c9d 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -42,6 +42,7 @@
 #include <linux/bitops.h>
 #include <linux/iomap.h>
 #include <linux/iversion.h>
+#include <linux/fsverity.h>
 
 #include "ext4_jbd2.h"
 #include "ext4_extents.h"
@@ -511,7 +512,7 @@ void ext4_check_map_extents_env(struct inode *inode)
 	    is_special_ino(inode->i_sb, inode->i_ino) ||
 	    (inode_state_read_once(inode) & (I_FREEING | I_WILL_FREE | I_NEW)) ||
 	    ext4_test_inode_flag(inode, EXT4_INODE_EA_INODE) ||
-	    ext4_verity_in_progress(inode))
+	    fsverity_is_building(inode))
 		return;
 
 	WARN_ON_ONCE(!inode_is_locked(inode) &&
@@ -1498,7 +1499,7 @@ static int ext4_write_begin(const struct kiocb *iocb,
 
 	if (ret) {
 		bool extended = (pos + len > inode->i_size) &&
-				!ext4_verity_in_progress(inode);
+				!fsverity_is_building(inode);
 
 		folio_unlock(folio);
 		/*
@@ -1565,7 +1566,7 @@ static int ext4_write_end(const struct kiocb *iocb,
 	loff_t old_size = inode->i_size;
 	int ret = 0, ret2;
 	int i_size_changed = 0;
-	bool verity = ext4_verity_in_progress(inode);
+	bool verity = fsverity_is_building(inode);
 
 	trace_ext4_write_end(inode, pos, len, copied);
 
@@ -1670,7 +1671,7 @@ static int ext4_journalled_write_end(const struct kiocb *iocb,
 	int partial = 0;
 	unsigned from, to;
 	int size_changed = 0;
-	bool verity = ext4_verity_in_progress(inode);
+	bool verity = fsverity_is_building(inode);
 
 	trace_ext4_journalled_write_end(inode, pos, len, copied);
 	from = pos & (PAGE_SIZE - 1);
@@ -2215,7 +2216,7 @@ static void mpage_submit_folio(struct mpage_da_data *mpd, struct folio *folio)
 	size = i_size_read(mpd->inode);
 	len = folio_size(folio);
 	if (folio_pos(folio) + len > size &&
-	    !ext4_verity_in_progress(mpd->inode))
+	    !fsverity_is_building(mpd->inode))
 		len = size & (len - 1);
 	ext4_bio_write_folio(&mpd->io_submit, folio, len);
 }
@@ -2305,7 +2306,7 @@ static int mpage_process_page_bufs(struct mpage_da_data *mpd,
 	ext4_lblk_t blocks = (i_size_read(inode) + i_blocksize(inode) - 1)
 							>> inode->i_blkbits;
 
-	if (ext4_verity_in_progress(inode))
+	if (fsverity_is_building(inode))
 		blocks = EXT_MAX_BLOCKS;
 
 	do {
@@ -2711,7 +2712,7 @@ static int mpage_journal_page_buffers(handle_t *handle,
 	mpd->wbc->nr_to_write -= folio_nr_pages(folio);
 
 	if (folio_pos(folio) + len > size &&
-	    !ext4_verity_in_progress(inode))
+	    !fsverity_is_building(inode))
 		len = size & (len - 1);
 
 	return ext4_journal_folio_buffers(handle, folio, len);
@@ -3276,7 +3277,7 @@ static int ext4_da_write_begin(const struct kiocb *iocb,
 
 	index = pos >> PAGE_SHIFT;
 
-	if (ext4_nonda_switch(inode->i_sb) || ext4_verity_in_progress(inode)) {
+	if (ext4_nonda_switch(inode->i_sb) || fsverity_is_building(inode)) {
 		*fsdata = (void *)FALL_BACK_TO_NONDELALLOC;
 		return ext4_write_begin(iocb, mapping, pos,
 					len, foliop, fsdata);
diff --git a/fs/ext4/ioctl.c b/fs/ext4/ioctl.c
index e8e579498c99..d3db2e77ebda 100644
--- a/fs/ext4/ioctl.c
+++ b/fs/ext4/ioctl.c
@@ -575,8 +575,7 @@ static bool dax_compatible(struct inode *inode, unsigned int oldflags,
 
 	if (flags & EXT4_DAX_FL) {
 		if ((oldflags & EXT4_DAX_MUT_EXCL) ||
-		     ext4_test_inode_state(inode,
-					  EXT4_STATE_VERITY_IN_PROGRESS)) {
+		     fsverity_is_building(inode)) {
 			return false;
 		}
 	}
diff --git a/fs/ext4/verity.c b/fs/ext4/verity.c
index 56fe3e5b33e0..0189c8868b74 100644
--- a/fs/ext4/verity.c
+++ b/fs/ext4/verity.c
@@ -83,9 +83,6 @@ static int ext4_begin_enable_verity(struct file *filp)
 	if (IS_DAX(inode) || ext4_test_inode_flag(inode, EXT4_INODE_DAX))
 		return -EINVAL;
 
-	if (ext4_verity_in_progress(inode))
-		return -EBUSY;
-
 	/*
 	 * Since the file was opened readonly, we have to initialize the jbd
 	 * inode and quotas here and not rely on ->open() doing it.  This must
@@ -123,8 +120,6 @@ static int ext4_begin_enable_verity(struct file *filp)
 		return PTR_ERR(handle);
 
 	err = ext4_orphan_add(handle, inode);
-	if (err == 0)
-		ext4_set_inode_state(inode, EXT4_STATE_VERITY_IN_PROGRESS);
 
 	ext4_journal_stop(handle);
 	return err;
@@ -185,10 +180,9 @@ static int ext4_end_enable_verity(struct file *filp, const void *desc,
 		goto cleanup;
 
 	/*
-	 * Write all pages (both data and verity metadata).  Note that this must
-	 * happen before clearing EXT4_STATE_VERITY_IN_PROGRESS; otherwise pages
-	 * beyond i_size won't be written properly.  For crash consistency, this
-	 * also must happen before the verity inode flag gets persisted.
+	 * Write all pages (both data and verity metadata). For crash
+	 * consistency, this also must happen before the verity inode flag gets
+	 * persisted.
 	 */
 	err = filemap_write_and_wait(inode->i_mapping);
 	if (err)
@@ -224,7 +218,6 @@ static int ext4_end_enable_verity(struct file *filp, const void *desc,
 
 	/* Now that rollback is no longer possible, set S_VERITY. */
 	ext4_set_inode_flags(inode, false);
-	ext4_clear_inode_state(inode, EXT4_STATE_VERITY_IN_PROGRESS);
 	return 0;
 
 stop_and_cleanup:
@@ -234,13 +227,12 @@ static int ext4_end_enable_verity(struct file *filp, const void *desc,
 	/*
 	 * Verity failed to be enabled, so clean up by truncating any verity
 	 * metadata that was written beyond i_size (both from cache and from
-	 * disk), removing the inode from the orphan list (if it wasn't done
-	 * already), and clearing EXT4_STATE_VERITY_IN_PROGRESS.
+	 * disk) and removing the inode from the orphan list (if it wasn't done
+	 * already).
 	 */
 	truncate_inode_pages(inode->i_mapping, inode->i_size);
 	ext4_truncate(inode);
 	ext4_orphan_del(NULL, inode);
-	ext4_clear_inode_state(inode, EXT4_STATE_VERITY_IN_PROGRESS);
 	return err;
 }
 
-- 
2.54.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
