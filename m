From: Chao Yu <yuchao0@huawei.com>
Subject: [PATCH 6/7] f2fs: clean up f2fs_map_blocks
Date: Thu, 30 Nov 2017 19:28:22 +0800
Message-ID: <20171130112823.100494-6-yuchao0@huawei.com>
References: <20171130112823.100494-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.193]
 helo=mx.sourceforge.net)
 by sfs-ml-2.v29.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 (envelope-from <yuchao0@huawei.com>) id 1eKN1R-0005X2-B4
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 30 Nov 2017 11:28:53 +0000
Received: from szxga05-in.huawei.com ([45.249.212.191])
 by sfi-mx-3.v28.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
 (Exim 4.89) id 1eKN1P-0007dX-Oc
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 30 Nov 2017 11:28:53 +0000
In-Reply-To: <20171130112823.100494-1-yuchao0@huawei.com>
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

f2fs_map_blocks():

if (blkaddr == NEW_ADDR || blkaddr == NULL_ADDR) {
	if (create) {
		...
	} else {
		...
		if (flag == F2FS_GET_BLOCK_FIEMAP &&
					blkaddr == NULL_ADDR) {
			...
		}
		if (flag != F2FS_GET_BLOCK_FIEMAP ||
					blkaddr != NEW_ADDR)
			goto sync_out;
	}

It means we can break the loop in cases of:
a) flag != F2FS_GET_BLOCK_FIEMAP or
b) flag == F2FS_GET_BLOCK_FIEMAP && blkaddr == NULL_ADDR

Condition b) is the same as previous one, so merge operations of them
for readability.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/data.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index c792f13081db..c24ea5be2a67 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -988,9 +988,9 @@ int f2fs_map_blocks(struct inode *inode, struct f2fs_map_blocks *map,
 						blkaddr == NULL_ADDR) {
 				if (map->m_next_pgofs)
 					*map->m_next_pgofs = pgofs + 1;
+				goto sync_out;
 			}
-			if (flag != F2FS_GET_BLOCK_FIEMAP ||
-						blkaddr != NEW_ADDR)
+			if (flag != F2FS_GET_BLOCK_FIEMAP)
 				goto sync_out;
 		}
 	}
-- 
2.15.0.55.gc2ece9dc4de6


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
