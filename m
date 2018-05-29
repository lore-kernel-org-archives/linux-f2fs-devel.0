From: youngjun yoo <youngjun.willow@gmail.com>
Subject: [PATCH 1/3] fs: f2fs: changed variable type of offset
 "unsigned" to "loff_t"
Date: Wed, 30 May 2018 04:21:14 +0900
Message-ID: <20180529192114.GA7728@willow72>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <willow72@willow72>) id 1fNkZY-0002Td-Hx
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 29 May 2018 19:46:20 +0000
Received: from [210.115.226.247] (helo=willow72)
 by sfi-mx-3.v28.lw.sourceforge.com with esmtp (Exim 4.90_1)
 id 1fNkZX-006IOY-8E
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 29 May 2018 19:46:20 +0000
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
To: jaegenk@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

clean up checkpatch warning:
WARNING: Prefer 'unsigned int' to bare use of 'unsigned'

Signed-off-by: youngjun yoo <youngjun.willow@gmail.com>
---
 fs/f2fs/file.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index cc08956..5ae120f 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -95,7 +95,7 @@ static int f2fs_vm_page_mkwrite(struct vm_fault *vmf)
 	/* page is wholly or partially inside EOF */
 	if (((loff_t)(page->index + 1) << PAGE_SHIFT) >
 						i_size_read(inode)) {
-		unsigned offset;
+		loff_t offset;
 		offset = i_size_read(inode) & ~PAGE_MASK;
 		zero_user_segment(page, offset, PAGE_SIZE);
 	}
@@ -539,7 +539,7 @@ void truncate_data_blocks(struct dnode_of_data *dn)
 static int truncate_partial_data_page(struct inode *inode, u64 from,
 								bool cache_only)
 {
-	unsigned offset = from & (PAGE_SIZE - 1);
+	loff_t offset = from & (PAGE_SIZE - 1);
 	pgoff_t index = from >> PAGE_SHIFT;
 	struct address_space *mapping = inode->i_mapping;
 	struct page *page;
-- 
2.7.4


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
