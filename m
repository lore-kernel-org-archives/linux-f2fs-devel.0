From: Weichao Guo <guoweichao@huawei.com>
Subject: [PATCH] f2fs: no need to punch hole far beyond the file
 size
Date: Sat, 14 Oct 2017 00:59:50 +0800
Message-ID: <20171013165950.219357-1-guoweichao@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
 helo=mx.sourceforge.net)
 by sfs-ml-3.v29.ch3.sourceforge.com with esmtps (TLSv1:DHE-RSA-AES256-SHA:256)
 (Exim 4.89) (envelope-from <guoweichao@huawei.com>)
 id 1e2vmL-0000u7-Pt
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 13 Oct 2017 08:57:13 +0000
Received: from szxga04-in.huawei.com ([45.249.212.190])
 by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
 (Exim 4.76) id 1e2vmK-0000fW-3G
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 13 Oct 2017 08:57:13 +0000
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: jaegeuk@kernel.org, yuchao0@huawei.com
Cc: heyunlei@huawei.com, linux-f2fs-devel@lists.sourceforge.net

Punching hole with a length which far larger than file size will
cause a long time looping in truncate_hole after lock_op, it can
be reproduced as the following:

        $ echo "abc" > file
        $ xfs_io -c "fpunch 0 HUGE_LENGTH" file

This may cause other I/Os blocked a long time. Let's fix this case
by setting the hole to end after the page that contains i_size.

Signed-off-by: Weichao Guo <guoweichao@huawei.com>
---
 fs/f2fs/file.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 517e112..1b44d26 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -873,6 +873,14 @@ static int punch_hole(struct inode *inode, loff_t offset, loff_t len)
 	if (ret)
 		return ret;
 
+	/*
+	 * If the hole extends beyond i_size, set the hole
+	 * to end after the page that contains i_size
+	 */
+	if (offset + len > inode->i_size)
+		len = inode->i_size + PAGE_CACHE_SIZE -
+			(inode->i_size & (PAGE_CACHE_SIZE - 1)) - offset;
+
 	pg_start = ((unsigned long long) offset) >> PAGE_SHIFT;
 	pg_end = ((unsigned long long) offset + len) >> PAGE_SHIFT;
 
-- 
2.10.1


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
