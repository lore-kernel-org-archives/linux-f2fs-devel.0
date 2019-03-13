From: kbuild test robot <lkp@intel.com>
Subject: [f2fs:dev-test /56] fs/f2fs/gc.c:1426:44: sparse: cast
 to restricted __le32
Date: Thu, 14 Mar 2019 07:33:55 +0800
Message-ID: <201903140754.sPs7JycE%lkp@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <lkp@intel.com>) id 1h4DQG-0005gR-Er
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 13 Mar 2019 23:36:32 +0000
Received: from mga09.intel.com ([134.134.136.24])
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1h4DQD-00Gu2h-Qv
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 13 Mar 2019 23:36:32 +0000
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
head:   904ecfcd9f95aba239695c5d90233f158f838919
commit: 481a85e8a4e54513d8551f01d00d81e39e37ec01 [/56] f2fs-dev: ioctl for removing a range from F2FS
reproduce:
        # apt-get install sparse
        git checkout 481a85e8a4e54513d8551f01d00d81e39e37ec01
        make ARCH=x86_64 allmodconfig
        make C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__'


sparse warnings: (new ones prefixed by >>)

>> fs/f2fs/gc.c:1426:44: sparse: cast to restricted __le32
>> fs/f2fs/gc.c:1426:44: sparse: cast from restricted __le64
>> fs/f2fs/gc.c:1426:42: sparse: incorrect type in assignment (different base types) @@    expected restricted __le64 [usertype] block_count @@    got restricted __le64 [usertype] block_count @@
   fs/f2fs/gc.c:1426:42:    expected restricted __le64 [usertype] block_count
   fs/f2fs/gc.c:1426:42:    got restricted __le32 [usertype] <noident>

vim +1426 fs/f2fs/gc.c

  1389	
  1390	int f2fs_resize_from_end(struct f2fs_sb_info *sbi, size_t resize_len)
  1391	{
  1392		unsigned int section_size = F2FS_BLKSIZE * BLKS_PER_SEC(sbi);
  1393		unsigned int secs = (resize_len + section_size - 1) / section_size;
  1394		int gc_mode;
  1395	
  1396		if (secs * BLKS_PER_SEC(sbi) + valid_user_blocks(sbi) +
  1397			sbi->current_reserved_blocks + sbi->unusable_block_count +
  1398			F2FS_OPTION(sbi).root_reserved_blocks > sbi->user_block_count)
  1399			return -ENOSPC;
  1400	
  1401		mutex_lock(&DIRTY_I(sbi)->seglist_lock);
  1402		NEW_MAIN_SECS(sbi) = MAIN_SECS(sbi) - secs;
  1403		for (gc_mode = 0; gc_mode < MAX_GC_POLICY; gc_mode++)
  1404			if (SIT_I(sbi)->last_victim[gc_mode] >=
  1405						NEW_MAIN_SECS(sbi) * sbi->segs_per_sec)
  1406				SIT_I(sbi)->last_victim[gc_mode] = 0;
  1407		mutex_unlock(&DIRTY_I(sbi)->seglist_lock);
  1408	
  1409		free_segment_range(sbi, NEW_MAIN_SECS(sbi) * sbi->segs_per_sec,
  1410				MAIN_SEGS(sbi) - 1);
  1411	
  1412		/* Update FS metadata */
  1413		SM_I(sbi)->segment_count -= secs * sbi->segs_per_sec;
  1414		MAIN_SECS(sbi) = NEW_MAIN_SECS(sbi);
  1415		MAIN_SEGS(sbi) = MAIN_SECS(sbi) * sbi->segs_per_sec;
  1416		sbi->user_block_count -= secs * BLKS_PER_SEC(sbi);
  1417		sbi->ckpt->user_block_count = cpu_to_le64(sbi->user_block_count);
  1418		FREE_I(sbi)->free_sections -= secs;
  1419		FREE_I(sbi)->free_segments -= secs * sbi->segs_per_sec;
  1420	
  1421		/* Update superblock */
  1422		F2FS_RAW_SUPER(sbi)->section_count = cpu_to_le32(MAIN_SECS(sbi));
  1423		F2FS_RAW_SUPER(sbi)->segment_count = cpu_to_le32(le32_to_cpu(
  1424			F2FS_RAW_SUPER(sbi)->segment_count) - secs * sbi->segs_per_sec);
  1425		F2FS_RAW_SUPER(sbi)->segment_count_main = cpu_to_le32(MAIN_SEGS(sbi));
> 1426		F2FS_RAW_SUPER(sbi)->block_count = cpu_to_le32(le32_to_cpu(

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
