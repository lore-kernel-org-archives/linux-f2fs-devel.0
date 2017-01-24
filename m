From: Kinglong Mee <kinglongmee@gmail.com>
Subject: [PATCH] mkfs.f2fs: fix bad assignment of total_sectors
 for f2fs_configuration
Date: Tue, 24 Jan 2017 10:42:53 +0800
Message-ID: <130c919b-def1-33b1-0e16-e18e8de28d5c@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <kinglongmee@gmail.com>) id 1cVr4i-0004cP-Kc
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 24 Jan 2017 02:43:12 +0000
Received: from mail-it0-f65.google.com ([209.85.214.65])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1cVr4i-0001rf-0S
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 24 Jan 2017 02:43:12 +0000
Received: by mail-it0-f65.google.com with SMTP id o138so12418835ito.3
	for <linux-f2fs-devel@lists.sourceforge.net>;
	Mon, 23 Jan 2017 18:43:11 -0800 (PST)
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Jaegeuk Kim <jaegeuk@kernel.org>, linux-f2fs-devel@lists.sourceforge.net

wanted_total_sectors is introduced instead total_sectors,
so that, the initialize is a fault, drop it.

Signed-off-by: Kinglong Mee <kinglongmee@gmail.com>
---
 mkfs/f2fs_format_main.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/mkfs/f2fs_format_main.c b/mkfs/f2fs_format_main.c
index db1dc94..5bb1faf 100644
--- a/mkfs/f2fs_format_main.c
+++ b/mkfs/f2fs_format_main.c
@@ -151,9 +151,6 @@ static void f2fs_parse_options(int argc, char *argv[])
 		c.wanted_total_sectors = atoll(argv[optind+1]);
 	}
 
-	if ((optind + 1) < argc)
-		c.total_sectors = atoll(argv[optind+1]);
-
 	if (c.zoned_mode)
 		c.feature |= cpu_to_le32(F2FS_FEATURE_BLKZONED);
 }
-- 
2.9.3


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, SlashDot.org! http://sdm.link/slashdot
