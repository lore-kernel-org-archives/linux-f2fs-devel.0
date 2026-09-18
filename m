Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2F5EC982DA
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 18 Sep 2026 11:16:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-ID:Date:To:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=y1XPuUvB1g+5jOIdcOpFLR4aY5xJZrKB3mfj4E6mNds=; b=OzXP+0qBhD4khf1xSNJviX8eev
	GKnBWkuUfFek4MEahpc7bjyRlADF5dM6rJqgwLsE+hmL2U5ys7JBEF8UMoTgGVR3M5tWRr1CzNJRu
	/KyUCthtD7ucrDpnK3F8riHxMABWmaVEXJDQhvOMIDvtk7NS6fCtyZ41qP1nxF5toCFc=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1x7Wa8-0003qf-0R;
	Fri, 18 Sep 2026 11:16:40 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <aalbersh@kernel.org>) id 1x7Wa7-0003qU-1m
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 18 Sep 2026 11:16:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=v3Ncvjf0hwtJJZK9pRrZLdGb+szlbnZRxACnVZ65HjM=; b=J4677goPMdG2DK5R5qzIO+NCUt
 SVdRNSnC3bdlVC6DIy4UijDzBN55wHxt+TPxHo6Nr17dbfr8umsX5OBjlRU6YQEUrGTE5Eo0SN4Ks
 gorwW/cHAxUzgeyRiW9nmVO5TKNfDcQunRUFvaHxUNDh+lwOnkP71ldfQajji+4OXeYY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=v3Ncvjf0hwtJJZK9pRrZLdGb+szlbnZRxACnVZ65HjM=; b=iwL4fEfC9n4jBFQTPwL00Y07cK
 y2OD2uDNfck9IuH/Qd+Sr6BMANsGLtg2551ud0c2c49zZwz6tjqBOrW01LzpVY2HCKsDSf9h2DcvT
 PhcU5PXGAE5R66zna5CYBChWesw1UeRJfvRgkPxXZ/tKIAr/XqmqWJsPZ5B5R2H9uSSs=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1x7Wa4-0007rh-TZ for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 18 Sep 2026 11:16:39 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id B12DB60A94;
 Fri, 18 Sep 2026 11:16:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B28C1F00899;
 Fri, 18 Sep 2026 11:16:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789730196;
 bh=v3Ncvjf0hwtJJZK9pRrZLdGb+szlbnZRxACnVZ65HjM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=dptXv+sNkIxYDgXRi1/EPcntOCS7ZJhaCpmsZjtPQdyYbVkCY1+Mrd/sHGMuIXBf9
 WPuvtMKlTM9CRFZh9dg0BFqqg7XQOcLU9FrxIvKlHtLHmFP6MN1tp5V8kss3evWJWC
 V0h8gXL4JGXtWUzmCkJNv9WyCuGm7fmJnKkZ9R9pM5Pldm3UttN9syapBYxIVs/Q4K
 E1shcEWQUGtpERN3mYzA6VerwR1/y0T4SvyE6BUv6ZJysHeK/50VjRbivTqnpuJnPd
 Tnnd3V5NUfLa5jNLrJY9VTpClfxLwxuirdEMl18rwPZRh6NE2weoKDrvJb7B5NV4+3
 NrFVTW0aJ7xoA==
To: djwong@kernel.org, ebiggers@kernel.org, hch@lst.de,
 Carlos Maiolino <cem@kernel.org>
Date: Fri, 18 Sep 2026 13:15:26 +0200
Message-ID: <20260918111539.1003439-15-aalbersh@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260918111539.1003439-1-aalbersh@kernel.org>
References: <20260918111539.1003439-1-aalbersh@kernel.org>
MIME-Version: 1.0
X-Headers-End: 1x7Wa4-0007rh-TZ
Subject: [f2fs-dev] [PATCH v16 14/21] xfs: don't remove written extents past
 EOF on fsverity inodes
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

xfs_free_eofblocks() removes all extents past EOF unless the
XFS_DIFLAG_PREALLOC or XFS_DIFLAG_APPEND flags are set. This is
undesired for fsverity as it stores metadata beyond EOF. However, while
merkle tree is being built, delayed preallocation and unwritten extents
are used. After metadata construction is done, fsverity inodes becomes
read-only and won't be changed anymore, none of these unwritten extents
or preallocations in post EOF region will be used.

