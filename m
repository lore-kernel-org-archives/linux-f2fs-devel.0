From: Chao Yu <yuchao0@huawei.com>
Subject: [PATCH 2/2] common/quota: adapt _require_prjquota() for
 f2fs
Date: Sun, 30 Sep 2018 17:26:53 +0800
Message-ID: <20180930092653.122684-2-yuchao0@huawei.com>
References: <20180930092653.122684-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <yuchao0@huawei.com>) id 1g6Y0d-0006rE-KQ
 for linux-f2fs-devel@lists.sourceforge.net; Sun, 30 Sep 2018 09:27:27 +0000
Received: from szxga04-in.huawei.com ([45.249.212.190] helo=huawei.com)
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1g6Y0c-009VM7-6v
 for linux-f2fs-devel@lists.sourceforge.net; Sun, 30 Sep 2018 09:27:27 +0000
In-Reply-To: <20180930092653.122684-1-yuchao0@huawei.com>
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

In _require_prjquota(), let's check project quota support as below for
f2fs:
- For image support, check 'project_quota' on enabled feature list of
specified device.
- For kernel support, check /sys/fs/f2fs/features/project_quota sysfs
entry status.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 common/quota | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/common/quota b/common/quota
index 9ab091817804..9b8641350a4d 100644
--- a/common/quota
+++ b/common/quota
@@ -82,6 +82,13 @@ _require_prjquota()
 	dumpe2fs -h $_dev 2>&1 | grep -qw project || \
 		_notrun "Project quota not available on this $FSTYP"
     fi
+    if [ "$FSTYP" == "f2fs" ]; then
+	dump.f2fs $_dev 2>&1 | grep -qw project_quota
+	[ $? -ne 0 ] && _notrun "Project quota not enabled in this device $_dev"
+	cat /sys/fs/f2fs/features/project_quota | grep -qw supported
+	[ $? -ne 0 ] && _notrun "Installed kernel does not support project quotas"
+	return
+    fi
     src/feature -P $_dev
     [ $? -ne 0 ] && _notrun "Installed kernel does not support project quotas"
     if [ "$USE_EXTERNAL" = yes -a ! -z "$_dev" ]; then
-- 
2.18.0.rc1
