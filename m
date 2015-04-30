From: Chao Yu <chao2.yu@samsung.com>
Subject: [PATCH 1/2] f2fs: remove unneeded f2fs_make_empty declaration
Date: Thu, 30 Apr 2015 18:34:41 +0800
Message-ID: <025801d08331$5dbc6bd0$19354370$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-language: zh-cn
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>, Changman Lee <cm224.lee@samsung.com>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

Remove f2fs_make_empty() declaration, since the main body of this function
is move into do_make_empty_dir() and the function is obsolete now.

Signed-off-by: Chao Yu <chao2.yu@samsung.com>
---
 fs/f2fs/f2fs.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 8be6cab..ff1014b 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1478,7 +1478,6 @@ int __f2fs_add_link(struct inode *, const struct qstr *, struct inode *, nid_t,
 void f2fs_delete_entry(struct f2fs_dir_entry *, struct page *, struct inode *,
 							struct inode *);
 int f2fs_do_tmpfile(struct inode *, struct inode *);
-int f2fs_make_empty(struct inode *, struct inode *);
 bool f2fs_empty_dir(struct inode *);
 
 static inline int f2fs_add_link(struct dentry *dentry, struct inode *inode)
-- 
2.3.3
