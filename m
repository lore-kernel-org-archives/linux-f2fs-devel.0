From: Nicholas Krause <xerofoify@gmail.com>
Subject: [PATCH RESEND] f2fs:Fix incorrect return statement in
	the function f2fs_ioc_release_volatile_write
Date: Sun,  6 Sep 2015 08:28:46 -0400
Message-ID: <1441542526-11916-1-git-send-email-xerofoify@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <xerofoify@gmail.com>) id 1ZYZ44-0002j1-DX
	for linux-f2fs-devel@lists.sourceforge.net;
	Sun, 06 Sep 2015 12:28:56 +0000
Received: from mail-io0-f169.google.com ([209.85.223.169])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1ZYZ43-0005sM-Ou
	for linux-f2fs-devel@lists.sourceforge.net;
	Sun, 06 Sep 2015 12:28:56 +0000
Received: by ioii196 with SMTP id i196so65070354ioi.3
	for <linux-f2fs-devel@lists.sourceforge.net>;
	Sun, 06 Sep 2015 05:28:50 -0700 (PDT)
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: jaegeuk@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

This fixes the incorrect return statement at the end of the function
f2fs_ioc_release_volatile_write's body for returning zero as this is
incorrect due to the function call before this return statement to
the function punch_hole being able to fail and we should return this
function's return fail directly in order to signal to callers of the
function f2fs_ioc_release_volatile if a failure arises with this call
to punch_hole fails.

Signed-off-by: Nicholas Krause <xerofoify@gmail.com>
---
 fs/f2fs/file.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index b0f38c3..ec323b4 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -1369,8 +1369,7 @@ static int f2fs_ioc_release_volatile_write(struct file *filp)
 	if (!f2fs_is_first_block_written(inode))
 		return truncate_partial_data_page(inode, 0, true);
 
-	punch_hole(inode, 0, F2FS_BLKSIZE);
-	return 0;
+	return punch_hole(inode, 0, F2FS_BLKSIZE);
 }
 
 static int f2fs_ioc_abort_volatile_write(struct file *filp)
-- 
2.1.4


------------------------------------------------------------------------------
