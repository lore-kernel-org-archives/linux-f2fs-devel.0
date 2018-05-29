From: youngjun yoo <youngjun.willow@gmail.com>
Subject: [PATCH 2/3] fs: f2fs: add missing blank lines after
 declarations
Date: Wed, 30 May 2018 04:33:07 +0900
Message-ID: <20180529193307.GA8686@willow72>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <willow72@willow72>) id 1fNkUi-0002yF-DE
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 29 May 2018 19:41:20 +0000
Received: from [210.115.226.247] (helo=willow72)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtp (Exim 4.90_1)
 id 1fNkUh-009CHk-4S
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 29 May 2018 19:41:20 +0000
Content-Disposition: inline
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
Cc: linux-kernel@vgr.kernel.org, linux-f2fs-devel@lists.sourceforge.net

clean up checkpatch warning:
WARNING: Missing a blank line after declarations

Signed-off-by: youngjun yoo <youngjun.willow@gmail.com>
---
 fs/f2fs/file.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 5ae120f..df8b02b 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -96,6 +96,7 @@ static int f2fs_vm_page_mkwrite(struct vm_fault *vmf)
 	if (((loff_t)(page->index + 1) << PAGE_SHIFT) >
 						i_size_read(inode)) {
 		loff_t offset;
+
 		offset = i_size_read(inode) & ~PAGE_MASK;
 		zero_user_segment(page, offset, PAGE_SIZE);
 	}
@@ -412,6 +413,7 @@ static loff_t f2fs_seek_block(struct file *file, loff_t offset, int whence)
 				dn.ofs_in_node++, pgofs++,
 				data_ofs = (loff_t)pgofs << PAGE_SHIFT) {
 			block_t blkaddr;
+
 			blkaddr = datablock_addr(dn.inode,
 					dn.node_page, dn.ofs_in_node);
 
@@ -502,6 +504,7 @@ void truncate_data_blocks_range(struct dnode_of_data *dn, int count)
 
 	for (; count > 0; count--, addr++, dn->ofs_in_node++) {
 		block_t blkaddr = le32_to_cpu(*addr);
+
 		if (blkaddr == NULL_ADDR)
 			continue;
 
-- 
2.7.4


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
