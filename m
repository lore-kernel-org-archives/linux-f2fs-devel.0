From: Hou Pengyang <houpengyang@huawei.com>
Subject: [PATCH 2/3] f2fs: check IPU after reading dnode from disk
Date: Fri, 5 May 2017 09:12:28 +0000
Message-ID: <20170505091229.156181-3-houpengyang@huawei.com>
References: <20170505091229.156181-1-houpengyang@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <houpengyang@huawei.com>) id 1d6ZIG-000422-9L
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 05 May 2017 09:12:56 +0000
Received: from szxga03-in.huawei.com ([45.249.212.189])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1d6ZIF-0002oB-5i
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 05 May 2017 09:12:56 +0000
In-Reply-To: <20170505091229.156181-1-houpengyang@huawei.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: jaegeuk@kernel.org, yuchao0@huawei.com
Cc: chao@kernel.org, linux-f2fs-devel@lists.sourceforge.net

Signed-off-by: Hou Pengyang <houpengyang@huawei.com>
---
 fs/f2fs/data.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 075d159..e41f5ed 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -1381,6 +1381,13 @@ int do_write_data_page(struct f2fs_io_info *fio)
 			ClearPageUptodate(page);
 			goto out_writepage;
 		}
+
+		if (valid_ipu_blkaddr(fio) && need_inplace_update(fio)) {
+			ipu_force = true;
+			fio->need_lock = false;
+			goto got_it;
+		}
+		/* If NOT IPU, we should unlock node_page for cp */
 		unlock_page(dn.node_page);
 		dn.node_page_locked = false;
 	} else
-- 
2.10.1


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
