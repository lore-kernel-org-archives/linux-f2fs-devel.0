From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 3/3] f2fs: report -ENOENT for unreached data
	indices
Date: Tue,  3 Mar 2015 10:02:49 -0800
Message-ID: <1425405769-92563-3-git-send-email-jaegeuk@kernel.org>
References: <1425405769-92563-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1YSr9u-0006CX-Pg
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 03 Mar 2015 18:03:06 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1YSr9t-0001bA-2R for linux-f2fs-devel@lists.sourceforge.net;
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

If inode has inline_data, it should report -ENOENT when accessing out-of-bound
region.
This is used by f2fs_fiemap which treats -ENOENT with no error.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/node.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 35a9117..4687eae 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -501,7 +501,7 @@ int get_dnode_of_data(struct dnode_of_data *dn, pgoff_t index, int mode)
 
 	/* if inline_data is set, should not report any block indices */
 	if (f2fs_has_inline_data(dn->inode) && index) {
-		err = -EINVAL;
+		err = -ENOENT;
 		f2fs_put_page(npage[0], 1);
 		goto release_out;
 	}
-- 
2.1.1


------------------------------------------------------------------------------
Dive into the World of Parallel Programming The Go Parallel Website, sponsored
by Intel and developed in partnership with Slashdot Media, is your hub for all
things parallel software development, from weekly thought leadership blogs to
news, videos, case studies, tutorials and more. Take a look and join the 
conversation now. http://goparallel.sourceforge.net/
