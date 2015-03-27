From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 1/6] fsck.f2fs: reduce redundant message
Date: Thu, 26 Mar 2015 17:03:04 -0700
Message-ID: <1427414589-66956-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1YbHkC-0005fG-FT
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 27 Mar 2015 00:03:24 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1YbHk9-0001s5-5l for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 27 Mar 2015 00:03:24 +0000
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>

This assert message is unnecessary to be shown, since caller shows the reason
already.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fsck/f2fs.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fsck/f2fs.h b/fsck/f2fs.h
index 709fbf3..e59bb0b 100644
--- a/fsck/f2fs.h
+++ b/fsck/f2fs.h
@@ -340,7 +340,7 @@ static inline bool IS_VALID_BLK_ADDR(struct f2fs_sb_info *sbi, u32 addr)
 
 	if (addr >= F2FS_RAW_SUPER(sbi)->block_count ||
 				addr < SM_I(sbi)->main_blkaddr) {
-		ASSERT_MSG("block addr [0x%x]\n", addr);
+		DBG(1, "block addr [0x%x]\n", addr);
 		return 0;
 	}
 
-- 
2.1.1


------------------------------------------------------------------------------
Dive into the World of Parallel Programming The Go Parallel Website, sponsored
by Intel and developed in partnership with Slashdot Media, is your hub for all
things parallel software development, from weekly thought leadership blogs to
news, videos, case studies, tutorials and more. Take a look and join the 
conversation now. http://goparallel.sourceforge.net/
