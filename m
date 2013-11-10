From: Huajun Li <huajun.li.lee@gmail.com>
Subject: [PATCH V2 6/6] f2fs: update f2fs Documentation
Date: Sun, 10 Nov 2013 23:13:21 +0800
Message-ID: <1384096401-25169-7-git-send-email-huajun.li.lee@gmail.com>
References: <1384096401-25169-1-git-send-email-huajun.li.lee@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <huajun.li.lee@gmail.com>) id 1VfWnb-0006pj-8s
	for linux-f2fs-devel@lists.sourceforge.net;
	Sun, 10 Nov 2013 15:19:39 +0000
Received: from mga02.intel.com ([134.134.136.20])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1VfWna-00024a-LB for linux-f2fs-devel@lists.sourceforge.net;
	Sun, 10 Nov 2013 15:19:39 +0000
In-Reply-To: <1384096401-25169-1-git-send-email-huajun.li.lee@gmail.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: jaegeuk.kim@samsung.com, linux-f2fs-devel@lists.sourceforge.net
Cc: linux-fsdevel@vger.kernel.org, Huajun Li <huajun.li@intel.com>, linux-kernel@vger.kernel.org

From: Huajun Li <huajun.li@intel.com>

This patch describes the inline_data support in f2fs document.

Signed-off-by: Huajun Li <huajun.li@intel.com>
---
 Documentation/filesystems/f2fs.txt |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/filesystems/f2fs.txt b/Documentation/filesystems/f2fs.txt
index a3fe811..9849372 100644
--- a/Documentation/filesystems/f2fs.txt
+++ b/Documentation/filesystems/f2fs.txt
@@ -120,6 +120,8 @@ active_logs=%u         Support configuring the number of active logs. In the
 disable_ext_identify   Disable the extension list configured by mkfs, so f2fs
                        does not aware of cold files such as media files.
 inline_xattr           Enable the inline xattrs feature.
+inline_data            Enable the inline data feature: New created small(<~3.4k)
+                       files can be written into inode block.
 
 ================================================================================
 DEBUGFS ENTRIES
-- 
1.7.9.5


------------------------------------------------------------------------------
November Webinars for C, C++, Fortran Developers
Accelerate application performance with scalable programming models. Explore
techniques for threading, error checking, porting, and tuning. Get the most 
from the latest Intel processors and coprocessors. See abstracts and register
http://pubads.g.doubleclick.net/gampad/clk?id=60136231&iu=/4140/ostg.clktrk
