Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56DA8606A854
	for <linux-f2fs-devel@archiver.kernel.org>; Wed,  4 Nov 2026 19:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=EopilfdZ;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=I6wD2kHX;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=QHA0J67Y;
	dkim=neutral header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SYMjwR9C
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-ID:Date:To:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=WJ7qFOw++1BRlNXdLTKQfyab8mRrD63TJi/Kd6ls/2M=; b=EopilfdZgU/NqEBvvfwYvvQ4oX
	PdYo2b/81rkq7cR0GKBLdHy14wCd2f2GmUQz//nriMgpjYLfiPkowGhj0UiaaZ2Bfi93RdfqIhCOP
	Bp3jMgaQw26C4ntw/O0Ao2/Avyw6gQnwe4mWlHYwUDODCysyYDrLAc1kiOsgiV0FSM1M=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xOgwj-000000000r9-09wJ;
	Wed, 04 Nov 2026 19:46:57 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <aalbersh@kernel.org>) id 1xOgwg-000000000qT-1dNS
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 04 Nov 2026 19:46:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=BimR1D9/wvZGY0reDOYel4C+9wjSglW0Ag8MNWquP3M=; b=I6wD2kHXv5HKO2NB5CKTtnfwKk
 DwAIgBOXNZstQg5LTZ/ZqcjXtDsXCRTXkVKr4bKqmwSt05l6MP3+ycL9o34bwyZ0YTX/uHsn5NxSW
 HoHppQNLIYnzOweAX3sMBO3KJFBXlLRvuwZ2MR4I1msVoVvcdtQI+3PC7uU8i1SQoSko=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=BimR1D9/wvZGY0reDOYel4C+9wjSglW0Ag8MNWquP3M=; b=QHA0J67YiHZ1kCty5ZG7kLh/Za
 UgaEJcDJ1+yylyr3RpqxWcwfGcAlnjsamx+pIwnY4RePhdoQ1GSr10p3ZW3rFzAddKhqJc++PNMcr
 AF19iNAQsvQY+8uTapm2KS8wIMMHqUNZFmKPsytw8ONV3DtHP33mtaw3gMIZMPhMrq94=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xOgwf-000000006t0-01qx
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 04 Nov 2026 19:46:54 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id B56A1414B1;
 Wed,  4 Nov 2026 19:46:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5C321F00A1C;
 Wed,  4 Nov 2026 19:46:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793821607;
 bh=BimR1D9/wvZGY0reDOYel4C+9wjSglW0Ag8MNWquP3M=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=SYMjwR9CisNRR4trA29J7KYyt9QQltUoV6GaOZQupCdWwqP7nEenQBuyfJvbd/Y6G
 c+d8wNrGK/ym2gUcRUDIR39Q7A+spBR7QqRMpG1m5xpI7GS4v5txkTX1Y7D88y5HuI
 ImYXCqFJosDpkrORlHNlK3Vxl/xkCOHMjSg65oGEfSFzOwzh6fWQYonctIPAbQKmDl
 lz1o0JzenKjtMcZLg4GGdUEa6Bww5ILNLq3OPjsRnSTiz30hEJQknKv065WnqaGmx0
 Ks7S3MzxpObGiRSZDhv+2WnBKRf2AEuIAKyzXOfzT7JldhUl0nPlkfmO7w6syp2tgi
 qgbNGRI7x/qng==
To: ebiggers@kernel.org,
	hch@lst.de,
	fsverity@lists.linux.dev
Date: Wed,  4 Nov 2026 20:46:14 +0100
Message-ID: <20261104194618.103332-6-aalbersh@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261104194618.103332-1-aalbersh@kernel.org>
References: <20261104194618.103332-1-aalbersh@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xOgwf-000000006t0-01qx
Subject: [f2fs-dev] [PATCH 5/5] f2fs: use I_VERITY_BUILDING instead of
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
Cc: linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org,
 Andrey Albershteyn <aalbersh@kernel.org>, linux-btrfs@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
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
 fs/f2fs/verity.c | 15 ++++-----------
 3 files changed, 9 insertions(+), 23 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 28fd8afff5d4..ab6f6f182f97 100644
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
index f7423b3f6e4a..374c861f13b9 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -925,7 +925,6 @@ enum {
 	FI_EXTRA_ATTR,		/* indicate file has extra attribute */
 	FI_PROJ_INHERIT,	/* indicate file inherits projectid */
 	FI_PIN_FILE,		/* indicate file should not be gced */
-	FI_VERITY_IN_PROGRESS,	/* building fs-verity Merkle tree */
 	FI_COMPRESSED_FILE,	/* indicate file's data can be compressed */
 	FI_COMPRESS_CORRUPT,	/* indicate compressed cluster is corrupted */
 	FI_MMAP_FILE,		/* indicate file was mmapped */
@@ -3535,12 +3534,6 @@ static inline void clear_inode_flag(struct inode *inode, int flag)
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
index 4a2cea4288f9..af3d33c6f26d 100644
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
 
@@ -143,10 +139,9 @@ static int f2fs_end_enable_verity(struct file *filp, const void *desc,
 		goto cleanup;
 
 	/*
-	 * Write all pages (both data and verity metadata).  Note that this must
-	 * happen before clearing FI_VERITY_IN_PROGRESS; otherwise pages beyond
-	 * i_size won't be written properly.  For crash consistency, this also
-	 * must happen before the verity inode flag gets persisted.
+	 * Write all pages (both data and verity metadata). For crash
+	 * consistency, this also must happen before the verity inode flag gets
+	 * persisted.
 	 */
 	err = filemap_write_and_wait(inode->i_mapping);
 	if (err)
@@ -164,14 +159,13 @@ static int f2fs_end_enable_verity(struct file *filp, const void *desc,
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
@@ -186,7 +180,6 @@ static int f2fs_end_enable_verity(struct file *filp, const void *desc,
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
