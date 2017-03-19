From: kbuild test robot <lkp@intel.com>
Subject: Re: [PATCH] f2fs: don't allow volatile writes for
	non-regular file
Date: Mon, 20 Mar 2017 00:00:33 +0800
Message-ID: <201703192340.5NOXcZia%fengguang.wu@intel.com>
References: <20170317033217.5371-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <fengguang.wu@intel.com>) id 1cpdGx-0001Ku-Ti
	for linux-f2fs-devel@lists.sourceforge.net;
	Sun, 19 Mar 2017 16:01:35 +0000
Received: from mga07.intel.com ([134.134.136.100])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1cpdGw-0003a4-2a
	for linux-f2fs-devel@lists.sourceforge.net;
	Sun, 19 Mar 2017 16:01:35 +0000
Content-Disposition: inline
In-Reply-To: <20170317033217.5371-1-yuchao0@huawei.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Chao Yu <yuchao0@huawei.com>
Cc: chao@kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, kbuild-all@01.org, jaegeuk@kernel.org

Hi Chao,

[auto build test WARNING on f2fs/dev]
[also build test WARNING on v4.11-rc2 next-20170310]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Chao-Yu/f2fs-don-t-allow-volatile-writes-for-non-regular-file/20170319-221605
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git dev
reproduce:
        # apt-get install sparse
        make ARCH=x86_64 allmodconfig
        make C=1 CF=-D__CHECK_ENDIAN__


sparse warnings: (new ones prefixed by >>)

   include/linux/compiler.h:264:8: sparse: attribute 'no_sanitize_address': unknown attribute
>> fs/f2fs/file.c:1598:14: sparse: incompatible types for operation (&)
   fs/f2fs/file.c:1598:14:    left side has type struct inode *inode
   fs/f2fs/file.c:1598:14:    right side has type int
   fs/f2fs/file.c:1598:14: sparse: incompatible types for operation (==)
   fs/f2fs/file.c:1598:14:    left side has type bad type
   fs/f2fs/file.c:1598:14:    right side has type int
   In file included from include/linux/stat.h:6:0,
                    from include/linux/fs.h:9,
                    from fs/f2fs/file.c:11:
   fs/f2fs/file.c: In function 'f2fs_ioc_start_volatile_write':
   include/uapi/linux/stat.h:20:26: error: invalid operands to binary & (have 'struct inode *' and 'int')
    #define S_ISREG(m) (((m) & S_IFMT) == S_IFREG)
                             ^
   fs/f2fs/file.c:1598:7: note: in expansion of macro 'S_ISREG'
     if (!S_ISREG(inode))
          ^~~~~~~

vim +1598 fs/f2fs/file.c

  1582			ret = f2fs_do_sync_file(filp, 0, LLONG_MAX, 0, true);
  1583		}
  1584	err_out:
  1585		inode_unlock(inode);
  1586		mnt_drop_write_file(filp);
  1587		return ret;
  1588	}
  1589	
  1590	static int f2fs_ioc_start_volatile_write(struct file *filp)
  1591	{
  1592		struct inode *inode = file_inode(filp);
  1593		int ret;
  1594	
  1595		if (!inode_owner_or_capable(inode))
  1596			return -EACCES;
  1597	
> 1598		if (!S_ISREG(inode))
  1599			return -EINVAL;
  1600	
  1601		ret = mnt_want_write_file(filp);
  1602		if (ret)
  1603			return ret;
  1604	
  1605		inode_lock(inode);
  1606	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
