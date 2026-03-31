Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD54210F9302
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 31 Mar 2026 21:29:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-ID:Date:To:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BZhuAcWHhtHA+Vzki5MZQWIRDHLfPvZaAdnZDTC8uKk=; b=QnjGrCpAB2+04b2L54m7n+oAfk
	3L+q2VnK465eMChwFbwEVYjgqd/86lW95gbk52C4iTzAzIW2MiTnIHk3A4/fdHTKOMAuk5j7HMlAP
	2T5mIG3mRsiXosos19lx9ov5cGuDNrmbfuTieP4p7XGn8zTEIfeAAgscid+gWpsl+584=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1w7geV-0006fB-9k;
	Tue, 31 Mar 2026 21:29:35 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <aalbersh@kernel.org>) id 1w7geU-0006eu-1z
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 31 Mar 2026 21:29:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=6/zmzAwIjMl/Fnz1FPbsiMuz9q1YHlUZQcYgfS6PpbE=; b=AAlNPW1vL0b83cL5zH59cTna9M
 SmJttHhKMLOXHB3ZqVsjbBKtL0zSqkXYWSA1cOKg9E4GA7E221XWA6S1x5eens3HQEkU2mDGTOMzk
 A+zvVw6kIIJtxhQqSPFpdmXf/E1HbkND4J0Kdqp3FnILY0/EC8iGJTXYlBHONQSeJ3+k=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=6/zmzAwIjMl/Fnz1FPbsiMuz9q1YHlUZQcYgfS6PpbE=; b=jZiD+ZKJf78V1FuDiglISIOFuD
 pRJUi2d2ADhUZfkcXpxzM7ws+Ge8DUK2OzbBBpyz/Ccszea4o+XWV56XK0Gi61Dh1W3aXjxduKsQz
 JYRJlsEWTu1wYJ0ZGEAD9EqU/aUyK/JiEF7/oRiZtUZyi/MJWYZTOgOIroZWO+5LG310=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1w7geT-00077U-GS for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 31 Mar 2026 21:29:33 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 37A7943C2F;
 Tue, 31 Mar 2026 21:29:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A58F8C19423;
 Tue, 31 Mar 2026 21:29:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1774992563;
 bh=iOgFntkagcHnJzdVdNQ9ZYUIxxE/XWG3vo8zPAmv77U=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=ZDpzJfJj5OwM7uL6NistKiIgD+erSMLlCyY0qsotS7Q4rvj48xZ3c0JDt0+yL56N8
 T0s9cF5A7Pfjg+hZXguUXhhu1UFSoUQZkqwjr/YnQNCTeavmQVOh7pt2bio01MM3qr
 CisQck7Ss3qNKevQFR66K4NFhy+mvPkfB/OT+1PV+Jt293pgoS/b5TG7TYljhj6DS2
 4vJwBBLJ8UYZEtfIW8OIWUEJqYkKSvdX7FQM1F3WCOWA/cB/gREilPIYIKK4Th46kX
 grFPUkdopeYDnPgoSovC1o8LxyagBYIKq1vKn8hVZKjmz8SGZVxJnEB/SJ/IGt55gu
 EjfQ3v2DoZAAQ==
To: linux-xfs@vger.kernel.org, fsverity@lists.linux.dev,
 linux-fsdevel@vger.kernel.org, ebiggers@kernel.org
Date: Tue, 31 Mar 2026 23:28:17 +0200
Message-ID: <20260331212827.2631020-17-aalbersh@kernel.org>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20260331212827.2631020-1-aalbersh@kernel.org>
References: <20260331212827.2631020-1-aalbersh@kernel.org>
MIME-Version: 1.0
X-Headers-End: 1w7geT-00077U-GS
Subject: [f2fs-dev] [PATCH v6 16/22] xfs: remove unwritten extents after
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
 linux-f2fs-devel@lists.sourceforge.net, linux-ext4@vger.kernel.org, hch@lst.de,
 linux-btrfs@vger.kernel.org
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
Signed-off-by: Andrey Albershteyn <aalbersh@kernel.org>
---
 fs/xfs/xfs_fsverity.c | 67 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 67 insertions(+)

diff --git a/fs/xfs/xfs_fsverity.c b/fs/xfs/xfs_fsverity.c
index 5a6a48fcf843..b193009a1bdb 100644
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
@@ -173,6 +175,63 @@ xfs_fsverity_delete_metadata(
 	return error;
 }
 
+static int
+xfs_fsverity_cancel_unwritten(
+	struct xfs_inode	*ip,
+	xfs_fileoff_t		start,
+	xfs_fileoff_t		end)
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
@@ -248,6 +307,14 @@ xfs_fsverity_end_enable(
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
