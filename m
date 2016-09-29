From: Junling Zheng <zhengjunling@huawei.com>
Subject: [PATCH 4/4] f2fs: unify the length of versions
Date: Thu, 29 Sep 2016 18:38:37 +0800
Message-ID: <1475145517-18366-4-git-send-email-zhengjunling@huawei.com>
References: <1475145517-18366-1-git-send-email-zhengjunling@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <zhengjunling@huawei.com>) id 1bpYxN-0004fQ-NM
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 29 Sep 2016 10:52:49 +0000
Received: from szxga03-in.huawei.com ([119.145.14.66])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1bpYxM-0005SN-SF
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 29 Sep 2016 10:52:49 +0000
In-Reply-To: <1475145517-18366-1-git-send-email-zhengjunling@huawei.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: linux-f2fs-devel@lists.sourceforge.net

Currently, versions in f2fs_configuration have one more byte, so versions
in f2fs_super_block may not end with '\0', which will cause errors while
printing it in print_raw_sb_info(). Unify the length of versions to fix it.

Signed-off-by: Junling Zheng <zhengjunling@huawei.com>
---
 include/f2fs_fs.h | 6 +++---
 lib/libf2fs.c     | 4 ++--
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/f2fs_fs.h b/include/f2fs_fs.h
index 1345e2d..e666076 100644
--- a/include/f2fs_fs.h
+++ b/include/f2fs_fs.h
@@ -270,9 +270,9 @@ struct f2fs_configuration {
 	u_int64_t target_sectors;
 	u_int32_t sectors_per_blk;
 	u_int32_t blks_per_seg;
-	__u8 init_version[VERSION_LEN + 1];
-	__u8 sb_version[VERSION_LEN + 1];
-	__u8 version[VERSION_LEN + 1];
+	__u8 init_version[VERSION_LEN];
+	__u8 sb_version[VERSION_LEN];
+	__u8 version[VERSION_LEN];
 	char *vol_label;
 	int heap;
 	int32_t fd, kd;
diff --git a/lib/libf2fs.c b/lib/libf2fs.c
index 706cc34..0a9436b 100644
--- a/lib/libf2fs.c
+++ b/lib/libf2fs.c
@@ -570,11 +570,11 @@ int f2fs_dev_is_umounted(struct f2fs_configuration *c)
 void get_kernel_version(__u8 *version)
 {
 	int i;
-	for (i = 0; i < VERSION_LEN; i++) {
+	for (i = 0; i < VERSION_LEN - 1; i++) {
 		if (version[i] == '\n')
 			break;
 	}
-	memset(version + i, 0, VERSION_LEN + 1 - i);
+	memset(version + i, 0, VERSION_LEN - i);
 }
 
 int f2fs_get_device_info(struct f2fs_configuration *c)
-- 
2.7.4


------------------------------------------------------------------------------
