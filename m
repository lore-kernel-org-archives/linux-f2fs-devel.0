From: Wanpeng Li <wanpeng.li@linux.intel.com>
Subject: [PATCH v3 2/2] f2fs: enable fast symlink by utilizing
	inline data
Date: Tue, 24 Mar 2015 10:20:28 +0800
Message-ID: <1427163628-3840-2-git-send-email-wanpeng.li@linux.intel.com>
References: <1427163628-3840-1-git-send-email-wanpeng.li@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <wanpeng.li@linux.intel.com>) id 1YaEjn-00072s-MA
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 24 Mar 2015 02:38:39 +0000
Received: from mga02.intel.com ([134.134.136.20])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1YaEjm-0008VC-Ko for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 24 Mar 2015 02:38:39 +0000
In-Reply-To: <1427163628-3840-1-git-send-email-wanpeng.li@linux.intel.com>
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
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org

Fast symlink can utilize inline data flow to avoid using any
i_addr region, since we need to handle many cases such as
truncation, roll-forward recovery, and fsck/dump tools.

Signed-off-by: Wanpeng Li <wanpeng.li@linux.intel.com>
---
 fs/f2fs/inline.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/inline.c b/fs/f2fs/inline.c
index d3e0599..375d2c7 100644
--- a/fs/f2fs/inline.c
+++ b/fs/f2fs/inline.c
@@ -21,7 +21,7 @@ bool f2fs_may_inline(struct inode *inode)
 	if (f2fs_is_atomic_file(inode))
 		return false;
 
-	if (!S_ISREG(inode->i_mode))
+	if (!S_ISREG(inode->i_mode) && !S_ISLNK(inode->i_mode))
 		return false;
 
 	if (i_size_read(inode) > MAX_INLINE_DATA)
-- 
2.1.0


------------------------------------------------------------------------------
Dive into the World of Parallel Programming The Go Parallel Website, sponsored
by Intel and developed in partnership with Slashdot Media, is your hub for all
things parallel software development, from weekly thought leadership blogs to
news, videos, case studies, tutorials and more. Take a look and join the 
conversation now. http://goparallel.sourceforge.net/
