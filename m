From: Sheng Yong <shengyong1@huawei.com>
Subject: [PATCH v2] f2fs: fix race between write_checkpoint and
 write_begin
Date: Wed, 14 Nov 2018 19:34:28 +0800
Message-ID: <20181114113428.39780-1-shengyong1@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <shengyong1@huawei.com>) id 1gMtRj-0004Qu-KH
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 14 Nov 2018 11:34:59 +0000
Received: from szxga04-in.huawei.com ([45.249.212.190] helo=huawei.com)
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1gMtRT-008Xde-LN
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 14 Nov 2018 11:34:59 +0000
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: yuchao0@huawei.com, jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net

The following race could lead to inconsistent SIT bitmap:

Task A                          Task B
======                          ======
f2fs_write_checkpoint
  block_operations
    f2fs_lock_all
      down_write(node_change)
      down_write(node_write)
      ... sync ...
      up_write(node_change)
                                f2fs_file_write_iter
                                  set_inode_flag(FI_NO_PREALLOC)
                                  ......
                                  f2fs_write_begin(index=0, has inline data)
                                    prepare_write_begin
                                      __do_map_lock(AIO) => down_read(node_change)
                                      f2fs_convert_inline_page => update SIT
                                      __do_map_lock(AIO) => up_read(node_change)
  f2fs_flush_sit_entries <= inconsistent SIT
  finish write checkpoint
  sudden-power-off

If SPO occurs after checkpoint is finished, SIT bitmap will be set
incorrectly.

Signed-off-by: Sheng Yong <shengyong1@huawei.com>
---
v2->v1:
Sorry for late. We can use f2fs_lock_op directly, but it makes it a bit
complicate to unlock. So v2 still uses __do_map_lock with different flags
to avoid race.

Use F2FS_GET_BLOCK_PRE_AIO and F2FS_GET_BLOCK_DEFAULT to tell different
condition.

Thanks
---
 fs/f2fs/data.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 6e0ffb1749ca..4abd47d82cdb 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -2376,6 +2376,7 @@ static int prepare_write_begin(struct f2fs_sb_info *sbi,
 	struct page *ipage;
 	bool locked = false;
 	struct extent_info ei = {0,0,0};
+	int flag = F2FS_GET_BLOCK_PRE_AIO;
 	int err = 0;
 
 	/*
@@ -2386,9 +2387,12 @@ static int prepare_write_begin(struct f2fs_sb_info *sbi,
 			!is_inode_flag_set(inode, FI_NO_PREALLOC))
 		return 0;
 
+	if (f2fs_has_inline_data(inode) && pos + len > MAX_INLINE_DATA(inode))
+		/* avoid race between write CP and convert_inline_page */
+		flag = F2FS_GET_BLOCK_DEFAULT;
 	if (f2fs_has_inline_data(inode) ||
 			(pos & PAGE_MASK) >= i_size_read(inode)) {
-		__do_map_lock(sbi, F2FS_GET_BLOCK_PRE_AIO, true);
+		__do_map_lock(sbi, flag, true);
 		locked = true;
 	}
 restart:
@@ -2424,8 +2428,8 @@ static int prepare_write_begin(struct f2fs_sb_info *sbi,
 			err = f2fs_get_dnode_of_data(&dn, index, LOOKUP_NODE);
 			if (err || dn.data_blkaddr == NULL_ADDR) {
 				f2fs_put_dnode(&dn);
-				__do_map_lock(sbi, F2FS_GET_BLOCK_PRE_AIO,
-								true);
+				flag = F2FS_GET_BLOCK_PRE_AIO;
+				__do_map_lock(sbi, flag, true);
 				locked = true;
 				goto restart;
 			}
@@ -2439,7 +2443,7 @@ static int prepare_write_begin(struct f2fs_sb_info *sbi,
 	f2fs_put_dnode(&dn);
 unlock_out:
 	if (locked)
-		__do_map_lock(sbi, F2FS_GET_BLOCK_PRE_AIO, false);
+		__do_map_lock(sbi, flag, false);
 	return err;
 }
 
-- 
2.17.1
