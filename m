From: Chao Yu <yuchao0@huawei.com>
Subject: [PATCH 2/2] f2fs: clean up unneeded declaration
Date: Wed, 3 Jan 2018 17:32:51 +0800
Message-ID: <20180103093251.13597-2-yuchao0@huawei.com>
References: <20180103093251.13597-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180103093251.13597-1-yuchao0@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, chao@kernel.org, Chao Yu <yuchao0@huawei.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

Commit 6afc662e68b5 ("f2fs: support flexible inline xattr size")
declared f2fs_sb_has_flexible_inline_xattr in f2fs.h for latter being
used in get_inline_xattr_addrs, but in latter version, related code
has been changed, leave f2fs_sb_has_flexible_inline_xattr w/o any
users. Let's remove it for cleanup.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/f2fs.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index ad19d29688ae..c082ae905f08 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -2449,7 +2449,6 @@ static inline int get_extra_isize(struct inode *inode)
 	return F2FS_I(inode)->i_extra_isize / sizeof(__le32);
 }
 
-static inline int f2fs_sb_has_flexible_inline_xattr(struct super_block *sb);
 static inline int get_inline_xattr_addrs(struct inode *inode)
 {
 	return F2FS_I(inode)->i_inline_xattr_size;
-- 
2.15.0.55.gc2ece9dc4de6
