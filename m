Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0BA2606A699
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 27 Nov 2026 10:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=Qlq1QbS7;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=hYpZBtCH;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=KysiwcwJ;
	dkim=neutral header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IHzHn/Ug
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-ID:Date:To:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=lh0EtfhB4sayUjt7xPE7VxfU+WfnrjFqZTnlF2ty294=; b=Qlq1QbS7TDG8cAWVtVmwvGDfVO
	/PrOK+ftcUnRSLoex0QO8LKXr5B4ohkMoqTfSCBunmNurjeqtjCNhyTTCq6TRiR3k9GK/0Cp+gMUk
	cWUc4tEMyJNRM65Knb84dZQAJ21peLjpxzGEdfKykqfIqlTBRWgi/SljH0TgXyj3WV/s=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xWtcz-000000006Vg-1cHz;
	Fri, 27 Nov 2026 10:56:29 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <chao@kernel.org>) id 1xWtcy-000000006VW-1L8Z
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 27 Nov 2026 10:56:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=QAh84q6dLbI/ZquU3Mza3G28fl4mzR7JeprffGBtWYo=; b=hYpZBtCHAfJUbLodXvtXxt4820
 j5u/+fXOEtIFf+J0YBbg7OCAMr0YWNc/V6qwqDbQWjdgmaPNA99b2Ku6dJqwUHDnD7D1yooloj192
 aOKVag/J2M2zq0ZEgeIF1ypRb6WMQoh86nmnfgWqQHOWKPYBc6epnZ1tZBoew2hMxQDc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=QAh84q6dLbI/ZquU3Mza3G28fl4mzR7JeprffGBtWYo=; b=KysiwcwJfEvUlE7rnsHv+NHIIt
 US5QTmsq6HPXfJDt0o9Y4w6+MIvD11DWCzMWNuZ3417t+zpWwH2+e3TWNrymwMsFnYrKtnruFg8TT
 wcjbD3fT5Dr7Asj0MZaIvdS1fp41N3LVCruJA5/zrlO8n91NzwuAB/m9LM8S3ejLNxsk=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xWtcv-000000001Be-1XNA
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 27 Nov 2026 10:56:28 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 17493454F1
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri, 27 Nov 2026 10:56:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01BC21F00926;
 Fri, 27 Nov 2026 10:56:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795776979;
 bh=QAh84q6dLbI/ZquU3Mza3G28fl4mzR7JeprffGBtWYo=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=IHzHn/UgRN1GswdchlZznL5F3U6pEHEuSM0sjGOXNlX12egXX+zbmjSOTTUURNZC4
 FR1qFVVmxVCMGpy77lUC3UAGiHS/+Z5AnacISl+bYe7zew4vccqxOwPvs2PxA2na5x
 8huf30WCu/wphxOfjgywezVXfWWYUGk7u/NwQpysXgEIMfRwMDQg31/amaWSF+laRr
 wx+wlncehZeJRR1XKgQ4ghOic8yoSUba9iaR/9hm8ENH8qFzttgqYj8QwzXQuihbgA
 N9rnepDV/MLj2xilr4j2TQ2sqxTkMiXQUp01rOPgCKOYud3jhjGV/pSLas0qg7XzaE
 XJH77sG8heSqQ==
To: jaegeuk@kernel.org
Date: Fri, 27 Nov 2026 10:56:11 +0000
Message-ID: <20261127105608.537148-11-chao@kernel.org>
X-Mailer: git-send-email 2.56.1.839.g22a8290db9-goog
In-Reply-To: <20261127105608.537148-8-chao@kernel.org>
References: <20261127105608.537148-8-chao@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xWtcv-000000001Be-1XNA
Subject: [f2fs-dev] [PATCH v2 4/7] f2fs: fix to truncate stale meta cache
 entry on in-place update
X-BeenThere: linux-f2fs-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
From: Chao Yu via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Chao Yu <chao@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Chao Yu <chao@kernel.org>

GC migrates data blocks of the inode which requires meta inode GC via
meta cache, and it trusts an uptodate entry w/o reading the block from
disk again, in both ra_data_block() and move_data_block().

However, in-place update paths only truncate the entry if the inode
requires meta inode GC at the time of writing:
- f2fs_inplace_write_data() checks fio->meta_gc
- f2fs_wait_on_block_writeback_range() for DIO checks
f2fs_meta_inode_gc_required()

f2fs_meta_inode_gc_required() returns true for atomic and COW files,
which is a temporary state, so an entry cached during atomic write, or
cached before the block was donated by F2FS_IOC_MOVE_RANGE, can survive
in-place update once the owner does not require meta inode GC, then GC
will migrate stale data from the entry once the owner requires meta
inode GC again, resulting in overwriting valid data.

Case #1: atomic write

- App (file F)				- GC
- ioctl(F2FS_IOC_START_ATOMIC_WRITE)
 : f2fs_meta_inode_gc_required(F) is true
- write F[k], k != j
					- gc_data_segment() phase 3
					 - ra_data_block(F, j)
					  : cache F[j] in META[P]