Let xfs_free_eofblocks() be called on fsverity inode as usual to remove
anything which is not written extent. However, inodes which are
undergoing merkle tree construction need to be skipped in case reclaim
takes place.

Signed-off-by: Andrey Albershteyn <aalbersh@kernel.org>
---
 fs/xfs/xfs_bmap_util.c | 25 ++++++++++++++++++++++---
 1 file changed, 22 insertions(+), 3 deletions(-)

diff --git a/fs/xfs/xfs_bmap_util.c b/fs/xfs/xfs_bmap_util.c
index 268d159339d0..7fd951992557 100644
--- a/fs/xfs/xfs_bmap_util.c
+++ b/fs/xfs/xfs_bmap_util.c
@@ -31,6 +31,7 @@
 #include "xfs_rtbitmap.h"
 #include "xfs_rtgroup.h"
 #include "xfs_zone_alloc.h"
+#include <linux/fsverity.h>
 
 /* Kernel only BMAP related definitions and functions */
 
@@ -553,6 +554,13 @@ xfs_can_free_eofblocks(
 	if (last_fsb <= end_fsb)
 		return false;
 
+	/*
+	 * Don't clean fsverity inodes which have merkle tree being built, the
+	 * merkle tree is written beyond EOF
+	 */
+	if (xfs_iflags_test(ip, XFS_VERITY_CONSTRUCTION))
+		return false;
+
 	/*
 	 * Check if there is an post-EOF extent to free.  If there are any
 	 * delalloc blocks attached to the inode (data fork delalloc
@@ -579,6 +587,9 @@ xfs_free_eofblocks(
 	struct xfs_trans	*tp;
 	struct xfs_mount	*mp = ip->i_mount;
 	int			error;
+	int			bmapi_flags = XFS_BMAPI_NODISCARD;
+	bool			has_verity =
+			ip->i_diflags2 & XFS_DIFLAG2_VERITY;
 
 	/* Attach the dquots to the inode up front. */
 	error = xfs_qm_dqattach(ip);
@@ -593,15 +604,20 @@ xfs_free_eofblocks(
 	 *
 	 * Note that this means we also leave speculative preallocations in
 	 * place for preallocated files.
+	 *
+	 * Clean up delalloc reservations for fsverity too as those won't be
+	 * used
 	 */
-	if (ip->i_diflags & (XFS_DIFLAG_PREALLOC | XFS_DIFLAG_APPEND)) {
+	if (ip->i_diflags & (XFS_DIFLAG_PREALLOC | XFS_DIFLAG_APPEND) ||
+			has_verity) {
 		if (ip->i_delayed_blks) {
 			xfs_bmap_punch_delalloc_range(ip, XFS_DATA_FORK,
 				round_up(XFS_ISIZE(ip), mp->m_sb.sb_blocksize),
 				LLONG_MAX, NULL);
 		}
 		xfs_inode_clear_eofblocks_tag(ip);
-		return 0;
+		if (!has_verity)
+			return 0;
 	}
 
 	error = xfs_trans_alloc(mp, &M_RES(mp)->tr_itruncate, 0, 0, 0, &tp);
@@ -613,6 +629,9 @@ xfs_free_eofblocks(
 	xfs_ilock(ip, XFS_ILOCK_EXCL);
 	xfs_trans_ijoin(tp, ip, 0);
 
+	if (has_verity)
+		bmapi_flags |= XFS_BMAPI_UNWRITTEN;
+
 	/*
 	 * Do not update the on-disk file size.  If we update the on-disk file
 	 * size and then the system crashes before the contents of the file are
@@ -620,7 +639,7 @@ xfs_free_eofblocks(
 	 * bug).
 	 */
 	error = xfs_itruncate_extents_flags(&tp, ip, XFS_DATA_FORK,
-				XFS_ISIZE(ip), XFS_BMAPI_NODISCARD);
+				XFS_ISIZE(ip), bmapi_flags);
 	if (error)
 		goto err_cancel;
 
-- 
2.54.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
