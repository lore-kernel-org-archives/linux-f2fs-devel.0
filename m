From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 2/3] f2fs: allocate hot_data for atomic writes
Date: Wed, 12 Apr 2017 14:21:20 -0700
Message-ID: <20170412212121.17693-2-jaegeuk@kernel.org>
References: <20170412212121.17693-1-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1cyPhl-0002Sl-7m
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 12 Apr 2017 21:21:33 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1cyPhk-00010D-KP
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 12 Apr 2017 21:21:33 +0000
In-Reply-To: <20170412212121.17693-1-jaegeuk@kernel.org>
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

We'd better allocate atomic writes to hot_data zone.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/file.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 4731eb587e06..0ac833dd2634 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -1531,6 +1531,7 @@ static int f2fs_ioc_start_atomic_write(struct file *filp)
 		goto out;
 
 	set_inode_flag(inode, FI_ATOMIC_FILE);
+	set_inode_flag(inode, FI_HOT_DATA);
 	f2fs_update_time(F2FS_I_SB(inode), REQ_TIME);
 
 	if (!get_dirty_pages(inode))
-- 
2.11.0


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
