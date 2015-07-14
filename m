From: Chao Yu <chao2.yu@samsung.com>
Subject: RE: [f2fs:dev-test 24/27] fs/f2fs/data.c:1136:5: sparse: symbol
 'f2fs_write_cache_pages' was not declared. Should it be static?
Date: Tue, 14 Jul 2015 18:11:55 +0800
Message-ID: <00f301d0be1d$a15ed4a0$e41c7de0$@samsung.com>
References: <201507140816.NqM3qfvR%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <201507140816.NqM3qfvR%fengguang.wu@intel.com>
Content-language: zh-cn
Sender: linux-kernel-owner@vger.kernel.org
To: 'kbuild test robot' <fengguang.wu@intel.com>
Cc: kbuild-all@01.org, 'Jaegeuk Kim' <jaegeuk@kernel.org>, 'Changman Lee' <cm224.lee@samsung.com>, linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

Hi Fengguang,

Thanks for your reminder. Issue was fixed.

Regards,

> -----Original Message-----
> From: kbuild test robot [mailto:fengguang.wu@intel.com]
> Sent: Tuesday, July 14, 2015 8:24 AM
> To: Chao Yu
> Cc: kbuild-all@01.org; Jaegeuk Kim; Changman Lee; linux-f2fs-devel@lists.sourceforge.net;
> linux-kernel@vger.kernel.org
> Subject: [f2fs:dev-test 24/27] fs/f2fs/data.c:1136:5: sparse: symbol 'f2fs_write_cache_pages'
> was not declared. Should it be static?
> 
> tree:   git://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs dev-test
> head:   ac8132095a69bd62e30a505212627e2657740452
> commit: 7e4a4d93dd6faf05d6201423d21ae8a00e538a2c [24/27] f2fs: expose f2fs_write_cache_pages
> reproduce:
>   # apt-get install sparse
>   git checkout 7e4a4d93dd6faf05d6201423d21ae8a00e538a2c
>   make ARCH=x86_64 allmodconfig
>   make C=1 CF=-D__CHECK_ENDIAN__
> 
> 
> sparse warnings: (new ones prefixed by >>)
> 
> >> fs/f2fs/data.c:1136:5: sparse: symbol 'f2fs_write_cache_pages' was not declared. Should it
> be static?
> 
> Please review and possibly fold the followup patch.
> 
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
