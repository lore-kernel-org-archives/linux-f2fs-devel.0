Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B88CCA5FDD
	for <linux-f2fs-devel@archiver.kernel.org>; Fri,  2 Oct 2026 22:37:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-ID:Date:To:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qEF1pL/FQ9/5ZI0j71KeJIuWJstjCuOm22TkFl6Pszo=; b=XFuOrwczQtFc+ZvuFx8dXAP1AB
	czunfEor8MOPldL6YE2Fj8CMGJE5FCWe8RGkCMgSlPShy8ejNautf8wgnuihfqreMcBqzf/8Psczs
	Jupc6/svJ0HfojIxH2C4tvgydwuwI+3rBDa4/3+cpssonn3LfyZpjXWt2d9ZjdoUiJk4=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xClsx-0003c0-PX;
	Fri, 02 Oct 2026 22:37:48 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <aalbersh@kernel.org>) id 1xClsw-0003br-A4
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 02 Oct 2026 22:37:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=tyN8+gtU92vgNY5ULImxmqhPQNG/e7/IRfFO6L6Bczg=; b=ZbmTqugbMjuzLTf4w1aPBVhRxu
 WEsaTOYqDTnJd6WFrcYIpW7gkVIo++rIo/S2oeNU9cNY/M+rjmu3p/5D5ukW4q1DpmRW2zSCrZ1lp
 VtIBnHPzX1aPLZSiR8lmLTblDDF2PfNi/XzPQ9qp840/rg+cjU/7KBT8Hzt3zsKLTU9c=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=tyN8+gtU92vgNY5ULImxmqhPQNG/e7/IRfFO6L6Bczg=; b=Nrt17DBoq70SeSR7WmdBLEwFuH
 t3zh8rhoSoKazYEzJmSjS55S+/Y46rh1GOf/5xIIpvoeAGDxs+/e9J/KL8hOf5F/40BovsIeYqyJu
 gPICzouNdfTK6afJPlYkKSukEB28+85l9vpCVf1TxWpQ7I1LJVotblhZQ3N7I5aT0acg=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1xClsw-0006b5-Ey for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 02 Oct 2026 22:37:46 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 2B3DC40E24;
 Fri,  2 Oct 2026 22:37:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16CFA1F000FF;
 Fri,  2 Oct 2026 22:37:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790980661;
 bh=tyN8+gtU92vgNY5ULImxmqhPQNG/e7/IRfFO6L6Bczg=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=Is6rdJmm0F740AinrlD2eXqyQ7AnNrjuP5QcPizteoY4fErQuf4b372wSufcyTpwG
 DfD+ogqXcOEEIPLqRu0Xk0Q0cVs0mDcylKHW1kpe0MeZA38YSOM7QGzEd0oBIGxk5E
 XKJCJgZOqTviIv0Kj0/07h3MT0BfC2AVswMpbecJ1bnTwWIWMqpMBPB+nbzbYmA6/y
 jUmZvZ4AghOwsfooqgtmHwV10fPRswe04TVonX12wfSorIksJk1tCl5zRUzl7ZhIPs
 874hWB8sD2Y7C6+h+JOurBcKXIph4D5k65eIlzYgko16vJfHbLuleABmueEyMx+Uap
 hynN3EuS5Zovg==
To: djwong@kernel.org, ebiggers@kernel.org, hch@lst.de,
 Carlos Maiolino <cem@kernel.org>
Date: Sat,  3 Oct 2026 00:36:49 +0200
Message-ID: <20261002223705.2175542-9-aalbersh@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261002223705.2175542-1-aalbersh@kernel.org>
References: <20261002223705.2175542-1-aalbersh@kernel.org>
MIME-Version: 1.0
X-Headers-End: 1xClsw-0006b5-Ey
Subject: [f2fs-dev] [PATCH v17 08/21] xfs: don't allow to enable DAX on
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
