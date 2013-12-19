From: Jaegeuk Kim <jaegeuk.kim@samsung.com>
Subject: [PATCH] f2fs: add description about small_discards in document
Date: Thu, 19 Dec 2013 17:49:13 +0900
Message-ID: <1387442953-13476-1-git-send-email-jaegeuk.kim@samsung.com>
Return-path: <linux-fsdevel-owner@vger.kernel.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Cc: Jaegeuk Kim <jaegeuk.kim@samsung.com>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

This patch adds a description about small_disacrds in the f2fs document.

Signed-off-by: Jaegeuk Kim <jaegeuk.kim@samsung.com>
---
 Documentation/filesystems/f2fs.txt | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/filesystems/f2fs.txt b/Documentation/filesystems/f2fs.txt
index 6de2102..1073970 100644
--- a/Documentation/filesystems/f2fs.txt
+++ b/Documentation/filesystems/f2fs.txt
@@ -173,6 +173,12 @@ Files in /sys/fs/f2fs/<devname>
 			      conduct checkpoint to reclaim the prefree segments
 			      to free segments. By default, 100 segments, 200MB.
 
+ max_small_discards	      This parameter controls the number of discard
+			      commands that consist small blocks less than 2MB.
+			      The candidates to be discarded are cached until
+			      checkpoint is triggered, and issued during the
+			      checkpoint. By default, it is disabled with 0.
+
  ipu_policy                   This parameter controls the policy of in-place
                               updates in f2fs. There are five policies:
                                0: F2FS_IPU_FORCE, 1: F2FS_IPU_SSR,
-- 
1.8.4.474.g128a96c

