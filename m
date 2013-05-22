From: Jaegeuk Kim <jaegeuk.kim@samsung.com>
Subject: [f2fs-dev] [PATCH 1/2] f2fs: reuse the locked dnode page and its
	inode
Date: Wed, 22 May 2013 09:13:31 +0900
Message-ID: <1369181612-15777-1-git-send-email-jaegeuk.kim@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk.kim@samsung.com>) id 1Uewhg-0001jY-R1
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 22 May 2013 00:14:52 +0000
Received: from mailout3.samsung.com ([203.254.224.33])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1Uewhe-00080p-Fz for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 22 May 2013 00:14:52 +0000
Received: from epcpsbgr1.samsung.com
	(u141.gpu120.samsung.co.kr [203.254.230.141])
	by mailout3.samsung.com (Oracle Communications Messaging Server
	7u4-24.01 (7.0.4.24.0) 64bit (built Nov 17 2011))
	with ESMTP id <0MN6008EFBC206J0@mailout3.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Wed, 22 May 2013 09:14:43 +0900 (KST)
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

This patch fixes the following deadlock bug during the recovery.

INFO: task mount:1322 blocked for more than 120 seconds.
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
mount           D ffffffff81125870     0  1322   1266 0x00000000
 ffff8801207e39d8 0000000000000046 ffff88012ab1dee0 0000000000000046
 ffff8801207e3a08 ffff880115903f40 ffff8801207e3fd8 ffff8801207e3fd8
 ffff8801207e3fd8 ffff880115903f40 ffff8801207e39d8 ffff88012fc94520
Call Trace:
[<ffffffff81125870>] ? __lock_page+0x70/0x70
[<ffffffff816a92d9>] schedule+0x29/0x70
[<ffffffff816a93af>] io_schedule+0x8f/0xd0
[<ffffffff8112587e>] sleep_on_page+0xe/0x20
[<ffffffff816a649a>] __wait_on_bit_lock+0x5a/0xc0
[<ffffffff81125867>] __lock_page+0x67/0x70
[<ffffffff8106c7b0>] ? autoremove_wake_function+0x40/0x40
[<ffffffff81126857>] find_lock_page+0x67/0x80
[<ffffffff8112698f>] find_or_create_page+0x3f/0xb0
[<ffffffffa03901a8>] ? sync_inode_page+0xa8/0xd0 [f2fs]
[<ffffffffa038fdf7>] get_node_page+0x67/0x180 [f2fs]
[<ffffffffa039818b>] recover_fsync_data+0xacb/0xff0 [f2fs]
[<ffffffff816aaa1e>] ? _raw_spin_unlock+0x3e/0x40
[<ffffffffa0389634>] f2fs_fill_super+0x7d4/0x850 [f2fs]
[<ffffffff81184cf9>] mount_bdev+0x1c9/0x210
[<ffffffffa0388e60>] ? validate_superblock+0x180/0x180 [f2fs]
[<ffffffffa0387635>] f2fs_mount+0x15/0x20 [f2fs]
[<ffffffff81185a13>] mount_fs+0x43/0x1b0
[<ffffffff81145ba0>] ? __alloc_percpu+0x10/0x20
[<ffffffff811a0796>] vfs_kern_mount+0x76/0x120
[<ffffffff811a2cb7>] do_mount+0x237/0xa10
[<ffffffff81140b9b>] ? strndup_user+0x5b/0x80
[<ffffffff811a3520>] SyS_mount+0x90/0xe0
[<ffffffff816b3502>] system_call_fastpath+0x16/0x1b

The bug is triggered when check_index_in_prev_nodes tries to get the direct
node page by calling get_node_page.
At this point, if the direct node page is already locked by get_dnode_of_data,
its caller, we got a deadlock condition.

This patch adds additional condition check for the reuse of locked direct node
pages prior to the get_node_page call.

Signed-off-by: Jaegeuk Kim <jaegeuk.kim@samsung.com>
---
 fs/f2fs/f2fs.h     |  1 +
 fs/f2fs/file.c     |  2 +-
 fs/f2fs/recovery.c | 26 +++++++++++++++++++++-----
 3 files changed, 23 insertions(+), 6 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 6594ce1..7b05029 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -900,6 +900,7 @@ void truncate_data_blocks(struct dnode_of_data *);
 void f2fs_truncate(struct inode *);
 int f2fs_setattr(struct dentry *, struct iattr *);
 int truncate_hole(struct inode *, pgoff_t, pgoff_t);
