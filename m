From: Chao Yu <chao2.yu@samsung.com>
Subject: [PATCH v2] f2fs: fix to skip recovering dot dentries in a readonly fs
Date: Wed, 30 Dec 2015 17:40:31 +0800
Message-ID: <00ef01d142e6$3802e480$a808ad80$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-language: zh-cn
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

If filesystem is readonly, leave user message info instead of recovering
inline dot inode.

Signed-off-by: Chao Yu <chao2.yu@samsung.com>
---
v2:
 - add to print message.
 fs/f2fs/namei.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
index 6c4a943..a629af5 100644
--- a/fs/f2fs/namei.c
+++ b/fs/f2fs/namei.c
@@ -214,6 +214,13 @@ static int __recover_dot_dentries(struct inode *dir, nid_t pino)
 	struct page *page;
 	int err = 0;
 
+	if (f2fs_readonly(sbi->sb)) {
+		f2fs_msg(sbi->sb, KERN_INFO,
+			"skip recovering inline_dots inode (ino:%lu, pino:%u) "
+			"in readonly mountpoint", dir->i_ino, pino);
+		return 0;
+	}
+
 	f2fs_balance_fs(sbi);
 
 	f2fs_lock_op(sbi);
-- 
2.6.3
