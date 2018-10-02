From: Chao Yu <chao@kernel.org>
Subject: [PATCH] f2fs: fix to recover cold bit of inode block during POR
Date: Tue,  2 Oct 2018 11:13:24 +0800
Message-ID: <20181002031324.12517-1-chao@kernel.org>
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, Chao Yu <yuchao0@huawei.com>, stable@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

From: Chao Yu <yuchao0@huawei.com>

Testcase to reproduce this bug:
1. mkfs.f2fs /dev/sdd
2. mount -t f2fs /dev/sdd /mnt/f2fs
3. touch /mnt/f2fs/file
4. sync
5. chattr +A /mnt/f2fs/file
6. xfs_io -f /mnt/f2fs/file -c "fsync"
7. godown /mnt/f2fs
8. umount /mnt/f2fs
9. mount -t f2fs /dev/sdd /mnt/f2fs
10. chattr -A /mnt/f2fs/file
11. xfs_io -f /mnt/f2fs/file -c "fsync"
12. umount /mnt/f2fs
13. mount -t f2fs /dev/sdd /mnt/f2fs
14. lsattr /mnt/f2fs/file

-----------------N- /mnt/f2fs/file

But actually, we expect the corrct result is:

-------A---------N- /mnt/f2fs/file

The reason is in step 9) we missed to recover cold bit flag in inode
block, so later, in fsync, we will skip write inode block due to below
condition check, result in lossing data in another SPOR.

f2fs_fsync_node_pages()
	if (!IS_DNODE(page) || !is_cold_node(page))
		continue;

Note that, I guess that some non-dir inode has already lost cold bit
during POR, so in order to reenable recovery for those inode, let's
try to recover cold bit in f2fs_iget() to save more fsynced data.

Fixes: c56675750d7c ("f2fs: remove unneeded set_cold_node()")
Cc: <stable@vger.kernel.org> 4.17+
Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/inode.c | 4 ++++
 fs/f2fs/node.c  | 2 +-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
index 3c278e63d1a3..4ce4d6b298f9 100644
--- a/fs/f2fs/inode.c
+++ b/fs/f2fs/inode.c
@@ -365,6 +365,10 @@ static int do_read_inode(struct inode *inode)
 	if (f2fs_has_inline_data(inode) && !f2fs_exist_data(inode))
 		__recover_inline_status(inode, node_page);
 
+	/* try to recover cold bit for non-dir inode */
+	if (!S_ISDIR(inode->i_mode) && !is_cold_node(node_page))
+		set_cold_node(node_page, false);
+
 	/* get rdev by using inline_info */
 	__get_inode_rdev(inode, ri);
 
diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index b3cf18eb12f0..b1edc7525597 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -2549,7 +2549,7 @@ int f2fs_recover_inode_page(struct f2fs_sb_info *sbi, struct page *page)
 	if (!PageUptodate(ipage))
 		SetPageUptodate(ipage);
 	fill_node_footer(ipage, ino, ino, 0, true);
-	set_cold_node(page, false);
+	set_cold_node(ipage, false);
 
 	src = F2FS_INODE(page);
 	dst = F2FS_INODE(ipage);
-- 
2.18.0
