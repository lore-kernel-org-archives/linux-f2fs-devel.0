From: Junling Zheng <zhengjunling@huawei.com>
Subject: [PATCH v2] fsck.f2fs: do not print content beyond
 sb->version
Date: Fri, 8 Jun 2018 13:11:48 +0800
Message-ID: <20180608051148.34512-1-zhengjunling@huawei.com>
References: <20180606143924.154725-1-zhengjunling@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <zhengjunling@huawei.com>) id 1fR9h9-0006bs-VL
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 08 Jun 2018 05:12:15 +0000
Received: from szxga04-in.huawei.com ([45.249.212.190] helo=huawei.com)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1fR9h7-003RYU-Tr
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 08 Jun 2018 05:12:15 +0000
In-Reply-To: <20180606143924.154725-1-zhengjunling@huawei.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: jaegeuk@kernel.org, yuchao0@huawei.com
Cc: miaoxie@huawei.com, linux-f2fs-devel@lists.sourceforge.net

Currently, versions in f2fs_configuration have one more byte than
those in sb, so versions in sb may not end with '\0', and then
print_raw_sb_info() will print something beyond sb->version.

Signed-off-by: Junling Zheng <zhengjunling@huawei.com>
---
 fsck/mount.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fsck/mount.c b/fsck/mount.c
index 0a30adb..66b4a5d 100644
--- a/fsck/mount.c
+++ b/fsck/mount.c
@@ -341,7 +341,7 @@ void print_raw_sb_info(struct f2fs_super_block *sb)
 	DISP_u32(sb, node_ino);
 	DISP_u32(sb, meta_ino);
 	DISP_u32(sb, cp_payload);
-	DISP("%s", sb, version);
+	DISP("%-.256s", sb, version);
 	printf("\n");
 }
 
-- 
2.17.0


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
