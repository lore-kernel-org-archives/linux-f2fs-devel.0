From: Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 230/258] f2fs: fix sbi->extent_list
 corruption issue
Date: Mon, 28 Jan 2019 10:58:56 -0500
Message-ID: <20190128155924.51521-230-sashal@kernel.org>
References: <20190128155924.51521-1-sashal@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <sashal@kernel.org>) id 1go9UX-0008NX-IW
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 28 Jan 2019 16:10:33 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1go9UW-003TvL-1E
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 28 Jan 2019 16:10:33 +0000
In-Reply-To: <20190128155924.51521-1-sashal@kernel.org>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>, Jaegeuk Kim <jaegeuk@kernel.org>, linux-f2fs-devel@lists.sourceforge.net

From: Sahitya Tummala <stummala@codeaurora.org>

[ Upstream commit e4589fa545e0020dbbc3c9bde35f35f949901392 ]

When there is a failure in f2fs_fill_super() after/during
the recovery of fsync'd nodes, it frees the current sbi and
retries again. This time the mount is successful, but the files
that got recovered before retry, still holds the extent tree,
whose extent nodes list is corrupted since sbi and sbi->extent_list
is freed up. The list_del corruption issue is observed when the
file system is getting unmounted and when those recoverd files extent
node is being freed up in the below context.

list_del corruption. prev->next should be fffffff1e1ef5480, but was (null)
<...>
kernel BUG at kernel/msm-4.14/lib/list_debug.c:53!
lr : __list_del_entry_valid+0x94/0xb4
pc : __list_del_entry_valid+0x94/0xb4
<...>
Call trace:
__list_del_entry_valid+0x94/0xb4
__release_extent_node+0xb0/0x114
__free_extent_tree+0x58/0x7c
f2fs_shrink_extent_tree+0xdc/0x3b0
f2fs_leave_shrinker+0x28/0x7c
f2fs_put_super+0xfc/0x1e0
generic_shutdown_super+0x70/0xf4
kill_block_super+0x2c/0x5c
kill_f2fs_super+0x44/0x50
deactivate_locked_super+0x60/0x8c
deactivate_super+0x68/0x74
cleanup_mnt+0x40/0x78
__cleanup_mnt+0x1c/0x28
task_work_run+0x48/0xd0
do_notify_resume+0x678/0xe98
work_pending+0x8/0x14

Fix this by not creating extents for those recovered files if shrinker is
not registered yet. Once mount is successful and shrinker is registered,
those files can have extents again.

Signed-off-by: Sahitya Tummala <stummala@codeaurora.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/f2fs.h     | 11 ++++++++++-
 fs/f2fs/shrinker.c |  2 +-
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 462a2fb8aa69..eea2811dc672 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -2614,10 +2614,19 @@ static inline bool is_dot_dotdot(const struct qstr *str)
 
 static inline bool f2fs_may_extent_tree(struct inode *inode)
 {
-	if (!test_opt(F2FS_I_SB(inode), EXTENT_CACHE) ||
+	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
+
+	if (!test_opt(sbi, EXTENT_CACHE) ||
 			is_inode_flag_set(inode, FI_NO_EXTENT))
 		return false;
 
+	/*
+	 * for recovered files during mount do not create extents
+	 * if shrinker is not registered.
+	 */
+	if (list_empty(&sbi->s_list))
+		return false;
+
 	return S_ISREG(inode->i_mode);
 }
 
diff --git a/fs/f2fs/shrinker.c b/fs/f2fs/shrinker.c
index 36cfd816c160..29042e6d5126 100644
--- a/fs/f2fs/shrinker.c
+++ b/fs/f2fs/shrinker.c
@@ -138,6 +138,6 @@ void f2fs_leave_shrinker(struct f2fs_sb_info *sbi)
 	f2fs_shrink_extent_tree(sbi, __count_extent_cache(sbi));
 
 	spin_lock(&f2fs_list_lock);
-	list_del(&sbi->s_list);
+	list_del_init(&sbi->s_list);
 	spin_unlock(&f2fs_list_lock);
 }
-- 
2.19.1
