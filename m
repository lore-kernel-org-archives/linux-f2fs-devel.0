Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EFDDC5AD05
	for <linux-f2fs-devel@archiver.kernel.org>; Fri,  7 Aug 2026 22:02:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:Message-ID:Date:To:Sender:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=Y9tO/LX4CGZMIvG3w6fqY9OL/7uT+MiZlkfGqb+kSKQ=; b=fmf+B9fjDNC4MhAK2ZhGhpvCkE
	kih0Ea+3oCOI1+50+iBKivMvxsSUs3c3Ji1oh/h6YcHdNspxHIyxnBBtHlZEzAcf2gQujnaGzRUeW
	t2yPSWfci4HArEOVihTOtaxEsJdSfJ8TfW8WexZjFJlqBo7T/YHcvfNfmMkM1hwgzlBY=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wsSeS-0002OP-2k;
	Fri, 07 Aug 2026 22:02:52 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <jaegeuk@kernel.org>) id 1wsSeO-0002OH-Lf
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 07 Aug 2026 22:02:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=lqIML6Uc2iiN6TB3NkQPdJzYlPEG9jpmafklGp+LOjU=; b=T7wIUfJiwg6mY0cSzcQK6YSL1q
 XhEJAVI+bOWUJHz1I5uRJ/4muEDYLFxhT1QKBdq4BHM+YLtlmAE9KaPBIyjq4SbG03Em/MP2lJI2z
 tmCanak33XoyTepTdrjWzJHGRbiKEk2SWLj4UMvS7bajvYl+cd4tjy9uGEEpY4gr0wKo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=lqIML6Uc2iiN6TB3NkQPdJzYlPEG9jpmafklGp+LOjU=; b=H
 Iac9HoNyxIWQekD8uUZ9p/VNeGrtmrnY9VNxJNENWWFYxrhYceT+jXUja+FazqWRwIzPsikDGgaIs
 7KQ1CiTVJCeZoR2p0i1r3PmiTLOqi/bvvDS0DMW0BTFREQMc06Z2CaDJG8wPaeBDfxvpCKSqsCWbZ
 s1CPbard6vWpiz7s=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wsSeN-0008Ty-Ua for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 07 Aug 2026 22:02:49 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 4E9E6600B0
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri,  7 Aug 2026 22:02:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E36E71F000E9;
 Fri,  7 Aug 2026 22:02:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786140162;
 bh=lqIML6Uc2iiN6TB3NkQPdJzYlPEG9jpmafklGp+LOjU=;
 h=From:To:Cc:Subject:Date;
 b=i9QeKG+IMS0pLE0X0Q+kfTMehebSh+LofbFxk8dTAQESky+9WoQ3IUMpq6FgnXar7
 nCyg5XNFNHwlHKWulQRlRcQmahURUWMk1LL7CXPhxa9aeKnpVTognQKVsyGmfzqNvn
 S6h2gOMD7hmztFSWYj4zRwzjOl5ezv94vw5opke5RMfWUMFfyFz4gS1hz0w/0/dH9l
 zLoO+4cWn3dG8PC/PetfcMu503SS34TsFvn3DLGEfH30N4XvuGWHvphqBXO0Nvts6z
 dKPnRPjhLbWfmLdf4w9ivwB31CPSfN4buGythrQHSwTijV9w0sR9wrlPuJUbRcz5lD
 BtCk1sjgdfNNQ==
To: linux-kernel@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net
Date: Fri,  7 Aug 2026 22:02:34 +0000
Message-ID: <20260807220235.384637-1-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.55.0.654.g21b8a5bc05-goog
MIME-Version: 1.0
X-Headers-End: 1wsSeN-0008Ty-Ua
Subject: [f2fs-dev] [PATCH 1/2] f2fs: refactor f2fs_evict_inode having three
 major parts
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
From: Jaegeuk Kim via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: Jaegeuk Kim <jaegeuk@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

1. f2fs_pre_evict_inode()
 : drop all in-memory structures

2. f2fs_delete_inode()
 : truncate inode blocks, if it was unlinked.

