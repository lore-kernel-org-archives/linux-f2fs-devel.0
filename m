From: Jeff Layton <jlayton@kernel.org>
Subject: [PATCH] f2fs: don't bother with inode->i_version
Date: Mon, 30 Oct 2017 11:11:56 -0400
Message-ID: <20171030151156.6418-1-jlayton@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
 helo=mx.sourceforge.net)
 by sfs-ml-4.v29.ch3.sourceforge.com with esmtps (TLSv1:DHE-RSA-AES256-SHA:256)
 (Exim 4.89) (envelope-from <jlayton@kernel.org>) id 1e9BjW-00042B-1f
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 30 Oct 2017 15:12:10 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
 (Exim 4.76) id 1e9BjQ-0007du-9E
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 30 Oct 2017 15:12:09 +0000
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: jaegeuk@kernel.org, yuchao0@huawei.com
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

From: Jeff Layton <jlayton@redhat.com>

f2fs does not set the SB_I_VERSION flag, so the i_version will never
be incremented on write. It was recently changed to increment the
i_version on a quota write, which isn't necessary here.

Signed-off-by: Jeff Layton <jlayton@redhat.com>
---
 fs/f2fs/super.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 933c3d529e65..b3359158e7be 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -618,7 +618,6 @@ static struct inode *f2fs_alloc_inode(struct super_block *sb)
 	init_once((void *) fi);
 
 	/* Initialize f2fs-specific inode info */
-	fi->vfs_inode.i_version = 1;
 	atomic_set(&fi->dirty_pages, 0);
 	fi->i_current_depth = 1;
 	fi->i_advise = 0;
@@ -1386,7 +1385,6 @@ static ssize_t f2fs_quota_write(struct super_block *sb, int type,
 
 	if (len == towrite)
 		return 0;
-	inode->i_version++;
 	inode->i_mtime = inode->i_ctime = current_time(inode);
 	f2fs_mark_inode_dirty_sync(inode, false);
 	return len - towrite;
-- 
2.13.6


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
