Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E462C55822
	for <linux-f2fs-devel@archiver.kernel.org>; Mon,  3 Aug 2026 20:09:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-ID:Date:To:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=peiF+ZCve6au7MOusZ3JGQr6+IRBAJffmJNJ0x2V1W0=; b=ieKVbMKn1fcXvr2stHSU8Qyg/b
	1bYCKzCQrP11hl00yaWKhkXNyrAMOvzwWL/QYu9VvVWEHV5UM6RgXo7i9wpBNvEy3CbEyoG41xtS1
	z8EYnIhu726QcXw8MRwsE/bmQotDPDd4sHtobeu1kMVjp76RvguHDjIt1wcDSDjccVYQ=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wqyyj-0007lg-Mu;
	Mon, 03 Aug 2026 20:09:42 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <aalbersh@kernel.org>) id 1wqyyh-0007lO-W9
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 03 Aug 2026 20:09:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=AufMkm+nEeCieeEcnf+ZJSfHdxMb9GSGIeKul87lEHs=; b=MlODpzTdQSUKJFBvJXbuJiK/Yr
 Yh8gsZP3fm/pQqN2B/GH2ICSo0BMsx+bJFjd3ZsJ0jJOySJxM8OX5crur64UAKkSTq3hobPjUmEjy
 WLGr3MJtEnbOWNYN5wfOTZVMZZoJaMi3+73b6fQaJr8mdhbrnLzYGEQ7fkFEWLhqK0ts=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=AufMkm+nEeCieeEcnf+ZJSfHdxMb9GSGIeKul87lEHs=; b=Hz/VlHeHgof4BF4lv9pQH+GTx8
 e11mgLvh0dIk3btgkVSTEVoIB5s8zocidBVSZ2f6KW4Qby4IdE2zvi+Zt8xBsxXe0LNV64a350H+h
 2AfasqcDJaWAzeVDWg7fnW7IWY8B8yobIWEfLKQMCoJPpzNJ1r4YbtgPr4lotHGSXho0=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wqyyk-0000vk-SU for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 03 Aug 2026 20:09:40 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id BD77C60A68;
 Mon,  3 Aug 2026 20:09:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD82D1F000E9;
 Mon,  3 Aug 2026 20:09:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785787773;
 bh=AufMkm+nEeCieeEcnf+ZJSfHdxMb9GSGIeKul87lEHs=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=BRv+LhtiG+1pVRFvdMV2uconPz3S4bZF/fjyim/XtOpOlb2zlNWV4nV7XLkXwUKFG
 6YgxBzAG88dTdgKb4O4Hll83gaVJ380jNJzht/ySR9PLT25raZ2F1yFQM4croyINQK
 QmrNrMpvoYzI3lwx4OOxCX17YjGHpXCKtmb1+uZqUrptu9e+8+63qY6Atjve4i9ZNH
 WLia2WqUndXlB4xDwy6PeDjbEyubwP0XiARoEUhQf1SRnhNEL5LSa6TNHpdqfqPmlH
 pOXuv2IRzQ38D0W5X/G1NGyuOZkgm/zwf4FIb4+mejYgFnP2xzJLTWNuSBYavjHdDW
 k1hu/KZLGBTpg==
To: linux-xfs@vger.kernel.org, fsverity@lists.linux.dev,
 linux-fsdevel@vger.kernel.org, ebiggers@kernel.org
Date: Mon,  3 Aug 2026 22:07:59 +0200
Message-ID: <20260803200820.393203-10-aalbersh@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260803200820.393203-1-aalbersh@kernel.org>
References: <20260803200820.393203-1-aalbersh@kernel.org>
MIME-Version: 1.0
X-Headers-End: 1wqyyk-0000vk-SU
Subject: [f2fs-dev] [PATCH v14 09/21] xfs: don't allow to enable DAX on
 fs-verity sealed inode
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

fs-verity doesn't support DAX. Forbid filesystem to enable DAX on
inodes which already have fs-verity enabled. The opposite is checked
when fs-verity is enabled, it won't be enabled if DAX is.

Signed-off-by: Darrick J. Wong <djwong@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Andrey Albershteyn <aalbersh@kernel.org>
---
 fs/xfs/xfs_iops.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
index 11dc1a485ca7..55667cc762f8 100644
--- a/fs/xfs/xfs_iops.c
+++ b/fs/xfs/xfs_iops.c
@@ -1370,6 +1370,8 @@ xfs_inode_should_enable_dax(
 		return false;
 	if (!xfs_inode_supports_dax(ip))
 		return false;
+	if (ip->i_diflags2 & XFS_DIFLAG2_VERITY)
+		return false;
 	if (xfs_has_dax_always(ip->i_mount))
 		return true;
 	if (ip->i_diflags2 & XFS_DIFLAG2_DAX)
-- 
2.54.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
