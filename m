From: Sasha Levin via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Subject: [PATCH AUTOSEL 4.14 28/89] f2fs: fix defined but not
 used build warnings
Date: Sun, 2 Sep 2018 13:06:41 +0000
Message-ID: <20180902064918.183387-28-alexander.levin@microsoft.com>
References: <20180902064918.183387-1-alexander.levin@microsoft.com>
Reply-To: Sasha Levin <Alexander.Levin@microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <Alexander.Levin@microsoft.com>) id 1fwS60-0003On-CX
 for linux-f2fs-devel@lists.sourceforge.net; Sun, 02 Sep 2018 13:07:16 +0000
Received: from mail-by2nam03on0101.outbound.protection.outlook.com
 ([104.47.42.101] helo=NAM03-BY2-obe.outbound.protection.outlook.com)
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-SHA384:256) (Exim 4.90_1)
 id 1fwS5x-006JMT-DT
 for linux-f2fs-devel@lists.sourceforge.net; Sun, 02 Sep 2018 13:07:16 +0000
In-Reply-To: <20180902064918.183387-1-alexander.levin@microsoft.com>
Content-Language: en-US
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: "stable@vger.kernel.org" <stable@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: Sasha Levin <Alexander.Levin@microsoft.com>, Jaegeuk Kim <jaegeuk@kernel.org>, Randy Dunlap <rdunlap@infradead.org>, "linux-f2fs-devel@lists.sourceforge.net" <linux-f2fs-devel@lists.sourceforge.net>

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
---
 fs/f2fs/sysfs.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
index e2c258f717cd..93af9d7dfcdc 100644
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
@@ -408,7 +410,8 @@ static int segment_info_seq_show(struct seq_file *seq, void *offset)
 	return 0;
 }
 
-static int segment_bits_seq_show(struct seq_file *seq, void *offset)
+static int __maybe_unused segment_bits_seq_show(struct seq_file *seq,
+						void *offset)
 {
 	struct super_block *sb = seq->private;
 	struct f2fs_sb_info *sbi = F2FS_SB(sb);
@@ -432,7 +435,8 @@ static int segment_bits_seq_show(struct seq_file *seq, void *offset)
 	return 0;
 }
 
-static int iostat_info_seq_show(struct seq_file *seq, void *offset)
+static int __maybe_unused iostat_info_seq_show(struct seq_file *seq,
+					       void *offset)
 {
 	struct super_block *sb = seq->private;
 	struct f2fs_sb_info *sbi = F2FS_SB(sb);
-- 
2.17.1

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
