From: Chao Yu <chao@kernel.org>
Subject: [PATCH v3 2/4] f2fs: fix to document fault injection option and sysfs file
Date: Mon, 12 Jun 2017 22:30:44 +0800
Message-ID: <20170612143044.4147-1-chao@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, Chao Yu <yuchao0@huawei.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

From: Chao Yu <yuchao0@huawei.com>

Commit 73faec4d9935 ("f2fs: add mount option to select fault injection
ratio") and Commit 087968974fcd ("f2fs: add fault injection to sysfs")
forget to document mount option and sysfs file.

This patch fixes to document them.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
v3: fix typo.
 Documentation/ABI/testing/sysfs-fs-f2fs | 12 ++++++++++++
 Documentation/filesystems/f2fs.txt      |  2 ++
 2 files changed, 14 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-fs-f2fs b/Documentation/ABI/testing/sysfs-fs-f2fs
index a809f6005f14..994c88ca01d2 100644
--- a/Documentation/ABI/testing/sysfs-fs-f2fs
+++ b/Documentation/ABI/testing/sysfs-fs-f2fs
@@ -112,3 +112,15 @@ Date:		January 2016
 Contact:	"Shuoran Liu" <liushuoran@huawei.com>
 Description:
 		 Shows total written kbytes issued to disk.
+
+What:		/sys/fs/f2fs/<disk>/inject_rate
+Date:		May 2016
+Contact:	"Sheng Yong" <shengyong1@huawei.com>
+Description:
+		 Controls the injection rate.
+
+What:		/sys/fs/f2fs/<disk>/inject_type
+Date:		May 2016
+Contact:	"Sheng Yong" <shengyong1@huawei.com>
+Description:
+		 Controls the injection type.
diff --git a/Documentation/filesystems/f2fs.txt b/Documentation/filesystems/f2fs.txt
index 4f6531a4701b..8b04a6359530 100644
--- a/Documentation/filesystems/f2fs.txt
+++ b/Documentation/filesystems/f2fs.txt
@@ -155,6 +155,8 @@ noinline_data          Disable the inline data feature, inline data feature is
                        enabled by default.
 data_flush             Enable data flushing before checkpoint in order to
                        persist data of regular and symlink.
+fault_injection=%d     Enable fault injection in all supported types with
+                       specified injection rate.
 mode=%s                Control block allocation mode which supports "adaptive"
                        and "lfs". In "lfs" mode, there should be no random
                        writes towards main area.
-- 
2.13.0.90.g1eb437020
