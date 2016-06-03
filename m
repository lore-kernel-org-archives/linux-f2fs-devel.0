From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 4/8] f2fs: skip roll_forward recovery after umount
Date: Thu,  2 Jun 2016 20:55:35 -0700
Message-ID: <1464926139-58252-4-git-send-email-jaegeuk@kernel.org>
References: <1464926139-58252-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1b8gDA-0000zh-Bg
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 03 Jun 2016 03:55:52 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1b8gD9-0004gE-Ns
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 03 Jun 2016 03:55:52 +0000
In-Reply-To: <1464926139-58252-1-git-send-email-jaegeuk@kernel.org>
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

If f2fs was umounted successfully, we don't need to go into roll_forward.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/recovery.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/f2fs/recovery.c b/fs/f2fs/recovery.c
index b568b28..841bddc 100644
--- a/fs/f2fs/recovery.c
+++ b/fs/f2fs/recovery.c
@@ -579,6 +579,9 @@ int recover_fsync_data(struct f2fs_sb_info *sbi, bool check_only)
 	int ret = 0;
 	bool need_writecp = false;
 
+	if (is_set_ckpt_flags(sbi->ckpt, CP_UMOUNT_FLAG))
+		return 0;
+
 	fsync_entry_slab = f2fs_kmem_cache_create("f2fs_fsync_inode_entry",
 			sizeof(struct fsync_inode_entry));
 	if (!fsync_entry_slab)
-- 
2.6.3


------------------------------------------------------------------------------
What NetFlow Analyzer can do for you? Monitors network bandwidth and traffic
patterns at an interface-level. Reveals which users, apps, and protocols are 
consuming the most bandwidth. Provides multi-vendor support for NetFlow, 
J-Flow, sFlow and other flows. Make informed decisions using capacity 
planning reports. https://ad.doubleclick.net/ddm/clk/305295220;132659582;e
