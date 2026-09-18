Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66CCFC982DA
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 18 Sep 2026 11:17:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-ID:Date:To:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HzSoacJdVejJYn06Q5KcxERBuVXY/RJ3cbueR3JnaJc=; b=XgbpsVVOraOYkdZyyKtRkEnhNK
	7l77i4F8ZhGpEdpgHO8hurtKoX72iz6sUY6O6FTPOcGHro+JdMJY7qk0ITivGTwLVyfgwMQ0Qt60k
	K+rSL8gnvIcAQ3x1G6jSbYNaUCoPM4xft1eZZzDrlKj9gzwC4scPajKA0xy9dHeVi1Hc=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1x7WaW-0001Jm-2a;
	Fri, 18 Sep 2026 11:17:04 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <aalbersh@kernel.org>) id 1x7WaU-0001JX-Ac
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 18 Sep 2026 11:17:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=X2CWqNywYNsvbx7g4PPecfxdxb01tUk+6rCakwXASDw=; b=LcQ7rKoe3B+A7cNc7ZhaMoqzwr
 7xeGZ1aG4p6al3qEHjL0rGi37nQeTDvdFp5usQelekMOAvTRYT17IbkVU2vXCEgg+LOGGD9B3ryD4
 DkaHAreJNMynH18W86EJNeSYUHG0ElYWHptS+IQ8b3T11VahGfCppWqWO5/jvNqYZVAA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=X2CWqNywYNsvbx7g4PPecfxdxb01tUk+6rCakwXASDw=; b=TzF8AXQ0NA8d+yA4yMrowplVSI
 A6ap1X/mJ07YqMk1ApRZ+z7IVDkzB7/HOQ3bD5cYG8YOBS/TbbOrjIVLMEP87M+PoPWHn0VpH12t+
 UdgbBr5q2bjvDkK13ByoJn/nJbf5ssSkMcpLc4AMAe2PQWl45bkb2U6SOCiVZqb1kIrw=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1x7WaS-000091-5D for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 18 Sep 2026 11:17:02 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 9498F60A99;
 Fri, 18 Sep 2026 11:16:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58B7F1F000FF;
 Fri, 18 Sep 2026 11:16:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789730214;
 bh=X2CWqNywYNsvbx7g4PPecfxdxb01tUk+6rCakwXASDw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=Fh0KYZGVKFFVjzt7gZfAYnsvFPEzhKpBxIyEht/PFPtm05Ge6stxkXMwAi2oV5fA1
 SYdeo0mVp9OlYvWEmVi7kCeTkRq8xJtCCYFujDbYsOEKnJcfexUrHXCebQsqgo6YUa
 2GWjzA0IVKtI+8BMyDIZB3J1LachDpsV6Maes90AHaYEbXYyK2k8au0J/q8EAsxwPf
 Vd0z4tXVcoxB75SnX0ly3qTao6xtu+OuKLQxSXSCMjj/8tOG8jpqdJbnYXmiilCN1g
 F3/QbKRFlUH1M/o0OGdgBiBw0lCKbi+dOC6zI4/H/1XySWXJyxJc+BjuYDHk84STqs
 oeaJ7QOOa1nlw==
To: djwong@kernel.org, ebiggers@kernel.org, hch@lst.de,
 Carlos Maiolino <cem@kernel.org>
Date: Fri, 18 Sep 2026 13:15:31 +0200
Message-ID: <20260918111539.1003439-20-aalbersh@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260918111539.1003439-1-aalbersh@kernel.org>
References: <20260918111539.1003439-1-aalbersh@kernel.org>
MIME-Version: 1.0
X-Headers-End: 1x7WaS-000091-5D
Subject: [f2fs-dev] [PATCH v16 19/21] xfs: check and repair the verity inode
 flag state
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

From: "Darrick J. Wong" <djwong@kernel.org>

If an inode has the incore verity iflag set, make sure that we can
actually activate fsverity on that inode.  If activation fails due to
a fsverity metadata validation error, clear the flag.  The usage model
for fsverity requires that any program that cares about verity state is
required to call statx/getflags to check that the flag is set after
opening the file, so clearing the flag will not compromise that model.

Signed-off-by: Darrick J. Wong <djwong@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Andrey Albershteyn <aalbersh@kernel.org>
---
 fs/xfs/scrub/common.c       | 55 +++++++++++++++++++++++++++++++++++++
 fs/xfs/scrub/common.h       |  2 ++
 fs/xfs/scrub/inode.c        |  7 +++++
 fs/xfs/scrub/inode_repair.c | 36 ++++++++++++++++++++++++
 4 files changed, 100 insertions(+)

diff --git a/fs/xfs/scrub/common.c b/fs/xfs/scrub/common.c
index e5233e31abb7..02b68bf4c512 100644
--- a/fs/xfs/scrub/common.c
+++ b/fs/xfs/scrub/common.c
@@ -45,6 +45,8 @@
 #include "scrub/health.h"
 #include "scrub/tempfile.h"
 
