From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH] f2fs-tools: build binaries in Mac
Date: Thu, 16 Nov 2017 10:28:15 +0800
Message-ID: <053fa280-c420-c55e-82b6-01e068f32b97@huawei.com>
References: <20171115041749.24105-1-jaegeuk@kernel.org>
 <f0d84ca7-6bac-9a71-52e7-cab2cfc0ce7a@huawei.com>
 <20171115162202.GA33528@jaegeuk-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.194]
 helo=mx.sourceforge.net)
 by sfs-ml-4.v29.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 (envelope-from <yuchao0@huawei.com>) id 1eF9uu-0004m6-Ml
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 16 Nov 2017 02:28:36 +0000
Received: from szxga04-in.huawei.com ([45.249.212.190])
 by sfi-mx-4.v28.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
 (Exim 4.89) id 1eF9up-0002BF-EH
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 16 Nov 2017 02:28:36 +0000
In-Reply-To: <20171115162202.GA33528@jaegeuk-macbookpro.roam.corp.google.com>
Content-Language: en-US
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net

On 2017/11/16 0:22, Jaegeuk Kim wrote:
> On 11/15, Chao Yu wrote:
>> Hi Jaegeuk,
>>
>> On 2017/11/15 12:17, Jaegeuk Kim wrote:
>>> This patch modifies f2fs-tools to be built in mac.
>>
>> Is there any requirement from Mac ecosystem?
> 
> It's for Android SDK. ;)

Alright... still can't catch up its purpose.

Thanks,

