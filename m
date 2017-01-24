From: Masanari Iida <standby24x7@gmail.com>
Subject: [linux-next] [PATCH] Doc: f2fs: Fix typo in Documentation/filesystems/f2fs.txt
Date: Tue, 24 Jan 2017 12:47:55 +0900
Message-ID: <20170124034755.20965-1-standby24x7@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, jaegeuk@kernel.org, yuchao0@huawei.com, linux-f2fs-devel@lists.sourceforge.net, corbet@lwn.net, linux-doc@vger.kernel.org
Cc: Masanari Iida <standby24x7@gmail.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

This patch fix a typo in f2fs.txt

Signed-off-by: Masanari Iida <standby24x7@gmail.com>
---
 Documentation/filesystems/f2fs.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/filesystems/f2fs.txt b/Documentation/filesystems/f2fs.txt
index d99faced79cb..0ab33d4c8406 100644
--- a/Documentation/filesystems/f2fs.txt
+++ b/Documentation/filesystems/f2fs.txt
@@ -131,7 +131,7 @@ inline_dentry          Enable the inline dir feature: data in new created
                        directory entries can be written into inode block. The
                        space of inode block which is used to store inline
                        dentries is limited to ~3.4k.
-noinline_dentry        Diable the inline dentry feature.
+noinline_dentry        Disable the inline dentry feature.
 flush_merge	       Merge concurrent cache_flush commands as much as possible
                        to eliminate redundant command issues. If the underlying
 		       device handles the cache_flush command relatively slowly,
-- 
2.11.0.453.g787f75f0567a
