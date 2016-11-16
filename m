From: Yunlei He <heyunlei@huawei.com>
Subject: [PATCH] f2fs: fix an infinite loop when flush nodes in cp
Date: Wed, 16 Nov 2016 17:26:24 +0800
Message-ID: <20161116092624.17893-1-heyunlei@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <heyunlei@huawei.com>) id 1c6wO8-0000RK-0y
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 16 Nov 2016 09:20:16 +0000
Received: from szxga02-in.huawei.com ([119.145.14.65])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1c6wO4-00053a-HR
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 16 Nov 2016 09:20:16 +0000
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: linux-f2fs-devel@lists.sourceforge.net, jaegeuk@kernel.org, yuchao0@huawei.com
Cc: heyunlei@huwei.com

Thread A			Thread B

- write_checkpoint
 - block_operations
   -blk_start_plug
    -sync_node_pages		- f2fs_do_sync_file
				 - fsync_node_pages
				  - f2fs_wait_on_page_writeback

Thread A wait for global F2FS_DIRTY_NODES decreased to zero,
it start a plug list, some requests have been added to this list.
Thread B lock one dirty node page, and wait this page write back.
But this page has been in plug list of thread A with PG_writeback flag.
Thread A keep on running and its plug list has no chance to finish,
so it seems a deadlock between cp and fsync path.

This patch add a wait on page write back before set node page dirty
to avoid this problem.

Signed-off-by: Yunlei He <heyunlei@huawei.com>
Signed-off-by: Pengyang Hou <houpengyang@huawei.com>
---
 fs/f2fs/node.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 38cc07d..1de25f8 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1410,6 +1410,7 @@ int fsync_node_pages(struct f2fs_sb_info *sbi, struct inode *inode,
 			"Retry to write fsync mark: ino=%u, idx=%lx",
 					ino, last_page->index);
 		lock_page(last_page);
+		f2fs_wait_on_page_writeback(last_page, NODE, true);
 		set_page_dirty(last_page);
 		unlock_page(last_page);
 		goto retry;
-- 
2.10.1


------------------------------------------------------------------------------