+int truncate_data_blocks_range(struct dnode_of_data *, int);
 long f2fs_ioctl(struct file *, unsigned int, unsigned long);
 long f2fs_compat_ioctl(struct file *, unsigned int, unsigned long);
 
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 316bcfe..deefd25 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -168,7 +168,7 @@ static int f2fs_file_mmap(struct file *file, struct vm_area_struct *vma)
 	return 0;
 }
 
-static int truncate_data_blocks_range(struct dnode_of_data *dn, int count)
+int truncate_data_blocks_range(struct dnode_of_data *dn, int count)
 {
 	int nr_free = 0, ofs = dn->ofs_in_node;
 	struct f2fs_sb_info *sbi = F2FS_SB(dn->inode->i_sb);
diff --git a/fs/f2fs/recovery.c b/fs/f2fs/recovery.c
index 5148d90..eceb665 100644
--- a/fs/f2fs/recovery.c
+++ b/fs/f2fs/recovery.c
@@ -189,14 +189,14 @@ static void destroy_fsync_dnodes(struct f2fs_sb_info *sbi,
 }
 
 static void check_index_in_prev_nodes(struct f2fs_sb_info *sbi,
-						block_t blkaddr)
+			block_t blkaddr, struct dnode_of_data *dn)
 {
 	struct seg_entry *sentry;
 	unsigned int segno = GET_SEGNO(sbi, blkaddr);
 	unsigned short blkoff = GET_SEGOFF_FROM_SEG0(sbi, blkaddr) &
 					(sbi->blocks_per_seg - 1);
 	struct f2fs_summary sum;
-	nid_t ino;
+	nid_t ino, nid;
 	void *kaddr;
 	struct inode *inode;
 	struct page *node_page;
@@ -224,10 +224,26 @@ static void check_index_in_prev_nodes(struct f2fs_sb_info *sbi,
 		f2fs_put_page(sum_page, 1);
 	}
 
+	/* Use the locked dnode page and inode */
+	nid = le32_to_cpu(sum.nid);
+	if (dn->inode->i_ino == nid) {
+		struct dnode_of_data tdn = *dn;
+		tdn.nid = nid;
+		tdn.node_page = dn->inode_page;
+		tdn.ofs_in_node = sum.ofs_in_node;
+		truncate_data_blocks_range(&tdn, 1);
+		return;
+	} else if (dn->nid == nid) {
+		struct dnode_of_data tdn = *dn;
+		tdn.ofs_in_node = sum.ofs_in_node;
+		truncate_data_blocks_range(&tdn, 1);
+		return;
+	}
+
 	/* Get the node page */
-	node_page = get_node_page(sbi, le32_to_cpu(sum.nid));
+	node_page = get_node_page(sbi, nid);
 	bidx = start_bidx_of_node(ofs_of_node(node_page)) +
-				le16_to_cpu(sum.ofs_in_node);
+					le16_to_cpu(sum.ofs_in_node);
 	ino = ino_of_node(node_page);
 	f2fs_put_page(node_page, 1);
 
@@ -285,7 +301,7 @@ static int do_recover_data(struct f2fs_sb_info *sbi, struct inode *inode,
 			}
 
 			/* Check the previous node page having this index */
-			check_index_in_prev_nodes(sbi, dest);
+			check_index_in_prev_nodes(sbi, dest, &dn);
 
 			set_summary(&sum, dn.nid, dn.ofs_in_node, ni.version);
 
-- 
1.8.1.3.566.gaa39828


------------------------------------------------------------------------------
Try New Relic Now & We'll Send You this Cool Shirt
New Relic is the only SaaS-based application performance monitoring service 
that delivers powerful full stack analytics. Optimize and monitor your
browser, app, & servers with just a few lines of code. Try New Relic
and get this awesome Nerd Life shirt! http://p.sf.net/sfu/newrelic_d2d_may
