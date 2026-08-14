Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDCCAC5B572
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 14 Aug 2026 09:26:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-ID:Date:To:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0KFFaJmZBICXqCBY4xFomJyey3BUBBHU7+OvwKZzCDY=; b=Jl9mqZSq+GFUWqqbJXQmdRTSps
	esbQAXXlmazeepF65nw8x7OMnYsDF+lEGtJkGBMC1S/b7zjHOD+Zegb0PgId6FH+0n+5Dxet4+Pr/
	Q5HEXax8B9g+hPCyEEDc3ria363lbM8Y2321cNx/fCyYJtGrMdutFwx2iccpddclEzHY=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wuoB4-0006EO-I0;
	Fri, 14 Aug 2026 09:26:14 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <aalbersh@kernel.org>) id 1wuoB3-0006EH-Jh
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 14 Aug 2026 09:26:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=VCbZ0KFk5ZUpAhgJyWzjosvAA/mYQFZ16h9KR8EOgiA=; b=EmU9DDE0vJpkZ54/4ZyJNzSa+j
 F99Nl4d2C22L4HdS4Owd7g99So5Db81HH+JFYLnnYLgddeFgrqA84WZEYYP/uXSAo2SNnmp7C3EEn
 to4E4qrlvJBRucf9t/2lurYoF6wvNcx8qLrIRdXee/8Ma1+OKd6VWS1eqPigJ+X2dLdA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=VCbZ0KFk5ZUpAhgJyWzjosvAA/mYQFZ16h9KR8EOgiA=; b=ROpytsrny0KfpRyZeRt782d0oL
 GWpCKe+wQpc5Zq1zAM1vfRJ+qN7i1b+vjiqvUyWZWKYoW5Bzzd8g4lpaGQuE3G1sUTrFWgPPBrgEV
 nHuXeJdIEU78eZ//QYD2wCQHKAeQNhFRQZ5vX1yNAbVK/qbPhUXRtVMcSos8HLuClcgs=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wuoAz-0007jj-Ca for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 14 Aug 2026 09:26:13 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id CD740601DE;
 Fri, 14 Aug 2026 09:26:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BB631F000E9;
 Fri, 14 Aug 2026 09:25:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786699563;
 bh=VCbZ0KFk5ZUpAhgJyWzjosvAA/mYQFZ16h9KR8EOgiA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=QQmQAGpc70y5BEN0/Fyh5Uwgz+y+4fMT1w4eVnrYkY6dq7hcgBBMkDyJlVApEVPqz
 nQEPZlldAgZPf+fgByFxrYF2LTRBCtALz2UJyokD5XHJmNVfK/GEUor7ST0rkFhSqK
 pfqEEqNpmMVDzCJkMkkGhpOAhdrhpuRaTVTGMhWq+k3Nwkvimsjy0cfmtaFYMYx4nn
 lWYkMyMpj/r9LQcq0SpDymbZCHZ1xyq2lOCsx5iWWPJNI+6FfKib+xWOz0xaJk1c6L
 Jd8I302CLjTbCmm64CudM6KUTwQRgn/lKSkGGBeJa3XXqmxKtCxyu8UL7HqZY0gRWz
 PnBLI7Z8DaErQ==
To: djwong@kernel.org, ebiggers@kernel.org, hch@lst.de,
 Jens Axboe <axboe@kernel.dk>, Carlos Maiolino <cem@kernel.org>
Date: Fri, 14 Aug 2026 11:24:23 +0200
Message-ID: <20260814092448.1818082-7-aalbersh@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260814092448.1818082-1-aalbersh@kernel.org>
References: <20260814092448.1818082-1-aalbersh@kernel.org>
MIME-Version: 1.0
X-Headers-End: 1wuoAz-0007jj-Ca
Subject: [f2fs-dev] [PATCH v15 06/25] fsverity: hoist statx reporting of
 fs-verity flag
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
Cc: fsverity@lists.linux.dev, linux-xfs@vger.kernel.org,
 Andrey Albershteyn <aalbersh@kernel.org>, david@fromorbit.com,
 linux-unionfs@vger.kernel.org, stable@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, linux-block@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, Tal Zussman <tz2294@columbia.edu>,
 linux-ext4@vger.kernel.org, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

All filesystems, supporting fsverity, report this status by checking
inode flag. Also, BTRFS was missing stat->attributes_mask, which is
fixed now.

