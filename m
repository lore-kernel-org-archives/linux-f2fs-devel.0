From: Chao Yu <yuchao0@huawei.com>
Subject: [PATCH] f2fs: protect free nid operation with cp_rwsem
Date: Fri, 17 Mar 2017 18:46:23 +0800
Message-ID: <20170317104623.90116-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <yuchao0@huawei.com>) id 1copPL-0003Z4-Du
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 17 Mar 2017 10:46:55 +0000
Received: from [45.249.212.189] (helo=dggrg03-dlp.huawei.com)
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1copPK-0000mg-5l
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 17 Mar 2017 10:46:55 +0000
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

- f2fs_balance_fs_bg
 - build_free_nids
  - __build_free_nids
   - scan_nat_page
    - add_free_nid
					- f2fs_create
					 - f2fs_new_inode
					  - alloc_nid
   - remove_free_nid

This patch uses cp_rwsem to protect free nid allocation/initialization
to avoid reusing allocated nid in above scenario.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/inode.c   | 2 ++
 fs/f2fs/segment.c | 5 ++++-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
index 2520fa72b23f..f941410f994a 100644
--- a/fs/f2fs/inode.c
+++ b/fs/f2fs/inode.c
@@ -423,7 +423,9 @@ void f2fs_evict_inode(struct inode *inode)
 			add_ino_entry(sbi, inode->i_ino, UPDATE_INO);
 	}
 	if (is_inode_flag_set(inode, FI_FREE_NID)) {
+		f2fs_lock_op(sbi);
 		alloc_nid_failed(sbi, inode->i_ino);
+		f2fs_unlock_op(sbi);
 		clear_inode_flag(inode, FI_FREE_NID);
 	}
 	f2fs_bug_on(sbi, err &&
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 0bf024f62330..f85e1f443c99 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -426,8 +426,11 @@ void f2fs_balance_fs_bg(struct f2fs_sb_info *sbi)
 
 	if (!available_free_memory(sbi, FREE_NIDS))
 		try_to_free_nids(sbi, MAX_FREE_NIDS);
-	else
+	else {
+		f2fs_lock_op(sbi);
 		build_free_nids(sbi, false, false);
+		f2fs_unlock_op(sbi);
+	}
 
 	if (!is_idle(sbi))
 		return;
-- 
2.8.2.295.g3f1c1d0


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
