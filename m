From: Chao Yu <chao@kernel.org>
Subject: [PATCH 2/4] f2fs: fix to clear page private flag
Date: Fri, 29 Apr 2016 20:13:36 +0800
Message-ID: <1461932018-3272-1-git-send-email-chao@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, Chao Yu <yuchao0@huawei.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

From: Chao Yu <yuchao0@huawei.com>

Commit 28bc106b2346 ("f2fs: support revoking atomic written pages")
forgot to clear page private flag correctly, fix it.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/segment.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 770cdc9..2e6f537 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -227,6 +227,7 @@ next:
 		if (drop || recover)
 			ClearPageUptodate(page);
 		set_page_private(page, 0);
+		ClearPagePrivate(page);
 		f2fs_put_page(page, 1);
 
 		list_del(&cur->list);
-- 
2.7.2
