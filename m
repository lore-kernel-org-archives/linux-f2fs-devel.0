Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1917606A320
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 20 Nov 2026 15:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=LI1K+uKJ;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=Xh/Kzwh3;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=YV/xHs3M;
	dkim=neutral header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oquvyCd6
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-ID:Date:To:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=MnhmZOUHZq7bCtsXAj/mZ89uRrvwzwobOExBgyHlaFo=; b=LI1K+uKJ4ac4X95JO1OB2jP5HB
	1Ak+jomeGYJ3yxMngyFFn3z3jospZdP4l1XdcEdIr+tT5/wpq/2jRn8MYHogVTAWsqTaTgJs6qGjD
	M6G6Q+ZEsG5PqrUZRYAiP6y9WgLjt70T4Qp2RVBroBxdXFL4gaUgZnwMZYxRR/h5Jo+I=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xUQwS-000000004Jx-2c1P;
	Fri, 20 Nov 2026 15:54:24 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <aalbersh@kernel.org>) id 1xUQwR-000000004Ji-1uP8
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 20 Nov 2026 15:54:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=+8w5qlf8jD//ZtOO2vLYEXLr+YWwj7aWgsYMhZaXWmY=; b=Xh/Kzwh3MBKLR970Nh08+aX0iC
 mTGBZA55whtLkZaubmfDmoUgGTv1qAVSQ7PblZcXkRnElA4Y8rPkB0o0ZC1zTSRWFxY9bgpEZJ18Y
 2iGltcmtvA/MMBYlIs9jip+mzeZQCF5FyzhCN7ohPPvlXB+4GaIpofDlHkX10j9kHP44=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=+8w5qlf8jD//ZtOO2vLYEXLr+YWwj7aWgsYMhZaXWmY=; b=YV/xHs3MP1hLpbQit2E0Xp/MmA
 2BAuIQ6SUub+HA9PFy3ygvX21IGYhTh5wT+80pncu5k79oE3KvYKNp2POgN4gc4aEPQvS52msB8sd
 9mZZzB+8dcqWVcPuAkNC4DJyVATNTbyVrJbN+PnvHgrE6Y379V/NnDGgs69wDNdDnJZE=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xUQwQ-000000003z2-10O9
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 20 Nov 2026 15:54:23 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id A590461292;
 Fri, 20 Nov 2026 15:54:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18C1C1F000D3;
 Fri, 20 Nov 2026 15:54:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795190056;
 bh=+8w5qlf8jD//ZtOO2vLYEXLr+YWwj7aWgsYMhZaXWmY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=oquvyCd61j8lJzeU+qPQzLF+Y1v9DmtHSx0UbdnlXhxFBeK+CiXqs15r70oeh7AKu
 WwlMLu7LwkliqzBEe9WSkFEj2iCchRi758Maf9tAPtgCylwkH4SpTVxhoPEjGwNd6y
 OW2PkP/Sw7PSXoSsSIWKN0PH5QW0tgPoGhxTIlLizVV/gaBzekAZEH94RBQ/R8HRqd
 lONgehHB76cq+8DsTh0F9hdzlxN7IU+cMXDCSAzbBhFHc1g6XhEQJYW8pd296q6mcu
 LRMzIZ8sDI71eKKCCAJ7m/Z0l/XnjTXQ6DBbkCgOW9/JlctE2h3Mas/yzPhh8hQNcc
 lvyOYf9BWyCGA==
To: "fsdevel" <linux-fsdevel@vger.kernel.org>,
 "fsverity" <fsverity@lists.linux.dev>,
 "linux-ext4" <linux-ext4@vger.kernel.org>,
 "linux-btrfs" <linux-btrfs@vger.kernel.org>,
 "linux-f2fs" <linux-f2fs-devel@lists.sourceforge.net>,
 "linux-xfs" <linux-xfs@vger.kernel.org>, dsterba@suse.com,
 "Eric Biggers" <ebiggers@kernel.org>,
 "Christian Brauner" <brauner@kernel.org>
Date: Fri, 20 Nov 2026 16:50:29 +0100
Message-ID: <20261120155032.187246-8-aalbersh@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261120155032.187246-1-aalbersh@kernel.org>
References: <20261120155032.187246-1-aalbersh@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xUQwQ-000000003z2-10O9
Subject: [f2fs-dev] [PATCH v3 7/7] f2fs: use I_VERITY_BUILDING instead of
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
Cc: tytso@mit.edu, Andrey Albershteyn <aalbersh@kernel.org>,
 viro@zeniv.linux.org.uk, jaegeuk@kernel.org
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
generic fs-verity enable path, drop the inode runtime flags that
duplicated this state.

Replace f2fs own helper f2fs_verity_in_progress() with
fsverity_is_building(), and remove the and FI_VERITY_IN_PROGRESS flags.
It's fine to remove IS_ENABLED() guard as fsverity_is_building() has
stub.

