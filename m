From: Wang Sheng-Hui <shhuiw@gmail.com>
Subject: [f2fs-dev] [PATCH] f2fs-tools: fix the total_zones calculation in
	f2fs_prepare_super_block
Date: Fri, 28 Jun 2013 13:21:07 +0800
Message-ID: <51CD1D43.5040004@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <shhuiw@gmail.com>) id 1UsR7b-0003EX-Vw
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 28 Jun 2013 05:21:24 +0000
Received: from mail-ie0-f173.google.com ([209.85.223.173])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1UsR7a-0004bt-8d
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 28 Jun 2013 05:21:23 +0000
Received: by mail-ie0-f173.google.com with SMTP id k13so3341708iea.18
	for <linux-f2fs-devel@lists.sourceforge.net>;
	Thu, 27 Jun 2013 22:21:17 -0700 (PDT)
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

We can count the main area as the data zones. Remove the '-1' miscalcuation.

Signed-off-by: Wang Sheng-Hui <shhuiw@gmail.com>
---
  mkfs/f2fs_format.c |    5 ++---
  1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/mkfs/f2fs_format.c b/mkfs/f2fs_format.c
index f00ba04..4d7ea84 100644
--- a/mkfs/f2fs_format.c
+++ b/mkfs/f2fs_format.c
@@ -372,9 +372,8 @@ static int f2fs_prepare_super_block(void)
  	super_block.meta_ino = cpu_to_le32(2);
  	super_block.root_ino = cpu_to_le32(3);

-	total_zones = ((le32_to_cpu(super_block.segment_count_main) - 1) /
-			config.segs_per_sec) /
-			config.secs_per_zone;
+	total_zones = le32_to_cpu(super_block.segment_count_main) /
+			(config.segs_per_sec * config.secs_per_zone);
  	if (total_zones <= 6) {
  		MSG(1, "\tError: %d zones: Need more zones \
  			by shrinking zone size\n", total_zones);
-- 
1.7.10.4


------------------------------------------------------------------------------
This SF.net email is sponsored by Windows:

Build for Windows Store.

http://p.sf.net/sfu/windows-dev2dev
