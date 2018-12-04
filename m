From: Sheng Yong <shengyong1@huawei.com>
Subject: [PATCH] f2fs: clear PG_writeback if IPU failed
Date: Tue, 4 Dec 2018 22:59:21 +0800
Message-ID: <20181204145921.81980-1-shengyong1@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <shengyong1@huawei.com>) id 1gUCAu-0001YA-LF
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 04 Dec 2018 14:59:48 +0000
Received: from szxga05-in.huawei.com ([45.249.212.191] helo=huawei.com)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1gUCAs-000m3R-M7
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 04 Dec 2018 14:59:48 +0000
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
Cc: linux-f2fs-devel@lists.sourceforge.net

If IPU failed, nothing is commited, we should end page writeback.

Signed-off-by: Sheng Yong <shengyong1@huawei.com>
---
 fs/f2fs/data.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 8780f3d737c4..b29b754141d8 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -1853,6 +1853,8 @@ int f2fs_do_write_data_page(struct f2fs_io_info *fio)
 		if (fio->need_lock == LOCK_REQ)
 			f2fs_unlock_op(fio->sbi);
 		err = f2fs_inplace_write_data(fio);
+		if (err && PageWriteback(page))
+			end_page_writeback(page);
 		trace_f2fs_do_write_data_page(fio->page, IPU);
 		set_inode_flag(inode, FI_UPDATE_WRITE);
 		return err;
-- 
2.17.1
