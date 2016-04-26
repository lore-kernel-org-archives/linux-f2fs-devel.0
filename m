From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 4/7] f2fs: report unwritten status in
	fsync_node_pages
Date: Mon, 25 Apr 2016 17:06:57 -0700
Message-ID: <1461629220-16280-4-git-send-email-jaegeuk@kernel.org>
References: <1461629220-16280-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1auqWz-00052f-BM
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 26 Apr 2016 00:07:09 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1auqWy-0004mS-Jk
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 26 Apr 2016 00:07:09 +0000
In-Reply-To: <1461629220-16280-1-git-send-email-jaegeuk@kernel.org>
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

The fsync_node_pages should return pass or failure so that user could know
fsync is completed or not.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/file.c |  4 +++-
 fs/f2fs/node.c | 13 ++++++-------
 2 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 3d53ee0..60fd64c 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -256,7 +256,9 @@ go_write:
 		goto out;
 	}
 sync_nodes:
-	fsync_node_pages(sbi, ino, &wbc);
+	ret = fsync_node_pages(sbi, ino, &wbc);
+	if (ret)
+		goto out;
 
 	/* if cp_error was enabled, we should avoid infinite loop */
 	if (unlikely(f2fs_cp_error(sbi))) {
diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 675b730..8a1e211 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1227,7 +1227,7 @@ int fsync_node_pages(struct f2fs_sb_info *sbi, nid_t ino,
 {
 	pgoff_t index, end;
 	struct pagevec pvec;
-	int nwritten = 0;
+	int ret = 0;
 
 	pagevec_init(&pvec, 0);
 	index = 0;
@@ -1278,21 +1278,20 @@ continue_unlock:
 			if (IS_INODE(page))
 				set_dentry_mark(page,
 						need_dentry_mark(sbi, ino));
-			nwritten++;
 
-			if (NODE_MAPPING(sbi)->a_ops->writepage(page, wbc))
+			ret = NODE_MAPPING(sbi)->a_ops->writepage(page, wbc);
+			if (ret) {
 				unlock_page(page);
-
-			if (--wbc->nr_to_write == 0)
 				break;
+			}
 		}
 		pagevec_release(&pvec);
 		cond_resched();
 
-		if (wbc->nr_to_write == 0)
+		if (ret)
 			break;
 	}
-	return nwritten;
+	return ret ? -EIO: 0;
 }
 
 int sync_node_pages(struct f2fs_sb_info *sbi, struct writeback_control *wbc)
-- 
2.6.3


------------------------------------------------------------------------------
Find and fix application performance issues faster with Applications Manager
Applications Manager provides deep performance insights into multiple tiers of
your business applications. It resolves application problems quickly and
reduces your MTTR. Get your free trial!
https://ad.doubleclick.net/ddm/clk/302982198;130105516;z
