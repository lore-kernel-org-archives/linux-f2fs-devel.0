From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH] f2fs-tools: release 1.4.0
Date: Sat, 20 Sep 2014 09:19:01 -0700
Message-ID: <1411229941-18054-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1XVNNP-0005PL-7E
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 20 Sep 2014 16:19:11 +0000
Received: from mail.kernel.org ([198.145.19.201])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1XVNNO-0004xa-AV for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 20 Sep 2014 16:19:11 +0000
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
Cc: Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org

This version includes:
 - fsck.f2fs fixing corrupted images/partitions
 - dump.f2fs retrieving speicific file
 - bug fixes on f2fsstat and fibmap.f2fs
 - refactor code blocks for android build

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 VERSION | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/VERSION b/VERSION
index c3a3dd8..4e11b43 100644
--- a/VERSION
+++ b/VERSION
@@ -1,2 +1,2 @@
-1.2.0
-2013-10-25
+1.4.0
+2014-09-18
-- 
1.8.5.2 (Apple Git-48)


------------------------------------------------------------------------------
Slashdot TV.  Video for Nerds.  Stuff that Matters.
http://pubads.g.doubleclick.net/gampad/clk?id=160591471&iu=/4140/ostg.clktrk
