From: Huajun Li <huajun.li@intel.com>
Subject: [f2fs-dev] [RFC 4/5] f2fs: Add Kconfig interface for inline data
	support
Date: Mon,  3 Jun 2013 18:04:13 +0800
Message-ID: <1370253854-15084-5-git-send-email-huajun.li@intel.com>
References: <1370253854-15084-1-git-send-email-huajun.li@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <huajun.li@intel.com>) id 1UjRdY-0007td-8w
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 03 Jun 2013 10:05:12 +0000
Received: from mga03.intel.com ([143.182.124.21])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1UjRdX-000185-Cu for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 03 Jun 2013 10:05:12 +0000
In-Reply-To: <1370253854-15084-1-git-send-email-huajun.li@intel.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: jaegeuk.kim@samsung.com, linux-fsdevel@vger.kernel.org, huajun.li.lee@gmail.com
Cc: namjae.jeon@samsung.com, Huajun Li <huajun.li@intel.com>, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

From: Haicheng Li <haicheng.li@linux.intel.com>

Add Kconfig interface for inline data support, and update Makefile to
compile new added source file.

Signed-off-by: Haicheng Li <haicheng.li@linux.intel.com>
Signed-off-by: Huajun Li <huajun.li@intel.com>
---
 fs/f2fs/Kconfig  |   10 ++++++++++
 fs/f2fs/Makefile |    1 +
 2 files changed, 11 insertions(+)

diff --git a/fs/f2fs/Kconfig b/fs/f2fs/Kconfig
index fd27e7e..75da2e4 100644
--- a/fs/f2fs/Kconfig
+++ b/fs/f2fs/Kconfig
@@ -51,3 +51,13 @@ config F2FS_FS_POSIX_ACL
 	  Linux website <http://acl.bestbits.at/>.
 
 	  If you don't know what Access Control Lists are, say N
+
+config F2FS_INLINE_DATA
+	bool "F2FS inline data support"
+	depends on F2FS_FS
+	default y
+	help
+	  Inline data support is an optimization of F2FS data space management,
+	  which utilizes the unused space within f2fs inode to keep real data.
+
+	  If unsure, say N.
diff --git a/fs/f2fs/Makefile b/fs/f2fs/Makefile
index 27a0820..e1ff7b8 100644
--- a/fs/f2fs/Makefile
+++ b/fs/f2fs/Makefile
@@ -5,3 +5,4 @@ f2fs-y		+= checkpoint.o gc.o data.o node.o segment.o recovery.o
 f2fs-$(CONFIG_F2FS_STAT_FS) += debug.o
 f2fs-$(CONFIG_F2FS_FS_XATTR) += xattr.o
 f2fs-$(CONFIG_F2FS_FS_POSIX_ACL) += acl.o
+f2fs-$(CONFIG_F2FS_INLINE_DATA) += inline.o
-- 
1.7.9.5


------------------------------------------------------------------------------
Get 100% visibility into Java/.NET code with AppDynamics Lite
It's a free troubleshooting tool designed for production
Get down to code-level detail for bottlenecks, with <2% overhead.
Download for free and get started troubleshooting in minutes.
http://p.sf.net/sfu/appdyn_d2d_ap2
