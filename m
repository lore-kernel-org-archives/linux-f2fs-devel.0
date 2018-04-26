From: kbuild test robot <lkp@intel.com>
Subject: [f2fs:dev-test 40/41] fs/f2fs/segment.c:1601:6: sparse:
 symbol 'release_discard_addr' was not declared. Should it be static?
Date: Fri, 27 Apr 2018 03:57:31 +0800
Message-ID: <201804270303.VPJ9nTL4%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <fengguang.wu@intel.com>) id 1fBn2H-0007pO-I0
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 26 Apr 2018 19:58:33 +0000
Received: from mga09.intel.com ([134.134.136.24])
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1fBn2B-00DCA3-69
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 26 Apr 2018 19:58:33 +0000
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
head:   57ef368c8663e2198fadc0cfecdf67e0fe11e65a
commit: 6f89409e87ce2a41baa5650c978857f306c02859 [40/41] f2fs: introduce release_discard_addr() for cleanup
reproduce:
        # apt-get install sparse
        git checkout 6f89409e87ce2a41baa5650c978857f306c02859
        make ARCH=x86_64 allmodconfig
        make C=1 CF=-D__CHECK_ENDIAN__


sparse warnings: (new ones prefixed by >>)

   fs/f2fs/segment.c:1052:26: sparse: expression using sizeof(void)
   fs/f2fs/segment.c:1052:26: sparse: expression using sizeof(void)
>> fs/f2fs/segment.c:1601:6: sparse: symbol 'release_discard_addr' was not declared. Should it be static?
   fs/f2fs/segment.c:2420:27: sparse: expression using sizeof(void)
   fs/f2fs/segment.h:373:28: sparse: expression using sizeof(void)
   fs/f2fs/segment.h:373:28: sparse: expression using sizeof(void)
   fs/f2fs/segment.c:3368:36: sparse: expression using sizeof(void)
   fs/f2fs/segment.c:3368:36: sparse: expression using sizeof(void)

Please review and possibly fold the followup patch.

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
