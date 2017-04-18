From: Jin Qian <jinqian@google.com>
Subject: [PATCH 1/1] fsck.f2fs: fix cur_valid_map buffer overflow
Date: Tue, 18 Apr 2017 10:58:05 -0700
Message-ID: <20170418175805.17594-1-jinqian@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jinqian@google.com>) id 1d0Xni-0006EL-Gj
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 18 Apr 2017 18:24:30 +0000
Received: from mail-pf0-f174.google.com ([209.85.192.174])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1d0Xng-0003G6-Hz
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 18 Apr 2017 18:24:30 +0000
Received: by mail-pf0-f174.google.com with SMTP id 194so456817pfv.3
	for <linux-f2fs-devel@lists.sourceforge.net>;
	Tue, 18 Apr 2017 11:24:28 -0700 (PDT)
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

blk_off is read from image. Attacker can construct an image with big
blk_off that trigger overflow on se->cur_valid_map.

Signed-off-by: Jin Qian <jinqian@google.com>
---
 fsck/fsck.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fsck/fsck.c b/fsck/fsck.c
index b625153..e97ee0a 100644
--- a/fsck/fsck.c
+++ b/fsck/fsck.c
@@ -1825,6 +1825,8 @@ int check_curseg_offset(struct f2fs_sb_info *sbi)
 		struct seg_entry *se;
 		int j, nblocks;
 
+		if ((curseg->next_blkoff >> 3) >= SIT_VBLOCK_MAP_SIZE)
+			return -EINVAL;
 		se = get_seg_entry(sbi, curseg->segno);
 		if (f2fs_test_bit(curseg->next_blkoff,
 					(const char *)se->cur_valid_map)) {
-- 
2.12.2.762.g0e3151a226-goog


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
