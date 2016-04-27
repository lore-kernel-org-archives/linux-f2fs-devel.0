From: Yunlong Song <yunlong.song@huawei.com>
Subject: [PATCH] f2fs: fix to return 0 if err == -ENOENT in f2fs_readdir
Date: Wed, 27 Apr 2016 20:32:37 +0800
Message-ID: <1461760357-13882-1-git-send-email-yunlong.song@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: jaegeuk@kernel.org, cm224.lee@samsung.com, yuchao0@huawei.com, chao@kernel.org, sylinux@163.com, yunlong.song@huawei.com
Cc: bintian.wang@huawei.com, houpengyang@huawei.com, heyunlei@huawei.com, liushuoran@huawei.com, shiguojun@huawei.com, linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

Commit 57b62d29ad5b384775974973087d47755a8c6fcc ("f2fs: fix to report
error in f2fs_readdir") causes f2fs_readdir to return -ENOENT when
get_lock_data_page returns -ENOENT. However, the original logic is to
continue when get_lock_data_page returns -ENOENT, but it forgets to
reset err to 0.

This will cause getdents64 incorretly return -ENOENT when lastdirent is
NULL in getdents64. This will lead to a wrong return value for syscall
caller.

Signed-off-by: Yunlong Song <yunlong.song@huawei.com>
---
 fs/f2fs/dir.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
index 0ad7b9a..3ed6145 100644
--- a/fs/f2fs/dir.c
+++ b/fs/f2fs/dir.c
@@ -886,6 +886,7 @@ static int f2fs_readdir(struct file *file, struct dir_context *ctx)
 		kunmap(dentry_page);
 		f2fs_put_page(dentry_page, 1);
 	}
+	err = 0;
 out:
 	fscrypt_fname_free_buffer(&fstr);
 	return err;
-- 
1.8.5.2
