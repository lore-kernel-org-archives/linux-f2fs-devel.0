Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9332C44524
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 20 Jul 2026 09:06:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-ID:Date:To:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6cJ7hViq4AYV7PH5EcnBQFXtjlUDgem+4ifjdDYevN4=; b=FP3xScJmjS0H1EAAYxoO3uXkxb
	S9NAIDDVm+GqaNPWHaKNJoTiUkbD4pDaie+1e7eqhA/AbWANZO0tjq/x8wLa5PMtqWsqxW77dSNd2
	Q5Py7Suj3Vf0e4LCiSJqjF8U0r7eSxUK2EJeV0hBKxjindQPXkT3dQdEBPfBjE8avMZE=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wljx8-0000U3-IK;
	Mon, 20 Jul 2026 09:06:23 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <aalbersh@kernel.org>) id 1wljwu-0000Rd-Ou
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 20 Jul 2026 09:06:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=+47nVRLEZQw/YviSfUoLbkFDroVKuX0Z4+TWL8l7VFE=; b=Z5tybmcgM6Ralf2nsf+/TwVLE7
 E/s3emg3DPAJ8zpH8RnY1s2x7Mmb4dBUbbdXpZ10qccQ6bHTqDeRu06pPvPb4lHfJmlBQHKppr5TK
 4G0Eb1sR8nqD1TtxbH4ZKpbM9i9fvj0JqEOSFpKAvNvFlxM+AiwoyHwM/wty06sIwDM8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=+47nVRLEZQw/YviSfUoLbkFDroVKuX0Z4+TWL8l7VFE=; b=W+/yg1W1ArloYHu2QVLHzoX6oR
 AQIzexVQy0OHbo2ZYbmDZ/s2T9D4kBy+1a6KAbHFPa8cj9H0KSuzq8+mNJQsyHNQnVUfPjai8Z+Gx
 pXK3npYWScmQH8VcfUmTT8zu/+JBzC9m+QhQ0yBPg0MWV988wTkTlG1c/2lQRW7/jlm0=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wljwo-0008Az-TY for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 20 Jul 2026 09:06:05 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 975BF4387F;
 Mon, 20 Jul 2026 09:05:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16D701F000E9;
 Mon, 20 Jul 2026 09:05:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784538357;
 bh=+47nVRLEZQw/YviSfUoLbkFDroVKuX0Z4+TWL8l7VFE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=djz3AyRlLkB4EkzF9XWbuuDmZe4Vyk4m9uHeptIXgIMMQDolgQXMzFDrwrVOvNuCD
 0ePpAYkqAfTuh4rjVA7tgpC1Aq2nPtxte0FPnLjE3yRxyxW4uBDwA/+PrDFi0jQo2J
 QlUNV/fstm94CtFNZHncpUfU0mFEPumgaj0xQ6upXL1qrNj4u0iDEujohhGxo0SPO2
 27pDk680D1ldc5hbBPLeE4PM45qQpEgVxNtGH++yAXVOa8BJwNUNmleu2VAu1A7MVZ
 /iUNh2cCa5AmVBILtt+zIYtrCrMTRUJLYI1198U/WpO3T1ZITzNgi7/Vi8NU7GjZLA
 TNYl1NDqbW5NQ==
To: linux-xfs@vger.kernel.org, fsverity@lists.linux.dev,
 linux-fsdevel@vger.kernel.org, ebiggers@kernel.org
Date: Mon, 20 Jul 2026 11:03:49 +0200
Message-ID: <20260720090410.3487990-22-aalbersh@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260720090410.3487990-1-aalbersh@kernel.org>
References: <20260720090410.3487990-1-aalbersh@kernel.org>
MIME-Version: 1.0
X-Headers-End: 1wljwo-0008Az-TY
Subject: [f2fs-dev] [PATCH v12 21/21] xfs: enable ro-compat fs-verity flag
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
index 7b0511eb03d0..2878bc9cb656 100644
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
