From: Yunlong Song <yunlong.song@huawei.com>
Subject: [PATCH] f2fs: make assignment of t->dentry_bitmap more readable
Date: Mon, 2 Apr 2018 20:22:20 +0800
Message-ID: <1522671740-92824-1-git-send-email-yunlong.song@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: jaegeuk@kernel.org, chao@kernel.org, yuchao0@huawei.com, yunlong.song@icloud.com, yunlong.song@huawei.com
Cc: miaoxie@huawei.com, bintian.wang@huawei.com, shengyong1@huawei.com, heyunlei@huawei.com, linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

In make_dentry_ptr_block, it is confused with "&" for t->dentry_bitmap
but without "&" for t->dentry, so delete "&" to make code more readable.

Signed-off-by: Yunlong Song <yunlong.song@huawei.com>
---
 fs/f2fs/f2fs.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 191ee57..474b9e9 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -471,7 +471,7 @@ static inline void make_dentry_ptr_block(struct inode *inode,
 	d->inode = inode;
 	d->max = NR_DENTRY_IN_BLOCK;
 	d->nr_bitmap = SIZE_OF_DENTRY_BITMAP;
-	d->bitmap = &t->dentry_bitmap;
+	d->bitmap = t->dentry_bitmap;
 	d->dentry = t->dentry;
 	d->filename = t->filename;
 }
-- 
1.8.5.2