3. f2fs_post_evict_inode()
 : update inode records for future access

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/inode.c | 136 ++++++++++++++++++++++++++++--------------------
 1 file changed, 81 insertions(+), 55 deletions(-)

diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
index c95e0b126da4..553b1e338aa1 100644
--- a/fs/f2fs/inode.c
+++ b/fs/f2fs/inode.c
@@ -855,15 +855,12 @@ void f2fs_remove_donate_inode(struct inode *inode)
 }
 
 /*
- * Called at the last iput() if i_nlink is zero
+ * Return true, if we shouldn't go through post_evict_inode.
  */
-void f2fs_evict_inode(struct inode *inode)
+static bool f2fs_pre_evict_inode(struct inode *inode)
 {
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
 	struct f2fs_inode_info *fi = F2FS_I(inode);
-	nid_t xnid = fi->i_xattr_nid;
-	int err = 0;
-	bool freeze_protected = false;
 
 	f2fs_abort_atomic_write(inode, true);
 
@@ -883,13 +880,13 @@ void f2fs_evict_inode(struct inode *inode)
 	truncate_inode_pages_final(&inode->i_data);
 
 	if ((inode->i_nlink || is_bad_inode(inode)) &&
-		test_opt(sbi, COMPRESS_CACHE) && f2fs_compressed_file(inode))
+	    test_opt(sbi, COMPRESS_CACHE) && f2fs_compressed_file(inode))
 		f2fs_invalidate_compress_pages(sbi, inode->i_ino);
 
 	if (inode->i_ino == F2FS_NODE_INO(sbi) ||
-			inode->i_ino == F2FS_META_INO(sbi) ||
-			inode->i_ino == F2FS_COMPRESS_INO(sbi))
-		goto out_clear;
+	    inode->i_ino == F2FS_META_INO(sbi) ||
+	    inode->i_ino == F2FS_COMPRESS_INO(sbi))
+		return true;
 
 	f2fs_bug_on(sbi, get_dirty_pages(inode));
 	f2fs_remove_dirty_inode(inode);
@@ -898,14 +895,18 @@ void f2fs_evict_inode(struct inode *inode)
 	if (!IS_DEVICE_ALIASING(inode))
 		f2fs_destroy_extent_tree(inode);
 
-	if (inode->i_nlink || is_bad_inode(inode))
-		goto no_delete;
+	return false;
+}
 
