From: Sheng Yong <shengyong1@huawei.com>
Subject: [PATCH] f2fs: fix race between write_checkpoint and
 write_begin
Date: Mon, 12 Nov 2018 20:01:28 +0800
Message-ID: <20181112120128.96682-1-shengyong1@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <shengyong1@huawei.com>) id 1gMAus-0002st-UB
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 12 Nov 2018 12:02:06 +0000
Received: from szxga05-in.huawei.com ([45.249.212.191] helo=huawei.com)
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1gMAuf-006ci8-R6
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 12 Nov 2018 12:02:06 +0000
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
incorrectly. This patch uses node_write to avoid the race condition.

Signed-off-by: Sheng Yong <shengyong1@huawei.com>
---
 fs/f2fs/data.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 106f116466bf..dc5b251aee86 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -2355,7 +2355,9 @@ static int prepare_write_begin(struct f2fs_sb_info *sbi,
 			if (inode->i_nlink)
 				set_inline_node(ipage);
 		} else {
+			down_read(&sbi->node_write);
 			err = f2fs_convert_inline_page(&dn, page);
+			up_read(&sbi->node_write);
 			if (err)
 				goto out;
 			if (dn.data_blkaddr == NULL_ADDR)
-- 
2.17.1
