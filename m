From: Chao Yu <chao2.yu@samsung.com>
Subject: [PATCH 4/4] f2fs: fix incorrectly stat number of inline data inode
Date: Mon, 16 Feb 2015 16:20:27 +0800
Message-ID: <006701d049c1$7a323190$6e9694b0$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-language: zh-cn
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>, Changman Lee <cm224.lee@samsung.com>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

We should stat inline data information for temp file in f2fs_tmpfile if we
enable inline_data feature.

Otherwise, inline data stat number will be wrong after this temp file is
evicted.

Signed-off-by: Chao Yu <chao2.yu@samsung.com>
---
 fs/f2fs/namei.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
index e79639a9..1e2ae21 100644
--- a/fs/f2fs/namei.c
+++ b/fs/f2fs/namei.c
@@ -693,6 +693,8 @@ static int f2fs_tmpfile(struct inode *dir, struct dentry *dentry, umode_t mode)
 	f2fs_unlock_op(sbi);
 
 	alloc_nid_done(sbi, inode->i_ino);
+
+	stat_inc_inline_inode(inode);
 	d_tmpfile(dentry, inode);
 	unlock_new_inode(inode);
 	return 0;
-- 
2.2.1
