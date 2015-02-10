From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 4/4] f2fs: allocate data blocks in advance for
	f2fs_direct_IO
Date: Tue, 10 Feb 2015 13:58:45 -0800
Message-ID: <1423605525-85348-4-git-send-email-jaegeuk@kernel.org>
References: <1423605525-85348-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1YLIpi-0002RX-Er
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 10 Feb 2015 21:59:02 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1YLIph-0007bu-FQ for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 10 Feb 2015 21:59:02 +0000
In-Reply-To: <1423605525-85348-1-git-send-email-jaegeuk@kernel.org>
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

This patch adds preallocation for data blocks to prepare f2fs_direct_IO.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/data.c | 57 ++++++++++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 54 insertions(+), 3 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 26e2476..985ed02 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -592,6 +592,56 @@ static int __allocate_data_block(struct dnode_of_data *dn)
 	return 0;
 }
 
+static void __allocate_data_blocks(struct inode *inode, loff_t offset,
+							size_t count)
+{
+	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
+	struct dnode_of_data dn;
+	u64 start = F2FS_BYTES_TO_BLK(offset);
+	u64 len = F2FS_BYTES_TO_BLK(count);
+	bool allocated;
+	u64 end_offset;
+
+	while (len) {
+		f2fs_balance_fs(sbi);
+		f2fs_lock_op(sbi);
+
+		/* When reading holes, we need its node page */
+		set_new_dnode(&dn, inode, NULL, NULL, 0);
+		if (get_dnode_of_data(&dn, start, ALLOC_NODE))
+			goto out;
+
+		allocated = false;
+		end_offset = ADDRS_PER_PAGE(dn.node_page, F2FS_I(inode));
+
+		while (dn.ofs_in_node < end_offset && len) {
+			if (dn.data_blkaddr == NULL_ADDR) {
+				if (__allocate_data_block(&dn))
+					goto sync_out;
+				allocated = true;
+			}
+			len--;
+			start++;
+			dn.ofs_in_node++;
+		}
+
+		if (allocated)
+			sync_inode_page(&dn);
+
+		f2fs_put_dnode(&dn);
+		f2fs_unlock_op(sbi);
+	}
+	return;
+
+sync_out:
+	if (allocated)
+		sync_inode_page(&dn);
+	f2fs_put_dnode(&dn);
+out:
+	f2fs_unlock_op(sbi);
+	return;
+}
+
 /*
  * get_data_block() now supported readahead/bmap/rw direct_IO with mapped bh.
  * If original data blocks are allocated, then give them to blockdev.
@@ -617,10 +667,8 @@ static int __get_data_block(struct inode *inode, sector_t iblock,
 	if (check_extent_cache(inode, pgofs, bh_result))
 		goto out;
 
-	if (create) {
-		f2fs_balance_fs(F2FS_I_SB(inode));
+	if (create)
 		f2fs_lock_op(F2FS_I_SB(inode));
-	}
 
 	/* When reading holes, we need its node page */
 	set_new_dnode(&dn, inode, NULL, NULL, 0);
@@ -1108,6 +1156,9 @@ static ssize_t f2fs_direct_IO(int rw, struct kiocb *iocb,
 
 	trace_f2fs_direct_IO_enter(inode, offset, count, rw);
 
+	if (rw & WRITE)
+		__allocate_data_blocks(inode, offset, count);
+
 	err = blockdev_direct_IO(rw, iocb, inode, iter, offset, get_data_block);
 	if (err < 0 && (rw & WRITE))
 		f2fs_write_failed(mapping, offset + count);
-- 
2.1.1


------------------------------------------------------------------------------
Dive into the World of Parallel Programming. The Go Parallel Website,
sponsored by Intel and developed in partnership with Slashdot Media, is your
hub for all things parallel software development, from weekly thought
leadership blogs to news, videos, case studies, tutorials and more. Take a
look and join the conversation now. http://goparallel.sourceforge.net/
