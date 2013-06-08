From: Namjae Jeon <linkinjeon@gmail.com>
Subject: [f2fs-dev] [PATCH 4/4] f2fs: optimise the
	truncate_data_blocks_range() range.
Date: Sat,  8 Jun 2013 21:25:40 +0900
Message-ID: <1370694340-2842-1-git-send-email-linkinjeon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <linkinjeon@gmail.com>) id 1UlIDS-0005PP-4V
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 08 Jun 2013 12:25:54 +0000
Received: from mail-pd0-f180.google.com ([209.85.192.180])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1UlIDR-0007aZ-CJ
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 08 Jun 2013 12:25:54 +0000
Received: by mail-pd0-f180.google.com with SMTP id 10so5781692pdi.25
	for <linux-f2fs-devel@lists.sourceforge.net>;
	Sat, 08 Jun 2013 05:25:47 -0700 (PDT)
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: jaegeuk.kim@samsung.com
Cc: Namjae Jeon <linkinjeon@gmail.com>, Namjae Jeon <namjae.jeon@samsung.com>, Pankaj Kumar <pankaj.km@samsung.com>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

From: Namjae Jeon <namjae.jeon@samsung.com>

The function truncate_data_blocks_range() decrements the valid
block count of inode via dec_valid_block_count(). Since this
function updates the i_blocks field of inode, we can update this
field once we have calculated total the number of blocks
to be freed.

Therefore we can decrement valid blocks outside of the for loop.

if (nr_free) {
+dec_valid_block_count(sbi, dn->inode, nf_free)
                set_page_dirty(dn->node_page);
                sync_inode_page(dn);
        }
'nr_free' tells the total number of blocks freed.So, we can
just directly pass this value to dec_valid_block_count() and update
the i_blocks.

Signed-off-by: Namjae Jeon <namjae.jeon@samsung.com>
Signed-off-by: Pankaj Kumar <pankaj.km@samsung.com>
---
 fs/f2fs/file.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 6071ff5..1c5362b 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -185,10 +185,10 @@ int truncate_data_blocks_range(struct dnode_of_data *dn, int count)
 
 		update_extent_cache(NULL_ADDR, dn);
 		invalidate_blocks(sbi, blkaddr);
-		dec_valid_block_count(sbi, dn->inode, 1);
 		nr_free++;
 	}
 	if (nr_free) {
+		dec_valid_block_count(sbi, dn->inode, nr_free);
 		set_page_dirty(dn->node_page);
 		sync_inode_page(dn);
 	}
-- 
1.7.9.5


------------------------------------------------------------------------------
How ServiceNow helps IT people transform IT departments:
1. A cloud service to automate IT design, transition and operations
2. Dashboards that offer high-level views of enterprise services
3. A single system of record for all IT processes
http://p.sf.net/sfu/servicenow-d2d-j
