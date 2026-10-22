Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B483606A31B
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 22 Oct 2026 12:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=KZPVSwEf;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=OWAATGKh;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=d/z9JudF;
	dkim=neutral header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fJqeeYB4
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-ID:Date:To:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=1zcpsFqQGLBWp/b9OYgxYQhHU1MrOi5w4SCuoOAjl80=; b=KZPVSwEfGQRINFnPxY0eFH37pq
	X9P558JgfWTTLwKiacX4A+4D7DxH7f4+fy0Mlkxzkqznie8eUTaZP+6QtjkrgPMOlgW/V4FUWmpZH
	rbJJ/ZUcLnX1a7YB2PbKjIDGQPHeTceBPpTsniNaXb6mbMUFfsDel0GbUtHsAm1XRFCU=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xJsID-000000005gv-3VLk;
	Thu, 22 Oct 2026 12:53:13 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <chao@kernel.org>) id 1xJsIB-000000005gj-0D4x
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 22 Oct 2026 12:53:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=mC7auiCaQGZIxut1v/QBYeg0DgUHWCkVzu3OemQGO7k=; b=OWAATGKhFbplbHJyTKp4+snlFJ
 XtIaQQdO14xDxMlA8ArE3A0xtvzX/cufEE/kpOcXYKmzvV/wWe+yRuohBDjcsIGyHQs5hBgeQUeP7
 jFObjTTPz9qOSaSZ9me7T5rEGFdM1WYnvDjJfvhUN/OUPYRVbz852dGP2NY3Yv++Ff9M=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=mC7auiCaQGZIxut1v/QBYeg0DgUHWCkVzu3OemQGO7k=; b=d/z9JudFzyld+IImK9ZPLaJKoC
 cL5tdiFku68FzDNjZkfk5IgwsaEnqUw4/Ii0P7n7U7gtITDyeoAYDDlxXgLhc7GKpY8zzwO9W5xBp
 3jCyULRAHWbQfvZ6RtoZ5cJfhscgTJWzwas1hBsV77P9Nd4hJANmUcYqxAR9a3LsNXbA=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xJsI7-000000001GP-08v8
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 22 Oct 2026 12:53:10 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 9FF324482B
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu, 22 Oct 2026 12:53:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 928FD1F000C5;
 Thu, 22 Oct 2026 12:53:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792673581;
 bh=mC7auiCaQGZIxut1v/QBYeg0DgUHWCkVzu3OemQGO7k=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=fJqeeYB46NR7x7eozWMgPsBjibI0+5qLaTN7u4ooecCnqokBue5VEihM7pxhvpMGw
 Hc93tOzLzLIny8t/dLpFQQK2VVl1aw8pPAH8p73/xJRwpfyaILATzrWqRh+9ZGLtX3
 OLSjNVNGNbyw+2v2vNcTykYmTzRfmVj28f1+yrAMrbu3BDsTAfOt+PhtlMDhYM7UBw
 GUDlsAUWNPfE5z9rOrspqnNycj+A6Y9tV2r0fS0EWuw8a0OG5s4ddBVXrOJfUOMDt4
 yRA0OSR/aZflgCWKO1R5BfVg1o/0IkWQalVnB3GOGfSC/PxY2lhC6opgSL11DXQ9aA
 YzhCN5tK8LOSA==
To: jaegeuk@kernel.org
Date: Thu, 22 Oct 2026 12:52:41 +0000
Message-ID: <20261022125244.2205275-4-chao@kernel.org>
X-Mailer: git-send-email 2.56.0.218.g1ec904b173-goog
In-Reply-To: <20261022125244.2205275-1-chao@kernel.org>
References: <20261022125244.2205275-1-chao@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xJsI7-000000001GP-08v8
Subject: [f2fs-dev] [PATCH 4/7] f2fs: fix to truncate stale meta cache entry
 on in-place update
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
Cc: stable@kernel.org, linux-kernel@vger.kernel.org,
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

Cc: stable@kernel.org
Fixes: b40a2b003709 ("f2fs: use meta inode for GC of atomic file")
Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/segment.c | 23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index daf6d9617d5b..c24910839583 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -4282,8 +4282,13 @@ int f2fs_inplace_write_data(struct f2fs_io_info *fio)
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
 
@@ -4471,12 +4476,16 @@ void f2fs_wait_on_block_writeback_range(struct inode *inode, block_t blkaddr,
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
