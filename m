From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 2/3] f2fs: clear append/update flags once fsync
	is done
Date: Tue,  3 Mar 2015 10:02:48 -0800
Message-ID: <1425405769-92563-2-git-send-email-jaegeuk@kernel.org>
References: <1425405769-92563-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1YSr9v-0006Ch-0C
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 03 Mar 2015 18:03:07 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1YSr9q-0005tH-KR for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 03 Mar 2015 18:03:06 +0000
In-Reply-To: <1425405769-92563-1-git-send-email-jaegeuk@kernel.org>
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

When fsync is done through checkpoint, previous f2fs missed to clear append
and update flag. This patch fixes to clear them.

This was originally catched by Changman Lee before.

Signed-off-by: Changman Lee <cm224.lee@samsung.com>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/file.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 0deee3b..f1341c7 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -241,6 +241,8 @@ go_write:
 		 * will be used only for fsynced inodes after checkpoint.
 		 */
 		try_to_fix_pino(inode);
+		clear_inode_flag(fi, FI_APPEND_WRITE);
+		clear_inode_flag(fi, FI_UPDATE_WRITE);
 		goto out;
 	}
 sync_nodes:
-- 
2.1.1


------------------------------------------------------------------------------
Dive into the World of Parallel Programming The Go Parallel Website, sponsored
by Intel and developed in partnership with Slashdot Media, is your hub for all
things parallel software development, from weekly thought leadership blogs to
news, videos, case studies, tutorials and more. Take a look and join the 
conversation now. http://goparallel.sourceforge.net/
