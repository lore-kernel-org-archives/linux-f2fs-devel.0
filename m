From: "gaoxiang (P)" <gaoxiang25@huawei.com>
Subject: [PATCH] f2fs: allow readpages with NULL file pointer
Date: Thu, 21 Sep 2017 05:00:33 +0000
Message-ID: <9047C53C18267742AB12E43B65C7F9F70BBE4BD7@dggemi505-mbs.china.huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
 helo=mx.sourceforge.net)
 by sfs-ml-3.v29.ch3.sourceforge.com with esmtps (TLSv1:DHE-RSA-AES256-SHA:256)
 (Exim 4.89) (envelope-from <gaoxiang25@huawei.com>)
 id 1dutc8-0000Y5-OD
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 21 Sep 2017 05:01:28 +0000
Received: from szxga01-in.huawei.com ([45.249.212.187])
 by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
 (Exim 4.76) id 1dutc6-000146-He
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 21 Sep 2017 05:01:28 +0000
Content-Language: zh-CN
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: "jaegeuk@kernel.org" <jaegeuk@kernel.org>, "Yuchao (T)" <yuchao0@huawei.com>
Cc: "linux-f2fs-devel@lists.sourceforge.net" <linux-f2fs-devel@lists.sourceforge.net>

Keep in line with the other Linux file system implementations
since page_cache_sync_readahead supports NULL file pointer,
and thus we can readahead data by f2fs itself without file opening
(something like the btrfs behavior).

Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
---
 fs/f2fs/data.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 95f30f0..afa12f1 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -1333,9 +1333,11 @@ static int f2fs_read_data_pages(struct file *file,
 			struct address_space *mapping,
 			struct list_head *pages, unsigned nr_pages)
 {
-	struct inode *inode = file->f_mapping->host;
+	struct inode *inode = mapping->host;
 	struct page *page = list_last_entry(pages, struct page, lru);
 
+	if (likely(file != NULL))
+		BUG_ON(file->f_mapping != mapping);
 	trace_f2fs_readpages(inode, page, nr_pages);
 
 	/* If the file has inline data, skip readpages */
-- 
2.1.4


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
