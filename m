Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6C62CA5FE6
	for <linux-f2fs-devel@archiver.kernel.org>; Fri,  2 Oct 2026 22:38:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-ID:Date:To:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PxjX6/W7nmN7mWPluvd10liTWDglaH95UKtCq3ulC78=; b=B2xHdS0GKmKIO+p+FL4vXREkFf
	FMFhTDjQ5DYyrmNhQI0L4/7BMY4G8CJs9kPvacSFrwZWqPpULg53L2/V+LeiuNuMVUU68hMunefmJ
	Ym+7LbzSEt68jB1grFyaaQDPdDzgb+2+6gDHkWPMCcRKkbQk7zZZPS1d/TBoDkrsF70k=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xCltJ-0001g9-F7;
	Fri, 02 Oct 2026 22:38:09 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <aalbersh@kernel.org>) id 1xCltI-0001fy-EW
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 02 Oct 2026 22:38:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=xCYk0Gq6TJerMCtpjc/Alie0O8U64/7WPSND7e9qc2o=; b=I+50qBNhzHmBvJU4wO97Vud6SR
 0tx8+bdjznCTEdcqKBICABnT9oZ6AwCxZE0MY/7/8PKSCE+5tQ6NYdOn3KUwlKvra/1KX2HNGo57J
 Zkl2lD6mo7bbkcH9wOlEtsUBASi5pLXYhiEYa1+wGbylYv+74YjezoMlpkjYycBw9lI0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=xCYk0Gq6TJerMCtpjc/Alie0O8U64/7WPSND7e9qc2o=; b=bXuHrE8qK1otThteWQnkuUd6q6
 7P83tH9ry0taTeQ/HuweOwtBUOfAPepVEV9S5d5XMDHjMofjIaSuIeFe1azuxlOSPFeYolT2QPac1
 WTRaZqot65QH920xFVl9qgccOETYjhaR2om+TX8k/+qgoP7xXtk5ffYDWf+KT1fYKu4M=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1xCltH-0006bf-Sj for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 02 Oct 2026 22:38:08 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 4D59D60D82;
 Fri,  2 Oct 2026 22:38:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 094F71F000FF;
 Fri,  2 Oct 2026 22:37:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790980682;
 bh=xCYk0Gq6TJerMCtpjc/Alie0O8U64/7WPSND7e9qc2o=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=Nrpfpa71CSPmqBRx81HpMBjNKeXWnwvFTlU0cnTd0ZMl89Ysvgnw8hio9TsVPYUGC
 NnK2JUH8qruaOmXIFYHZ8afRmuLLG1wxC2PA+2iK+kc6Mx6+swNA966eDwu2xxfOVw
 VNK1ed/+qOdxLGHrC2MEGwOpglCMZQ5TL9jnPEFTGg3peZcB+zDSybxWE6YB6fC4oM
 gNhMBmz464TJKEjCZqjXgDg8RH+W53UX8Z8yH48BZoQrajXDS8osA3/tU2p2FJsxga
 +rCjavTFEULegNei+FmxslOeVwiRuvIngIoIjYxndJ3L0B1U+1CMRX1sKTe9c8tk4X
 cMVymZseBBr4A==
To: djwong@kernel.org, ebiggers@kernel.org, hch@lst.de,
 Carlos Maiolino <cem@kernel.org>
Date: Sat,  3 Oct 2026 00:36:55 +0200
Message-ID: <20261002223705.2175542-15-aalbersh@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261002223705.2175542-1-aalbersh@kernel.org>
References: <20261002223705.2175542-1-aalbersh@kernel.org>
MIME-Version: 1.0
X-Headers-End: 1xCltH-0006bf-Sj
Subject: [f2fs-dev] [PATCH v17 14/21] xfs: don't remove written extents past
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
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/xfs/xfs_bmap_util.c | 31 ++++++++++++++++++++++++++++---
 1 file changed, 28 insertions(+), 3 deletions(-)

diff --git a/fs/xfs/xfs_bmap_util.c b/fs/xfs/xfs_bmap_util.c
index 268d159339d0..74e99d0bee7a 100644
--- a/fs/xfs/xfs_bmap_util.c
+++ b/fs/xfs/xfs_bmap_util.c
@@ -31,6 +31,7 @@
 #include "xfs_rtbitmap.h"
 #include "xfs_rtgroup.h"
 #include "xfs_zone_alloc.h"
+#include <linux/fsverity.h>
 
 /* Kernel only BMAP related definitions and functions */
 
@@ -553,6 +554,15 @@ xfs_can_free_eofblocks(
 	if (last_fsb <= end_fsb)
 		return false;
 
+	/*
+	 * Don't clean fsverity inodes as they already have been cleaned up and
+	 * are read-only. Skip inodes which have merkle tree being built, the
+	 * merkle tree is written beyond EOF
+	 */
+	if (fsverity_active(VFS_IC(ip)) ||
+	    xfs_iflags_test(ip, XFS_VERITY_CONSTRUCTION))
+		return false;
+
 	/*
 	 * Check if there is an post-EOF extent to free.  If there are any
 	 * delalloc blocks attached to the inode (data fork delalloc
@@ -579,6 +589,9 @@ xfs_free_eofblocks(
 	struct xfs_trans	*tp;
 	struct xfs_mount	*mp = ip->i_mount;
 	int			error;
+	int			bmapi_flags = XFS_BMAPI_NODISCARD;
+	bool			has_verity =
+			ip->i_diflags2 & XFS_DIFLAG2_VERITY;
 
 	/* Attach the dquots to the inode up front. */
 	error = xfs_qm_dqattach(ip);
@@ -593,15 +606,20 @@ xfs_free_eofblocks(
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
@@ -613,6 +631,13 @@ xfs_free_eofblocks(
 	xfs_ilock(ip, XFS_ILOCK_EXCL);
 	xfs_trans_ijoin(tp, ip, 0);
 
+	/*
+	 * While fs-verity writes metadata after EOF, it can leave unwritten
+	 * preallocations.  Clear all that out.
+	 */
+	if (has_verity)
+		bmapi_flags |= XFS_BMAPI_UNWRITTEN;
+
 	/*
 	 * Do not update the on-disk file size.  If we update the on-disk file
 	 * size and then the system crashes before the contents of the file are
@@ -620,7 +645,7 @@ xfs_free_eofblocks(
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
