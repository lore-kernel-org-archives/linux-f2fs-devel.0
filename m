From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 5/5] f2fs: do not recover wrong data index
Date: Thu,  2 Apr 2015 10:49:25 -0700
Message-ID: <1427996965-10578-5-git-send-email-jaegeuk@kernel.org>
References: <1427996965-10578-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1YdjFb-0003xi-6Z
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 02 Apr 2015 17:49:55 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1YdjFa-0002bb-8d for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 02 Apr 2015 17:49:55 +0000
In-Reply-To: <1427996965-10578-1-git-send-email-jaegeuk@kernel.org>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>

During the roll-forward recovery, if we found a new data index written fsync
lastly, we need to recover new block address.
But, if that address was corrupted, we should not recover that.
Otherwise, f2fs gets kernel panic from:

 In check_index_in_prev_nodes(),

    sentry = get_seg_entry(sbi, segno);
             --------------------------> out-of-range segno.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/recovery.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/recovery.c b/fs/f2fs/recovery.c
index 63b720b..4b742c9 100644
--- a/fs/f2fs/recovery.c
+++ b/fs/f2fs/recovery.c
@@ -395,7 +395,9 @@ static int do_recover_data(struct f2fs_sb_info *sbi, struct inode *inode,
 		src = datablock_addr(dn.node_page, dn.ofs_in_node);
 		dest = datablock_addr(page, dn.ofs_in_node);
 
-		if (src != dest && dest != NEW_ADDR && dest != NULL_ADDR) {
+		if (src != dest && dest != NEW_ADDR && dest != NULL_ADDR &&
+			dest >= MAIN_BLKADDR(sbi) && dest < MAX_BLKADDR(sbi)) {
+
 			if (src == NULL_ADDR) {
 				err = reserve_new_block(&dn);
 				/* We should not get -ENOSPC */
-- 
2.1.1


------------------------------------------------------------------------------
Dive into the World of Parallel Programming The Go Parallel Website, sponsored
by Intel and developed in partnership with Slashdot Media, is your hub for all
things parallel software development, from weekly thought leadership blogs to
news, videos, case studies, tutorials and more. Take a look and join the 
conversation now. http://goparallel.sourceforge.net/
