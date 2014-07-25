From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 09/11] f2fs: test before set/clear bits
Date: Fri, 25 Jul 2014 15:47:23 -0700
Message-ID: <1406328445-63707-9-git-send-email-jaegeuk@kernel.org>
References: <1406328445-63707-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1XAoIx-0001JZ-KD
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 25 Jul 2014 22:49:35 +0000
Received: from mail.kernel.org ([198.145.19.201])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1XAoIw-00028L-UP for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 25 Jul 2014 22:49:35 +0000
In-Reply-To: <1406328445-63707-1-git-send-email-jaegeuk@kernel.org>
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

If the bit is already set, we don't need to reset it, and vice versa.
Because we don't need to make the caches dirty for that.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/f2fs.h | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 8f8685e..475f97c 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1003,7 +1003,8 @@ enum {
 
 static inline void set_inode_flag(struct f2fs_inode_info *fi, int flag)
 {
-	set_bit(flag, &fi->flags);
+	if (!test_bit(flag, &fi->flags))
+		set_bit(flag, &fi->flags);
 }
 
 static inline int is_inode_flag_set(struct f2fs_inode_info *fi, int flag)
@@ -1013,7 +1014,8 @@ static inline int is_inode_flag_set(struct f2fs_inode_info *fi, int flag)
 
 static inline void clear_inode_flag(struct f2fs_inode_info *fi, int flag)
 {
-	clear_bit(flag, &fi->flags);
+	if (test_bit(flag, &fi->flags))
+		clear_bit(flag, &fi->flags);
 }
 
 static inline void set_acl_inode(struct f2fs_inode_info *fi, umode_t mode)
-- 
1.8.5.2 (Apple Git-48)


------------------------------------------------------------------------------
Want fast and easy access to all the code in your enterprise? Index and
search up to 200,000 lines of code with a free copy of Black Duck
Code Sight - the same software that powers the world's largest code
search on Ohloh, the Black Duck Open Hub! Try it now.
http://p.sf.net/sfu/bds
