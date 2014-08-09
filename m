From: Chao Yu <chao2.yu@samsung.com>
Subject: [PATCH 0/5] f2fs: support inline dir
Date: Sat, 09 Aug 2014 10:44:31 +0800
Message-ID: <00be01cfb37b$f3ba83f0$db2f8bd0$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chao2.yu@samsung.com>) id 1XFweu-0008Sr-3Q
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 09 Aug 2014 02:45:28 +0000
Received: from mailout3.samsung.com ([203.254.224.33])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-MD5:128)
	(Exim 4.76) id 1XFwes-00040R-6I
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 09 Aug 2014 02:45:28 +0000
Received: from epcpsbgm2.samsung.com (epcpsbgm2 [203.254.230.27])
	by mailout3.samsung.com
	(Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit
	(built Nov
	17 2011)) with ESMTP id <0NA000HJKQBGWN50@mailout3.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Sat, 09 Aug 2014 11:45:16 +0900 (KST)
Content-language: zh-cn
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Jaegeuk Kim <jaegeuk@kernel.org>, Changman Lee <cm224.lee@samsung.com>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

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
   1) Test with fsstress with special arguments, it can save about 3% space.
   time fsstress -c -p 20 -n 500 -l 10 -d /mnt/f2fs -w -f chown=0 -f creat=10
   -f dwrite=0 -f fdatasync=0 -f fsync=0 -f link=10 -f mkdir=10 -f mknod=10
   -f rename=0 -f rmdir=0 -f symlink=10 -f truncate=0 -f unlink=0 -f write=10 -S
   based	/dev/sdb        20969472  2234136  18591976  11% /mnt/f2fs
   patched	/dev/sdb        20969472  2303120  18522992  12% /mnt/f2fs
   2) Test with storing kernel src, it can save less than 1% space.

b) performance
   Test with fsstress shows cost time reduce 21%.
   time fsstress -d /mnt/f2fs -l 5 -n 1000 -p 20 -c -r
   based	168.503 s  (inline data)
   patched	132.840 s  (inline data + inline dir)

Chao Yu (5):
  f2fs: add infra macro and sturct for inline dir
  f2fs: export dir operations for inline dir
  f2fs: add key function to handle inline dir
  f2fs: enable inline dir handling
  f2fs: update f2fs documentation

 Documentation/filesystems/f2fs.txt |   5 +-
 fs/f2fs/dir.c                      |  48 +++--
 fs/f2fs/f2fs.h                     |  18 +-
 fs/f2fs/inline.c                   | 388 +++++++++++++++++++++++++++++++++++++
 fs/f2fs/namei.c                    |   8 +-
 fs/f2fs/recovery.c                 |   2 +-
 include/linux/f2fs_fs.h            |  18 ++
 7 files changed, 469 insertions(+), 18 deletions(-)

-- 
2.0.1.474.g72c7794



------------------------------------------------------------------------------
