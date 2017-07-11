From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH v2] f2fs: Don't clear SGID when inheriting
 ACLs
Date: Tue, 11 Jul 2017 16:31:24 -0700
Message-ID: <20170711233124.GA96177@jaegeuk-macbookpro.roam.corp.google.com>
References: <20170711205324.90260-1-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1dV4cu-00088G-RX
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 11 Jul 2017 23:31:32 +0000
Received: from mail.kernel.org ([198.145.29.99])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1dV4cs-0004Xr-UF
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 11 Jul 2017 23:31:32 +0000
Content-Disposition: inline
In-Reply-To: <20170711205324.90260-1-jaegeuk@kernel.org>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: Jan Kara <jack@suse.cz>, stable@vger.kernel.org

This patch copies commit b7f8a09f80:
"btrfs: Don't clear SGID when inheriting ACLs" written by Jan.

Fixes: 073931017b49d9458aa351605b43a7e34598caef
CC: stable@vger.kernel.org
Signed-off-by: Jan Kara <jack@suse.cz>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---

Change log from v1:
 - fix for simple change

 fs/f2fs/acl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/acl.c b/fs/f2fs/acl.c
index a140c5e3dc54..b4b8438c42ef 100644
--- a/fs/f2fs/acl.c
+++ b/fs/f2fs/acl.c
@@ -211,7 +211,7 @@ static int __f2fs_set_acl(struct inode *inode, int type,
 	switch (type) {
 	case ACL_TYPE_ACCESS:
 		name_index = F2FS_XATTR_INDEX_POSIX_ACL_ACCESS;
-		if (acl) {
+		if (acl && !ipage) {
 			error = posix_acl_update_mode(inode, &inode->i_mode, &acl);
 			if (error)
 				return error;
-- 
2.13.0.rc1.294.g07d810a77f-goog



------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
