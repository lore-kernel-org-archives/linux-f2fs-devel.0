From: Chao Yu <yuchao0@huawei.com>
Subject: [PATCH 2/4] f2fs: fix to document fault injection option
 and sysfs file
Date: Mon, 12 Jun 2017 09:44:25 +0800
Message-ID: <20170612014427.40692-2-yuchao0@huawei.com>
References: <20170612014427.40692-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <yuchao0@huawei.com>) id 1dKEPe-0007GP-1Z
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 12 Jun 2017 01:45:02 +0000
Received: from szxga01-in.huawei.com ([45.249.212.187])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1dKEPc-00043r-P7
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 12 Jun 2017 01:45:02 +0000
In-Reply-To: <20170612014427.40692-1-yuchao0@huawei.com>
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
Cc: chao@kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

Commit 73faec4d9935 ("f2fs: add mount option to select fault injection
ratio") and Commit 087968974fcd ("f2fs: add fault injection to sysfs")
forget to document mount option and sysfs file.

This patch fixes to document them.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 Documentation/ABI/testing/sysfs-fs-f2fs | 12 ++++++++++++
 Documentation/filesystems/f2fs.txt      |  2 ++
 2 files changed, 14 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-fs-f2fs b/Documentation/ABI/testing/sysfs-fs-f2fs
index a809f6005f14..ae59451865a6 100644
--- a/Documentation/ABI/testing/sysfs-fs-f2fs
+++ b/Documentation/ABI/testing/sysfs-fs-f2fs
@@ -112,3 +112,15 @@ Date:		January 2016
 Contact:	"Shuoran Liu" <liushuoran@huawei.com>
 Description:
 		 Shows total written kbytes issued to disk.
+
+What:		/sys/fs/f2fs/<disk>/injection_rate
+Date:		May 2016
+Contact:	"Sheng Yong" <shengyong1@huawei.com>
+Description:
+		 Contrils the injection rate.
+
+What:		/sys/fs/f2fs/<disk>/injection_type
+Date:		May 2016
+Contact:	"Sheng Yong" <shengyong1@huawei.com>
+Description:
+		 Contrils the injection type.
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
2.13.1.388.g69e6b9b4f4a9


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
