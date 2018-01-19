From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH] fsck.f2fs: avoid quota fix causing roll-forward
 drop
Date: Thu, 18 Jan 2018 22:31:10 -0800
Message-ID: <20180119063110.1952-1-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.192]
 helo=mx.sourceforge.net)
 by sfs-ml-1.v29.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 (envelope-from <jaegeuk@kernel.org>) id 1ecQCs-0005ZX-M0
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 19 Jan 2018 06:31:18 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-2.v28.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 id 1ecQCr-0000ww-V4
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 19 Jan 2018 06:31:18 +0000
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>

If we write checkpoint, we'll drop roll-forward recovery, since crc in
checkpoint will be changed. Let's avoid it as much as possible.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fsck/fsck.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/fsck/fsck.c b/fsck/fsck.c
index 1211729..ebd21d0 100644
--- a/fsck/fsck.c
+++ b/fsck/fsck.c
@@ -1690,12 +1690,10 @@ int fsck_chk_quota_files(struct f2fs_sb_info *sbi)
 							qtype, ino);
 			f2fs_filesize_update(sbi, ino, 0);
 			ret = quota_write_inode(sbi, qtype);
-			if (!ret) {
-				c.bug_on = 1;
+			if (!ret)
 				DBG(1, "OK\n");
-			} else {
+			else
 				ASSERT_MSG("Unable to write quota file");
-			}
 		} else {
 			ASSERT_MSG("Quota file is missing or invalid"
 					" quota file content found.");
-- 
2.15.0.531.g2ccb3012c9-goog


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
