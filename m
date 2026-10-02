Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98904CA5FE9
	for <linux-f2fs-devel@archiver.kernel.org>; Fri,  2 Oct 2026 22:38:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-ID:Date:To:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZdRl3wMF2i8ayGmjAaFUrt13Hfq7VrUCjJcgLnO/vmI=; b=k3DSsF4voZqZksl3/IZCwWbthf
	y1cwdmgZ6ZlDx6EVdBwZIShRQlXke5LzAaTZdhuRy3+B0h3+HQ13ah8IbjABbh64nwQ/DorMBTzTX
	IWR57LzSF6PmMuqxx7CUDKWQpQ/1YMMFSmzGfpMCDOIk4dRzKE9atyfQwqEvg1OAnTeA=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xClu1-0001kl-V0;
	Fri, 02 Oct 2026 22:38:53 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <aalbersh@kernel.org>) id 1xCltw-0001iU-8P
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 02 Oct 2026 22:38:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=9UsWTPXNPtGAnC/NXDW+DJPQrI7L9qVnDZTXWpl6xCI=; b=OvrmBBu30tXXoAkxWxGW0AlX7n
 lbB08Uh+bGTQfE4KDbuR9GylyKAJKDRhslJtPSa4F75chu+LEoMmkEs0zRWqL56krOoOmLb21ydS5
 xQ2PHPrSPVfwmXcL1lQH5r+pADDWSecdokng5Gy4m+Dk/15bGkrC9tfqatu11e5aJY5Q=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=9UsWTPXNPtGAnC/NXDW+DJPQrI7L9qVnDZTXWpl6xCI=; b=Qsyk4ivGu3vKpJCrJUXrWvsFhG
 pkHKZaSxbBFYNhDBRR6ZW4wZIsRCLJSXGazLM4BJIMHyGfgnDNwdCabxXJE3Xwu1zvG5gcKgY8XKB
 3qjZUX5yCY4+1c0z0SA4dZPg0FmdeArbEZ9FZ1zSvOHsdJy3V9pO9zHPYJl8OkPDr78M=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1xCltg-0003kq-5H for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 02 Oct 2026 22:38:32 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id D6E634481A;
 Fri,  2 Oct 2026 22:38:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2E791F00893;
 Fri,  2 Oct 2026 22:38:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790980706;
 bh=9UsWTPXNPtGAnC/NXDW+DJPQrI7L9qVnDZTXWpl6xCI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=CoJCQSqArVqS0yKPYrOGWg4qTKQn2ygVJn+7hmo/BCrCkxzJv5atgfDpFT8avQm/g
 DGNvxqqoAJIbU//Wy5j4qch4BUgGKmtRXU0VNSgOUaIV4SRlbYIUYkMZNbahH/jERW
 e+psjlv8/NZecBW5zWx8NndLCuoWlqGOLZYGxzt25FxphFT4uGvU6xx6eEmXbP99L3
 XYoFYFyPq42CpODG66a+MpnH0r2b1o85XXMEOUNG8strfFwdWMYibG5/4Y/SZoUn8i
 Xdz+3SXxSBQP0AnOw9jtq/I+0tVUH60SqmQUcUCoKEryplFze0e9wd1LSDkWWJ5W5J
 81YnHyO6PHvcA==
To: djwong@kernel.org, ebiggers@kernel.org, hch@lst.de,
 Carlos Maiolino <cem@kernel.org>
Date: Sat,  3 Oct 2026 00:37:02 +0200
Message-ID: <20261002223705.2175542-22-aalbersh@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261002223705.2175542-1-aalbersh@kernel.org>
References: <20261002223705.2175542-1-aalbersh@kernel.org>
MIME-Version: 1.0
X-Headers-End: 1xCltg-0003kq-5H
Subject: [f2fs-dev] [PATCH v17 21/21] xfs: enable ro-compat fs-verity flag
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

Finalize fs-verity integration in XFS by making kernel fs-verity
aware with ro-compat flag.

Reviewed-by: Darrick J. Wong <djwong@kernel.org>
[djwong: add spaces]
Signed-off-by: Darrick J. Wong <djwong@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Andrey Albershteyn <aalbersh@kernel.org>
---
 fs/xfs/libxfs/xfs_format.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/xfs/libxfs/xfs_format.h b/fs/xfs/libxfs/xfs_format.h
index fc196d9e12dd..8be1b101b196 100644
--- a/fs/xfs/libxfs/xfs_format.h
+++ b/fs/xfs/libxfs/xfs_format.h
@@ -378,8 +378,9 @@ xfs_sb_has_compat_feature(
 #define XFS_SB_FEAT_RO_COMPAT_ALL \
 		(XFS_SB_FEAT_RO_COMPAT_FINOBT | \
 		 XFS_SB_FEAT_RO_COMPAT_RMAPBT | \
-		 XFS_SB_FEAT_RO_COMPAT_REFLINK| \
-		 XFS_SB_FEAT_RO_COMPAT_INOBTCNT)
+		 XFS_SB_FEAT_RO_COMPAT_REFLINK | \
+		 XFS_SB_FEAT_RO_COMPAT_INOBTCNT | \
+		 XFS_SB_FEAT_RO_COMPAT_VERITY)
 #define XFS_SB_FEAT_RO_COMPAT_UNKNOWN	~XFS_SB_FEAT_RO_COMPAT_ALL
 static inline bool
 xfs_sb_has_ro_compat_feature(
-- 
2.54.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