> 
>>
>> Thanks,
>>
>>>
>>> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
>>> ---
>>>  configure.ac             | 99 +++++++++++++++++++++++++++++++++++++++++-------
>>>  fsck/dump.c              |  6 +++
>>>  fsck/f2fs.h              |  5 ++-
>>>  fsck/fsck.c              |  4 +-
>>>  fsck/mount.c             | 10 +++++
>>>  fsck/quotaio_tree.h      |  4 ++
>>>  fsck/resize.c            |  5 ++-
>>>  fsck/sload.c             |  2 +
>>>  fsck/xattr.c             |  3 --
>>>  fsck/xattr.h             | 20 ++++++++++
>>>  include/android_config.h | 54 ++++++++++++++++++++++++++
>>>  include/f2fs_fs.h        | 39 +++++++++++++++----
>>>  lib/libf2fs.c            | 61 +++++++++++++++++++++++++----
>>>  lib/libf2fs_io.c         | 17 +++++++++
>>>  mkfs/f2fs_format.c       |  4 +-
>>>  mkfs/f2fs_format_utils.c | 10 +++--
>>>  tools/Makefile.am        |  6 ++-
>>>  tools/f2fscrypt.c        |  9 ++++-
>>>  tools/fibmap.c           | 65 ++++++++++++++++++++++++++++---
>>>  19 files changed, 371 insertions(+), 52 deletions(-)
>>>  create mode 100644 include/android_config.h
>>>
>>> diff --git a/configure.ac b/configure.ac
>>> index 451b2de..73c830d 100644
>>> --- a/configure.ac
>>> +++ b/configure.ac
>>> @@ -35,16 +35,6 @@ AC_CONFIG_MACRO_DIR([m4])
>>>  AC_CONFIG_AUX_DIR([build-aux])
>>>  AM_INIT_AUTOMAKE([foreign tar-pax dist-xz])
>>>  
>>> -AC_CHECK_HEADERS_ONCE([
>>> -	fcntl.h
>>> -	mntent.h
>>> -	stdlib.h
>>> -	string.h
>>> -	unistd.h
>>> -	sys/ioctl.h
>>> -	sys/mount.h
>>> -])
>>> -
>>>  # Test configure options.
>>>  AC_ARG_WITH([selinux],
>>>  	AS_HELP_STRING([--without-selinux],
>>> @@ -91,9 +81,30 @@ AS_IF([test "x$have_blkid" = "xyes"],
>>>  )
>>>  
>>>  # Checks for header files.
>>> -AC_CHECK_HEADERS([linux/fs.h linux/blkzoned.h fcntl.h mntent.h stdlib.h string.h \
>>> -		sys/ioctl.h sys/mount.h unistd.h linux/falloc.h byteswap.h \
>>> -		attr/xattr.h linux/xattr.h linux/posix_acl.h sys/acl.h])
>>> +AC_CHECK_HEADERS(m4_flatten([
>>> +	attr/xattr.h
>>> +	byteswap.h
>>> +	fcntl.h
>>> +	linux/blkzoned.h
>>> +	linux/falloc.h
>>> +	linux/fs.h
>>> +	linux/hdreg.h
>>> +	linux/limits.h
>>> +	linux/posix_acl.h
>>> +	linux/types.h
>>> +	linux/xattr.h
>>> +	mntent.h
>>> +	scsi/sg.h
>>> +	stdlib.h
>>> +	string.h
>>> +	sys/acl.h
>>> +	sys/ioctl.h
>>> +	sys/syscall.h
>>> +	sys/mount.h
>>> +	sys/sysmacros.h
>>> +	sys/xattr.h
>>> +	unistd.h
>>> +]))
>>>  
>>>  # Checks for typedefs, structures, and compiler characteristics.
>>>  AC_C_INLINE
>>> @@ -104,15 +115,75 @@ AC_TYPE_SIZE_T
>>>  # Checks for library functions.
>>>  AC_FUNC_GETMNTENT
>>>  AC_CHECK_FUNCS_ONCE([
>>> +	add_key
>>>  	fallocate
>>> +	fsetxattr
>>> +	fstat
>>> +	fstat64
>>>  	getmntent
>>> +	keyctl
>>> +	llseek
>>> +	lseek64
>>>  	memset
>>> -	fsetxattr
>>> +	setmntent
>>>  ])
>>>  
>>>  AS_IF([test "$ac_cv_header_byteswap_h" = "yes"],
>>>        [AC_CHECK_DECLS([bswap_64],,,[#include <byteswap.h>])])
>>>  
>>> +dnl
>>> +dnl Check to see if llseek() is declared in unistd.h.  On some libc's
>>> +dnl it is, and on others it isn't..... Thank you glibc developers....
>>> +dnl
>>> +AC_CHECK_DECL(llseek,[AC_DEFINE(HAVE_LLSEEK_PROTOTYPE, 1,
>>> +			[Define to 1 if llseek declared in unistd.h])],,
>>> +			[#include <unistd.h>])
>>> +dnl
>>> +dnl Check to see if lseek64() is declared in unistd.h.  Glibc's header files
>>> +dnl are so convoluted that I can't tell whether it will always be defined,
>>> +dnl and if it isn't defined while lseek64 is defined in the library,
>>> +dnl disaster will strike.
>>> +dnl
>>> +dnl Warning!  Use of --enable-gcc-wall may throw off this test.
>>> +dnl
>>> +dnl
>>> +AC_CHECK_DECL(lseek64,[AC_DEFINE(HAVE_LSEEK64_PROTOTYPE, 1,
>>> +		[Define to 1 if lseek64 declared in unistd.h])],,
>>> +		[#define _LARGEFILE_SOURCE
>>> +		#define _LARGEFILE64_SOURCE
>>> +		#include <unistd.h>])
>>> +dnl
>>> +dnl Word sizes...
>>> +dnl
>>> +
>>> +# AC_CANONICAL_HOST is needed to access the 'host_os' variable
>>> +AC_CANONICAL_HOST
>>> +
>>> +build_linux=no
>>> +build_windows=no
>>> +build_mac=no
>>> +
>>> +# Detect the target system
>>> +case "${host_os}" in
>>> +linux*)
>>> +	build_linux=yes
>>> +	;;
>>> +cygwin*|mingw*)
>>> +	build_windows=yes
>>> +	;;
>>> +darwin*)
>>> +	build_mac=yes
>>> +	;;
>>> +*)
>>> +	AC_MSG_ERROR(["OS $host_os is not supported"])
>>> +	;;
>>> +esac
>>> +
>>> +# Pass the conditionals to automake
>>> +AM_CONDITIONAL([LINUX], [test "$build_linux" = "yes"])
>>> +AM_CONDITIONAL([WINDOWS], [test "$build_windows" = "yes"])
>>> +AM_CONDITIONAL([OSX], [test "$build_mac" = "yes"])
>>> +
>>>  # Install directories
>>>  #AC_PREFIX_DEFAULT([/usr])
>>>  #AC_SUBST([sbindir], [/sbin])
>>> diff --git a/fsck/dump.c b/fsck/dump.c
>>> index ec69f25..9f0993e 100644
>>> --- a/fsck/dump.c
>>> +++ b/fsck/dump.c
>>> @@ -360,8 +360,14 @@ static void dump_xattr(struct f2fs_sb_info *sbi, struct f2fs_node *node_blk)
>>>  		}
>>>  
>>>  		DBG(1, "fd %d xattr_name %s\n", c.dump_fd, xattr_name);
>>> +#if defined(__linux__)
>>>  		ret = fsetxattr(c.dump_fd, xattr_name, value,
>>>  				le16_to_cpu(ent->e_value_size), 0);
>>> +#elif defined(__APPLE__)
>>> +		ret = fsetxattr(c.dump_fd, xattr_name, value,
>>> +				le16_to_cpu(ent->e_value_size), 0,
>>> +				XATTR_CREATE);
>>> +#endif
>>>  		if (ret)
>>>  			MSG(0, "XATTR index 0x%x set xattr failed error %d\n",
>>>  			    ent->e_name_index, errno);
>>> diff --git a/fsck/f2fs.h b/fsck/f2fs.h
>>> index 542594e..34b2481 100644
>>> --- a/fsck/f2fs.h
>>> +++ b/fsck/f2fs.h
>>> @@ -11,6 +11,7 @@
>>>  #ifndef _F2FS_H_
>>>  #define _F2FS_H_
>>>  
>>> +#include <f2fs_fs.h>
>>>  #include <stdlib.h>
>>>  #include <unistd.h>
>>>  #include <stdio.h>
>>> @@ -18,14 +19,14 @@
>>>  #include <fcntl.h>
>>>  #include <string.h>
>>>  #include <errno.h>
>>> +#ifdef HAVE_MNTENT_H
>>>  #include <mntent.h>
>>> +#endif
>>>  #include <sys/stat.h>
>>>  #include <sys/ioctl.h>
>>>  #include <sys/mount.h>
>>>  #include <assert.h>
>>>  
>>> -#include <f2fs_fs.h>
>>> -
>>>  #define EXIT_ERR_CODE		(-1)
>>>  #define ver_after(a, b) (typecheck(unsigned long long, a) &&            \
>>>  		typecheck(unsigned long long, b) &&                     \
>>> diff --git a/fsck/fsck.c b/fsck/fsck.c
>>> index ef46e33..ec88712 100644
>>> --- a/fsck/fsck.c
>>> +++ b/fsck/fsck.c
>>> @@ -881,14 +881,14 @@ skip_blkcnt_fix:
>>>  	}
>>>  	if (ftype == F2FS_FT_SYMLINK && i_blocks && i_size == 0) {
>>>  		DBG(1, "ino: 0x%x i_blocks: %lu with zero i_size",
>>> -							nid, i_blocks);
>>> +						nid, (unsigned long)i_blocks);
>>>  		if (c.fix_on) {
>>>  			u64 i_size = i_blocks * F2FS_BLKSIZE;
>>>  
>>>  			node_blk->i.i_size = cpu_to_le64(i_size);
>>>  			need_fix = 1;
>>>  			FIX_MSG("Symlink: recover 0x%x with i_size=%lu",
>>> -							nid, i_size);
>>> +						nid, (unsigned long)i_size);
>>>  		}
>>>  	}
>>>  
>>> diff --git a/fsck/mount.c b/fsck/mount.c
>>> index 826a2f9..653dcf3 100644
>>> --- a/fsck/mount.c
>>> +++ b/fsck/mount.c
>>> @@ -18,6 +18,16 @@
>>>  #include <sys/acl.h>
>>>  #endif
>>>  
>>> +#ifndef ACL_UNDEFINED_TAG
>>> +#define ACL_UNDEFINED_TAG	(0x00)
>>> +#define ACL_USER_OBJ		(0x01)
>>> +#define ACL_USER		(0x02)
>>> +#define ACL_GROUP_OBJ		(0x04)
>>> +#define ACL_GROUP		(0x08)
>>> +#define ACL_MASK		(0x10)
>>> +#define ACL_OTHER		(0x20)
>>> +#endif
>>> +
>>>  u32 get_free_segments(struct f2fs_sb_info *sbi)
>>>  {
>>>  	u32 i, free_segs = 0;
>>> diff --git a/fsck/quotaio_tree.h b/fsck/quotaio_tree.h
>>> index 4ca2d7f..aed93a8 100644
>>> --- a/fsck/quotaio_tree.h
>>> +++ b/fsck/quotaio_tree.h
>>> @@ -6,9 +6,13 @@
>>>  #define _LINUX_QUOTA_TREE_H
>>>  
>>>  #include <inttypes.h>
>>> +#ifdef HAVE_LINUX_TYPES_H
>>>  #include <linux/types.h>
>>> +#endif
>>>  #include <sys/types.h>
>>>  
>>> +#include <f2fs_fs.h>
>>> +
>>>  typedef __u32 qid_t;        /* Type in which we store ids in memory */
>>>  
>>>  #define QT_TREEOFF	1	/* Offset of tree in file in blocks */
>>> diff --git a/fsck/resize.c b/fsck/resize.c
>>> index 4584d6f..6c3eeab 100644
>>> --- a/fsck/resize.c
>>> +++ b/fsck/resize.c
>>> @@ -36,7 +36,7 @@ static int get_new_sb(struct f2fs_super_block *sb)
>>>  				zone_align_start_offset) / segment_size_bytes /
>>>  				c.segs_per_sec * c.segs_per_sec);
>>>  
>>> -	blocks_for_sit = ALIGN(get_sb(segment_count), SIT_ENTRY_PER_BLOCK);
>>> +	blocks_for_sit = SIZE_ALIGN(get_sb(segment_count), SIT_ENTRY_PER_BLOCK);
>>>  	sit_segments = SEG_ALIGN(blocks_for_sit);
>>>  	set_sb(segment_count_sit, sit_segments * 2);
>>>  	set_sb(nat_blkaddr, get_sb(sit_blkaddr) +
>>> @@ -45,7 +45,8 @@ static int get_new_sb(struct f2fs_super_block *sb)
>>>  	total_valid_blks_available = (get_sb(segment_count) -
>>>  			(get_sb(segment_count_ckpt) +
>>>  			get_sb(segment_count_sit))) * blks_per_seg;
>>> -	blocks_for_nat = ALIGN(total_valid_blks_available, NAT_ENTRY_PER_BLOCK);
>>> +	blocks_for_nat = SIZE_ALIGN(total_valid_blks_available,
>>> +					NAT_ENTRY_PER_BLOCK);
>>>  	set_sb(segment_count_nat, SEG_ALIGN(blocks_for_nat));
>>>  
>>>  	sit_bitmap_size = ((get_sb(segment_count_sit) / 2) <<
>>> diff --git a/fsck/sload.c b/fsck/sload.c
>>> index 68799c1..bfc79f2 100644
>>> --- a/fsck/sload.c
>>> +++ b/fsck/sload.c
>>> @@ -15,7 +15,9 @@
>>>  #include "fsck.h"
>>>  #include <libgen.h>
>>>  #include <dirent.h>
>>> +#ifdef HAVE_MNTENT_H
>>>  #include <mntent.h>
>>> +#endif
>>>  
>>>  #ifdef HAVE_LIBSELINUX
>>>  #include <selinux/selinux.h>
>>> diff --git a/fsck/xattr.c b/fsck/xattr.c
>>> index 1d0f7d3..f2576cd 100644
>>> --- a/fsck/xattr.c
>>> +++ b/fsck/xattr.c
>>> @@ -17,9 +17,6 @@
>>>  #include "node.h"
>>>  #include "xattr.h"
>>>  
>>> -#define XATTR_CREATE 0x1
>>> -#define XATTR_REPLACE 0x2
>>> -
>>>  void *read_all_xattrs(struct f2fs_sb_info *sbi, struct f2fs_node *inode)
>>>  {
>>>  	struct f2fs_xattr_header *header;
>>> diff --git a/fsck/xattr.h b/fsck/xattr.h
>>> index beed3bb..e4a98e2 100644
>>> --- a/fsck/xattr.h
>>> +++ b/fsck/xattr.h
>>> @@ -17,6 +17,9 @@
>>>  #define _XATTR_H_
>>>  
>>>  #include "f2fs.h"
>>> +#ifdef HAVE_SYS_XATTR_H
>>> +#include <sys/xattr.h>
>>> +#endif
>>>  
>>>  struct f2fs_xattr_header {
>>>  	__le32 h_magic;		/* magic number for identification */
>>> @@ -76,6 +79,23 @@ static inline int f2fs_acl_count(int size)
>>>  	}
>>>  }
>>>  
>>> +#ifndef XATTR_USER_PREFIX
>>> +#define XATTR_USER_PREFIX	"user."
>>> +#endif
>>> +#ifndef XATTR_SECURITY_PREFIX
>>> +#define XATTR_SECURITY_PREFIX	"security."
>>> +#endif
>>> +#ifndef XATTR_TRUSTED_PREFIX
>>> +#define XATTR_TRUSTED_PREFIX	"trusted."
>>> +#endif
>>> +
>>> +#ifndef XATTR_CREATE
>>> +#define XATTR_CREATE 0x1
>>> +#endif
>>> +#ifndef XATTR_REPLACE
>>> +#define XATTR_REPLACE 0x2
>>> +#endif
>>> +
>>>  #define XATTR_ROUND	(3)
>>>  
>>>  #define XATTR_SELINUX_SUFFIX "selinux"
>>> diff --git a/include/android_config.h b/include/android_config.h
>>> new file mode 100644
>>> index 0000000..bfc4105
>>> --- /dev/null
>>> +++ b/include/android_config.h
>>> @@ -0,0 +1,54 @@
>>> +#if defined(__linux__)
>>> +#define HAVE_BYTESWAP_H 1
>>> +#define HAVE_FCNTL_H 1
>>> +#define HAVE_FALLOC_H 1
>>> +#define HAVE_LINUX_HDREG_H 1
>>> +#define HAVE_LINUX_LIMITS_H 1
>>> +#define HAVE_POSIX_ACL_H 1
>>> +#define HAVE_LINUX_TYPES_H 1
>>> +#define HAVE_LINUX_XATTR_H 1
>>> +#define HAVE_MNTENT_H 1
>>> +#define HAVE_STDLIB_H 1
>>> +#define HAVE_STRING_H 1
>>> +#define HAVE_SYS_IOCTL_H 1
>>> +#define HAVE_SYS_SYSCALL_H 1
>>> +#define HAVE_SYS_MOUNT_H 1
>>> +#define HAVE_SYS_SYSMACROS_H 1
>>> +#define HAVE_SYS_XATTR_H 1
>>> +#define HAVE_UNISTD_H 1
>>> +
>>> +#define HAVE_ADD_KEY 1
>>> +#define HAVE_FALLOCATE 1
>>> +#define HAVE_FSETXATTR 1
>>> +#define HAVE_FSTAT 1
>>> +#define HAVE_FSTAT64 1
>>> +#define HAVE_GETMNTENT 1
>>> +#define HAVE_KEYCTL 1
>>> +#define HAVE_LLSEEK 1
>>> +#define HAVE_LSEEK64 1
>>> +#define HAVE_MEMSET 1
>>> +#define HAVE_SETMNTENT 1
>>> +#endif
>>> +
>>> +#if defined(__APPLE__)
>>> +#define HAVE_FCNTL_H 1
>>> +#define HAVE_FALLOC_H 1
>>> +#define HAVE_POSIX_ACL_H 1
>>> +#define HAVE_STDLIB_H 1
>>> +#define HAVE_STRING_H 1
>>> +#define HAVE_SYS_IOCTL_H 1
>>> +#define HAVE_SYS_SYSCALL_H 1
>>> +#define HAVE_SYS_MOUNT_H 1
>>> +#define HAVE_SYS_XATTR_H 1
>>> +#define HAVE_UNISTD_H 1
>>> +
>>> +#define HAVE_ADD_KEY 1
>>> +#define HAVE_FALLOCATE 1
>>> +#define HAVE_FSETXATTR 1
>>> +#define HAVE_FSTAT 1
>>> +#define HAVE_FSTAT64 1
>>> +#define HAVE_GETMNTENT 1
>>> +#define HAVE_KEYCTL 1
>>> +#define HAVE_LLSEEK 1
>>> +#define HAVE_MEMSET 1
>>> +#endif
>>> diff --git a/include/f2fs_fs.h b/include/f2fs_fs.h
>>> index 8d67a76..05b893a 100644
>>> --- a/include/f2fs_fs.h
>>> +++ b/include/f2fs_fs.h
>>> @@ -12,14 +12,20 @@
>>>  #ifndef __F2FS_FS_H__
>>>  #define __F2FS_FS_H__
>>>  
>>> -#include <inttypes.h>
>>> -#include <linux/types.h>
>>> -#include <sys/types.h>
>>> -
>>>  #ifdef HAVE_CONFIG_H
>>>  #include <config.h>
>>>  #endif
>>>  
>>> +#ifdef WITH_ANDROID
>>> +#include <android_config.h>
>>> +#endif
>>> +
>>> +#include <inttypes.h>
>>> +#ifdef HAVE_LINUX_TYPES_H
>>> +#include <linux/types.h>
>>> +#endif
>>> +#include <sys/types.h>
>>> +
>>>  #ifdef HAVE_LINUX_BLKZONED_H
>>>  #include <linux/blkzoned.h>
>>>  #endif
>>> @@ -39,10 +45,25 @@ typedef u_int16_t	u16;
>>>  typedef u_int8_t	u8;
>>>  typedef u32		block_t;
>>>  typedef u32		nid_t;
>>> +#ifndef bool
>>>  typedef u8		bool;
>>> +#endif
>>>  typedef unsigned long	pgoff_t;
>>>  typedef unsigned short	umode_t;
>>>  
>>> +#ifndef HAVE_LINUX_TYPES_H
>>> +typedef u8	__u8;
>>> +typedef u16	__u16;
>>> +typedef u32	__u32;
>>> +typedef u64	__u64;
>>> +typedef u16	__le16;
>>> +typedef u32	__le32;
>>> +typedef u64	__le64;
>>> +typedef u16	__be16;
>>> +typedef u32	__be32;
>>> +typedef u64	__be64;
>>> +#endif
>>> +
>>>  #if HAVE_BYTESWAP_H
>>>  #include <byteswap.h>
>>>  #else
>>> @@ -226,7 +247,9 @@ static inline uint64_t bswap_64(uint64_t val)
>>>  		snprintf(buf, len, #member)
>>>  
>>>  /* these are defined in kernel */
>>> +#ifndef PAGE_SIZE
>>>  #define PAGE_SIZE		4096
>>> +#endif
>>>  #define PAGE_CACHE_SIZE		4096
>>>  #define BITS_PER_BYTE		8
>>>  #define F2FS_SUPER_MAGIC	0xF2F52010	/* F2FS Magic Number */
>>> @@ -784,7 +807,7 @@ struct f2fs_nat_block {
>>>   * disk is 16 TB and it equals to 16 * 1024 * 1024 / 2 segments.
>>>   */
>>>  #define F2FS_MAX_SEGMENT       ((16 * 1024 * 1024) / 2)
>>> -#define MAX_SIT_BITMAP_SIZE    (SEG_ALIGN(ALIGN(F2FS_MAX_SEGMENT, \
>>> +#define MAX_SIT_BITMAP_SIZE    (SEG_ALIGN(SIZE_ALIGN(F2FS_MAX_SEGMENT, \
>>>  						SIT_ENTRY_PER_BLOCK)) * \
>>>  						c.blks_per_seg / 8)
>>>  
>>> @@ -1146,9 +1169,9 @@ extern int f2fs_reset_zones(int);
>>>  
>>>  extern struct f2fs_configuration c;
>>>  
>>> -#define ALIGN(val, size)	((val) + (size) - 1) / (size)
>>> -#define SEG_ALIGN(blks)		ALIGN(blks, c.blks_per_seg)
>>> -#define ZONE_ALIGN(blks)	ALIGN(blks, c.blks_per_seg * \
>>> +#define SIZE_ALIGN(val, size)	((val) + (size) - 1) / (size)
>>> +#define SEG_ALIGN(blks)		SIZE_ALIGN(blks, c.blks_per_seg)
>>> +#define ZONE_ALIGN(blks)	SIZE_ALIGN(blks, c.blks_per_seg * \
>>>  					c.segs_per_zone)
>>>  
>>>  static inline double get_best_overprovision(struct f2fs_super_block *sb)
>>> diff --git a/lib/libf2fs.c b/lib/libf2fs.c
>>> index 0f1fead..1e63843 100644
>>> --- a/lib/libf2fs.c
>>> +++ b/lib/libf2fs.c
>>> @@ -8,25 +8,34 @@
>>>   */
>>>  #define _LARGEFILE64_SOURCE
>>>  
>>> +#include <f2fs_fs.h>
>>>  #include <stdio.h>
>>>  #include <stdlib.h>
>>>  #include <string.h>
>>>  #include <errno.h>
>>>  #include <unistd.h>
>>>  #include <fcntl.h>
>>> +#ifdef HAVE_MNTENT_H
>>>  #include <mntent.h>
>>> +#endif
>>>  #include <time.h>
>>>  #include <sys/stat.h>
>>>  #include <sys/mount.h>
>>>  #include <sys/ioctl.h>
>>> +#ifdef HAVE_SYS_SYSMACROS_H
>>>  #include <sys/sysmacros.h>
>>> +#endif
>>>  #ifndef WITH_ANDROID
>>> +#ifdef HAVE_SCSI_SG_H
>>>  #include <scsi/sg.h>
>>>  #endif
>>> +#endif
>>> +#ifdef HAVE_LINUX_HDREG_H
>>>  #include <linux/hdreg.h>
>>> +#endif
>>> +#ifdef HAVE_LINUX_LIMITS_H
>>>  #include <linux/limits.h>
>>> -
>>> -#include <f2fs_fs.h>
>>> +#endif
>>>  
>>>  #ifndef WITH_ANDROID
>>>  /* SCSI command for standard inquiry*/
>>> @@ -607,6 +616,7 @@ void f2fs_init_configuration(void)
>>>  	c.dry_run = 0;
>>>  }
>>>  
>>> +#ifdef HAVE_SETMNTENT
>>>  static int is_mounted(const char *mpt, const char *device)
>>>  {
>>>  	FILE *file = NULL;
>>> @@ -628,6 +638,7 @@ static int is_mounted(const char *mpt, const char *device)
>>>  	endmntent(file);
>>>  	return mnt ? 1 : 0;
>>>  }
>>> +#endif
>>>  
>>>  int f2fs_dev_is_umounted(char *path)
>>>  {
>>> @@ -642,29 +653,36 @@ int f2fs_dev_is_umounted(char *path)
>>>  	 * try with /proc/mounts fist to detect RDONLY.
>>>  	 * f2fs_stop_checkpoint makes RO in /proc/mounts while RW in /etc/mtab.
>>>  	 */
>>> +#ifdef __linux__
>>>  	ret = is_mounted("/proc/mounts", path);
>>>  	if (ret) {
>>>  		MSG(0, "Info: Mounted device!\n");
>>>  		return -1;
>>>  	}
>>> -
>>> +#endif
>>> +#if defined(MOUNTED) || defined(_PATH_MOUNTED)
>>> +#ifndef MOUNTED
>>> +#define MOUNTED _PATH_MOUNTED
>>> +#endif
>>>  	ret = is_mounted(MOUNTED, path);
>>>  	if (ret) {
>>>  		MSG(0, "Info: Mounted device!\n");
>>>  		return -1;
>>>  	}
>>> -
>>> +#endif
>>>  	/*
>>>  	 * If we are supposed to operate on the root device, then
>>>  	 * also check the mounts for '/dev/root', which sometimes
>>>  	 * functions as an alias for the root device.
>>>  	 */
>>>  	if (is_rootdev) {
>>> +#ifdef __linux__
>>>  		ret = is_mounted("/proc/mounts", "/dev/root");
>>>  		if (ret) {
>>>  			MSG(0, "Info: Mounted device!\n");
>>>  			return -1;
>>>  		}
>>> +#endif
>>>  	}
>>>  
>>>  	/*
>>> @@ -681,7 +699,7 @@ int f2fs_dev_is_umounted(char *path)
>>>  			return -1;
>>>  		}
>>>  	}
>>> -	return 0;
>>> +	return ret;
>>>  }
>>>  
>>>  int f2fs_devs_are_umounted(void)
>>> @@ -704,6 +722,25 @@ void get_kernel_version(__u8 *version)
>>>  	memset(version + i, 0, VERSION_LEN + 1 - i);
>>>  }
>>>  
>>> +
>>> +#if defined(__linux__) && defined(_IO) && !defined(BLKGETSIZE)
>>> +#define BLKGETSIZE	_IO(0x12,96)
>>> +#endif
>>> +
>>> +#if defined(__linux__) && defined(_IOR) && !defined(BLKGETSIZE64)
>>> +#define BLKGETSIZE64	_IOR(0x12,114, size_t)
>>> +#endif
>>> +
>>> +#if defined(__linux__) && defined(_IO) && !defined(BLKSSZGET)
>>> +#define BLKSSZGET	_IO(0x12,104)
>>> +#endif
>>> +
>>> +#if defined(__APPLE__)
>>> +#include <sys/disk.h>
>>> +#define BLKGETSIZE	DKIOCGETBLOCKCOUNT
>>> +#define BLKSSZGET	DKIOCGETBLOCKCOUNT
>>> +#endif /* APPLE_DARWIN */
>>> +
>>>  int get_device_info(int i)
>>>  {
>>>  	int32_t fd = 0;
>>> @@ -712,8 +749,10 @@ int get_device_info(int i)
>>>  	uint32_t total_sectors;
>>>  #endif
>>>  	struct stat stat_buf;
>>> +#ifdef HDIO_GETGIO
>>>  	struct hd_geometry geom;
>>> -#ifndef WITH_ANDROID
>>> +#endif
>>> +#if !defined(WITH_ANDROID) && defined(__linux__)
>>>  	sg_io_hdr_t io_hdr;
>>>  	unsigned char reply_buffer[96] = {0};
>>>  	unsigned char model_inq[6] = {MODELINQUIRY};
>>> @@ -750,10 +789,12 @@ int get_device_info(int i)
>>>  	} else if (S_ISREG(stat_buf.st_mode)) {
>>>  		dev->total_sectors = stat_buf.st_size / dev->sector_size;
>>>  	} else if (S_ISBLK(stat_buf.st_mode)) {
>>> +#ifdef BLKSSZGET
>>>  		if (ioctl(fd, BLKSSZGET, &sector_size) < 0)
>>>  			MSG(0, "\tError: Using the default sector size\n");
>>>  		else if (dev->sector_size < sector_size)
>>>  			dev->sector_size = sector_size;
>>> +#endif
>>>  #ifdef BLKGETSIZE64
>>>  		if (ioctl(fd, BLKGETSIZE64, &dev->total_sectors) < 0) {
>>>  			MSG(0, "\tError: Cannot get the device size\n");
>>> @@ -769,13 +810,17 @@ int get_device_info(int i)
>>>  		dev->total_sectors /= dev->sector_size;
>>>  
>>>  		if (i == 0) {
>>> +#ifdef HDIO_GETGIO
>>>  			if (ioctl(fd, HDIO_GETGEO, &geom) < 0)
>>>  				c.start_sector = 0;
>>>  			else
>>>  				c.start_sector = geom.start;
>>> +#else
>>> +			c.start_sector = 0;
>>> +#endif
>>>  		}
>>>  
>>> -#ifndef WITH_ANDROID
>>> +#if !defined(WITH_ANDROID) && defined(__linux__)
>>>  		/* Send INQUIRY command */
>>>  		memset(&io_hdr, 0, sizeof(sg_io_hdr_t));
>>>  		io_hdr.interface_id = 'S';
>>> @@ -809,7 +854,7 @@ int get_device_info(int i)
>>>  		return -1;
>>>  	}
>>>  
>>> -#ifndef WITH_ANDROID
>>> +#if !defined(WITH_ANDROID) && defined(__linux__)
>>>  	if (S_ISBLK(stat_buf.st_mode))
>>>  		f2fs_get_zoned_model(i);
>>>  
>>> diff --git a/lib/libf2fs_io.c b/lib/libf2fs_io.c
>>> index 8a79672..268dcfa 100644
>>> --- a/lib/libf2fs_io.c
>>> +++ b/lib/libf2fs_io.c
>>> @@ -14,12 +14,16 @@
>>>  #include <errno.h>
>>>  #include <unistd.h>
>>>  #include <fcntl.h>
>>> +#ifdef HAVE_MNTENT_H
>>>  #include <mntent.h>
>>> +#endif
>>>  #include <time.h>
>>>  #include <sys/stat.h>
>>>  #include <sys/mount.h>
>>>  #include <sys/ioctl.h>
>>> +#ifdef HAVE_LINUX_HDREG_H
>>>  #include <linux/hdreg.h>
>>> +#endif
>>>  
>>>  #include <f2fs_fs.h>
>>>  
>>> @@ -54,6 +58,15 @@ static int __get_device_fd(__u64 *offset)
>>>  	return -1;
>>>  }
>>>  
>>> +#ifndef HAVE_LSEEK64
>>> +typedef off_t	off64_t;
>>> +
>>> +static inline off64_t lseek64(int fd, __u64 offset, int set)
>>> +{
>>> +	return lseek(fd, offset, set);
>>> +}
>>> +#endif
>>> +
>>>  /*
>>>   * IO interfaces
>>>   */
>>> @@ -86,7 +99,11 @@ int dev_read(void *buf, __u64 offset, size_t len)
>>>  	return 0;
>>>  }
>>>  
>>> +#ifdef POSIX_FADV_WILLNEED
>>>  int dev_readahead(__u64 offset, size_t len)
>>> +#else
>>> +int dev_readahead(__u64 offset, size_t UNUSED(len))
>>> +#endif
>>>  {
>>>  	int fd = __get_device_fd(&offset);
>>>  
>>> diff --git a/mkfs/f2fs_format.c b/mkfs/f2fs_format.c
>>> index 2ba8dd3..d5f39ca 100644
>>> --- a/mkfs/f2fs_format.c
>>> +++ b/mkfs/f2fs_format.c
>>> @@ -254,7 +254,7 @@ static int f2fs_prepare_super_block(void)
>>>  	set_sb(sit_blkaddr, get_sb(segment0_blkaddr) +
>>>  			get_sb(segment_count_ckpt) * c.blks_per_seg);
>>>  
>>> -	blocks_for_sit = ALIGN(get_sb(segment_count), SIT_ENTRY_PER_BLOCK);
>>> +	blocks_for_sit = SIZE_ALIGN(get_sb(segment_count), SIT_ENTRY_PER_BLOCK);
>>>  
>>>  	sit_segments = SEG_ALIGN(blocks_for_sit);
>>>  
>>> @@ -267,7 +267,7 @@ static int f2fs_prepare_super_block(void)
>>>  			(get_sb(segment_count_ckpt) +
>>>  			get_sb(segment_count_sit))) * c.blks_per_seg;
>>>  
>>> -	blocks_for_nat = ALIGN(total_valid_blks_available,
>>> +	blocks_for_nat = SIZE_ALIGN(total_valid_blks_available,
>>>  			NAT_ENTRY_PER_BLOCK);
>>>  
>>>  	set_sb(segment_count_nat, SEG_ALIGN(blocks_for_nat));
>>> diff --git a/mkfs/f2fs_format_utils.c b/mkfs/f2fs_format_utils.c
>>> index 558684d..a474764 100644
>>> --- a/mkfs/f2fs_format_utils.c
>>> +++ b/mkfs/f2fs_format_utils.c
>>> @@ -6,20 +6,24 @@
>>>   *
>>>   * Dual licensed under the GPL or LGPL version 2 licenses.
>>>   */
>>> +#ifndef _LARGEFILE_SOURCE
>>>  #define _LARGEFILE_SOURCE
>>> +#endif
>>> +#ifndef _LARGEFILE64_SOURCE
>>>  #define _LARGEFILE64_SOURCE
>>> +#endif
>>>  #ifndef _GNU_SOURCE
>>>  #define _GNU_SOURCE
>>>  #endif
>>>  
>>> +#include <f2fs_fs.h>
>>> +
>>>  #include <stdio.h>
>>>  #include <unistd.h>
>>>  #include <sys/ioctl.h>
>>>  #include <sys/stat.h>
>>>  #include <fcntl.h>
>>>  
>>> -#include "f2fs_fs.h"
>>> -
>>>  #ifdef HAVE_LINUX_FS_H
>>>  #include <linux/fs.h>
>>>  #endif
>>> @@ -68,7 +72,7 @@ static int trim_device(int i)
>>>  			MSG(0, "Info: This device doesn't support BLKSECDISCARD\n");
>>>  		} else {
>>>  			MSG(0, "Info: Secure Discarded %lu MB\n",
>>> -						stat_buf.st_size >> 20);
>>> +					(unsigned long)stat_buf.st_size >> 20);
>>>  			return 0;
>>>  		}
>>>  #endif
>>> diff --git a/tools/Makefile.am b/tools/Makefile.am
>>> index 5a9303f..81cf89b 100644
>>> --- a/tools/Makefile.am
>>> +++ b/tools/Makefile.am
>>> @@ -2,10 +2,14 @@
>>>  
>>>  AM_CPPFLAGS = ${libuuid_CFLAGS} -I$(top_srcdir)/include
>>>  AM_CFLAGS = -Wall
>>> -sbin_PROGRAMS = f2fstat fibmap.f2fs parse.f2fs f2fscrypt
>>> +sbin_PROGRAMS = f2fstat fibmap.f2fs parse.f2fs
>>>  f2fstat_SOURCES = f2fstat.c
>>>  fibmap_f2fs_SOURCES = fibmap.c
>>>  parse_f2fs_SOURCES = f2fs_io_parse.c
>>> +
>>> +if LINUX
>>> +sbin_PROGRAMS += f2fscrypt
>>>  f2fscrypt_SOURCES = f2fscrypt.c sha512.c
>>>  f2fscrypt_LDFLAGS = -luuid
>>>  dist_man_MANS = f2fscrypt.8
>>> +endif
>>> diff --git a/tools/f2fscrypt.c b/tools/f2fscrypt.c
>>> index 48ea5f6..81ef830 100644
>>> --- a/tools/f2fscrypt.c
>>> +++ b/tools/f2fscrypt.c
>>> @@ -30,7 +30,9 @@
>>>  #include <stdio.h>
>>>  #include <stdlib.h>
>>>  #include <string.h>
>>> +#ifdef HAVE_MNTENT_H
>>>  #include <mntent.h>
>>> +#endif
>>>  #include <sys/ioctl.h>
>>>  #include <sys/stat.h>
>>>  #include <sys/types.h>
>>> @@ -38,7 +40,9 @@
>>>  #include <termios.h>
>>>  #include <unistd.h>
>>>  #include <signal.h>
>>> +#ifdef __KERNEL__
>>>  #include <linux/fs.h>
>>> +#endif
>>>  #include <uuid/uuid.h>
>>>  
>>>  #if !defined(HAVE_ADD_KEY) || !defined(HAVE_KEYCTL)
>>> @@ -47,6 +51,7 @@
>>>  #ifdef HAVE_SYS_KEY_H
>>>  #include <sys/key.h>
>>>  #endif
>>> +#include <f2fs_fs.h>
>>>  
>>>  #define F2FS_MAX_KEY_SIZE		64
>>>  #define F2FS_MAX_PASSPHRASE_SIZE	1024
>>> @@ -121,7 +126,7 @@ int options;
>>>  extern void f2fs_sha512(const unsigned char *in, unsigned long in_size,
>>>  						unsigned char *out);
>>>  
>>> -#ifndef HAVE_KEYCTL
>>> +#if !defined(HAVE_KEYCTL)
>>>  static long keyctl(int cmd, ...)
>>>  {
>>>  	va_list va;
>>> @@ -137,7 +142,7 @@ static long keyctl(int cmd, ...)
>>>  }
>>>  #endif
>>>  
>>> -#ifndef HAVE_ADD_KEY
>>> +#if !defined(HAVE_ADD_KEY)
>>>  static key_serial_t add_key(const char *type, const char *description,
>>>  			    const void *payload, size_t plen,
>>>  			    key_serial_t keyring)
>>> diff --git a/tools/fibmap.c b/tools/fibmap.c
>>> index 6b092f5..d17144a 100644
>>> --- a/tools/fibmap.c
>>> +++ b/tools/fibmap.c
>>> @@ -1,4 +1,20 @@
>>> +#if !defined(__FreeBSD__) && !defined(__NetBSD__) && !defined(__OpenBSD__)
>>> +#define _XOPEN_SOURCE 600
>>> +#define _DARWIN_C_SOURCE
>>> +#define _FILE_OFFSET_BITS 64
>>> +#ifndef _LARGEFILE_SOURCE
>>> +#define _LARGEFILE_SOURCE
>>> +#endif
>>> +#ifndef _LARGEFILE64_SOURCE
>>>  #define _LARGEFILE64_SOURCE
>>> +#endif
>>> +#ifndef _GNU_SOURCE
>>> +#define _GNU_SOURCE
>>> +#endif
>>> +#endif
>>> +#ifndef O_LARGEFILE
>>> +#define O_LARGEFILE 0
>>> +#endif
>>>  #include <unistd.h>
>>>  #include <string.h>
>>>  #include <stdlib.h>
>>> @@ -8,12 +24,25 @@
>>>  #include <sys/types.h>
>>>  #include <sys/ioctl.h>
>>>  #include <sys/stat.h>
>>> +#ifdef HAVE_SYS_SYSMACROS_H
>>>  #include <sys/sysmacros.h>
>>> +#endif
>>>  #include <libgen.h>
>>> +#ifdef HAVE_LINUX_HDREG_H
>>>  #include <linux/hdreg.h>
>>> +#endif
>>> +#ifdef HAVE_LINUX_TYPES_H
>>>  #include <linux/types.h>
>>> +#endif
>>> +#ifdef __KERNEL__
>>>  #include <linux/fs.h>
>>> +#endif
>>>  #include <inttypes.h>
>>> +#include <f2fs_fs.h>
>>> +
>>> +#ifndef FIBMAP
>>> +#define FIBMAP          _IO(0x00, 1)    /* bmap access */
>>> +#endif
>>>  
>>>  struct file_ext {
>>>  	__u32 f_pos;
>>> @@ -31,28 +60,42 @@ void print_ext(struct file_ext *ext)
>>>  					ext->end_blk, ext->blk_count);
>>>  }
>>>  
>>> +#if defined(HAVE_FSTAT64) && !defined(__OSX_AVAILABLE_BUT_DEPRECATED)
>>>  void print_stat(struct stat64 *st)
>>> +#else
>>> +void print_stat(struct stat *st)
>>> +#endif
>>>  {
>>>  	printf("--------------------------------------------\n");
>>>  	printf("dev       [%d:%d]\n", major(st->st_dev), minor(st->st_dev));
>>>  	printf("ino       [0x%8"PRIx64" : %"PRIu64"]\n",
>>>  						st->st_ino, st->st_ino);
>>>  	printf("mode      [0x%8x : %d]\n", st->st_mode, st->st_mode);
>>> -	printf("nlink     [0x%8lx : %ld]\n", st->st_nlink, st->st_nlink);
>>> +	printf("nlink     [0x%8lx : %ld]\n",
>>> +					(unsigned long)st->st_nlink,
>>> +					(long)st->st_nlink);
>>>  	printf("uid       [0x%8x : %d]\n", st->st_uid, st->st_uid);
>>>  	printf("gid       [0x%8x : %d]\n", st->st_gid, st->st_gid);
>>>  	printf("size      [0x%8"PRIx64" : %"PRIu64"]\n",
>>> -						st->st_size, st->st_size);
>>> -	printf("blksize   [0x%8lx : %ld]\n", st->st_blksize, st->st_blksize);
>>> +					(u64)st->st_size, (u64)st->st_size);
>>> +	printf("blksize   [0x%8lx : %ld]\n",
>>> +					(unsigned long)st->st_blksize,
>>> +					(long)st->st_blksize);
>>>  	printf("blocks    [0x%8"PRIx64" : %"PRIu64"]\n",
>>> -					st->st_blocks, st->st_blocks);
>>> +					(u64)st->st_blocks, (u64)st->st_blocks);
>>>  	printf("--------------------------------------------\n\n");
>>>  }
>>>  
>>> -void stat_bdev(struct stat64 *st, unsigned int *start_lba)
>>> +#if defined(HAVE_FSTAT64) && !defined(__OSX_AVAILABLE_BUT_DEPRECATED)
>>> +static void stat_bdev(struct stat64 *st, unsigned int *start_lba)
>>> +#else
>>> +static void stat_bdev(struct stat *st, unsigned int *start_lba)
>>> +#endif
>>>  {
>>>  	struct stat bdev_stat;
>>> +#ifdef HDIO_GETGIO
>>>  	struct hd_geometry geom;
>>> +#endif
>>>  	char devname[32] = { 0, };
>>>  	char linkname[32] = { 0, };
>>>  	int fd;
>>> @@ -67,10 +110,14 @@ void stat_bdev(struct stat64 *st, unsigned int *start_lba)
>>>  		goto out;
>>>  
>>>  	if (S_ISBLK(bdev_stat.st_mode)) {
>>> +#ifdef HDIO_GETGIO
>>>  		if (ioctl(fd, HDIO_GETGEO, &geom) < 0)
>>>  			*start_lba = 0;
>>>  		else
>>>  			*start_lba = geom.start;
>>> +#else
>>> +		*start_lba = 0;
>>> +#endif
>>>  	}
>>>  
>>>  	if (readlink(devname, linkname, sizeof(linkname)) < 0)
>>> @@ -90,7 +137,11 @@ int main(int argc, char *argv[])
>>>  	int fd;
>>>  	int ret = 0;
>>>  	char *filename;
>>> +#if defined(HAVE_FSTAT64) && !defined(__OSX_AVAILABLE_BUT_DEPRECATED)
>>>  	struct stat64 st;
>>> +#else
>>> +	struct stat st;
>>> +#endif
>>>  	int total_blks;
>>>  	unsigned int i;
>>>  	struct file_ext ext;
>>> @@ -112,7 +163,11 @@ int main(int argc, char *argv[])
>>>  
>>>  	fsync(fd);
>>>  
>>> +#if defined(HAVE_FSTAT64) && !defined(__OSX_AVAILABLE_BUT_DEPRECATED)
>>>  	if (fstat64(fd, &st) < 0) {
>>> +#else
>>> +	if (fstat(fd, &st) < 0) {
>>> +#endif
>>>  		ret = errno;
>>>  		perror(filename);
>>>  		goto out;
>>>
> 
> .
> 


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
