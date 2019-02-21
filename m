From: Chao Yu <yuchao0@huawei.com>
Subject: [PATCH] f2fs: fix encrypted page memory leak
Date: Thu, 21 Feb 2019 20:37:14 +0800
Message-ID: <20190221123714.47172-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, chao@kernel.org, Chao Yu <yuchao0@huawei.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

For IPU path of f2fs_do_write_data_page(), in its error path, we
need to release encrypted page and fscrypt context, otherwise it
will cause memory leak.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/data.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index e099babf85bd..b0d1e946e141 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -1860,8 +1860,13 @@ int f2fs_do_write_data_page(struct f2fs_io_info *fio)
 		if (fio->need_lock == LOCK_REQ)
 			f2fs_unlock_op(fio->sbi);
 		err = f2fs_inplace_write_data(fio);
-		if (err && PageWriteback(page))
-			end_page_writeback(page);
+		if (err) {
+			if (f2fs_encrypted_file(inode))
+				fscrypt_pullback_bio_page(&fio->encrypted_page,
+									true);
+			if (PageWriteback(page))
+				end_page_writeback(page);
+		}
 		trace_f2fs_do_write_data_page(fio->page, IPU);
 		set_inode_flag(inode, FI_UPDATE_WRITE);
 		return err;
-- 
2.18.0.rc1
