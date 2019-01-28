From: Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.14 047/170] f2fs: fix race between
 write_checkpoint and write_begin
Date: Mon, 28 Jan 2019 11:09:57 -0500
Message-ID: <20190128161200.55107-47-sashal@kernel.org>
References: <20190128161200.55107-1-sashal@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <sashal@kernel.org>) id 1go9Xz-0002ep-Hh
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 28 Jan 2019 16:14:07 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1go9Xu-003UJ0-02
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 28 Jan 2019 16:14:07 +0000
In-Reply-To: <20190128161200.55107-1-sashal@kernel.org>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>, Jaegeuk Kim <jaegeuk@kernel.org>, linux-f2fs-devel@lists.sourceforge.net

From: Sheng Yong <shengyong1@huawei.com>

[ Upstream commit 2866fb16d67992195b0526d19e65acb6640fb87f ]

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
Reviewed-by: Chao Yu <yuchao0@huawei.com>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/data.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index c68b319b07aa..3d37124eb63e 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -1880,6 +1880,7 @@ static int prepare_write_begin(struct f2fs_sb_info *sbi,
 	bool locked = false;
 	struct extent_info ei = {0,0,0};
 	int err = 0;
+	int flag;
 
 	/*
 	 * we already allocated all the blocks, so we don't need to get
@@ -1889,9 +1890,15 @@ static int prepare_write_begin(struct f2fs_sb_info *sbi,
 			!is_inode_flag_set(inode, FI_NO_PREALLOC))
 		return 0;
 
+	/* f2fs_lock_op avoids race between write CP and convert_inline_page */
+	if (f2fs_has_inline_data(inode) && pos + len > MAX_INLINE_DATA(inode))
+		flag = F2FS_GET_BLOCK_DEFAULT;
+	else
+		flag = F2FS_GET_BLOCK_PRE_AIO;
+
 	if (f2fs_has_inline_data(inode) ||
 			(pos & PAGE_MASK) >= i_size_read(inode)) {
-		__do_map_lock(sbi, F2FS_GET_BLOCK_PRE_AIO, true);
+		__do_map_lock(sbi, flag, true);
 		locked = true;
 	}
 restart:
@@ -1929,6 +1936,7 @@ static int prepare_write_begin(struct f2fs_sb_info *sbi,
 				f2fs_put_dnode(&dn);
 				__do_map_lock(sbi, F2FS_GET_BLOCK_PRE_AIO,
 								true);
+				WARN_ON(flag != F2FS_GET_BLOCK_PRE_AIO);
 				locked = true;
 				goto restart;
 			}
@@ -1942,7 +1950,7 @@ static int prepare_write_begin(struct f2fs_sb_info *sbi,
 	f2fs_put_dnode(&dn);
 unlock_out:
 	if (locked)
-		__do_map_lock(sbi, F2FS_GET_BLOCK_PRE_AIO, false);
+		__do_map_lock(sbi, flag, false);
 	return err;
 }
 
-- 
2.19.1
