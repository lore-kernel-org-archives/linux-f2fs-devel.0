From: Chao Yu <chao2.yu@samsung.com>
Subject: [f2fs-dev] [PATCH 2/2] f2fs: avoid unneeded lookup when xattr name
 length is too long
Date: Sat, 22 Mar 2014 14:59:45 +0800
Message-ID: <000d01cf459c$68d4e070$3a7ea150$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-fsdevel-owner@vger.kernel.org>
Content-language: zh-cn
Sender: linux-fsdevel-owner@vger.kernel.org
To: ??? <jaegeuk.kim@samsung.com>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

In f2fs_setxattr we have limit this attribute name length, so we should also
check it in f2fs_getxattr to avoid useless lookup caused by invalid name length.

Signed-off-by: Chao Yu <chao2.yu@samsung.com>
---
 fs/f2fs/xattr.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/f2fs/xattr.c b/fs/f2fs/xattr.c
index 0121e45..503c245 100644
--- a/fs/f2fs/xattr.c
+++ b/fs/f2fs/xattr.c
@@ -407,6 +407,8 @@ int f2fs_getxattr(struct inode *inode, int name_index, const char *name,
 	if (name == NULL)
 		return -EINVAL;
 	name_len = strlen(name);
+	if (name_len > F2FS_NAME_LEN)
+		return -ERANGE;
 
 	base_addr = read_all_xattrs(inode, NULL);
 	if (!base_addr)
-- 
1.7.9.5


