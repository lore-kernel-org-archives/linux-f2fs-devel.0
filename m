Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30F73C25B76
	for <linux-f2fs-devel@archiver.kernel.org>; Wed,  5 Jun 2024 11:49:44 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1sEp9C-0007YZ-OJ;
	Wed, 05 Jun 2024 11:49:43 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <sashal@kernel.org>) id 1sEp9B-0007YM-7R
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 05 Jun 2024 11:49:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=GA3slw7kWtvld+OYaJ8ay7jfXpeXoUfx0sdJ1f3uDpU=; b=CcoF7s0OQ1ISWHPb8bFMIqvcdw
 AhyOACPqt0OF9d7AJwK0xShmSWzLm/fzr0P9XyLsHD7mnZntaWFD6YD53FJJeGvfKMwGZnRv9jYM0
 QQCXjDfKw9/+vRxuCHbHxqLaAn3TGAQD4ystoKwxV19hAMu+f8j6i0fFhPcwU2WEwCjw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=GA3slw7kWtvld+OYaJ8ay7jfXpeXoUfx0sdJ1f3uDpU=; b=kg328u0TqkJBc9FMfKDf+4bquo
 zbX2M6l8ne+mjPxt7jHIJuh4o03hc4U3BtQeRSB7zYCGh03y/1Q3vYy6Rh7j+KBSB+fSOthdqsN8G
 /NeTHbArKDeDJ5CIT3MMUE93RnhyAYCu37SB3nblmu4fNjau9e0kuPImj5xBKUhgMX7Y=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1sEp9B-00089r-Kr for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 05 Jun 2024 11:49:41 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 8733E6185C;
 Wed,  5 Jun 2024 11:49:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89EE0C4AF07;
 Wed,  5 Jun 2024 11:49:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1717588170;
 bh=uPCGWMeOdnY4K7O2ka/QvfwHXB9VtLOgHdRbGb7d3jE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=rgPBKgiEN7JPQE+zsi7S2hEqHcAIexlICgl02jXyem8/9EWEDD2DzeyHhKJZ9/veI
 7AkBc5p5Q3hsCBQcb8iddPX81z89CSKQ9oRxl1OtwE9eG30xainPJTaa0CO6QuJqiW
 Y7/fgd4HsxZLxHDffkhPXFC6FS5SIW2rIP3kmFJokE+0bhaBhz70xFG90Kjdg7atEu
 ekOSREN8hZXn5Tayro583kO9TjqMpzPdrcSfUF3tNJf6Qj6+n3Nx2GE2ppdEqURHMo
 DH4tuy5yP2xP1pL+MZHf1STS0uZZ7KcPAOyJxI9tuVUUmz7SG2K5To8khRDKFqGUf3
 Vb9Iotk1+AB5w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Date: Wed,  5 Jun 2024 07:48:31 -0400
Message-ID: <20240605114927.2961639-2-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240605114927.2961639-1-sashal@kernel.org>
References: <20240605114927.2961639-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.9.3
X-Headers-End: 1sEp9B-00089r-Kr
Subject: [f2fs-dev] [PATCH AUTOSEL 6.9 02/28] f2fs: fix to detect
 inconsistent nat entry during truncation
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
Cc: Sasha Levin <sashal@kernel.org>, Jaegeuk Kim <jaegeuk@kernel.org>,
 linux-f2fs-devel@lists.sourceforge.net, Roman Smirnov <r.smirnov@omp.ru>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

From: Chao Yu <chao@kernel.org>

[ Upstream commit 92c556ed6318e13c16746495a8d4513129eb9b0f ]

As Roman Smirnov reported as below:

"
There is a possible bug in f2fs_truncate_inode_blocks():

    if (err < 0 && err != -ENOENT)
    			goto fail;
        ...
        offset[1] = 0;
        offset[0]++;
        nofs += err;

If err = -ENOENT then nofs will sum with an error code,
which is strange behaviour. Also if nofs < ENOENT this will
cause an overflow. err will be equal to -ENOENT with the
following call stack:

truncate_nodes()
  f2fs_get_node_page()
     __get_node_page()
        read_node_page()
"

If nat is corrupted, truncate_nodes() may return -ENOENT, and
f2fs_truncate_inode_blocks() doesn't handle such error correctly,
fix it.

Reported-by: Roman Smirnov <r.smirnov@omp.ru>
Closes: https://lore.kernel.org/linux-f2fs-devel/085b27fd2b364a3c8c3a9ca77363e246@omp.ru
Signed-off-by: Chao Yu <chao@kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/node.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index b3de6d6cdb021..bb57bbaff7b4f 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1187,7 +1187,17 @@ int f2fs_truncate_inode_blocks(struct inode *inode, pgoff_t from)
 		default:
 			BUG();
 		}
-		if (err < 0 && err != -ENOENT)
+		if (err == -ENOENT) {
+			set_sbi_flag(F2FS_P_SB(page), SBI_NEED_FSCK);
+			f2fs_handle_error(sbi, ERROR_INVALID_BLKADDR);
+			f2fs_err_ratelimited(sbi,
+				"truncate node fail, ino:%lu, nid:%u, "
+				"offset[0]:%d, offset[1]:%d, nofs:%d",
+				inode->i_ino, dn.nid, offset[0],
+				offset[1], nofs);
+			err = 0;
+		}
+		if (err < 0)
 			goto fail;
 		if (offset[1] == 0 &&
 				ri->i_nid[offset[0] - NODE_DIR1_BLOCK]) {
-- 
2.43.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
