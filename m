From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH] f2fs: fix sparse warnings
Date: Tue, 24 Mar 2015 12:07:38 -0700
Message-ID: <1427224058-43092-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1YaUB7-00031s-Ne
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 24 Mar 2015 19:07:53 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1YaUB6-00033A-Mz for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 24 Mar 2015 19:07:53 +0000
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

This patch fixes the below warning.

sparse warnings: (new ones prefixed by >>)

>> fs/f2fs/inode.c:56:23: sparse: restricted __le32 degrades to integer
>> fs/f2fs/inode.c:56:52: sparse: restricted __le32 degrades to integer

Reported-by: kbuild test robot <fengguang.wu@intel.com>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/inode.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
index 07237ac..e622ec9 100644
--- a/fs/f2fs/inode.c
+++ b/fs/f2fs/inode.c
@@ -53,7 +53,9 @@ static void __get_inode_rdev(struct inode *inode, struct f2fs_inode *ri)
 
 static bool __written_first_block(struct f2fs_inode *ri)
 {
-	if (ri->i_addr[0] != NEW_ADDR && ri->i_addr[0] != NULL_ADDR)
+	block_t addr = le32_to_cpu(ri->i_addr[0]);
+
+	if (addr != NEW_ADDR && addr != NULL_ADDR)
 		return true;
 	return false;
 }
-- 
2.1.1


------------------------------------------------------------------------------
Dive into the World of Parallel Programming The Go Parallel Website, sponsored
by Intel and developed in partnership with Slashdot Media, is your hub for all
things parallel software development, from weekly thought leadership blogs to
news, videos, case studies, tutorials and more. Take a look and join the 
conversation now. http://goparallel.sourceforge.net/
