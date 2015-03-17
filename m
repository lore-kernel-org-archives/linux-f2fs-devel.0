From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 2/4] f2fs: set buffer_new when new blocks are
	allocated
Date: Tue, 17 Mar 2015 09:57:39 -0700
Message-ID: <1426611461-690-2-git-send-email-jaegeuk@kernel.org>
References: <1426611461-690-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1YXuoU-0005Jr-0H
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 17 Mar 2015 16:57:54 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1YXuoS-00024C-VO for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 17 Mar 2015 16:57:53 +0000
In-Reply-To: <1426611461-690-1-git-send-email-jaegeuk@kernel.org>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>

This patch modifies to call set_buffer_new, if new blocks are allocated.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/data.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index ba70a78..cefaa67 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -257,7 +257,6 @@ static void f2fs_map_bh(struct super_block *sb, pgoff_t pgofs,
 	unsigned int blkbits = sb->s_blocksize_bits;
 	size_t count;
 
-	set_buffer_new(bh_result);
 	map_bh(bh_result, sb, ei->blk + pgofs - ei->fofs);
 	count = ei->fofs + ei->len - pgofs;
 	if (count < (UINT_MAX >> blkbits))
@@ -1139,7 +1138,7 @@ static int __get_data_block(struct inode *inode, sector_t iblock,
 		goto put_out;
 
 	if (dn.data_blkaddr != NULL_ADDR) {
-		set_buffer_new(bh_result);
+		clear_buffer_new(bh_result);
 		map_bh(bh_result, inode->i_sb, dn.data_blkaddr);
 	} else if (create) {
 		err = __allocate_data_block(&dn);
@@ -1184,6 +1183,7 @@ get_next:
 			if (err)
 				goto sync_out;
 			allocated = true;
+			set_buffer_new(bh_result);
 			blkaddr = dn.data_blkaddr;
 		}
 		/* Give more consecutive addresses for the readahead */
-- 
2.1.1


------------------------------------------------------------------------------
Dive into the World of Parallel Programming The Go Parallel Website, sponsored
by Intel and developed in partnership with Slashdot Media, is your hub for all
things parallel software development, from weekly thought leadership blogs to
news, videos, case studies, tutorials and more. Take a look and join the 
conversation now. http://goparallel.sourceforge.net/
