From: Hou Pengyang <houpengyang@huawei.com>
Subject: [PATCH 2/3] f2fs: lookup extent cache first under IPU
	scenario
Date: Sat, 22 Apr 2017 09:22:22 +0000
Message-ID: <20170422092223.118496-3-houpengyang@huawei.com>
References: <20170422092223.118496-1-houpengyang@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <houpengyang@huawei.com>) id 1d1rFf-0006mm-Dk
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 22 Apr 2017 09:22:47 +0000
Received: from szxga03-in.huawei.com ([45.249.212.189]
	helo=dggrg03-dlp.huawei.com)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1d1rFc-0000qH-Qx
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 22 Apr 2017 09:22:47 +0000
In-Reply-To: <20170422092223.118496-1-houpengyang@huawei.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: jaegeuk@kernel.org, chao@kernel.org, yuchao0@huawei.com
Cc: linux-f2fs-devel@lists.sourceforge.net

Signed-off-by: Hou Pengyang <houpengyang@huawei.com>
Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/data.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 6b18750..1c99ae1 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -1367,8 +1367,32 @@ int do_write_data_page(struct f2fs_io_info *fio)
 	struct page *page = fio->page;
 	struct inode *inode = page->mapping->host;
 	struct dnode_of_data dn;
+	struct extent_info ei = {0,0,0};
 	int err = 0;
 
+	/*
+	 * If a page is cold, NOT atomit written and need_ipu now, there is
+	 * a high probability that IPU should be adapted. For IPU, we try to
+	 * check extent tree to get the block index first, instead of reading
+	 * the dnode page, where may lead to an useless dnode IO, since no need to
+	 * update the dnode index for IPU.
+	 */
+	if (unlikely(need_inplace_update_block(fio, page) &&
+			f2fs_lookup_extent_cache(inode, page->index, &ei))) {
+
+		fio->old_blkaddr = ei.blk + page->index - ei.fofs;
+
+		if (fio->old_blkaddr != NEW_ADDR &&
+				fio->old_blkaddr != NULL_ADDR) {
+			err = f2fs_encrypt_page(fio, page);
+			if (err)
+				return err;
+			set_page_writeback(page);
+			err = do_rewrite_data_page(fio, page);
+			return err;
+		}
+	}
+
 	set_new_dnode(&dn, inode, NULL, NULL, 0);
 	err = get_dnode_of_data(&dn, page->index, LOOKUP_NODE);
 	if (err)
-- 
2.10.1


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
