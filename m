From: "Russ W. Knize" <rknize@gmail.com>
Subject: [RFC] f2fs: dont take an =?UTF-8?Q?fs=5Flock=20in=20f=32fs=5Fsetx?=  =?UTF-8?Q?attr=28=29?=
Date: Tue, 24 Sep 2013 09:39:31 -0500
Message-ID: <e28992f12d725c3f0c0137aa046c8786@www.metagalaxy.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-fsdevel-owner@vger.kernel.org>
Sender: linux-fsdevel-owner@vger.kernel.org
To: linux-f2fs-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

The VFS layer already protects xattr_handler.set from concurrent
access via an inode mutex, so there is no reason to take an fs_lock
as well.  This avoids a potential dealock:

- vfs_create()
  - f2fs_create() - takes an fs_lock
   - f2fs_add_link()
    - __f2fs_add_link()
     - init_inode_metadata()
      - f2fs_init_security()
       - security_inode_init_security()
        - f2fs_initxattrs()
         - f2fs_setxattr() - also takes an fs_lock

If the caller happens to grab the same fs_lock from the pool in both
places, they will deadlock.

Signed-off-by: Russ Knize <rknize@motorola.com>
---
  fs/f2fs/xattr.c |    4 ----
  1 file changed, 4 deletions(-)

diff --git a/fs/f2fs/xattr.c b/fs/f2fs/xattr.c
index 1ac8a5f..18b4080 100644
--- a/fs/f2fs/xattr.c
+++ b/fs/f2fs/xattr.c
@@ -478,7 +478,6 @@ int f2fs_setxattr(struct inode *inode, int 
name_index, const char *name,
  	void *base_addr;
  	int found, newsize;
  	size_t name_len;
-	int ilock;
  	__u32 new_hsize;
  	int error = -ENOMEM;

@@ -495,8 +494,6 @@ int f2fs_setxattr(struct inode *inode, int 
name_index, const char *name,

  	f2fs_balance_fs(sbi);

-	ilock = mutex_lock_op(sbi);
-
  	base_addr = read_all_xattrs(inode, ipage);
  	if (!base_addr)
  		goto exit;
@@ -578,7 +575,6 @@ int f2fs_setxattr(struct inode *inode, int 
name_index, const char *name,
  	else
  		update_inode_page(inode);
  exit:
-	mutex_unlock_op(sbi, ilock);
  	kzfree(base_addr);
  	return error;
  }
-- 
1.7.10.4

