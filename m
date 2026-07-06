Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E29AC43458
	for <linux-f2fs-devel@archiver.kernel.org>; Mon,  6 Jul 2026 10:00:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:Message-ID:Date:To:Sender:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=dCAfCcFtKibQnZLF7D7kIcYD4DzLbj/BYYDHj6+umuM=; b=lNXvAM1zSfGu68HwLwum8Y1V3J
	zM4IWmfSP8xBZBRI2DKJhGcmliRisKtraNKIdlz7zCvDxv1armnBBhpM9dsJgHXUL1k+WbMqRGv48
	g7DXkOCfPaZu/L+/xhAOHlhJaGqwKcXjMYIljbQn9brN2gxA9KMahjEY8QCAwn4MvZlU=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wgg7R-0001TO-Rl;
	Mon, 06 Jul 2026 10:00:05 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1wgg7Q-0001TG-BJ
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 06 Jul 2026 10:00:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=chjPuNCFQtUiE7OqGIJnm2ZFSRal0XTYbXylExYq4fo=; b=i0YXbZX/xiaPSfQhCpCiU+gYL0
 +wLD2IEvnd6q0stvtDLGBn9zb59xcPqaza5hp5LNrxmeevEhQSfyRSEdjWSyGYQcBMShePNJXryEg
 VPrEoj0J5i2JlrHm46nX180ZVYvYPp4GXMlj4cIYKd4aWtYVJSC5ikJfP3uY8IYjLBxI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=chjPuNCFQtUiE7OqGIJnm2ZFSRal0XTYbXylExYq4fo=; b=M
 sxTaeN+bfGY69cO1DH5s1wL5f2Dcar0b15eOOlpZrQpIGVd8tIDDHh+JF0XyBRq21lJJkAVIjuk6R
 9lyzdC2RDtBpcnswTBrX/yty2iYTRYvrsqWuOhy8C0r+xntHW73JhWPIp+hpLzBdgVnWgAx350DUL
 0jupsX0LRf6Hsp9k=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wgg7O-0005cc-1g for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 06 Jul 2026 10:00:04 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 38D0040A39;
 Mon,  6 Jul 2026 09:59:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF5E51F00A3D;
 Mon,  6 Jul 2026 09:59:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783331992;
 bh=chjPuNCFQtUiE7OqGIJnm2ZFSRal0XTYbXylExYq4fo=;
 h=From:To:Cc:Subject:Date;
 b=o0672R1m+PN640PWaZ3WGV0QHFpLyyiLlYFGvglbB6O+fpJ0TBx+LXrXhsM/uW+zw
 o3ddwvf+OBYwG9cS00B9UThKtVN/gVxJTyimFG8+c4IIu3K+hwkEt4CsiLZiI3MxRJ
 uo15vLe0ZJ10Kk89PjEtPlPbAfWs9fxH6r+wWIjKQMyzd1t8JBuZmYPrYV2yY6AAcc
 HwSPTCKW0S9g71Um9H9lVX3GupRgZupQzRGdPGrCVWb61sU6N1vyxDpFTVPOdDCkV6
 RlzN6CtUb4uEdkW2Zp5XMXjjYh5VSircD2ZYrTBkYZZuztptyfuXkBPoO1HLbqouj6
 +4i/YdyHNbp0w==
To: jaegeuk@kernel.org
Date: Mon,  6 Jul 2026 17:59:42 +0800
Message-ID: <20260706095943.2560208-1-chao@kernel.org>
X-Mailer: git-send-email 2.55.0.rc2.803.g1fd1e6609c-goog
MIME-Version: 1.0
X-Headers-End: 1wgg7O-0005cc-1g
Subject: [f2fs-dev] [PATCH 1/2] f2fs: quota: do not use GFP_NOFS in
 f2fs_quota_read()
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
From: Chao Yu via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Chao Yu <chao@kernel.org>
Cc: Jan Kara <jack@suse.cz>, linux-kernel@vger.kernel.org,
 Matthew Wilcox <willy@infradead.org>, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Commit 02117b8ae9c0 ("f2fs: Set GF_NOFS in read_cache_page_gfp while doing
f2fs_quota_read") adds GFP_NOFS in f2fs_quota_read() to avoid below deadlock:

- do_sys_open
 - vfs_open
  - dquot_file_open
   - dquot_initialize
    - dqget
     - dquot_acquire
      : locks &dqopt->dqio_mutex (VFS Quota Mutex)
      - qtree_read_dquot
       - f2fs_quota_read
        - read_mapping_page (GFP_KERNEL / allows GFP_FS)
         - __alloc_pages_nodemask
          - try_to_free_pages (Direct Reclaim)
           - prune_icache_sb
            - evict
             - f2fs_evict_inode
              - dquot_drop
               - dqput
                - dquot_commit
                 : tries to lock &dqopt->dqio_mutex again
                 ==> DEADLOCK (waiting for itself)

As Jan Kara mentioned, quota system has fixed this issue w/ commit
537e11cdc7a6 ("quota: Prevent memory allocation recursion while holding
dq_lock"), so this GFP_NOFS flag should be relic, let's drop it.

Cc: Jan Kara <jack@suse.cz>
Cc: Matthew Wilcox <willy@infradead.org>
Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/super.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index da468df058eb..fdfd6a7203dd 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -3167,8 +3167,7 @@ static ssize_t f2fs_quota_read(struct super_block *sb, int type, char *data,
 		size_t offset;
 
 repeat:
-		folio = mapping_read_folio_gfp(mapping, off >> PAGE_SHIFT,
-				GFP_NOFS);
+		folio = mapping_read_folio_gfp(mapping, off >> PAGE_SHIFT, 0);
 		if (IS_ERR(folio)) {
 			if (PTR_ERR(folio) == -ENOMEM) {
 				memalloc_retry_wait(GFP_NOFS);
-- 
2.49.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
