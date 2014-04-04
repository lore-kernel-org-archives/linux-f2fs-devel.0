From: Chao Yu <chao2.yu@samsung.com>
Subject: [f2fs-dev] [PATCH] f2fs: fix wrong statistics of inline data
Date: Fri, 04 Apr 2014 17:06:33 +0800
Message-ID: <000001cf4fe5$4e9d4af0$ebd7e0d0$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-fsdevel-owner@vger.kernel.org>
Content-language: zh-cn
Sender: linux-fsdevel-owner@vger.kernel.org
To: ??? <jaegeuk.kim@samsung.com>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

If we remove a file that has inline data after mount, our statistics turns to
inaccurate.

cat /sys/kernel/debug/f2fs/status
  - Inline_data Inode: 4294967295

Let's add stat_inc_inline_inode() to stat inline info of the file when lookup.

Signed-off-by: Chao Yu <chao2.yu@samsung.com>
---
 fs/f2fs/inode.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
index 0d8e4a2..4f1c225 100644
--- a/fs/f2fs/inode.c
+++ b/fs/f2fs/inode.c
@@ -112,6 +112,8 @@ static int do_read_inode(struct inode *inode)
 	get_extent_info(&fi->ext, ri->i_ext);
 	get_inline_info(fi, ri);
 
+	stat_inc_inline_inode(inode);
+
 	/* get rdev by using inline_info */
 	__get_inode_rdev(inode, ri);
 
-- 
1.7.9.5


