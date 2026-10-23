Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA4E8606A31E
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 23 Oct 2026 12:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=bIRk/uP3;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=fGLmwA7d;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=U/JnzFn5;
	dkim=neutral header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NzJZDvRh
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:To:In-Reply-To:References:Message-Id:
	MIME-Version:Date:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=hWZKTAQ2QvRof9mgI5kYX5UoeXfF1Wo97kF1FLKxdxw=; b=bIRk/uP3/uiyQ1QHXdUHhaiHbo
	pyGf+YP1I6UH7MF9uDXUCpA6CboKFEjUGdysnNVdJoFNcJVp7asfhR1NiPZhqB2rkIz0MdmAMjF61
	1zBIphDG539j3CoNKSmPeCQuAByw05cZbCPggUxvGlXm5prWnZiEd02GrY02T0UNtkBQ=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xKEeF-000000002jW-2YTa;
	Fri, 23 Oct 2026 12:45:27 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <brauner@kernel.org>) id 1xKEdw-000000002jE-2zg3
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 23 Oct 2026 12:45:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Message-Id:
 Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=rgdAURmlMgVTnL/fFQWHyNoovvjMeOUAESXzVFTzmXg=; b=fGLmwA7dCPVEbge/V3wHoXz6dk
 6CZ+iBGm6iRuZg5Q3tplA0YNJij8ms81+P3KsInrP+6wK/dTUPxH+3INRFhIpfGrzIwhotl3alKbo
 WIBoyFKhPObn6ZHNKahrVSQEmV/+pbFflhiAHBwGK50G3wKeOkcBVPNot8+ryBZHohHw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Cc:To:In-Reply-To:References:Message-Id:Content-Transfer-Encoding:
 Content-Type:MIME-Version:Subject:Date:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=rgdAURmlMgVTnL/fFQWHyNoovvjMeOUAESXzVFTzmXg=; b=U/JnzFn5m3s8jvADRxlGRKsTMd
 GKCSC+i+1ANK4K/VaPd34Ifi2HDxNZcRzi/+DxlwagWBT9gLYEcPNhcUO6m0IKfg/awZ31dtk3FOm
 B6bLpNM1vUOVw3lp+YwILU0JjRyium3uTSZxar+suHC1YHll+CvLKqMavRN8oTpee6kQ=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xKEdw-000000004Af-0zTq
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 23 Oct 2026 12:45:08 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id A7F8460A53;
 Fri, 23 Oct 2026 12:45:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1D0A1F031E1;
 Fri, 23 Oct 2026 12:45:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792759502;
 bh=rgdAURmlMgVTnL/fFQWHyNoovvjMeOUAESXzVFTzmXg=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=NzJZDvRhW++FYtXdKKWPF53butaI0sT8gd8vRr/FNZsnMriJJwgCoTxpRKEeZBSzh
 qec871Xz377IDpLG3uDPN+AnEpyqEMxkFfbrcFRnvPyeuldmahqoppMG4D+go2WeSt
 AIredcXrv+K5Bshr20/XEhukZ4dNPB+m9BExfxPR59cZtV2qsDqaWQALiJLqbtmeyA
 nhxyuYb7pOYTwbq2wk4+ksh3ZjGT3Qp0DPQv466YRdJPhpiTvo/6CBVwRbzT2RQYu6
 eNIF5vmJN922ITZsz8xsUUVOkM454G9CW3x3j8U/wvt31i6dbIqGMe2WA9s0idbuOn
 yb+2kXSp2TnRg==
Date: Fri, 23 Oct 2026 14:44:23 +0200
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Message-Id: <20261023-work-dcache-casefold-v1-2-1b0bd5c73a69@kernel.org>
References: <20261023-work-dcache-casefold-v1-0-1b0bd5c73a69@kernel.org>
In-Reply-To: <20261023-work-dcache-casefold-v1-0-1b0bd5c73a69@kernel.org>
To: linux-fsdevel@vger.kernel.org
X-Mailer: b4 0.17-dev-ce4c1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1755; i=brauner@kernel.org;
 h=from:subject:message-id; bh=f6kUNy44BjhD0KISho48b0YJIAWFq4F28VN5497hSx0=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTdDjsmtez1EymBm2u2dTw8zvbPwWTtG0GJO1PdJWcG5
 +sryvBO6yhlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZhIigwjw3T/z58Sn1fu8eje
 7Lp8zbGYq5ufmXy4kqN3dpK8x1TLS2cZ/vudvjs1cPU1y4+bJ/XEzFzb4+0UJXyu+wy/edXznCp
 5CS4A
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xKEdw-000000004Af-0zTq
Subject: [f2fs-dev] [PATCH 2/2] xfs: unhash a removed name in ascii-ci mode
 instead of invalidating it
X-BeenThere: linux-f2fs-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
From: Christian Brauner via Linux-f2fs-devel
 <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Christian Brauner <brauner@kernel.org>
Cc: "Christian Brauner \(Amutable\)" <brauner@kernel.org>,
 Jan Kara <jack@suse.cz>, linux-f2fs-devel@lists.sourceforge.net,
 linux-xfs@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>,
 Gabriel Krisman Bertazi <krisman@kernel.org>, linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-19.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

xfs_vn_unlink() uses d_invalidate() on the dentry of a removed name on a
case-insensitive filesystem, so that d_delete() doesn't leave a negative
dentry behind. The next create() would otherwise reuse with the wrong
spelling. But as the comment already states all it wants is the unhash.

But d_invalidate() is the wrong primitive for that. It's for a name that
went stale. It walks the subtree, prunes it and detaches every mount it
finds, under namespace_sem, and here that runs from inside the
filesystem's own directory operation. There is nothing below a file or
an empty directory to prune, and vfs_unlink() and vfs_rmdir() detach the
mounts a few lines later as for every other filesystem.

The previous patch moved ext4, f2fs and tmpfs over to d_delete()
unhashing the dentry for them. ascii-ci doesn't set S_CASEFOLD, so the
VFS can't tell these directories apart, and the feature is deprecated
anyway. So just d_drop() the dentry. d_delete() finds it unhashed and
turns it negative without hashing it, exactly as before.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/xfs/xfs_iops.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
index d307ec97fac8..bed8372e4bcb 100644
--- a/fs/xfs/xfs_iops.c
+++ b/fs/xfs/xfs_iops.c
@@ -416,10 +416,10 @@ xfs_vn_unlink(
 	/*
 	 * With unlink, the VFS makes the dentry "negative": no inode,
 	 * but still hashed. This is incompatible with case-insensitive
-	 * mode, so invalidate (unhash) the dentry in CI-mode.
+	 * mode, so unhash the dentry in CI-mode.
 	 */
 	if (xfs_has_asciici(XFS_M(dir->i_sb)))
-		d_invalidate(dentry);
+		d_drop(dentry);
 	return 0;
 }
 

-- 
2.53.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
