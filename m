From: "Tiezhu Yang" <kernelpatch@126.com>
Subject: [PATCH] f2fs: fix a typo in f2fs.txt
Date: Wed, 8 Feb 2017 05:08:01 +0800 (CST)
Message-ID: <149f6251.17c.15a1a679a5c.Coremail.kernelpatch@126.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <kernelpatch@126.com>) id 1cbCzw-000849-4a
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 07 Feb 2017 21:08:24 +0000
Received: from m15-14.126.com ([220.181.15.14])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1cbCzs-0001AQ-Iq for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 07 Feb 2017 21:08:24 +0000
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

There is a typo "f2f2" in f2fs.txt, this patch fixes it.

Signed-off-by: Tiezhu Yang <kernelpatch@126.com>
---
 Documentation/filesystems/f2fs.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/filesystems/f2fs.txt b/Documentation/filesystems/f2fs.txt
index 0ab33d4..3d7e12d 100644
--- a/Documentation/filesystems/f2fs.txt
+++ b/Documentation/filesystems/f2fs.txt
@@ -176,7 +176,7 @@ f2fs. Each file shows the whole f2fs information.
 SYSFS ENTRIES
 ================================================================================
 
-Information about mounted f2f2 file systems can be found in
+Information about mounted f2fs file systems can be found in
 /sys/fs/f2fs.  Each mounted filesystem will have a directory in
 /sys/fs/f2fs based on its device name (i.e., /sys/fs/f2fs/sda).
 The files in each per-device directory are shown in table below.
-- 
1.8.3.1
------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, SlashDot.org! http://sdm.link/slashdot
