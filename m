From: Gu Zheng <guz.fnst@cn.fujitsu.com>
Subject: [PATCH] f2fs: delete and free dirty dir freeing inode
 entry when sync dirty dir inodes
Date: Mon, 21 Oct 2013 15:19:16 +0800
Message-ID: <5264D574.6000105@cn.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <guz.fnst@cn.fujitsu.com>) id 1VYAPY-0002KV-FM
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 21 Oct 2013 08:00:24 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1VYAPX-0002Z4-5e for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 21 Oct 2013 08:00:24 +0000
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Kim <jaegeuk.kim@samsung.com>
Cc: fsdevel <linux-fsdevel@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, f2fs <linux-f2fs-devel@lists.sourceforge.net>

In sync_dirty_dir_inodes(), remove_dirty_dir_inode() will be called
in the callback of filemap_flush to delete and free dirty dir inode entry.
But for the freeing inode entry, missed this step after sbumit data bio,
and this may lead to a dead loop if these is freeing inode entry in
dir_inode_list. So add the delete and free step to fix it.

Signed-off-by: Gu Zheng <guz.fnst@cn.fujitsu.com>
---
 fs/f2fs/checkpoint.c |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index 8d16071..f61838f 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -600,7 +600,16 @@ retry:
 		 * wribacking dentry pages in the freeing inode.
 		 */
 		f2fs_submit_bio(sbi, DATA, true);
+
+		spin_lock(&sbi->dir_inode_lock);
+		list_del(&entry->list);
+#ifdef CONFIG_F2FS_STAT_FS
+		sbi->n_dirty_dirs--;
+#endif
+		spin_unlock(&sbi->dir_inode_lock);
+		kmem_cache_free(inode_entry_slab, entry);
 	}
+
 	goto retry;
 }
 
-- 
1.7.7


------------------------------------------------------------------------------
October Webinars: Code for Performance
Free Intel webinars can help you accelerate application performance.
Explore tips for MPI, OpenMP, advanced profiling, and more. Get the most from 
the latest Intel processors and coprocessors. See abstracts and register >
http://pubads.g.doubleclick.net/gampad/clk?id=60135031&iu=/4140/ostg.clktrk
