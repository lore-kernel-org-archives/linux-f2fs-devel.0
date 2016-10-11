From: Chao Yu <chao@kernel.org>
Subject: [PATCH 7/8] f2fs: fix to update largest extent under lock
Date: Tue, 11 Oct 2016 22:57:05 +0800
Message-ID: <20161011145706.5028-7-chao@kernel.org>
References: <20161011145706.5028-1-chao@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chao@kernel.org>) id 1btyWr-0007fd-Gn
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 11 Oct 2016 14:59:41 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1btyWq-0005TU-Rd
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 11 Oct 2016 14:59:41 +0000
In-Reply-To: <20161011145706.5028-1-chao@kernel.org>
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

In order to avoid racing problem, make largest extent cache being updated
under lock.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/inode.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
index 34ae03c..d9cd458 100644
--- a/fs/f2fs/inode.c
+++ b/fs/f2fs/inode.c
@@ -252,6 +252,7 @@ retry:
 int update_inode(struct inode *inode, struct page *node_page)
 {
 	struct f2fs_inode *ri;
+	struct extent_tree *et = F2FS_I(inode)->extent_tree;
 
 	f2fs_inode_synced(inode);
 
@@ -267,11 +268,13 @@ int update_inode(struct inode *inode, struct page *node_page)
 	ri->i_size = cpu_to_le64(i_size_read(inode));
 	ri->i_blocks = cpu_to_le64(inode->i_blocks);
 
-	if (F2FS_I(inode)->extent_tree)
-		set_raw_extent(&F2FS_I(inode)->extent_tree->largest,
-							&ri->i_ext);
-	else
+	if (et) {
+		read_lock(&et->lock);
+		set_raw_extent(&et->largest, &ri->i_ext);
+		read_unlock(&et->lock);
+	} else {
 		memset(&ri->i_ext, 0, sizeof(ri->i_ext));
+	}
 	set_raw_inline(inode, ri);
 
 	ri->i_atime = cpu_to_le64(inode->i_atime.tv_sec);
-- 
2.10.1


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most 
engaging tech sites, SlashDot.org! http://sdm.link/slashdot
