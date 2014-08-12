From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 11/13] f2fs: unlock_page when node page is
	redirtied out
Date: Tue, 12 Aug 2014 12:49:25 -0700
Message-ID: <1407872967-26423-11-git-send-email-jaegeuk@kernel.org>
References: <1407872967-26423-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1XHI4o-0007RI-T3
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 12 Aug 2014 19:49:46 +0000
Received: from mail.kernel.org ([198.145.19.201])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1XHI4m-0003Tt-M4 for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 12 Aug 2014 19:49:46 +0000
In-Reply-To: <1407872967-26423-1-git-send-email-jaegeuk@kernel.org>
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

This patch fixes missing unlock_page when a node page is redirtied out.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/node.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index c80e3d5..9f126f8 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1129,8 +1129,11 @@ continue_unlock:
 				set_fsync_mark(page, 0);
 				set_dentry_mark(page, 0);
 			}
-			NODE_MAPPING(sbi)->a_ops->writepage(page, wbc);
-			wrote++;
+
+			if (NODE_MAPPING(sbi)->a_ops->writepage(page, wbc))
+				unlock_page(page);
+			else
+				wrote++;
 
 			if (--wbc->nr_to_write == 0)
 				break;
-- 
1.8.5.2 (Apple Git-48)


------------------------------------------------------------------------------
