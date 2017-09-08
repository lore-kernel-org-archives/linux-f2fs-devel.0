From: Michael Halcrow via Linux-f2fs-devel
 <linux-f2fs-devel@lists.sourceforge.net>
Subject: [PATCH 2/3] F2FS crypto: Return -EXDEV for link, rename,
 and cross-rename between incompat contexts
Date: Thu,  7 Sep 2017 17:12:03 -0700
Message-ID: <20170908001204.18174-3-mhalcrow@google.com>
References: <20170908001204.18174-1-mhalcrow@google.com>
Reply-To: Michael Halcrow <mhalcrow@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
 helo=mx.sourceforge.net)
 by sfs-ml-3.v29.ch3.sourceforge.com with esmtps (TLSv1:DHE-RSA-AES256-SHA:256)
 (Exim 4.89) (envelope-from <mhalcrow@google.com>) id 1dq6uX-0001Y2-L7
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 08 Sep 2017 00:12:41 +0000
Received: from mail-pg0-f53.google.com ([74.125.83.53])
 by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
 (Exim 4.76) id 1dq6uW-0005lv-SO
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 08 Sep 2017 00:12:41 +0000
Received: by mail-pg0-f53.google.com with SMTP id t3so2132150pgt.0
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu, 07 Sep 2017 17:12:40 -0700 (PDT)
In-Reply-To: <20170908001204.18174-1-mhalcrow@google.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: linux-fscrypt@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org, linux-mtd@lists.infradead.org, linux-ext4@vger.kernel.org, tytso@mit.edu, linux-f2fs-devel@lists.sourceforge.net

Gives user space the opportunity to fall back to copy-and-delete.

Signed-off-by: Michael Halcrow <mhalcrow@google.com>
---
 fs/f2fs/namei.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
index 760d85223c81..689c671cf8b8 100644
--- a/fs/f2fs/namei.c
+++ b/fs/f2fs/namei.c
@@ -202,7 +202,7 @@ static int f2fs_link(struct dentry *old_dentry, struct inode *dir,
 
 	if (f2fs_encrypted_inode(dir) &&
 			!fscrypt_has_permitted_context(dir, inode))
-		return -EPERM;
+		return -EXDEV;
 
 	err = dquot_initialize(dir);
 	if (err)
@@ -720,7 +720,7 @@ static int f2fs_rename(struct inode *old_dir, struct dentry *old_dentry,
 
 	if ((old_dir != new_dir) && f2fs_encrypted_inode(new_dir) &&
 			!fscrypt_has_permitted_context(new_dir, old_inode)) {
-		err = -EPERM;
+		err = -EXDEV;
 		goto out;
 	}
 
@@ -910,7 +910,7 @@ static int f2fs_cross_rename(struct inode *old_dir, struct dentry *old_dentry,
 			(old_dir != new_dir) &&
 			(!fscrypt_has_permitted_context(new_dir, old_inode) ||
 			 !fscrypt_has_permitted_context(old_dir, new_inode)))
-		return -EPERM;
+		return -EXDEV;
 
 	err = dquot_initialize(old_dir);
 	if (err)
-- 
2.14.1.581.gf28d330327-goog


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
