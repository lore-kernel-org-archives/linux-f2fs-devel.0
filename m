From: Chao Yu <yuchao0@huawei.com>
Subject: [PATCH] f2fs: fix to update iostat correctly in IPU path
Date: Thu, 21 Feb 2019 20:40:13 +0800
Message-ID: <20190221124013.47531-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, chao@kernel.org, Chao Yu <yuchao0@huawei.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

In error path of IPU, we didn't account iostat correctly, fix it.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/segment.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 3602acee4985..86a6fcbe8484 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -3197,10 +3197,10 @@ int f2fs_inplace_write_data(struct f2fs_io_info *fio)
 	stat_inc_inplace_blocks(fio->sbi);
 
 	err = f2fs_submit_page_bio(fio);
-	if (!err)
+	if (!err) {
 		update_device_state(fio);
-
-	f2fs_update_iostat(fio->sbi, fio->io_type, F2FS_BLKSIZE);
+		f2fs_update_iostat(fio->sbi, fio->io_type, F2FS_BLKSIZE);
+	}
 
 	return err;
 }
-- 
2.18.0.rc1
