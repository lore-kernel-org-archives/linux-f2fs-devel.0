Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8C7BC04FFE
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 26 Apr 2024 10:36:00 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1s0Ivs-00019V-Uw;
	Fri, 26 Apr 2024 10:35:57 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1s0Ivm-00019G-Sv
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 26 Apr 2024 10:35:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=u9hhjY3YKAJF7nmBSLYD68trt8R2hF2v9zotqINYWuQ=; b=Smw+6MJ55GGEJ+b64LS6vjBtpe
 4WOmIQrgi1kumzPBmSUUbWWW9LpA9nGEJpqZ40RQ4KHyU7zV/9in18hRELm7PooNfXpCrybYebozY
 jgz1bwaE5pcLvt+VLHJjAXN3L7jrCg9sYC7nDB9bX++g0PFZ1WTtn8ZNop47M54K6EEQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=u9hhjY3YKAJF7nmBSLYD68trt8R2hF2v9zotqINYWuQ=; b=J
 HPh8uEYux3F7/EmW/zKVrnaVNKYvBHzQ9JaLzEstUrb3bzO0ubRhQgldMTUZkU+GbwApooWWVcjpe
 4qj4bKza1JSmcPrULhm9FVom6nlNDR/R+A6fkbxnqVW1GDvvnOsjQezfvZcBFnMWqc7ezGU7ae++o
 xLqaE9xI+dgMqBEw=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1s0Ivl-0001xF-6e for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 26 Apr 2024 10:35:50 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 36A4862002;
 Fri, 26 Apr 2024 10:35:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13252C113CD;
 Fri, 26 Apr 2024 10:35:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1714127738;
 bh=1M11MRI5r8LFTEUJBIZWj9DEeQPtq9UkmPXJoyrFJjU=;
 h=From:To:Cc:Subject:Date:From;
 b=On42Bq5KFzRD58lKilMe0u76cR7Lb3kLZv3yFI8/dRcW/gGFClfpRsUzevcZVZNBZ
 zsbWa07OXKjttI4WUKybjCosSxNTxiz81HjVwR5jL22uF466Itlldl9ZoFA5rPvhFw
 s535rAYULOBpDgV9LKQDSi9V0vIdHvGGcRPqWx76luyPwOOSRcg7dyQDcq6Bm1/J6Z
 Xfq/0oPeWrixhzoWhwxR+xG+kYa3+IQODhMni99yh8KlFsdS3L1NHC0oPMjFwCX6eK
 5gVO4BLYPFFONM0jLI2pq90md2EXzC2lHOQAI0IgxWEQN0rK1R+MXMPtfzqQSr57Rm
 Hvi7an9EHuBXA==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Date: Fri, 26 Apr 2024 18:35:28 +0800
Message-Id: <20240426103528.406063-1-chao@kernel.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
X-Headers-End: 1s0Ivl-0001xF-6e
Subject: [f2fs-dev] [PATCH] f2fs: zone: fix to don't trigger OPU on pinfile
 for direct IO
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

Otherwise, it breaks pinfile's sematics.

Cc: Daeho Jeong <daeho43@gmail.com>
Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/data.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index bee1e45f76b8..e29000d83d52 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -1596,7 +1596,8 @@ int f2fs_map_blocks(struct inode *inode, struct f2fs_map_blocks *map, int flag)
 
 	/* use out-place-update for direct IO under LFS mode */
 	if (map->m_may_create &&
-	    (is_hole || (f2fs_lfs_mode(sbi) && flag == F2FS_GET_BLOCK_DIO))) {
+	    (is_hole || (flag == F2FS_GET_BLOCK_DIO && (f2fs_lfs_mode(sbi) &&
+	    (!f2fs_sb_has_blkzoned(sbi) || !f2fs_is_pinned_file(inode)))))) {
 		if (unlikely(f2fs_cp_error(sbi))) {
 			err = -EIO;
 			goto sync_out;
-- 
2.40.1



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
