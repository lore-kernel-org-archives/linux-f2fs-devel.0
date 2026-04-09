Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 164E2EA3C59
	for <linux-f2fs-devel@archiver.kernel.org>; Thu,  9 Apr 2026 13:14:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-ID:Date:To:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/ihXTvLKyo6Wb1Ang8QGQKwAsJl0xkpP7D0mcd98cDo=; b=Etd6qkQfdOe+exD6ow+xCLE+VW
	9AO+mTf69EBcPHDy5uiFJyh9wfFKDZrcWRsyNJ+WqS7QnA6xace0KyPq1ZwD0nTirF5c9rITBiX9h
	YuA+6FrL2utLJW6z5IB1Tg5Z5KPKxJOaqF1EU9oghkrd5FsMEERHQZzCoooxRF4dI2Rk=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wApDi-0005oZ-G6;
	Thu, 09 Apr 2026 13:14:54 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <aalbersh@kernel.org>) id 1wApDg-0005oL-M3
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 09 Apr 2026 13:14:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=9o+o/e+0nWVDHKM3SRYN/4oZtN8PnlF2wMfvwmAPe4o=; b=SS6ya9gSCdZUlVyZIz44cqX8U5
 o6o+kOClupjTlXqVnaju9QHwkE0KOU8mtTE2sG4tGSXDUMTBfstiXrlxJDQA1hlKD0vT5wVNY33IW
 PPXpGnv7nxHAgN3jBmYECvI00PvzJTPnijoxvSRP3bz9MokFKP2QekeDsIQBftbtFVpk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=9o+o/e+0nWVDHKM3SRYN/4oZtN8PnlF2wMfvwmAPe4o=; b=hGbHorG6+FcqyX4xkfM6+XrfOC
 k2YDhtRGwAK2TCQ7jprbL5KeuhB23UGPmq+gVWTXDeNp4jLILhf2CRCdOG5b38AIZaISToABWT16R
 NJt/Az9YDLUzREADoXLlmNH/LdtaiOSN+8LULbSIOliqx+CdaG3XmN7ovOkfrYJqgm8A=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wApDg-0002RQ-Ap for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 09 Apr 2026 13:14:52 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id BDB1F60131;
 Thu,  9 Apr 2026 13:14:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D9DAC19424;
 Thu,  9 Apr 2026 13:14:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1775740486;
 bh=60UpzLwPFsE/OH5uzd9+hLYE021xyutp1l0GCWgkWzo=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=UKD4lyFg4opZe3vfypZtbbemlJWxR74gyF8riPaWp/xnwDFuVoAY78ueFD+2T2GJ5
 eI/25Ap+BuEK0DC/qkrF8QKwRd7i1sYmv5Zjy1Qc6W8/cuBfpuBn+qUxMBoyKPiasR
 PapB7mfMcqrEkhP3XpXy/5TQavwLaqr2eFrXAd+IZ53ZbztKBVB5TyoQ9Up7AumjIN
 QJTFJ3UAP7gLxCEvCQfMIMFWZA6RRbXNX9xZaCBL4Mgby0VOleIaHlTPEzAEKNj1uG
 rR8BYewYTc4WWmvMFq1d02o8H+ggr6XWfS4c+Wk6mVmpUxQEHtmxxtnkqdpAjASeme
 Apn3gS5pc026g==
To: linux-xfs@vger.kernel.org, fsverity@lists.linux.dev,
 linux-fsdevel@vger.kernel.org, ebiggers@kernel.org
Date: Thu,  9 Apr 2026 15:13:44 +0200
Message-ID: <20260409131404.1545834-13-aalbersh@kernel.org>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20260409131404.1545834-1-aalbersh@kernel.org>
References: <20260409131404.1545834-1-aalbersh@kernel.org>
MIME-Version: 1.0
X-Headers-End: 1wApDg-0002RQ-Ap
Subject: [f2fs-dev] [PATCH v7 12/22] xfs: don't allow to enable DAX on
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
index ca369eb96561..17efc83a86ed 100644
--- a/fs/xfs/xfs_iops.c
+++ b/fs/xfs/xfs_iops.c
@@ -1387,6 +1387,8 @@ xfs_inode_should_enable_dax(
 		return false;
 	if (!xfs_inode_supports_dax(ip))
 		return false;
+	if (ip->i_diflags2 & XFS_DIFLAG2_VERITY)
+		return false;
 	if (xfs_has_dax_always(ip->i_mount))
 		return true;
 	if (ip->i_diflags2 & XFS_DIFLAG2_DAX)
-- 
2.51.2



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
