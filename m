From: Hou Pengyang <houpengyang@huawei.com>
Subject: [RFC] f2fs: fix a race condition between evict & gc
Date: Mon, 16 May 2016 10:40:21 +0000
Message-ID: <1463395221-109622-1-git-send-email-houpengyang@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <houpengyang@huawei.com>) id 1b2FxP-000803-Un
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 16 May 2016 10:41:03 +0000
Received: from szxga02-in.huawei.com ([119.145.14.65])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1b2FxJ-0001Zf-Dd
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 16 May 2016 10:41:03 +0000
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: jaegeuk@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

When collecting data segment(gc_data_segment), there is a race condition
between evict and phases of gc:
0) ra_node_page(dnode)
1) ra_node_page(inode)
		<--- evict the inode
2) f2fs_iget get the inode and add it to gc_list 
3) move_data_page

In step 2), f2fs_iget does NOT find the inode and allocs a new inode as result,
which is not resonable.

This patch changes f2fs_iget to ilookup. when no inode is found, no new inode is
created.

Signed-off-by: Hou Pengyang <houpengyang@huawei.com>
---
 fs/f2fs/gc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index 38d56f6..6e73193 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -717,8 +717,8 @@ next_step:
 		ofs_in_node = le16_to_cpu(entry->ofs_in_node);
 
 		if (phase == 2) {
-			inode = f2fs_iget(sb, dni.ino);
-			if (IS_ERR(inode) || is_bad_inode(inode))
+			inode = ilookup(sb, dni.ino);
+			if (!inode || IS_ERR(inode) || is_bad_inode(inode))
 				continue;
 
 			/* if encrypted inode, let's go phase 3 */
-- 
1.9.1


------------------------------------------------------------------------------
Mobile security can be enabling, not merely restricting. Employees who
bring their own devices (BYOD) to work are irked by the imposition of MDM
restrictions. Mobile Device Manager Plus allows you to control only the
apps on BYO-devices by containerizing them, leaving personal data untouched!
https://ad.doubleclick.net/ddm/clk/304595813;131938128;j
