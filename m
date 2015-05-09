From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 3/5] dump.f2fs: show i_advise field in inode
Date: Fri,  8 May 2015 21:24:39 -0700
Message-ID: <1431145481-2184-3-git-send-email-jaegeuk@kernel.org>
References: <1431145481-2184-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1YqwK4-00042S-Vq
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 09 May 2015 04:25:08 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1YqwK4-0003x9-Cb for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 09 May 2015 04:25:08 +0000
In-Reply-To: <1431145481-2184-1-git-send-email-jaegeuk@kernel.org>
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
Cc: Jaegeuk Kim <jaegeuk@kernel.org>

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fsck/mount.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fsck/mount.c b/fsck/mount.c
index 11ab197..13b73e9 100644
--- a/fsck/mount.c
+++ b/fsck/mount.c
@@ -26,6 +26,7 @@ void print_inode_info(struct f2fs_inode *inode, int name)
 	}
 
 	DISP_u32(inode, i_mode);
+	DISP_u32(inode, i_advise);
 	DISP_u32(inode, i_uid);
 	DISP_u32(inode, i_gid);
 	DISP_u32(inode, i_links);
-- 
2.1.1


------------------------------------------------------------------------------
One dashboard for servers and applications across Physical-Virtual-Cloud 
Widest out-of-the-box monitoring support with 50+ applications
Performance metrics, stats and reports that give you Actionable Insights
Deep dive visibility with transaction tracing using APM Insight.
http://ad.doubleclick.net/ddm/clk/290420510;117567292;y
