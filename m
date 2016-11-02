From: Chao Yu <yuchao0@huawei.com>
Subject: [PATCH] f2fs: update inode updating status correctly
Date: Wed, 2 Nov 2016 20:08:34 +0800
Message-ID: <20161102120834.15178-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <yuchao0@huawei.com>) id 1c1uMJ-0007LH-O5
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 02 Nov 2016 12:09:35 +0000
Received: from szxga01-in.huawei.com ([58.251.152.64])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1c1uMG-0003IW-4H
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 02 Nov 2016 12:09:35 +0000
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
Cc: chao@kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

We should record updating status of inode only for living inode, for those
unlinked inode it needs to clear ino cache, otherwise after the ino of
unlinked inode was been reused, it will cause unneeded node page writing
during ->fsync.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/inode.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
index 7b5e402..36f8a9b 100644
--- a/fs/f2fs/inode.c
+++ b/fs/f2fs/inode.c
@@ -409,10 +409,15 @@ void f2fs_evict_inode(struct inode *inode)
 	invalidate_mapping_pages(NODE_MAPPING(sbi), inode->i_ino, inode->i_ino);
 	if (xnid)
 		invalidate_mapping_pages(NODE_MAPPING(sbi), xnid, xnid);
-	if (is_inode_flag_set(inode, FI_APPEND_WRITE))
-		add_ino_entry(sbi, inode->i_ino, APPEND_INO);
-	if (is_inode_flag_set(inode, FI_UPDATE_WRITE))
-		add_ino_entry(sbi, inode->i_ino, UPDATE_INO);
+	if (inode->i_nlink) {
+		if (is_inode_flag_set(inode, FI_APPEND_WRITE))
+			add_ino_entry(sbi, inode->i_ino, APPEND_INO);
+		if (is_inode_flag_set(inode, FI_UPDATE_WRITE))
+			add_ino_entry(sbi, inode->i_ino, UPDATE_INO);
+	} else {
+		remove_ino_entry(sbi, inode->i_ino, APPEND_INO);
+		remove_ino_entry(sbi, inode->i_ino, UPDATE_INO);
+	}
 	if (is_inode_flag_set(inode, FI_FREE_NID)) {
 		alloc_nid_failed(sbi, inode->i_ino);
 		clear_inode_flag(inode, FI_FREE_NID);
-- 
2.8.2.311.gee88674


------------------------------------------------------------------------------
Developer Access Program for Intel Xeon Phi Processors
Access to Intel Xeon Phi processor-based developer platforms.
With one year of Intel Parallel Studio XE.
Training and support from Colfax.
Order your platform today. http://sdm.link/xeonphi
