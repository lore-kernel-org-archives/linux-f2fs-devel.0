From: kbuild test robot <fengguang.wu@intel.com>
Subject: [f2fs:dev-test 24/27] fs/f2fs/data.c:1136:5: sparse:
 symbol 'f2fs_write_cache_pages' was not declared. Should it be static?
Date: Tue, 14 Jul 2015 08:23:34 +0800
Message-ID: <201507140816.NqM3qfvR%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <fengguang.wu@intel.com>) id 1ZEo17-0005pn-32
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 14 Jul 2015 00:24:13 +0000
Received: from mga02.intel.com ([134.134.136.20])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1ZEo16-0006RX-AM for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 14 Jul 2015 00:24:13 +0000
Content-Disposition: inline
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Chao Yu <chao2.yu@samsung.com>
Cc: Jaegeuk Kim <jaegeuk@kernel.org>, kbuild-all@01.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs dev-test
head:   ac8132095a69bd62e30a505212627e2657740452
commit: 7e4a4d93dd6faf05d6201423d21ae8a00e538a2c [24/27] f2fs: expose f2fs_write_cache_pages
reproduce:
  # apt-get install sparse
  git checkout 7e4a4d93dd6faf05d6201423d21ae8a00e538a2c
  make ARCH=x86_64 allmodconfig
  make C=1 CF=-D__CHECK_ENDIAN__


sparse warnings: (new ones prefixed by >>)

>> fs/f2fs/data.c:1136:5: sparse: symbol 'f2fs_write_cache_pages' was not declared. Should it be static?

Please review and possibly fold the followup patch.

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

------------------------------------------------------------------------------
Don't Limit Your Business. Reach for the Cloud.
GigeNET's Cloud Solutions provide you with the tools and support that
you need to offload your IT needs and focus on growing your business.
Configured For All Businesses. Start Your Cloud Today.
https://www.gigenetcloud.com/
