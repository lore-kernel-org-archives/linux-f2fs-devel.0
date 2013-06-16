From: Namjae Jeon <linkinjeon@gmail.com>
Subject: [f2fs-dev] [PATCH 2/2] f2fs: optimise the init_dirty_segmap function
Date: Sun, 16 Jun 2013 09:49:11 +0900
Message-ID: <1371343751-2710-1-git-send-email-linkinjeon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <linkinjeon@gmail.com>) id 1Uo19t-0001an-7a
	for linux-f2fs-devel@lists.sourceforge.net;
	Sun, 16 Jun 2013 00:49:29 +0000
Received: from mail-pa0-f51.google.com ([209.85.220.51])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1Uo19p-0004QO-GY
	for linux-f2fs-devel@lists.sourceforge.net;
	Sun, 16 Jun 2013 00:49:29 +0000
Received: by mail-pa0-f51.google.com with SMTP id lf11so1727195pab.24
	for <linux-f2fs-devel@lists.sourceforge.net>;
	Sat, 15 Jun 2013 17:49:19 -0700 (PDT)
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: jaegeuk.kim@samsung.com
Cc: Namjae Jeon <linkinjeon@gmail.com>, Namjae Jeon <namjae.jeon@samsung.com>, Pankaj Kumar <pankaj.km@samsung.com>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

From: Namjae Jeon <namjae.jeon@samsung.com>

Optimise the while loop condition

Since this condition will always be true and while loop will
be terminated by the following condition in code:

if (segno >= TOTAL_SEGS(sbi))
    break;
Hence we can replace the while loop condition with while(1)
instead of always checking for segno to be less than Total segs.

Also we do not need to use TOTAL_SEGS() everytime. We can store
this value in a local variable since this value is constant.

Signed-off-by: Namjae Jeon <namjae.jeon@samsung.com>
Signed-off-by: Pankaj Kumar <pankaj.km@samsung.com>
---
 fs/f2fs/segment.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index b15debc..e351222 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -1582,13 +1582,13 @@ static void init_dirty_segmap(struct f2fs_sb_info *sbi)
 {
 	struct dirty_seglist_info *dirty_i = DIRTY_I(sbi);
 	struct free_segmap_info *free_i = FREE_I(sbi);
-	unsigned int segno = 0, offset = 0;
+	unsigned int segno = 0, offset = 0, total_segs = TOTAL_SEGS(sbi);
 	unsigned short valid_blocks;
 
-	while (segno < TOTAL_SEGS(sbi)) {
+	while (1) {
 		/* find dirty segment based on free segmap */
-		segno = find_next_inuse(free_i, TOTAL_SEGS(sbi), offset);
-		if (segno >= TOTAL_SEGS(sbi))
+		segno = find_next_inuse(free_i, total_segs, offset);
+		if (segno >= total_segs)
 			break;
 		offset = segno + 1;
 		valid_blocks = get_valid_blocks(sbi, segno, 0);
-- 
1.7.9.5


------------------------------------------------------------------------------
This SF.net email is sponsored by Windows:

Build for Windows Store.

http://p.sf.net/sfu/windows-dev2dev
