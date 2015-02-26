From: Chao Yu <chao2.yu@samsung.com>
Subject: RE: [f2fs-dev] [PATCH 2/2] f2fs: fix the number of orphan inode blocks
Date: Thu, 26 Feb 2015 09:33:55 +0800
Message-ID: <013201d05164$637b7880$2a726980$@samsung.com>
References: <1424908641-76409-1-git-send-email-wanpeng.li@linux.intel.com>
 <1424908641-76409-2-git-send-email-wanpeng.li@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1424908641-76409-2-git-send-email-wanpeng.li@linux.intel.com>
Content-language: zh-cn
Sender: linux-kernel-owner@vger.kernel.org
To: 'Wanpeng Li' <wanpeng.li@linux.intel.com>, 'Jaegeuk Kim' <jaegeuk@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

Hi Wanpeng,

> -----Original Message-----
> From: Wanpeng Li [mailto:wanpeng.li@linux.intel.com]
> Sent: Thursday, February 26, 2015 7:57 AM
> To: Jaegeuk Kim
> Cc: Wanpeng Li; linux-kernel@vger.kernel.org; linux-f2fs-devel@lists.sourceforge.net
> Subject: [f2fs-dev] [PATCH 2/2] f2fs: fix the number of orphan inode blocks
> 
> cp_pack_start_sum is calculated in do_checkpoint and is equal to
> cpu_to_le32(1 + cp_payload_blks + orphan_blocks). The number of
> orphan inode blocks is take advantage of by recover_orphan_inodes
> to readahead meta pages and recovery inodes. However, current codes
> forget to reduce the number of cp payload blocks when calculate
> the number of orphan inode blocks. This patch fix it.

Nice work! looks good to me. :)

> 
> Signed-off-by: Wanpeng Li <wanpeng.li@linux.intel.com>

Reviewed-by: Chao Yu <chao2.yu@samsung.com>
