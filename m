From: Jaegeuk Kim <jaegeuk.kim@samsung.com>
Subject: [f2fs-dev] [PATCH 1/3] f2fs: avoid RECLAIM_FS-ON-W: deadlock
Date: Tue, 21 May 2013 12:56:31 +0900
Message-ID: <1369108593-880-1-git-send-email-jaegeuk.kim@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk.kim@samsung.com>) id 1UediU-0002no-6U
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 21 May 2013 03:58:26 +0000
Received: from mailout4.samsung.com ([203.254.224.34])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1UediS-0008JB-DY for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 21 May 2013 03:58:26 +0000
Received: from epcpsbgr4.samsung.com
	(u144.gpu120.samsung.co.kr [203.254.230.144])
	by mailout4.samsung.com (Oracle Communications Messaging Server
	7u4-24.01 (7.0.4.24.0) 64bit (built Nov 17 2011))
	with ESMTP id <0MN400294R151BI0@mailout4.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Tue, 21 May 2013 12:58:17 +0900 (KST)
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

This patch tries to avoid the following deadlock condition of which the reclaim
path can trigger f2fs_balance_fs again.

=================================
[ INFO: inconsistent lock state ]
---------------------------------
inconsistent {RECLAIM_FS-ON-W} -> {IN-RECLAIM_FS-W} usage.
kswapd0/41 [HC0[0]:SC0[0]:HE1:SE1] takes:
 (&sbi->gc_mutex){+.+.?.}, at: f2fs_balance_fs+0xe6/0x100 [f2fs]
{RECLAIM_FS-ON-W} state was registered at:
  [<ffffffff810aa5a9>] mark_held_locks+0xb9/0x140
  [<ffffffff810aae85>] lockdep_trace_alloc+0x85/0xf0
  [<ffffffff8113ab2c>] __alloc_pages_nodemask+0x7c/0x9b0
  [<ffffffff81175aa8>] alloc_pages_current+0xb8/0x180
  [<ffffffff811319cf>] __page_cache_alloc+0xaf/0xd0
  [<ffffffff8113225c>] find_or_create_page+0x4c/0xb0
  [<ffffffffa021359e>] find_data_page+0x14e/0x210 [f2fs]
  [<ffffffffa021161b>] f2fs_gc+0x9eb/0xd90 [f2fs]
  [<ffffffffa0218fae>] f2fs_balance_fs+0xee/0x100 [f2fs]
  [<ffffffffa020848c>] f2fs_setattr+0x6c/0x200 [f2fs]
  [<ffffffff811ae51b>] notify_change+0x1db/0x3a0
  [<ffffffff8118fbd0>] do_truncate+0x60/0xa0
  [<ffffffff8118fd95>] vfs_truncate+0x185/0x1b0
  [<ffffffff8118fe1c>] do_sys_truncate+0x5c/0xa0
  [<ffffffff8118ffee>] SyS_truncate+0xe/0x10
  [<ffffffff816e2b42>] system_call_fastpath+0x16/0x1b

Signed-off-by: Jaegeuk Kim <jaegeuk.kim@samsung.com>
---
 fs/f2fs/data.c  | 4 ++--
 fs/f2fs/inode.c | 3 +--
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index c320f7f..1644fff 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -199,7 +199,7 @@ struct page *find_data_page(struct inode *inode, pgoff_t index, bool sync)
 	if (dn.data_blkaddr == NEW_ADDR)
 		return ERR_PTR(-EINVAL);
 
-	page = grab_cache_page(mapping, index);
+	page = grab_cache_page_write_begin(mapping, index, AOP_FLAG_NOFS);
 	if (!page)
 		return ERR_PTR(-ENOMEM);
 
@@ -234,7 +234,7 @@ struct page *get_lock_data_page(struct inode *inode, pgoff_t index)
 	int err;
 
 repeat:
-	page = grab_cache_page(mapping, index);
+	page = grab_cache_page_write_begin(mapping, index, AOP_FLAG_NOFS);
 	if (!page)
 		return ERR_PTR(-ENOMEM);
 
diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
index 91ac7f9..a18946e 100644
--- a/fs/f2fs/inode.c
+++ b/fs/f2fs/inode.c
@@ -130,8 +130,7 @@ make_now:
 		inode->i_op = &f2fs_dir_inode_operations;
 		inode->i_fop = &f2fs_dir_operations;
 		inode->i_mapping->a_ops = &f2fs_dblock_aops;
-		mapping_set_gfp_mask(inode->i_mapping, GFP_HIGHUSER_MOVABLE |
-				__GFP_ZERO);
+		mapping_set_gfp_mask(inode->i_mapping, GFP_F2FS_ZERO);
 	} else if (S_ISLNK(inode->i_mode)) {
 		inode->i_op = &f2fs_symlink_inode_operations;
 		inode->i_mapping->a_ops = &f2fs_dblock_aops;
-- 
1.8.1.3.566.gaa39828


------------------------------------------------------------------------------
Try New Relic Now & We'll Send You this Cool Shirt
New Relic is the only SaaS-based application performance monitoring service 
that delivers powerful full stack analytics. Optimize and monitor your
browser, app, & servers with just a few lines of code. Try New Relic
and get this awesome Nerd Life shirt! http://p.sf.net/sfu/newrelic_d2d_may
