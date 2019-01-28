From: Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.20 085/304] f2fs: avoid GC causing
 encrypted file corrupted
Date: Mon, 28 Jan 2019 10:40:02 -0500
Message-ID: <20190128154341.47195-85-sashal@kernel.org>
References: <20190128154341.47195-1-sashal@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <sashal@kernel.org>) id 1go986-0000iO-S5
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 28 Jan 2019 15:47:22 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1go985-008gOn-Ao
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 28 Jan 2019 15:47:22 +0000
In-Reply-To: <20190128154341.47195-1-sashal@kernel.org>
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
Cc: Jaegeuk Kim <jaegeuk@kernel.org>, linux-f2fs-devel@lists.sourceforge.net, Sasha Levin <sashal@kernel.org>

From: Yunlong Song <yunlong.song@huawei.com>

[ Upstream commit 9bf1a3f73927492c8be127b642197125e9d52be8 ]

The encrypted file may be corrupted by GC in following case:

Time 1: | segment 1 blkaddr = A |  GC -> | segment 2 blkaddr = B |
Encrypted block 1 is moved from blkaddr A of segment 1 to blkaddr B of
segment 2,

Time 2: | segment 1 blkaddr = B |  GC -> | segment 3 blkaddr = C |

Before page 1 is written back and if segment 2 become a victim, then
page 1 is moved from blkaddr B of segment 2 to blkaddr Cof segment 3,
during the GC process of Time 2, f2fs should wait for page 1 written back
before reading it, or move_data_block will read a garbage block from
blkaddr B since page is not written back to blkaddr B yet.

Commit 6aa58d8a ("f2fs: readahead encrypted block during GC") introduce
ra_data_block to read encrypted block, but it forgets to add
f2fs_wait_on_page_writeback to avoid racing between GC and flush.

Signed-off-by: Yunlong Song <yunlong.song@huawei.com>
Reviewed-by: Chao Yu <yuchao0@huawei.com>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/gc.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index a07241fb8537..c96e7c6354ef 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -658,6 +658,14 @@ got_it:
 	fio.page = page;
 	fio.new_blkaddr = fio.old_blkaddr = dn.data_blkaddr;
 
+	/*
+	 * don't cache encrypted data into meta inode until previous dirty
+	 * data were writebacked to avoid racing between GC and flush.
+	 */
+	f2fs_wait_on_page_writeback(page, DATA, true);
+
+	f2fs_wait_on_block_writeback(inode, dn.data_blkaddr);
+
 	fio.encrypted_page = f2fs_pagecache_get_page(META_MAPPING(sbi),
 					dn.data_blkaddr,
 					FGP_LOCK | FGP_CREAT, GFP_NOFS);
@@ -745,6 +753,8 @@ static int move_data_block(struct inode *inode, block_t bidx,
 	 */
 	f2fs_wait_on_page_writeback(page, DATA, true);
 
+	f2fs_wait_on_block_writeback(inode, dn.data_blkaddr);
+
 	err = f2fs_get_node_info(fio.sbi, dn.nid, &ni);
 	if (err)
 		goto put_out;
-- 
2.19.1
