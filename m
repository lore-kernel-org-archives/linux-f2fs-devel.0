Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A1F9CD4F3C
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 20 May 2026 12:38:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-ID:Date:To:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4AvS/8zWCLk/DShlIocQtnbeCSukUqQxxoW2QhOThrg=; b=BSUhQI/OM6wzJ1hnAnodSfWjO9
	aUN37A0UIK6izxCuwRqUGAgHnZTBokhyhk8wtEDldOxYG3YuHzAPdhw6PQzpZ6BJOkpLaziG6rJgj
	kSOJ/uBJtj2mxh5hXAIQ8LXqI/7fdpURAsmwMpUkBZ8evEWZ+qqe6/9N3poEB3rvLV94=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wPgBy-0007SX-02;
	Wed, 20 May 2026 12:38:30 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <aalbersh@kernel.org>) id 1wPgBu-0007Rn-Mk
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 20 May 2026 12:38:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=mfyAjF/CmUTJWYFj5Klp/BtXlNLH5opRVJLFuVtT+eY=; b=TDjsZECqyx6XSfIDaOTIGLvxgK
 EIojjAADjXxuTWetwvOaf7CBb5O7GOHCBfvKcx3ydAosrUsPuFKFYhhn3oPzWeIQleQxL62KKK3Av
 DdrZwEV/5o6prikwmcXeJOJzdAN4oo60mFcDFihcTK2+WckHjjfXdPIokrzjhlMdxEKw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=mfyAjF/CmUTJWYFj5Klp/BtXlNLH5opRVJLFuVtT+eY=; b=kPxMbnF7bZlL623/QLhsi+e1ko
 G7LPpl7tlWKtZzQ/GHKC9+BMC2FgaxhYXAj2kxKhWukMJAOD9ajRDymV6w1EczF3BCILaBgsnXv2I
 UYeiywJN9O3FFiA5MRuKYCMAPex/Cls4j+3k/jNP5NLQc72lSev6q5qO5/9zHhD5X0HM=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wPgBt-0006d9-HE for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 20 May 2026 12:38:27 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 729AC601FF;
 Wed, 20 May 2026 12:38:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 013EF1F000E9;
 Wed, 20 May 2026 12:38:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1779280695;
 bh=mfyAjF/CmUTJWYFj5Klp/BtXlNLH5opRVJLFuVtT+eY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=A21DPI5YQPBuVhDAVnIzMTuK4VVJioBQZQbdzkFplNnvjXl1IdzDB+o9R1PPQlBNz
 7g8/lFEIBkRh1a6xvzMb5IGIOhi+khVCZ3ybEow1bA5QnNjV6dUJqO3Q/mBdFM82oh
 ApC90tVdO/St9SPZTWxaAfaOilZG958BjvdOYD68Z+reXkNRx0IjE62B2Gu4FZpZhb
 RdWUPdO8jU/f5ispiHdf1hRYzHsBYDv1zw/wlHtCxzwbQYag/XZbnYFpwKGWdT7Srg
 UKTJ8gnR9Y2C+kK4uhPNWounxXavpMnYDhityc3XFreEujy7pnyGcY4OaWx7wSuBFc
 TM7pIboETB3eg==
To: linux-xfs@vger.kernel.org, fsverity@lists.linux.dev,
 linux-fsdevel@vger.kernel.org, ebiggers@kernel.org
Date: Wed, 20 May 2026 14:37:17 +0200
Message-ID: <20260520123722.405752-20-aalbersh@kernel.org>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20260520123722.405752-1-aalbersh@kernel.org>
References: <20260520123722.405752-1-aalbersh@kernel.org>
MIME-Version: 1.0
X-Headers-End: 1wPgBt-0006d9-HE
Subject: [f2fs-dev] [PATCH v10 19/22] xfs: advertise fs-verity being
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
 Andrey Albershteyn <aalbersh@redhat.com>, linux-unionfs@vger.kernel.org,
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
2.51.2



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
