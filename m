Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86E07C27C52
	for <linux-f2fs-devel@archiver.kernel.org>; Thu,  6 Jun 2024 09:56:07 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1sF9qp-00085c-Eg;
	Thu, 06 Jun 2024 09:56:06 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1sF9qo-00085V-Su
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 06 Jun 2024 09:56:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=jR6C+wFdE3uOl2fRjQL/fyknAU7aLPEEszWnuwweJvA=; b=grW+cguQCNBQiovKOvISsZnL5F
 ZTBVBcDirhd/xUtMCEnS/tPR4fE6HDtqMK6Zr2QCUwE5AwowHQyo/2GxdJh/61i1ybYYYXI4WwPa3
 hxJLGYKnNkqGRhuKWU6qBstqXz2XprQBIfzg6Iyi1Hvs+gtpR7AQxzRXWoMVr5EvMNAc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=jR6C+wFdE3uOl2fRjQL/fyknAU7aLPEEszWnuwweJvA=; b=h
 PvBkobWUXeqXpOTmssz/khjItcivmFldX/5GmRKAHctO4Vi8UH9M9Q+P3zHUzlDtT2DTvlwAsR+84
 VMaHyxT56FrRsh9Shvs1em7d28FCoQWctsT1VX5rxBgdb/Q6UTxCRxr/Ur9CEwNDZo3TMIo22U1W+
 KllXOGRJ/TYVC14U=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1sF9qo-0004gL-IB for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 06 Jun 2024 09:56:06 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 7292261A94
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu,  6 Jun 2024 09:56:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01782C32786;
 Thu,  6 Jun 2024 09:55:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1717667760;
 bh=taqzzIoM4pefR9En+zKIyMj3up5tKOsXWoFe6XXJE1U=;
 h=From:To:Cc:Subject:Date:From;
 b=nGQ4XbpMf66u0zSZZspvZOCfAm70HsfKzEN59kFtS2za97f7TzHpX8UW1QeYY1N4G
 HPdg0tJp2j2w0rAGx6rpqj4OIi7eHlBAZde7jDsa6JLnwiP+gzyHGCY9m8YIHrZpfP
 DNUr8V5rrfbDG00TNgKMLxk2ZZJ67bXdjyJOIWtLaRW9ixD/3mxs1fjvFbsl2aUstC
 eI7BvLZa7FVLUYxJwIqJ1AyXn2NEJE0dr4Zl6Qwm78coTMFOVBn/juo5jUmYkYmL0R
 Lea3GYdnAbChnteWrOQI+WgzwxieHxcZtwlk/27rYgi/ndHeGIa6VJQWmz2VbCxmtG
 8GkDGKPklncAw==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Date: Thu,  6 Jun 2024 17:55:51 +0800
Message-Id: <20240606095551.4089055-1-chao@kernel.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
X-Headers-End: 1sF9qo-0004gL-IB
Subject: [f2fs-dev] [PATCH] f2fs: remove redundant sanity check in
 sanity_check_inode()
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

Commit f240d3aaf5a1 ("f2fs: do more sanity check on inode") missed
to remove redundant sanity check on flexible_inline_xattr flag, fix
it.

Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/inode.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
index 87982e06bbe7..a3456b29b5ff 100644
--- a/fs/f2fs/inode.c
+++ b/fs/f2fs/inode.c
@@ -312,10 +312,6 @@ static bool sanity_check_inode(struct inode *inode, struct page *node_page)
 			if (!sanity_check_compress_inode(inode, ri))
 				return false;
 		}
-	} else if (f2fs_sb_has_flexible_inline_xattr(sbi)) {
-		f2fs_warn(sbi, "%s: corrupted inode ino=%lx, run fsck to fix.",
-			  __func__, inode->i_ino);
-		return false;
 	}
 
 	if (!f2fs_sb_has_extra_attr(sbi)) {
-- 
2.40.1



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
