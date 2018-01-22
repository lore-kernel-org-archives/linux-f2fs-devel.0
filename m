From: Hyunchul Lee <hyc.lee@gmail.com>
Subject: [PATCH 3/3] f2fs: Add the 'whint_mode' mount option to f2fs documentation
Date: Mon, 22 Jan 2018 19:49:09 +0900
Message-ID: <1516618149-1495-4-git-send-email-hyc.lee@gmail.com>
References: <1516618149-1495-1-git-send-email-hyc.lee@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1516618149-1495-1-git-send-email-hyc.lee@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, kernel-team@lge.com, Hyunchul Lee <cheol.lee@lge.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

From: Hyunchul Lee <cheol.lee@lge.com>

Signed-off-by: Hyunchul Lee <cheol.lee@lge.com>
---
 Documentation/filesystems/f2fs.txt | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/filesystems/f2fs.txt b/Documentation/filesystems/f2fs.txt
index 13c2ff0..414a160 100644
--- a/Documentation/filesystems/f2fs.txt
+++ b/Documentation/filesystems/f2fs.txt
@@ -174,6 +174,12 @@ offgrpjquota           Turn off group journelled quota.
 offprjjquota           Turn off project journelled quota.
 quota                  Enable plain user disk quota accounting.
 noquota                Disable all plain disk quota option.
+whint_mode=%s          Control which write hints are passed down to block
+                       layer. This supports "off", "user-based", and
+                       "fs-based".  In "off" mode (default), f2fs does not pass
+                       down hints. In "user-based" mode, f2fs tries to pass
+                       down hints given by users. And in "fs-based" mode, f2fs
+                       passes down hints with its policy.
 
 ================================================================================
 DEBUGFS ENTRIES
-- 
1.9.1
