Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12FC3C43458
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 10 Jul 2026 08:54:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-ID:Date:To:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hcrGu/vH0ibCbOa4OHF1YbF4jrQYnToMHc4pA4hTPP4=; b=L3Iri27W2DeIHX00cuFvu9bLe5
	h+ymlheAqL1dxWYx0HzdHhs9WtQU46j+3zm41oImsCFTtDcDF7k3YN3vbHCPRpFihdybgdu8LnvDO
	lNDj1Isbgvs+86+8a2MUzP6XyoaOkr74sdz85gJZt3estMbgH3DlEMFPqPoO0Jx+UJIc=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wi707-0003Xv-1U;
	Fri, 10 Jul 2026 08:54:27 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <aalbersh@kernel.org>) id 1wi706-0003Xe-Ih
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 10 Jul 2026 08:54:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=gWGHAsVEWDN5q0AsAxjKzOwxRUm3dDFZ1Y+hUuQVafs=; b=Ybn3C3VcaChctvADhkRfIl0Bh+
 w5SZRwbytTLpby+/3A4tiJ4izJmfHSGzo3h5SVWjZmVmvDlxdEkhZzdu42fCWGg8sLNIxlc7T3p9Q
 NKk1ePz6mF2w4IByB+C67d5x9cG23gk/N2FDAa1uf2M3d8HcVrij8MZ4u4qTuVw7BkeU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=gWGHAsVEWDN5q0AsAxjKzOwxRUm3dDFZ1Y+hUuQVafs=; b=EbB111ZBVWi2LfXS46mU6FHY5V
 X2sDcZ9iXKzd5OhABBGaP1EZRPJKHWO6P84tpdZ+FumDpZEVP42bLyRzhxCfj726XkrXvfuV10M2k
 kcLRfGNQdJ6cMTv0eCdXo9Awrh4OJz1v02OrFBEw3WmjsaWZXt6M/xi5bA5yngamPhuQ=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wi705-0007Z0-U8 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 10 Jul 2026 08:54:27 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 5CC656111A;
 Fri, 10 Jul 2026 08:54:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63C791F00A3A;
 Fri, 10 Jul 2026 08:54:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783673655;
 bh=gWGHAsVEWDN5q0AsAxjKzOwxRUm3dDFZ1Y+hUuQVafs=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=j4LJD5lmFH9jU7mhpJmp7RZNQ2FfTX191mZ2lexxoX1sCIxDwosQeCmXGpaQ+pSRR
 Br5lNxMoVU4Rej5uLFkOoSeD6fhBuprspL5twzl/7Xry/3j+/73tvI2yjpq4jYuU1Q
 ZJkPX6RCjLxxP5I9kCvo+AI0bDz3d8bnWFMOEFYxL6S3mcDGUVqAzI1kDW07zuOGE3
 iZ7nnqyfpggy+UY9UO67KnOEQPRopWuXPiRAJLKJMScQHzyHKYFu4NyvMOoTz+x+eT
 vW746JG0Q2/lfmLhyt45CWmX6OXQaG33Wd8SZAVhzmv/7hsCr8bvLfkgbNd5BGsJ1o
 /F1Ba+xV9OwXg==
To: linux-xfs@vger.kernel.org, fsverity@lists.linux.dev,
 linux-fsdevel@vger.kernel.org, ebiggers@kernel.org
Date: Fri, 10 Jul 2026 10:52:45 +0200
Message-ID: <20260710085256.3464201-18-aalbersh@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260710085256.3464201-1-aalbersh@kernel.org>
References: <20260710085256.3464201-1-aalbersh@kernel.org>
MIME-Version: 1.0
X-Headers-End: 1wi705-0007Z0-U8
Subject: [f2fs-dev] [PATCH v11 17/20] xfs: advertise fs-verity being
 available on filesystem
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
Cc: Andrey Albershteyn <aalbersh@kernel.org>,
 "Darrick J. Wong" <djwong@kernel.org>,
 Andrey Albershteyn <aalbersh@redhat.com>,
 linux-f2fs-devel@lists.sourceforge.net, linux-ext4@vger.kernel.org, hch@lst.de,
 linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

From: "Darrick J. Wong" <djwong@kernel.org>

Advertise that this filesystem supports fsverity.

Signed-off-by: Darrick J. Wong <djwong@kernel.org>
Reviewed-by: Andrey Albershteyn <aalbersh@redhat.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Andrey Albershteyn <aalbersh@kernel.org>
---
 fs/xfs/libxfs/xfs_fs.h | 1 +
 fs/xfs/libxfs/xfs_sb.c | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/fs/xfs/libxfs/xfs_fs.h b/fs/xfs/libxfs/xfs_fs.h
index 185f09f327c0..c80133784419 100644
--- a/fs/xfs/libxfs/xfs_fs.h
+++ b/fs/xfs/libxfs/xfs_fs.h
@@ -250,6 +250,7 @@ typedef struct xfs_fsop_resblks {
 #define XFS_FSOP_GEOM_FLAGS_PARENT	(1 << 25) /* linux parent pointers */
 #define XFS_FSOP_GEOM_FLAGS_METADIR	(1 << 26) /* metadata directories */
 #define XFS_FSOP_GEOM_FLAGS_ZONED	(1 << 27) /* zoned rt device */
+#define XFS_FSOP_GEOM_FLAGS_VERITY	(1 << 28) /* fs-verity */
 
 /*
  * Minimum and maximum sizes need for growth checks.
diff --git a/fs/xfs/libxfs/xfs_sb.c b/fs/xfs/libxfs/xfs_sb.c
index a15510ebd2f1..222bbe5559df 100644
--- a/fs/xfs/libxfs/xfs_sb.c
+++ b/fs/xfs/libxfs/xfs_sb.c
@@ -1590,6 +1590,8 @@ xfs_fs_geometry(
 		geo->flags |= XFS_FSOP_GEOM_FLAGS_METADIR;
 	if (xfs_has_zoned(mp))
 		geo->flags |= XFS_FSOP_GEOM_FLAGS_ZONED;
+	if (xfs_has_verity(mp))
+		geo->flags |= XFS_FSOP_GEOM_FLAGS_VERITY;
 	geo->rtsectsize = sbp->sb_blocksize;
 	geo->dirblocksize = xfs_dir2_dirblock_bytes(sbp);
 
-- 
2.54.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
