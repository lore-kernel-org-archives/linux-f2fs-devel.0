Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B896CA5FE6
	for <linux-f2fs-devel@archiver.kernel.org>; Fri,  2 Oct 2026 22:38:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-ID:Date:To:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5ftll5jYvyf/Z3tCXpMjAHolkQEteWhSUqPyrUEhBqg=; b=GV8x1eWA1bgE6X1wTg2ImatfQN
	NpnactVmNLPq0l7NAhgWjGbCCR46XClBPov5QsXCUkR38gvufDfLxDqU6PzLggwHsE5irCJIX9Gz5
	VaI609FAoT1pjIJOFGQK3sdON54iXbX5KczCUK4dfmmE6VwcaxbcuX102Tz/12oAHuoY=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xCltB-0007Ig-Rb;
	Fri, 02 Oct 2026 22:37:59 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <aalbersh@kernel.org>) id 1xCltA-0007IW-R2
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 02 Oct 2026 22:37:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=dvtqKS0n96fAVujRqx2ORjcVNwtZXlHKAcxua1BPCkQ=; b=D2nEAdnXlMWr5u5AaieaVuwYRm
 bzIbWb94NKb7EwgkiEi4NR65I1sQjm+qBd9w7MUbSRUf45oSNQE4GDRwr+UmyYNxZ1VXJiRHFMQHO
 xWsDsEqv2RUylkTnIz5sBgJS2eyHLBMaLy0cd8+vrePCF1LIe/fsN6QBDoT6es3QdlqQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=dvtqKS0n96fAVujRqx2ORjcVNwtZXlHKAcxua1BPCkQ=; b=HfjIj4Oc2o/fxSp66sAp41lAsd
 tX7danoMBDmYzxe75U/ZjBYHcJimo0o3NwS4psWL+Y1jVBlfTz/Irg/TK5aRQWjysLByYAw+0b9+1
 /UIXR6ijEueqSI3elkdk1uhFjB+x4spDc9A33SRkdR/fe/aUca0SAgcOiK+lsyCWljOs=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1xClt6-0006bS-U2 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 02 Oct 2026 22:37:58 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 9F278447E7;
 Fri,  2 Oct 2026 22:37:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86C731F00893;
 Fri,  2 Oct 2026 22:37:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790980671;
 bh=dvtqKS0n96fAVujRqx2ORjcVNwtZXlHKAcxua1BPCkQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=Um6giWYfKVSRYSzIVspSz4rGB0wLsnTcz+weHoBt7jJr/HqS2T1h8GvPPt7MTuej7
 X48FiP8p0zLbv2AJiqNSe7kMjw0EGMFIJyuEFozdoTtNIQKCgG2EpBCLELUlMJF8VF
 wPQ4+i9vVpuH7L4N+A51QFwDhNuiwIQA9Ilo3BA068IsMde7j/UqmkNZT1g7/HdT8m
 8H0Hmlem7S5C4dhsf5qDTk0RNOARNYYi913tnJyP7hdnLy1SZdfWTnqNdqOUfFK+fh
 C7NV0ZV+Mz4HprrdE6q/GScTEQZCwr+dAoDblpN1vldiH9VC6LE/sPFTouFi1QEFt6
 a3/mC89KEGDng==
To: djwong@kernel.org, ebiggers@kernel.org, hch@lst.de,
 Carlos Maiolino <cem@kernel.org>
Date: Sat,  3 Oct 2026 00:36:52 +0200
Message-ID: <20261002223705.2175542-12-aalbersh@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261002223705.2175542-1-aalbersh@kernel.org>
References: <20261002223705.2175542-1-aalbersh@kernel.org>
MIME-Version: 1.0
X-Headers-End: 1xClt6-0006bS-U2
Subject: [f2fs-dev] [PATCH v17 11/21] xfs: handle fsverity I/O in write/read
 path
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
Cc: fsverity@lists.linux.dev, Andrey Albershteyn <aalbersh@kernel.org>,
 david@fromorbit.com, linux-unionfs@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
 linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

