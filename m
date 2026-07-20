Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89C2FC44515
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 20 Jul 2026 09:05:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-ID:Date:To:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=peiF+ZCve6au7MOusZ3JGQr6+IRBAJffmJNJ0x2V1W0=; b=f3awaZCmlQELANMHcqrogPdEXW
	GppFBQP4cqnqM5/ytLLU9juNuQ9morwhFh9dl9Wkd4E2z8RA+XRPFzPHrdKx3AGlFRciy+I+Bvvll
	YhFA9oVyUFJB0nc8zYc2t302VxzR0RM9aT9E6Pk5K4SVOWv9nz7yrknKpseeKasFAalc=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wljwM-0000K1-E6;
	Mon, 20 Jul 2026 09:05:35 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <aalbersh@kernel.org>) id 1wljwK-0000Ji-Vj
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 20 Jul 2026 09:05:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=AufMkm+nEeCieeEcnf+ZJSfHdxMb9GSGIeKul87lEHs=; b=CKj5GHvDJz7ENliiXPLAC3P7mF
 avSMgGKvTfbgS2coECK4jnwqzygWbzch2mHSkQE7qNUCQzqqWhefi/hdZvK2f11NG3XASLh8Dej8U
 G3bJu/IbDClL7Xo9F9FLi5iSr7VACDf5DL2CSo0yJk4qPjxvlBvbUTsHbNehoQLwDdAA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=AufMkm+nEeCieeEcnf+ZJSfHdxMb9GSGIeKul87lEHs=; b=Te686HMWDM2xxltDsiabnumm29
 VjdFZ2KUKJGO2+0zTz9cWGZxVe8ykCnT6d00oyO5f2mkqAXkXQv+lFb+quCRt2BNN6XA5Ng+qRSGf
 +kAXCmKnrmfQGfunojCA+yQyUDq4BB8wNKKqhKtDun4EfdWM18XcX4i0mzbOTXKEYpqQ=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wljwJ-00087r-Lu for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 20 Jul 2026 09:05:32 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 5AE1743F63;
 Mon, 20 Jul 2026 09:05:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D58A71F00A3A;
 Mon, 20 Jul 2026 09:05:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784538321;
 bh=AufMkm+nEeCieeEcnf+ZJSfHdxMb9GSGIeKul87lEHs=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=H4tTs5snpsGIyCxOsMqLuiTUHKXvzvDv1HKYpw8kASU2Yg3mI58jja6lV2cHVbuuP
 6uIY2GJ6olbkPEASMhJsh8xIylZe0OXiXORO3r6TAF/BBE/4EuUS2HcDn73lb3hATc
 z72MpXklKW2PKnLRBZXcp6tuhP3FlEdljkg84DQcDtlE1e12qqgrve2n3oC6DWGYqR
 YHjVLsqD3awT/B0dEX7gSSBNW73uPO8Y6RPIlqBTkpAhwe4ISYmWF5JjPjqC0wEH+z
 1sk4lKi96rQi6rDqJ793H82RelVwap4IOgMzZuuCdpsbeGYoq/jAFgN+Y3OY1K53bl
 cwzv0nH9tNdVQ==
To: linux-xfs@vger.kernel.org, fsverity@lists.linux.dev,
 linux-fsdevel@vger.kernel.org, ebiggers@kernel.org
Date: Mon, 20 Jul 2026 11:03:37 +0200
Message-ID: <20260720090410.3487990-10-aalbersh@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260720090410.3487990-1-aalbersh@kernel.org>
References: <20260720090410.3487990-1-aalbersh@kernel.org>
MIME-Version: 1.0
X-Headers-End: 1wljwJ-00087r-Lu
Subject: [f2fs-dev] [PATCH v12 09/21] xfs: don't allow to enable DAX on
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
