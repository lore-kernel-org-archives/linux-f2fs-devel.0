From: Fan Li <fanofcode.li@samsung.com>
Subject: [PATCH 2/3] f2fs: support finding extents after isize
Date: Wed, 30 Dec 2015 17:17:23 +0800
Message-ID: <000d01d142e2$fab05fc0$f0111f40$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <fanofcode.li@samsung.com>) id 1aECtW-0005Rk-T5
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 30 Dec 2015 09:18:10 +0000
Received: from mailout1.samsung.com ([203.254.224.24])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1aECtV-0001N3-0m
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 30 Dec 2015 09:18:10 +0000
Received: from epcpsbgm1new.samsung.com (epcpsbgm1 [203.254.230.26])
	by mailout1.samsung.com
	(Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May 5
	2014)) with ESMTP id <0O0500WPCZ61WL50@mailout1.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Wed, 30 Dec 2015 18:18:01 +0900 (KST)
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

f2fs allows preallocation beyond isize, but f2fs_fiemap only look up
extents within isize. Therefore add this support.

Note: It's possible that there are holes after isize, for example,
fallocate  multiple discontinuous extents after isize with 
FALLOC_FL_KEEP_SIZE set. Since I can tell no differences between 
EOF and holes from return of get_data_block, I'm afaid this patch
can't support such scenarios. 


Signed-off-by: Fan li <fanofcode.li@samsung.com>
---
 fs/f2fs/data.c |    7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index a9a4d89..f89cf07 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -798,12 +798,6 @@ int f2fs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
 	isize = i_size_read(inode);
 
 	mutex_lock(&inode->i_mutex);
-	if (start >= isize)
-		goto out;
-
-	if (start + len > isize)
-		len = isize - start;
-
 	if (logical_to_blk(inode, len) == 0)
 		len = blk_to_logical(inode, 1);
 
@@ -829,6 +823,7 @@ next:
 		 * punch holes beyond isize and keep size unchanged.
 		 */
 		flags |= FIEMAP_EXTENT_LAST;
+		last_blk = start_blk - 1;
 	}
 
 	if (size)
-- 
1.7.9.5


------------------------------------------------------------------------------
