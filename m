From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 3/4] f2fs: show more precise message on orphan
	recovery failure
Date: Tue,  7 Mar 2017 14:13:02 -0800
Message-ID: <20170307221303.6757-3-jaegeuk@kernel.org>
References: <20170307221303.6757-1-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1clNM4-0007pp-IM
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 07 Mar 2017 22:13:16 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1clNM3-0007YE-TR
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 07 Mar 2017 22:13:16 +0000
In-Reply-To: <20170307221303.6757-1-jaegeuk@kernel.org>
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

This case is not caused by fsck.f2fs. User needs to retry mount.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/checkpoint.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index 91734cc13f71..36ccc30ed54b 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -568,7 +568,7 @@ static int recover_orphan_inode(struct f2fs_sb_info *sbi, nid_t ino)
 	if (ni.blk_addr != NULL_ADDR) {
 		set_sbi_flag(sbi, SBI_NEED_FSCK);
 		f2fs_msg(sbi->sb, KERN_WARNING,
-			"%s: orphan failed (ino=%x), run fsck to fix.",
+			"%s: orphan failed (ino=%x) by kernel, retry mount.",
 				__func__, ino);
 		return -EIO;
 	}
-- 
2.11.0


------------------------------------------------------------------------------
Announcing the Oxford Dictionaries API! The API offers world-renowned
dictionary content that is easy and intuitive to access. Sign up for an
account today to start using our lexical data to power your apps and
projects. Get started today and enter our developer competition.
http://sdm.link/oxford