-	err = f2fs_dquot_initialize(inode);
-	if (err) {
-		err = 0;
+static void f2fs_delete_inode(struct inode *inode)
+{
+	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
+	bool freeze_protected = false;
+	struct f2fs_lock_context lc;
+	int err = 0;
+
+	if (f2fs_dquot_initialize(inode))
 		set_sbi_flag(sbi, SBI_QUOTA_NEED_REPAIR);
-	}
 
 	f2fs_remove_ino_entry(sbi, inode->i_ino, APPEND_INO);
 	f2fs_remove_ino_entry(sbi, inode->i_ino, UPDATE_INO);
@@ -924,30 +925,30 @@ void f2fs_evict_inode(struct inode *inode)
 	if (time_to_inject(sbi, FAULT_EVICT_INODE))
 		err = -EIO;
 
-	if (!err) {
-		struct f2fs_lock_context lc;
-
-		f2fs_lock_op(sbi, &lc);
-		err = f2fs_remove_inode_page(inode);
-		f2fs_unlock_op(sbi, &lc);
-		if (err == -ENOENT) {
-			err = 0;
-
-			/*
-			 * in fuzzed image, another node may has the same
-			 * block address as inode's, if it was truncated
-			 * previously, truncation of inode node will fail.
-			 */
-			if (is_inode_flag_set(inode, FI_DIRTY_INODE)) {
-				f2fs_warn(F2FS_I_SB(inode),
-					"f2fs_evict_inode: inconsistent node id, ino:%llu",
-					inode->i_ino);
-				f2fs_inode_synced(inode);
-				set_sbi_flag(sbi, SBI_NEED_FSCK);
-			}
+	if (err)
+		goto error_check;
+
+	f2fs_lock_op(sbi, &lc);
+	err = f2fs_remove_inode_page(inode);
+	f2fs_unlock_op(sbi, &lc);
+
+	if (err == -ENOENT) {
+		err = 0;
+
+		/*
+		 * in fuzzed image, another node may has the same
+		 * block address as inode's, if it was truncated
+		 * previously, truncation of inode node will fail.
+		 */
+		if (is_inode_flag_set(inode, FI_DIRTY_INODE)) {
+			f2fs_warn(F2FS_I_SB(inode),
+				"f2fs_evict_inode: inconsistent node id, ino:%llu",
+				inode->i_ino);
+			f2fs_inode_synced(inode);
+			set_sbi_flag(sbi, SBI_NEED_FSCK);
 		}
 	}
-
+error_check:
 	/* give more chances, if ENOMEM case */
 	if (err == -ENOMEM) {
 		err = 0;
@@ -957,27 +958,37 @@ void f2fs_evict_inode(struct inode *inode)
 	if (IS_DEVICE_ALIASING(inode))
 		f2fs_destroy_extent_tree(inode);
 
-	if (err) {
-		f2fs_update_inode_page(inode);
-		if (dquot_initialize_needed(inode))
-			set_sbi_flag(sbi, SBI_QUOTA_NEED_REPAIR);
+	if (!err)
+		goto unfreeze_out;
 
-		/*
-		 * If both f2fs_truncate() and f2fs_update_inode_page() failed
-		 * due to fuzzed corrupted inode, call f2fs_inode_synced() to
-		 * avoid triggering later f2fs_bug_on().
-		 */
-		if (is_inode_flag_set(inode, FI_DIRTY_INODE)) {
-			f2fs_warn(sbi,
-				"f2fs_evict_inode: inode is dirty, ino:%llu",
-				inode->i_ino);
-			f2fs_inode_synced(inode);
-			set_sbi_flag(sbi, SBI_NEED_FSCK);
-		}
+	f2fs_update_inode_page(inode);
+
+	if (dquot_initialize_needed(inode))
+		set_sbi_flag(sbi, SBI_QUOTA_NEED_REPAIR);
+
+	/*
+	 * If both f2fs_truncate() and f2fs_update_inode_page() failed
+	 * due to fuzzed corrupted inode, call f2fs_inode_synced() to
+	 * avoid triggering later f2fs_bug_on().
+	 */
+	if (is_inode_flag_set(inode, FI_DIRTY_INODE)) {
+		f2fs_warn(sbi,
+			"f2fs_evict_inode: inode is dirty, ino:%llu",
+			inode->i_ino);
+		f2fs_inode_synced(inode);
+		set_sbi_flag(sbi, SBI_NEED_FSCK);
 	}
+unfreeze_out:
 	if (freeze_protected)
 		sb_end_intwrite(inode->i_sb);
-no_delete:
+}
+
+static void f2fs_post_evict_inode(struct inode *inode)
+{
+	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
+	struct f2fs_inode_info *fi = F2FS_I(inode);
+	nid_t xnid = fi->i_xattr_nid;
+
 	dquot_drop(inode);
 
 	stat_dec_inline_xattr(inode);
@@ -1019,7 +1030,22 @@ void f2fs_evict_inode(struct inode *inode)
 		 * In that case, f2fs_check_nid_range() is enough to give a clue.
 		 */
 	}
-out_clear:
+}
+
+/*
+ * Called at the last iput() if i_nlink is zero
+ */
+void f2fs_evict_inode(struct inode *inode)
+{
+	if (f2fs_pre_evict_inode(inode))
+		goto clear_out;
+
+	if (!inode->i_nlink && !is_bad_inode(inode))
+		f2fs_delete_inode(inode);
+
+	f2fs_post_evict_inode(inode);
+
+clear_out:
 	fscrypt_put_encryption_info(inode);
 	clear_inode(inode);
 }
-- 
2.55.0.654.g21b8a5bc05-goog



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
