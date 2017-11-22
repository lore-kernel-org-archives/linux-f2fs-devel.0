From: Sheng Yong <shengyong1@huawei.com>
Subject: [PATCH 2/3] f2fs: still write data if preallocate only
 partial blocks
Date: Wed, 22 Nov 2017 18:23:39 +0800
Message-ID: <20171122102340.133491-2-shengyong1@huawei.com>
References: <20171122102340.133491-1-shengyong1@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.194]
 helo=mx.sourceforge.net)
 by sfs-ml-2.v29.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 (envelope-from <shengyong1@huawei.com>) id 1eHSCG-00075Y-H3
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 22 Nov 2017 10:24:00 +0000
Received: from szxga04-in.huawei.com ([45.249.212.190])
 by sfi-mx-4.v28.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
 (Exim 4.89) id 1eHSCF-0008RU-Ls
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 22 Nov 2017 10:24:00 +0000
In-Reply-To: <20171122102340.133491-1-shengyong1@huawei.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: jaegeuk@kernel.org, yuchao0@huawei.com, chao@kernel.org
Cc: shengyong1@huawei.com, linux-f2fs-devel@lists.sourceforge.net

If there is not enough space left, f2fs_preallocate_blocks may only
preallocte partial blocks. As a result, the write operation fails
but i_blocks is not 0.  To avoid this, f2fs should write data in
non-preallocation way and write as many data as the size of i_blocks.

Signed-off-by: Sheng Yong <shengyong1@huawei.com>
---
 fs/f2fs/data.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index b0781edc9ada..e593df628158 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -862,8 +862,14 @@ int f2fs_preallocate_blocks(struct kiocb *iocb, struct iov_iter *from)
 		if (err)
 			return err;
 	}
-	if (!f2fs_has_inline_data(inode))
-		return f2fs_map_blocks(inode, &map, 1, F2FS_GET_BLOCK_PRE_AIO);
+	if (!f2fs_has_inline_data(inode)) {
+		err = f2fs_map_blocks(inode, &map, 1, F2FS_GET_BLOCK_PRE_AIO);
+		if (map.m_len > 0 && err == -ENOSPC) {
+			set_inode_flag(inode, FI_NO_PREALLOC);
+			err = 0;
+		}
+		return err;
+	}
 	return err;
 }
 
-- 
2.11.0


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
