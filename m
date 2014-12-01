From: Chao Yu <chao2.yu@samsung.com>
Subject: [f2fs-dev][PATCH] f2fs: fix to return correct error number in
 f2fs_write_begin
Date: Mon, 01 Dec 2014 11:30:20 +0800
Message-ID: <002001d00d17$41d48500$c57d8f00$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-language: zh-cn
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>, Changman Lee <cm224.lee@samsung.com>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

Fix the wrong error number in error path of f2fs_write_begin.

Signed-off-by: Chao Yu <chao2.yu@samsung.com>
---
 fs/f2fs/data.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index c7bc626..7ec697b 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -960,8 +960,10 @@ repeat:
 
 	/* check inline_data */
 	ipage = get_node_page(sbi, inode->i_ino);
-	if (IS_ERR(ipage))
+	if (IS_ERR(ipage)) {
+		err = PTR_ERR(ipage);
 		goto unlock_fail;
+	}
 
 	set_new_dnode(&dn, inode, ipage, ipage, 0);
 
-- 
2.1.2
