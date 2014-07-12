From: Huang Ying <ying.huang@intel.com>
Subject: [PATCH v2] f2fs: Add f2fs_balance_fs for direct IO
Date: Sat, 12 Jul 2014 20:10:00 +0800
Message-ID: <1405167000-23477-1-git-send-email-ying.huang@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <ying.huang@intel.com>) id 1X5w83-0000HS-7W
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 12 Jul 2014 12:10:11 +0000
Received: from mga09.intel.com ([134.134.136.24])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1X5w82-0006S0-9l for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 12 Jul 2014 12:10:11 +0000
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
Cc: Huang Ying <ying.huang@intel.com>, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

Otherwise, if a large amount of direct IO writes were done, the
segment allocation may be failed because no enough segments are gced.

Changes:

v2: add f2fs_balance_fs into __get_data_block instead of f2fs_direct_IO.

Signed-off-by: Huang, Ying <ying.huang@intel.com>
---
 fs/f2fs/data.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -626,8 +626,10 @@ static int __get_data_block(struct inode
 	if (check_extent_cache(inode, pgofs, bh_result))
 		goto out;
 
-	if (create)
+	if (create) {
+		f2fs_balance_fs(sbi);
 		f2fs_lock_op(sbi);
+	}
 
 	/* When reading holes, we need its node page */
 	set_new_dnode(&dn, inode, NULL, NULL, 0);

------------------------------------------------------------------------------
