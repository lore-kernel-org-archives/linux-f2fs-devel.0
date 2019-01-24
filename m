From: Chao Yu <yuchao0@huawei.com>
Subject: [PATCH] f2fs: fix to document inline_xattr_size option
Date: Thu, 24 Jan 2019 17:18:07 +0800
Message-ID: <20190124091807.89080-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, chao@kernel.org, Chao Yu <yuchao0@huawei.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

We missed to add document for inline_xattr_size mount option in f2fs.txt,
add it.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 Documentation/filesystems/f2fs.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/filesystems/f2fs.txt b/Documentation/filesystems/f2fs.txt
index e46c2147ddf8..f7b5e4ff0de3 100644
--- a/Documentation/filesystems/f2fs.txt
+++ b/Documentation/filesystems/f2fs.txt
@@ -126,6 +126,8 @@ disable_ext_identify   Disable the extension list configured by mkfs, so f2fs
                        does not aware of cold files such as media files.
 inline_xattr           Enable the inline xattrs feature.
 noinline_xattr         Disable the inline xattrs feature.
+inline_xattr_size=%u   Support configuring inline xattr size, it depends on
+		       flexible inline xattr feature.
 inline_data            Enable the inline data feature: New created small(<~3.4k)
                        files can be written into inode block.
 inline_dentry          Enable the inline dir feature: data in new created
-- 
2.18.0.rc1
