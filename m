Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6538C982DC
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 18 Sep 2026 11:16:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-ID:Date:To:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vTq6Al25CFNy3ZczWehBf8uUMakR7daoGQ4h1Y2Lzvw=; b=TSMJbFBnf+LiJrmYMrDbfHfGY3
	Juh21bQ+6bpXtIKPYNmfDOMlFEU8zAxkSAFETAc6CWzYi5dYsi1QGOTMIe08y0ST7JB0eemibKye4
	zFWDbe75YaBcFqL/HTpAWRCCgtevMHdFw8xlG4K5aozbl/9iwCfRK/iu1hE8Nqu49lNE=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1x7WaJ-0003sj-I0;
	Fri, 18 Sep 2026 11:16:52 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <aalbersh@kernel.org>) id 1x7WaH-0003sT-NV
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 18 Sep 2026 11:16:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=lfg52zb8DlfflgPU8kvIwpmUoI7GKK53PRBf16ii4Ys=; b=SnBJNuWvxNP90TXHgUEBy8acTQ
 YjvITXt1W5xmBsf1Yn+Kpm+pPyyld3NsJ08Sgx2lKUQytbg9orG7jXDr6Lwe824bK4moAbH22Xvm1
 eXjBgsPwwVxdoncbuVekE99BB3BIgsJ5W4ubw100voz1VD5Xt/m+1PAzwN/vNAatikZA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=lfg52zb8DlfflgPU8kvIwpmUoI7GKK53PRBf16ii4Ys=; b=R26UmhbFrFM9QLkt7TD9yKRlUH
 CHnMi/uw6A4yW/9ichRP3zdUo1eHyf+z7F8TWsTrXpTC71FWH7cbvVLXaInUSIvWLRf6RMIS39DKf
 TJZ1DA6dP+zIapUwV3B4dN9UZlTMx5KsTkX1JTMQnviLoUpOyrxqAYWZAT5kRq1vV4bM=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1x7WaG-0007sz-Ut for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 18 Sep 2026 11:16:50 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id A5FFF447BB;
 Fri, 18 Sep 2026 11:16:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 827D01F00893;
 Fri, 18 Sep 2026 11:16:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789730203;
 bh=lfg52zb8DlfflgPU8kvIwpmUoI7GKK53PRBf16ii4Ys=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=dKI6hYkYwVhRj+nacZenOqaeyKlFxrRNlKib+x4xTHPnj6IDM9SnYRBCylb76yWyA
 uDNr6BQPR75xrv3cwPqUhNvTwjs6Yl5rhwn+yEewl46epRLsuFLzB1mq20/kpZwMmS
 +c2kz+yA9GOCkNGSJ+rn0DDKV9PA/qvBWpjJzhfRXx7qRS3ByqQiZJQbltKviOkB9G
 6m/l2p/8MQL/14FJ+6RArTw7CNTOhMIaNUgykHuNY/nCpSp+tdvesKLCf+V0PiRSP2
 vECTD1WWGIcduJBKv180U+cxwlhD9EIKeAUFeItZC7ZP4IdkBSWOt05OYXqSG2vjgv
 h+XeNmLydZa2A==
To: djwong@kernel.org, ebiggers@kernel.org, hch@lst.de,
 Carlos Maiolino <cem@kernel.org>
Date: Fri, 18 Sep 2026 13:15:28 +0200
Message-ID: <20260918111539.1003439-17-aalbersh@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260918111539.1003439-1-aalbersh@kernel.org>
References: <20260918111539.1003439-1-aalbersh@kernel.org>
MIME-Version: 1.0
X-Headers-End: 1x7WaG-0007sz-Ut
Subject: [f2fs-dev] [PATCH v16 16/21] xfs: initialize fs-verity on file open
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

fs-verity will read and attach metadata (not the tree itself) from
a disk for those inodes which already have fs-verity enabled.

Signed-off-by: Darrick J. Wong <djwong@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Andrey Albershteyn <aalbersh@kernel.org>
---
 fs/xfs/xfs_file.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
index 578ca6fb8292..e13390539f04 100644
--- a/fs/xfs/xfs_file.c
+++ b/fs/xfs/xfs_file.c
@@ -1794,11 +1794,18 @@ xfs_file_open(
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
