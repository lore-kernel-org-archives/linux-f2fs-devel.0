From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [patch] f2fs: simplify by using a literal
Date: Thu, 28 Aug 2014 16:13:21 +0300
Message-ID: <20140828131320.GA24477@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <dan.carpenter@oracle.com>) id 1XMzXR-0006jh-4P
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 28 Aug 2014 13:14:53 +0000
Received: from userp1040.oracle.com ([156.151.31.81])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1XMzXP-0000DL-UH
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 28 Aug 2014 13:14:52 +0000
Content-Disposition: inline
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: kernel-janitors@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

We can make the code a bit simpler because we know that "!retry" is
zero.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 0f61f5a..41bdf51 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -1133,7 +1133,7 @@ free_sbi:
 
 	/* give only one another chance */
 	if (retry) {
-		retry = !retry;
+		retry = 0;
 		shrink_dcache_sb(sb);
 		goto try_onemore;
 	}

------------------------------------------------------------------------------
Slashdot TV.  
Video for Nerds.  Stuff that matters.
http://tv.slashdot.org/
