Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCD1DC44524
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 20 Jul 2026 09:05:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-ID:Date:To:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=KRUHe6ttGhF0kA0ztAAcemiRDPlJIwGNvJKnCPmH0Vw=; b=C3jWnSpsoydc89oTolwSUdAuVc
	Th4cw+fOFruJ5FSdQE5O+Wc00Q79U/z1i0xSHMDsDzsJ1t4qvZ65687DFyg128EFborvMJCSX9Yhm
	34KYnF/BV9Sldx3MkfJResAhfIFAHx1uvUi3yjXdlIMhjwXhB0BDy/0Qsx3sIaI83ZoQ=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wljwV-0000MG-R2;
	Mon, 20 Jul 2026 09:05:44 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <aalbersh@kernel.org>) id 1wljwU-0000Lw-TX
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 20 Jul 2026 09:05:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=9QTcR6aLgUEtsJ2fn2Z4p7S4tu82w8VjwhNOU+8/DXE=; b=jS0JNH/tFxwswr8oxiVKcjaaGv
 aIp0QnpZAi7xC0Ke+Y81QLsDVa2b3BY3+GEb/ztJ36zaJYo2rfkK8PyVIhgBnjcJ4BGXcPadwVA91
 vY2N90WIITw224J07wPYqiDgQTTu2qFKlR4tSlF5MjCEeurxmyw2TWndylz/mktCy+pY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=9QTcR6aLgUEtsJ2fn2Z4p7S4tu82w8VjwhNOU+8/DXE=; b=RSCoNeWmMQSbG3osLKreNLtT8x
 n9c91mdFMNwS/gGgivKcTt7+sD1EAbZRs2kGtVSg5F4i0UpNiF5+5sa32Zm/Ah3Ksh+2C5xGj+xuq
 tIhqvr0w21zYu8EvzdFIAmOJggzwNkyp+ETrRE+2UXQxbOF7bNGb72COlMFcaeEXNsNg=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wljwU-000887-40 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 20 Jul 2026 09:05:43 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 0E5D343FF2;
 Mon, 20 Jul 2026 09:05:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8114D1F000E9;
 Mon, 20 Jul 2026 09:05:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784538341;
 bh=9QTcR6aLgUEtsJ2fn2Z4p7S4tu82w8VjwhNOU+8/DXE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=i5QOQBy4bo4w3OKQlYJKwiK5yblyNYd9hqNIPmFxRcDXI0zhxBVBkh/jL4k2Btl2j
 nKQd7+z+JHbGwm0Mw5PH0CmbIgihBzCAzm1IJA7p+N6kdqDYH3L5QNy0rSP/am02N7
 QD29x7ijzv4Yw3FwLzfmFnLGEJntA+50sEFiRpnSZUOMVYrifimVsemdtHKc02NkGr
 JkhPOcDUHBFPjxUdXv2tU5XsUjUt+jbSEKxkYcRnOVEBU0LPQRK8hpsfQ26xs2HMNc
 8qwFzXB0VLVMP711qB4BWjk1n5P1H3sQWainbeiSNaKRpWgFFzeYi1aOrNHRSqd6MQ
 G68iEEcrpgxwQ==
To: linux-xfs@vger.kernel.org, fsverity@lists.linux.dev,
 linux-fsdevel@vger.kernel.org, ebiggers@kernel.org
Date: Mon, 20 Jul 2026 11:03:44 +0200
Message-ID: <20260720090410.3487990-17-aalbersh@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260720090410.3487990-1-aalbersh@kernel.org>
References: <20260720090410.3487990-1-aalbersh@kernel.org>
MIME-Version: 1.0
X-Headers-End: 1wljwU-000887-40
Subject: [f2fs-dev] [PATCH v12 16/21] xfs: initialize fs-verity on file open
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
index f7e3fe22ca96..cba194d678fc 100644
--- a/fs/xfs/xfs_file.c
+++ b/fs/xfs/xfs_file.c
@@ -37,6 +37,7 @@
 #include <linux/fadvise.h>
 #include <linux/mount.h>
 #include <linux/filelock.h>
+#include <linux/fsverity.h>
 
 static const struct vm_operations_struct xfs_file_vm_ops;
 
@@ -1719,11 +1720,18 @@ xfs_file_open(
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
2.54.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
