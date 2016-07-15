From: Sheng Yong <shengyong1@huawei.com>
Subject: [PATCH trivial 1/7] dump.f2fs: show inode->i_dir_level
Date: Fri, 15 Jul 2016 20:01:19 +0800
Message-ID: <1468584085-29090-1-git-send-email-shengyong1@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <shengyong1@huawei.com>) id 1bO1tG-00065j-Vl
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 15 Jul 2016 12:06:46 +0000
Received: from szxga02-in.huawei.com ([119.145.14.65])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1bO1tC-0007vf-On
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 15 Jul 2016 12:06:46 +0000
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net

Signed-off-by: Sheng Yong <shengyong1@huawei.com>
---
 fsck/mount.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fsck/mount.c b/fsck/mount.c
index e0223e0..3e3d176 100644
--- a/fsck/mount.c
+++ b/fsck/mount.c
@@ -70,6 +70,7 @@ void print_inode_info(struct f2fs_inode *inode, int name)
 	DISP_u32(inode, i_flags);
 	DISP_u32(inode, i_inline);
 	DISP_u32(inode, i_pino);
+	DISP_u32(inode, i_dir_level);
 
 	if (namelen) {
 		DISP_u32(inode, i_namelen);
-- 
2.7.1


------------------------------------------------------------------------------
What NetFlow Analyzer can do for you? Monitors network bandwidth and traffic
patterns at an interface-level. Reveals which users, apps, and protocols are 
consuming the most bandwidth. Provides multi-vendor support for NetFlow, 
J-Flow, sFlow and other flows. Make informed decisions using capacity planning
reports.http://sdm.link/zohodev2dev
