From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 3/3] f2fs: fix not to set fsync/dentry mark
Date: Wed, 12 Apr 2017 14:21:21 -0700
Message-ID: <20170412212121.17693-3-jaegeuk@kernel.org>
References: <20170412212121.17693-1-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1cyPhn-0007go-CX
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 12 Apr 2017 21:21:35 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1cyPhm-0002As-JU
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 12 Apr 2017 21:21:35 +0000
In-Reply-To: <20170412212121.17693-1-jaegeuk@kernel.org>
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

Otherwise, we can see stale fsync/dentry mark given by previous calls, resulting
in giving up roll-forward recovery due to wrong dentry mark.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/node.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 9422dd252813..ad54e907b97b 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1458,6 +1458,9 @@ int fsync_node_pages(struct f2fs_sb_info *sbi, struct inode *inode,
 			f2fs_wait_on_page_writeback(page, NODE, true);
 			BUG_ON(PageWriteback(page));
 
+			set_fsync_mark(page, 0);
+			set_dentry_mark(page, 0);
+
 			if (!atomic || page == last_page) {
 				set_fsync_mark(page, 1);
 				if (IS_INODE(page)) {
-- 
2.11.0


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
