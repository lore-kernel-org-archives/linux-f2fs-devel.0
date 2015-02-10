From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 2/4] f2fs: call set_buffer_new for get_block
Date: Tue, 10 Feb 2015 13:58:43 -0800
Message-ID: <1423605525-85348-2-git-send-email-jaegeuk@kernel.org>
References: <1423605525-85348-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1YLIpd-0002bW-Ke
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 10 Feb 2015 21:58:57 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1YLIpc-00076a-Hw for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 10 Feb 2015 21:58:57 +0000
In-Reply-To: <1423605525-85348-1-git-send-email-jaegeuk@kernel.org>
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

This patch fixes wrong handling of buffer_new flag in get_block.
If f2fs allocates new blocks and mapped buffer_head, it needs to set buffer_new
for the bh_result.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/data.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index d166557..26e2476 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -274,7 +274,7 @@ static int check_extent_cache(struct inode *inode, pgoff_t pgofs,
 		unsigned int blkbits = inode->i_sb->s_blocksize_bits;
 		size_t count;
 
-		clear_buffer_new(bh_result);
+		set_buffer_new(bh_result);
 		map_bh(bh_result, inode->i_sb,
 				start_blkaddr + pgofs - start_fofs);
 		count = end_fofs - pgofs + 1;
@@ -634,12 +634,14 @@ static int __get_data_block(struct inode *inode, sector_t iblock,
 		goto put_out;
 
 	if (dn.data_blkaddr != NULL_ADDR) {
+		set_buffer_new(bh_result);
 		map_bh(bh_result, inode->i_sb, dn.data_blkaddr);
 	} else if (create) {
 		err = __allocate_data_block(&dn);
 		if (err)
 			goto put_out;
 		allocated = true;
+		set_buffer_new(bh_result);
 		map_bh(bh_result, inode->i_sb, dn.data_blkaddr);
 	} else {
 		goto put_out;
-- 
2.1.1


------------------------------------------------------------------------------
Dive into the World of Parallel Programming. The Go Parallel Website,
sponsored by Intel and developed in partnership with Slashdot Media, is your
hub for all things parallel software development, from weekly thought
leadership blogs to news, videos, case studies, tutorials and more. Take a
look and join the conversation now. http://goparallel.sourceforge.net/
