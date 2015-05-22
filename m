From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 2/3] f2fs crypto: use bounce pages from mempool
	first
Date: Thu, 21 May 2015 17:40:24 -0700
Message-ID: <1432255225-76792-2-git-send-email-jaegeuk@kernel.org>
References: <1432255225-76792-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1Yvb1H-0005l1-Ig
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 22 May 2015 00:40:59 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1Yvb1G-0002Fd-Ng for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 22 May 2015 00:40:59 +0000
In-Reply-To: <1432255225-76792-1-git-send-email-jaegeuk@kernel.org>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>

If a lot of write streams are triggered, alloc_page and __free_page are
costly called, resulting in high memory pressure.

In order to avoid that, let's reuse mempool pages for writeback pages.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/crypto.c | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/fs/f2fs/crypto.c b/fs/f2fs/crypto.c
index 2c7819a..2ceee68 100644
--- a/fs/f2fs/crypto.c
+++ b/fs/f2fs/crypto.c
@@ -408,20 +408,12 @@ struct page *f2fs_encrypt(struct inode *inode,
 		return (struct page *)ctx;
 
 	/* The encryption operation will require a bounce page. */
-	ciphertext_page = alloc_page(GFP_NOFS);
+	ciphertext_page = mempool_alloc(f2fs_bounce_page_pool, GFP_NOFS);
 	if (!ciphertext_page) {
-		/*
-		 * This is a potential bottleneck, but at least we'll have
-		 * forward progress.
-		 */
-		ciphertext_page = mempool_alloc(f2fs_bounce_page_pool,
-							GFP_NOFS);
-		if (WARN_ON_ONCE(!ciphertext_page))
-			ciphertext_page = mempool_alloc(f2fs_bounce_page_pool,
-						GFP_NOFS | __GFP_WAIT);
-		ctx->flags &= ~F2FS_BOUNCE_PAGE_REQUIRES_FREE_ENCRYPT_FL;
-	} else {
+		ciphertext_page = alloc_page(GFP_NOFS);
 		ctx->flags |= F2FS_BOUNCE_PAGE_REQUIRES_FREE_ENCRYPT_FL;
+	} else {
+		ctx->flags &= ~F2FS_BOUNCE_PAGE_REQUIRES_FREE_ENCRYPT_FL;
 	}
 	ctx->flags |= F2FS_WRITE_PATH_FL;
 	ctx->w.bounce_page = ciphertext_page;
-- 
2.1.1


------------------------------------------------------------------------------
One dashboard for servers and applications across Physical-Virtual-Cloud 
Widest out-of-the-box monitoring support with 50+ applications
Performance metrics, stats and reports that give you Actionable Insights
Deep dive visibility with transaction tracing using APM Insight.
http://ad.doubleclick.net/ddm/clk/290420510;117567292;y
