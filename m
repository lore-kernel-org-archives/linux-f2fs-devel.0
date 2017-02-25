From: Kinglong Mee <kinglongmee@gmail.com>
Subject: [PATCH] f2fs: update the comment of default nr_pages to
	skipping
Date: Sat, 25 Feb 2017 19:32:21 +0800
Message-ID: <d484159d-9849-60f0-5317-c7d53fad2bb7@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <kinglongmee@gmail.com>) id 1chaaX-0004d2-96
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 25 Feb 2017 11:32:33 +0000
Received: from mail-io0-f195.google.com ([209.85.223.195])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1chaaW-0002nC-C1
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 25 Feb 2017 11:32:33 +0000
Received: by mail-io0-f195.google.com with SMTP id w10so1292608iod.3
	for <linux-f2fs-devel@lists.sourceforge.net>;
	Sat, 25 Feb 2017 03:32:32 -0800 (PST)
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
Cc: linux-f2fs-devel@lists.sourceforge.net

Fixes: 2c237ebaa4 ("f2fs: avoid writing node/metapages during writes")
Signed-off-by: Kinglong Mee <kinglongmee@gmail.com>
---
 fs/f2fs/segment.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h
index f4020f1..5e8ad42 100644
--- a/fs/f2fs/segment.h
+++ b/fs/f2fs/segment.h
@@ -736,8 +736,8 @@ static inline bool sec_usage_check(struct f2fs_sb_info *sbi, unsigned int secno)
  * It is very important to gather dirty pages and write at once, so that we can
  * submit a big bio without interfering other data writes.
  * By default, 512 pages for directory data,
- * 512 pages (2MB) * 3 for three types of nodes, and
- * max_bio_blocks for meta are set.
+ * 512 pages (2MB) * 8 for nodes, and
+ * 256 pages * 8 for meta are set.
  */
 static inline int nr_pages_to_skip(struct f2fs_sb_info *sbi, int type)
 {
-- 
2.9.3


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, SlashDot.org! http://sdm.link/slashdot
