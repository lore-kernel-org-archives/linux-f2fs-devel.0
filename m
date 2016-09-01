From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH] f2fs: check free_sections for defragmentation
Date: Thu,  1 Sep 2016 13:46:05 -0700
Message-ID: <20160901204605.21448-1-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1bfYsK-0001zp-DD
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 01 Sep 2016 20:46:16 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1bfYsJ-0000Uo-De
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 01 Sep 2016 20:46:16 +0000
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

Fix wrong condition check for defragmentation of a file.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/file.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 37c24be..a8aa6fd 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -2037,7 +2037,7 @@ static int f2fs_defragment_range(struct f2fs_sb_info *sbi,
 	 * avoid defragment running in SSR mode when free section are allocated
 	 * intensively
 	 */
-	if (has_not_enough_free_secs(sbi, sec_num)) {
+	if (free_sections(sbi) <= sec_num) {
 		err = -EAGAIN;
 		goto out;
 	}
-- 
2.8.3


------------------------------------------------------------------------------
