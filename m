Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A528FF8873
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 28 Apr 2026 08:35:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-ID:Date:To:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Hp5GKAtlG3kIjU13+APTFUhxxJZgciFiGmhu40KjkFs=; b=TOzMkQbl7Y4h1zEb+5CMxMJAlg
	u/7ao3PexhPxdOiztbhMu2dT44lsdDAopWi4fqqTQJaRoIJ7J19/601kTkZeKzmEaUgdQt0/3GyhL
	alVhZmkbK7A/yG74QUXIVo+BMf4X7c+wpVS1oH8c4MVRca7dhCFLxtLzNmPcGqZ/dZsU=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wHdul-00018D-U4;
	Tue, 28 Apr 2026 08:35:31 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <aalbersh@kernel.org>) id 1wHduj-00015Q-I9
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 28 Apr 2026 08:35:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=8khfHPPTDYOvTysJ7YcmpQXZ+97vXVSzPPzSexF7G6w=; b=j32czS8qnVG/mcAR3tK032j2oA
 dZjYc02r/2tph6rdx41XSpL3RrQLIpxITIGvta2pRCiwoDEHAiqFKPE4aY0cTDSRRGiUrSV9s0643
 QYAUzEIPEawX47F7B+ZuIVUuimtUZ2p0lmW3CHMuo4l1FNgRC0Ivmipkd+iUGTlgci+s=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=8khfHPPTDYOvTysJ7YcmpQXZ+97vXVSzPPzSexF7G6w=; b=L+EShiQDb5UsfZsQwVGh//7kx7
 SabFJwQWki1pQpD3KtXAZazkXo83JA8gJZ6id9EKerQC5VdHfokq2iYhOs/mDCVlQ0JasgpAcNILf
 1Y3vSQfGC/+eQfpe3ntO6yhFYQ1hX+QW/2/e/68Ykw6478C2NODP6fqborFcb/J9Cuxc=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wHduF-0004hh-K6 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 28 Apr 2026 08:35:00 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 0F5F66091C;
 Tue, 28 Apr 2026 08:34:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47857C4AF0C;
 Tue, 28 Apr 2026 08:34:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1777365288;
 bh=Aq0ZUSqSUefcts6LfugDkZmOSMW+4m4ueZMlzDmeXr4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=IprwRXJCWRo55iClilMfq2t3DPMoB2rvZ3Fzl0J+HO6tOVe19cTJxslCXwj4MqxKF
 yuQEhDLqK5hmKf86In0+zG5J/5gkdOCa/IlHep/aFi0MbJoa2rsezYxGz0IHkmr3Tr
 iPlrV35uLHTdczcCJmwx69CNVekNRBKZInEXq+8tPTpCvb69VlkFvgjP3KEcTtA5v0
 /ywciA+bjYE8LKf07iwoJ0gm2hYE3B8kMDASbd0pi+zVjOjYG7+fr3nwTVBCQ/lRWV
 N9/SBo/0UjxNy7ytKqnWDFdEaNhm23TiluKY9nIKNyJDXKh0qN1DUw2XXphGL3Fn7F
 M9XMxixyDor1w==
To: linux-xfs@vger.kernel.org, fsverity@lists.linux.dev,
 linux-fsdevel@vger.kernel.org, ebiggers@kernel.org
Date: Tue, 28 Apr 2026 10:33:24 +0200
Message-ID: <20260428083332.768693-19-aalbersh@kernel.org>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20260428083332.768693-1-aalbersh@kernel.org>
References: <20260428083332.768693-1-aalbersh@kernel.org>
MIME-Version: 1.0
X-Headers-End: 1wHduF-0004hh-K6
Subject: [f2fs-dev] [PATCH v9 18/22] xfs: add fs-verity ioctls
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
index facffdc8dca8..e633d56cad00 100644
--- a/fs/xfs/xfs_ioctl.c
+++ b/fs/xfs/xfs_ioctl.c
@@ -46,6 +46,7 @@
 
 #include <linux/mount.h>
 #include <linux/fileattr.h>
+#include <linux/fsverity.h>
 
 /* Return 0 on success or positive error */
 int
@@ -1426,6 +1427,19 @@ xfs_file_ioctl(
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
2.51.2



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
