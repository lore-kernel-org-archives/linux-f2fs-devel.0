From: Chao Yu <chao2.yu@samsung.com>
Subject: Re: [PATCH 1/2] f2fs: report error of
	f2fs_create_root_stats
Date: Thu, 29 Oct 2015 09:09:50 +0800
Message-ID: <01d901d111e6$a04b8870$e0e29950$@samsung.com>
References: <01aa01d11166$d88de7d0$89a9b770$@samsung.com>
	<201510281853.iWVhWYTs%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chao2.yu@samsung.com>) id 1Zrbju-0005MP-Rn
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 29 Oct 2015 01:10:50 +0000
Received: from mailout2.samsung.com ([203.254.224.25])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1Zrbjs-0003Xu-Q9
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 29 Oct 2015 01:10:50 +0000
Received: from epcpsbgm2new.samsung.com (epcpsbgm2 [203.254.230.27])
	by mailout2.samsung.com
	(Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May 5
	2014)) with ESMTP id <0NWY007I3J9BMSB0@mailout2.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Thu, 29 Oct 2015 10:10:40 +0900 (KST)
In-reply-to: <201510281853.iWVhWYTs%fengguang.wu@intel.com>
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
To: 'kbuild test robot' <lkp@intel.com>
Cc: 'Jaegeuk Kim' <jaegeuk@kernel.org>, kbuild-all@01.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

Hi,

Thanks for reporting this, I will fix it. :)

Regards,

> -----Original Message-----
> From: kbuild test robot [mailto:lkp@intel.com]
> Sent: Wednesday, October 28, 2015 6:30 PM
> To: Chao Yu
> Cc: kbuild-all@01.org; Jaegeuk Kim; linux-f2fs-devel@lists.sourceforge.net;
> linux-kernel@vger.kernel.org
> Subject: Re: [PATCH 1/2] f2fs: report error of f2fs_create_root_stats
> 
> Hi Chao,
> 
> [auto build test WARNING on f2fs/dev -- if it's inappropriate base, please suggest rules for
> selecting the more suitable base]
> 
> url:
> https://github.com/0day-ci/linux/commits/Chao-Yu/f2fs-report-error-of-f2fs_create_root_sta
> ts/20151028-175937
> config: x86_64-randconfig-x015-201543 (attached as .config)
> reproduce:
>         # save the attached .config to linux build tree
>         make ARCH=x86_64
> 
> All warnings (new ones prefixed by >>):
> 
>    In file included from fs/f2fs/dir.c:13:0:
>    fs/f2fs/f2fs.h: In function 'f2fs_create_root_stats':
> >> fs/f2fs/f2fs.h:2018:1: warning: no return statement in function returning non-void
> [-Wreturn-type]
>     static inline int __init f2fs_create_root_stats(void) { }
>     ^
> --
>    In file included from fs/f2fs/namei.c:19:0:
>    fs/f2fs/f2fs.h: In function 'f2fs_create_root_stats':
> >> fs/f2fs/f2fs.h:2018:1: warning: no return statement in function returning non-void
> [-Wreturn-type]
>     static inline int __init f2fs_create_root_stats(void) { }
>     ^
>    fs/f2fs/namei.c: In function 'f2fs_symlink':
>    fs/f2fs/namei.c:414:59: warning: 'p_len' may be used uninitialized in this function
> [-Wmaybe-uninitialized]
>       filemap_write_and_wait_range(inode->i_mapping, 0, p_len - 1);
>                                                               ^
> --
>    In file included from fs/f2fs/node.c:19:0:
>    fs/f2fs/f2fs.h: In function 'f2fs_create_root_stats':
> >> fs/f2fs/f2fs.h:2018:1: warning: no return statement in function returning non-void
> [-Wreturn-type]
>     static inline int __init f2fs_create_root_stats(void) { }
>     ^
>    fs/f2fs/node.c: In function 'flush_nat_entries':
>    fs/f2fs/node.c:1920:11: warning: 'nat_blk' may be used uninitialized in this function
> [-Wmaybe-uninitialized]
>        raw_ne = &nat_blk->entries[nid - start_nid];
>               ^
>    fs/f2fs/node.c:1883:25: note: 'nat_blk' was declared here
>      struct f2fs_nat_block *nat_blk;
>                             ^
> 
> vim +2018 fs/f2fs/f2fs.h
> 
>   2002	#define stat_inc_inline_xattr(inode)
>   2003	#define stat_dec_inline_xattr(inode)
>   2004	#define stat_inc_inline_inode(inode)
>   2005	#define stat_dec_inline_inode(inode)
>   2006	#define stat_inc_inline_dir(inode)
>   2007	#define stat_dec_inline_dir(inode)
>   2008	#define stat_inc_seg_type(sbi, curseg)
>   2009	#define stat_inc_block_count(sbi, curseg)
>   2010	#define stat_inc_inplace_blocks(sbi)
>   2011	#define stat_inc_seg_count(sbi, type, gc_type)
>   2012	#define stat_inc_tot_blk_count(si, blks)
>   2013	#define stat_inc_data_blk_count(sbi, blks, gc_type)
>   2014	#define stat_inc_node_blk_count(sbi, blks, gc_type)
>   2015
>   2016	static inline int f2fs_build_stats(struct f2fs_sb_info *sbi) { return 0; }
>   2017	static inline void f2fs_destroy_stats(struct f2fs_sb_info *sbi) { }
> > 2018	static inline int __init f2fs_create_root_stats(void) { }
>   2019	static inline void f2fs_destroy_root_stats(void) { }
>   2020	#endif
>   2021
>   2022	extern const struct file_operations f2fs_dir_operations;
>   2023	extern const struct file_operations f2fs_file_operations;
>   2024	extern const struct inode_operations f2fs_file_inode_operations;
>   2025	extern const struct address_space_operations f2fs_dblock_aops;
>   2026	extern const struct address_space_operations f2fs_node_aops;
> 
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation


------------------------------------------------------------------------------
