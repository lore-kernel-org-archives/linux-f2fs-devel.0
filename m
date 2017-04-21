From: Hou Pengyang <houpengyang@huawei.com>
Subject: [PATCH 3/3] f2fs: unlock dnode before IPU
Date: Fri, 21 Apr 2017 09:56:35 +0000
Message-ID: <20170421095635.101454-4-houpengyang@huawei.com>
References: <20170421095635.101454-1-houpengyang@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <houpengyang@huawei.com>) id 1d1VJT-0002Vh-8h
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 21 Apr 2017 09:57:15 +0000
Received: from szxga02-in.huawei.com ([45.249.212.188]
	helo=dggrg02-dlp.huawei.com)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1d1VJR-0001nv-63
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 21 Apr 2017 09:57:15 +0000
In-Reply-To: <20170421095635.101454-1-houpengyang@huawei.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: jaegeuk@kernel.org, chao@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net

Signed-off-by: Hou Pengyang <houpengyang@huawei.com>
---
 fs/f2fs/data.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 3a660f7..fcd907c 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -1409,7 +1409,9 @@ int do_write_data_page(struct f2fs_io_info *fio)
 			!is_cold_data(page) &&
 			!IS_ATOMIC_WRITTEN_PAGE(page) &&
 			need_inplace_update(inode, fio))) {
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
