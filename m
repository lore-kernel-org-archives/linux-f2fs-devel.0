From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [f2fs:dev-test 9/9] fs/f2fs/file.c:599:9: error:
 implicit declaration of function 'iomap_zero_range'
Date: Fri, 21 Jul 2017 15:09:59 -0700
Message-ID: <20170721220959.GA22459@jaegeuk-macbookpro.roam.corp.google.com>
References: <201707220508.tlZncFoS%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
 helo=mx.sourceforge.net)
 by sfs-ml-2.v29.ch3.sourceforge.com with esmtps (TLSv1:DHE-RSA-AES256-SHA:256)
 (Exim 4.89) (envelope-from <jaegeuk@kernel.org>) id 1dYg7b-0007Pe-Ql
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 21 Jul 2017 22:10:07 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
 (Exim 4.76) id 1dYg7a-0005k8-5q
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 21 Jul 2017 22:10:07 +0000
Content-Disposition: inline
In-Reply-To: <201707220508.tlZncFoS%fengguang.wu@intel.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: kbuild test robot <fengguang.wu@intel.com>
Cc: linux-f2fs-devel@lists.sourceforge.net, Qiuyang Sun <sunqiuyang@huawei.com>, kbuild-all@01.org

Qiuyang,

I've modified your patch to resolve this, and pushed a new one into f2fs.git.
Could you please check it?

Thanks,

On 07/22, kbuild test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git dev-test
> head:   7f25bbd057c335857559619b4a16738b3ba79db9
> commit: 7f25bbd057c335857559619b4a16738b3ba79db9 [9/9] f2fs: dax: implement direct access
> config: i386-randconfig-x003-07210940 (attached as .config)
> compiler: gcc-6 (Debian 6.2.0-3) 6.2.0 20160901
> reproduce:
>         git checkout 7f25bbd057c335857559619b4a16738b3ba79db9
>         # save the attached .config to linux build tree
>         make ARCH=i386 
> 
> All errors (new ones prefixed by >>):
> 
>    fs/f2fs/file.c: In function 'truncate_partial_data_page':
> >> fs/f2fs/file.c:599:9: error: implicit declaration of function 'iomap_zero_range' [-Werror=implicit-function-declaration]
>       ret = iomap_zero_range(inode, from, PAGE_SIZE - offset,
>             ^~~~~~~~~~~~~~~~
> >> fs/f2fs/file.c:600:11: error: 'f2fs_iomap_ops' undeclared (first use in this function)
>        NULL, &f2fs_iomap_ops);
>               ^~~~~~~~~~~~~~
>    fs/f2fs/file.c:600:11: note: each undeclared identifier is reported only once for each function it appears in
>    fs/f2fs/file.c: In function 'fill_zero':
>    fs/f2fs/file.c:891:16: error: 'f2fs_iomap_ops' undeclared (first use in this function)
>        len, NULL, &f2fs_iomap_ops);
>                    ^~~~~~~~~~~~~~
>    cc1: some warnings being treated as errors
> 
> vim +/iomap_zero_range +599 fs/f2fs/file.c
> 
>    583	
>    584	static int truncate_partial_data_page(struct inode *inode, u64 from,
>    585									bool cache_only)
>    586	{
>    587		unsigned offset = from & (PAGE_SIZE - 1);
>    588		pgoff_t index = from >> PAGE_SHIFT;
>    589		struct address_space *mapping = inode->i_mapping;
>    590		struct page *page;
>    591	
>    592		if (!offset && !cache_only)
>    593			return 0;
>    594	
>    595		if (f2fs_dax_file(inode)) {
>    596			int ret;
>    597	
>    598			down_read(&F2FS_I(inode)->dio_rwsem[WRITE]);
>  > 599			ret = iomap_zero_range(inode, from, PAGE_SIZE - offset,
>  > 600				NULL, &f2fs_iomap_ops);
>    601			up_read(&F2FS_I(inode)->dio_rwsem[WRITE]);
>    602			return ret;
>    603		}
>    604	
>    605		if (cache_only) {
>    606			page = find_lock_page(mapping, index);
>    607			if (page && PageUptodate(page))
>    608				goto truncate_out;
>    609			f2fs_put_page(page, 1);
>    610			return 0;
>    611		}
>    612	
>    613		page = get_lock_data_page(inode, index, true);
>    614		if (IS_ERR(page))
>    615			return PTR_ERR(page) == -ENOENT ? 0 : PTR_ERR(page);
>    616	truncate_out:
>    617		f2fs_wait_on_page_writeback(page, DATA, true);
>    618		zero_user(page, offset, PAGE_SIZE - offset);
>    619	
>    620		/* An encrypted inode should have a key and truncate the last page. */
>    621		f2fs_bug_on(F2FS_I_SB(inode), cache_only && f2fs_encrypted_inode(inode));
>    622		if (!cache_only)
>    623			set_page_dirty(page);
>    624		f2fs_put_page(page, 1);
>    625		return 0;
>    626	}
>    627	
> 
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation



------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