For write/writeback set IOMAP_F_FSVERITY flag telling iomap to not
update inode size and to not skip folios beyond EOF.

Initiate fsverity writeback with IOMAP_F_FSVERITY set to tell iomap
should not skip folio that is dirty beyond EOF.

In read path let iomap know that we are reading fsverity metadata. So,
treat holes in the tree as request to synthesize tree blocks and hole
after descriptor as end of the fsverity region.

Introduce a new inode flag meaning that merkle tree is being build on
the inode.

Signed-off-by: Andrey Albershteyn <aalbersh@kernel.org>
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 fs/xfs/Makefile          |  1 +
 fs/xfs/libxfs/xfs_bmap.c |  9 +++++++++
 fs/xfs/xfs_aops.c        | 36 +++++++++++++++++++++++++++++++-----
 fs/xfs/xfs_fsverity.c    | 22 ++++++++++++++++++++++
 fs/xfs/xfs_fsverity.h    | 20 ++++++++++++++++++++
 fs/xfs/xfs_inode.h       |  6 ++++++
 fs/xfs/xfs_iomap.c       | 37 ++++++++++++++++++++++++++++---------
 fs/xfs/xfs_iomap.h       |  5 +++--
 8 files changed, 120 insertions(+), 16 deletions(-)
 create mode 100644 fs/xfs/xfs_fsverity.c
 create mode 100644 fs/xfs/xfs_fsverity.h

diff --git a/fs/xfs/Makefile b/fs/xfs/Makefile
index 399a207f2d0e..dd712c521862 100644
--- a/fs/xfs/Makefile
+++ b/fs/xfs/Makefile
@@ -150,6 +150,7 @@ xfs-$(CONFIG_XFS_POSIX_ACL)	+= xfs_acl.o
 xfs-$(CONFIG_SYSCTL)		+= xfs_sysctl.o
 xfs-$(CONFIG_COMPAT)		+= xfs_ioctl32.o
 xfs-$(CONFIG_EXPORTFS_BLOCK_OPS)	+= xfs_pnfs.o
+xfs-$(CONFIG_FS_VERITY)		+= xfs_fsverity.o
 
 # notify failure
 ifeq ($(CONFIG_MEMORY_FAILURE),y)
diff --git a/fs/xfs/libxfs/xfs_bmap.c b/fs/xfs/libxfs/xfs_bmap.c
index d64defeda645..9dc96a4edea6 100644
--- a/fs/xfs/libxfs/xfs_bmap.c
+++ b/fs/xfs/libxfs/xfs_bmap.c
@@ -41,6 +41,8 @@
 #include "xfs_inode_util.h"
 #include "xfs_rtgroup.h"
 #include "xfs_zone_alloc.h"
+#include "xfs_fsverity.h"
+#include <linux/fsverity.h>
 
 struct kmem_cache		*xfs_bmap_intent_cache;
 
