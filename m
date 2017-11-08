From: Yunlong Song <yunlong.song@huawei.com>
Subject: [PATCH] f2fs: let f2fs also gc atomic file to avoid loop
 gc
Date: Wed, 8 Nov 2017 10:34:57 +0800
Message-ID: <1510108497-58331-1-git-send-email-yunlong.song@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.191]
 helo=mx.sourceforge.net)
 by sfs-ml-1.v29.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 (envelope-from <yunlong.song@huawei.com>) id 1eCGD7-0002ee-CQ
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 08 Nov 2017 02:35:25 +0000
Received: from szxga04-in.huawei.com ([45.249.212.190])
 by sfi-mx-1.v28.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
 (Exim 4.89) id 1eCGD6-0005Fm-36
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 08 Nov 2017 02:35:25 +0000
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: jaegeuk@kernel.org, chao@kernel.org, yuchao0@huawei.com, yunlong.song@icloud.com, yunlong.song@huawei.com
Cc: linux-fsdevel@vger.kernel.org, miaoxie@huawei.com, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

If some files are opened with atomic flag and have not commited yet, at
the same time, if all the target victim segments have at least one page
of these atomic files, then f2fs gc will fail to do gc and hangs in the
process of go to gc_more, since gc_date_segment will not move any data
and get_valid_blocks will never be 0, then do_garbage_collect will
always return 0.

Signed-off-by: Yunlong Song <yunlong.song@huawei.com>
---
 fs/f2fs/gc.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index 5d5bba4..3fdcd04 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -621,9 +621,6 @@ static void move_data_block(struct inode *inode, block_t bidx,
 	if (!check_valid_map(F2FS_I_SB(inode), segno, off))
 		goto out;
 
-	if (f2fs_is_atomic_file(inode))
-		goto out;
-
 	set_new_dnode(&dn, inode, NULL, NULL, 0);
 	err = get_dnode_of_data(&dn, bidx, LOOKUP_NODE);
 	if (err)
@@ -718,9 +715,6 @@ static void move_data_page(struct inode *inode, block_t bidx, int gc_type,
 	if (!check_valid_map(F2FS_I_SB(inode), segno, off))
 		goto out;
 
-	if (f2fs_is_atomic_file(inode))
-		goto out;
-
 	if (gc_type == BG_GC) {
 		if (PageWriteback(page))
 			goto out;
-- 
1.8.5.2


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