Signed-off-by: Andrey Albershteyn <aalbersh@kernel.org>
---
 fs/f2fs/data.c   | 10 +++++-----
 fs/f2fs/f2fs.h   |  7 -------
 fs/f2fs/verity.c | 12 +++---------
 3 files changed, 8 insertions(+), 21 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 7c5aa95b7da8..c75e61af21f7 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -3356,7 +3356,7 @@ int f2fs_write_single_data_page(struct folio *folio, int *submitted,
 		goto redirty_out;
 
 	if (folio->index < end_index ||
-			f2fs_verity_in_progress(inode) ||
+			fsverity_is_building(inode) ||
 			compr_blocks)
 		goto write;
 
@@ -3889,7 +3889,7 @@ void f2fs_write_failed(struct inode *inode, loff_t to)
 		return;
 
 	/* In the fs-verity case, f2fs_end_enable_verity() does the truncate */
-	if (to > i_size && !f2fs_verity_in_progress(inode)) {
+	if (to > i_size && !fsverity_is_building(inode)) {
 		f2fs_down_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
 		filemap_invalidate_lock(inode->i_mapping);
 
@@ -4205,7 +4205,7 @@ static int f2fs_write_begin(const struct kiocb *iocb,
 		return 0;
 
 	if (!(pos & (PAGE_SIZE - 1)) && (pos + len) >= i_size_read(inode) &&
-	    !f2fs_verity_in_progress(inode)) {
+	    !fsverity_is_building(inode)) {
 		folio_zero_segment(folio, len, folio_size(folio));
 		return 0;
 	}
@@ -4279,7 +4279,7 @@ static int f2fs_write_end(const struct kiocb *iocb,
 		f2fs_update_time(F2FS_I_SB(inode), REQ_TIME);
 
 		if (pos + copied > i_size_read(inode) &&
-				!f2fs_verity_in_progress(inode))
+				!fsverity_is_building(inode))
 			f2fs_i_size_write(inode, pos + copied);
 		return copied;
 	}
@@ -4294,7 +4294,7 @@ static int f2fs_write_end(const struct kiocb *iocb,
 		folio_set_f2fs_atomic(folio);
 
 	if (pos + copied > i_size_read(inode) &&
-	    !f2fs_verity_in_progress(inode)) {
+	    !fsverity_is_building(inode)) {
 		f2fs_i_size_write(inode, pos + copied);
 		if (f2fs_is_atomic_file(inode))
 			f2fs_i_size_write(F2FS_I(inode)->cow_inode,
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 6941891d7cae..c0fca6229170 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -926,7 +926,6 @@ enum {
 	FI_EXTRA_ATTR,		/* indicate file has extra attribute */
 	FI_PROJ_INHERIT,	/* indicate file inherits projectid */
 	FI_PIN_FILE,		/* indicate file should not be gced */
-	FI_VERITY_IN_PROGRESS,	/* building fs-verity Merkle tree */
 	FI_COMPRESSED_FILE,	/* indicate file's data can be compressed */
 	FI_COMPRESS_CORRUPT,	/* indicate compressed cluster is corrupted */
 	FI_MMAP_FILE,		/* indicate file was mmapped */
@@ -3536,12 +3535,6 @@ static inline void clear_inode_flag(struct inode *inode, int flag)
 	__mark_inode_dirty_flag(inode, flag, false);
 }
 
-static inline bool f2fs_verity_in_progress(struct inode *inode)
-{
-	return IS_ENABLED(CONFIG_FS_VERITY) &&
-	       is_inode_flag_set(inode, FI_VERITY_IN_PROGRESS);
-}
-
 static inline void set_acl_inode(struct inode *inode, umode_t mode)
 {
 	F2FS_I(inode)->i_acl_mode = mode;
diff --git a/fs/f2fs/verity.c b/fs/f2fs/verity.c
index 4a2cea4288f9..f31a71295e47 100644
--- a/fs/f2fs/verity.c
+++ b/fs/f2fs/verity.c
@@ -94,9 +94,6 @@ static int f2fs_begin_enable_verity(struct file *filp)
 	struct inode *inode = file_inode(filp);
 	int err;
 
-	if (f2fs_verity_in_progress(inode))
-		return -EBUSY;
-
 	if (f2fs_is_atomic_file(inode))
 		return -EOPNOTSUPP;
 
@@ -113,7 +110,6 @@ static int f2fs_begin_enable_verity(struct file *filp)
 	if (err)
 		return err;
 
-	set_inode_flag(inode, FI_VERITY_IN_PROGRESS);
 	return 0;
 }
 
@@ -143,8 +139,8 @@ static int f2fs_end_enable_verity(struct file *filp, const void *desc,
 		goto cleanup;
 
 	/*
-	 * Write all pages (both data and verity metadata).  Note that this must
-	 * happen before clearing FI_VERITY_IN_PROGRESS; otherwise pages beyond
+	 * Write all pages (both data and verity metadata). Note that this must
+	 * happen before I_VERITY_BUILDING is cleared; otherwise pages beyond
 	 * i_size won't be written properly.  For crash consistency, this also
 	 * must happen before the verity inode flag gets persisted.
 	 */
@@ -164,14 +160,13 @@ static int f2fs_end_enable_verity(struct file *filp, const void *desc,
 	f2fs_set_inode_flags(inode);
 	f2fs_mark_inode_dirty_sync(inode, true);
 
-	clear_inode_flag(inode, FI_VERITY_IN_PROGRESS);
 	return 0;
 
 cleanup:
 	/*
 	 * Verity failed to be enabled, so clean up by truncating any verity
 	 * metadata that was written beyond i_size (both from cache and from
-	 * disk) and clearing FI_VERITY_IN_PROGRESS.
+	 * disk).
 	 *
 	 * Taking i_gc_rwsem[WRITE] is needed to stop f2fs garbage collection
 	 * from re-instantiating cached pages we are truncating (since unlike
@@ -186,7 +181,6 @@ static int f2fs_end_enable_verity(struct file *filp, const void *desc,
 		set_sbi_flag(sbi, SBI_NEED_FSCK);
 	}
 	f2fs_up_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
-	clear_inode_flag(inode, FI_VERITY_IN_PROGRESS);
 	return err ?: err2;
 }
 
-- 
2.54.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
