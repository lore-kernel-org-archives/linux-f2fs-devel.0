From: YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] f2fs: remove set but not used variable 'err'
Date: Fri, 4 Jan 2019 01:38:29 +0000
Message-ID: <1546565909-17400-1-git-send-email-yuehaibing@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>
Cc: YueHaibing <yuehaibing@huawei.com>, linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

Fixes gcc '-Wunused-but-set-variable' warning:

fs/f2fs/data.c: In function 'f2fs_dio_submit_bio':
fs/f2fs/data.c:2585:6: warning:
 variable 'err' set but not used [-Wunused-but-set-variable]


Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 fs/f2fs/data.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index f91d863..4e402ad 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -2582,14 +2582,11 @@ static void f2fs_dio_submit_bio(struct bio *bio, struct inode *inode,
 {
 	struct f2fs_private_dio *dio;
 	bool write = (bio_op(bio) == REQ_OP_WRITE);
-	int err;
 
 	dio = f2fs_kzalloc(F2FS_I_SB(inode),
 			sizeof(struct f2fs_private_dio), GFP_NOFS);
-	if (!dio) {
-		err = -ENOMEM;
+	if (!dio)
 		goto out;
-	}
 
 	dio->inode = inode;
 	dio->orig_end_io = bio->bi_end_io;
