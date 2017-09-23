From: Hsiang Kao via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Subject: [PATCH v2] f2fs: allow readpages with NULL file pointer
Date: Sun, 24 Sep 2017 02:45:42 +0800
Message-ID: <bb773ebc-6372-dae7-4642-10594d6e3c94@aol.com>
Reply-To: Hsiang Kao <hsiangkao@aol.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
 helo=mx.sourceforge.net)
 by sfs-ml-3.v29.ch3.sourceforge.com with esmtps (TLSv1:DHE-RSA-AES256-SHA:256)
 (Exim 4.89) (envelope-from <hsiangkao@aol.com>) id 1dvpR6-00085m-L6
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 23 Sep 2017 18:45:56 +0000
Received: from omr-m008e.mx.aol.com ([204.29.186.7])
 by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
 (Exim 4.76) id 1dvpR4-0001ZL-FB
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 23 Sep 2017 18:45:56 +0000
Content-Language: en-US
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: jaegeuk@kernel.org, chao@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net

Keep in line with the other Linux file system implementations
since page_cache_sync_readahead supports NULL file pointer,
and thus we can readahead data by f2fs itself without file opening
(something like the btrfs behavior).

Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
---
  fs/f2fs/data.c | 2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 95f30f0..506281d 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -1333,7 +1333,7 @@ static int f2fs_read_data_pages(struct file *file,
  			struct address_space *mapping,
  			struct list_head *pages, unsigned nr_pages)
  {
-	struct inode *inode = file->f_mapping->host;
+	struct inode *inode = mapping->host;
  	struct page *page = list_last_entry(pages, struct page, lru);
   	trace_f2fs_readpages(inode, page, nr_pages);
-- 
2.7.4


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
