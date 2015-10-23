From: Fengguang Wu <fengguang.wu@intel.com>
Subject: Re: [kbuild-all] [f2fs:linux-3.10 36/36]
 fs/f2fs/dir.c:898:2: error: unknown field 'readdir' specified in
 initializer
Date: Fri, 23 Oct 2015 08:09:24 +0800
Message-ID: <20151023000924.GA32099@wfg-t540p.sh.intel.com>
References: <201510060701.qocJiwCT%fengguang.wu@intel.com>
	<20151022231327.GA30517@wfg-t540p.sh.intel.com>
	<20151022232036.GA57981@jaegeuk-mac02.mot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <fengguang.wu@intel.com>) id 1ZpPvR-0001bV-Fc
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 23 Oct 2015 00:09:41 +0000
Received: from mga02.intel.com ([134.134.136.20])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1ZpPvP-0004Pc-FT for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 23 Oct 2015 00:09:41 +0000
Content-Disposition: inline
In-Reply-To: <20151022232036.GA57981@jaegeuk-mac02.mot.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: kbuild-all@01.org, f2fs <linux-f2fs-devel@lists.sourceforge.net>

Hi Jaegeuk,

On Thu, Oct 22, 2015 at 04:20:36PM -0700, Jaegeuk Kim wrote:
> Hi Fengguang,
> 
> On Fri, Oct 23, 2015 at 07:13:27AM +0800, Fengguang Wu wrote:
> > FYI, it's still not fixed..
> 
> Thank you so much for every valuable tests.
> If possible, could you get rid of this branch, linux-3.10, from your kbuild test
> robot?

OK.

> This provides a backported f2fs for v3.10, so it should fail to build as
> is.

The problem is, this branch is based on v4.2 kernel. Otherwise the
robot will auto skip old kernels. 

> Please, note that the only valid branch in my repo for linux-next is *dev*.

OK. I'll blacklist branches other than dev and dev-test.

Thanks,
Fengguang

