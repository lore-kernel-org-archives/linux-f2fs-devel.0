From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH] f2fs: declare missing static function
Date: Mon, 30 Jan 2017 15:19:13 -0800
Message-ID: <20170130231913.1286-1-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1cYLEJ-0005dd-O6
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 30 Jan 2017 23:19:23 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1cYLEH-00047h-Rc
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 30 Jan 2017 23:19:23 +0000
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

We missed two functions declared as static functions.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/segment.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index ebe635621e60..3f56f709012a 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -1040,7 +1040,7 @@ void clear_prefree_segments(struct f2fs_sb_info *sbi, struct cp_control *cpc)
 	}
 }
 
-int create_discard_cmd_control(struct f2fs_sb_info *sbi)
+static int create_discard_cmd_control(struct f2fs_sb_info *sbi)
 {
 	dev_t dev = sbi->sb->s_bdev->bd_dev;
 	struct discard_cmd_control *dcc;
@@ -1077,7 +1077,7 @@ int create_discard_cmd_control(struct f2fs_sb_info *sbi)
 	return err;
 }
 
-void destroy_discard_cmd_control(struct f2fs_sb_info *sbi, bool free)
+static void destroy_discard_cmd_control(struct f2fs_sb_info *sbi, bool free)
 {
 	struct discard_cmd_control *dcc = SM_I(sbi)->dcc_info;
 
-- 
2.11.0


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, SlashDot.org! http://sdm.link/slashdot
