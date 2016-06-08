From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 6/7] f2fs: fix deadlock in add_link failure
Date: Wed,  8 Jun 2016 10:24:43 -0700
Message-ID: <20160608172444.60371-6-jaegeuk@kernel.org>
References: <20160608172444.60371-1-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1bAhDx-0007kB-5W
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 08 Jun 2016 17:25:01 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1bAhDw-0006c3-GS
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 08 Jun 2016 17:25:01 +0000
In-Reply-To: <20160608172444.60371-1-jaegeuk@kernel.org>
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

mkdir                        sync_dirty_inode
 - init_inode_metadata
   - lock_page(node)
   - make_empty_dir
                             - filemap_fdatawrite()
                              - do_writepages
                              - lock_page(data)
                              - write_page(data)
                               - lock_page(node)
   - f2fs_init_acl
    - error
   - truncate_inode_pages
    - lock_page(data)

So, we don't need to truncate data pages in this error case, which will
be done by f2fs_evict_inode.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/dir.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
index f6ab3c2..4864824 100644
--- a/fs/f2fs/dir.c
+++ b/fs/f2fs/dir.c
@@ -450,9 +450,6 @@ struct page *init_inode_metadata(struct inode *inode, struct inode *dir,
 	return page;
 
 put_error:
-	/* truncate empty dir pages */
-	truncate_inode_pages(&inode->i_data, 0);
-
 	clear_nlink(inode);
 	update_inode(inode, page);
 	f2fs_put_page(page, 1);
-- 
2.8.3


------------------------------------------------------------------------------
What NetFlow Analyzer can do for you? Monitors network bandwidth and traffic
patterns at an interface-level. Reveals which users, apps, and protocols are 
consuming the most bandwidth. Provides multi-vendor support for NetFlow, 
J-Flow, sFlow and other flows. Make informed decisions using capacity 
planning reports. https://ad.doubleclick.net/ddm/clk/305295220;132659582;e
