From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH] f2fs: don't allow volatile writes for
	non-regular file
Date: Mon, 20 Mar 2017 18:56:13 +0800
Message-ID: <9f786f97-7062-744c-1d52-a831333731f2@huawei.com>
References: <201703192340.5NOXcZia%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <yuchao0@huawei.com>) id 1cpv07-0004VG-GA
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 20 Mar 2017 10:57:23 +0000
Received: from [45.249.212.189] (helo=dggrg03-dlp.huawei.com)
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1cpv05-0002jI-3F
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 20 Mar 2017 10:57:23 +0000
In-Reply-To: <201703192340.5NOXcZia%fengguang.wu@intel.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: kbuild test robot <lkp@intel.com>
Cc: jaegeuk@kernel.org, chao@kernel.org, kbuild-all@01.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

Hello,

Sorry for my mistaken, have fixed and resent the patch.

[PATCH RESEND] f2fs: don't allow volatile writes for non-regular file

Thanks,

On 2017/3/20 0:00, kbuild test robot wrote:
> Hi Chao,
> 
> [auto build test WARNING on f2fs/dev]
> [also build test WARNING on v4.11-rc2 next-20170310]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
> 
> url:    https://github.com/0day-ci/linux/commits/Chao-Yu/f2fs-don-t-allow-volatile-writes-for-non-regular-file/20170319-221605
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git dev
> reproduce:
>         # apt-get install sparse
>         make ARCH=x86_64 allmodconfig
>         make C=1 CF=-D__CHECK_ENDIAN__
> 
> 
> sparse warnings: (new ones prefixed by >>)
> 
>    include/linux/compiler.h:264:8: sparse: attribute 'no_sanitize_address': unknown attribute
>>> fs/f2fs/file.c:1598:14: sparse: incompatible types for operation (&)
>    fs/f2fs/file.c:1598:14:    left side has type struct inode *inode
>    fs/f2fs/file.c:1598:14:    right side has type int
>    fs/f2fs/file.c:1598:14: sparse: incompatible types for operation (==)
>    fs/f2fs/file.c:1598:14:    left side has type bad type
>    fs/f2fs/file.c:1598:14:    right side has type int
>    In file included from include/linux/stat.h:6:0,
>                     from include/linux/fs.h:9,
>                     from fs/f2fs/file.c:11:
>    fs/f2fs/file.c: In function 'f2fs_ioc_start_volatile_write':
>    include/uapi/linux/stat.h:20:26: error: invalid operands to binary & (have 'struct inode *' and 'int')
>     #define S_ISREG(m) (((m) & S_IFMT) == S_IFREG)
>                              ^
>    fs/f2fs/file.c:1598:7: note: in expansion of macro 'S_ISREG'
>      if (!S_ISREG(inode))
>           ^~~~~~~
> 
> vim +1598 fs/f2fs/file.c
> 
>   1582			ret = f2fs_do_sync_file(filp, 0, LLONG_MAX, 0, true);
>   1583		}
>   1584	err_out:
>   1585		inode_unlock(inode);
>   1586		mnt_drop_write_file(filp);
>   1587		return ret;
>   1588	}
>   1589	
>   1590	static int f2fs_ioc_start_volatile_write(struct file *filp)
>   1591	{
>   1592		struct inode *inode = file_inode(filp);
>   1593		int ret;
>   1594	
>   1595		if (!inode_owner_or_capable(inode))
>   1596			return -EACCES;
>   1597	
>> 1598		if (!S_ISREG(inode))
>   1599			return -EINVAL;
>   1600	
>   1601		ret = mnt_want_write_file(filp);
>   1602		if (ret)
>   1603			return ret;
>   1604	
>   1605		inode_lock(inode);
>   1606	
> 
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
> 
> .
> 


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
