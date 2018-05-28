From: Chao Yu <yuchao0@huawei.com>
Subject: [PATCH 1/2] f2fs: don't drop dentry pages after fs
 shutdown
Date: Mon, 28 May 2018 16:59:26 +0800
Message-ID: <20180528085927.91965-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <yuchao0@huawei.com>) id 1fNE0K-0008PA-5H
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 28 May 2018 08:59:48 +0000
Received: from [45.249.212.35] (helo=huawei.com)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1fNE0I-006eKJ-Ln
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 28 May 2018 08:59:48 +0000
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

As description in commit "f2fs: don't drop any page on f2fs_cp_error()
case":

"We still provide readdir() after shtudown, so we should keep pages to
avoid additional IOs."

In order to provider lastest directory structure, let's keep dentry
pages in cache after fs shutdown.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/data.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 9d3e2e1c1e33..31c2edb217ec 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -1801,6 +1801,12 @@ static int __write_data_page(struct page *page, bool *submitted,
 	/* we should bypass data pages to proceed the kworkder jobs */
 	if (unlikely(f2fs_cp_error(sbi))) {
 		mapping_set_error(page->mapping, -EIO);
+		/*
+		 * don't drop any dirty dentry pages for keeping lastest
+		 * directory structure.
+		 */
+		if (S_ISDIR(inode->i_mode))
+			goto redirty_out;
 		goto out;
 	}
 
-- 
2.17.0.391.g1f1cddd558b5


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
