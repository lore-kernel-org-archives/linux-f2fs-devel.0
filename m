From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [f2fs:dev-test 17/43] fs/f2fs/segment.c:2422:3:
 error: label 'out' used but not defined
Date: Thu, 3 May 2018 09:37:28 +0800
Message-ID: <086dbbd0-fd66-f6e3-b1d9-fa19b44b480e@huawei.com>
References: <201805030856.dxbO5HNd%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <yuchao0@huawei.com>) id 1fE3Bx-0007Zg-Lx
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 03 May 2018 01:37:53 +0000
Received: from szxga05-in.huawei.com ([45.249.212.191] helo=huawei.com)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1fE3Bu-00HCOL-0s
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 03 May 2018 01:37:53 +0000
In-Reply-To: <201805030856.dxbO5HNd%fengguang.wu@intel.com>
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
To: kbuild test robot <lkp@intel.com>, Chao Yu <chao@kernel.org>, Jaegeuk Kim <jaegeuk@kernel.org>
Cc: kbuild-all@01.org, linux-f2fs-devel@lists.sourceforge.net

On 2018/5/3 8:51, kbuild test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git dev-test
> head:   feae4d20e07c14bd416da38bf34b5d18c034b9b5
> commit: 6c55253f427c44da1b7d49592144c13de0274a47 [17/43] f2fs: don't split checkpoint in fstrim
> config: x86_64-randconfig-x013-201817 (attached as .config)
> compiler: gcc-7 (Debian 7.3.0-16) 7.3.0
> reproduce:
>         git checkout 6c55253f427c44da1b7d49592144c13de0274a47
>         # save the attached .config to linux build tree
>         make ARCH=x86_64 
> 
> All errors (new ones prefixed by >>):
> 
>    fs/f2fs/segment.c: In function 'f2fs_trim_fs':
>>> fs/f2fs/segment.c:2422:3: error: label 'out' used but not defined
>       goto out;
>       ^~~~

I think there is a conflict when merging another patch "f2fs: correct return
value of f2fs_trim_fs" in where we remove the 'out' label, Jaegeuk, could you
help to fix it in git tree?

Thanks,

> 
> vim +/out +2422 fs/f2fs/segment.c
> 
>   2381	
>   2382	int f2fs_trim_fs(struct f2fs_sb_info *sbi, struct fstrim_range *range)
>   2383	{
>   2384		__u64 start = F2FS_BYTES_TO_BLK(range->start);
>   2385		__u64 end = start + F2FS_BYTES_TO_BLK(range->len) - 1;
>   2386		unsigned int start_segno, end_segno;
>   2387		block_t start_block, end_block;
>   2388		struct cp_control cpc;
>   2389		struct discard_policy dpolicy;
>   2390		unsigned long long trimmed = 0;
>   2391		int err = 0;
>   2392	
>   2393		if (start >= MAX_BLKADDR(sbi) || range->len < sbi->blocksize)
>   2394			return -EINVAL;
>   2395	
>   2396		if (end <= MAIN_BLKADDR(sbi))
>   2397			return -EINVAL;
>   2398	
>   2399		if (is_sbi_flag_set(sbi, SBI_NEED_FSCK)) {
>   2400			f2fs_msg(sbi->sb, KERN_WARNING,
>   2401				"Found FS corruption, run fsck to fix.");
>   2402			return -EIO;
>   2403		}
>   2404	
>   2405		/* start/end segment number in main_area */
>   2406		start_segno = (start <= MAIN_BLKADDR(sbi)) ? 0 : GET_SEGNO(sbi, start);
>   2407		end_segno = (end >= MAX_BLKADDR(sbi)) ? MAIN_SEGS(sbi) - 1 :
>   2408							GET_SEGNO(sbi, end);
>   2409	
>   2410		cpc.reason = CP_DISCARD;
>   2411		cpc.trim_minlen = max_t(__u64, 1, F2FS_BYTES_TO_BLK(range->minlen));
>   2412		cpc.trim_start = start_segno;
>   2413		cpc.trim_end = end_segno;
>   2414	
>   2415		if (sbi->discard_blks == 0)
>   2416			goto out;
>   2417	
>   2418		mutex_lock(&sbi->gc_mutex);
>   2419		err = write_checkpoint(sbi, &cpc);
>   2420		mutex_unlock(&sbi->gc_mutex);
>   2421		if (err)
>> 2422			goto out;
>   2423	
>   2424		start_block = START_BLOCK(sbi, start_segno);
>   2425		end_block = START_BLOCK(sbi, end_segno + 1);
>   2426	
>   2427		init_discard_policy(&dpolicy, DPOLICY_FSTRIM, cpc.trim_minlen);
>   2428		__issue_discard_cmd_range(sbi, &dpolicy, start_block, end_block);
>   2429		trimmed = __wait_discard_cmd_range(sbi, &dpolicy,
>   2430						start_block, end_block);
>   2431		range->len = F2FS_BLK_TO_BYTES(trimmed);
>   2432		return err;
>   2433	}
>   2434	
> 
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
> 


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
