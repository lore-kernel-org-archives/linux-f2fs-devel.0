From: Chao Yu <yuchao0@huawei.com>
Subject: [PATCH 5/5] f2fs: clean up ioctl interface naming
Date: Tue, 17 Jul 2018 20:41:49 +0800
Message-ID: <20180717124149.32523-5-yuchao0@huawei.com>
References: <20180717124149.32523-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <yuchao0@huawei.com>) id 1ffPJk-0001da-6B
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 17 Jul 2018 12:43:00 +0000
Received: from szxga04-in.huawei.com ([45.249.212.190] helo=huawei.com)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1ffPJi-00Ahu3-8H
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 17 Jul 2018 12:43:00 +0000
In-Reply-To: <20180717124149.32523-1-yuchao0@huawei.com>
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

Romve redundant prefix 'f2fs_' in the middle of f2fs_ioc_f2fs_write_checkpoint().

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/file.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 3a31b4e6d2dc..c6e3c0f751de 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -2125,7 +2125,7 @@ static int f2fs_ioc_gc_range(struct file *filp, unsigned long arg)
 	return ret;
 }
 
-static int f2fs_ioc_f2fs_write_checkpoint(struct file *filp, unsigned long arg)
+static int f2fs_ioc_write_checkpoint(struct file *filp, unsigned long arg)
 {
 	struct inode *inode = file_inode(filp);
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
@@ -2906,7 +2906,7 @@ long f2fs_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 	case F2FS_IOC_GARBAGE_COLLECT_RANGE:
 		return f2fs_ioc_gc_range(filp, arg);
 	case F2FS_IOC_WRITE_CHECKPOINT:
-		return f2fs_ioc_f2fs_write_checkpoint(filp, arg);
+		return f2fs_ioc_write_checkpoint(filp, arg);
 	case F2FS_IOC_DEFRAGMENT:
 		return f2fs_ioc_defragment(filp, arg);
 	case F2FS_IOC_MOVE_RANGE:
-- 
2.18.0.rc1


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
