Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B703FC55843
	for <linux-f2fs-devel@archiver.kernel.org>; Mon,  3 Aug 2026 20:09:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-ID:Date:To:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HbyX65xMV5w+mBIpuTEkkivobBFxB9fAwFpd863iHBY=; b=PC1mZJ0tIRHZeVoo507zRkun7E
	boLw4CSzMcSeqYgJPN4MGswNxswgiOfKNhsuK4pOtAGRrpVmMHYdqh0W/GTbJCaUFfboUTHmNQgXy
	O+tMw/VcsmX1ddUTcsvk38yY4syGprGf8TXZxq6dznPoJ46aZBYnt/R+dm6bCV4KYDGw=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wqyya-0006Pr-Ra;
	Mon, 03 Aug 2026 20:09:30 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <aalbersh@kernel.org>) id 1wqyya-0006Pl-1l
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 03 Aug 2026 20:09:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=rZWX811rIfYR67QwB8vikVgdnuYWzMncjRnGbNdXxUY=; b=Rs0SwlwIkiNAk5zn1YNiSpEvOr
 k3iJXg8aUBdQd9Og183jOB685ioWiB0iG+UmfH7BJJA25jXRPbLf7Y05VaLau0AautCRKWsu4boif
 rsUG6HrnyUvi1rPOaWMm5ySYvYK1yNOz4Z71wIjM3em5+WICvGO+VwHm7arKuVbHQLGw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=rZWX811rIfYR67QwB8vikVgdnuYWzMncjRnGbNdXxUY=; b=j5quPgMhieqJuKOWKaT7VxpUFg
 +x24XQ8AemQRD/Xe5yCC5EbZ0XLwMaeBNC23A0Xlc5dadXJ4GhB5CT6H/w0ocE4ckKFtTOMnJSuir
 1ffDJSXBMEVmHxEHB5ABqHPQFfy6kbTy9HExN4txZhNx2PkiLVOsb9z0gHHWT0+v7+VA=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wqyyX-0001CC-5T for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 03 Aug 2026 20:09:29 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id CFFD5423C1;
 Mon,  3 Aug 2026 20:09:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0E541F000E9;
 Mon,  3 Aug 2026 20:09:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785787763;
 bh=rZWX811rIfYR67QwB8vikVgdnuYWzMncjRnGbNdXxUY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=Xv3GemY77kDWAyLYxMaiSPV9m1hveehoyl3i3Pa1ocRZHXhZRJfMXy7EsEdEH0+mV
 IS4dl/QpROJ3JldTVRKPS0JS0ZIYeQ6K3ODY3IWn8R5wxt6v7M32BSYjQnNRfZz+1P
 ivkjvC3F8h+aljDnxDI8dSwFib21pWU/HZsXqHnLqird2by4+LbX0t3/8R1OjQBtsB
 t8xEDIT9k6idva/WTCbjmdFgKx0hpRrC65uYVS+wvUyDyzoZd1wYDYCl2DNSo30rGb
 TALha/hctIeA2B021v7HH5kbWjdfHoqBi3vkxZOBtAJuhkEx8/EZUqa8nBimuc3qcv
 J+1GfWBOY+TBg==
To: linux-xfs@vger.kernel.org, fsverity@lists.linux.dev,
 linux-fsdevel@vger.kernel.org, ebiggers@kernel.org
Date: Mon,  3 Aug 2026 22:07:56 +0200
Message-ID: <20260803200820.393203-7-aalbersh@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260803200820.393203-1-aalbersh@kernel.org>
References: <20260803200820.393203-1-aalbersh@kernel.org>
MIME-Version: 1.0
X-Headers-End: 1wqyyX-0001CC-5T
Subject: [f2fs-dev] [PATCH v14 06/21] fsverity: don't allow setting DAX file
 attribute on fsverity files
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

When fsverity is enabled on the file, with FS_IOC_ENABLE_VERITY ioctl(),
it checks if file has DAX enabled and fails if that's true. However, the
opposite case is not checked.

Note, that the only other filesystem supporting DAX and fsverity is
ext4, and ext4 does check for this case.

Signed-off-by: Andrey Albershteyn <aalbersh@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 fs/file_attr.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/fs/file_attr.c b/fs/file_attr.c
index bfb00d256dd5..473ebbe9af31 100644
--- a/fs/file_attr.c
+++ b/fs/file_attr.c
@@ -235,10 +235,15 @@ static int fileattr_set_prepare(struct inode *inode,
 	/*
 	 * It is only valid to set the DAX flag on regular files and
 	 * directories on filesystems.
+	 *
+	 * DAX and fsverity are incompatible.
 	 */
-	if ((fa->fsx_xflags & FS_XFLAG_DAX) &&
-	    !(S_ISREG(inode->i_mode) || S_ISDIR(inode->i_mode)))
-		return -EINVAL;
+	if (fa->fsx_xflags & FS_XFLAG_DAX) {
+		if (!(S_ISREG(inode->i_mode) || S_ISDIR(inode->i_mode)))
+			return -EINVAL;
+		if (old_ma->fsx_xflags & FS_XFLAG_VERITY)
+			return -EINVAL;
+	}
 
 	/* Extent size hints of zero turn off the flags. */
 	if (fa->fsx_extsize == 0)
@@ -246,6 +251,7 @@ static int fileattr_set_prepare(struct inode *inode,
 	if (fa->fsx_cowextsize == 0)
 		fa->fsx_xflags &= ~FS_XFLAG_COWEXTSIZE;
 
+
 	return 0;
 }
 
-- 
2.54.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
