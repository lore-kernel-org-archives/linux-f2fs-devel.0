From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 01/10] f2fs: fix negative value for lseek offset
Date: Sun, 14 Sep 2014 15:14:15 -0700
Message-ID: <1410732864-53069-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1XTI3z-0008Th-4G
	for linux-f2fs-devel@lists.sourceforge.net;
	Sun, 14 Sep 2014 22:14:31 +0000
Received: from mail.kernel.org ([198.145.19.201])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1XTI3x-0001vp-Sd for linux-f2fs-devel@lists.sourceforge.net;
	Sun, 14 Sep 2014 22:14:31 +0000
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

If application throws negative value of lseek with SEEK_DATA|SEEK_HOLE,
previous f2fs went into BUG_ON in get_dnode_of_data, which was reported
by Tommi Rantala.

He could make a simple code to detect this having:
	lseek(fd, -17595150933902LL, SEEK_DATA);

This patch should resolve that bug.

Reported-by: Tommi Rentala <tt.rantala@gmail.com>
[Jaegeuk Kim: relocate the condition as suggested by Chao]
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/file.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 9f0ea3d..5cde363 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -353,6 +353,8 @@ static loff_t f2fs_llseek(struct file *file, loff_t offset, int whence)
 						maxbytes, i_size_read(inode));
 	case SEEK_DATA:
 	case SEEK_HOLE:
+		if (offset < 0)
+			return -ENXIO;
 		return f2fs_seek_block(file, offset, whence);
 	}
 
-- 
1.8.5.2 (Apple Git-48)


------------------------------------------------------------------------------
Want excitement?
Manually upgrade your production database.
When you want reliability, choose Perforce
Perforce version control. Predictably reliable.
http://pubads.g.doubleclick.net/gampad/clk?id=157508191&iu=/4140/ostg.clktrk
