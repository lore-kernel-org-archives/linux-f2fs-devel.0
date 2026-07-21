Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86D3CC44536
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 21 Jul 2026 18:45:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-ID:Date:To:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=n+ADsHcGYx6HLSlK3cHvNO09RuaZCrj1PxnWep2XA1U=; b=D704TLBi7NIDRw+XOSrEOfC3IN
	212tFCgHahLUdFRP8AFVph5hiPw7MkKljabed187fdE3ejf83VsvL2hTLiS7ywYiXlPFgdfbqc7mt
	kmm0LwiR6b8gJfLUQaNhHmFqnjT/4vE3EIXyfsuW9l5JP54EsCbpV1fFUuYUIaRKhDjM=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wmFSq-0002R8-O7;
	Tue, 21 Jul 2026 18:45:12 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <aalbersh@kernel.org>) id 1wmFSg-0002OP-36
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 21 Jul 2026 18:45:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=IwUo6t+cqdumeWexc/kPGLChnWY3Nr/38ljrnlrlNdc=; b=b84UttplcREt2hodeyx+8No8gS
 mJu7Kn6ZRclx94JSdJsFGlWeqV8RPPsLDQl/1eerhrR6NvreOfrdpeMSx6AMjdTvDfAoSigg5imM+
 RSzbcCow/Wdj6bB1u+e1F3k+fhdLfT5PKdrxf5iFPY2N2/4Jcy28mGRK5Kdrv/L8bT7E=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=IwUo6t+cqdumeWexc/kPGLChnWY3Nr/38ljrnlrlNdc=; b=Zgo2nZmCoKe2hxN/t2u+2gUngy
 DgK5FjMwSaeZGvi33Ts+0Gzy2VMFzJ/KHuStj4xb4TE7d0sFmLc4Qw8Mo1lDgiCQ54xEgt5z7tdD7
 lKSZlgr/IAlGU+gxuJl7P/T6beOrezvU598/4DupJRrr6H37yftxP0ZdPYu+uKchpY9k=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wmFSa-00033b-5T for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 21 Jul 2026 18:44:57 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 952CD60A5A;
 Tue, 21 Jul 2026 18:44:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC1301F00A3A;
 Tue, 21 Jul 2026 18:44:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784659485;
 bh=IwUo6t+cqdumeWexc/kPGLChnWY3Nr/38ljrnlrlNdc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=m8vZ3bLb4tuscuGSKKsgbCo32u617Sc+X8UyxZU5RFDnZ8h0X7nmoktV4cQwoQS++
 2IaqEUtspkkZsy6eGrXSK0+xHUrE/RW75CUCkC5G5iERpML/VLn7yE5qF37vsVzbXs
 vbem5myY4m3vV4XDz9V21l1CLspvUwxGOHQfAwFnPsqt8xNgYcdJPhl6yRNiIwCBVn
 Ub0DFFpQzVotOGDOlRtqX3lmP9WAruS90SQTLhBzxlwGR73XSOiAQ0IsiPDZ0vS8CF
 H2ooBe2H1/FNthtYKzMRZU98zg9XG8GR54DLo1VpEl7rEWXQDj6l0OFHRvx9OIGAJH
 jyc5NnFHvdmMA==
To: linux-xfs@vger.kernel.org, fsverity@lists.linux.dev,
 linux-fsdevel@vger.kernel.org, ebiggers@kernel.org
Date: Tue, 21 Jul 2026 20:40:54 +0200
Message-ID: <20260721184346.416657-18-aalbersh@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260721184346.416657-1-aalbersh@kernel.org>
References: <20260721184346.416657-1-aalbersh@kernel.org>
MIME-Version: 1.0
X-Headers-End: 1wmFSa-00033b-5T
Subject: [f2fs-dev] [PATCH v13 17/23] xfs: remove unwritten extents after
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

Signed-off-by: Andrey Albershteyn <aalbersh@kernel.org>
---
 fs/xfs/xfs_fsverity.c | 79 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 79 insertions(+)

diff --git a/fs/xfs/xfs_fsverity.c b/fs/xfs/xfs_fsverity.c
index d3d4ba3edfc1..5dcbdf20e474 100644
--- a/fs/xfs/xfs_fsverity.c
+++ b/fs/xfs/xfs_fsverity.c
@@ -12,12 +12,15 @@
 #include "xfs_inode.h"
 #include "xfs_log_format.h"
 #include "xfs_trans.h"
+#include "xfs_defer.h"
 #include "xfs_trace.h"
 #include "xfs_quota.h"
 #include "xfs_fsverity.h"
 #include "xfs_iomap.h"
 #include "xfs_error.h"
 #include "xfs_health.h"
+#include "xfs_bmap.h"
+#include "xfs_bmap_util.h"
 #include <linux/fsverity.h>
 #include <linux/iomap.h>
 #include <linux/pagemap.h>
@@ -174,6 +177,74 @@ xfs_fsverity_delete_metadata(
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
+	xfs_fileoff_t		offset_fsb = XFS_B_TO_FSBT(mp, start);
+	xfs_fileoff_t		end_fsb = XFS_B_TO_FSB(mp, end);
+	struct xfs_bmbt_irec	imap;
+	int			nimaps;
+	int			error = 0;
+	int			done;
+
+	while (offset_fsb < end_fsb) {
+		nimaps = 1;
+
+		error = xfs_trans_alloc(mp, &M_RES(mp)->tr_write, 0, 0, 0, &tp);
+		if (error)
+			return error;
+
+		xfs_ilock(ip, XFS_ILOCK_EXCL);
+		error = xfs_bmapi_read(ip, offset_fsb,
+				end_fsb - offset_fsb, &imap, &nimaps,
+				0);
+		if (error)
+			goto out_cancel;
+
+		if (nimaps == 0)
+			goto out_cancel;
+
+		if (imap.br_state == XFS_EXT_UNWRITTEN) {
+			done = 0;
+
+			xfs_trans_ijoin(tp, ip, 0);
+
+			while (!done) {
+				error = xfs_bunmapi(tp, ip, imap.br_startoff,
+						imap.br_blockcount, 0, 1,
+						&done);
+				if (error)
+					goto out_cancel;
+
+				error = xfs_defer_finish(&tp);
+				if (error)
+					goto out_cancel;
+			}
+
+			error = xfs_trans_commit(tp);
+			if (error)
+				goto out_unlock;
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
+out_unlock:
+	xfs_iunlock(ip, XFS_ILOCK_EXCL);
+	return error;
+}
+
 
 /*
  * Prepare to enable fsverity by clearing old metadata.
@@ -257,6 +328,14 @@ xfs_fsverity_end_enable(
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
2.54.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
