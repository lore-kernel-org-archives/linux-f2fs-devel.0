From: Chao Yu <yuchao0@huawei.com>
Subject: [PATCH 1/2] check: recognize f2fs through parameter
Date: Sun, 30 Sep 2018 17:26:52 +0800
Message-ID: <20180930092653.122684-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <yuchao0@huawei.com>) id 1g6Y0d-0003C3-Mg
 for linux-f2fs-devel@lists.sourceforge.net; Sun, 30 Sep 2018 09:27:27 +0000
Received: from szxga06-in.huawei.com ([45.249.212.32] helo=huawei.com)
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1g6Y0b-009VM4-2J
 for linux-f2fs-devel@lists.sourceforge.net; Sun, 30 Sep 2018 09:27:27 +0000
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: fstests@vger.kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net

Add a paramenter in check to configure $FSTYP for f2fs.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 check | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/check b/check
index f3c8021d94b9..a9024094721a 100755
--- a/check
+++ b/check
@@ -59,6 +59,7 @@ check options
     -pvfs2          test PVFS2
     -tmpfs              test TMPFS
     -ubifs              test ubifs
+    -f2fs		test f2fs
     -l			line mode diff
     -udiff		show unified diff (default)
     -n			show me, do not run tests
@@ -263,6 +264,7 @@ while [ $# -gt 0 ]; do
 	-pvfs2)		FSTYP=pvfs2 ;;
 	-tmpfs)		FSTYP=tmpfs ;;
 	-ubifs)		FSTYP=ubifs ;;
+	-f2fs)		FSTYP=f2fs ;;
 
 	-g)	group=$2 ; shift ;
 		GROUP_LIST="$GROUP_LIST ${group//,/ }"
-- 
2.18.0.rc1
