From: Yunlei He <heyunlei@huawei.com>
Subject: [PATCH v2] f2fs: skip writeback meta pages if cp_mutex
	acquire failed
Date: Wed, 1 Mar 2017 18:07:10 +0800
Message-ID: <20170301100710.9386-1-heyunlei@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <heyunlei@huawei.com>) id 1cj16S-0007et-AJ
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 01 Mar 2017 10:03:24 +0000
Received: from [45.249.212.187] (helo=dggrg01-dlp.huawei.com)
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1cj16P-0004bN-R2
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 01 Mar 2017 10:03:24 +0000
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: jaegeuk@kernel.org, yuchao0@huawei.com, linux-f2fs-devel@lists.sourceforge.net

Skip writeback meta pages if cp_mutex lock acquire failed, cp will
flush dirty pages instead.

Signed-off-by: Yunlei He <heyunlei@huawei.com>
---
 fs/f2fs/checkpoint.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index 0339daf..91734cc 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -275,10 +275,11 @@ static int f2fs_write_meta_pages(struct address_space *mapping,
 		get_pages(sbi, F2FS_DIRTY_META) < nr_pages_to_skip(sbi, META))
 		goto skip_write;
 
-	trace_f2fs_writepages(mapping->host, wbc, META);
+	/* if locked failed, cp will flush dirty pages instead */
+	if (!mutex_trylock(&sbi->cp_mutex))
+		goto skip_write;
 
-	/* if mounting is failed, skip writing node pages */
-	mutex_lock(&sbi->cp_mutex);
+	trace_f2fs_writepages(mapping->host, wbc, META);
 	diff = nr_pages_to_write(sbi, META, wbc);
 	written = sync_meta_pages(sbi, META, wbc->nr_to_write);
 	mutex_unlock(&sbi->cp_mutex);
-- 
2.10.1


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, SlashDot.org! http://sdm.link/slashdot
