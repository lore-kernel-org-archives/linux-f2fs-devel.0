From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 2/2] f2fs: avoid dirty node pages in check_only
	recovery
Date: Fri, 14 Apr 2017 17:16:11 -0700
Message-ID: <20170415001611.9059-2-jaegeuk@kernel.org>
References: <20170415001611.9059-1-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1czBO5-0006Wi-WE
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 15 Apr 2017 00:16:26 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1czBO4-0005FW-TU
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 15 Apr 2017 00:16:25 +0000
In-Reply-To: <20170415001611.9059-1-jaegeuk@kernel.org>
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

In the check_only mode, we should not make any dirty node pages. Otherwise,
we can get this panic:

F2FS-fs (nvme0n1p1): Need to recover fsync data
------------[ cut here ]------------
kernel BUG at fs/f2fs/node.c:2204!
CPU: 7 PID: 19923 Comm: mount Tainted: G           OE   4.9.8 #2
RIP: 0010:[<ffffffffc0979c0b>]  [<ffffffffc0979c0b>] flush_nat_entries+0x43b/0x7d0 [f2fs]
Call Trace:
 [<ffffffffc096ddaa>] ? __f2fs_submit_merged_bio+0x5a/0xd0 [f2fs]
 [<ffffffffc096ddaa>] ? __f2fs_submit_merged_bio+0x5a/0xd0 [f2fs]
 [<ffffffffc096dddb>] ? __f2fs_submit_merged_bio+0x8b/0xd0 [f2fs]
 [<ffffffff860e450f>] ? up_write+0x1f/0x40
 [<ffffffffc096dddb>] ? __f2fs_submit_merged_bio+0x8b/0xd0 [f2fs]
 [<ffffffffc0969f04>] write_checkpoint+0x2f4/0xf20 [f2fs]
 [<ffffffff860e938d>] ? trace_hardirqs_on+0xd/0x10
 [<ffffffffc0960bc9>] ? f2fs_sync_fs+0x79/0x190 [f2fs]
 [<ffffffffc0960bc9>] ? f2fs_sync_fs+0x79/0x190 [f2fs]
 [<ffffffffc0960bd5>] f2fs_sync_fs+0x85/0x190 [f2fs]
 [<ffffffffc097b6de>] f2fs_balance_fs_bg+0x7e/0x1c0 [f2fs]
 [<ffffffffc0977b64>] f2fs_write_node_pages+0x34/0x350 [f2fs]
 [<ffffffff860e5f42>] ? __lock_is_held+0x52/0x70
 [<ffffffff861d9b31>] do_writepages+0x21/0x30
 [<ffffffff86298ce1>] __writeback_single_inode+0x61/0x760
 [<ffffffff86909127>] ? _raw_spin_unlock+0x27/0x40
 [<ffffffff8629a735>] writeback_single_inode+0xd5/0x190
 [<ffffffff8629a889>] write_inode_now+0x99/0xc0
 [<ffffffff86283876>] iput+0x1f6/0x2c0
 [<ffffffffc0964b52>] f2fs_fill_super+0xc32/0x10c0 [f2fs]
 [<ffffffff86266462>] mount_bdev+0x182/0x1b0
 [<ffffffffc0963f20>] ? f2fs_commit_super+0x100/0x100 [f2fs]
 [<ffffffffc0960da5>] f2fs_mount+0x15/0x20 [f2fs]
 [<ffffffff86266e08>] mount_fs+0x38/0x170
 [<ffffffff86288bab>] vfs_kern_mount+0x6b/0x160
 [<ffffffff8628bcfe>] do_mount+0x1be/0xd60

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/recovery.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/fs/f2fs/recovery.c b/fs/f2fs/recovery.c
index d025aa83fb5b..907d6b7dde6a 100644
--- a/fs/f2fs/recovery.c
+++ b/fs/f2fs/recovery.c
@@ -198,7 +198,8 @@ static void recover_inode(struct inode *inode, struct page *page)
 			ino_of_node(page), name);
 }
 
-static int find_fsync_dnodes(struct f2fs_sb_info *sbi, struct list_head *head)
+static int find_fsync_dnodes(struct f2fs_sb_info *sbi, struct list_head *head,
+				bool check_only)
 {
 	struct curseg_info *curseg;
 	struct page *page = NULL;
@@ -225,7 +226,8 @@ static int find_fsync_dnodes(struct f2fs_sb_info *sbi, struct list_head *head)
 
 		entry = get_fsync_inode(head, ino_of_node(page));
 		if (!entry) {
-			if (IS_INODE(page) && is_dent_dnode(page)) {
+			if (!check_only &&
+					IS_INODE(page) && is_dent_dnode(page)) {
 				err = recover_inode_page(sbi, page);
 				if (err)
 					break;
@@ -569,7 +571,7 @@ int recover_fsync_data(struct f2fs_sb_info *sbi, bool check_only)
 	mutex_lock(&sbi->cp_mutex);
 
 	/* step #1: find fsynced inode numbers */
-	err = find_fsync_dnodes(sbi, &inode_list);
+	err = find_fsync_dnodes(sbi, &inode_list, check_only);
 	if (err || list_empty(&inode_list))
 		goto out;
 
-- 
2.11.0


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
