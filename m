From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 2/2] f2fs: don't allow atomic writes for not
	regular files
Date: Fri, 17 Mar 2017 10:09:06 +0800
Message-ID: <20170317020906.28165-2-jaegeuk@kernel.org>
References: <20170317020906.28165-1-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1cohKU-0000OD-J3
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 17 Mar 2017 02:09:22 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1cohKT-0000Sm-TC
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 17 Mar 2017 02:09:22 +0000
In-Reply-To: <20170317020906.28165-1-jaegeuk@kernel.org>
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

The atomic writes only supports regular files for database.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/file.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index da6d33d1bb34..d486e02b43c2 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -1522,6 +1522,9 @@ static int f2fs_ioc_start_atomic_write(struct file *filp)
 	if (f2fs_is_atomic_file(inode))
 		goto out;
 
+	if (!S_ISREG(inode->i_mode))
+		return -EINVAL;
+
 	ret = f2fs_convert_inline_inode(inode);
 	if (ret)
 		goto out;
-- 
2.11.0


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
