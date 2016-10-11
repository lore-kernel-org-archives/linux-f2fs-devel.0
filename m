From: Chao Yu <chao@kernel.org>
Subject: [PATCH 8/8] f2fs: fix error handling in fsync_node_pages
Date: Tue, 11 Oct 2016 22:57:06 +0800
Message-ID: <20161011145706.5028-8-chao@kernel.org>
References: <20161011145706.5028-1-chao@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chao@kernel.org>) id 1btyX0-00039s-0C
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 11 Oct 2016 14:59:50 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1btyWv-0005yu-1o
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 11 Oct 2016 14:59:49 +0000
In-Reply-To: <20161011145706.5028-1-chao@kernel.org>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: jaegeuk@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

From: Chao Yu <yuchao0@huawei.com>

In fsync_node_pages, if f2fs was taged with CP_ERROR_FLAG, make sure bio
cache was flushed before return.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/node.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 3a393e3..14f137d 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1339,7 +1339,8 @@ retry:
 			if (unlikely(f2fs_cp_error(sbi))) {
 				f2fs_put_page(last_page, 0);
 				pagevec_release(&pvec);
-				return -EIO;
+				ret = -EIO;
+				goto out;
 			}
 
 			if (!IS_DNODE(page) || !is_cold_node(page))
@@ -1412,7 +1413,7 @@ continue_unlock:
 		unlock_page(last_page);
 		goto retry;
 	}
-
+out:
 	if (nwritten)
 		f2fs_submit_merged_bio_cond(sbi, NULL, NULL, ino, NODE, WRITE);
 	return ret ? -EIO: 0;
-- 
2.10.1


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most 
engaging tech sites, SlashDot.org! http://sdm.link/slashdot
