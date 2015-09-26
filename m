From: Nicholas Krause <xerofoify@gmail.com>
Subject: [PATCH RESEND #2] f2fs:Fix incorrect return statement in
	the function f2fs_ioc_release_volatile_write
Date: Sat, 26 Sep 2015 09:37:51 -0400
Message-ID: <1443274671-18077-1-git-send-email-xerofoify@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <xerofoify@gmail.com>) id 1Zfpfu-000726-GY
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 26 Sep 2015 13:38:02 +0000
Received: from mail-ig0-f182.google.com ([209.85.213.182])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1Zfpfs-0000vn-Pm
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 26 Sep 2015 13:38:02 +0000
Received: by igcpb10 with SMTP id pb10so29117548igc.1
	for <linux-f2fs-devel@lists.sourceforge.net>;
	Sat, 26 Sep 2015 06:37:55 -0700 (PDT)
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
Reviewed-by: Chao Yu <chao2.yu@samsung.com>
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
