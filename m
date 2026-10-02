Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E431CA5FE7
	for <linux-f2fs-devel@archiver.kernel.org>; Fri,  2 Oct 2026 22:38:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-ID:Date:To:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=QGK/7ZUAXuKlr4r7Usv8ddFoT2MDZUpeQ40DY+xa5As=; b=XVE600TINaFFBOmLBzPSdF89Bd
	y6USfJU18WZ0ivzUoz09LYFtB33Y8tr28qprtddqUYBxkt1aHM4oGwDfmwI0icuGP3gx6zxKXD2Sj
	j35NHpxjBmpbABr95KRB0k1FiZB12NQyeC9e6hrzaM7S8dME1qxT2p/iqe+keBZXAOs4=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xClu1-0001kO-GF;
	Fri, 02 Oct 2026 22:38:53 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <aalbersh@kernel.org>) id 1xCltd-0001hU-Td
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 02 Oct 2026 22:38:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=HrtmR+UhuIlkdLxqdHwsV1MPMtkWUuoZJKrA9HvlOJs=; b=WG6XCE3u4NKR8PyJ3Uaiu5UX4i
 IVv4EJRwM31jk9BTombccO1BhwXLKNzHmHT3h4wTmnAsRYHsDBYDmK1yUv0mmhFNJpUJC73EvQYx9
 +SHXYe8JhWbOvT86FSEu7RDmAfztmGq5O5lLQvqR0MmiAmEKoc2mv/XIriZBvdYfkBqI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=HrtmR+UhuIlkdLxqdHwsV1MPMtkWUuoZJKrA9HvlOJs=; b=i7p4hJ3rKXGKtQyscp5KmAe9tn
 13ncCjoGmo/ZZNKDcJyecrlKBLSwM1S8ZijnLmgx3I8P4QLy5T8DxUYnUwv0aOKDORb2ZgIrn0daU
 OR93KTSDcW4UEajiBhjLZz0DmgVI03cB8POUpg3EZ05t06inQF5u0Mfdx3b9J1fzBCBY=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1xCltR-0006c0-WD for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 02 Oct 2026 22:38:18 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id AE9BB41A41;
 Fri,  2 Oct 2026 22:38:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DDFB1F00893;
 Fri,  2 Oct 2026 22:38:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790980692;
 bh=HrtmR+UhuIlkdLxqdHwsV1MPMtkWUuoZJKrA9HvlOJs=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=GNlQY51UK2aqkIyJmyZ4Kim5Wn44NuJ+ZNK1ATX3nI/r5cLKmuq7G252oExQojpgI
 9SM8z0Tr9CdqjmM5/YGd6GjVMDQn9BOO+/lr6Xu+J8AvFDMf00x5UHdB2R9QPpFoxw
 1TWiyZYwFj4gaI1ngJwCtiSbozEY2/RtEuurfiBiUmP5/AQjkk3T5Ca2ugVqLE19Ap
 oXLg7Uq09YlGPJGh2BGRT4sp5HrfI6HsRTgl0wekMCyWb2LZGoPHNKiLmRSa65BT9w
 lh95gpeOl2mCy1MGIunwV/zMEAGdR8Mcft7QLyK2dmGlcjKlfTgmZ5WQm/UnubyiK1
 yFTRZmuMdNw1Q==
To: djwong@kernel.org, ebiggers@kernel.org, hch@lst.de,
 Carlos Maiolino <cem@kernel.org>
Date: Sat,  3 Oct 2026 00:36:58 +0200
Message-ID: <20261002223705.2175542-18-aalbersh@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261002223705.2175542-1-aalbersh@kernel.org>
References: <20261002223705.2175542-1-aalbersh@kernel.org>
MIME-Version: 1.0
X-Headers-End: 1xCltR-0006c0-WD
Subject: [f2fs-dev] [PATCH v17 17/21] xfs: add fs-verity ioctls
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

Add fs-verity ioctls to enable, dump metadata (descriptor and Merkle
tree pages) and obtain file's digest.

[djwong: remove unnecessary casting]

Signed-off-by: Darrick J. Wong <djwong@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Andrey Albershteyn <aalbersh@kernel.org>
---
 fs/xfs/xfs_ioctl.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/fs/xfs/xfs_ioctl.c b/fs/xfs/xfs_ioctl.c
index 96ca3e480cb9..ac4c36f381b8 100644
--- a/fs/xfs/xfs_ioctl.c
+++ b/fs/xfs/xfs_ioctl.c
@@ -49,6 +49,7 @@
 
 #include <linux/mount.h>
 #include <linux/fileattr.h>
+#include <linux/fsverity.h>
 
 /* Return 0 on success or positive error */
 int
@@ -1466,6 +1467,19 @@ xfs_file_ioctl(
 	case XFS_IOC_VERIFY_MEDIA:
 		return xfs_ioc_verify_media(filp, arg);
 
+	case FS_IOC_ENABLE_VERITY:
+		if (!xfs_has_verity(mp))
+			return -EOPNOTSUPP;
+		return fsverity_ioctl_enable(filp, arg);
+	case FS_IOC_MEASURE_VERITY:
+		if (!xfs_has_verity(mp))
+			return -EOPNOTSUPP;
+		return fsverity_ioctl_measure(filp, arg);
+	case FS_IOC_READ_VERITY_METADATA:
+		if (!xfs_has_verity(mp))
+			return -EOPNOTSUPP;
+		return fsverity_ioctl_read_metadata(filp, arg);
+
 	default:
 		return -ENOTTY;
 	}
-- 
2.54.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
