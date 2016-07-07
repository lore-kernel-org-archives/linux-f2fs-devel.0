From: Chao Yu <chao@kernel.org>
Subject: [PATCH v2] f2fs: fix to avoid redundant discard during
	fstrim
Date: Thu,  7 Jul 2016 22:46:55 +0800
Message-ID: <1467902815-13624-1-git-send-email-chao@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chao@kernel.org>) id 1bLAc7-0000Cw-Kz
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 07 Jul 2016 14:49:15 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1bLAc5-0006tD-Gc
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 07 Jul 2016 14:49:15 +0000
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

From: Chao Yu <yuchao0@huawei.com>

With below test steps, f2fs will issue redundant discard when doing fstrim,
the reason is that we issue discards for both prefree segments and
consecutive freed region user wants to trim, part regions they covered are
overlapped, here, we change to do not to issue any discards for prefree
segments in trimmed range.

1. mount -t f2fs -o discard /dev/zram0 /mnt/f2fs
2. fstrim -o 0 -l 3221225472 -m 2097152 -v /mnt/f2fs/
3. dd if=/dev/zero  of=/mnt/f2fs/a bs=2M count=1
4. dd if=/dev/zero  of=/mnt/f2fs/b bs=1M count=1
5. sync
6. rm /mnt/f2fs/a /mnt/f2fs/b
7. fstrim -o 0 -l 3221225472 -m 2097152 -v /mnt/f2fs/

Before:
<...>-5428  [001] ...1  9511.052125: f2fs_issue_discard: dev = (251,0), blkstart = 0x2200, blklen = 0x200
<...>-5428  [001] ...1  9511.052787: f2fs_issue_discard: dev = (251,0), blkstart = 0x2200, blklen = 0x300

After:
<...>-6764  [000] ...1  9720.382504: f2fs_issue_discard: dev = (251,0), blkstart = 0x2200, blklen = 0x300

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
v2: do not skip cleaning up bitmap/refcount of prefree segment.
 fs/f2fs/segment.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 6d16ecf..e508b15 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -710,6 +710,7 @@ void clear_prefree_segments(struct f2fs_sb_info *sbi, struct cp_control *cpc)
 	unsigned long *prefree_map = dirty_i->dirty_segmap[PRE];
 	unsigned int start = 0, end = -1;
 	unsigned int secno, start_segno;
+	bool force = (cpc->reason == CP_DISCARD);
 
 	mutex_lock(&dirty_i->seglist_lock);
 
@@ -726,7 +727,7 @@ void clear_prefree_segments(struct f2fs_sb_info *sbi, struct cp_control *cpc)
 
 		dirty_i->nr_dirty[PRE] -= end - start;
 
-		if (!test_opt(sbi, DISCARD))
+		if (force || !test_opt(sbi, DISCARD))
 			continue;
 
 		if (!test_opt(sbi, LFS) || sbi->segs_per_sec == 1) {
@@ -750,7 +751,7 @@ next:
 
 	/* send small discards */
 	list_for_each_entry_safe(entry, this, head, list) {
-		if (cpc->reason == CP_DISCARD && entry->len < cpc->trim_minlen)
+		if (force && entry->len < cpc->trim_minlen)
 			goto skip;
 		f2fs_issue_discard(sbi, entry->blkaddr, entry->len);
 		cpc->trimmed += entry->len;
-- 
2.7.2


------------------------------------------------------------------------------
Attend Shape: An AT&T Tech Expo July 15-16. Meet us at AT&T Park in San
Francisco, CA to explore cutting-edge tech and listen to tech luminaries
present their vision of the future. This family event has something for
everyone, including kids. Get more information and register today.
http://sdm.link/attshape
