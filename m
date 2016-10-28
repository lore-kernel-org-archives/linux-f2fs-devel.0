From: kbuild test robot <lkp@intel.com>
Subject: Re: [PATCH 8/9] f2fs: Reset sequential zones on zoned block devices
Date: Fri, 28 Oct 2016 17:38:16 +0800
Message-ID: <201610281750.WSfWJ5Yk%fengguang.wu@intel.com>
References: <1477641337-12321-9-git-send-email-damien.lemoal@wdc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-fsdevel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1477641337-12321-9-git-send-email-damien.lemoal@wdc.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Cc: kbuild-all@01.org, jaegeuk@kernel.org, yuchao0@huawei.com, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, Hannes Reinecke <hare@suse.de>, Shaun Tancheff <shaun@tancheff.com>, Damien Le Moal <damien.lemoal@wdc.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

Hi Damien,

[auto build test WARNING on v4.9-rc2]
[cannot apply to f2fs/dev next-20161028]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
[Suggest to use git(>=2.9.0) format-patch --base=<commit> (or --base=auto for convenience) to record what (public, well-known) commit your patch series was built on]
[Check https://git-scm.com/docs/git-format-patch for more information]

url:    https://github.com/0day-ci/linux/commits/Damien-Le-Moal/f2fs-Zoned-block-device-support/20161028-160349
reproduce:
        # apt-get install sparse
        make ARCH=x86_64 allmodconfig
        make C=1 CF=-D__CHECK_ENDIAN__


sparse warnings: (new ones prefixed by >>)

   include/linux/compiler.h:253:8: sparse: attribute 'no_sanitize_address': unknown attribute
   fs/f2fs/segment.c:668:25: sparse: undefined identifier 'bdev_zone_size'
   fs/f2fs/f2fs.h:2424:42: sparse: no member 'log_blocks_per_blkz' in struct f2fs_sb_info
   fs/f2fs/f2fs.h:2426:19: sparse: no member 'blkz_type' in struct f2fs_sb_info
   fs/f2fs/segment.c:683:14: sparse: undefined identifier 'BLK_ZONE_TYPE_CONVENTIONAL'
   fs/f2fs/segment.c:689:14: sparse: undefined identifier 'BLK_ZONE_TYPE_SEQWRITE_REQ'
   fs/f2fs/segment.c:690:14: sparse: undefined identifier 'BLK_ZONE_TYPE_SEQWRITE_PREF'
   fs/f2fs/segment.c:691:24: sparse: undefined identifier 'blkdev_reset_zones'
>> fs/f2fs/segment.c:683:14: sparse: incompatible types for 'case' statement
   fs/f2fs/segment.c:689:14: sparse: incompatible types for 'case' statement
   fs/f2fs/segment.c:690:14: sparse: incompatible types for 'case' statement
   fs/f2fs/segment.c:683:14: sparse: Expected constant expression in case statement
   fs/f2fs/segment.c:689:14: sparse: Expected constant expression in case statement
   fs/f2fs/segment.c:690:14: sparse: Expected constant expression in case statement
   In file included from fs/f2fs/segment.c:20:0:
   fs/f2fs/f2fs.h: In function 'get_blkz_type':
   fs/f2fs/f2fs.h:2424:35: error: 'struct f2fs_sb_info' has no member named 'log_blocks_per_blkz'; did you mean 'log_blocks_per_seg'?
     unsigned int zno = blkaddr >> sbi->log_blocks_per_blkz;
                                      ^~
   fs/f2fs/f2fs.h:2426:12: error: 'struct f2fs_sb_info' has no member named 'blkz_type'
     return sbi->blkz_type[zno];
               ^~
   fs/f2fs/segment.c: In function 'f2fs_issue_discard_zone':
   fs/f2fs/segment.c:668:18: error: implicit declaration of function 'bdev_zone_size' [-Werror=implicit-function-declaration]
     if (nr_sects != bdev_zone_size(bdev)) {
                     ^~~~~~~~~~~~~~
   fs/f2fs/segment.c:683:7: error: 'BLK_ZONE_TYPE_CONVENTIONAL' undeclared (first use in this function)
     case BLK_ZONE_TYPE_CONVENTIONAL:
          ^~~~~~~~~~~~~~~~~~~~~~~~~~
   fs/f2fs/segment.c:683:7: note: each undeclared identifier is reported only once for each function it appears in
   fs/f2fs/segment.c:689:7: error: 'BLK_ZONE_TYPE_SEQWRITE_REQ' undeclared (first use in this function)
     case BLK_ZONE_TYPE_SEQWRITE_REQ:
          ^~~~~~~~~~~~~~~~~~~~~~~~~~
   fs/f2fs/segment.c:690:7: error: 'BLK_ZONE_TYPE_SEQWRITE_PREF' undeclared (first use in this function)
     case BLK_ZONE_TYPE_SEQWRITE_PREF:
          ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   fs/f2fs/segment.c:691:10: error: implicit declaration of function 'blkdev_reset_zones' [-Werror=implicit-function-declaration]
      return blkdev_reset_zones(bdev, sector,
             ^~~~~~~~~~~~~~~~~~
   In file included from fs/f2fs/segment.c:20:0:
   fs/f2fs/f2fs.h: In function 'get_blkz_type':
   fs/f2fs/f2fs.h:2427:1: warning: control reaches end of non-void function [-Wreturn-type]
    }
    ^
   cc1: some warnings being treated as errors

vim +/case +683 fs/f2fs/segment.c

   662						block_t blkstart, block_t blklen)
   663	{
   664		sector_t sector = SECTOR_FROM_BLOCK(blkstart);
   665		sector_t nr_sects = SECTOR_FROM_BLOCK(blklen);
   666		struct block_device *bdev = sbi->sb->s_bdev;
   667	
 > 668		if (nr_sects != bdev_zone_size(bdev)) {
   669			f2fs_msg(sbi->sb, KERN_INFO,
   670				 "Unaligned discard attempted (sector %llu + %llu)",
   671				 (unsigned long long)sector,
   672				 (unsigned long long)nr_sects);
   673			return -EIO;
   674		}
   675	
   676		/*
   677		 * We need to know the type of the zone: for conventional zones,
   678		 * use regular discard if the drive supports it. For sequential
   679		 * zones, reset the zone write pointer.
   680		 */
   681		switch (get_blkz_type(sbi, blkstart)) {
   682	
 > 683		case BLK_ZONE_TYPE_CONVENTIONAL:
   684			if (!blk_queue_discard(bdev_get_queue(bdev)))
   685				return 0;
   686			return __f2fs_issue_discard_async(sbi, blkstart,

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
