From: Chao Yu <yuchao0@huawei.com>
Subject: [PATCH] f2fs: detect dirty inode in evict_inode
Date: Tue, 12 Sep 2017 14:04:05 +0800
Message-ID: <20170912060405.82807-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
 helo=mx.sourceforge.net)
 by sfs-ml-1.v29.ch3.sourceforge.com with esmtps (TLSv1:DHE-RSA-AES256-SHA:256)
 (Exim 4.89) (envelope-from <yuchao0@huawei.com>) id 1dreJT-00035P-Ck
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 12 Sep 2017 06:04:47 +0000
Received: from szxga04-in.huawei.com ([45.249.212.190])
 by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
 (Exim 4.76) id 1dreJM-0003WX-M9
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 12 Sep 2017 06:04:47 +0000
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

Add a bugon in f2fs_evict_inode to detect inconsistent status between
inode cache and related node page cache.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/inode.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
index c3e60fa60957..42a8594d6361 100644
--- a/fs/f2fs/inode.c
+++ b/fs/f2fs/inode.c
@@ -531,6 +531,9 @@ void f2fs_evict_inode(struct inode *inode)
 	stat_dec_inline_dir(inode);
 	stat_dec_inline_inode(inode);
 
+	if (!is_set_ckpt_flags(sbi, CP_ERROR_FLAG))
+		f2fs_bug_on(sbi, is_inode_flag_set(inode, FI_DIRTY_INODE));
+
 	/* ino == 0, if f2fs_new_inode() was failed t*/
 	if (inode->i_ino)
 		invalidate_mapping_pages(NODE_MAPPING(sbi), inode->i_ino,
-- 
2.13.1.388.g69e6b9b4f4a9


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
