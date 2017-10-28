From: Chao Yu <yuchao0@huawei.com>
Subject: [PATCH 1/5] f2fs: add missing sysfs description
Date: Sat, 28 Oct 2017 16:52:29 +0800
Message-ID: <20171028085233.34488-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
 helo=mx.sourceforge.net)
 by sfs-ml-2.v29.ch3.sourceforge.com with esmtps (TLSv1:DHE-RSA-AES256-SHA:256)
 (Exim 4.89) (envelope-from <yuchao0@huawei.com>) id 1e8MrZ-000801-06
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 28 Oct 2017 08:53:05 +0000
Received: from [45.249.212.32] (helo=huawei.com)
 by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
 id 1e8MrX-0006aH-Jt
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 28 Oct 2017 08:53:04 +0000
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: jaegeuk@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

There are some missing sysfs entries' description in document, add them.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 Documentation/ABI/testing/sysfs-fs-f2fs | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-fs-f2fs b/Documentation/ABI/testing/sysfs-fs-f2fs
index 11b7f4ebea7c..b7160b29b91d 100644
--- a/Documentation/ABI/testing/sysfs-fs-f2fs
+++ b/Documentation/ABI/testing/sysfs-fs-f2fs
@@ -51,6 +51,12 @@ Description:
 		 Controls the dirty page count condition for the in-place-update
 		 policies.
 
+What:		/sys/fs/f2fs/<disk>/min_hot_blocks
+Date:		March 2017
+Contact:	"Jaegeuk Kim" <jaegeuk@kernel.org>
+Description:
+		 Controls the dirty page count condition for redefining hot data.
+
 What:		/sys/fs/f2fs/<disk>/max_small_discards
 Date:		November 2013
 Contact:	"Jaegeuk Kim" <jaegeuk.kim@samsung.com>
@@ -102,6 +108,12 @@ Contact:	"Jaegeuk Kim" <jaegeuk@kernel.org>
 Description:
 		 Controls the idle timing.
 
+What:		/sys/fs/f2fs/<disk>/iostat_enable
+Date:		August 2017
+Contact:	"Chao Yu" <yuchao0@huawei.com>
+Description:
+		 Controls to enable/disable IO stat.
+
 What:		/sys/fs/f2fs/<disk>/ra_nid_pages
 Date:		October 2015
 Contact:	"Chao Yu" <chao2.yu@samsung.com>
@@ -122,6 +134,12 @@ Contact:	"Shuoran Liu" <liushuoran@huawei.com>
 Description:
 		 Shows total written kbytes issued to disk.
 
+What:		/sys/fs/f2fs/<disk>/feature
+Date:		July 2017
+Contact:	"Jaegeuk Kim" <jaegeuk@kernel.org>
+Description:
+		 Shows all enabled features in current device.
+
 What:		/sys/fs/f2fs/<disk>/inject_rate
 Date:		May 2016
 Contact:	"Sheng Yong" <shengyong1@huawei.com>
-- 
2.13.1.388.g69e6b9b4f4a9


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
