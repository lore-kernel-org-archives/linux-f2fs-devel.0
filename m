From: Chao Yu <chao2.yu@samsung.com>
Subject: [f2fs-dev][PATCH 6/6 v2] f2fs: update f2fs documentation for inline
 dir support
Date: Wed, 24 Sep 2014 18:20:23 +0800
Message-ID: <004101cfd7e1$46710860$d3531920$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-language: zh-cn
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>, Changman Lee <cm224.lee@samsung.com>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

This patch adds descriptions for the inline dir support in f2fs document.

Signed-off-by: Chao Yu <chao2.yu@samsung.com>
---
 Documentation/filesystems/f2fs.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/filesystems/f2fs.txt b/Documentation/filesystems/f2fs.txt
index 2cca5a2..4bb9f27 100644
--- a/Documentation/filesystems/f2fs.txt
+++ b/Documentation/filesystems/f2fs.txt
@@ -122,6 +122,10 @@ disable_ext_identify   Disable the extension list configured by mkfs, so f2fs
 inline_xattr           Enable the inline xattrs feature.
 inline_data            Enable the inline data feature: New created small(<~3.4k)
                        files can be written into inode block.
+inline_dentry          Enable the inline dir feature: data in new created
+                       directory entries can be written into inode block. The
+                       space of inode block which is used to store inline
+                       dentries is limited to ~3.4k.
 flush_merge	       Merge concurrent cache_flush commands as much as possible
                        to eliminate redundant command issues. If the underlying
 		       device handles the cache_flush command relatively slowly,
-- 
2.0.1.474.g72c7794
