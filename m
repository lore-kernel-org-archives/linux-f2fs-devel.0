From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 1/3] f2fs: fix to report newly allocate region as
	extent
Date: Fri, 13 Jun 2014 19:17:44 +0900
Message-ID: <1402654666-81383-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1WvOYP-0004rr-Ay
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 13 Jun 2014 10:17:49 +0000
Received: from mail.kernel.org ([198.145.19.201])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1WvOYN-0005KD-LH for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 13 Jun 2014 10:17:49 +0000
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

Previous get_block in f2fs didn't report the newly allocated region which has
NEW_ADDR.
For reader, it should not report, but fiemap needs this.
So, this patch introduces two get_block sharing core function.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/data.c | 23 ++++++++++++++++++-----
 1 file changed, 18 insertions(+), 5 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index c1fb6dd..263cdbd 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -608,8 +608,8 @@ static int __allocate_data_block(struct dnode_of_data *dn)
  *     b. do not use extent cache for better performance
  *     c. give the block addresses to blockdev
  */
-static int get_data_block(struct inode *inode, sector_t iblock,
-			struct buffer_head *bh_result, int create)
+static int __get_data_block(struct inode *inode, sector_t iblock,
+			struct buffer_head *bh_result, int create, bool fiemap)
 {
 	struct f2fs_sb_info *sbi = F2FS_SB(inode->i_sb);
 	unsigned int blkbits = inode->i_sb->s_blocksize_bits;
@@ -637,7 +637,7 @@ static int get_data_block(struct inode *inode, sector_t iblock,
 			err = 0;
 		goto unlock_out;
 	}
-	if (dn.data_blkaddr == NEW_ADDR)
+	if (dn.data_blkaddr == NEW_ADDR && !fiemap)
 		goto put_out;
 
 	if (dn.data_blkaddr != NULL_ADDR) {
@@ -671,7 +671,7 @@ get_next:
 				err = 0;
 			goto unlock_out;
 		}
-		if (dn.data_blkaddr == NEW_ADDR)
+		if (dn.data_blkaddr == NEW_ADDR && !fiemap)
 			goto put_out;
 
 		end_offset = ADDRS_PER_PAGE(dn.node_page, F2FS_I(inode));
@@ -708,10 +708,23 @@ out:
 	return err;
 }
 
+static int get_data_block(struct inode *inode, sector_t iblock,
+			struct buffer_head *bh_result, int create)
+{
+	return __get_data_block(inode, iblock, bh_result, create, false);
+}
+
+static int get_data_block_fiemap(struct inode *inode, sector_t iblock,
+			struct buffer_head *bh_result, int create)
+{
+	return __get_data_block(inode, iblock, bh_result, create, true);
+}
+
 int f2fs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
 		u64 start, u64 len)
 {
-	return generic_block_fiemap(inode, fieinfo, start, len, get_data_block);
+	return generic_block_fiemap(inode, fieinfo,
+				start, len, get_data_block_fiemap);
 }
 
 static int f2fs_read_data_page(struct file *file, struct page *page)
-- 
1.8.5.2 (Apple Git-48)


------------------------------------------------------------------------------
HPCC Systems Open Source Big Data Platform from LexisNexis Risk Solutions
Find What Matters Most in Your Big Data with HPCC Systems
Open Source. Fast. Scalable. Simple. Ideal for Dirty Data.
Leverages Graph Analysis for Fast Processing & Easy Data Exploration
http://p.sf.net/sfu/hpccsystems