- ioctl(F2FS_IOC_COMMIT_ATOMIC_WRITE)
 - f2fs_commit_atomic_write()
  - f2fs_down_write(i_gc_rwsem[WRITE])
					- gc_data_segment() phase 4
					 - f2fs_down_write_trylock(i_gc_rwsem[WRITE])
					 : fail, skip F[j]
  - __f2fs_commit_atomic_write()
  : only F[k] is replaced, F[j] is still mapped to P
  - f2fs_up_write(i_gc_rwsem[WRITE])
 - f2fs_abort_atomic_write()
  - clear_inode_flag(FI_ATOMIC_FILE)
- write F[j] w/ new data, fdatasync()
 - f2fs_inplace_write_data()
 : fio->meta_gc is false, META[P] becomes stale
- ioctl(F2FS_IOC_START_ATOMIC_WRITE)
					- gc_data_segment() phase 3
					 - ra_data_block(F, j)
					 : META[P] is uptodate, skip reading
					- gc_data_segment() phase 4
					 - move_data_block(F, j)
					 : META[P] is uptodate, skip reading
					  - memcpy(tentry, sentry)
					  - f2fs_update_data_blkaddr(newaddr)
					 : F[j] was rolled back to old data

Case #2: F2FS_IOC_MOVE_RANGE

- Thread A (src)			- GC			- Thread B (dst)
- write src[i], P is not checkpointed
- ioctl(F2FS_IOC_START_ATOMIC_WRITE)
					- gc_data_segment() phase 3
					 - ra_data_block(src, i)
					 : cache src[i] in META[P]
					- gc_data_segment() phase 4
					 : fail to lock i_gc_rwsem, skip src[i]
- ioctl(F2FS_IOC_ABORT_ATOMIC_WRITE)
 - f2fs_abort_atomic_write()
  - clear_inode_flag(FI_ATOMIC_FILE)
- ioctl(F2FS_IOC_MOVE_RANGE, src[i] -> dst[j])
 - f2fs_move_file_range()
  - __exchange_data_block()
   - __read_out_blkaddrs()
   : P is not checkpointed, do not invalidate it
   - __clone_blkaddrs()
    - f2fs_replace_block(dst[j], P)
									- write dst[j] w/ new data, fdatasync()
									 - f2fs_inplace_write_data()
									 : fio->meta_gc is false, META[P] becomes stale
									- ioctl(F2FS_IOC_START_ATOMIC_WRITE)
					- gc_data_segment()
					 - ra_data_block(dst, j)
					 - move_data_block(dst, j)
					 : migrate stale data in META[P]
					 : dst[j] was overwritten w/ src[i]'s old data

DIO overwrite has the same issue, since f2fs_map_blocks() w/
F2FS_GET_BLOCK_DIO calls f2fs_wait_on_block_writeback_range() for the
block which will be overwritten in place.

Before commit 570e2ccc7cb3 ("f2fs: avoid reading already updated pages
during GC"), ra_data_block() always read the block from disk, then the
stale entry would be updated before move_data_block() used it.

Let's always truncate the meta cache entry in f2fs_inplace_write_data()
and f2fs_wait_on_block_writeback_range() regardless of current state of
the inode, and only wait for writeback of the cache entry when the inode
requires meta inode GC.

Cc: stable@vger.kernel.org
Fixes: b40a2b003709 ("f2fs: use meta inode for GC of atomic file")
Signed-off-by: Chao Yu <chao@kernel.org>
---
v2:
- rebase to the latest dev-test branch.

 fs/f2fs/segment.c | 23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 73dc88aa6dde..1bfe1802f7dd 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -4305,8 +4305,13 @@ int f2fs_inplace_write_data(struct f2fs_io_info *fio)
 		goto drop_bio;
 	}
 
-	if (fio->meta_gc)
-		f2fs_truncate_meta_caches(sbi, fio->new_blkaddr, 1);
+	/*
+	 * GC may have cached this block in meta cache while its owner was in
+	 * atomic write or before it was donated by F2FS_IOC_MOVE_RANGE, so
+	 * truncate it regardless of fio->meta_gc to avoid that GC migrates
+	 * stale data from meta cache later.
+	 */
+	f2fs_truncate_meta_caches(sbi, fio->new_blkaddr, 1);
 
 	stat_inc_inplace_blocks(fio->sbi);
 
@@ -4494,12 +4499,16 @@ void f2fs_wait_on_block_writeback_range(struct inode *inode, block_t blkaddr,
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
 	block_t i;
 
-	if (!f2fs_meta_inode_gc_required(inode))
-		return;
-
-	for (i = 0; i < len; i++)
-		f2fs_wait_on_block_writeback(inode, blkaddr + i);
+	if (f2fs_meta_inode_gc_required(inode)) {
+		for (i = 0; i < len; i++)
+			f2fs_wait_on_block_writeback(inode, blkaddr + i);
+	}
 
+	/*
+	 * GC may have cached these blocks in meta cache while their owner
+	 * required meta inode GC, truncate them regardless of current state
+	 * of the inode, since DIO may overwrite them in place.
+	 */
 	f2fs_truncate_meta_caches(sbi, blkaddr, len);
 }
 
-- 
2.49.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
