From: kbuild test robot <lkp@intel.com>
Subject: [f2fs:dev-test 15/41]
 include/trace/events/f2fs.h:1287:1: sparse: sparse: cast to restricted
 vm_fault_t
Date: Wed, 24 Apr 2019 09:26:48 +0800
Message-ID: <201904240946.5kYJ7xld%lkp@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <lkp@intel.com>) id 1hJ6gt-0005Jz-Qh
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 24 Apr 2019 01:27:15 +0000
Received: from mga05.intel.com ([192.55.52.43])
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1hJ6gr-00948u-SY
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 24 Apr 2019 01:27:15 +0000
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
To: Chao Yu <yuchao0@huawei.com>, Chao Yu <chao@kernel.org>
Cc: Jaegeuk Kim <jaegeuk@kernel.org>, kbuild-all@01.org, linux-f2fs-devel@lists.sourceforge.net

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git dev-test
head:   2f7ea3581030c1a146db350dc5d3bf068861145b
commit: 93ed4e0804b3b5e9dc7e2cfe522b0a407ab7198c [15/41] f2fs: add tracepoint for f2fs_filemap_fault()
reproduce:
        # apt-get install sparse
        git checkout 93ed4e0804b3b5e9dc7e2cfe522b0a407ab7198c
        make ARCH=x86_64 allmodconfig
        make C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__'

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>



sparse warnings: (new ones prefixed by >>)

>> include/trace/events/f2fs.h:1287:1: sparse: sparse: cast to restricted vm_fault_t
>> include/trace/events/f2fs.h:1287:1: sparse: sparse: cast to restricted vm_fault_t
>> include/trace/events/f2fs.h:1287:1: sparse: sparse: restricted vm_fault_t degrades to integer
>> include/trace/events/f2fs.h:1287:1: sparse: sparse: restricted vm_fault_t degrades to integer
   include/asm-generic/atomic-instrumented.h:239:26: sparse: sparse: context imbalance in 'f2fs_drop_inode' - unexpected unlock

vim +1287 include/trace/events/f2fs.h

  1286	
> 1287	TRACE_EVENT(f2fs_filemap_fault,
  1288	
  1289		TP_PROTO(struct inode *inode, pgoff_t index, enum vm_fault_reason ret),
  1290	
  1291		TP_ARGS(inode, index, ret),
  1292	
  1293		TP_STRUCT__entry(
  1294			__field(dev_t,	dev)
  1295			__field(ino_t,	ino)
  1296			__field(pgoff_t, index)
  1297			__field(enum vm_fault_reason, ret)
  1298		),
  1299	
  1300		TP_fast_assign(
  1301			__entry->dev	= inode->i_sb->s_dev;
  1302			__entry->ino	= inode->i_ino;
  1303			__entry->index	= index;
  1304			__entry->ret	= ret;
  1305		),
  1306	
  1307		TP_printk("dev = (%d,%d), ino = %lu, index = %lu, ret = %u",
  1308			show_dev_ino(__entry),
  1309			(unsigned long)__entry->index,
  1310			ret)
  1311	);
  1312	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
