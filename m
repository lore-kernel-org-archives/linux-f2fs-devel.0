From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 3/8] f2fs: avoid wrong count on dirty inodes
Date: Thu,  2 Jun 2016 20:55:34 -0700
Message-ID: <1464926139-58252-3-git-send-email-jaegeuk@kernel.org>
References: <1464926139-58252-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1b8gD9-0005Wf-9l
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 03 Jun 2016 03:55:51 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1b8gD8-00030Z-Fq
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 03 Jun 2016 03:55:51 +0000
In-Reply-To: <1464926139-58252-1-git-send-email-jaegeuk@kernel.org>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>

The number should be covered by spin_lock. Otherwise we can see wrong count
in f2fs_stat.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/super.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 27f76819e..9e75433 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -645,8 +645,8 @@ static void f2fs_dirty_inode(struct inode *inode, int flags)
 	list_add_tail(&F2FS_I(inode)->gdirty_list,
 				&sbi->inode_list[DIRTY_META]);
 	inc_page_count(sbi, F2FS_DIRTY_IMETA);
-	spin_unlock(&sbi->inode_lock[DIRTY_META]);
 	stat_inc_dirty_inode(sbi, DIRTY_META);
+	spin_unlock(&sbi->inode_lock[DIRTY_META]);
 }
 
 void f2fs_inode_synced(struct inode *inode)
@@ -662,8 +662,8 @@ void f2fs_inode_synced(struct inode *inode)
 	clear_inode_flag(inode, FI_DIRTY_INODE);
 	clear_inode_flag(inode, FI_AUTO_RECOVER);
 	dec_page_count(sbi, F2FS_DIRTY_IMETA);
-	spin_unlock(&sbi->inode_lock[DIRTY_META]);
 	stat_dec_dirty_inode(F2FS_I_SB(inode), DIRTY_META);
+	spin_unlock(&sbi->inode_lock[DIRTY_META]);
 }
 
 static void f2fs_i_callback(struct rcu_head *head)
-- 
2.6.3


------------------------------------------------------------------------------
What NetFlow Analyzer can do for you? Monitors network bandwidth and traffic
patterns at an interface-level. Reveals which users, apps, and protocols are 
consuming the most bandwidth. Provides multi-vendor support for NetFlow, 
J-Flow, sFlow and other flows. Make informed decisions using capacity 
planning reports. https://ad.doubleclick.net/ddm/clk/305295220;132659582;e