> > On Tue, Oct 06, 2015 at 07:30:03AM +0800, kbuild test robot wrote:
> > > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs linux-3.10
> > > head:   c47363c38a60736d1c5baaa29613c177dfacebd9
> > > commit: c47363c38a60736d1c5baaa29613c177dfacebd9 [36/36] f2fs: support 3.10
> > > config: i386-randconfig-x003-201540 (attached as .config)
> > > reproduce:
> > >         git checkout c47363c38a60736d1c5baaa29613c177dfacebd9
> > >         # save the attached .config to linux build tree
> > >         make ARCH=i386 
> > > 
> > > All errors (new ones prefixed by >>):
> > > 
> > > >> fs/f2fs/dir.c:898:2: error: unknown field 'readdir' specified in initializer
> > >      .readdir = f2fs_readdir,
> > >      ^
> > >    fs/f2fs/dir.c:898:13: warning: initialization from incompatible pointer type [-Wincompatible-pointer-types]
> > >      .readdir = f2fs_readdir,
> > >                 ^
> > >    fs/f2fs/dir.c:898:13: note: (near initialization for 'f2fs_dir_operations.write')
> > > --
> > >    In file included from fs/f2fs/file.c:27:0:
> > >    fs/f2fs/segment.h: In function 'nr_pages_to_skip':
> > >    fs/f2fs/segment.h:698:20: error: 'struct backing_dev_info' has no member named 'dirty_exceeded'
> > >      if (sbi->sb->s_bdi->dirty_exceeded)
> > >                        ^
> > >    fs/f2fs/file.c: At top level:
> > > >> fs/f2fs/file.c:324:15: error: static declaration of 'vfs_setpos' follows non-static declaration
> > >     static loff_t vfs_setpos(struct file *file, loff_t offset, loff_t maxsize)
> > >                   ^
> > >    In file included from fs/f2fs/file.c:11:0:
> > >    include/linux/fs.h:2662:15: note: previous declaration of 'vfs_setpos' was here
> > >     extern loff_t vfs_setpos(struct file *file, loff_t offset, loff_t maxsize);
> > >                   ^
> > >    fs/f2fs/file.c: In function 'f2fs_collapse_range':
> > > >> fs/f2fs/file.c:958:2: error: too many arguments to function 'truncate_pagecache'
> > >      truncate_pagecache(inode, 0, offset);
> > >      ^
> > >    In file included from include/linux/pagemap.h:7:0,
> > >                     from include/linux/f2fs_fs.h:14,
> > >                     from fs/f2fs/file.c:12:
> > >    include/linux/mm.h:1172:13: note: declared here
> > >     extern void truncate_pagecache(struct inode *inode, loff_t new);
> > >                 ^
> > >    fs/f2fs/file.c: In function 'f2fs_insert_range':
> > >    fs/f2fs/file.c:1117:2: error: too many arguments to function 'truncate_pagecache'
> > >      truncate_pagecache(inode, 0, offset);
> > >      ^
> > >    In file included from include/linux/pagemap.h:7:0,
> > >                     from include/linux/f2fs_fs.h:14,
> > >                     from fs/f2fs/file.c:12:
> > >    include/linux/mm.h:1172:13: note: declared here
> > >     extern void truncate_pagecache(struct inode *inode, loff_t new);
> > >                 ^
> > >    fs/f2fs/file.c: At top level:
> > >    fs/f2fs/file.c:1241:0: warning: "FALLOC_FL_COLLAPSE_RANGE" redefined
> > >     #define FALLOC_FL_COLLAPSE_RANGE 0X08
> > >     ^
> > >    In file included from include/linux/falloc.h:4:0,
> > >                     from fs/f2fs/file.c:17:
> > >    include/uapi/linux/falloc.h:28:0: note: this is the location of the previous definition
> > >     #define FALLOC_FL_COLLAPSE_RANGE 0x08
> > >     ^
> > >    fs/f2fs/file.c:1242:0: warning: "FALLOC_FL_ZERO_RANGE" redefined
> > >     #define FALLOC_FL_ZERO_RANGE  0X10
> > >     ^
> > >    In file included from include/linux/falloc.h:4:0,
> > >                     from fs/f2fs/file.c:17:
> > >    include/uapi/linux/falloc.h:42:0: note: this is the location of the previous definition
> > >     #define FALLOC_FL_ZERO_RANGE  0x10
> > >     ^
> > >    fs/f2fs/file.c:1243:0: warning: "FALLOC_FL_INSERT_RANGE" redefined
> > >     #define FALLOC_FL_INSERT_RANGE  0X20
> > >     ^
> > >    In file included from include/linux/falloc.h:4:0,
> > >                     from fs/f2fs/file.c:17:
> > >    include/uapi/linux/falloc.h:59:0: note: this is the location of the previous definition
> > >     #define FALLOC_FL_INSERT_RANGE  0x20
> > >     ^
> > > >> fs/f2fs/file.c:1741:11: error: 'do_sync_read' undeclared here (not in a function)
> > >      .read  = do_sync_read,
> > >               ^
> > > >> fs/f2fs/file.c:1742:12: error: 'do_sync_write' undeclared here (not in a function)
> > >      .write  = do_sync_write,
> > >                ^
> > > >> fs/f2fs/file.c:1743:2: error: unknown field 'aio_read' specified in initializer
> > >      .aio_read = generic_file_aio_read,
> > >      ^
> > > >> fs/f2fs/file.c:1743:14: error: 'generic_file_aio_read' undeclared here (not in a function)
> > >      .aio_read = generic_file_aio_read,
> > >                  ^
> > > >> fs/f2fs/file.c:1744:2: error: unknown field 'aio_write' specified in initializer
> > >      .aio_write = generic_file_aio_write,
> > >      ^
> > > >> fs/f2fs/file.c:1744:15: error: 'generic_file_aio_write' undeclared here (not in a function)
> > >      .aio_write = generic_file_aio_write,
> > >                   ^
> > > >> fs/f2fs/file.c:1755:18: error: 'generic_file_splice_write' undeclared here (not in a function)
> > >      .splice_write = generic_file_splice_write,
> > >                      ^
> > > --
> > >    In file included from fs/f2fs/super.c:30:0:
> > >    fs/f2fs/segment.h: In function 'nr_pages_to_skip':
> > >    fs/f2fs/segment.h:698:20: error: 'struct backing_dev_info' has no member named 'dirty_exceeded'
> > >      if (sbi->sb->s_bdi->dirty_exceeded)
> > >                        ^
> > >    In file included from include/trace/define_trace.h:91:0,
> > >                     from include/trace/events/f2fs.h:1207,
> > >                     from fs/f2fs/super.c:36:
> > >    include/trace/events/f2fs.h: In function 'trace_event_raw_event_f2fs__submit_bio':
> > > >> include/trace/events/f2fs.h:755:25: error: 'struct bio' has no member named 'bi_sector'
> > >       __entry->sector  = bio->bi_sector;
> > >                             ^
> > >    include/trace/perf.h:175:4: note: in definition of macro 'DECLARE_EVENT_CLASS'
> > >      { assign; }       \
> > >        ^
> > >    include/trace/events/f2fs.h:751:2: note: in expansion of macro 'TP_fast_assign'
> > >      TP_fast_assign(
> > >      ^
> > > >> include/trace/events/f2fs.h:756:23: error: 'struct bio' has no member named 'bi_size'
> > >       __entry->size  = bio->bi_size;
> > >                           ^
> > >    include/trace/perf.h:175:4: note: in definition of macro 'DECLARE_EVENT_CLASS'
> > >      { assign; }       \
> > >        ^
> > >    include/trace/events/f2fs.h:751:2: note: in expansion of macro 'TP_fast_assign'
> > >      TP_fast_assign(
> > >      ^
> > >    In file included from include/trace/define_trace.h:91:0,
> > >                     from include/trace/events/f2fs.h:1207,
> > >                     from fs/f2fs/super.c:36:
> > >    include/trace/events/f2fs.h: In function 'perf_trace_f2fs__submit_bio':
> > > >> include/trace/events/f2fs.h:755:25: error: 'struct bio' has no member named 'bi_sector'
> > >       __entry->sector  = bio->bi_sector;
> > >                             ^
> > >    include/trace/perf.h:326:4: note: in definition of macro 'DECLARE_EVENT_CLASS'
> > >      { assign; }       \
> > >        ^
> > >    include/trace/events/f2fs.h:751:2: note: in expansion of macro 'TP_fast_assign'
> > >      TP_fast_assign(
> > >      ^
> > > >> include/trace/events/f2fs.h:756:23: error: 'struct bio' has no member named 'bi_size'
> > >       __entry->size  = bio->bi_size;
> > >                           ^
> > >    include/trace/perf.h:326:4: note: in definition of macro 'DECLARE_EVENT_CLASS'
> > >      { assign; }       \
> > >        ^
> > >    include/trace/events/f2fs.h:751:2: note: in expansion of macro 'TP_fast_assign'
> > >      TP_fast_assign(
> > >      ^
> > >    fs/f2fs/super.c: At top level:
> > > >> fs/f2fs/super.c:44:2: error: unknown field 'shrink' specified in initializer
> > >      .shrink = f2fs_shrink_scan,
> > >      ^
> > >    fs/f2fs/super.c:44:12: warning: initialization from incompatible pointer type [-Wincompatible-pointer-types]
> > >      .shrink = f2fs_shrink_scan,
> > >                ^
> > >    fs/f2fs/super.c:44:12: note: (near initialization for 'f2fs_shrinker_info.count_objects')
> > > --
> > >    In file included from fs/f2fs/data.c:27:0:
> > >    fs/f2fs/segment.h: In function 'nr_pages_to_skip':
> > >    fs/f2fs/segment.h:698:20: error: 'struct backing_dev_info' has no member named 'dirty_exceeded'
> > >      if (sbi->sb->s_bdi->dirty_exceeded)
> > >                        ^
> > >    fs/f2fs/data.c: In function '__bio_alloc':
> > > >> fs/f2fs/data.c:97:5: error: 'struct bio' has no member named 'bi_sector'
> > >      bio->bi_sector = SECTOR_FROM_BLOCK(blk_addr);
> > >         ^
> > >    fs/f2fs/data.c:98:17: warning: assignment from incompatible pointer type [-Wincompatible-pointer-types]
> > >      bio->bi_end_io = is_read ? f2fs_read_end_io : f2fs_write_end_io;
> > >                     ^
> > >    In file included from include/linux/list.h:8:0,
> > >                     from include/linux/wait.h:6,
> > >                     from include/linux/fs.h:6,
> > >                     from fs/f2fs/data.c:11:
> > >    fs/f2fs/data.c: In function 'f2fs_mpage_readpages':
> > >    fs/f2fs/data.c:976:26: error: implicit declaration of function 'bio_get_nr_vecs' [-Werror=implicit-function-declaration]
> > >         min_t(int, nr_pages, bio_get_nr_vecs(bdev)));
> > >                              ^
> > >    include/linux/kernel.h:763:17: note: in definition of macro 'min_t'
> > >      type __min2 = (y);   \
> > >                     ^
> > >    fs/f2fs/data.c:983:7: error: 'struct bio' has no member named 'bi_sector'
> > >        bio->bi_sector = SECTOR_FROM_BLOCK(block_nr);
> > >           ^
> > >    fs/f2fs/data.c:984:19: warning: assignment from incompatible pointer type [-Wincompatible-pointer-types]
> > >        bio->bi_end_io = f2fs_read_end_io;
> > >                       ^
> > >    fs/f2fs/data.c: In function 'f2fs_write_failed':
> > > >> fs/f2fs/data.c:1374:3: error: too many arguments to function 'truncate_pagecache'
> > >       truncate_pagecache(inode, 0, inode->i_size);
> > >       ^
> > >    In file included from include/linux/pagemap.h:7:0,
> > >                     from include/linux/f2fs_fs.h:14,
> > >                     from fs/f2fs/data.c:12:
> > >    include/linux/mm.h:1172:13: note: declared here
> > >     extern void truncate_pagecache(struct inode *inode, loff_t new);
> > >                 ^
> > >    fs/f2fs/data.c: In function 'f2fs_direct_IO':
> > >    fs/f2fs/data.c:1603:27: warning: passing argument 1 of 'blockdev_direct_IO' makes pointer from integer without a cast [-Wint-conversion]
> > >      err = blockdev_direct_IO(rw, iocb, inode, iov, offset, nr_segs,
> > >                               ^
> > >    In file included from fs/f2fs/data.c:11:0:
> > >    include/linux/fs.h:2710:23: note: expected 'struct kiocb *' but argument is of type 'int'
> > >     static inline ssize_t blockdev_direct_IO(struct kiocb *iocb,
> > >                           ^
> > >    fs/f2fs/data.c:1603:31: warning: passing argument 2 of 'blockdev_direct_IO' from incompatible pointer type [-Wincompatible-pointer-types]
> > >      err = blockdev_direct_IO(rw, iocb, inode, iov, offset, nr_segs,
> > >                                   ^
> > >    In file included from fs/f2fs/data.c:11:0:
> > >    include/linux/fs.h:2710:23: note: expected 'struct inode *' but argument is of type 'struct kiocb *'
> > >     static inline ssize_t blockdev_direct_IO(struct kiocb *iocb,
> > >                           ^
> > >    fs/f2fs/data.c:1603:37: warning: passing argument 3 of 'blockdev_direct_IO' from incompatible pointer type [-Wincompatible-pointer-types]
> > >      err = blockdev_direct_IO(rw, iocb, inode, iov, offset, nr_segs,
> > >                                         ^
> > >    In file included from fs/f2fs/data.c:11:0:
> > >    include/linux/fs.h:2710:23: note: expected 'struct iov_iter *' but argument is of type 'struct inode *'
> > >     static inline ssize_t blockdev_direct_IO(struct kiocb *iocb,
> > >                           ^
> > >    fs/f2fs/data.c:1603:44: warning: passing argument 4 of 'blockdev_direct_IO' makes integer from pointer without a cast [-Wint-conversion]
> > >      err = blockdev_direct_IO(rw, iocb, inode, iov, offset, nr_segs,
> > >                                                ^
> > >    In file included from fs/f2fs/data.c:11:0:
> > >    include/linux/fs.h:2710:23: note: expected 'loff_t {aka long long int}' but argument is of type 'const struct iovec *'
> > >     static inline ssize_t blockdev_direct_IO(struct kiocb *iocb,
> > >                           ^
> > >    fs/f2fs/data.c:1603:49: warning: passing argument 5 of 'blockdev_direct_IO' makes pointer from integer without a cast [-Wint-conversion]
> > >      err = blockdev_direct_IO(rw, iocb, inode, iov, offset, nr_segs,
> > >                                                     ^
> > >    In file included from fs/f2fs/data.c:11:0:
> > >    include/linux/fs.h:2710:23: note: expected 'int (*)(struct inode *, sector_t,  struct buffer_head *, int) {aka int (*)(struct inode *, long long unsigned int,  struct buffer_head *, int)}' but argument is of type 'loff_t {aka long long int}'
> > >     static inline ssize_t blockdev_direct_IO(struct kiocb *iocb,
> > >                           ^
> > >    fs/f2fs/data.c:1603:8: error: too many arguments to function 'blockdev_direct_IO'
> > >      err = blockdev_direct_IO(rw, iocb, inode, iov, offset, nr_segs,
> > >            ^
> > >    In file included from fs/f2fs/data.c:11:0:
> > >    include/linux/fs.h:2710:23: note: declared here
> > >     static inline ssize_t blockdev_direct_IO(struct kiocb *iocb,
> > >                           ^
> > >    fs/f2fs/data.c: At top level:
> > >    fs/f2fs/data.c:1702:20: warning: initialization from incompatible pointer type [-Wincompatible-pointer-types]
> > >      .invalidatepage = f2fs_invalidate_page,
> > >                        ^
> > >    fs/f2fs/data.c:1702:20: note: (near initialization for 'f2fs_dblock_aops.invalidatepage')
> > >    fs/f2fs/data.c:1704:15: warning: initialization from incompatible pointer type [-Wincompatible-pointer-types]
> > >      .direct_IO = f2fs_direct_IO,
> > >                   ^
> > >    fs/f2fs/data.c:1704:15: note: (near initialization for 'f2fs_dblock_aops.direct_IO')
> > >    cc1: some warnings being treated as errors
> > > --
> > >    fs/f2fs/acl.c: In function 'f2fs_init_acl':
> > >    fs/f2fs/acl.c:293:27: warning: passing argument 1 of 'posix_acl_create' from incompatible pointer type [-Wincompatible-pointer-types]
> > >      error = posix_acl_create(&acl, GFP_KERNEL, &inode->i_mode);
> > >                               ^
> > >    In file included from include/linux/posix_acl_xattr.h:12:0,
> > >                     from fs/f2fs/acl.h:18,
> > >                     from fs/f2fs/acl.c:18:
> > >    include/linux/posix_acl.h:96:12: note: expected 'struct inode *' but argument is of type 'struct posix_acl **'
> > >     extern int posix_acl_create(struct inode *, umode_t *, struct posix_acl **,
> > >                ^
> > >    In file included from include/linux/mm.h:9:0,
> > >                     from include/linux/pagemap.h:7,
> > >                     from include/linux/f2fs_fs.h:14,
> > >                     from fs/f2fs/acl.c:15:
> > >    include/linux/gfp.h:113:20: warning: passing argument 2 of 'posix_acl_create' makes pointer from integer without a cast [-Wint-conversion]
> > >     #define GFP_KERNEL (__GFP_WAIT | __GFP_IO | __GFP_FS)
> > >                        ^
> > >    fs/f2fs/acl.c:293:33: note: in expansion of macro 'GFP_KERNEL'
> > >      error = posix_acl_create(&acl, GFP_KERNEL, &inode->i_mode);
> > >                                     ^
> > >    In file included from include/linux/posix_acl_xattr.h:12:0,
> > >                     from fs/f2fs/acl.h:18,
> > >                     from fs/f2fs/acl.c:18:
> > >    include/linux/posix_acl.h:96:12: note: expected 'umode_t * {aka short unsigned int *}' but argument is of type 'unsigned int'
> > >     extern int posix_acl_create(struct inode *, umode_t *, struct posix_acl **,
> > >                ^
> > >    fs/f2fs/acl.c:293:45: warning: passing argument 3 of 'posix_acl_create' from incompatible pointer type [-Wincompatible-pointer-types]
> > >      error = posix_acl_create(&acl, GFP_KERNEL, &inode->i_mode);
> > >                                                 ^
> > >    In file included from include/linux/posix_acl_xattr.h:12:0,
> > >                     from fs/f2fs/acl.h:18,
> > >                     from fs/f2fs/acl.c:18:
> > >    include/linux/posix_acl.h:96:12: note: expected 'struct posix_acl **' but argument is of type 'umode_t * {aka short unsigned int *}'
> > >     extern int posix_acl_create(struct inode *, umode_t *, struct posix_acl **,
> > >                ^
> > > >> fs/f2fs/acl.c:293:10: error: too few arguments to function 'posix_acl_create'
> > >      error = posix_acl_create(&acl, GFP_KERNEL, &inode->i_mode);
> > >              ^
> > >    In file included from include/linux/posix_acl_xattr.h:12:0,
> > >                     from fs/f2fs/acl.h:18,
> > >                     from fs/f2fs/acl.c:18:
> > >    include/linux/posix_acl.h:96:12: note: declared here
> > >     extern int posix_acl_create(struct inode *, umode_t *, struct posix_acl **,
> > >                ^
> > >    fs/f2fs/acl.c: In function 'f2fs_acl_chmod':
> > >    fs/f2fs/acl.c:319:26: warning: passing argument 1 of 'posix_acl_chmod' from incompatible pointer type [-Wincompatible-pointer-types]
> > >      error = posix_acl_chmod(&acl, GFP_KERNEL, mode);
> > >                              ^
> > >    In file included from include/linux/posix_acl_xattr.h:12:0,
> > >                     from fs/f2fs/acl.h:18,
> > >                     from fs/f2fs/acl.c:18:
> > >    include/linux/posix_acl.h:95:12: note: expected 'struct inode *' but argument is of type 'struct posix_acl **'
> > >     extern int posix_acl_chmod(struct inode *, umode_t);
> > >                ^
> > > >> fs/f2fs/acl.c:319:10: error: too many arguments to function 'posix_acl_chmod'
> > >      error = posix_acl_chmod(&acl, GFP_KERNEL, mode);
> > >              ^
> > >    In file included from include/linux/posix_acl_xattr.h:12:0,
> > >                     from fs/f2fs/acl.h:18,
> > >                     from fs/f2fs/acl.c:18:
> > >    include/linux/posix_acl.h:95:12: note: declared here
> > >     extern int posix_acl_chmod(struct inode *, umode_t);
> > >                ^
> > > 
> > > vim +/readdir +898 fs/f2fs/dir.c
> > > 
> > >    892		return err;
> > >    893	}
> > >    894	
> > >    895	const struct file_operations f2fs_dir_operations = {
> > >    896		.llseek		= generic_file_llseek,
> > >    897		.read		= generic_read_dir,
> > >  > 898		.readdir	= f2fs_readdir,
> > >    899		.fsync		= f2fs_sync_file,
> > >    900		.unlocked_ioctl	= f2fs_ioctl,
> > >    901	#ifdef CONFIG_COMPAT
> > > 
> > > ---
> > > 0-DAY kernel test infrastructure                Open Source Technology Center
> > > https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
> > 
> > 
> > > _______________________________________________
> > > kbuild-all mailing list
> > > kbuild-all@lists.01.org
> > > https://lists.01.org/mailman/listinfo/kbuild-all
> _______________________________________________
> kbuild-all mailing list
> kbuild-all@lists.01.org
> https://lists.01.org/mailman/listinfo/kbuild-all

------------------------------------------------------------------------------
