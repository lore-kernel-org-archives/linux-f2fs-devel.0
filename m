From: Fengguang Wu <fengguang.wu@intel.com>
Subject: Re: [kbuild-all] [f2fs:dev-test 63/64]
 fs/ext4/readpage.o: warning: objtool: mpage_end_io()+0x53: function has
 unreachable instruction
Date: Wed, 20 Jul 2016 09:11:23 +0800
Message-ID: <20160720011123.GM17027@wfg-t540p.sh.intel.com>
References: <201607192249.hbBy3WQ4%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <fengguang.wu@intel.com>) id 1bPg2v-0006lp-Ai
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 20 Jul 2016 01:11:33 +0000
Received: from mga01.intel.com ([192.55.52.88])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1bPg2t-0005yp-UY for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 20 Jul 2016 01:11:33 +0000
Content-Disposition: inline
In-Reply-To: <201607192249.hbBy3WQ4%fengguang.wu@intel.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Jaegeuk Kim <jaegeuk@kernel.org>, kbuild-all@01.org, linux-f2fs-devel@lists.sourceforge.net

Hi Jaegeuk,

Sorry please ignore this one -- it looks like false warning from old
gcc 4.4 and 4.6 -- we just enabled old compiler tests triggered
thousands of these warnings..

Thanks,
Fengguang

On Tue, Jul 19, 2016 at 10:52:50PM +0800, kbuild test robot wrote:
>tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git dev-test
>head:   c316708435b53448aee2ecec63fcfe495c2a49a9
>commit: 99c6af120d9f452ace3d8712b5ec54fac9b3a3ea [63/64] ext4 crypto: migrate into vfs's crypto engine
>config: x86_64-randconfig-a0-07191719 (attached as .config)
>compiler: gcc-4.4 (Debian 4.4.7-8) 4.4.7
>reproduce:
>        git checkout 99c6af120d9f452ace3d8712b5ec54fac9b3a3ea
>        # save the attached .config to linux build tree
>        make ARCH=x86_64
>
>All warnings (new ones prefixed by >>):
>
>>> fs/ext4/readpage.o: warning: objtool: mpage_end_io()+0x53: function has unreachable instruction
>
>---
>0-DAY kernel test infrastructure                Open Source Technology Center
>https://lists.01.org/pipermail/kbuild-all                   Intel Corporation


>_______________________________________________
>kbuild-all mailing list
>kbuild-all@lists.01.org
>https://lists.01.org/mailman/listinfo/kbuild-all


------------------------------------------------------------------------------
What NetFlow Analyzer can do for you? Monitors network bandwidth and traffic
patterns at an interface-level. Reveals which users, apps, and protocols are 
consuming the most bandwidth. Provides multi-vendor support for NetFlow, 
J-Flow, sFlow and other flows. Make informed decisions using capacity planning
reports.http://sdm.link/zohodev2dev
