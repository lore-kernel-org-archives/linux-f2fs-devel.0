From: Jaegeuk Kim <jaegeuk.kim@samsung.com>
Subject: [PATCH 1/4] f2fs: update_inode_page should be done all
	the time
Date: Tue, 28 Jan 2014 14:54:04 +0900
Message-ID: <1390888447-5258-1-git-send-email-jaegeuk.kim@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk.kim@samsung.com>) id 1W81eD-0003zn-Op
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 28 Jan 2014 05:55:45 +0000
Received: from mailout4.samsung.com ([203.254.224.34])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-MD5:128)
	(Exim 4.76) id 1W81eB-0006vz-OG
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 28 Jan 2014 05:55:45 +0000
Received: from epcpsbgr4.samsung.com
	(u144.gpu120.samsung.co.kr [203.254.230.144])
	by mailout4.samsung.com (Oracle Communications Messaging Server
	7u4-24.01 (7.0.4.24.0) 64bit (built Nov 17 2011))
	with ESMTP id <0N0300EK1KGL9PC0@mailout4.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Tue, 28 Jan 2014 14:55:33 +0900 (KST)
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

In order to make fs consistency, update_inode_page should not be failed all
the time. Otherwise, it is possible to lose some metadata in the inode like
a link count.

Signed-off-by: Jaegeuk Kim <jaegeuk.kim@samsung.com>
---
 fs/f2fs/data.c  |  3 +--
 fs/f2fs/f2fs.h  |  8 +++++++-
 fs/f2fs/inode.c | 20 ++++++++++++--------
 3 files changed, 20 insertions(+), 11 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 0ae5587..6827359 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -62,8 +62,7 @@ static void f2fs_write_end_io(struct bio *bio, int err)
 		if (unlikely(!uptodate)) {
 			SetPageError(page);
 			set_bit(AS_EIO, &page->mapping->flags);
-			set_ckpt_flags(sbi->ckpt, CP_ERROR_FLAG);
-			sbi->sb->s_flags |= MS_RDONLY;
+			f2fs_stop_checkpoint(sbi);
 		}
 		end_page_writeback(page);
 		dec_page_count(sbi, F2FS_WRITEBACK);
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index af51a0b..42903c3 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1023,6 +1023,12 @@ static inline int f2fs_readonly(struct super_block *sb)
 	return sb->s_flags & MS_RDONLY;
 }
 
+static inline void f2fs_stop_checkpoint(struct f2fs_sb_info *sbi)
+{
+	set_ckpt_flags(sbi->ckpt, CP_ERROR_FLAG);
+	sbi->sb->s_flags |= MS_RDONLY;
+}
+
 /*
  * file.c
  */
@@ -1044,7 +1050,7 @@ void f2fs_set_inode_flags(struct inode *);
 struct inode *f2fs_iget(struct super_block *, unsigned long);
 int try_to_free_nats(struct f2fs_sb_info *, int);
 void update_inode(struct inode *, struct page *);
-int update_inode_page(struct inode *);
+void update_inode_page(struct inode *);
 int f2fs_write_inode(struct inode *, struct writeback_control *);
 void f2fs_evict_inode(struct inode *);
 
diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
index 4d67ed7..1a4ba27 100644
--- a/fs/f2fs/inode.c
+++ b/fs/f2fs/inode.c
@@ -212,24 +212,28 @@ void update_inode(struct inode *inode, struct page *node_page)
 	clear_inode_flag(F2FS_I(inode), FI_DIRTY_INODE);
 }
 
-int update_inode_page(struct inode *inode)
+void update_inode_page(struct inode *inode)
 {
 	struct f2fs_sb_info *sbi = F2FS_SB(inode->i_sb);
 	struct page *node_page;
-
+retry:
 	node_page = get_node_page(sbi, inode->i_ino);
-	if (IS_ERR(node_page))
-		return PTR_ERR(node_page);
+	if (IS_ERR(node_page)) {
+		if (PTR_ERR(node_page) == -ENOMEM) {
+			cond_resched();
+			goto retry;
+		} else {
+			f2fs_stop_checkpoint(sbi);
+		}
+	}
 
 	update_inode(inode, node_page);
 	f2fs_put_page(node_page, 1);
-	return 0;
 }
 
 int f2fs_write_inode(struct inode *inode, struct writeback_control *wbc)
 {
 	struct f2fs_sb_info *sbi = F2FS_SB(inode->i_sb);
-	int ret;
 
 	if (inode->i_ino == F2FS_NODE_INO(sbi) ||
 			inode->i_ino == F2FS_META_INO(sbi))
@@ -243,13 +247,13 @@ int f2fs_write_inode(struct inode *inode, struct writeback_control *wbc)
 	 * during the urgent cleaning time when runing out of free sections.
 	 */
 	f2fs_lock_op(sbi);
-	ret = update_inode_page(inode);
+	update_inode_page(inode);
 	f2fs_unlock_op(sbi);
 
 	if (wbc)
 		f2fs_balance_fs(sbi);
 
-	return ret;
+	return 0;
 }
 
 /*
-- 
1.8.4.474.g128a96c


------------------------------------------------------------------------------
WatchGuard Dimension instantly turns raw network data into actionable 
security intelligence. It gives you real-time visual feedback on key
security issues and trends.  Skip the complicated setup - simply import
a virtual appliance and go from zero to informed in seconds.
http://pubads.g.doubleclick.net/gampad/clk?id=123612991&iu=/4140/ostg.clktrk
