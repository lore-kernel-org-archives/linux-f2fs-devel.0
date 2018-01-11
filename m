From: Chao Yu <yuchao0@huawei.com>
Subject: [PATCH v2] f2fs: fix to cover f2fs_inline_data_fiemap
 with inode_lock
Date: Thu, 11 Jan 2018 14:37:35 +0800
Message-ID: <20180111063735.37395-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.191]
 helo=mx.sourceforge.net)
 by sfs-ml-2.v29.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 (envelope-from <yuchao0@huawei.com>) id 1eZWV2-0002bO-RE
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 11 Jan 2018 06:38:04 +0000
Received: from [45.249.212.32] (helo=huawei.com)
 by sfi-mx-1.v28.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 id 1eZWV1-0005uk-Bd
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 11 Jan 2018 06:38:04 +0000
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

This patch fix to cover f2fs_inline_data_fiemap with inode_lock in order
to make that interface avoiding race with mapping change.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
v2:
- change to just cover inode lock for f2fs_inline_data_fiemap
 fs/f2fs/data.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index d6302051a65d..12155ee90468 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -1150,14 +1150,14 @@ int f2fs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
 	if (ret)
 		return ret;
 
+	inode_lock(inode);
+
 	if (f2fs_has_inline_data(inode)) {
 		ret = f2fs_inline_data_fiemap(inode, fieinfo, start, len);
 		if (ret != -EAGAIN)
-			return ret;
+			goto out;
 	}
 
-	inode_lock(inode);
-
 	if (logical_to_blk(inode, len) == 0)
 		len = blk_to_logical(inode, 1);
 
-- 
2.15.0.55.gc2ece9dc4de6


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
