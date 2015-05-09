From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 02/18] f2fs: report unwritten area in f2fs_fiemap
Date: Fri,  8 May 2015 21:20:37 -0700
Message-ID: <1431145253-2019-2-git-send-email-jaegeuk@kernel.org>
References: <1431145253-2019-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1YqwGF-00051r-BJ
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 09 May 2015 04:21:11 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1YqwGE-0007i1-4O for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 09 May 2015 04:21:11 +0000
In-Reply-To: <1431145253-2019-1-git-send-email-jaegeuk@kernel.org>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>

This patch slightly changes f2fs_fiemap function to report unwritten area.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/data.c | 117 +++++++++++++++++++++++++++++++++++++++++++++++++++++++--
 fs/f2fs/f2fs.h |   4 +-
 2 files changed, 117 insertions(+), 4 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 3b76261..842fcdd 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -1241,6 +1241,8 @@ static int f2fs_map_blocks(struct inode *inode, struct f2fs_map_blocks *map,
 	if (dn.data_blkaddr != NULL_ADDR) {
 		map->m_flags = F2FS_MAP_MAPPED;
 		map->m_pblk = dn.data_blkaddr;
+		if (dn.data_blkaddr == NEW_ADDR)
+			map->m_flags |= F2FS_MAP_UNWRITTEN;
 	} else if (create) {
 		err = __allocate_data_block(&dn);
 		if (err)
@@ -1288,7 +1290,10 @@ get_next:
 			blkaddr = dn.data_blkaddr;
 		}
 		/* Give more consecutive addresses for the readahead */
-		if (map->m_pblk != NEW_ADDR && blkaddr == (map->m_pblk + ofs)) {
+		if ((map->m_pblk != NEW_ADDR &&
+				blkaddr == (map->m_pblk + ofs)) ||
+				(map->m_pblk == NEW_ADDR &&
+				blkaddr == NEW_ADDR)) {
 			ofs++;
 			dn.ofs_in_node++;
 			pgofs++;
@@ -1339,11 +1344,117 @@ static int get_data_block_fiemap(struct inode *inode, sector_t iblock,
 	return __get_data_block(inode, iblock, bh_result, create, true);
 }
 
+static inline sector_t logical_to_blk(struct inode *inode, loff_t offset)
+{
+	return (offset >> inode->i_blkbits);
+}
+
+static inline loff_t blk_to_logical(struct inode *inode, sector_t blk)
+{
+	return (blk << inode->i_blkbits);
+}
+
 int f2fs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
 		u64 start, u64 len)
 {
-	return generic_block_fiemap(inode, fieinfo,
-				start, len, get_data_block_fiemap);
+	struct buffer_head map_bh;
+	sector_t start_blk, last_blk;
+	loff_t isize = i_size_read(inode);
+	u64 logical = 0, phys = 0, size = 0;
+	u32 flags = 0;
+	bool past_eof = false, whole_file = false;
+	int ret = 0;
+
+	ret = fiemap_check_flags(fieinfo, FIEMAP_FLAG_SYNC);
+	if (ret)
+		return ret;
+
+	mutex_lock(&inode->i_mutex);
+
+	if (len >= isize) {
+		whole_file = true;
+		len = isize;
+	}
+
+	if (logical_to_blk(inode, len) == 0)
+		len = blk_to_logical(inode, 1);
+
+	start_blk = logical_to_blk(inode, start);
+	last_blk = logical_to_blk(inode, start + len - 1);
+next:
+	memset(&map_bh, 0, sizeof(struct buffer_head));
+	map_bh.b_size = len;
+
+	ret = get_data_block_fiemap(inode, start_blk, &map_bh, 0);
+	if (ret)
+		goto out;
+
+	/* HOLE */
+	if (!buffer_mapped(&map_bh)) {
+		start_blk++;
+
+		if (!past_eof && blk_to_logical(inode, start_blk) >= isize)
+			past_eof = 1;
+
+		if (past_eof && size) {
+			flags |= FIEMAP_EXTENT_LAST;
+			ret = fiemap_fill_next_extent(fieinfo, logical,
+					phys, size, flags);
+		} else if (size) {
+			ret = fiemap_fill_next_extent(fieinfo, logical,
+					phys, size, flags);
+			size = 0;
+		}
+
+		/* if we have holes up to/past EOF then we're done */
+		if (start_blk > last_blk || past_eof || ret)
+			goto out;
+	} else {
+		if (start_blk > last_blk && !whole_file) {
+			ret = fiemap_fill_next_extent(fieinfo, logical,
+					phys, size, flags);
+			goto out;
+		}
+
+		/*
+		 * if size != 0 then we know we already have an extent
+		 * to add, so add it.
+		 */
+		if (size) {
+			ret = fiemap_fill_next_extent(fieinfo, logical,
+					phys, size, flags);
+			if (ret)
+				goto out;
+		}
+
+		logical = blk_to_logical(inode, start_blk);
+		phys = blk_to_logical(inode, map_bh.b_blocknr);
+		size = map_bh.b_size;
+		flags = 0;
+		if (buffer_unwritten(&map_bh))
+			flags = FIEMAP_EXTENT_UNWRITTEN;
+
+		start_blk += logical_to_blk(inode, size);
+
+		/*
+		 * If we are past the EOF, then we need to make sure as
+		 * soon as we find a hole that the last extent we found
+		 * is marked with FIEMAP_EXTENT_LAST
+		 */
+		if (!past_eof && logical + size >= isize)
+			past_eof = true;
+	}
+	cond_resched();
+	if (fatal_signal_pending(current))
+		ret = -EINTR;
+	else
+		goto next;
+out:
+	if (ret == 1)
+		ret = 0;
+
+	mutex_unlock(&inode->i_mutex);
+	return ret;
 }
 
 /*
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 160945f..477e65f 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -330,7 +330,9 @@ struct extent_tree {
  */
 #define F2FS_MAP_NEW		(1 << BH_New)
 #define F2FS_MAP_MAPPED		(1 << BH_Mapped)
-#define F2FS_MAP_FLAGS		(F2FS_MAP_NEW | F2FS_MAP_MAPPED)
+#define F2FS_MAP_UNWRITTEN	(1 << BH_Unwritten)
+#define F2FS_MAP_FLAGS		(F2FS_MAP_NEW | F2FS_MAP_MAPPED |\
+				F2FS_MAP_UNWRITTEN)
 
 struct f2fs_map_blocks {
 	block_t m_pblk;
-- 
2.1.1


------------------------------------------------------------------------------
One dashboard for servers and applications across Physical-Virtual-Cloud 
Widest out-of-the-box monitoring support with 50+ applications
Performance metrics, stats and reports that give you Actionable Insights
Deep dive visibility with transaction tracing using APM Insight.
http://ad.doubleclick.net/ddm/clk/290420510;117567292;y
