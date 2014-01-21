From: Jaegeuk Kim <jaegeuk.kim@samsung.com>
Subject: [PATCH 2/2] f2fs: move a branch for code redability
Date: Tue, 21 Jan 2014 18:54:34 +0900
Message-ID: <1390298075-21458-2-git-send-email-jaegeuk.kim@samsung.com>
References: <1390298075-21458-1-git-send-email-jaegeuk.kim@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk.kim@samsung.com>) id 1W5Y41-0004OC-53
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 21 Jan 2014 09:56:09 +0000
Received: from mailout3.samsung.com ([203.254.224.33])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-MD5:128)
	(Exim 4.76) id 1W5Y3z-0000TL-1T
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 21 Jan 2014 09:56:09 +0000
Received: from epcpsbgr4.samsung.com
	(u144.gpu120.samsung.co.kr [203.254.230.144])
	by mailout3.samsung.com (Oracle Communications Messaging Server
	7u4-24.01 (7.0.4.24.0) 64bit (built Nov 17 2011))
	with ESMTP id <0MZQ00F2JWXBU060@mailout3.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Tue, 21 Jan 2014 18:55:59 +0900 (KST)
In-reply-to: <1390298075-21458-1-git-send-email-jaegeuk.kim@samsung.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

This patch moves a function in f2fs_delete_entry for code readability.

Signed-off-by: Jaegeuk Kim <jaegeuk.kim@samsung.com>
---
 fs/f2fs/dir.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
index 1679e8b..2d5c657 100644
--- a/fs/f2fs/dir.c
+++ b/fs/f2fs/dir.c
@@ -552,12 +552,11 @@ void f2fs_delete_entry(struct f2fs_dir_entry *dentry, struct page *page,
 	dir->i_ctime = dir->i_mtime = CURRENT_TIME;
 	mark_inode_dirty(dir);
 
-	if (inode && S_ISDIR(inode->i_mode)) {
-		drop_nlink(dir);
-		update_inode_page(dir);
-	}
-
 	if (inode) {
+		if (S_ISDIR(inode->i_mode)) {
+			drop_nlink(dir);
+			update_inode_page(dir);
+		}
 		inode->i_ctime = CURRENT_TIME;
 		drop_nlink(inode);
 		if (S_ISDIR(inode->i_mode)) {
-- 
1.8.4.474.g128a96c


------------------------------------------------------------------------------
CenturyLink Cloud: The Leader in Enterprise Cloud Services.
Learn Why More Businesses Are Choosing CenturyLink Cloud For
Critical Workloads, Development Environments & Everything In Between.
Get a Quote or Start a Free Trial Today. 
http://pubads.g.doubleclick.net/gampad/clk?id=119420431&iu=/4140/ostg.clktrk
