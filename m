From: Yunlei He <heyunlei@huawei.com>
Subject: [PATCH] f2fs: no need lock_op in f2fs_write_inline_data
Date: Thu, 23 Feb 2017 20:31:20 +0800
Message-ID: <20170223123120.18842-1-heyunlei@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <heyunlei@huawei.com>) id 1cgsUs-0003XD-T6
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 23 Feb 2017 12:27:46 +0000
Received: from [45.249.212.188] (helo=dggrg02-dlp.huawei.com)
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1cgsUq-0002aa-VD
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 23 Feb 2017 12:27:46 +0000
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

Similar as f2fs_write_inode, f2fs_write_inline_data just
mark inode page dirty, so it's no need to write inline data
under read lock of cp_rwsem.

Signed-off-by: Yunlei He <heyunlei@huawei.com>
---
 fs/f2fs/data.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 5f3bc98..836a15a 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -1414,9 +1414,9 @@ static int __write_data_page(struct page *page, bool *submitted,
 		goto redirty_out;
 
 	err = -EAGAIN;
-	f2fs_lock_op(sbi);
 	if (f2fs_has_inline_data(inode))
 		err = f2fs_write_inline_data(inode, page);
+	f2fs_lock_op(sbi);
 	if (err == -EAGAIN)
 		err = do_write_data_page(&fio);
 	if (F2FS_I(inode)->last_disk_size < psize)
-- 
2.10.1


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, SlashDot.org! http://sdm.link/slashdot
