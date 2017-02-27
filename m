From: Chao Yu <yuchao0@huawei.com>
Subject: [PATCH 2/2] f2fs: fix to enlarge size of write_io_dummy
	mempool
Date: Mon, 27 Feb 2017 18:43:13 +0800
Message-ID: <20170227104313.33980-2-yuchao0@huawei.com>
References: <20170227104313.33980-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <yuchao0@huawei.com>) id 1ciImU-0004mA-2J
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 27 Feb 2017 10:43:50 +0000
Received: from [45.249.212.188] (helo=dggrg02-dlp.huawei.com)
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1ciImT-0002Fu-3O
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 27 Feb 2017 10:43:50 +0000
In-Reply-To: <20170227104313.33980-1-yuchao0@huawei.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: jaegeuk@kernel.org
Cc: chao@kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

It needs to double cache size of write_io_dummy mempool, otherwise we may
run out of cache in scenraio of Data/Node IOs were issued concurrently.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/super.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 53305880c455..7571eb297b21 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -1929,7 +1929,7 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
 
 	if (F2FS_IO_SIZE(sbi) > 1) {
 		sbi->write_io_dummy =
-			mempool_create_page_pool(F2FS_IO_SIZE(sbi) - 1, 0);
+			mempool_create_page_pool(2 * (F2FS_IO_SIZE(sbi) - 1), 0);
 		if (!sbi->write_io_dummy)
 			goto free_options;
 	}
-- 
2.8.2.295.g3f1c1d0


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, SlashDot.org! http://sdm.link/slashdot
