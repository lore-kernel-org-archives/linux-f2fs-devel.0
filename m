From: Liu Xue <liuxueliu.liu@huawei.com>
Subject: [PATCH] fsck.f2fs: deal with realloc failure
Date: Wed, 2 Dec 2015 08:14:11 +0000
Message-ID: <1449044051-39524-1-git-send-email-liuxueliu.liu@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <liuxueliu.liu@huawei.com>) id 1a42Yj-0007gW-70
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 02 Dec 2015 08:14:41 +0000
Received: from szxga02-in.huawei.com ([119.145.14.65])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1a42Yc-0001RK-Ip
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 02 Dec 2015 08:14:41 +0000
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: jaegeuk@kernel.org, cm224.lee@samsung.com
Cc: linux-f2fs-devel@lists.sourceforge.net

Deal with realloc failure to avoid memory leak and memory free.

Signed-off-by: Xue Liu <liuxueliu.liu@huawei.com>
---
 fsck/fsck.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fsck/fsck.c b/fsck/fsck.c
index d3b5dd4..c39fd61 100644
--- a/fsck/fsck.c
+++ b/fsck/fsck.c
@@ -843,7 +843,10 @@ static void print_dentry(__u32 depth, __u8 *name,
 
 	if (tree_mark_size <= depth) {
 		tree_mark_size *= 2;
-		tree_mark = realloc(tree_mark, tree_mark_size);
+		char *tree_mark_old = realloc(tree_mark, tree_mark_size);
+		ASSERT(tree_mark_old != NULL);
+		tree_mark = tree_mark_old;
+		free(tree_mark_old);
 	}
 
 	if (last_de)
-- 
1.8.3.4


------------------------------------------------------------------------------
Go from Idea to Many App Stores Faster with Intel(R) XDK
Give your users amazing mobile app experiences with Intel(R) XDK.
Use one codebase in this all-in-one HTML5 development environment.
Design, debug & build mobile apps & 2D/3D high-impact games for multiple OSs.
http://pubads.g.doubleclick.net/gampad/clk?id=254741911&iu=/4140
