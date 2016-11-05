From: Chao Yu <chao@kernel.org>
Subject: [PATCH v2 2/2] Revert "f2fs: do not recover from
	previous remained wrong dnodes"
Date: Sat,  5 Nov 2016 11:12:40 +0800
Message-ID: <20161105031240.3824-1-chao@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chao@kernel.org>) id 1c2rRg-0006KU-Oe
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 05 Nov 2016 03:15:04 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1c2rRg-00070B-0w
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 05 Nov 2016 03:15:04 +0000
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: jaegeuk@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

From: Chao Yu <yuchao0@huawei.com>

i_times of inode will be set with current system time which can be
configured through 'date', so it's not safe to judge dnode block as
garbage data or unchanged inode depend on i_times.

Now, we have used enhanced 'cp_ver + cp' crc method to verify valid
dnode block, so I expect recoverying invalid dnode is almost not
possible.

This reverts commit 807b1e1c8e08452948495b1a9985ab46d329e5c2.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/recovery.c | 31 +------------------------------
 1 file changed, 1 insertion(+), 30 deletions(-)

diff --git a/fs/f2fs/recovery.c b/fs/f2fs/recovery.c
index d2ba4da..62523b2 100644
--- a/fs/f2fs/recovery.c
+++ b/fs/f2fs/recovery.c
@@ -196,32 +196,6 @@ static void recover_inode(struct inode *inode, struct page *page)
 			ino_of_node(page), name);
 }
 
-static bool is_same_inode(struct inode *inode, struct page *ipage)
-{
-	struct f2fs_inode *ri = F2FS_INODE(ipage);
-	struct timespec disk;
-
-	if (!IS_INODE(ipage))
-		return true;
-
-	disk.tv_sec = le64_to_cpu(ri->i_ctime);
-	disk.tv_nsec = le32_to_cpu(ri->i_ctime_nsec);
-	if (timespec_compare(&inode->i_ctime, &disk) > 0)
-		return false;
-
-	disk.tv_sec = le64_to_cpu(ri->i_atime);
-	disk.tv_nsec = le32_to_cpu(ri->i_atime_nsec);
-	if (timespec_compare(&inode->i_atime, &disk) > 0)
-		return false;
-
-	disk.tv_sec = le64_to_cpu(ri->i_mtime);
-	disk.tv_nsec = le32_to_cpu(ri->i_mtime_nsec);
-	if (timespec_compare(&inode->i_mtime, &disk) > 0)
-		return false;
-
-	return true;
-}
-
 static int find_fsync_dnodes(struct f2fs_sb_info *sbi, struct list_head *head)
 {
 	struct curseg_info *curseg;
@@ -248,10 +222,7 @@ static int find_fsync_dnodes(struct f2fs_sb_info *sbi, struct list_head *head)
 			goto next;
 
 		entry = get_fsync_inode(head, ino_of_node(page));
-		if (entry) {
-			if (!is_same_inode(entry->inode, page))
-				goto next;
-		} else {
+		if (!entry) {
 			if (IS_INODE(page) && is_dent_dnode(page)) {
 				err = recover_inode_page(sbi, page);
 				if (err)
-- 
2.10.1


------------------------------------------------------------------------------
Developer Access Program for Intel Xeon Phi Processors
Access to Intel Xeon Phi processor-based developer platforms.
With one year of Intel Parallel Studio XE.
Training and support from Colfax.
Order your platform today. http://sdm.link/xeonphi
