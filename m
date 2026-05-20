Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92A3FCD4F54
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 20 May 2026 12:38:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-ID:Date:To:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=I3JRDK9adAE1n0qMhlOIKXqMKlLLS0pI/9InoaTXN3E=; b=mKM1v3+x0GeBItMiLUzI0yVz8T
	2p4WXTszt/28CBu3ZaFb/1UbQpj4Ir4iqTBs7uHbCdkn+8ysL6zWRmLLAt0K3xqLEFWKg4MGfwca+
	UBZICv8lG7T5Zx1k6gydEhUKcIQCmYCgiwe3OSoz5vX1RXg6FTirj4pBxqlUJFiOtoRM=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wPgBu-00073R-Nf;
	Wed, 20 May 2026 12:38:24 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <aalbersh@kernel.org>) id 1wPgBt-00073B-2k
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 20 May 2026 12:38:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=qCCHYwxJZa/5SOjD2WmE7I8ycEVOggZ75oMnnZ58Shk=; b=jkj7yOlNyQZpB1dQhAC8IxeAA1
 cUbmL6AMeXvbF+jyWfA0LMBEHBTGekcEXa08qYZO74pcJeLGeESS1QCwm38RBobm1uYZ6Ya7jv3tK
 fz7pkboG3IVmUb3SRy/E7D4RbjcXh8leMJJjh28IOiPauvIFeHSUGmKnZb9Nz4UW91Oc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=qCCHYwxJZa/5SOjD2WmE7I8ycEVOggZ75oMnnZ58Shk=; b=T3BPqgTzfaQpMPWLXI4usYc1OZ
 T0r9rn/RYxBLpDVdIju5u9XO5+t/kOPfEuplyWcE4hj0cLAFkAxJYvJtB1fF2xgy1ga3n+wfXg9sp
 EQ7bPi9BlFMWRVBfo4WCB42SkVtYCFWeqeRYetdq5lbInZ208vXfGWRVKDA2uF5/eh9k=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wPgBo-0006cd-Fj for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 20 May 2026 12:38:22 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 6611F60212;
 Wed, 20 May 2026 12:38:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A0EE1F00894;
 Wed, 20 May 2026 12:38:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1779280690;
 bh=qCCHYwxJZa/5SOjD2WmE7I8ycEVOggZ75oMnnZ58Shk=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=S5jZ1m7AluCpwY1SkZ2skQlpneuIK+O/lzRac9DyBHEcoZXLl8F7fUE9bx5P0yJ6N
 npf0XdVLX0tAcKnSh5vX6LPyhDS3VAIxIvEmKJqmvRYEqKHamRI0dVNRL50uvG9vBQ
 IqdEDY1rLF2lIgVEspWBRWWcL/6IVstYXuse+QBPxmxgFxMGc0tffeuUpWsgDcp2VL
 ek9vvRqPaksSlRWHtYpUz+Pc+KPx6qbicQB8Eb7vrV0lDszzKBXzNps1HFSaOrzXjc
 o04U5AEU5cnHGHwo2g1NzHH6go3y52npR3tGJz3qKcwIM6/Lvosa88dzI1uo4z5AU/
 /pAfhi/aq4H0A==
To: linux-xfs@vger.kernel.org, fsverity@lists.linux.dev,
 linux-fsdevel@vger.kernel.org, ebiggers@kernel.org
Date: Wed, 20 May 2026 14:37:15 +0200
Message-ID: <20260520123722.405752-18-aalbersh@kernel.org>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20260520123722.405752-1-aalbersh@kernel.org>
References: <20260520123722.405752-1-aalbersh@kernel.org>
MIME-Version: 1.0
X-Headers-End: 1wPgBo-0006cd-Fj
Subject: [f2fs-dev] [PATCH v10 17/22] xfs: remove unwritten extents after
 preallocations in fsverity metadata
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
 linux-unionfs@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-ext4@vger.kernel.org, hch@lst.de, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

