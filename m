From: Gu Zheng <guz.fnst@cn.fujitsu.com>
Subject: [PATCH 5/5] f2fs: move the list_head initialization into
 the lock protection region
Date: Tue, 19 Nov 2013 18:03:47 +0800
Message-ID: <528B3783.2040905@cn.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <guz.fnst@cn.fujitsu.com>) id 1ViiG0-0007CO-AW
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 19 Nov 2013 10:10:08 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1ViiFz-0006e0-Et for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 19 Nov 2013 10:10:08 +0000
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


Signed-off-by: Gu Zheng <guz.fnst@cn.fujitsu.com>
---
 fs/f2fs/checkpoint.c |   15 ++++++++++-----
 1 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index f884589..1de70cc 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -511,8 +511,8 @@ void add_dirty_dir_inode(struct inode *inode)
 void remove_dirty_dir_inode(struct inode *inode)
 {
 	struct f2fs_sb_info *sbi = F2FS_SB(inode->i_sb);
-	struct list_head *head = &sbi->dir_inode_list;
-	struct list_head *this;
+
+	struct list_head *this, *head;
 
 	if (!S_ISDIR(inode->i_mode))
 		return;
@@ -523,6 +523,7 @@ void remove_dirty_dir_inode(struct inode *inode)
 		return;
 	}
 
+	head = &sbi->dir_inode_list;
 	list_for_each(this, head) {
 		struct dir_inode_entry *entry;
 		entry = list_entry(this, struct dir_inode_entry, list);
@@ -544,11 +545,13 @@ void remove_dirty_dir_inode(struct inode *inode)
 
 struct inode *check_dirty_dir_inode(struct f2fs_sb_info *sbi, nid_t ino)
 {
-	struct list_head *head = &sbi->dir_inode_list;
-	struct list_head *this;
+
+	struct list_head *this, *head;
 	struct inode *inode = NULL;
 
 	spin_lock(&sbi->dir_inode_lock);
+
+	head = &sbi->dir_inode_list;
 	list_for_each(this, head) {
 		struct dir_inode_entry *entry;
 		entry = list_entry(this, struct dir_inode_entry, list);
@@ -563,11 +566,13 @@ struct inode *check_dirty_dir_inode(struct f2fs_sb_info *sbi, nid_t ino)
 
 void sync_dirty_dir_inodes(struct f2fs_sb_info *sbi)
 {
-	struct list_head *head = &sbi->dir_inode_list;
+	struct list_head *head;
 	struct dir_inode_entry *entry;
 	struct inode *inode;
 retry:
 	spin_lock(&sbi->dir_inode_lock);
+
+	head = &sbi->dir_inode_list;
 	if (list_empty(head)) {
 		spin_unlock(&sbi->dir_inode_lock);
 		return;
-- 
1.7.7


------------------------------------------------------------------------------
Shape the Mobile Experience: Free Subscription
Software experts and developers: Be at the forefront of tech innovation.
Intel(R) Software Adrenaline delivers strategic insight and game-changing 
conversations that shape the rapidly evolving mobile landscape. Sign up now. 
http://pubads.g.doubleclick.net/gampad/clk?id=63431311&iu=/4140/ostg.clktrk
