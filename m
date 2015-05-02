From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 17/19] f2fs: revmove spin_lock for
	write_orphan_inodes
Date: Fri,  1 May 2015 17:48:44 -0700
Message-ID: <1430527726-68547-17-git-send-email-jaegeuk@kernel.org>
References: <1430527726-68547-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1YoLct-0003tZ-IJ
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 02 May 2015 00:49:51 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1YoLcs-0004To-Mi for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 02 May 2015 00:49:51 +0000
In-Reply-To: <1430527726-68547-1-git-send-email-jaegeuk@kernel.org>
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

This patch removes spin_lock, since this is covered by f2fs_lock_op already.
And, we should avoid to use page operations inside spin_lock.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/checkpoint.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index 6dbff2b..d076e7e 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -514,7 +514,12 @@ static void write_orphan_inodes(struct f2fs_sb_info *sbi, block_t start_blk)
 		grab_meta_page(sbi, start_blk + index);
 
 	index = 1;
-	spin_lock(&im->ino_lock);
+
+	/*
+	 * we don't need to do spin_lock(&im->ino_lock) here, since all the
+	 * orphan inode operations are covered under f2fs_lock_op().
+	 * And, spin_lock should be avoided due to page operations below.
+	 */
 	head = &im->ino_list;
 
 	/* loop for each orphan inode entry and write them in Jornal block */
@@ -554,8 +559,6 @@ static void write_orphan_inodes(struct f2fs_sb_info *sbi, block_t start_blk)
 		set_page_dirty(page);
 		f2fs_put_page(page, 1);
 	}
-
-	spin_unlock(&im->ino_lock);
 }
 
 static struct page *validate_checkpoint(struct f2fs_sb_info *sbi,
-- 
2.1.1


------------------------------------------------------------------------------
One dashboard for servers and applications across Physical-Virtual-Cloud 
Widest out-of-the-box monitoring support with 50+ applications
Performance metrics, stats and reports that give you Actionable Insights
Deep dive visibility with transaction tracing using APM Insight.
http://ad.doubleclick.net/ddm/clk/290420510;117567292;y
