From: Jaegeuk Kim <jaegeuk.kim@samsung.com>
Subject: [PATCH 1/2] f2fs: introduce CONFIG_F2FS_CHECK_FS for
	BUG_ON control
Date: Tue, 29 Oct 2013 15:53:11 +0900
Message-ID: <1383029592-17477-1-git-send-email-jaegeuk.kim@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk.kim@samsung.com>) id 1Vb3Bi-0001ux-Jo
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 29 Oct 2013 06:54:02 +0000
Received: from mailout2.samsung.com ([203.254.224.25])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1Vb3Be-0004m6-W6 for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 29 Oct 2013 06:54:02 +0000
Received: from epcpsbgr2.samsung.com
	(u142.gpu120.samsung.co.kr [203.254.230.142])
	by mailout2.samsung.com (Oracle Communications Messaging Server
	7u4-24.01 (7.0.4.24.0) 64bit (built Nov 17 2011))
	with ESMTP id <0MVF0030X4F73L80@mailout2.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Tue, 29 Oct 2013 15:53:52 +0900 (KST)
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

This config will support an option to remove so many BUG_ONs that degrade
the performance potentially.

Signed-off-by: Jaegeuk Kim <jaegeuk.kim@samsung.com>
---
 fs/f2fs/Kconfig | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/fs/f2fs/Kconfig b/fs/f2fs/Kconfig
index e06e099..214fe10 100644
--- a/fs/f2fs/Kconfig
+++ b/fs/f2fs/Kconfig
@@ -63,3 +63,11 @@ config F2FS_FS_SECURITY
 	  the extended attribute support in advance.
 
 	  If you are not using a security module, say N.
+
+config F2FS_CHECK_FS
+	bool "F2FS consistency checking feature"
+	depends on F2FS_FS
+	help
+	  Enables BUG_ONs which check the file system consistency in runtime.
+
+	  If you want to improve the performance, say N.
-- 
1.8.4.474.g128a96c


------------------------------------------------------------------------------
Android is increasing in popularity, but the open development platform that
developers love is also attractive to malware creators. Download this white
paper to learn more about secure code signing practices that can help keep
Android apps secure.
http://pubads.g.doubleclick.net/gampad/clk?id=65839951&iu=/4140/ostg.clktrk
