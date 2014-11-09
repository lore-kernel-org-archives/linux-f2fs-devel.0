From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 1/5] f2fs: disable roll-forward when active_logs
	= 2
Date: Sat,  8 Nov 2014 23:36:05 -0800
Message-ID: <1415518569-20626-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1XnN2p-0001tv-FX
	for linux-f2fs-devel@lists.sourceforge.net;
	Sun, 09 Nov 2014 07:36:19 +0000
Received: from mail.kernel.org ([198.145.19.201])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1XnN2o-0002tV-8A for linux-f2fs-devel@lists.sourceforge.net;
	Sun, 09 Nov 2014 07:36:19 +0000
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

The roll-forward mechanism should be activated when the number of active
logs is not 2.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/file.c    | 2 ++
 fs/f2fs/segment.c | 4 ++--
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 46311e7..54722a0 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -132,6 +132,8 @@ static inline bool need_do_checkpoint(struct inode *inode)
 		need_cp = true;
 	else if (test_opt(sbi, FASTBOOT))
 		need_cp = true;
+	else if (sbi->active_logs == 2)
+		need_cp = true;
 
 	return need_cp;
 }
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 2fb3d7f..16721b5d 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -1090,8 +1090,8 @@ static int __get_segment_type_4(struct page *page, enum page_type p_type)
 		else
 			return CURSEG_COLD_DATA;
 	} else {
-		if (IS_DNODE(page) && !is_cold_node(page))
-			return CURSEG_HOT_NODE;
+		if (IS_DNODE(page) && is_cold_node(page))
+			return CURSEG_WARM_NODE;
 		else
 			return CURSEG_COLD_NODE;
 	}
-- 
2.1.1


------------------------------------------------------------------------------
