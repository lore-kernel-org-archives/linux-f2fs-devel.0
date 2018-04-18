From: Yunlei He <heyunlei@huawei.com>
Subject: [PATCH v2] f2fs: allocate hot_data for atomic write more
 strictly
Date: Wed, 18 Apr 2018 11:06:39 +0800
Message-ID: <1524020799-3104-1-git-send-email-heyunlei@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <heyunlei@huawei.com>) id 1f8del-0000Lb-AM
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 18 Apr 2018 03:21:15 +0000
Received: from szxga04-in.huawei.com ([45.249.212.190] helo=huawei.com)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1f8dei-008oVb-Pp
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 18 Apr 2018 03:21:15 +0000
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: jaegeuk@kernel.org, yuchao0@huawei.com, linux-f2fs-devel@lists.sourceforge.net
Cc: zhangdianfang@huawei.com

If a file not set type as hot, has dirty pages more than
threshold 64 before starting atomic write, may be lose hot
flag.

v1->v2: move set FI_ATOMIC_FILE flag behind flush dirty pages too,
in case of dirty pages before starting atomic use atomic mode to
write back.

Signed-off-by: Yunlei He <heyunlei@huawei.com>
---
 fs/f2fs/file.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 79eeed5..78b3a58 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -1684,24 +1684,20 @@ static int f2fs_ioc_start_atomic_write(struct file *filp)
 	if (ret)
 		goto out;
 
-	set_inode_flag(inode, FI_ATOMIC_FILE);
-	set_inode_flag(inode, FI_HOT_DATA);
-	f2fs_update_time(F2FS_I_SB(inode), REQ_TIME);
-
 	if (!get_dirty_pages(inode))
-		goto inc_stat;
+		goto skip_flush;
 
 	f2fs_msg(F2FS_I_SB(inode)->sb, KERN_WARNING,
 		"Unexpected flush for atomic writes: ino=%lu, npages=%u",
 					inode->i_ino, get_dirty_pages(inode));
 	ret = filemap_write_and_wait_range(inode->i_mapping, 0, LLONG_MAX);
-	if (ret) {
-		clear_inode_flag(inode, FI_ATOMIC_FILE);
-		clear_inode_flag(inode, FI_HOT_DATA);
+	if (ret)
 		goto out;
-	}
+skip_flush:
+	set_inode_flag(inode, FI_HOT_DATA);
+	set_inode_flag(inode, FI_ATOMIC_FILE);
+	f2fs_update_time(F2FS_I_SB(inode), REQ_TIME);
 
-inc_stat:
 	F2FS_I(inode)->inmem_task = current;
 	stat_inc_atomic_write(inode);
 	stat_update_max_atomic_write(inode);
-- 
1.9.1


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
