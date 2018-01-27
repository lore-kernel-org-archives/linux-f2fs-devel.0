From: Chao Yu <yuchao0@huawei.com>
Subject: [PATCH 2/2] f2fs: fix to check extent cache in
 f2fs_drop_extent_tree
Date: Sat, 27 Jan 2018 17:29:49 +0800
Message-ID: <20180127092949.26616-2-yuchao0@huawei.com>
References: <20180127092949.26616-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.193]
 helo=mx.sourceforge.net)
 by sfs-ml-1.v29.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 (envelope-from <yuchao0@huawei.com>) id 1efMoL-0005X6-1w
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 27 Jan 2018 09:30:09 +0000
Received: from [45.249.212.35] (helo=huawei.com)
 by sfi-mx-3.v28.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 id 1efMoJ-00042h-Dh
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 27 Jan 2018 09:30:08 +0000
In-Reply-To: <20180127092949.26616-1-yuchao0@huawei.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: jaegeuk@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

If noextent_cache mount option is on, we will never initialize extent tree
in inode, but still we're going to access it in f2fs_drop_extent_tree,
result in kernel panic as below:

 BUG: unable to handle kernel NULL pointer dereference at 0000000000000038
 IP: _raw_write_lock+0xc/0x30
 Call Trace:
  ? f2fs_drop_extent_tree+0x41/0x70 [f2fs]
  f2fs_fallocate+0x5a0/0xdd0 [f2fs]
  ? common_file_perm+0x47/0xc0
  ? apparmor_file_permission+0x1a/0x20
  vfs_fallocate+0x15b/0x290
  SyS_fallocate+0x44/0x70
  do_syscall_64+0x6e/0x160
  entry_SYSCALL64_slow_path+0x25/0x25

This patch fixes to check extent cache status before using in
f2fs_drop_extent_tree.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/extent_cache.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/f2fs/extent_cache.c b/fs/f2fs/extent_cache.c
index ff2352a0ed15..aff6c2ed1c02 100644
--- a/fs/f2fs/extent_cache.c
+++ b/fs/f2fs/extent_cache.c
@@ -706,6 +706,9 @@ void f2fs_drop_extent_tree(struct inode *inode)
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
 	struct extent_tree *et = F2FS_I(inode)->extent_tree;
 
+	if (!f2fs_may_extent_tree(inode))
+		return;
+
 	set_inode_flag(inode, FI_NO_EXTENT);
 
 	write_lock(&et->lock);
-- 
2.15.0.55.gc2ece9dc4de6


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
