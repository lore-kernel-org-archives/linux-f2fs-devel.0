Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA43510F9303
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 31 Mar 2026 21:29:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-ID:Date:To:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=x7S9vC+StBxkCYmB8Eq3ShvIenJrj6aIuYNDhApxLJc=; b=brREpZTYblefHLLNGHZX5+rWM1
	y5PvlluYBoiXD8dfEAuvA/t0QR6RK1pg54tLc3emqF1iGIesfZUF9tTuwHY1ppOJWGcPxPVGIJym4
	dd76oEukpWjZPmMoiKms5yuRa2o27VungkfMiSp4lw2ErbR75emcx5zSZnOM9r6WhKlM=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1w7ge8-0002RL-Ks;
	Tue, 31 Mar 2026 21:29:12 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <aalbersh@kernel.org>) id 1w7ge7-0002RE-5L
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 31 Mar 2026 21:29:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=w2uKcgganAhQg74Fuf+AS49Uko5xJTS2Pjh70DGjE0w=; b=kBWiAaRJytnZyH3EFYQSA1TOyM
 GbQvdvOciQ/iVhRg+aQb+wz+H3Me5rfIplw7t1ZFa7wmcdplfKYvmPUGVbeI9G1IpyK2tYEQhbGhn
 quVveqA0NSK4oBGT8RpzXR1d59ll0S5keHaqgUwxR49g5ig0nKZm72uWd1eCm2eEhTV8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=w2uKcgganAhQg74Fuf+AS49Uko5xJTS2Pjh70DGjE0w=; b=fWHFxs8Fi9xegkvzwS3p+N3xoW
 ZB8KaG+p4xI81p1mc9PDZaDihJaPISId0DJiwEAz9NnGeCktNsD6w3CMbs0dIEpSkRoaG/PPTfUZd
 DXeyVDVLVmwWQ8e8uYfOH1ImtbXRJO8uu5KZMnp3yJ4TOB+XuXaAHwQyHmv8OZH3KKtY=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1w7ge6-00075k-Pm for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 31 Mar 2026 21:29:11 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 7E47943E71;
 Tue, 31 Mar 2026 21:29:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAE5DC19423;
 Tue, 31 Mar 2026 21:29:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1774992545;
 bh=gjzi4j4Cju/ktgfw/m2kII6LXPtWjZKRFOLxEgok6kg=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=QTw+M6nhWB3vooD1fcAu4VAynFJKvX/lcxMtlPgAYuA1ubd7rp2fErvuNVkpkoGBZ
 rN9Vgk7D01EITyvtAGWBSoavsR5jS/klg6FTpXuuWAwKWFxaK5RoayrjBeu7NeMLNE
 62A81u4f+vN3xi0ZgQhJPzctyuK8sqp5gAvqsFWYTa1i2YVZ2na/K0kTp0rV4PR4JO
 rGWbX9MMxVEuwulsF8nL6WQRQfq2//xU1y7HLpXoQEYddWdGDZvkIrsiKFVF5DKcSL
 lKlE+oRLSj329Nzit5pPfTrTwVXC9OQN7S3aJy4Or3LHGF4PsptB2pnA4CKiR4c0XG
 /86rt0FwuCcDg==
To: linux-xfs@vger.kernel.org, fsverity@lists.linux.dev,
 linux-fsdevel@vger.kernel.org, ebiggers@kernel.org
Date: Tue, 31 Mar 2026 23:28:11 +0200
Message-ID: <20260331212827.2631020-11-aalbersh@kernel.org>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20260331212827.2631020-1-aalbersh@kernel.org>
References: <20260331212827.2631020-1-aalbersh@kernel.org>
MIME-Version: 1.0
X-Headers-End: 1w7ge6-00075k-Pm
Subject: [f2fs-dev] [PATCH v6 10/22] xfs: initialize fs-verity on file open
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

Signed-off-by: Darrick J. Wong <djwong@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Andrey Albershteyn <aalbersh@kernel.org>
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
