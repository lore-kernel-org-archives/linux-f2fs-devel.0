From: zhengliang <zhengliang6@huawei.com>
Subject: [PATCH v4] f2fs: fix to data block override node segment
 by mistake
Date: Mon, 4 Mar 2019 09:32:25 +0800
Message-ID: <46bb1ca2-e768-274b-6d98-3ff4323abd1f@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <zhengliang6@huawei.com>) id 1h0cTZ-0004lz-6o
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 04 Mar 2019 01:33:05 +0000
Received: from szxga04-in.huawei.com ([45.249.212.190] helo=huawei.com)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1h0cTX-002GAu-4j
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 04 Mar 2019 01:33:05 +0000
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

v4: Rearrange the previous three versions.

The following scenario could lead to data block override by mistake.

TASK A            |  TASK kworker                                            |     TASK B                                            |       TASK C
                  |                                                          |                                                       |
open              |                                                          |                                                       |
write             |                                                          |                                                       |
close             |                                                          |                                                       |
                  |  f2fs_write_data_pages                                   |                                                       |
                  |    f2fs_write_cache_pages                                |                                                       |
                  |      f2fs_outplace_write_data                            |                                                       |
                  |        f2fs_allocate_data_block (get block in seg S,     |                                                       |
                  |                                  S is full, and only     |                                                       |
                  |                                  have this valid data    |                                                       |
                  |                                  block)                  |                                                       |
                  |          allocate_segment                                |                                                       |
                  |          locate_dirty_segment (mark S as PRE)            |                                                       |
                  |        f2fs_submit_page_write (submit but is not         |                                                       |
                  |                                written on dev)           |                                                       |
unlink            |                                                          |                                                       |
 iput_final       |                                                          |                                                       |
  f2fs_drop_inode |                                                          |                                                       |
    f2fs_truncate |                                                          |                                                       |
 (not evict)      |                                                          |                                                       |
                  |                                                          | write_checkpoint                                      |
                  |                                                          |  flush merged bio but not wait file data writeback    |
                  |                                                          |  set_prefree_as_free (mark S as FREE)                 |
                  |                                                          |                                                       | update NODE/DATA
                  |                                                          |                                                       | allocate_segment (select S)
                  |     writeback done                                       |                                                       |

So we need to guarantee io complete before truncate inode in f2fs_drop_inode.

Reviewed-by: Chao Yu <yuchao0@huawei.com>
Signed-off-by: Zheng Liang <zhengliang6@huawei.com>
--------
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index c46a1d43..60f0599 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -915,6 +915,10 @@ static int f2fs_drop_inode(struct inode *inode)
                        sb_start_intwrite(inode->i_sb);
                        f2fs_i_size_write(inode, 0);

+                       f2fs_submit_merged_write_cond(F2FS_I_SB(inode),
+                                       inode, NULL, 0, DATA);
+                       truncate_inode_pages_final(inode->i_mapping);
+
                        if (F2FS_HAS_BLOCKS(inode))
                                f2fs_truncate(inode);