@@ -4402,6 +4404,9 @@ xfs_bmapi_convert_one_delalloc(
 	 * the extent.  Just return the real extent at this offset.
 	 */
 	if (!isnullstartblock(bma.got.br_startblock)) {
+		if (xfs_iflags_test(ip, XFS_VERITY_CONSTRUCTION) &&
+		    offset >= xfs_fsverity_metadata_offset(ip))
+			flags |= IOMAP_F_FSVERITY;
 		xfs_bmbt_to_iomap(ip, iomap, &bma.got, 0, flags,
 				xfs_iomap_inode_sequence(ip, flags));
 		if (seq)
@@ -4449,6 +4454,10 @@ xfs_bmapi_convert_one_delalloc(
 	XFS_STATS_ADD(mp, xs_xstrat_bytes, XFS_FSB_TO_B(mp, bma.length));
 	XFS_STATS_INC(mp, xs_xstrat_quick);
 
+	if (xfs_iflags_test(ip, XFS_VERITY_CONSTRUCTION) &&
+	    offset >= xfs_fsverity_metadata_offset(ip))
+		flags |= IOMAP_F_FSVERITY;
+
 	ASSERT(!isnullstartblock(bma.got.br_startblock));
 	xfs_bmbt_to_iomap(ip, iomap, &bma.got, 0, flags,
 				xfs_iomap_inode_sequence(ip, flags));
diff --git a/fs/xfs/xfs_aops.c b/fs/xfs/xfs_aops.c
index c30e688cfc9f..19640e4e3ed1 100644
--- a/fs/xfs/xfs_aops.c
+++ b/fs/xfs/xfs_aops.c
@@ -23,6 +23,7 @@
 #include "xfs_ioend.h"
 #include "xfs_zone_alloc.h"
 #include "xfs_rtgroup.h"
+#include "xfs_fsverity.h"
 
 struct xfs_writepage_ctx {
 	struct iomap_writepage_ctx ctx;
@@ -172,12 +173,16 @@ xfs_map_blocks(
 	int			retries = 0;
 	int			error = 0;
 	unsigned int		*seq;
+	unsigned int		iomap_flags = 0;
 
 	if (xfs_is_shutdown(mp))
 		return -EIO;
 
 	XFS_ERRORTAG_DELAY(mp, XFS_ERRTAG_WB_DELAY_MS);
 
+	if (xfs_iflags_test(ip, XFS_VERITY_CONSTRUCTION))
+		iomap_flags |= IOMAP_F_FSVERITY;
+
 	/*
 	 * COW fork blocks can overlap data fork blocks even if the blocks
 	 * aren't shared.  COW I/O always takes precedent, so we must always
@@ -265,7 +270,8 @@ xfs_map_blocks(
 	    isnullstartblock(imap.br_startblock))
 		goto allocate_blocks;
 
-	xfs_bmbt_to_iomap(ip, &wpc->iomap, &imap, 0, 0, XFS_WPC(wpc)->data_seq);
+	xfs_bmbt_to_iomap(ip, &wpc->iomap, &imap, 0, iomap_flags,
+			  XFS_WPC(wpc)->data_seq);
 	trace_xfs_map_blocks_found(ip, offset, count, whichfork, &imap);
 	return 0;
 allocate_blocks:
@@ -412,12 +418,16 @@ xfs_zoned_map_blocks(
 	xfs_filblks_t		count_fsb;
 	struct xfs_bmbt_irec	imap, del;
 	struct xfs_iext_cursor	icur;
+	u16			iomap_flags = 0;
 
 	if (xfs_is_shutdown(mp))
 		return -EIO;
 
 	XFS_ERRORTAG_DELAY(mp, XFS_ERRTAG_WB_DELAY_MS);
 
+	if (xfs_iflags_test(ip, XFS_VERITY_CONSTRUCTION))
+		iomap_flags |= IOMAP_F_FSVERITY;
+
 	/*
 	 * All dirty data must be covered by delalloc extents.  But truncate can
 	 * remove delalloc extents underneath us or reduce their size.
@@ -441,7 +451,7 @@ xfs_zoned_map_blocks(
 		imap.br_startblock = HOLESTARTBLOCK;
 		imap.br_state = XFS_EXT_NORM;
 		xfs_iunlock(ip, XFS_ILOCK_EXCL);
-		xfs_bmbt_to_iomap(ip, &wpc->iomap, &imap, 0, 0, 0);
+		xfs_bmbt_to_iomap(ip, &wpc->iomap, &imap, 0, iomap_flags, 0);
 		return 0;
 	}
 	end_fsb = min(end_fsb, imap.br_startoff + imap.br_blockcount);
@@ -454,7 +464,7 @@ xfs_zoned_map_blocks(
 	xfs_iunlock(ip, XFS_ILOCK_EXCL);
 
 	xfs_iomap_set_anon_write(ip, &wpc->iomap, offset,
-			XFS_FSB_TO_B(mp, count_fsb));
+			XFS_FSB_TO_B(mp, count_fsb), iomap_flags);
 	trace_xfs_zoned_map_blocks(ip, offset, wpc->iomap.length);
 	return 0;
 }
@@ -507,6 +517,22 @@ static const struct iomap_writeback_ops xfs_zoned_writeback_ops = {
 	.writeback_submit	= xfs_zoned_writeback_submit,
 };
 
+static int
+xfs_iomap_writepages(
+	struct xfs_inode		*ip,
+	struct iomap_writepage_ctx	*ctx)
+{
+	/*
+	 * Writeback does not work for folios past EOF, let it know that
+	 * I/O happens for fsverity metadata and this restriction need
+	 * to be skipped
+	 */
+	if (xfs_iflags_test(ip, XFS_VERITY_CONSTRUCTION))
+		ctx->iomap.flags |= IOMAP_F_FSVERITY;
+
+	return iomap_writepages(ctx);
+}
+
 STATIC int
 xfs_vm_writepages(
 	struct address_space	*mapping,
@@ -526,7 +552,7 @@ xfs_vm_writepages(
 		};
 		int				error;
 
-		error = iomap_writepages(&xc.ctx);
+		error = xfs_iomap_writepages(ip, &xc.ctx);
 		if (xc.open_zone)
 			xfs_open_zone_put(xc.open_zone);
 		return error;
@@ -539,7 +565,7 @@ xfs_vm_writepages(
 			},
 		};
 
-		return iomap_writepages(&wpc.ctx);
+		return xfs_iomap_writepages(ip, &wpc.ctx);
 	}
 }
 
diff --git a/fs/xfs/xfs_fsverity.c b/fs/xfs/xfs_fsverity.c
new file mode 100644
index 000000000000..e30021c22683
--- /dev/null
+++ b/fs/xfs/xfs_fsverity.c
@@ -0,0 +1,22 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2026 Red Hat, Inc.
+ */
+#include "xfs_platform.h"
+#include "xfs_fs.h"
+#include "xfs_shared.h"
+#include "xfs_format.h"
+#include "xfs_log_format.h"
+#include "xfs_trans_resv.h"
+#include "xfs_mount.h"
+#include "xfs_inode.h"
+#include "xfs_fsverity.h"
+#include <linux/fsverity.h>
+#include <linux/iomap.h>
+
+loff_t
+xfs_fsverity_metadata_offset(
+	const struct xfs_inode	*ip)
+{
+	return round_up(i_size_read(VFS_IC(ip)), XFS_FSVERITY_START_ALIGN);
+}
diff --git a/fs/xfs/xfs_fsverity.h b/fs/xfs/xfs_fsverity.h
new file mode 100644
index 000000000000..c2ab5af89370
--- /dev/null
+++ b/fs/xfs/xfs_fsverity.h
@@ -0,0 +1,20 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2026 Red Hat, Inc.
+ */
+#ifndef __XFS_FSVERITY_H__
+#define __XFS_FSVERITY_H__
+
+#include "xfs_platform.h"
+
+#ifdef CONFIG_FS_VERITY
+loff_t xfs_fsverity_metadata_offset(const struct xfs_inode *ip);
+#else
+static inline loff_t xfs_fsverity_metadata_offset(const struct xfs_inode *ip)
+{
+	WARN_ON_ONCE(1);
+	return ULLONG_MAX;
+}
+#endif	/* CONFIG_FS_VERITY */
+
+#endif	/* __XFS_FSVERITY_H__ */
diff --git a/fs/xfs/xfs_inode.h b/fs/xfs/xfs_inode.h
index 1602027cd0aa..af5ced6997e8 100644
--- a/fs/xfs/xfs_inode.h
+++ b/fs/xfs/xfs_inode.h
@@ -419,6 +419,12 @@ static inline bool xfs_inode_can_sw_atomic_write(const struct xfs_inode *ip)
  */
 #define XFS_IREMAPPING		(1U << 15)
 
+/*
+ * fs-verity's Merkle tree is under construction. The file is read-only, the
+ * only writes happening are for the fsverity metadata.
+ */
+#define XFS_VERITY_CONSTRUCTION	(1U << 16)
+
 /* All inode state flags related to inode reclaim. */
 #define XFS_ALL_IRECLAIM_FLAGS	(XFS_IRECLAIMABLE | \
 				 XFS_IRECLAIM | \
diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
index 7c6238fed61e..ccc8b8fabab3 100644
--- a/fs/xfs/xfs_iomap.c
+++ b/fs/xfs/xfs_iomap.c
@@ -32,6 +32,8 @@
 #include "xfs_rtbitmap.h"
 #include "xfs_icache.h"
 #include "xfs_zone_alloc.h"
+#include "xfs_fsverity.h"
+#include <linux/fsverity.h>
 
 #define XFS_ALLOC_ALIGN(mp, off) \
 	(((off) >> mp->m_allocsize_log) << mp->m_allocsize_log)
@@ -883,6 +885,9 @@ xfs_direct_write_iomap_begin(
 	if (flags & IOMAP_ATOMIC)
 		iomap_flags |= IOMAP_F_ATOMIC_BIO;
 
+	if (xfs_iflags_test(ip, XFS_VERITY_CONSTRUCTION))
+		iomap_flags |= IOMAP_F_FSVERITY;
+
 	/*
 	 * COW writes may allocate delalloc space or convert unwritten COW
 	 * extents, so we need to make sure to take the lock exclusively here.
@@ -1023,7 +1028,8 @@ xfs_direct_write_iomap_begin(
 	trace_xfs_iomap_found(ip, offset, length - offset, XFS_COW_FORK, &cmap);
 	if (imap.br_startblock != HOLESTARTBLOCK) {
 		seq = xfs_iomap_inode_sequence(ip, 0);
-		error = xfs_bmbt_to_iomap(ip, srcmap, &imap, flags, 0, seq);
+		error = xfs_bmbt_to_iomap(ip, srcmap, &imap, flags,
+				iomap_flags & IOMAP_F_FSVERITY, seq);
 		if (error)
 			goto out_unlock;
 	}
@@ -1083,7 +1089,7 @@ xfs_zoned_direct_write_iomap_begin(
 			return error;
 	}
 
-	xfs_iomap_set_anon_write(ip, iomap, offset, length);
+	xfs_iomap_set_anon_write(ip, iomap, offset, length, 0);
 	return 0;
 }
 
@@ -1595,7 +1601,8 @@ xfs_zoned_buffered_write_iomap_begin(
 	loff_t			count,
 	unsigned		flags,
 	struct iomap		*iomap,
-	struct iomap		*srcmap)
+	struct iomap		*srcmap,
+	u16			iomap_flags)
 {
 	struct iomap_iter	*iter =
 		container_of(iomap, struct iomap_iter, iomap);
@@ -1605,7 +1612,6 @@ xfs_zoned_buffered_write_iomap_begin(
 	struct xfs_mount	*mp = ip->i_mount;
 	xfs_fileoff_t		offset_fsb = XFS_B_TO_FSBT(mp, offset);
 	xfs_fileoff_t		end_fsb = xfs_iomap_end_fsb(mp, offset, count);
-	u16			iomap_flags = IOMAP_F_SHARED;
 	unsigned int		lockmode = XFS_ILOCK_EXCL;
 	xfs_filblks_t		count_fsb;
 	xfs_extlen_t		indlen;
@@ -1668,7 +1674,8 @@ xfs_zoned_buffered_write_iomap_begin(
 				smap.br_startoff + smap.br_blockcount);
 			xfs_trim_extent(&smap, offset_fsb,
 					end_fsb - offset_fsb);
-			error = xfs_bmbt_to_iomap(ip, srcmap, &smap, flags, 0,
+			error = xfs_bmbt_to_iomap(ip, srcmap, &smap, flags,
+					iomap_flags,
 					xfs_iomap_inode_sequence(ip, 0));
 			if (error)
 				goto out_unlock;
@@ -1678,6 +1685,8 @@ xfs_zoned_buffered_write_iomap_begin(
 	if (!ip->i_cowfp)
 		xfs_ifork_init_cow(ip);
 
+	iomap_flags |= IOMAP_F_SHARED;
+
 	if (!xfs_iext_lookup_extent(ip, ip->i_cowfp, offset_fsb, &icur, &got))
 		got.br_startoff = end_fsb;
 	if (got.br_startoff <= offset_fsb) {
@@ -1809,9 +1818,12 @@ xfs_buffered_write_iomap_begin(
 	if (xfs_is_shutdown(mp))
 		return -EIO;
 
+	if (xfs_iflags_test(ip, XFS_VERITY_CONSTRUCTION))
+		iomap_flags |= IOMAP_F_FSVERITY;
+
 	if (xfs_is_zoned_inode(ip))
 		return xfs_zoned_buffered_write_iomap_begin(inode, offset,
-				count, flags, iomap, srcmap);
+				count, flags, iomap, srcmap, iomap_flags);
 
 	/* we can't use delayed allocations when using extent size hints */
 	if (xfs_get_extsz_hint(ip))
@@ -2095,7 +2107,8 @@ xfs_buffered_write_iomap_begin(
 
 found_cow:
 	if (imap.br_startoff <= offset_fsb) {
-		error = xfs_bmbt_to_iomap(ip, srcmap, &imap, flags, 0,
+		error = xfs_bmbt_to_iomap(ip, srcmap, &imap, flags,
+				iomap_flags & IOMAP_F_FSVERITY,
 				xfs_iomap_inode_sequence(ip, 0));
 		if (error)
 			goto out_unlock;
@@ -2199,12 +2212,17 @@ xfs_read_iomap_begin(
 	bool			shared = false;
 	unsigned int		lockmode = XFS_ILOCK_SHARED;
 	u64			seq;
+	unsigned int		iomap_flags = 0;
 
 	ASSERT(!(flags & (IOMAP_WRITE | IOMAP_ZERO)));
 
 	if (xfs_is_shutdown(mp))
 		return -EIO;
 
+	if (fsverity_active(inode) &&
+	    (offset >= xfs_fsverity_metadata_offset(ip)))
+		iomap_flags |= IOMAP_F_FSVERITY;
+
 	error = xfs_ilock_for_iomap(ip, flags, &lockmode);
 	if (error)
 		return error;
@@ -2218,8 +2236,9 @@ xfs_read_iomap_begin(
 	if (error)
 		return error;
 	trace_xfs_iomap_found(ip, offset, length, XFS_DATA_FORK, &imap);
-	return xfs_bmbt_to_iomap(ip, iomap, &imap, flags,
-				 shared ? IOMAP_F_SHARED : 0, seq);
+	iomap_flags |= shared ? IOMAP_F_SHARED : 0;
+
+	return xfs_bmbt_to_iomap(ip, iomap, &imap, flags, iomap_flags, seq);
 }
 
 static DEFINE_IOMAP_ITER_NEXT(xfs_read_iomap_next, xfs_read_iomap_begin);
diff --git a/fs/xfs/xfs_iomap.h b/fs/xfs/xfs_iomap.h
index f2520a9b3a13..d3ca0f2afc9f 100644
--- a/fs/xfs/xfs_iomap.h
+++ b/fs/xfs/xfs_iomap.h
@@ -34,13 +34,14 @@ xfs_iomap_set_anon_write(
 	struct xfs_inode		*ip,
 	struct iomap			*iomap,
 	loff_t				offset,
-	loff_t				length)
+	loff_t				length,
+	u16				iomap_flags)
 {
 	iomap->type = IOMAP_MAPPED;
 	iomap->bdev = ip->i_mount->m_rtdev_targp->bt_bdev;
 	iomap->offset = offset;
 	iomap->length = length;
-	iomap->flags = IOMAP_F_ANON_WRITE | IOMAP_F_DIRTY;
+	iomap->flags = iomap_flags | IOMAP_F_ANON_WRITE | IOMAP_F_DIRTY;
 	if (bdev_has_integrity_csum(iomap->bdev))
 		iomap->flags |= IOMAP_F_INTEGRITY;
 }
-- 
2.54.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
