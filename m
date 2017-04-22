From: Hou Pengyang <houpengyang@huawei.com>
Subject: [PATCH 3/3] f2fs: unlock dnode before IPU
Date: Sat, 22 Apr 2017 09:22:23 +0000
Message-ID: <20170422092223.118496-4-houpengyang@huawei.com>
References: <20170422092223.118496-1-houpengyang@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <houpengyang@huawei.com>) id 1d1rFf-0004vg-Ed
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 22 Apr 2017 09:22:47 +0000
Received: from szxga03-in.huawei.com ([45.249.212.189]
	helo=dggrg03-dlp.huawei.com)
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1d1rFe-00010j-Cj
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
---
 fs/f2fs/data.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 1c99ae1..a0df451 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -1418,7 +1418,9 @@ int do_write_data_page(struct f2fs_io_info *fio)
 	 */
 	if (unlikely(fio->old_blkaddr != NEW_ADDR &&
 			need_inplace_update_block(fio, page))) {
+		f2fs_put_dnode(&dn);
 		err = do_rewrite_data_page(fio, page);
+		return err;
 	} else {
 		write_data_page(&dn, fio);
 		trace_f2fs_do_write_data_page(page, OPU);
-- 
2.10.1


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
