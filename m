From: Jaegeuk Kim <jaegeuk.kim@samsung.com>
Subject: [PATCH 2/2] f2fs: should put the dnode when NEW_ADDR is
	detected
Date: Thu, 26 Dec 2013 17:17:21 +0900
Message-ID: <1388045841-32165-2-git-send-email-jaegeuk.kim@samsung.com>
References: <1388045841-32165-1-git-send-email-jaegeuk.kim@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk.kim@samsung.com>) id 1Vw69V-0000YW-2T
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 26 Dec 2013 08:18:45 +0000
Received: from mailout2.samsung.com ([203.254.224.25])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-MD5:128)
	(Exim 4.76) id 1Vw69S-0005Ag-If
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 26 Dec 2013 08:18:45 +0000
Received: from epcpsbgr3.samsung.com
	(u143.gpu120.samsung.co.kr [203.254.230.143])
	by mailout2.samsung.com (Oracle Communications Messaging Server
	7u4-24.01 (7.0.4.24.0) 64bit (built Nov 17 2011))
	with ESMTP id <0MYE009G4N2XMB40@mailout2.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Thu, 26 Dec 2013 17:18:33 +0900 (KST)
In-reply-to: <1388045841-32165-1-git-send-email-jaegeuk.kim@samsung.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

When get_dnode_of_data() in get_data_block() returns a successful dnode, we
should put the dnode.
But, previously, if its data block address is equal to NEW_ADDR, we didn't do
that, resulting in a deadlock condition.
So, this patch splits original error conditions with this case, and then calls
f2fs_put_dnode before finishing the function.

Signed-off-by: Jaegeuk Kim <jaegeuk.kim@samsung.com>
---
 fs/f2fs/data.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 0879d2a..991e368 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -626,11 +626,13 @@ static int get_data_block(struct inode *inode, sector_t iblock,
 	/* When reading holes, we need its node page */
 	set_new_dnode(&dn, inode, NULL, NULL, 0);
 	err = get_dnode_of_data(&dn, pgofs, mode);
-	if (err || dn.data_blkaddr == NEW_ADDR) {
+	if (err) {
 		if (err == -ENOENT)
 			err = 0;
 		goto unlock_out;
 	}
+	if (dn.data_blkaddr == NEW_ADDR)
+		goto put_out;
 
 	if (dn.data_blkaddr != NULL_ADDR) {
 		map_bh(bh_result, inode->i_sb, dn.data_blkaddr);
@@ -659,11 +661,14 @@ get_next:
 
 		set_new_dnode(&dn, inode, NULL, NULL, 0);
 		err = get_dnode_of_data(&dn, pgofs, mode);
-		if (err || dn.data_blkaddr == NEW_ADDR) {
+		if (err) {
 			if (err == -ENOENT)
 				err = 0;
 			goto unlock_out;
 		}
+		if (dn.data_blkaddr == NEW_ADDR)
+			goto put_out;
+
 		end_offset = IS_INODE(dn.node_page) ?
 			ADDRS_PER_INODE(F2FS_I(inode)) : ADDRS_PER_BLOCK;
 	}
-- 
1.8.4.474.g128a96c


------------------------------------------------------------------------------
Rapidly troubleshoot problems before they affect your business. Most IT 
organizations don't have a clear picture of how application performance 
affects their revenue. With AppDynamics, you get 100% visibility into your 
Java,.NET, & PHP application. Start your 15-day FREE TRIAL of AppDynamics Pro!
http://pubads.g.doubleclick.net/gampad/clk?id=84349831&iu=/4140/ostg.clktrk