XFS preallocates spaces during writes. In normal I/O this space, if
unused, is removed by truncate. For files with fsverity XFS does not use
truncate as fsverity metadata is stored past EOF.

After we're done with writing fsverity metadata iterate over extents in
that region and remove any unwritten ones. These would be left overs in
the holes in the merkle tree and past fsverity descriptor.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Signed-off-by: Andrey Albershteyn <aalbersh@kernel.org>
---
 fs/xfs/xfs_fsverity.c | 69 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 69 insertions(+)

diff --git a/fs/xfs/xfs_fsverity.c b/fs/xfs/xfs_fsverity.c
index a06885291412..298d712b5ba2 100644
--- a/fs/xfs/xfs_fsverity.c
+++ b/fs/xfs/xfs_fsverity.c
@@ -21,6 +21,8 @@
 #include "xfs_iomap.h"
 #include "xfs_error.h"
 #include "xfs_health.h"
+#include "xfs_bmap.h"
+#include "xfs_bmap_util.h"
 #include <linux/fsverity.h>
 #include <linux/iomap.h>
 #include <linux/pagemap.h>
@@ -171,6 +173,65 @@ xfs_fsverity_delete_metadata(
 	return error;
 }
 
+static int
+xfs_fsverity_cancel_unwritten(
+	struct xfs_inode	*ip,
+	loff_t			start,
+	loff_t			end)
+{
+	struct xfs_mount	*mp = ip->i_mount;
+	struct xfs_trans	*tp;
+	xfs_fileoff_t		offset_fsb = XFS_B_TO_FSB(mp, start);
+	xfs_fileoff_t		end_fsb = XFS_B_TO_FSB(mp, end);
+	struct xfs_bmbt_irec	imap;
+	int			nimaps;
+	int			error = 0;
+	int			done;
+
+
+	while (offset_fsb < end_fsb) {
+		nimaps = 1;
+
+		error = xfs_trans_alloc(mp, &M_RES(mp)->tr_write, 0, 0,
+				0, &tp);
+		if (error)
+			return error;
+
+		xfs_ilock(ip, XFS_ILOCK_EXCL);
+		error = xfs_bmapi_read(ip, offset_fsb, end_fsb - offset_fsb,
+				&imap, &nimaps, 0);
+		if (error)
+			goto out_cancel;
+
+		if (nimaps == 0)
+			goto out_cancel;
+
+		if (imap.br_state == XFS_EXT_UNWRITTEN) {
+			xfs_trans_ijoin(tp, ip, 0);
+
+			error = xfs_bunmapi(tp, ip, imap.br_startoff,
+					imap.br_blockcount, 0, 1, &done);
+			if (error)
+				goto out_cancel;
+
+			error = xfs_trans_commit(tp);
+			if (error)
+				return error;
+		} else {
+			xfs_trans_cancel(tp);
+		}
+		xfs_iunlock(ip, XFS_ILOCK_EXCL);
+
+		offset_fsb = imap.br_startoff + imap.br_blockcount;
+	}
+
+	return error;
+out_cancel:
+	xfs_trans_cancel(tp);
+	xfs_iunlock(ip, XFS_ILOCK_EXCL);
+	return error;
+}
+
 
 /*
  * Prepare to enable fsverity by clearing old metadata.
@@ -248,6 +309,14 @@ xfs_fsverity_end_enable(
 	if (error)
 		goto out;
 
+	/*
+	 * Remove unwritten extents left by COW preallocations and write
+	 * preallocation in the merkle tree holes and past descriptor
+	 */
+	error = xfs_fsverity_cancel_unwritten(ip, range_start, LLONG_MAX);
+	if (error)
+		goto out;
+
 	/*
 	 * Proactively drop any delayed allocations in COW fork, the fsverity
 	 * files are read-only
-- 
2.51.2



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
