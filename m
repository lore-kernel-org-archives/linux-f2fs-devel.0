Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92670C982DD
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 18 Sep 2026 11:16:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-ID:Date:To:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=VPAQATzFBZOkWZhKJelGDmGeboNibT4QFjM7WdfAF4w=; b=NqKdVHx6sbhgcVFwubGp+XsJW1
	NsJ3PWQeMVeylLL6EhpQDXd3Vp362cikDq4cZf2vxpUHpjIoG0jQNpLKVKjJXXEWgJTOYI3A6SItb
	ch2tyyXkGv6hrPD9wsEgzVXthaekqdzPHP82OZn5R8KmAP7AvjBUKkleNuB0GS4mKbDY=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1x7Wa9-00026j-JK;
	Fri, 18 Sep 2026 11:16:42 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <aalbersh@kernel.org>) id 1x7Wa7-00026U-EL
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 18 Sep 2026 11:16:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=QInnqDD5jc6bE+5gjiyUNdUgRM86g68YjtdsLs+67xc=; b=Pc3jNGAdnZdWUHTxTS0kyWBVHF
 b8QtyWCgCRZbie+j0aJ7xHFc5V7IUHHsJJ8W1A64UGI7BMAuxGY7Zv9xQvu2izX8mRP0oZagN68Ov
 CPraEL5mXUjr6PHfG/4UM3cjK03XUmlyNJTvDmdacmuDlMAAvzUotIjX1RrAzKsXec50=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=QInnqDD5jc6bE+5gjiyUNdUgRM86g68YjtdsLs+67xc=; b=Mlvw5PfldG6LSK3fnt9TGUZ+GJ
 woAQ7EYdJ7zGo+UTxFFjP1kX+yZHWzLTzIDM/TdmHAClREbHTT2sVeg39TCIZZGkRbGG26HpBto8V
 +PHRzTEMrXdvAiCYVX7+pTLUVgCFCPV+D7IBc17fihunF2x4BPuzzsVBQXeFeanV/f9Y=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1x7Wa6-0007sF-Pi for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 18 Sep 2026 11:16:40 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 369B960A93;
 Fri, 18 Sep 2026 11:16:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E70641F0089A;
 Fri, 18 Sep 2026 11:16:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789730192;
 bh=QInnqDD5jc6bE+5gjiyUNdUgRM86g68YjtdsLs+67xc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=DYoLo4xXL0dFO5TV/w+9MtKO/jM00UvuAtonC+y8fulwk/A0sXs+SiD5TxzGJbj82
 EHeqsGHn7iMQzodHqrMn1Bjx/FKhhqz6jmB280VyU4KYfOqKFHPP+N3AY/3EXVAopK
 Y0y68llGa1hSYX+BxEoSi6Ip7R6OUF2Jo7DlwsllhVHDbaCtxJZ773AIWagimivWzr
 L3klC9VwuiIHuHpAmsu/LkebiPkVbhQ9nnaFd/x7V5X3v1HsBnKPetxS+l/2K8joKy
 U4QBG2rwF58t/RAN7syXtPPFjc1ekLVVR61RoPVoGUuoaIjbv+qcq8HyBvQS4GdVHM
 EXz+53WdQDcNA==
To: djwong@kernel.org, ebiggers@kernel.org, hch@lst.de,
 Carlos Maiolino <cem@kernel.org>
Date: Fri, 18 Sep 2026 13:15:25 +0200
Message-ID: <20260918111539.1003439-14-aalbersh@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260918111539.1003439-1-aalbersh@kernel.org>
References: <20260918111539.1003439-1-aalbersh@kernel.org>
MIME-Version: 1.0
X-Headers-End: 1x7Wa6-0007sF-Pi
Subject: [f2fs-dev] [PATCH v16 13/21] xfs: add XFS_BMAPI_UNWRITTEN to unmap
 unwritten extents in __xfs_bunmapi()
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

The __xfs_bunmapi() is used to remove all extents past EOF. Add
XFS_BMAPI_UNWRITTEN to remove only unwritten extents, while leaving
written ones in place. This will be used in following patch to clean up
unwritten extents on fsverity inodes.

Signed-off-by: Andrey Albershteyn <aalbersh@kernel.org>
---
 fs/xfs/libxfs/xfs_bmap.c | 6 +++++-
 fs/xfs/libxfs/xfs_bmap.h | 6 +++++-
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/fs/xfs/libxfs/xfs_bmap.c b/fs/xfs/libxfs/xfs_bmap.c
index cc48f6e20e80..7ba76017ae56 100644
--- a/fs/xfs/libxfs/xfs_bmap.c
+++ b/fs/xfs/libxfs/xfs_bmap.c
@@ -5280,6 +5280,10 @@ __xfs_bunmapi(
 		if (del.br_startoff + del.br_blockcount > end + 1)
 			del.br_blockcount = end + 1 - del.br_startoff;
 
+		if ((flags & XFS_BMAPI_UNWRITTEN) &&
+				del.br_state != XFS_EXT_UNWRITTEN)
+			goto skip;
+
 		if (!isrt || (flags & XFS_BMAPI_REMAP))
 			goto delete;
 
@@ -5414,7 +5418,7 @@ __xfs_bunmapi(
 			if (error)
 				goto error0;
 		}
-
+skip:
 		end = del.br_startoff - 1;
 nodelete:
 		/*
diff --git a/fs/xfs/libxfs/xfs_bmap.h b/fs/xfs/libxfs/xfs_bmap.h
index d5f2729305fa..0f36431d9936 100644
--- a/fs/xfs/libxfs/xfs_bmap.h
+++ b/fs/xfs/libxfs/xfs_bmap.h
@@ -90,6 +90,9 @@ struct xfs_bmalloca {
 /* Try to align allocations to the extent size hint */
 #define XFS_BMAPI_EXTSZALIGN	(1u << 11)
 
+/* Process unwritten extents only. Used for unmapping */
+#define XFS_BMAPI_UNWRITTEN	(1u << 12)
+
 #define XFS_BMAPI_FLAGS \
 	{ XFS_BMAPI_ENTIRE,	"ENTIRE" }, \
 	{ XFS_BMAPI_METADATA,	"METADATA" }, \
@@ -102,7 +105,8 @@ struct xfs_bmalloca {
 	{ XFS_BMAPI_COWFORK,	"COWFORK" }, \
 	{ XFS_BMAPI_NODISCARD,	"NODISCARD" }, \
 	{ XFS_BMAPI_NORMAP,	"NORMAP" },\
-	{ XFS_BMAPI_EXTSZALIGN,	"EXTSZALIGN" }
+	{ XFS_BMAPI_EXTSZALIGN,	"EXTSZALIGN" }, \
+	{ XFS_BMAPI_UNWRITTEN,	"UNWRITTEN" }
 
 
 static inline int xfs_bmapi_aflag(int w)
-- 
2.54.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
