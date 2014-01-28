From: Jaegeuk Kim <jaegeuk.kim@samsung.com>
Subject: [PATCH 3/4] f2fs: fix to recover xattr node block
Date: Tue, 28 Jan 2014 14:54:06 +0900
Message-ID: <1390888447-5258-3-git-send-email-jaegeuk.kim@samsung.com>
References: <1390888447-5258-1-git-send-email-jaegeuk.kim@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk.kim@samsung.com>) id 1W81eG-0001Wy-0R
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 28 Jan 2014 05:55:48 +0000
Received: from mailout4.samsung.com ([203.254.224.34])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-MD5:128)
	(Exim 4.76) id 1W81eD-0006vz-Uj
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 28 Jan 2014 05:55:47 +0000
Received: from epcpsbgr3.samsung.com
	(u143.gpu120.samsung.co.kr [203.254.230.143])
	by mailout4.samsung.com (Oracle Communications Messaging Server
	7u4-24.01 (7.0.4.24.0) 64bit (built Nov 17 2011))
	with ESMTP id <0N0300EK3KGM9PC0@mailout4.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Tue, 28 Jan 2014 14:55:34 +0900 (KST)
In-reply-to: <1390888447-5258-1-git-send-email-jaegeuk.kim@samsung.com>
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

If a new xattr node page was allocated and its inode is fsynced, we should
recover the xattr node page during the roll-forward process after power-cut.
But, previously, f2fs didn't handle that case, resulting in kernel panic as
follows reported by Tom Li.

BUG: unable to handle kernel paging request at ffffc9001c861a98
IP: [<ffffffffa0295236>] check_index_in_prev_nodes+0x86/0x2d0 [f2fs]
Call Trace:
 [<ffffffff815ece9b>] ? printk+0x48/0x4a
 [<ffffffffa029626a>] recover_fsync_data+0xdca/0xf50 [f2fs]
 [<ffffffffa02873ae>] f2fs_fill_super+0x92e/0x970 [f2fs]
 [<ffffffff8112c9f8>] mount_bdev+0x1b8/0x200
 [<ffffffffa0286a80>] ? f2fs_remount+0x130/0x130 [f2fs]
 [<ffffffffa0285e40>] f2fs_mount+0x10/0x20 [f2fs]
 [<ffffffff8112d4de>] mount_fs+0x3e/0x1b0
 [<ffffffff810ef4eb>] ? __alloc_percpu+0xb/0x10
 [<ffffffff8114761f>] vfs_kern_mount+0x6f/0x120
 [<ffffffff811497b9>] do_mount+0x259/0xa90
 [<ffffffff810ead1d>] ? memdup_user+0x3d/0x80
 [<ffffffff810eadb3>] ? strndup_user+0x53/0x70
 [<ffffffff8114a2c9>] SyS_mount+0x89/0xd0
 [<ffffffff815feae2>] system_call_fastpath+0x16/0x1b

This patch adds a recovery function of xattr node pages.

Reported-by: Tom Li <biergaizi@members.fsf.org>
Signed-off-by: Jaegeuk Kim <jaegeuk.kim@samsung.com>
---
 fs/f2fs/f2fs.h     |  1 +
 fs/f2fs/node.c     | 40 ++++++++++++++++++++++++++++++++++++++++
 fs/f2fs/recovery.c |  3 +++
 3 files changed, 44 insertions(+)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 6e9515d..80a64fd 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1117,6 +1117,7 @@ void alloc_nid_done(struct f2fs_sb_info *, nid_t);
 void alloc_nid_failed(struct f2fs_sb_info *, nid_t);
 void recover_node_page(struct f2fs_sb_info *, struct page *,
 		struct f2fs_summary *, struct node_info *, block_t);
+bool recover_xattr_data(struct inode *, struct page *, block_t);
 int recover_inode_page(struct f2fs_sb_info *, struct page *);
 int restore_node_summary(struct f2fs_sb_info *, unsigned int,
 				struct f2fs_summary_block *);
diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index b0649b7..82f4753 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1535,6 +1535,46 @@ void recover_node_page(struct f2fs_sb_info *sbi, struct page *page,
 	clear_node_page_dirty(page);
 }
 
+bool recover_xattr_data(struct inode *inode, struct page *page, block_t blkaddr)
+{
+	struct f2fs_sb_info *sbi = F2FS_SB(inode->i_sb);
+	nid_t prev_xnid = F2FS_I(inode)->i_xattr_nid;
+	nid_t new_xnid = nid_of_node(page);
+	struct node_info ni;
+
+	if (ofs_of_node(page) != XATTR_NODE_OFFSET)
+		return false;
+
+	/* 1: invalidate the previous xattr nid */
+	if (!prev_xnid)
+		goto recover_xnid;
+
+	/* Deallocate node address */
+	get_node_info(sbi, prev_xnid, &ni);
+	f2fs_bug_on(ni.blk_addr == NULL_ADDR);
+	invalidate_blocks(sbi, ni.blk_addr);
+	dec_valid_node_count(sbi, inode);
+	set_node_addr(sbi, &ni, NULL_ADDR);
+
+recover_xnid:
+	/* 2: allocate new xattr nid */
+	if (unlikely(!inc_valid_node_count(sbi, inode)))
+		f2fs_bug_on(1);
+
+	remove_free_nid(NM_I(sbi), new_xnid);
+	get_node_info(sbi, new_xnid, &ni);
+	ni.ino = inode->i_ino;
+	set_node_addr(sbi, &ni, NEW_ADDR);
+	F2FS_I(inode)->i_xattr_nid = new_xnid;
+
+	/* 3: update xattr blkaddr */
+	refresh_sit_entry(sbi, NEW_ADDR, blkaddr);
+	set_node_addr(sbi, &ni, blkaddr);
+
+	update_inode_page(inode);
+	return true;
+}
+
 int recover_inode_page(struct f2fs_sb_info *sbi, struct page *page)
 {
 	struct f2fs_inode *src, *dst;
diff --git a/fs/f2fs/recovery.c b/fs/f2fs/recovery.c
index 976a7a9..f1b0b89 100644
--- a/fs/f2fs/recovery.c
+++ b/fs/f2fs/recovery.c
@@ -301,6 +301,9 @@ static int do_recover_data(struct f2fs_sb_info *sbi, struct inode *inode,
 	if (recover_inline_data(inode, page))
 		goto out;
 
+	if (recover_xattr_data(inode, page, blkaddr))
+		goto out;
+
 	start = start_bidx_of_node(ofs_of_node(page), fi);
 	if (IS_INODE(page))
 		end = start + ADDRS_PER_INODE(fi);
-- 
1.8.4.474.g128a96c


------------------------------------------------------------------------------
WatchGuard Dimension instantly turns raw network data into actionable 
security intelligence. It gives you real-time visual feedback on key
security issues and trends.  Skip the complicated setup - simply import
a virtual appliance and go from zero to informed in seconds.
http://pubads.g.doubleclick.net/gampad/clk?id=123612991&iu=/4140/ostg.clktrk
