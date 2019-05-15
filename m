From: kbuild test robot <lkp@intel.com>
Subject: [f2fs:dev-test 7/13] fs/f2fs/gc.c:1436:44: sparse:
 sparse: cast to restricted __le32
Date: Wed, 15 May 2019 14:43:58 +0800
Message-ID: <201905151457.plb68OA0%lkp@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <lkp@intel.com>) id 1hQneg-0005RT-3d
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 15 May 2019 06:44:46 +0000
Received: from mga18.intel.com ([134.134.136.126])
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1hQned-00GsDA-NS
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 15 May 2019 06:44:45 +0000
Content-Disposition: inline
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Qiuyang Sun <sunqiuyang@huawei.com>
Cc: Jaegeuk Kim <jaegeuk@kernel.org>, kbuild-all@01.org, linux-f2fs-devel@lists.sourceforge.net

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git dev-test
head:   e4cd04801efa3f41904df9792aa68b05fb3bae02
commit: 3f1e9a91423ff983985f648360a1f76787021654 [7/13] f2fs: ioctl for removing a range from F2FS
reproduce:
        # apt-get install sparse
        git checkout 3f1e9a91423ff983985f648360a1f76787021654
        make ARCH=x86_64 allmodconfig
        make C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__'

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)

>> fs/f2fs/gc.c:1436:44: sparse: sparse: cast to restricted __le32
>> fs/f2fs/gc.c:1436:44: sparse: sparse: cast from restricted __le64
>> fs/f2fs/gc.c:1436:42: sparse: sparse: incorrect type in assignment (different base types) @@    expected restricted __le64 [usertype] block_count @@    got restricted __le64 [usertype] block_count @@
>> fs/f2fs/gc.c:1436:42: sparse:    expected restricted __le64 [usertype] block_count
>> fs/f2fs/gc.c:1436:42: sparse:    got restricted __le32 [usertype]

vim +1436 fs/f2fs/gc.c

  1399	
  1400	int f2fs_resize_from_end(struct f2fs_sb_info *sbi, size_t resize_len)
  1401	{
  1402		unsigned int section_size = F2FS_BLKSIZE * BLKS_PER_SEC(sbi);
  1403		unsigned int secs = (resize_len + section_size - 1) / section_size;
  1404		int gc_mode;
  1405	
  1406		if (secs * BLKS_PER_SEC(sbi) + valid_user_blocks(sbi) +
  1407			sbi->current_reserved_blocks + sbi->unusable_block_count +
  1408			F2FS_OPTION(sbi).root_reserved_blocks > sbi->user_block_count)
  1409			return -ENOSPC;
  1410	
  1411		mutex_lock(&DIRTY_I(sbi)->seglist_lock);
  1412		NEW_MAIN_SECS(sbi) = MAIN_SECS(sbi) - secs;
  1413		for (gc_mode = 0; gc_mode < MAX_GC_POLICY; gc_mode++)
  1414			if (SIT_I(sbi)->last_victim[gc_mode] >=
  1415						NEW_MAIN_SECS(sbi) * sbi->segs_per_sec)
  1416				SIT_I(sbi)->last_victim[gc_mode] = 0;
  1417		mutex_unlock(&DIRTY_I(sbi)->seglist_lock);
  1418	
  1419		free_segment_range(sbi, NEW_MAIN_SECS(sbi) * sbi->segs_per_sec,
  1420				MAIN_SEGS(sbi) - 1);
  1421	
  1422		/* Update FS metadata */
  1423		SM_I(sbi)->segment_count -= secs * sbi->segs_per_sec;
  1424		MAIN_SECS(sbi) = NEW_MAIN_SECS(sbi);
  1425		MAIN_SEGS(sbi) = MAIN_SECS(sbi) * sbi->segs_per_sec;
  1426		sbi->user_block_count -= secs * BLKS_PER_SEC(sbi);
  1427		sbi->ckpt->user_block_count = cpu_to_le64(sbi->user_block_count);
  1428		FREE_I(sbi)->free_sections -= secs;
  1429		FREE_I(sbi)->free_segments -= secs * sbi->segs_per_sec;
  1430	
  1431		/* Update superblock */
  1432		F2FS_RAW_SUPER(sbi)->section_count = cpu_to_le32(MAIN_SECS(sbi));
  1433		F2FS_RAW_SUPER(sbi)->segment_count = cpu_to_le32(le32_to_cpu(
  1434			F2FS_RAW_SUPER(sbi)->segment_count) - secs * sbi->segs_per_sec);
  1435		F2FS_RAW_SUPER(sbi)->segment_count_main = cpu_to_le32(MAIN_SEGS(sbi));
> 1436		F2FS_RAW_SUPER(sbi)->block_count = cpu_to_le32(le32_to_cpu(

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
