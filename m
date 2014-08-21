From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH] f2fs: remove rename and use rename2
Date: Thu, 21 Aug 2014 13:46:39 -0700
Message-ID: <1408653999-86902-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1XKZFu-00047C-84
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 21 Aug 2014 20:46:46 +0000
Received: from mail.kernel.org ([198.145.19.201])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1XKZFs-000149-EG for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 21 Aug 2014 20:46:45 +0000
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

Refer the following patch.

commit 7177a9c4b509eb357cc450256bc3cf39f1a1e639
Author: Miklos Szeredi <mszeredi@suse.cz>
Date:   Wed Jul 23 15:15:30 2014 +0200

    fs: call rename2 if exists

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/namei.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
index eb407d2..6b53ce9 100644
--- a/fs/f2fs/namei.c
+++ b/fs/f2fs/namei.c
@@ -704,7 +704,6 @@ const struct inode_operations f2fs_dir_inode_operations = {
 	.mkdir		= f2fs_mkdir,
 	.rmdir		= f2fs_rmdir,
 	.mknod		= f2fs_mknod,
-	.rename		= f2fs_rename,
 	.rename2	= f2fs_rename2,
 	.tmpfile	= f2fs_tmpfile,
 	.getattr	= f2fs_getattr,
-- 
1.8.5.2 (Apple Git-48)


------------------------------------------------------------------------------
Slashdot TV.  
Video for Nerds.  Stuff that matters.
http://tv.slashdot.org/
