Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CADBCA5FDD
	for <linux-f2fs-devel@archiver.kernel.org>; Fri,  2 Oct 2026 22:38:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-ID:Date:To:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vTq6Al25CFNy3ZczWehBf8uUMakR7daoGQ4h1Y2Lzvw=; b=C4sXkut368B4h9fhTUPxRFksZl
	tzQPyG/rHv6gxZH+/8LgZMqobWHHoue4dbe7A62mXv1HeV9XEStJwBDL7BQd3QePk8/ovNvNe1B0J
	jzWDYf0TiEemPckhiRqSIN/Cu+AGWiaucdgAR73ig/94oKp+VR2oH7rZNx2MgBu9iyUA=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xClu0-0001k7-4k;
	Fri, 02 Oct 2026 22:38:52 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <aalbersh@kernel.org>) id 1xCltQ-0001hH-Aj
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 02 Oct 2026 22:38:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=lfg52zb8DlfflgPU8kvIwpmUoI7GKK53PRBf16ii4Ys=; b=Io/uwO2/Gw7D7x/Jr0lFI06J8F
 kzP0WA85h/o0QlC7Y73KSY8Q6a3cXyitNfs7TAokVFyFjjFTDmkXqg09NhPL34q/8TsPTnRvzulcq
 S1qpi3fNIsgOOUEcidw2o1fXGr+I5oalSHX6YYNn3NsyjUng+BSylsoEiOf8pwFFRRS4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=lfg52zb8DlfflgPU8kvIwpmUoI7GKK53PRBf16ii4Ys=; b=eP2xZ8/FdzWY6/DsyeTlKsohCV
 kF7H0hlHLyhdpzr5idtS4ZYi99eijt4PhoCKU0wEHk5IMXBrUamFVYgIUtCD3dGS5PIuzSOc8ONXn
 odAZ3x6kBg6sS7+MbCSzcir10MUwotm6/lHamd8DI3A48hpqDKZFoct6Sr0D4KOhpZ3s=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1xCltO-0003ju-TD for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 02 Oct 2026 22:38:16 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 5870860D85;
 Fri,  2 Oct 2026 22:38:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05C901F000FF;
 Fri,  2 Oct 2026 22:38:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790980689;
 bh=lfg52zb8DlfflgPU8kvIwpmUoI7GKK53PRBf16ii4Ys=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=j8XOx/n/zCvUR4MwqSio1FINgu934XZOccwlfOyOhVAxRLgQ2vItJcIlkOM+3BhlH
 5cMn/LN449BTuqYy+ZFVk63Aa5XkHARzLCXN7PJVvF2QPk1Bl17mrUHzK8OwKwOAne
 fyMNDoY3lsGKxA2bK/5dM6mOniQFf7XjN6OWqsqPPsScCfgy8NI6dKsR6l/Ft7xrHE
 l8BQXizyQP0rXmsLpW2SBSbLQZl2hZ5ivsD7wplYvvqTkUPpoKHA1sDcwRge3rR9ao
 d+Wuu75p4uYjWP/mGd7tzX9RfyFxOGl4w/fB630wkabWKeVqQLSS+sdySXuozauvTQ
 AVW/srWyw/8vA==
To: djwong@kernel.org, ebiggers@kernel.org, hch@lst.de,
 Carlos Maiolino <cem@kernel.org>
Date: Sat,  3 Oct 2026 00:36:57 +0200
Message-ID: <20261002223705.2175542-17-aalbersh@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261002223705.2175542-1-aalbersh@kernel.org>
References: <20261002223705.2175542-1-aalbersh@kernel.org>
MIME-Version: 1.0
X-Headers-End: 1xCltO-0003ju-TD
Subject: [f2fs-dev] [PATCH v17 16/21] xfs: initialize fs-verity on file open
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

fs-verity will read and attach metadata (not the tree itself) from
a disk for those inodes which already have fs-verity enabled.

Signed-off-by: Darrick J. Wong <djwong@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Andrey Albershteyn <aalbersh@kernel.org>
---
 fs/xfs/xfs_file.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
index 578ca6fb8292..e13390539f04 100644
--- a/fs/xfs/xfs_file.c
+++ b/fs/xfs/xfs_file.c
@@ -1794,11 +1794,18 @@ xfs_file_open(
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
