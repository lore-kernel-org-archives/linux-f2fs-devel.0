From: Chao Yu <chao2.yu@samsung.com>
Subject: [f2fs-dev][PATCH 0/6 v2] f2fs: support inline dir
Date: Wed, 24 Sep 2014 18:14:15 +0800
Message-ID: <003b01cfd7e0$6ce35e40$46aa1ac0$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-language: zh-cn
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>, Changman Lee <cm224.lee@samsung.com>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

There are large space in f2fs inode, so last inline data patch set have made
f2fs to acquire the ability of storing data of small file (less than ~3.4k)
directly in inode block, but not support inline dir. In this patch, we make
f2fs to support inline dir.

Layout:
Inline dir layout is the same as inline data layout,
a. i_addr[0] are reserved space for converting from inline dir to regular one
when out-of-space occur in inline dentry.
b. i_addr[1..872] will be used as storing space of inline dentry.
c. i_addr[873..922] are reserved for inline xattr.

Size:
Since our max size of inline dir space is limit to MAX_INLINE_DATA (3488 bytes), 
we introduce inline dentry struct fit for available space, then our dentry slot
number in inline dentry reduce to 182, less than normal dentry block's 214.

Process:
In inline dir mode, our dir entries will be lookuped/stored/deleted in the
inline dentry space of inode, util there are no more space to store new added
dir entry, in this case we will convert inline dentry to normal 0-index dentry
block and disable inline dir mode for this inode.

Benefit points:
a) space saving
   1) Test with fsstress with special arguments, it can save about 7% space.
   time fsstress -c -p 20 -n 500 -l 10 -d /mnt/f2fs -w -f chown=0 -f creat=10
   -f dwrite=0 -f fdatasync=0 -f fsync=0 -f link=10 -f mkdir=10 -f mknod=10
   -f rename=0 -f rmdir=0 -f symlink=10 -f truncate=0 -f unlink=0 -f write=10 -S
		Dev		1K-blocks  Used    Available Use% Mounted on
   empty	/dev/sdb        20969472  1134600  19691512   6% /mnt/f2fs
   based	/dev/sdb        20969472  2331676  18494436  12% /mnt/f2fs
   patched	/dev/sdb        20969472  2247480  18578632  11% /mnt/f2fs
   2) Test with storing kernel src, it can save less than 1.4% space.
   empty	/dev/sdb        20969472  1134600  19691512   6% /mnt/f2fs
   based	/dev/sdb        20969472  1934656  18891456  10% /mnt/f2fs
   patched	/dev/sdb        20969472  1923400  18902712  10% /mnt/f2fs

b) performance
   Test with fsstress shows cost time reduce about 5%.
   time fsstress -d /mnt/f2fs -l 5 -n 1000 -p 20 -c -r
   based	135.652 s
   patched	129.256 s  (mount -o inline_dentry)

v2:
 o introduce f2fs_drop_nlink from f2fs_delete_entry to reuse code in
   f2fs_delete_inline_entry.
 o remove kmap/kunmap for inode page pointed out by Jaegeuk Kim.
 o introduce a new mount option inline_dentry for inline dir pointed out by
   Jaegeuk Kim.
 o rebase to last dev of f2fs (20140924).
 o retest performance/space-gain for inline dir excluding influence of inline
   data.

Chao Yu (6):
  f2fs: add infra struct and helper for inline dir
  f2fs: add a new mount option for inline dir
  f2fs: export dir operations for inline dir
  f2fs: add key function to handle inline dir
  f2fs: enable inline dir handling
  f2fs: update f2fs documentation for inline dir support

 Documentation/filesystems/f2fs.txt |   4 +
 fs/f2fs/dir.c                      | 103 +++++++----
 fs/f2fs/f2fs.h                     |  40 ++++-
 fs/f2fs/file.c                     |   2 +-
 fs/f2fs/inline.c                   | 347 +++++++++++++++++++++++++++++++++++++
 fs/f2fs/namei.c                    |  38 ++--
 fs/f2fs/recovery.c                 |   5 +-
 fs/f2fs/super.c                    |   7 +
 include/linux/f2fs_fs.h            |  19 ++
 9 files changed, 512 insertions(+), 53 deletions(-)

-- 
2.0.1.474.g72c7794
