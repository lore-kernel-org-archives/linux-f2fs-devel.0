Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA701FF886C
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 28 Apr 2026 08:34:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-ID:Date:To:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3sP00QLGa1BkX94twFSN8lkgfctZQi8UMhZZitaYmw0=; b=hpd6dSU/UmL70Doa87yU2doqKD
	RZgk+S/CB/ndFH1+eyTKJVVskqrghlau1elqlKKImud1YcFjvilGdlAwVt8NvRmY3pFyLRdm282rf
	zoeP4CfEVUcucGXphewlxGgM8STX+zcrcf7Ww2j2FfNhv9KmcSaq6acYcv5t7qvmcbZM=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wHdtz-0004TA-AM;
	Tue, 28 Apr 2026 08:34:43 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <aalbersh@kernel.org>) id 1wHdtw-0004Sz-6U
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 28 Apr 2026 08:34:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=L7lbVMXOwHHcAevnI59LdKxFWewGKSw08vt9Mtg3z1Q=; b=gRzNhCUa6STei6boPepBEGI3gO
 XCfRdboGHJSXUFQNaq5MUAvWm4WeZOeEabsbx0FmoR5k8E/2xOv9e9VeJIbDiCHs8ec9MxNixAb9n
 fNLdT1+K3AqNjZmaGFy/m5kgJsFADyJb7SR45ZW8fmzY8BswAigJQ3kcqVkqFhY6koOY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=L7lbVMXOwHHcAevnI59LdKxFWewGKSw08vt9Mtg3z1Q=; b=KjSTxmuf5I/zdarz++j51aYaQi
 yObvUhXcTKGVjJKi0pdhxcJ/ecdG6csnsEXeoRz5ZRrBomZ7NBMM+MH3S4xIKvjYwtBl25o0k3XMK
 6DNJf2u1H4ppRuKs8B+gKfGVqiwM86peDI52wbJppMUTgaipMotUqoyZ3qdYshZQOxIY=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wHdtv-0004fr-Q2 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 28 Apr 2026 08:34:40 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 3DF1261119;
 Tue, 28 Apr 2026 08:34:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 698DBC2BCB9;
 Tue, 28 Apr 2026 08:34:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1777365273;
 bh=l2TuE4Dq3W00QnGqh26ac7WtX/eqBCa3lcQ4ZM8TF1E=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=YMwK2SQ6PuOpeyfRJw58qAZtdcj0ld0MHefAaomuol/byqLyagL8z2OnXDvQ88nAe
 VgRYaBrpWNw1GDwBgpJwJbzz5QlIvIOrqAQ/sImd1mHsAgk746ujTCQXHlQjobP+vx
 SsOQ0JJbSqzH4c8wvITLmHPprh8vM1hkgcB5xq3xiWP+w0+nW0xBCtrHNAkKWMYzq/
 gw5oVMGNE0A0oDI3340xvs7oK+Tm4CFF/nXxbKYLxiXEmxy8W/rd7LUfGxguEiY3Dk
 GH5DA2auZZ1xuXTWyzvLOeKNPYCGHxmijpda4QWfmRKPrzcwgD93RSLUFbmq6+zFiP
 D7KVqTgTWS6Ug==
To: linux-xfs@vger.kernel.org, fsverity@lists.linux.dev,
 linux-fsdevel@vger.kernel.org, ebiggers@kernel.org
Date: Tue, 28 Apr 2026 10:33:19 +0200
Message-ID: <20260428083332.768693-14-aalbersh@kernel.org>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20260428083332.768693-1-aalbersh@kernel.org>
References: <20260428083332.768693-1-aalbersh@kernel.org>
MIME-Version: 1.0
X-Headers-End: 1wHdtv-0004fr-Q2
Subject: [f2fs-dev] [PATCH v9 13/22] xfs: disable direct read path for
 fs-verity files
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

The direct path is not supported on verity files. Attempts to use direct
I/O path on such files should fall back to buffered I/O path.

Signed-off-by: Darrick J. Wong <djwong@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Andrey Albershteyn <aalbersh@kernel.org>
---
 fs/xfs/xfs_file.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
index a980ac5196a8..6fa9835f9531 100644
--- a/fs/xfs/xfs_file.c
+++ b/fs/xfs/xfs_file.c
@@ -282,7 +282,8 @@ xfs_file_dax_read(
 	struct kiocb		*iocb,
 	struct iov_iter		*to)
 {
-	struct xfs_inode	*ip = XFS_I(iocb->ki_filp->f_mapping->host);
+	struct inode		*inode = iocb->ki_filp->f_mapping->host;
+	struct xfs_inode	*ip = XFS_I(inode);
 	ssize_t			ret = 0;
 
 	trace_xfs_file_dax_read(iocb, to);
@@ -333,6 +334,14 @@ xfs_file_read_iter(
 	if (xfs_is_shutdown(mp))
 		return -EIO;
 
+	/*
+	 * In case fs-verity is enabled, we also fallback to the buffered read
+	 * from the direct read path. Therefore, IOCB_DIRECT is set and need to
+	 * be cleared (see generic_file_read_iter())
+	 */
+	if (fsverity_active(inode))
+		iocb->ki_flags &= ~IOCB_DIRECT;
+
 	if (IS_DAX(inode))
 		ret = xfs_file_dax_read(iocb, to);
 	else if (iocb->ki_flags & IOCB_DIRECT)
-- 
2.51.2



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
