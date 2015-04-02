From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 3/5] f2fs: assign parent's i_mode for empty dir
Date: Thu,  2 Apr 2015 10:49:23 -0700
Message-ID: <1427996965-10578-3-git-send-email-jaegeuk@kernel.org>
References: <1427996965-10578-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1YdjFW-0002Gz-6B
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 02 Apr 2015 17:49:50 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1YdjFU-0004dW-Rp for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 02 Apr 2015 17:49:50 +0000
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

When assigning i_mode for dotdot, it needs to assign parent's i_mode.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/dir.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
index b2970fb..60a2a41 100644
--- a/fs/f2fs/dir.c
+++ b/fs/f2fs/dir.c
@@ -334,7 +334,7 @@ void do_make_empty_dir(struct inode *inode, struct inode *parent,
 	de->name_len = cpu_to_le16(2);
 	de->ino = cpu_to_le32(parent->i_ino);
 	memcpy(d->filename[1], "..", 2);
-	set_de_type(de, inode->i_mode);
+	set_de_type(de, parent->i_mode);
 
 	test_and_set_bit_le(0, (void *)d->bitmap);
 	test_and_set_bit_le(1, (void *)d->bitmap);
-- 
2.1.1


------------------------------------------------------------------------------
Dive into the World of Parallel Programming The Go Parallel Website, sponsored
by Intel and developed in partnership with Slashdot Media, is your hub for all
things parallel software development, from weekly thought leadership blogs to
news, videos, case studies, tutorials and more. Take a look and join the 
conversation now. http://goparallel.sourceforge.net/
