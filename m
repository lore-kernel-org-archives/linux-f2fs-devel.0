Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D0F7C4451C
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 21 Jul 2026 18:45:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-ID:Date:To:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=KRUHe6ttGhF0kA0ztAAcemiRDPlJIwGNvJKnCPmH0Vw=; b=bv4Kr/pDtawCOqGfhAxzaj02GC
	Di4DoafBkiOhC2YhlkDoVM0cGEAbVUJa9xZ+Nfy4Mc3JC+Gl0amMGNNvc/bGidyCbRYmEuVz9htTm
	3XN4dR0GkRJX2yk8MLyXxINVm+R6/5DbwAanBEHfkl4SaRDKvAKpgl87T1c5BuJnZ7+Y=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wmFSl-0001m1-FS;
	Tue, 21 Jul 2026 18:45:08 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <aalbersh@kernel.org>) id 1wmFSf-0001jA-9k
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 21 Jul 2026 18:45:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=9QTcR6aLgUEtsJ2fn2Z4p7S4tu82w8VjwhNOU+8/DXE=; b=fpEq9YJgNqiCZdvMBig87tCg3c
 JLMXAlcuswjf/3MuTAa8hPpJ0+0jdZI4vHkPJeuvvOn7fA3O85pZ1vg+QM+8hU/qJInv+FXWFl9bM
 KaetI58WaMvWdoGw/SHoJAaN+OOO9rU+LfDgg2FbU/Uv15+6D2OZKLkcdT0Tn30tEkYs=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=9QTcR6aLgUEtsJ2fn2Z4p7S4tu82w8VjwhNOU+8/DXE=; b=Al1L50rQfbdszvgYIedFYS3tiq
 nvKJrj8ElYe2Km+vQtGnFJhEeZNJ3Hph3ilw6XGexqv7AH2tE/62r0bA3RAv1JOrK8Mm1MX4kd52Z
 MLGkxxvzgIL5Hc06514vxzRo+832Ax1rRmFWn1CNRV+UCls6Y9whu3gXvHfjarplr9Q8=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wmFSX-00033S-Jg for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 21 Jul 2026 18:44:54 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 482A543EB2;
 Tue, 21 Jul 2026 18:44:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C08291F000E9;
 Tue, 21 Jul 2026 18:44:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784659488;
 bh=9QTcR6aLgUEtsJ2fn2Z4p7S4tu82w8VjwhNOU+8/DXE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=GfNXUEeB/wLF5RcE1h6XfuPwhyAxRp30JRgQuzfTpOOIt/YDoNZDyLtdueppx1NDQ
 5OoODdku6w55fUJqrVgqIuWoepjjYSCXiUZr/zQKoAhEmEFAMQm3mMxXHD6m3oa26W
 88CR4fF2CC/16dhJ6yd29NiK7I23o3c0cujNhxy4vakNZzqTOz2mo547jPLabo6N2q
 htd9VEuGY+bzCd2jr6C4wyNY4HjJzbJ7ArhiMf43KADFQImKq/9p85NpGMd9SzUrkU
 vYj3CMLUq9Yd4XLQV2pdk9glNwEPJ6ECC4ThTjWKwTRRphs4ke3u4Y3VRiSnVXNiEt
 dHC2QGO0Ws4Kg==
To: linux-xfs@vger.kernel.org, fsverity@lists.linux.dev,
 linux-fsdevel@vger.kernel.org, ebiggers@kernel.org
Date: Tue, 21 Jul 2026 20:40:55 +0200
Message-ID: <20260721184346.416657-19-aalbersh@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260721184346.416657-1-aalbersh@kernel.org>
References: <20260721184346.416657-1-aalbersh@kernel.org>
MIME-Version: 1.0
X-Headers-End: 1wmFSX-00033S-Jg
Subject: [f2fs-dev] [PATCH v13 18/23] xfs: initialize fs-verity on file open
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
 fs/xfs/xfs_file.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
index f7e3fe22ca96..cba194d678fc 100644
--- a/fs/xfs/xfs_file.c
+++ b/fs/xfs/xfs_file.c
@@ -37,6 +37,7 @@
 #include <linux/fadvise.h>
 #include <linux/mount.h>
 #include <linux/filelock.h>
+#include <linux/fsverity.h>
 
 static const struct vm_operations_struct xfs_file_vm_ops;
 
@@ -1719,11 +1720,18 @@ xfs_file_open(
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