Fixes: 146054090b08 ("btrfs: initial fsverity support")
Cc: stable@vger.kernel.org
Signed-off-by: Andrey Albershteyn <aalbersh@kernel.org>
Acked-by: Eric Biggers <ebiggers@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/btrfs/inode.c | 3 ---
 fs/ext4/inode.c  | 5 +----
 fs/f2fs/file.c   | 5 +----
 fs/stat.c        | 6 +++++-
 4 files changed, 7 insertions(+), 12 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 2534cd9284d5..ed31ba5a65bc 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -8221,7 +8221,6 @@ static int btrfs_getattr(struct mnt_idmap *idmap,
 	struct inode *inode = d_inode(path->dentry);
 	u32 blocksize = btrfs_sb(inode->i_sb)->sectorsize;
 	u32 bi_flags = BTRFS_I(inode)->flags;
-	u32 bi_ro_flags = BTRFS_I(inode)->ro_flags;
 
 	stat->result_mask |= STATX_BTIME;
 	stat->btime.tv_sec = BTRFS_I(inode)->i_otime_sec;
@@ -8234,8 +8233,6 @@ static int btrfs_getattr(struct mnt_idmap *idmap,
 		stat->attributes |= STATX_ATTR_IMMUTABLE;
 	if (bi_flags & BTRFS_INODE_NODUMP)
 		stat->attributes |= STATX_ATTR_NODUMP;
-	if (bi_ro_flags & BTRFS_INODE_RO_VERITY)
-		stat->attributes |= STATX_ATTR_VERITY;
 
 	stat->attributes_mask |= (STATX_ATTR_APPEND |
 				  STATX_ATTR_COMPRESSED |
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index ce99807c5f5b..99fa7a28951f 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -6250,15 +6250,12 @@ int ext4_getattr(struct mnt_idmap *idmap, const struct path *path,
 		stat->attributes |= STATX_ATTR_IMMUTABLE;
 	if (flags & EXT4_NODUMP_FL)
 		stat->attributes |= STATX_ATTR_NODUMP;
-	if (flags & EXT4_VERITY_FL)
-		stat->attributes |= STATX_ATTR_VERITY;
 
 	stat->attributes_mask |= (STATX_ATTR_APPEND |
 				  STATX_ATTR_COMPRESSED |
 				  STATX_ATTR_ENCRYPTED |
 				  STATX_ATTR_IMMUTABLE |
-				  STATX_ATTR_NODUMP |
-				  STATX_ATTR_VERITY);
+				  STATX_ATTR_NODUMP);
 
 	generic_fillattr(idmap, request_mask, inode, stat);
 	return 0;
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 4b52c56d71f0..9b531a016ed4 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -1024,15 +1024,12 @@ int f2fs_getattr(struct mnt_idmap *idmap, const struct path *path,
 		stat->attributes |= STATX_ATTR_IMMUTABLE;
 	if (flags & F2FS_NODUMP_FL)
 		stat->attributes |= STATX_ATTR_NODUMP;
-	if (IS_VERITY(inode))
-		stat->attributes |= STATX_ATTR_VERITY;
 
 	stat->attributes_mask |= (STATX_ATTR_COMPRESSED |
 				  STATX_ATTR_APPEND |
 				  STATX_ATTR_ENCRYPTED |
 				  STATX_ATTR_IMMUTABLE |
-				  STATX_ATTR_NODUMP |
-				  STATX_ATTR_VERITY);
+				  STATX_ATTR_NODUMP);
 
 	generic_fillattr(idmap, request_mask, inode, stat);
 
diff --git a/fs/stat.c b/fs/stat.c
index 89909746bed1..ae1299bd7436 100644
--- a/fs/stat.c
+++ b/fs/stat.c
@@ -203,8 +203,12 @@ int vfs_getattr_nosec(const struct path *path, struct kstat *stat,
 	if (IS_DAX(inode))
 		stat->attributes |= STATX_ATTR_DAX;
 
+	if (IS_VERITY(inode))
+		stat->attributes |= STATX_ATTR_VERITY;
+
 	stat->attributes_mask |= (STATX_ATTR_AUTOMOUNT |
-				  STATX_ATTR_DAX);
+				  STATX_ATTR_DAX |
+				  STATX_ATTR_VERITY);
 
 	idmap = mnt_idmap(path->mnt);
 	if (inode->i_op->getattr) {
-- 
2.54.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
