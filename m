From: Chao Yu <chao2.yu@samsung.com>
Subject: [f2fs-dev] [PATCH] f2fs: use f2fs_put_page to release page for uniform
 style
Date: Sat, 16 Nov 2013 14:15:59 +0800
Message-ID: <000201cee293$6137cd80$23a76880$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=gb2312
Content-Transfer-Encoding: 7bit
Return-path: <linux-fsdevel-owner@vger.kernel.org>
Content-language: zh-cn
Sender: linux-fsdevel-owner@vger.kernel.org
To: ??? <jaegeuk.kim@samsung.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, =?gb2312?B?zLfmrQ==?= <shu.tan@samsung.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

We should use f2fs_put_page to release page for uniform style of f2fs code.

Signed-off-by: Chao Yu <chao2.yu@samsung.com>
---
 fs/f2fs/data.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index aa3438c..076a60c 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -714,8 +714,7 @@ static int f2fs_write_end(struct file *file,
 		update_inode_page(inode);
 	}
 
-	unlock_page(page);
-	page_cache_release(page);
+	f2fs_put_page(page, 1);
 	return copied;
 }
 
-- 
1.7.9.5


