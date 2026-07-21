Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 114F9C4451C
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 21 Jul 2026 18:44:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-ID:Date:To:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=peiF+ZCve6au7MOusZ3JGQr6+IRBAJffmJNJ0x2V1W0=; b=bY8c/QFEhZ9XzWSWpl6dTSF+3H
	cbhtBnSfy0psGgbqUVIj3zEkcpJJHmR1oDLMCFvqz7RGS/JpCaiDBvn/M04iUjDHDcT/r8ESoq6hr
	c+/AldUWHEh79WBQ9gb33Z8FXg2guooUiUY3YBocZZTM0ad5yOWoq3RNHnw/W1svsjZU=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wmFSC-0001fJ-WC;
	Tue, 21 Jul 2026 18:44:33 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <aalbersh@kernel.org>) id 1wmFSB-0001ee-34
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 21 Jul 2026 18:44:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=AufMkm+nEeCieeEcnf+ZJSfHdxMb9GSGIeKul87lEHs=; b=ENCc0brtsY+FE4cwKNoraGo1sL
 nBZdTFvqtp6CcQdLJbmTEpJnLQqbeCjhDCjUem5/DuzcX0LibGo4R9fArhFjnDz11vmJ8hYlZnfvS
 cvLwWKVLom7D8eMuMOrv5hVN5p7TSuADcyICFsybcwdQ0LNYviO4TlAfzjMD3NlYSRsU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=AufMkm+nEeCieeEcnf+ZJSfHdxMb9GSGIeKul87lEHs=; b=IfMDv48ncqsY3Rx7jK0IHPJ1nK
 0/gTZDZcWsuR6RMqEc9T+0wC2NKogPL4SJwvtjwVpAS69tJuL4IcYjN0mqMPwQ85XFJi9oGQrJgO7
 ysv8MQWHnee5GTnOhsLT9CWz/xJ5lK6xTkb6j551pd5njOTY4eOeXAldhiC+NpnlEarM=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wmFSA-000316-GX for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 21 Jul 2026 18:44:31 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id E6BE560A65;
 Tue, 21 Jul 2026 18:44:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 385BA1F000E9;
 Tue, 21 Jul 2026 18:44:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784659464;
 bh=AufMkm+nEeCieeEcnf+ZJSfHdxMb9GSGIeKul87lEHs=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=VI8QXyrtqShahK7xudE6bynn5yytRJCy/Ch1rexov6aQhbV1FcM1eubLjeZVRXyMb
 3Ws0UK49pp1ZQFTzOh+Dwa73FnshywWaypODoUpSt/jVneZGKElQlbmriVB7w1tdfd
 Rc6utKZnknd9FxtIWD0GNveZu7y5ovicZgOwJ7Doyi8gtExLsHRb4L5WQXav07IFhd
 ZtWYdPI5uSIS3gVRgM6rA0KvNDx1Xx1cCaKeVp3/0/hx4yiHKxmib9roobdJWh7NzD
 mbB1j854JdsqVtYsmsEAK/32SNBEMuX8cgdMPfa9PHMTFadKWJUq3FaTHB3bKDWzAI
 oOU3GEW+QHwCg==
To: linux-xfs@vger.kernel.org, fsverity@lists.linux.dev,
 linux-fsdevel@vger.kernel.org, ebiggers@kernel.org
Date: Tue, 21 Jul 2026 20:40:47 +0200
Message-ID: <20260721184346.416657-11-aalbersh@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260721184346.416657-1-aalbersh@kernel.org>
References: <20260721184346.416657-1-aalbersh@kernel.org>
MIME-Version: 1.0
X-Headers-End: 1wmFSA-000316-GX
Subject: [f2fs-dev] [PATCH v13 10/23] xfs: don't allow to enable DAX on
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
