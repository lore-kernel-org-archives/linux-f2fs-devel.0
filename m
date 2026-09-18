Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9B02C982DF
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 18 Sep 2026 11:16:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-ID:Date:To:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qEF1pL/FQ9/5ZI0j71KeJIuWJstjCuOm22TkFl6Pszo=; b=jqWYmATsPpWUw360xJCSEv9qu1
	/EbzGlgHzsDIgrsunHwfqSO3PYEmc9bWrKnmQKqDLT1YFrIcNiVU4nBcbYJPrC5oeEnJ7LkuCfd5X
	lMyOEwj6OFSxDTqc/s/xyhuN8g+A/s9QweGy1JkRYamNsGumT7aS9pNmt03fne1Lc1ZY=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1x7WZr-0001CZ-3h;
	Fri, 18 Sep 2026 11:16:23 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <aalbersh@kernel.org>) id 1x7WZp-0001CQ-RO
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 18 Sep 2026 11:16:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=tyN8+gtU92vgNY5ULImxmqhPQNG/e7/IRfFO6L6Bczg=; b=KDBl6XuLPKNGn2osLlbrVmanXt
 04UUr/gyGBxXwkJkKUHEt3XO7z4qlolQarYb+ZJMeRA/eJA2batxglkwzwq+8qDuZrxThQb6xfW7+
 L+j6NhDQCDWokbvzxSyyUgvF1r6lNcaVZ1KUJi8ZMGfH6Mh3oKei7+FUaoZjEbsHgsJA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=tyN8+gtU92vgNY5ULImxmqhPQNG/e7/IRfFO6L6Bczg=; b=HHHPN+lCU4z81GGqLrAQ7EidKT
 Oc7FIPaGvZOjvQNmdwn6zkb6vYSB2EIFcaFASf2xiALJOpx0WlKPsqRxqaJ5mlbJo+tgd81I0bB7E
 H20oG1uftGy1oSTN6hU+R4Vd786PHMwunwE2a4ZL01eNyKhMAheWkJSTjpgWVnHsqPBw=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1x7WZp-00006h-EX for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 18 Sep 2026 11:16:21 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id DE3A260A94;
 Fri, 18 Sep 2026 11:16:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4D2E1F000FF;
 Fri, 18 Sep 2026 11:16:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789730175;
 bh=tyN8+gtU92vgNY5ULImxmqhPQNG/e7/IRfFO6L6Bczg=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=b1zmhfPuB3eWjGJ8+HUeW4aOIv9heH2h4oqCwT1HbwzCMvxN3cVAmC3mW4GycylLU
 sDhK8csu45egFrMwtGAskDjO+9AAObefpTeATg0fSGm7iO6dUXDmICIyyWhaGqSqt/
 C303RxKaFzCQveOKD3O5zt14IwOYr8bkrQ+5FgVtSOyA5vVEYGZr7/cKFHUOFuzau1
 a5IhAxrbSYeu284PF5eCoKFUULRK4nNWAy6sWb0NVcC9QS6OdlyBlAHAwr6J01E8cL
 a4wpzEAAzmj3j87VNvivqy1EGXL/S67XbZm4PPEnVT4Dfaao34l9UASlNuPNIRHFQR
 Hon1W5fezjpJA==
To: djwong@kernel.org, ebiggers@kernel.org, hch@lst.de,
 Carlos Maiolino <cem@kernel.org>
Date: Fri, 18 Sep 2026 13:15:20 +0200
Message-ID: <20260918111539.1003439-9-aalbersh@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260918111539.1003439-1-aalbersh@kernel.org>
References: <20260918111539.1003439-1-aalbersh@kernel.org>
MIME-Version: 1.0
X-Headers-End: 1x7WZp-00006h-EX
Subject: [f2fs-dev] [PATCH v16 08/21] xfs: don't allow to enable DAX on
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
Cc: fsverity@lists.linux.dev, Andrey Albershteyn <aalbersh@kernel.org>,
 david@fromorbit.com, linux-unionfs@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
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
index c7ecbb3d258a..b07ca2a33c64 100644
--- a/fs/xfs/xfs_iops.c
+++ b/fs/xfs/xfs_iops.c
@@ -1369,6 +1369,8 @@ xfs_inode_should_enable_dax(
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
