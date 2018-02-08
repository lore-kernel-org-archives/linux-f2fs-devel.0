From: Yunlong Song <yunlong.song@huawei.com>
Subject: [PATCH] f2fs: set_code_data in move_data_block
Date: Thu, 8 Feb 2018 20:33:37 +0800
Message-ID: <1518093217-123705-1-git-send-email-yunlong.song@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: jaegeuk@kernel.org, chao@kernel.org, yuchao0@huawei.com, yunlong.song@icloud.com, yunlong.song@huawei.com
Cc: miaoxie@huawei.com, bintian.wang@huawei.com, shengyong1@huawei.com, heyunlei@huawei.com, linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

Signed-off-by: Yunlong Song <yunlong.song@huawei.com>
---
 fs/f2fs/gc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index b9d93fd..2095630 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -692,6 +692,7 @@ static void move_data_block(struct inode *inode, block_t bidx,
 	fio.op = REQ_OP_WRITE;
 	fio.op_flags = REQ_SYNC;
 	fio.new_blkaddr = newaddr;
+	set_cold_data(fio.page);
 	err = f2fs_submit_page_write(&fio);
 	if (err) {
 		if (PageWriteback(fio.encrypted_page))
-- 
1.8.5.2
