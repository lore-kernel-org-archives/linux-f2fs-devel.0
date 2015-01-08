From: kbuild test robot <fengguang.wu@intel.com>
Subject: [f2fs:linux-3.4 31/33] fs/f2fs/trace.c:19:12: sparse: symbol
 'pids_lock' was not declared. Should it be static?
Date: Fri, 9 Jan 2015 03:38:38 +0800
Message-ID: <201501090312.wCG4mLHp%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: kbuild-all@01.org, Changman Lee <cm224.lee@samsung.com>, linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs linux-3.4
head:   a725baf7b8472a0b97dc12ed4d1c147cad2f3e8c
commit: 37a78eb5019798c94d4543c48e1d6490a552e1c7 [31/33] f2fs: add spin_lock to cover radix operations in IO tracer
reproduce:
  # apt-get install sparse
  git checkout 37a78eb5019798c94d4543c48e1d6490a552e1c7
  make ARCH=x86_64 allmodconfig
  make C=1 CF=-D__CHECK_ENDIAN__


sparse warnings: (new ones prefixed by >>)

>> fs/f2fs/trace.c:19:12: sparse: symbol 'pids_lock' was not declared. Should it be static?

Please review and possibly fold the followup patch.

---
0-DAY kernel test infrastructure                Open Source Technology Center
http://lists.01.org/mailman/listinfo/kbuild                 Intel Corporation
