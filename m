Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35383CD4F54
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 20 May 2026 12:38:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-ID:Date:To:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dguR9gX9QK5vuzzwzD3efpAqdB8w0TOY9mdf3r3zkI0=; b=hKpnovfDIJ+4tulxWc3SBUKPN8
	kT/LnspBhnQlVAnCqcsAyWWcI1O8VW/i8J1FPQvKparBZCq99pc6mDEiQP5rlzWo6uZv5Eo/Hl9Op
	1SmcxYFZOp10gm7HtwT/akDb9pTBEk8bdqlii6g7aNRSf5NEyL9+R9QLvPAPi1+a/n5g=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wPgBf-0001PB-3V;
	Wed, 20 May 2026 12:38:11 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <aalbersh@kernel.org>) id 1wPgBZ-0001Nf-2C
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 20 May 2026 12:38:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=1DHHkbgWsldiFzDBohMOCibrE/jcCaw8Lz0td95bxyE=; b=ah7ju9oB4qjPQsq2rjQhjQHxbf
 cOphDxMGhFApCm6C06VTXGe/YFzapQVGqarq7YQWC90D8hAt3TbSvw++duHh1LM4eTAv1cWVOv+Rq
 ReQufSDj/bvK9srITdsZ/stFx70Ut/837VgQ3PANc0Pi8mMg0h0MqAa6BWriTekELvoQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=1DHHkbgWsldiFzDBohMOCibrE/jcCaw8Lz0td95bxyE=; b=gzdLnBZvPNxNJB+I3a2TQ3OF2j
 u4Swvr5Nj6CTIK2f6qTDlsF/YGRdgf8JAjB1vkHFnqDvHhjqNAXW7Yx+mvLiG/AC2TISDl+YY+Leb
 8EytUGAideQt3hCSxMn+Eqbpz4iUM9S+VfscCaBnr8hD9wvqgKF5HcYD3sf9t+XIJYs4=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wPgBW-0006ZX-Pe for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 20 May 2026 12:38:05 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 0354643317;
 Wed, 20 May 2026 12:37:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D634E1F00893;
 Wed, 20 May 2026 12:37:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1779280677;
 bh=1DHHkbgWsldiFzDBohMOCibrE/jcCaw8Lz0td95bxyE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=LRKXai55KPHdXoSF1SgA7EMzJPc1BMAysLhGwQrlta1BIkj+sNr0V/T7d8AHLsrOS
 bd1v9iOaxht824zX6/RpRumfLOXEWsWGhF5Zq9unP9PYgQ/J8AFrACzTsjsHcAT+9U
 vJz/s/N07ayoVpXlNL5B74+euEWv2XVNwU/kzV6ZX9ziPpevXA63WhOPYn+WctfBVV
 hNixN3HydHu+UjAfzFshayfr6qyDhJwhaFeq4JxukRFp+aE/fZ6xL1a6Wp+I9k7Ppc
 2EVa2Js2BHy7/ofpIiFUM4m/LFoi+mvYitEGGJRDqljR4jLsvLjylsEm9TJLb3bc4z
 ANmdEb3mw8kvA==
To: linux-xfs@vger.kernel.org, fsverity@lists.linux.dev,
 linux-fsdevel@vger.kernel.org, ebiggers@kernel.org
Date: Wed, 20 May 2026 14:37:10 +0200
Message-ID: <20260520123722.405752-13-aalbersh@kernel.org>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20260520123722.405752-1-aalbersh@kernel.org>
References: <20260520123722.405752-1-aalbersh@kernel.org>
MIME-Version: 1.0
X-Headers-End: 1wPgBW-0006ZX-Pe
Subject: [f2fs-dev] [PATCH v10 12/22] xfs: don't allow to enable DAX on
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
 linux-unionfs@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-ext4@vger.kernel.org, hch@lst.de, linux-btrfs@vger.kernel.org
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
index 25c6e1d08cdc..99ce8bc12840 100644
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
2.51.2



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
