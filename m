From: Michael Halcrow via Linux-f2fs-devel
 <linux-f2fs-devel@lists.sourceforge.net>
Subject: [PATCH 1/3] ext4 crypto: Return -EXDEV for link, rename,
 and cross-rename between incompat contexts
Date: Thu,  7 Sep 2017 17:12:02 -0700
Message-ID: <20170908001204.18174-2-mhalcrow@google.com>
References: <20170908001204.18174-1-mhalcrow@google.com>
Reply-To: Michael Halcrow <mhalcrow@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
 helo=mx.sourceforge.net)
 by sfs-ml-1.v29.ch3.sourceforge.com with esmtps (TLSv1:DHE-RSA-AES256-SHA:256)
 (Exim 4.89) (envelope-from <mhalcrow@google.com>) id 1dq6uU-0003LP-FM
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 08 Sep 2017 00:12:38 +0000
Received: from mail-pf0-f177.google.com ([209.85.192.177])
 by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
 (Exim 4.76) id 1dq6uT-0008MI-MD
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 08 Sep 2017 00:12:38 +0000
Received: by mail-pf0-f177.google.com with SMTP id y29so1146568pff.0
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu, 07 Sep 2017 17:12:37 -0700 (PDT)
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
 fs/ext4/namei.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
index c1cf020d1889..3c493bc4273d 100644
--- a/fs/ext4/namei.c
+++ b/fs/ext4/namei.c
@@ -3223,7 +3223,7 @@ static int ext4_link(struct dentry *old_dentry,
 		return -EMLINK;
 	if (ext4_encrypted_inode(dir) &&
 			!fscrypt_has_permitted_context(dir, inode))
-		return -EPERM;
+		return -EXDEV;
 
        if ((ext4_test_inode_flag(dir, EXT4_INODE_PROJINHERIT)) &&
 	   (!projid_eq(EXT4_I(dir)->i_projid,
@@ -3552,7 +3552,7 @@ static int ext4_rename(struct inode *old_dir, struct dentry *old_dentry,
 	if ((old.dir != new.dir) &&
 	    ext4_encrypted_inode(new.dir) &&
 	    !fscrypt_has_permitted_context(new.dir, old.inode)) {
-		retval = -EPERM;
+		retval = -EXDEV;
 		goto end_rename;
 	}
 
@@ -3732,7 +3732,7 @@ static int ext4_cross_rename(struct inode *old_dir, struct dentry *old_dentry,
 	    (old_dir != new_dir) &&
 	    (!fscrypt_has_permitted_context(new_dir, old.inode) ||
 	     !fscrypt_has_permitted_context(old_dir, new.inode)))
-		return -EPERM;
+		return -EXDEV;
 
 	if ((ext4_test_inode_flag(new_dir, EXT4_INODE_PROJINHERIT) &&
 	     !projid_eq(EXT4_I(new_dir)->i_projid,
-- 
2.14.1.581.gf28d330327-goog


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
