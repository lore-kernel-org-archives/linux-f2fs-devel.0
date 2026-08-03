Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76B47C55196
	for <linux-f2fs-devel@archiver.kernel.org>; Mon,  3 Aug 2026 20:10:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-ID:Date:To:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MrbPbNLJjfM0Eldrc0Ei3bMVFw/PCveJCtDe9NSdDn8=; b=KNVJiEfkeP+iiCxQgOTRAHAs6f
	UuWMGRdT/1BOyta46Nglq9krEyhN3pR+B/fwjBUu4h1822FDzyFC6EFqrPdvrUNiwm769cxL/epRY
	h27uUQYUs5RmlBBx/jWqjpFHVv+dQ/Epp3QuznjqCRZGh1lpqvrm46JukQQFz7goXifs=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wqyz4-0004KQ-Mv;
	Mon, 03 Aug 2026 20:10:03 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <aalbersh@kernel.org>) id 1wqyz3-0004KE-Ul
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 03 Aug 2026 20:10:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=XYiFsFX7rZIZ+NM4yzl+CfRY3gAtOLbmDgiEslfJgig=; b=Ew8w7gGFgcOEwfYlPQvj0FR0J6
 nLttMJ5bLNn/2aXfN+O50U/rk+3YNe4Jym1zSeIQZVKyv8b1WX9b8ZsQ53vyqVVt0D+nS+jsnFT/f
 RXrnITJ2Oz85X22+ahKYnnZdMePUIEngDn9awve0YwCibwIEN7zl85uaftvru7HQB47A=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=XYiFsFX7rZIZ+NM4yzl+CfRY3gAtOLbmDgiEslfJgig=; b=PBPp1gCBdl7SHP6lKe2aW+cvvf
 iX77bjDKqNBS/xPgvA3wuXG7jgChOuWZ2xow4emDMgvees5EnWU/gTeBDbDhUS5hZzCVTD1s+5Wiq
 d5ZqBPHI71yGrZofIJ7SFXYyvau8dhUaYWym16YOQ1STX6J8tLKXxnqMVSMNHK6Te4mA=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wqyz7-0000wp-N0 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 03 Aug 2026 20:10:02 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 60C2E60A9C;
 Mon,  3 Aug 2026 20:09:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8ADB21F00A3A;
 Mon,  3 Aug 2026 20:09:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785787796;
 bh=XYiFsFX7rZIZ+NM4yzl+CfRY3gAtOLbmDgiEslfJgig=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=jErhP0kO6bvJI4W38MBU2AlfusQheOOyZpkpn7x/VNh+9XXI7aPqDiLKwu5cOSd37
 RiBuekaOKE5TtPTb1evjzdf00NElJKuzVgAQE1Uk+ZLrgUtE03pRPLK416dCrFFO3A
 60LEm7uE9YjM8eyG5XLn5+vRuvXW79VitFWv/ki4Yy9pGET3PUwEVCOc68gBBuQrk4
 PnC6HlxeEhu91N9rq2705JLQHdoftzqhnRzHTya5NIuEnvV9Df9GwG/39Qm278TkVz
 QkfyjX1rbIEk4nPQHoPSxJAvGyGPuZKTqsM9GbUckN04wK3WfQBet53n1t+xkPc2zB
 JcO6x1cv5lCAg==
To: linux-xfs@vger.kernel.org, fsverity@lists.linux.dev,
 linux-fsdevel@vger.kernel.org, ebiggers@kernel.org
Date: Mon,  3 Aug 2026 22:08:06 +0200
Message-ID: <20260803200820.393203-17-aalbersh@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260803200820.393203-1-aalbersh@kernel.org>
References: <20260803200820.393203-1-aalbersh@kernel.org>
MIME-Version: 1.0
X-Headers-End: 1wqyz7-0000wp-N0
Subject: [f2fs-dev] [PATCH v14 16/21] xfs: initialize fs-verity on file open
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

fs-verity will read and attach metadata (not the tree itself) from
a disk for those inodes which already have fs-verity enabled.

Signed-off-by: Darrick J. Wong <djwong@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Andrey Albershteyn <aalbersh@kernel.org>
---
 fs/xfs/xfs_file.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
index 43b8fd5a25c5..34160eeb29bf 100644
--- a/fs/xfs/xfs_file.c
+++ b/fs/xfs/xfs_file.c
@@ -1719,11 +1719,18 @@ xfs_file_open(
 	struct inode	*inode,
 	struct file	*file)
 {
+	int		error;
+
 	if (xfs_is_shutdown(XFS_M(inode->i_sb)))
 		return -EIO;
 	file->f_mode |= FMODE_NOWAIT | FMODE_CAN_ODIRECT;
 	if (xfs_get_atomic_write_min(XFS_I(inode)) > 0)
 		file->f_mode |= FMODE_CAN_ATOMIC_WRITE;
+
+	error = fsverity_file_open(inode, file);
+	if (error)
+		return error;
+
 	return generic_file_open(inode, file);
 }
 
-- 
2.54.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
