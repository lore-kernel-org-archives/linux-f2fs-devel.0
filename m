Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3E64C43458
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 10 Jul 2026 08:54:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-ID:Date:To:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6cJ7hViq4AYV7PH5EcnBQFXtjlUDgem+4ifjdDYevN4=; b=Y0jDh3Q8S0c29/FdUBdjmiB0on
	d87GDagzc7iSr+nEPqdSFG8SrRDb0lZIYkEAV1aFdG5UPszmOUXeF8/UimSSQhrB8jG+EvM28sImG
	XOkwD0WfU9/9W1GsFc/rkNF1vD4Aa0ydnnjXOBEB6xtMW6uZM/lu3T7TbXx3Ge6I4RrM=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wi70C-0007Qi-2V;
	Fri, 10 Jul 2026 08:54:32 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <aalbersh@kernel.org>) id 1wi709-0007QT-T9
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 10 Jul 2026 08:54:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=+47nVRLEZQw/YviSfUoLbkFDroVKuX0Z4+TWL8l7VFE=; b=e0G6LOAjXCnztgdAqTF+/byWH8
 Kq9tWnWtkxJBifJdF3ceSItpgtKxOpbi6LigezHdpmsx0ABgOfJisr0X6X2b3FuZMH7WM3I8KQMFs
 LeVldpwuIEe02R3UNXSAkQpMjuqvdGhtfXOxpUP9hNIYwFrZF8QBRFt4jD21wWaO1Y5c=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=+47nVRLEZQw/YviSfUoLbkFDroVKuX0Z4+TWL8l7VFE=; b=UNkaWy2guvbMFeJZjhL6LwEFnG
 5qukRItGi7yU/15dNcqeihTDtGdpx0xf1VBQS7ncLWUMR3yAFKp52YKdgFrqdnEVLH2DTFk2/APm4
 FhnFhnKt7IeHN2MbQnO1D97EN7ollEXMyO0rMrW232rWKuEch4mxC4ssZED0ekF81s40=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wi709-0007Zy-Cn for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 10 Jul 2026 08:54:29 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 2060F438E7;
 Fri, 10 Jul 2026 08:54:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FAE51F000E9;
 Fri, 10 Jul 2026 08:54:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783673664;
 bh=+47nVRLEZQw/YviSfUoLbkFDroVKuX0Z4+TWL8l7VFE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=nK5jpHF93VoaK0Uhid8ipouObrVpM3Q2pjZhykcHhSf2MYV9sb4ESGUt5y9VOFCM2
 qVPZu4gDfn9hDtEOIlOUYi5c6dPDEr0YBcEIUUH/MOTj6TCe2Cw+/CPnmoNs3Q1CSb
 wRH4z2Bb/gp0mTrCYRWq5HSd6gSz/EA3dY/w+Xza4pAHSaULDSEE1Jkcgc9KWVCE0+
 bNcdk2MBRjznD900Uc0NkbqXkQ5ueyk9/Xruv4yS0hXqkiy2iO14ivSsYzkrTv0NCf
 qM/EFM8QTepMQB8kNht45t0H0lVrevMdTMdhnALYs0D0Db+6eob+39c6tB+UIIs312
 2v9eWIU5BXJ1w==
To: linux-xfs@vger.kernel.org, fsverity@lists.linux.dev,
 linux-fsdevel@vger.kernel.org, ebiggers@kernel.org
Date: Fri, 10 Jul 2026 10:52:48 +0200
Message-ID: <20260710085256.3464201-21-aalbersh@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260710085256.3464201-1-aalbersh@kernel.org>
References: <20260710085256.3464201-1-aalbersh@kernel.org>
MIME-Version: 1.0
X-Headers-End: 1wi709-0007Zy-Cn
Subject: [f2fs-dev] [PATCH v11 20/20] xfs: enable ro-compat fs-verity flag
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
