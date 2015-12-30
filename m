From: Fan Li <fanofcode.li@samsung.com>
Subject: [PATCH 3/3] f2fs: avoid looking up extents outside
 specified range
Date: Wed, 30 Dec 2015 17:23:33 +0800
Message-ID: <000e01d142e3$d6dea560$849bf020$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <fanofcode.li@samsung.com>) id 1aECzU-0007Fq-3i
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 30 Dec 2015 09:24:20 +0000
Received: from mailout3.samsung.com ([203.254.224.33])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1aECzS-0003bF-AJ
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 30 Dec 2015 09:24:20 +0000
Received: from epcpsbgm2new.samsung.com (epcpsbgm2 [203.254.230.27])
	by mailout3.samsung.com
	(Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May 5
	2014)) with ESMTP id <0O05004YOZGAQ490@mailout3.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Wed, 30 Dec 2015 18:24:10 +0900 (KST)
Content-language: en-us
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: 'Jaegeuk Kim' <jaegeuk@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net

There are two advantages to update b_size in this way:
1. get_data_block tends to round down b_size to align with
   block size, if b_size isn't aligned already, it would take
   an extra loop to go through the range. So we round it up first.
2. unlike extent-based file, get_data_block could be time-consuming
    for indirect-based file, update b_size may avoid looking up blocks 
    outside the range.

Signed-off-by: Fan li <fanofcode.li@samsung.com>
---
 fs/f2fs/data.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index f89cf07..29fec76 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -798,15 +798,15 @@ int f2fs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
 	isize = i_size_read(inode);
 
 	mutex_lock(&inode->i_mutex);
-	if (logical_to_blk(inode, len) == 0)
-		len = blk_to_logical(inode, 1);
 
 	start_blk = logical_to_blk(inode, start);
 	last_blk = logical_to_blk(inode, start + len - 1);
-
 next:
 	memset(&map_bh, 0, sizeof(struct buffer_head));
-	map_bh.b_size = len;
+	if (last_blk >= start_blk)
+		map_bh.b_size = blk_to_logical(inode, last_blk - start_blk + 1);
+	else
+		map_bh.b_size = blk_to_logical(inode, 1);
 
 	ret = get_data_block(inode, start_blk, &map_bh, 0,
 					F2FS_GET_BLOCK_FIEMAP);
-- 
1.7.9.5


------------------------------------------------------------------------------
