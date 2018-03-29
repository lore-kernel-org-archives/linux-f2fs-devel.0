From: Junling Zheng <zhengjunling@huawei.com>
Subject: [PATCH] f2fs: fix a wrong condition in
 f2fs_skip_inode_update
Date: Thu, 29 Mar 2018 19:27:12 +0800
Message-ID: <20180329112712.90438-1-zhengjunling@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <zhengjunling@huawei.com>) id 1f1ViP-0001cj-FW
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 29 Mar 2018 11:27:33 +0000
Received: from [45.249.212.32] (helo=huawei.com)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1f1ViJ-002OG4-JC
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 29 Mar 2018 11:27:33 +0000
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
Cc: linux-f2fs-devel@lists.sourceforge.net

Fix commit 97dd26ad8347 (f2fs: fix wrong AUTO_RECOVER condition).
We should use ~PAGE_MASK to determine whether i_size is aligned to
the f2fs's block size or not.

Signed-off-by: Junling Zheng <zhengjunling@huawei.com>
---
 fs/f2fs/f2fs.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index ae69dc358401..8c159785f6b5 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -2469,7 +2469,7 @@ static inline bool f2fs_skip_inode_update(struct inode *inode, int dsync)
 	}
 	if (!is_inode_flag_set(inode, FI_AUTO_RECOVER) ||
 			file_keep_isize(inode) ||
-			i_size_read(inode) & PAGE_MASK)
+			i_size_read(inode) & ~PAGE_MASK)
 		return false;
 
 	down_read(&F2FS_I(inode)->i_sem);
-- 
2.16.2


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
