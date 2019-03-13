From: kbuild test robot <lkp@intel.com>
Subject: [f2fs:dev-test 54/55] fs/f2fs/data.c:520:6: sparse:
 symbol 'f2fs_submit_ipu_bio' was not declared. Should it be static?
Date: Thu, 14 Mar 2019 07:53:58 +0800
Message-ID: <201903140706.NPV5nM0E%lkp@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <lkp@intel.com>) id 1h4Dhk-00048w-Nc
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 13 Mar 2019 23:54:36 +0000
Received: from mga09.intel.com ([134.134.136.24])
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1h4Dhi-00GvPN-S7
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 13 Mar 2019 23:54:36 +0000
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
head:   9487ae9b5821c0fa47c53b7ced0ee3256d4c5117
commit: 60686faa1e20c6f221aad9f93a6f263faaf8cd76 [54/55] f2fs: add bio cache for IPU
reproduce:
        # apt-get install sparse
        git checkout 60686faa1e20c6f221aad9f93a6f263faaf8cd76
        make ARCH=x86_64 allmodconfig
        make C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__'


sparse warnings: (new ones prefixed by >>)

   fs/f2fs/data.c:423:47: sparse: Using plain integer as NULL pointer
>> fs/f2fs/data.c:520:6: sparse: symbol 'f2fs_submit_ipu_bio' was not declared. Should it be static?
   fs/f2fs/data.c:618:35: sparse: expression using sizeof(void)
   fs/f2fs/data.c:1099:30: sparse: expression using sizeof(void)
   fs/f2fs/data.c:1099:30: sparse: expression using sizeof(void)

Please review and possibly fold the followup patch.

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
