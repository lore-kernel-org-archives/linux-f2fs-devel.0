Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC73BFF886C
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 28 Apr 2026 08:35:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-ID:Date:To:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=CBaAfmqsVtR82iFHYSxzMNeTP4iJ81d6JoScI5bREvE=; b=K9lpkoH126rytc7CVgHwX7cjUs
	gp4OTWvKZr+xfSe899kjsIYzFqx5B7zFSBGQfEz2IOc+ltz0gvN4ysNrCBFb8QaBXAQS6mT+uhhN0
	0d8hjRkj7YtDoxs7XQN99lN7Fau+glO9uLZ4PbV+Jv0LO0Rz6KvjSgDcYdKPxlLjrnZw=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wHdul-00017z-HH;
	Tue, 28 Apr 2026 08:35:31 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <aalbersh@kernel.org>) id 1wHduj-000169-IA
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 28 Apr 2026 08:35:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Xui3Yd2dYz+96SItktvVLM/CAryyTbeJqWzBMfavRug=; b=USHTDUnnQwUys/xjC/D6xsQ5Tn
 F6pM0PE1OxBLTI+faDrRU59LAx4PYlko6ziLuEKZKYwkIkGQz97/0W9ktyreHGsqBWYqs52Fixq1S
 mbTTjvNUwkNrKlyYGbG71dM+f4H7Cd2cBnx11lIlF4n0IS4ronED0yMogfD2tn66Jvnw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=Xui3Yd2dYz+96SItktvVLM/CAryyTbeJqWzBMfavRug=; b=Co+AcEvjImg9Ox06sb8I0JEisd
 yg+MVINf8KUQxn+K83BtKx7U+HGpqeRltNarLQS2qTiRhB7hACbalC8PJRDPurzJqrPaNukalzDfY
 VOLOyIeChWJmlclrV0TCUDcj3SXDWhk2+d74K7PT7RTHFRSQKADWpd9eaKl5LBEiGzrM=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wHduH-0004hh-EF for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 28 Apr 2026 08:35:03 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 286B46014C;
 Tue, 28 Apr 2026 08:35:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 498E0C2BCB5;
 Tue, 28 Apr 2026 08:34:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1777365300;
 bh=ED63hkK8etbxautcxx1u5AO9FSZT6ssFdgXiGIlo5Yc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=ur86l8qHsHNK/DsGAq+jbCQjcJQbpchNoy0cCg4If3r2vIi6XG2QODPglvVCfby8Y
 FvtRBT5whNcm+bTJ0HZxIC6orB9MjuEv2lb4uTaqYjVhGEWs8NYQKO/VaAYY4cK586
 JBzciAtfyNrhQ2XD9vzAe9ezw+p4Dz9n9wmQKvOchqG7x4j+MrLockxQWBLlKiIeeH
 Qtnkpz/MHG44v0qLmehZDRvwQ4j9Ugtge+Cwyc5Q0p0+24mNPgsGWIMCValX9hVTi2
 PHcuJpIv37fuA4k3S3UqDfewFJrSqRqoDLHa2mgrdxGK/+2JPK5Y2eUpa+zCAVbGa5
 iWIK5zjNRl6rQ==
To: linux-xfs@vger.kernel.org, fsverity@lists.linux.dev,
 linux-fsdevel@vger.kernel.org, ebiggers@kernel.org
Date: Tue, 28 Apr 2026 10:33:28 +0200
Message-ID: <20260428083332.768693-23-aalbersh@kernel.org>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20260428083332.768693-1-aalbersh@kernel.org>
References: <20260428083332.768693-1-aalbersh@kernel.org>
MIME-Version: 1.0
X-Headers-End: 1wHduH-0004hh-EF
Subject: [f2fs-dev] [PATCH v9 22/22] xfs: enable ro-compat fs-verity flag
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
index 4dff29659e40..0ce46c234b9c 100644
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
2.51.2



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
