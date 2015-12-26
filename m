From: Fan Li <fanofcode.li@samsung.com>
Subject: [PATCH] f2fs: fix bugs and simplify codes of f2fs_fiemap
Date: Sat, 26 Dec 2015 18:07:41 +0800
Message-ID: <001601d13fc5$588bd000$09a37000$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <fanofcode.li@samsung.com>) id 1aClm1-0007OH-JN
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 26 Dec 2015 10:08:29 +0000
Received: from mailout3.samsung.com ([203.254.224.33])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1aCllz-0000xf-Lz
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 26 Dec 2015 10:08:29 +0000
Received: from epcpsbgm2new.samsung.com (epcpsbgm2 [203.254.230.27])
	by mailout3.samsung.com
	(Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May 5
	2014)) with ESMTP id <0NZY00IBOMTVJH90@mailout3.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Sat, 26 Dec 2015 19:08:20 +0900 (KST)
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
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

fix bugs:
1. len could be updated incorrectly when start+len is beyond isize.
2. If there is a hole consisting of more than two blocks, it could
   fail to add FIEMAP_EXTENT_LAST flag for the last extent.
3. If there is an extent beyond isize, when we search extents in a range 
   that ends at isize, it will also return the extent beyond isize,
   which is outside the range.

Signed-off-by: Fan li <fanofcode.li@samsung.com>
---
 fs/f2fs/data.c |   80 +++++++++++++++++++-------------------------------------
 1 file changed, 27 insertions(+), 53 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 5c43b2d..d67c599 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -783,7 +783,6 @@ int f2fs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
 	loff_t isize = i_size_read(inode);
 	u64 logical = 0, phys = 0, size = 0;
 	u32 flags = 0;
-	bool past_eof = false, whole_file = false;
 	int ret = 0;
 
 	ret = fiemap_check_flags(fieinfo, FIEMAP_FLAG_SYNC);
@@ -797,17 +796,18 @@ int f2fs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
 	}
 
 	mutex_lock(&inode->i_mutex);
+	if (start >= isize)
+		goto out;
 
-	if (len >= isize) {
-		whole_file = true;
-		len = isize;
-	}
+	if (start + len > isize)
+		len = isize - start;
 
 	if (logical_to_blk(inode, len) == 0)
 		len = blk_to_logical(inode, 1);
 
 	start_blk = logical_to_blk(inode, start);
 	last_blk = logical_to_blk(inode, start + len - 1);
+
 next:
 	memset(&map_bh, 0, sizeof(struct buffer_head));
 	map_bh.b_size = len;
@@ -819,59 +819,33 @@ next:
 
 	/* HOLE */
 	if (!buffer_mapped(&map_bh)) {
-		start_blk++;
-
-		if (!past_eof && blk_to_logical(inode, start_blk) >= isize)
-			past_eof = 1;
-
-		if (past_eof && size) {
-			flags |= FIEMAP_EXTENT_LAST;
-			ret = fiemap_fill_next_extent(fieinfo, logical,
-					phys, size, flags);
-		} else if (size) {
-			ret = fiemap_fill_next_extent(fieinfo, logical,
-					phys, size, flags);
-			size = 0;
-		}
+		/* Go through holes util pass the EOF */
+		if (blk_to_logical(inode, start_blk++) < isize)
+			goto prep_next;
+		/* Found a hole beyond isize means no more extents.
+		 * Note that the premise is that filesystems don't
+		 * punch holes beyond isize and keep size unchanged.
+		 */
+		flags |= FIEMAP_EXTENT_LAST;
+	}
 
-		/* if we have holes up to/past EOF then we're done */
-		if (start_blk > last_blk || past_eof || ret)
-			goto out;
-	} else {
-		if (start_blk > last_blk && !whole_file) {
-			ret = fiemap_fill_next_extent(fieinfo, logical,
-					phys, size, flags);
-			goto out;
-		}
+	if (size)
+		ret = fiemap_fill_next_extent(fieinfo, logical,
+				phys, size, flags);
 
-		/*
-		 * if size != 0 then we know we already have an extent
-		 * to add, so add it.
-		 */
-		if (size) {
-			ret = fiemap_fill_next_extent(fieinfo, logical,
-					phys, size, flags);
-			if (ret)
-				goto out;
-		}
+	if (start_blk > last_blk || ret)
+		goto out;
 
-		logical = blk_to_logical(inode, start_blk);
-		phys = blk_to_logical(inode, map_bh.b_blocknr);
-		size = map_bh.b_size;
-		flags = 0;
-		if (buffer_unwritten(&map_bh))
-			flags = FIEMAP_EXTENT_UNWRITTEN;
+	logical = blk_to_logical(inode, start_blk);
+	phys = blk_to_logical(inode, map_bh.b_blocknr);
+	size = map_bh.b_size;
+	flags = 0;
+	if (buffer_unwritten(&map_bh))
+		flags = FIEMAP_EXTENT_UNWRITTEN;
 
-		start_blk += logical_to_blk(inode, size);
+	start_blk += logical_to_blk(inode, size);
 
-		/*
-		 * If we are past the EOF, then we need to make sure as
-		 * soon as we find a hole that the last extent we found
-		 * is marked with FIEMAP_EXTENT_LAST
-		 */
-		if (!past_eof && logical + size >= isize)
-			past_eof = true;
-	}
+prep_next:
 	cond_resched();
 	if (fatal_signal_pending(current))
 		ret = -EINTR;
-- 
1.7.9.5


------------------------------------------------------------------------------
