From: Chao Yu <chao@kernel.org>
Subject: [PATCH 2/5] f2fs: clean up with IS_INODE()
Date: Sun,  8 Jul 2018 22:16:54 +0800
Message-ID: <20180708141657.24641-2-chao@kernel.org>
References: <20180708141657.24641-1-chao@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180708141657.24641-1-chao@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, Chao Yu <yuchao0@huawei.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

From: Chao Yu <yuchao0@huawei.com>

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
index 8211f5c288a1..b0ab39d83235 100644
--- a/fs/f2fs/inode.c
+++ b/fs/f2fs/inode.c
@@ -122,7 +122,7 @@ static bool f2fs_enable_inode_chksum(struct f2fs_sb_info *sbi, struct page *page
 	if (!f2fs_sb_has_inode_chksum(sbi->sb))
 		return false;
 
-	if (!RAW_IS_INODE(F2FS_NODE(page)) || !(ri->i_inline & F2FS_EXTRA_ATTR))
+	if (!IS_INODE(page) || !(ri->i_inline & F2FS_EXTRA_ATTR))
 		return false;
 
 	if (!F2FS_FITS_IN_INODE(ri, le16_to_cpu(ri->i_extra_isize),
-- 
2.16.2.17.g38e79b1fd
