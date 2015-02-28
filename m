From: Chao Yu <chao2.yu@samsung.com>
Subject: RE: [PATCH v2] f2fs: fix max orphan inodes calculation
Date: Sat, 28 Feb 2015 17:00:29 +0800
Message-ID: <019701d05335$29150580$7b3f1080$@samsung.com>
References: <1425029893-24702-1-git-send-email-wanpeng.li@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1425029893-24702-1-git-send-email-wanpeng.li@linux.intel.com>
Content-language: zh-cn
Sender: linux-kernel-owner@vger.kernel.org
To: 'Wanpeng Li' <wanpeng.li@linux.intel.com>, 'Jaegeuk Kim' <jaegeuk@kernel.org>
Cc: 'Changman Lee' <cm224.lee@samsung.com>, linux-f2fs-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

> -----Original Message-----
> From: Wanpeng Li [mailto:wanpeng.li@linux.intel.com]
> Sent: Friday, February 27, 2015 5:38 PM
> To: Jaegeuk Kim
> Cc: Changman Lee; Chao Yu; linux-f2fs-devel@lists.sourceforge.net;
> linux-fsdevel@vger.kernel.org; linux-kernel@vger.kernel.org; Wanpeng Li
> Subject: [PATCH v2] f2fs: fix max orphan inodes calculation
> 
> cp_payload is introduced for sit bitmap to support large volume, and it is
> just after the block of f2fs_checkpoint + nat bitmap, so the first segment
> should include F2FS_CP_PACKS + NR_CURSEG_TYPE + cp_payload + orphan blocks.
> However, current max orphan inodes calculation don't consider cp_payload,
> this patch fix it by reducing the number of cp_payload from total blocks of
> the first segment when calculate max orphan inodes.
> 
> Signed-off-by: Wanpeng Li <wanpeng.li@linux.intel.com>

Reviewed-by: Chao Yu <chao2.yu@samsung.com>
