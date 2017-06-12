From: Chao Yu <yuchao0@huawei.com>
Subject: [PATCH 4/4] f2fs: fix wrong error number of fill_super
Date: Mon, 12 Jun 2017 09:44:27 +0800
Message-ID: <20170612014427.40692-4-yuchao0@huawei.com>
References: <20170612014427.40692-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <yuchao0@huawei.com>) id 1dKEPb-0007Fk-F0
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 12 Jun 2017 01:44:59 +0000
Received: from szxga01-in.huawei.com ([45.249.212.187])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1dKEPY-0002ge-RA
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 12 Jun 2017 01:44:59 +0000
In-Reply-To: <20170612014427.40692-1-yuchao0@huawei.com>
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
Cc: chao@kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

This patch fixes incorrect error number in error path of fill_super.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/super.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 1c05763616b2..b26ae4d648cb 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -1945,6 +1945,7 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
 	if (f2fs_sb_mounted_blkzoned(sb)) {
 		f2fs_msg(sb, KERN_ERR,
 			 "Zoned block device support is not enabled\n");
+		err = -EOPNOTSUPP;
 		goto free_sb_buf;
 	}
 #endif
@@ -2016,8 +2017,10 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
 	if (F2FS_IO_SIZE(sbi) > 1) {
 		sbi->write_io_dummy =
 			mempool_create_page_pool(2 * (F2FS_IO_SIZE(sbi) - 1), 0);
-		if (!sbi->write_io_dummy)
+		if (!sbi->write_io_dummy) {
+			err = -ENOMEM;
 			goto free_options;
+		}
 	}
 
 	/* get an inode for meta space */
-- 
2.13.1.388.g69e6b9b4f4a9


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