+#include <linux/fsverity.h>
+
 /* Common code for the metadata scrubbers. */
 
 /*
@@ -1754,3 +1756,56 @@ xchk_inode_count_blocks(
 	return xfs_bmap_count_blocks(sc->tp, sc->ip, whichfork, nextents,
 			count);
 }
+
+/*
+ * If this inode has S_VERITY set on it, read the verity info. If the reading
+ * fails with anything other than ENOMEM, the file is corrupt, which we can
+ * detect later with fsverity_active.
+ *
+ * Callers must hold the IOLOCK and must not hold the ILOCK of sc->ip because
+ * activation reads inode data.
+ */
+int
+xchk_inode_setup_verity(
+	struct xfs_scrub	*sc)
+{
+	int			error;
+
+	if (!fsverity_active(VFS_I(sc->ip)))
+		return 0;
+
+	error = fsverity_ensure_verity_info(VFS_I(sc->ip));
+	switch (error) {
+	case 0:
+		/* fsverity is active */
+		break;
+	case -ENODATA:
+	case -EMSGSIZE:
+	case -EINVAL:
+	case -EFSCORRUPTED:
+	case -EFBIG:
+	case -ERANGE:
+	case -EBADMSG:
+		/*
+		 * The nonzero errno codes above are the error codes that can
+		 * be returned from fsverity on metadata validation errors.
+		 */
+		return 0;
+	default:
+		/* runtime errors */
+		return error;
+	}
+
+	return 0;
+}
+
+/*
+ * Is this a verity file that failed to activate?  Callers must have tried to
+ * activate fsverity via xchk_inode_setup_verity.
+ */
+bool
+xchk_inode_verity_broken(
+	struct xfs_inode	*ip)
+{
+	return fsverity_active(VFS_I(ip)) && !fsverity_get_info(VFS_I(ip));
+}
diff --git a/fs/xfs/scrub/common.h b/fs/xfs/scrub/common.h
index f0f073a93413..676b4afd0be4 100644
--- a/fs/xfs/scrub/common.h
+++ b/fs/xfs/scrub/common.h
@@ -267,6 +267,8 @@ int xchk_inode_is_allocated(struct xfs_scrub *sc, xfs_agino_t agino,
 		bool *inuse);
 int xchk_inode_count_blocks(struct xfs_scrub *sc, int whichfork,
 		xfs_extnum_t *nextents, xfs_filblks_t *count);
+int xchk_inode_setup_verity(struct xfs_scrub *sc);
+bool xchk_inode_verity_broken(struct xfs_inode *ip);
 
 bool xchk_inode_is_dirtree_root(const struct xfs_inode *ip);
 bool xchk_inode_is_sb_rooted(const struct xfs_inode *ip);
diff --git a/fs/xfs/scrub/inode.c b/fs/xfs/scrub/inode.c
index 65b13e311916..d1cdd6b445d0 100644
--- a/fs/xfs/scrub/inode.c
+++ b/fs/xfs/scrub/inode.c
@@ -36,6 +36,10 @@ xchk_prepare_iscrub(
 
 	xchk_ilock(sc, XFS_IOLOCK_EXCL);
 
+	error = xchk_inode_setup_verity(sc);
+	if (error)
+		return error;
+
 	error = xchk_trans_alloc(sc, 0);
 	if (error)
 		return error;
@@ -833,6 +837,9 @@ xchk_inode(
 	if (S_ISREG(VFS_I(sc->ip)->i_mode))
 		xchk_inode_check_reflink_iflag(sc, I_INO(sc->ip));
 
+	if (xchk_inode_verity_broken(sc->ip))
+		xchk_ino_set_corrupt(sc, sc->sm->sm_ino);
+
 	xchk_inode_check_unlinked(sc);
 
 	xchk_inode_xref(sc, I_INO(sc->ip), &di);
diff --git a/fs/xfs/scrub/inode_repair.c b/fs/xfs/scrub/inode_repair.c
index 8bc508336aa5..6c0b7130e227 100644
--- a/fs/xfs/scrub/inode_repair.c
+++ b/fs/xfs/scrub/inode_repair.c
@@ -573,6 +573,8 @@ xrep_dinode_flags(
 		dip->di_nrext64_pad = 0;
 	else if (dip->di_version >= 3)
 		dip->di_v3_pad = 0;
+	if (!xfs_has_verity(mp) || !S_ISREG(mode))
+		flags2 &= ~XFS_DIFLAG2_VERITY;
 
 	if (flags2 & XFS_DIFLAG2_METADATA) {
 		xfs_failaddr_t	fa;
@@ -1617,6 +1619,10 @@ xrep_dinode_core(
 	if (iget_error)
 		return iget_error;
 
+	error = xchk_inode_setup_verity(sc);
+	if (error)
+		return error;
+
 	error = xchk_trans_alloc(sc, 0);
 	if (error)
 		return error;
@@ -2035,6 +2041,27 @@ xrep_inode_unlinked(
 	return 0;
 }
 
+/*
+ * If this file is a fsverity file, xchk_prepare_iscrub or xrep_dinode_core
+ * should have activated it.  If it's still not active, then there's something
+ * wrong with the verity descriptor and we should turn it off.
+ */
+STATIC int
+xrep_inode_verity(
+	struct xfs_scrub	*sc)
+{
+	struct inode		*inode = VFS_I(sc->ip);
+
+	if (xchk_inode_verity_broken(sc->ip)) {
+		sc->ip->i_diflags2 &= ~XFS_DIFLAG2_VERITY;
+		inode_set_flags(inode, 0, S_VERITY);
+
+		xfs_trans_log_inode(sc->tp, sc->ip, XFS_ILOG_CORE);
+	}
+
+	return 0;
+}
+
 /* Repair an inode's fields. */
 int
 xrep_inode(
@@ -2084,6 +2111,15 @@ xrep_inode(
 			return error;
 	}
 
+	/*
+	 * Disable fsverity if it cannot be activated.  Activation failure
+	 * prohibits the file from being opened, so there cannot be another
+	 * program with an open fd to what it thinks is a verity file.
+	 */
+	error = xrep_inode_verity(sc);
+	if (error)
+		return error;
+
 	/* Reconnect incore unlinked list */
 	error = xrep_inode_unlinked(sc);
 	if (error)
-- 
2.54.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
