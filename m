From: Junling Zheng <zhengjunling@huawei.com>
Subject: [PATCH 2/4] fsck.f2fs: fix incorrect ERR_MSG in
	f2fs_do_mount
Date: Thu, 29 Sep 2016 18:38:35 +0800
Message-ID: <1475145517-18366-2-git-send-email-zhengjunling@huawei.com>
References: <1475145517-18366-1-git-send-email-zhengjunling@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <zhengjunling@huawei.com>) id 1bpYxB-0004eD-1m
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 29 Sep 2016 10:52:37 +0000
Received: from szxga03-in.huawei.com ([119.145.14.66])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1bpYx7-0000ij-SE
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 29 Sep 2016 10:52:37 +0000
In-Reply-To: <1475145517-18366-1-git-send-email-zhengjunling@huawei.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: linux-f2fs-devel@lists.sourceforge.net

Signed-off-by: Junling Zheng <zhengjunling@huawei.com>
---
 fsck/mount.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fsck/mount.c b/fsck/mount.c
index e390b26..a247dec 100644
--- a/fsck/mount.c
+++ b/fsck/mount.c
@@ -1978,7 +1978,7 @@ int f2fs_do_mount(struct f2fs_sb_info *sbi)
 	}
 
 	if (build_node_manager(sbi)) {
-		ERR_MSG("build_segment_manager failed\n");
+		ERR_MSG("build_node_manager failed\n");
 		return -1;
 	}
 
-- 
2.7.4


------------------------------------------------------------------------------
