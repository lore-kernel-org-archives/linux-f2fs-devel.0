From: Kinglong Mee <kinglongmee@gmail.com>
Subject: [PATCH 3/4] f2fs: check new size by inode_newsize_ok in
 f2fs_insert_range
Date: Fri, 10 Mar 2017 17:54:52 +0800
Message-ID: <5bdebecb-1c88-9310-b30f-dba414c2fb19@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <kinglongmee@gmail.com>) id 1cmHGI-0000s2-Dj
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 10 Mar 2017 09:55:02 +0000
Received: from mail-it0-f68.google.com ([209.85.214.68])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1cmHGH-00045D-Oj
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 10 Mar 2017 09:55:02 +0000
Received: by mail-it0-f68.google.com with SMTP id w185so827909ita.3
	for <linux-f2fs-devel@lists.sourceforge.net>;
	Fri, 10 Mar 2017 01:55:01 -0800 (PST)
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Jaegeuk Kim <jaegeuk@kernel.org>, linux-f2fs-devel@lists.sourceforge.net

The inode_newsize_ok is better than only checking the maxbytes,
eg. the rlimit etc.

Signed-off-by: Kinglong Mee <kinglongmee@gmail.com>
---
 fs/f2fs/file.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 88afe0f..08bfab3 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -1256,8 +1256,9 @@ static int f2fs_insert_range(struct inode *inode, loff_t offset, loff_t len)
 	int ret = 0;
 
 	new_size = i_size_read(inode) + len;
-	if (new_size > inode->i_sb->s_maxbytes)
-		return -EFBIG;
+	ret = inode_newsize_ok(inode, new_size);
+	if (ret)
+		return ret;
 
 	if (offset >= i_size_read(inode))
 		return -EINVAL;
-- 
2.9.3


------------------------------------------------------------------------------
Announcing the Oxford Dictionaries API! The API offers world-renowned
dictionary content that is easy and intuitive to access. Sign up for an
account today to start using our lexical data to power your apps and
projects. Get started today and enter our developer competition.
http://sdm.link/oxford
