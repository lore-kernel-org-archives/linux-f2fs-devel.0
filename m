From: Chao Yu <yuchao0@huawei.com>
Subject: [PATCH 2/4] f2fs: remove dead code in update_meta_page
Date: Thu, 2 Nov 2017 20:41:02 +0800
Message-ID: <20171102124104.75298-2-yuchao0@huawei.com>
References: <20171102124104.75298-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
 helo=mx.sourceforge.net)
 by sfs-ml-2.v29.ch3.sourceforge.com with esmtps (TLSv1:DHE-RSA-AES256-SHA:256)
 (Exim 4.89) (envelope-from <yuchao0@huawei.com>) id 1eAEoL-0001H8-Eb
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 02 Nov 2017 12:41:29 +0000
Received: from szxga05-in.huawei.com ([45.249.212.191])
 by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
 (Exim 4.76) id 1eAEoJ-0001C5-Va
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 02 Nov 2017 12:41:29 +0000
In-Reply-To: <20171102124104.75298-1-yuchao0@huawei.com>
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
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

After commit a468f0ef516f ("f2fs: use crc and cp version to determine
roll-forward recovery"), last caller of update_meta_page passing @src
with NULL is gone, so remove related dead code there.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/segment.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 83125f92accc..eece3804c049 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -2028,12 +2028,8 @@ struct page *get_sum_page(struct f2fs_sb_info *sbi, unsigned int segno)
 void update_meta_page(struct f2fs_sb_info *sbi, void *src, block_t blk_addr)
 {
 	struct page *page = grab_meta_page(sbi, blk_addr);
-	void *dst = page_address(page);
 
-	if (src)
-		memcpy(dst, src, PAGE_SIZE);
-	else
-		memset(dst, 0, PAGE_SIZE);
+	memcpy(page_address(page), src, PAGE_SIZE);
 	set_page_dirty(page);
 	f2fs_put_page(page, 1);
 }
-- 
2.13.1.388.g69e6b9b4f4a9


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
