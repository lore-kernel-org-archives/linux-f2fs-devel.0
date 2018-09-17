From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 4.14 045/126] f2fs: fix defined but not used build warnings
Date: Tue, 18 Sep 2018 00:41:33 +0200
Message-ID: <20180917211707.604787292@linuxfoundation.org>
References: <20180917211703.481236999@linuxfoundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180917211703.481236999@linuxfoundation.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>, Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>, linux-f2fs-devel@lists.sourceforge.net, Sasha Levin <alexander.levin@microsoft.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Randy Dunlap <rdunlap@infradead.org>

[ Upstream commit cb15d1e43db0a6341c1e26ac6a2c74e61b74f1aa ]

Fix build warnings in f2fs when CONFIG_PROC_FS is not enabled
by marking the unused functions as __maybe_unused.

../fs/f2fs/sysfs.c:519:12: warning: 'segment_info_seq_show' defined but not used [-Wunused-function]
../fs/f2fs/sysfs.c:546:12: warning: 'segment_bits_seq_show' defined but not used [-Wunused-function]
../fs/f2fs/sysfs.c:570:12: warning: 'iostat_info_seq_show' defined but not used [-Wunused-function]

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: Chao Yu <yuchao0@huawei.com>
Cc: linux-f2fs-devel@lists.sourceforge.net
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/f2fs/sysfs.c |   10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

--- a/fs/f2fs/sysfs.c
+++ b/fs/f2fs/sysfs.c
@@ -9,6 +9,7 @@
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
  */
+#include <linux/compiler.h>
 #include <linux/proc_fs.h>
 #include <linux/f2fs_fs.h>
 #include <linux/seq_file.h>
@@ -381,7 +382,8 @@ static struct kobject f2fs_feat = {
 	.kset	= &f2fs_kset,
 };
 
-static int segment_info_seq_show(struct seq_file *seq, void *offset)
+static int __maybe_unused segment_info_seq_show(struct seq_file *seq,
+						void *offset)
 {
 	struct super_block *sb = seq->private;
 	struct f2fs_sb_info *sbi = F2FS_SB(sb);
@@ -408,7 +410,8 @@ static int segment_info_seq_show(struct
 	return 0;
 }
 
-static int segment_bits_seq_show(struct seq_file *seq, void *offset)
+static int __maybe_unused segment_bits_seq_show(struct seq_file *seq,
+						void *offset)
 {
 	struct super_block *sb = seq->private;
 	struct f2fs_sb_info *sbi = F2FS_SB(sb);
@@ -432,7 +435,8 @@ static int segment_bits_seq_show(struct
 	return 0;
 }
 
-static int iostat_info_seq_show(struct seq_file *seq, void *offset)
+static int __maybe_unused iostat_info_seq_show(struct seq_file *seq,
+					       void *offset)
 {
 	struct super_block *sb = seq->private;
 	struct f2fs_sb_info *sbi = F2FS_SB(sb);
