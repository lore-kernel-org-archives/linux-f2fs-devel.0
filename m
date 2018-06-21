From: Chao Yu <yuchao0@huawei.com>
Subject: [PATCH] fsck.f2fs: show missing large_nat_bitmap flag in
 print_ckpt_info
Date: Thu, 21 Jun 2018 09:20:32 +0800
Message-ID: <20180621012032.96297-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <yuchao0@huawei.com>) id 1fVoIG-0007CT-Kh
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 21 Jun 2018 01:21:48 +0000
Received: from szxga04-in.huawei.com ([45.249.212.190] helo=huawei.com)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1fVoIE-004UAK-Ft
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 21 Jun 2018 01:21:48 +0000
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
Cc: linux-f2fs-devel@lists.sourceforge.net

Previously, we forget to print large_nat_bitmap according to CP flag,
fix it.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fsck/mount.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fsck/mount.c b/fsck/mount.c
index f830e9b1f72a..b4911506cddb 100644
--- a/fsck/mount.c
+++ b/fsck/mount.c
@@ -405,6 +405,8 @@ void print_ckpt_info(struct f2fs_sb_info *sbi)
 void print_cp_state(u32 flag)
 {
 	MSG(0, "Info: checkpoint state = %x : ", flag);
+	if (flag & CP_LARGE_NAT_BITMAP_FLAG)
+		MSG(0, "%s", " large_nat_bitmap");
 	if (flag & CP_NOCRC_RECOVERY_FLAG)
 		MSG(0, "%s", " allow_nocrc");
 	if (flag & CP_TRIMMED_FLAG)
-- 
2.18.0.rc1


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
