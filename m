From: Jaegeuk Kim <jaegeuk.kim@samsung.com>
Subject: [PATCH 3/5] f2fs: add a sysfs entry to control
	max_discards
Date: Fri, 15 Nov 2013 14:20:22 +0900
Message-ID: <1384492824-32483-3-git-send-email-jaegeuk.kim@samsung.com>
References: <1384492824-32483-1-git-send-email-jaegeuk.kim@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk.kim@samsung.com>) id 1VhBqX-0003Xu-3u
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 15 Nov 2013 05:21:33 +0000
Received: from mailout3.samsung.com ([203.254.224.33])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1VhBqT-0005wy-Rh for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 15 Nov 2013 05:21:33 +0000
Received: from epcpsbgr4.samsung.com
	(u144.gpu120.samsung.co.kr [203.254.230.144])
	by mailout3.samsung.com (Oracle Communications Messaging Server
	7u4-24.01 (7.0.4.24.0) 64bit (built Nov 17 2011))
	with ESMTP id <0MWA00FCWHJE4QO0@mailout3.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Fri, 15 Nov 2013 14:21:14 +0900 (KST)
In-reply-to: <1384492824-32483-1-git-send-email-jaegeuk.kim@samsung.com>
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

If frequent small discards are issued to the device, the performance would
be degraded significantly.
So, this patch adds a sysfs entry to control the number of discards to be
issued during a checkpoint procedure.

By default, f2fs does not issue any small discards, which means max_discards
is zero.

Signed-off-by: Jaegeuk Kim <jaegeuk.kim@samsung.com>
---
 fs/f2fs/super.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index e9aa3f7..a022412 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -175,6 +175,7 @@ F2FS_RW_ATTR(GC_THREAD, f2fs_gc_kthread, gc_max_sleep_time, max_sleep_time);
 F2FS_RW_ATTR(GC_THREAD, f2fs_gc_kthread, gc_no_gc_sleep_time, no_gc_sleep_time);
 F2FS_RW_ATTR(GC_THREAD, f2fs_gc_kthread, gc_idle, gc_idle);
 F2FS_RW_ATTR(SM_INFO, f2fs_sm_info, reclaim_segments, rec_prefree_segments);
+F2FS_RW_ATTR(SM_INFO, f2fs_sm_info, max_small_discards, max_discards);
 
 #define ATTR_LIST(name) (&f2fs_attr_##name.attr)
 static struct attribute *f2fs_attrs[] = {
@@ -183,6 +184,7 @@ static struct attribute *f2fs_attrs[] = {
 	ATTR_LIST(gc_no_gc_sleep_time),
 	ATTR_LIST(gc_idle),
 	ATTR_LIST(reclaim_segments),
+	ATTR_LIST(max_small_discards),
 	NULL,
 };
 
-- 
1.8.4.474.g128a96c


------------------------------------------------------------------------------
DreamFactory - Open Source REST & JSON Services for HTML5 & Native Apps
OAuth, Users, Roles, SQL, NoSQL, BLOB Storage and External API Access
Free app hosting. Or install the open source package on any LAMP server.
Sign up and see examples for AngularJS, jQuery, Sencha Touch and Native!
http://pubads.g.doubleclick.net/gampad/clk?id=63469471&iu=/4140/ostg.clktrk
