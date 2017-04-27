From: Jin Qian <jinqian@google.com>
Subject: [PATCHv2 1/1] f2fs-tools: sanity check segno and blk_off
	when building curseg array
Date: Thu, 27 Apr 2017 15:45:28 -0700
Message-ID: <20170427224528.23298-1-jinqian@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jinqian@google.com>) id 1d3sAX-0007dd-2B
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 27 Apr 2017 22:45:49 +0000
Received: from mail-pf0-f181.google.com ([209.85.192.181])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1d3sAV-0007ve-47
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 27 Apr 2017 22:45:49 +0000
Received: by mail-pf0-f181.google.com with SMTP id v14so39699617pfd.2
	for <linux-f2fs-devel@lists.sourceforge.net>;
	Thu, 27 Apr 2017 15:45:47 -0700 (PDT)
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
Cc: jaegeuk@kernel.org

segno and blk_off were read from input image without sanity check. This
could lead to buffer overflow when accessing internal arrays like SIT
sentries and seg_entry cur_valid_map.

Signed-off-by: Jin Qian <jinqian@google.com>
---
 fsck/mount.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fsck/mount.c b/fsck/mount.c
index ffaa0ed..6e6c552 100644
--- a/fsck/mount.c
+++ b/fsck/mount.c
@@ -1040,6 +1040,9 @@ static void build_curseg(struct f2fs_sb_info *sbi)
 			blk_off = get_cp(cur_node_blkoff[i - CURSEG_HOT_NODE]);
 			segno = get_cp(cur_node_segno[i - CURSEG_HOT_NODE]);
 		}
+		ASSERT(segno < TOTAL_SEGS(sbi));
+		ASSERT(blk_off < DEFAULT_BLOCKS_PER_SEGMENT);
+
 		array[i].segno = segno;
 		array[i].zone = GET_ZONENO_FROM_SEGNO(sbi, segno);
 		array[i].next_segno = NULL_SEGNO;
-- 
2.13.0.rc0.306.g87b477812d-goog


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
