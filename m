From: Chao Yu <chao2.yu@samsung.com>
Subject: [PATCH 3/8] f2fs: introduce __remove_dirty_inode
Date: Tue, 15 Dec 2015 13:31:40 +0800
Message-ID: <00f601d136f9$f6da6700$e48f3500$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chao2.yu@samsung.com>) id 1a8iDs-0000u5-9b
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 15 Dec 2015 05:32:28 +0000
Received: from mailout4.samsung.com ([203.254.224.34])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1a8iDq-0007OA-DR
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 15 Dec 2015 05:32:28 +0000
Received: from epcpsbgm2new.samsung.com (epcpsbgm2 [203.254.230.27])
	by mailout4.samsung.com
	(Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May 5
	2014)) with ESMTP id <0NZD0234FWPNPX90@mailout4.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Tue, 15 Dec 2015 14:32:18 +0900 (KST)
Content-language: zh-cn
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

Introduce __remove_dirty_inode to clean up codes in remove_dirty_dir_inode.

Signed-off-by: Chao Yu <chao2.yu@samsung.com>
---
 fs/f2fs/checkpoint.c | 24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index 1aca402..a4392f0 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -736,6 +736,20 @@ static void __add_dirty_inode(struct inode *inode)
 	return;
 }
 
+static void __remove_dirty_inode(struct inode *inode)
+{
+	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
+	struct f2fs_inode_info *fi = F2FS_I(inode);
+
+	if (get_dirty_pages(inode) ||
+			!is_inode_flag_set(F2FS_I(inode), FI_DIRTY_DIR))
+		return;
+
+	list_del_init(&fi->dirty_list);
+	clear_inode_flag(fi, FI_DIRTY_DIR);
+	stat_dec_dirty_dir(sbi);
+}
+
 void update_dirty_page(struct inode *inode, struct page *page)
 {
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
@@ -777,15 +791,7 @@ void remove_dirty_dir_inode(struct inode *inode)
 		return;
 
 	spin_lock(&sbi->dir_inode_lock);
-	if (get_dirty_pages(inode) ||
-			!is_inode_flag_set(F2FS_I(inode), FI_DIRTY_DIR)) {
-		spin_unlock(&sbi->dir_inode_lock);
-		return;
-	}
-
-	list_del_init(&fi->dirty_list);
-	clear_inode_flag(fi, FI_DIRTY_DIR);
-	stat_dec_dirty_dir(sbi);
+	__remove_dirty_inode(inode);
 	spin_unlock(&sbi->dir_inode_lock);
 
 	/* Only from the recovery routine */
-- 
2.6.3



------------------------------------------------------------------------------
