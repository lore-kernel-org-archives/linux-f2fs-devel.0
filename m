From: Chao Yu <yuchao0@huawei.com>
Subject: [PATCH 3/4] f2fs: avoid memory leak in
 f2fs_write_root_inode
Date: Thu, 16 Nov 2017 19:50:57 +0800
Message-ID: <20171116115058.110552-3-yuchao0@huawei.com>
References: <20171116115058.110552-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.193]
 helo=mx.sourceforge.net)
 by sfs-ml-4.v29.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 (envelope-from <yuchao0@huawei.com>) id 1eFIiG-0000RJ-Ry
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 16 Nov 2017 11:52:08 +0000
Received: from szxga05-in.huawei.com ([45.249.212.191])
 by sfi-mx-3.v28.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
 (Exim 4.89) id 1eFIiF-00034g-TG
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 16 Nov 2017 11:52:08 +0000
In-Reply-To: <20171116115058.110552-1-yuchao0@huawei.com>
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

Before exiting f2fs_write_root_inode, we should free in-there allocated
memory.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 mkfs/f2fs_format.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/mkfs/f2fs_format.c b/mkfs/f2fs_format.c
index d5f39ca3dac4..9fc0398fab65 100644
--- a/mkfs/f2fs_format.c
+++ b/mkfs/f2fs_format.c
@@ -1042,6 +1042,7 @@ static int f2fs_write_root_inode(void)
 			c.blks_per_seg, main_area_node_seg_blk_offset);
 	if (dev_write_block(raw_node, main_area_node_seg_blk_offset)) {
 		MSG(1, "\tError: While writing the raw_node to disk!!!\n");
+		free(raw_node);
 		return -1;
 	}
 
@@ -1052,9 +1053,11 @@ static int f2fs_write_root_inode(void)
 
 #ifndef WITH_ANDROID
 	if (discard_obsolete_dnode(raw_node, main_area_node_seg_blk_offset)) {
+		free(raw_node);
 		return -1;
 	}
 #endif
+	free(raw_node);
 	return 0;
 }
 
-- 
2.15.0.55.gc2ece9dc4de6


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
