From: Jaegeuk Kim <jaegeuk.kim@samsung.com>
Subject: [PATCH] f2fs: update f2fs document
Date: Fri, 01 Nov 2013 11:21:15 +0900
Message-ID: <1383272475-5023-1-git-send-email-jaegeuk.kim@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Cc: Jaegeuk Kim <jaegeuk.kim@samsung.com>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

This patch describes the inline_xattr support in f2fs document.

Signed-off-by: Jaegeuk Kim <jaegeuk.kim@samsung.com>
---
 Documentation/filesystems/f2fs.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/filesystems/f2fs.txt b/Documentation/filesystems/f2fs.txt
index 4c647c2..a3fe811 100644
--- a/Documentation/filesystems/f2fs.txt
+++ b/Documentation/filesystems/f2fs.txt
@@ -119,6 +119,7 @@ active_logs=%u         Support configuring the number of active logs. In the
                        Default number is 6.
 disable_ext_identify   Disable the extension list configured by mkfs, so f2fs
                        does not aware of cold files such as media files.
+inline_xattr           Enable the inline xattrs feature.
 
 ================================================================================
 DEBUGFS ENTRIES
-- 
1.8.4.474.g128a96c
