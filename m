Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E19DFC433F5
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 25 Mar 2022 18:19:12 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.94.2)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1nXoOp-0002CD-El; Fri, 25 Mar 2022 18:19:11 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <jaegeuk@kernel.org>) id 1nXoOo-0002C0-80
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 25 Mar 2022 18:19:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=mMfFQHUnMg0S5gwaDqoNxPrby/mA1FHHq+MNDUnHb+k=; b=Lk+LBNdX7pNgsKQ1tSAHWf2o7V
 YBgUK3GhfnO1bFX+uWfSX2JyOvFy4SiSlIZNDIhlcnUPaQwl9/ybnR2s27WoxdgGYJOQy+HANNhPj
 yrwDJwq0z0EiU2xWF1JukVlHiOMZVr0M+L2GXrT6Xasp9n6Dk2y54qOb5KXaVp6nOD8E=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=mMfFQHUnMg0S5gwaDqoNxPrby/mA1FHHq+MNDUnHb+k=; b=N
 zkJVlWlX4Z8uotIPevjR7bp6Sr8uomsJcJo16vzcNrBopRM0HOMSwmxdDAEYekQOek8c1/9ljXdo2
 bV2hmYmieuHBg+qqBOCC9/TMAmTOkeMtQKqyl/E9XDNJjC4ilDDJrbDruQeRGE76KIR6okOE8levj
 XwUiIV3Z+HDBS6AU=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.94.2)
 id 1nXoWe-00BzfF-KO
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 25 Mar 2022 18:19:09 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 721B561C27;
 Fri, 25 Mar 2022 18:18:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9832C2BBE4;
 Fri, 25 Mar 2022 18:18:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1648232333;
 bh=mfPWDhUfqbiFXpRrbs4H8Twleo93bChDmAXbKA3DZOI=;
 h=From:To:Cc:Subject:Date:From;
 b=o798N7GkFeIXVrWFHPZUaHG9jCRy9jMmPaypZ7TWckJNbKHKJvdpAefwEJlRnIRBQ
 ITBtHfs5ESK7wul7zx+DUIF/lpqKYsNODukV5/gruejEdwJVvd2To2a2kyPkInlHfj
 SdAEtxVnnnn9ELw8VCyZNaVjss5B+4Yp74WsOC+KB40iW3k1DcSm9IRHArs41771/3
 9cw5YkPzpKXCu0/8iFlgQLZlAggXEo4VTrcKOjfpjRYv/0ulhS3lKKYF8c7Dmn+w2p
 NsxEmt1rRdGOQshTgTtmTk7tngCAMIWTYVr1yQPZUFyOof/0T4b80t3pINYH5p6K4A
 eg/uP/F/HVn9w==
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: linux-kernel@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net
Date: Fri, 25 Mar 2022 11:18:50 -0700
Message-Id: <20220325181850.513023-1-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.35.1.1021.g381101b075-goog
MIME-Version: 1.0
X-Headers-End: 1nXoWe-00BzfF-KO
Subject: [f2fs-dev] [PATCH] f2fs: remove unnecessary f2fs_lock_op in
 f2fs_new_inode
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
Cc: Jaegeuk Kim <jaegeuk@kernel.org>,
 Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

This can be removed, since f2fs_alloc_nid() actually doesn't require to block
checkpoint and __f2fs_build_free_nids() is covered by nm_i->nat_tree_lock.

Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/namei.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
index 5ed79b29999f..816285414564 100644
--- a/fs/f2fs/namei.c
+++ b/fs/f2fs/namei.c
@@ -37,13 +37,10 @@ static struct inode *f2fs_new_inode(struct user_namespace *mnt_userns,
 	if (!inode)
 		return ERR_PTR(-ENOMEM);
 
-	f2fs_lock_op(sbi);
 	if (!f2fs_alloc_nid(sbi, &ino)) {
-		f2fs_unlock_op(sbi);
 		err = -ENOSPC;
 		goto fail;
 	}
-	f2fs_unlock_op(sbi);
 
 	nid_free = true;
 
-- 
2.35.1.1021.g381101b075-goog



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
