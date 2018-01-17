From: Chao Yu <yuchao0@huawei.com>
Subject: [PATCH 3/4] f2fs: fix to update last_disk_size correctly
Date: Wed, 17 Jan 2018 16:31:37 +0800
Message-ID: <20180117083138.27755-3-yuchao0@huawei.com>
References: <20180117083138.27755-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.192]
 helo=mx.sourceforge.net)
 by sfs-ml-4.v29.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 (envelope-from <yuchao0@huawei.com>) id 1ebj8n-00026e-9n
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 17 Jan 2018 08:32:13 +0000
Received: from [45.249.212.32] (helo=huawei.com)
 by sfi-mx-2.v28.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 id 1ebj8l-0000aw-GV
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 17 Jan 2018 08:32:13 +0000
In-Reply-To: <20180117083138.27755-1-yuchao0@huawei.com>
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

This patch fixes to update last_disk_size only when writing out page
successfully.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/data.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index b0e75d74fd57..28c03ea27954 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -1716,10 +1716,14 @@ static int __write_data_page(struct page *page, bool *submitted,
 		}
 	}
 
-	down_write(&F2FS_I(inode)->i_sem);
-	if (F2FS_I(inode)->last_disk_size < psize)
-		F2FS_I(inode)->last_disk_size = psize;
-	up_write(&F2FS_I(inode)->i_sem);
+	if (err) {
+		file_set_keep_isize(inode);
+	} else {
+		down_write(&F2FS_I(inode)->i_sem);
+		if (F2FS_I(inode)->last_disk_size < psize)
+			F2FS_I(inode)->last_disk_size = psize;
+		up_write(&F2FS_I(inode)->i_sem);
+	}
 
 done:
 	if (err && err != -ENOENT)
-- 
2.15.0.55.gc2ece9dc4de6


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
