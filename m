Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86CC5C47422
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 22 Jan 2024 02:23:35 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1rRjyH-0002Pi-2D;
	Mon, 22 Jan 2024 02:23:33 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1rRjyG-0002Pa-LG
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 22 Jan 2024 02:23:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=qeyilFyzqKvtFdQ1VSbpyJxMr2l1q8q+FZiMDVVvDQc=; b=NeG1nQ1uyQtfnm7UblCfTWSadP
 jrsdUR8KxffnPCZZr9IuFQQbC3u7SS1M4e/U6rLCMdDPGzjERWLT0wiyLU4D76WBCaWBDFQkuRYXM
 328sBOEmx+//WD2XxsybCxezG4fswXarTza2Ykfn2kkz4HojNAXXiU2htqqzThKk08mM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=qeyilFyzqKvtFdQ1VSbpyJxMr2l1q8q+FZiMDVVvDQc=; b=Y
 3Uj+vgobx390H7oVr6oanz8JuUFzEXmIix1OjId+q/Ke4Gu+razMq7YGx7kl/JMYM2JC/ewrXd3gC
 wP2L7P0JoyakFTGpsjHtI5LF9wltGsd9b+tLzDJIRMY8m+SFK5HDw7+tuwJhjN8mzQHhVXismP8os
 Z5rUS7lmjjOVQXAA=;
Received: from sin.source.kernel.org ([145.40.73.55])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1rRjyE-0005c9-EH for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 22 Jan 2024 02:23:33 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id B460DCE1F9C
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 22 Jan 2024 02:23:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2E9AC433F1;
 Mon, 22 Jan 2024 02:23:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1705890203;
 bh=z6sXpXgjIIXF4ORGPRhbVLiWL3zHNdnmLT0QW9aWDvc=;
 h=From:To:Cc:Subject:Date:From;
 b=kn7lVm1fUxlPx66h/CBV2QAlk0VPF75oaJwp5oc0y7G2bZEJ+3Z9eOc0IBHaqhlkW
 af8ID2Zv7bBqCI2vcOLinzvqe8H7/9YuCSNE2fX/iU7kJd+HNPb3dc3YtqD+lfbXZY
 Lr6RQHe1JtD9SOMmZ1+Ep1I9GvyX+CMx29upvdpk2qI71DbBsDdpjpmss8+KiuKSbM
 wGZ8plr4kU758CR3W67LayaxEcbwN5VL02FIf0B2TqhN7mmd2eSF1rioHutaHkcCjK
 BWU1GmfewrENNlQo2T4APOWn43pXxKiRsOnoJ76joAJLML2zlMp/7GVxF3D07ZlVIb
 /BLPld6QnqGFg==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Date: Mon, 22 Jan 2024 10:23:13 +0800
Message-Id: <20240122022313.3054810-1-chao@kernel.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
X-Headers-End: 1rRjyE-0005c9-EH
Subject: [f2fs-dev] [PATCH v2] f2fs: compress: fix to cover
 f2fs_disable_compressed_file() w/ i_sem
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
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

- f2fs_disable_compressed_file
  - check inode_has_data
					- f2fs_file_mmap
					- mkwrite
					 - f2fs_get_block_locked
					 : update metadata in compressed
					   inode's disk layout
  - fi->i_flags &= ~F2FS_COMPR_FL
  - clear_inode_flag(inode, FI_COMPRESSED_FILE);

we should use i_sem lock to prevent above race case.

Fixes: 4c8ff7095bef ("f2fs: support data compression")
Signed-off-by: Chao Yu <chao@kernel.org>
---
v2:
- remove unneeded i_size check pointed out by Jaegeuk.
 fs/f2fs/f2fs.h | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 4481f68d6418..c6655fbdeb5e 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -4409,15 +4409,24 @@ static inline bool f2fs_disable_compressed_file(struct inode *inode)
 {
 	struct f2fs_inode_info *fi = F2FS_I(inode);
 
-	if (!f2fs_compressed_file(inode))
+	f2fs_down_write(&F2FS_I(inode)->i_sem);
+
+	if (!f2fs_compressed_file(inode)) {
+		f2fs_up_write(&F2FS_I(inode)->i_sem);
 		return true;
-	if (S_ISREG(inode->i_mode) && F2FS_HAS_BLOCKS(inode))
+	}
+	if (f2fs_is_mmap_file(inode) ||
+		(S_ISREG(inode->i_mode) && F2FS_HAS_BLOCKS(inode))) {
+		f2fs_up_write(&F2FS_I(inode)->i_sem);
 		return false;
+	}
 
 	fi->i_flags &= ~F2FS_COMPR_FL;
 	stat_dec_compr_inode(inode);
 	clear_inode_flag(inode, FI_COMPRESSED_FILE);
 	f2fs_mark_inode_dirty_sync(inode, true);
+
+	f2fs_up_write(&F2FS_I(inode)->i_sem);
 	return true;
 }
 
-- 
2.40.1



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
