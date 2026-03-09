Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BE63FCA181
	for <linux-f2fs-devel@archiver.kernel.org>; Mon,  9 Mar 2026 19:25:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-ID:Date:To:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ixLuoDCFjxW+cw3KSqL4HRr+iF5qK80FSDhEATyE8RQ=; b=N/BTSrpxxQ7QYLczezFTr8ZILl
	wy/bL9245x+ah+5AA3joNNjOfTZs6r0n9DXT0DAZY9T5WbNy2vpQc6if/oXpaoUhuNO/TuCouU2wW
	wStGkZ8infeW2ftUmKC6KlhZUSZR/xLNXngD/Wf458jT74SnwLBen20B9K/rpa2jffOc=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1vzgER-0008D1-S8;
	Mon, 09 Mar 2026 19:25:35 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <aalbersh@kernel.org>) id 1vzgE6-0008AL-IN
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 09 Mar 2026 19:25:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ExMhA3H6ziSNMhG1qoslhWKRPShq1nQ3bDI4MmsgHok=; b=Q7Sv4rniSaoifPwO8MNIeLbJYb
 +UHD7xK9eNSgSvLsOHYoTWQNG5jQjQnOESdj1YejdTRAfHvqzzaJgInUdAlUChFxj2pDCImyjcebX
 hjWgduhWjbrm6krD2WKCd1QeNX0O9lOP6ZSdqTRzPPja9O5wDbKldA2m5Ml8HcPr8tiU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=ExMhA3H6ziSNMhG1qoslhWKRPShq1nQ3bDI4MmsgHok=; b=VGlml50+DAhzdbqY9ZVzW7YB42
 ZnuRBLfga4s7XWWJXwYBhhgIG31ZbEFSNWm1+O2WsMsamo+1NyLmRDSDbVOiNpicB/VVOqxHTFjXr
 fKj0aBFQXsGwMSDyQF0JALAUJzS1uW8gSWQN4ZGPp1zGvCVlSy1eSLa1VeO0xzHJG06A=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1vzgDx-0001Gf-2i for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 09 Mar 2026 19:25:05 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id A3CE743329;
 Mon,  9 Mar 2026 19:24:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AC78C4CEF7;
 Mon,  9 Mar 2026 19:24:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1773084294;
 bh=mPVHTe9Ab/5USFw8EX0zjFajZsuuSbaTg0zG8xac2aQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=pqMQpCfNaVdvzzzpIP2DjrTS/ZYgyv17WBIAofC2mluK9x7PojwIAkcwUCDorbStG
 cKDa4XcHWWlLpAppZsausDrJ7XzMgqvPwaUuIjM79XYywjNK32FAifnr0vp8nk4+2F
 Nc63s20tWE1ALdyokpYpgrlR/VrWbPdFC3nChVeTttukJHoTeyp0gN6JpBrjJYfUSk
 ZdCDvWwYdbzR9Dqo3QOqP1Oi7ZLOdOhSbGM5JG1SQTEabt4lnJwreVeeQqtbIw9y/c
 hRULBLGqzjK5ig6Zb6b1Oy+9m9eyEjx8HgS3vlg5ajicMrAr/u138wDv5oG/D+QUpZ
 Pc5W0BCuC8kcQ==
To: linux-xfs@vger.kernel.org, fsverity@lists.linux.dev,
 linux-fsdevel@vger.kernel.org, ebiggers@kernel.org
Date: Mon,  9 Mar 2026 20:23:28 +0100
Message-ID: <20260309192355.176980-14-aalbersh@kernel.org>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20260309192355.176980-1-aalbersh@kernel.org>
References: <20260309192355.176980-1-aalbersh@kernel.org>
MIME-Version: 1.0
X-Headers-End: 1vzgDx-0001Gf-2i
Subject: [f2fs-dev] [PATCH v4 13/25] xfs: initialize fs-verity on file open
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

fs-verity will read and attach metadata (not the tree itself) from
a disk for those inodes which already have fs-verity enabled.

Signed-off-by: Andrey Albershteyn <aalbersh@kernel.org>
Signed-off-by: Darrick J. Wong <djwong@kernel.org>
---
 fs/xfs/xfs_file.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
index 6246f34df9fd..a980ac5196a8 100644
--- a/fs/xfs/xfs_file.c
+++ b/fs/xfs/xfs_file.c
@@ -37,6 +37,7 @@
 #include <linux/fadvise.h>
 #include <linux/mount.h>
 #include <linux/filelock.h>
+#include <linux/fsverity.h>
 
 static const struct vm_operations_struct xfs_file_vm_ops;
 
@@ -1640,11 +1641,18 @@ xfs_file_open(
 	struct inode	*inode,
 	struct file	*file)
 {
+	int		error;
+
 	if (xfs_is_shutdown(XFS_M(inode->i_sb)))
 		return -EIO;
 	file->f_mode |= FMODE_NOWAIT | FMODE_CAN_ODIRECT;
 	if (xfs_get_atomic_write_min(XFS_I(inode)) > 0)
 		file->f_mode |= FMODE_CAN_ATOMIC_WRITE;
+
+	error = fsverity_file_open(inode, file);
+	if (error)
+		return error;
+
 	return generic_file_open(inode, file);
 }
 
-- 
2.51.2



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
