From: Wei Yongjun <weiyj.lk@gmail.com>
Subject: [PATCH -next] f2fs: fix non static symbol warning
Date: Tue, 23 Aug 2016 15:23:59 +0000
Message-ID: <1471965839-8389-1-git-send-email-weiyj.lk@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>, Changman Lee <cm224.lee@samsung.com>, Chao Yu <yuchao0@huawei.com>
Cc: Wei Yongjun <weiyongjun1@huawei.com>, linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

From: Wei Yongjun <weiyongjun1@huawei.com>

Fixes the following sparse warning:

fs/f2fs/data.c:969:12: warning:
 symbol 'f2fs_grab_bio' was not declared. Should it be static?

Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 fs/f2fs/data.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index ccb401e..64d1833 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -966,8 +966,8 @@ out:
 	return ret;
 }
 
-struct bio *f2fs_grab_bio(struct inode *inode, block_t blkaddr,
-							unsigned nr_pages)
+static struct bio *f2fs_grab_bio(struct inode *inode, block_t blkaddr,
+				 unsigned nr_pages)
 {
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
 	struct fscrypt_ctx *ctx = NULL;
