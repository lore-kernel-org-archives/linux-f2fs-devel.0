From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [f2fs:dev-test 30/30] fs/f2fs/file.c:99:2: error:
 implicit declaration of function '__do_map_lock';
 did you mean '__cond_lock'?
Date: Thu, 27 Sep 2018 11:34:40 +0800
Message-ID: <31ffb5ba-8584-85fa-975c-c6bb405dd40b@huawei.com>
References: <201809271121.vkngRPJR%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <yuchao0@huawei.com>) id 1g5N4r-0001aN-6m
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 27 Sep 2018 03:34:57 +0000
Received: from szxga06-in.huawei.com ([45.249.212.32] helo=huawei.com)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1g5N4n-00C3Ij-67
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 27 Sep 2018 03:34:57 +0000
In-Reply-To: <201809271121.vkngRPJR%fengguang.wu@intel.com>
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
To: kbuild test robot <lkp@intel.com>, Chao Yu <chao@kernel.org>
Cc: Jaegeuk Kim <jaegeuk@kernel.org>, kbuild-all@01.org, linux-f2fs-devel@lists.sourceforge.net

To Jaegeuk,

On 2018/9/27 11:25, kbuild test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git dev-test
> head:   008aecc0a7dd2906168196bd016a547704c2b444
> commit: 008aecc0a7dd2906168196bd016a547704c2b444 [30/30] f2fs: refactor ->page_mkwrite() flow
> config: i386-randconfig-x011-201838 (attached as .config)
> compiler: gcc-7 (Debian 7.3.0-1) 7.3.0
> reproduce:
>         git checkout 008aecc0a7dd2906168196bd016a547704c2b444
>         # save the attached .config to linux build tree
>         make ARCH=i386 
> 
> All errors (new ones prefixed by >>):
> 
>    fs/f2fs/file.c: In function 'f2fs_vm_page_mkwrite':
>>> fs/f2fs/file.c:99:2: error: implicit declaration of function '__do_map_lock'; did you mean '__cond_lock'? [-Werror=implicit-function-declaration]
>      __do_map_lock(sbi, F2FS_GET_BLOCK_PRE_AIO, true);

It relies on below patch which exports that function.

f2fs: guarantee journalled quota data by checkpoint

>      ^~~~~~~~~~~~~
>      __cond_lock
>    cc1: some warnings being treated as errors
> 
> vim +99 fs/f2fs/file.c
> 
>     44	
>     45	static vm_fault_t f2fs_vm_page_mkwrite(struct vm_fault *vmf)
>     46	{
>     47		struct page *page = vmf->page;
>     48		struct inode *inode = file_inode(vmf->vma->vm_file);
>     49		struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
>     50		struct dnode_of_data dn = { .node_changed = false };
>     51		int err;
>     52	
>     53		if (unlikely(f2fs_cp_error(sbi))) {
>     54			err = -EIO;
>     55			goto err;
>     56		}
>     57	
>     58		sb_start_pagefault(inode->i_sb);
>     59	
>     60		f2fs_bug_on(sbi, f2fs_has_inline_data(inode));
>     61	
>     62		file_update_time(vmf->vma->vm_file);
>     63		down_read(&F2FS_I(inode)->i_mmap_sem);
>     64		lock_page(page);
>     65		if (unlikely(page->mapping != inode->i_mapping ||
>     66				page_offset(page) > i_size_read(inode) ||
>     67				!PageUptodate(page))) {
>     68			unlock_page(page);
>     69			err = -EFAULT;
>     70			goto out_sem;
>     71		}
>     72	
>     73		/*
>     74		 * check to see if the page is mapped already (no holes)
>     75		 */
>     76		if (PageMappedToDisk(page))
>     77			goto mapped;
>     78	
>     79		/* page is wholly or partially inside EOF */
>     80		if (((loff_t)(page->index + 1) << PAGE_SHIFT) >
>     81							i_size_read(inode)) {
>     82			loff_t offset;
>     83	
>     84			offset = i_size_read(inode) & ~PAGE_MASK;
>     85			zero_user_segment(page, offset, PAGE_SIZE);
>     86		}
>     87		set_page_dirty(page);
>     88		if (!PageUptodate(page))
>     89			SetPageUptodate(page);
>     90	
>     91		f2fs_update_iostat(sbi, APP_MAPPED_IO, F2FS_BLKSIZE);
>     92	
>     93		trace_f2fs_vm_page_mkwrite(page, DATA);
>     94	mapped:
>     95		/* fill the page */
>     96		f2fs_wait_on_page_writeback(page, DATA, false);
>     97	
>     98		/* block allocation */
>   > 99		__do_map_lock(sbi, F2FS_GET_BLOCK_PRE_AIO, true);
>    100		set_new_dnode(&dn, inode, NULL, NULL, 0);
>    101		err = f2fs_reserve_block(&dn, page->index);
>    102		if (err)
>    103			goto out_unlock;
>    104	
>    105		/* wait for GCed page writeback via META_MAPPING */
>    106		f2fs_wait_on_block_writeback(inode, dn.data_blkaddr);
>    107	
>    108		f2fs_put_dnode(&dn);
>    109	out_unlock:
>    110		__do_map_lock(sbi, F2FS_GET_BLOCK_PRE_AIO, false);
>    111	out_sem:
>    112		up_read(&F2FS_I(inode)->i_mmap_sem);
>    113	
>    114		f2fs_balance_fs(sbi, dn.node_changed);
>    115	
>    116		sb_end_pagefault(inode->i_sb);
>    117		f2fs_update_time(sbi, REQ_TIME);
>    118	err:
>    119		return block_page_mkwrite_return(err);
>    120	}
>    121	
> 
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
> 
