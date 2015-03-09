From: Chao Yu <chao2.yu@samsung.com>
Subject: RE: [PATCH 1/2] f2fs: fix extent cache memory leak
Date: Mon, 09 Mar 2015 10:30:18 +0800
Message-ID: <004601d05a11$1af593b0$50e0bb10$@samsung.com>
References: <1425625255-4204-1-git-send-email-wanpeng.li@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1425625255-4204-1-git-send-email-wanpeng.li@linux.intel.com>
Content-language: zh-cn
Sender: linux-kernel-owner@vger.kernel.org
To: 'Wanpeng Li' <wanpeng.li@linux.intel.com>, 'Jaegeuk Kim' <jaegeuk@kernel.org>
Cc: 'Changman Lee' <cm224.lee@samsung.com>, linux-f2fs-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

Hi Wanpeng,

> -----Original Message-----
> From: Wanpeng Li [mailto:wanpeng.li@linux.intel.com]
> Sent: Friday, March 06, 2015 3:01 PM
> To: Jaegeuk Kim
> Cc: Changman Lee; Chao Yu; linux-f2fs-devel@lists.sourceforge.net;
> linux-fsdevel@vger.kernel.org; linux-kernel@vger.kernel.org; Wanpeng Li
> Subject: [PATCH 1/2] f2fs: fix extent cache memory leak
> 
> extent tree/node slab cache is created during f2fs insmod,
> how, it isn't destroyed during f2fs rmmod, this patch fix
> it by destroy extent tree/node slab cache once rmmod f2fs.

This is my bad, thanks for your catching and fixing.

> 
> Signed-off-by: Wanpeng Li <wanpeng.li@linux.intel.com>

Reviewed-by: Chao Yu <chao2.yu@samsung.com>
