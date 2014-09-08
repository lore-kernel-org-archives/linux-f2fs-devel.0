From: Huang Ying <ying.huang@intel.com>
Subject: [PATCH] f2fs: Fix recover when nid of non-inode dnode <
	nid of inode
Date: Mon,  8 Sep 2014 19:38:26 +0800
Message-ID: <1410176306-1689-1-git-send-email-ying.huang@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <ying.huang@intel.com>) id 1XQxHN-0004Yo-UJ
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 08 Sep 2014 11:38:42 +0000
Received: from mga02.intel.com ([134.134.136.20])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1XQxHN-0005gw-2G for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 08 Sep 2014 11:38:41 +0000
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Jaegeuk Kim <jaegeuk@kernel.org>, Changman Lee <cm224.lee@samsung.com>
Cc: Huang Ying <ying.huang@intel.com>, huang.ying.caritas@gmail.com, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

For fsync, if the nid of a non-inode dnode < nid of inode and the
inode is not checkpointed.  The non-inode dnode may be written before
inode.  So in find_fsync_dnodes, f2fs_iget will fail, cause the
recovery fail.

Usually, inode will be allocated before non-inode dnode, so the nid of
inode < nid of non-inode dnode.  But it is possible for the reverse.
For example, because of alloc_nid_failed.

This is fixed via ignoring non-inode dnode before inode dnode in
find_fsync_dnodes.

The patch was tested via allocating nid reversely via a debugging
patch, that is, from big number to small number.

Signed-off-by: Huang, Ying <ying.huang@intel.com>
---
 fs/f2fs/recovery.c |    7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

--- a/fs/f2fs/recovery.c
+++ b/fs/f2fs/recovery.c
@@ -172,8 +172,8 @@ static int find_fsync_dnodes(struct f2fs
 			if (IS_INODE(page) && is_dent_dnode(page))
 				set_inode_flag(F2FS_I(entry->inode),
 							FI_INC_LINK);
-		} else {
-			if (IS_INODE(page) && is_dent_dnode(page)) {
+		} else if (IS_INODE(page)) {
+			if (is_dent_dnode(page)) {
 				err = recover_inode_page(sbi, page);
 				if (err)
 					break;
@@ -193,7 +193,8 @@ static int find_fsync_dnodes(struct f2fs
 				break;
 			}
 			list_add_tail(&entry->list, head);
-		}
+		} else
+			goto next;
 		entry->blkaddr = blkaddr;
 
 		err = recover_inode(entry->inode, page);

------------------------------------------------------------------------------
Want excitement?
Manually upgrade your production database.
When you want reliability, choose Perforce
Perforce version control. Predictably reliable.
http://pubads.g.doubleclick.net/gampad/clk?id=157508191&iu=/4140/ostg.clktrk
