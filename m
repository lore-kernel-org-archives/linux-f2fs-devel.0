From: Chao Yu <chao2.yu@samsung.com>
Subject: RE: [f2fs-dev] [PATCH] f2fs: don't need to collect dirty sit entries
	and flush journal when there's no dirty sit entries
Date: Sat, 28 Feb 2015 16:59:11 +0800
Message-ID: <019601d05334$f097f640$d1c7e2c0$@samsung.com>
References: <1425027170-21093-1-git-send-email-wanpeng.li@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1425027170-21093-1-git-send-email-wanpeng.li@linux.intel.com>
Content-language: zh-cn
Sender: linux-kernel-owner@vger.kernel.org
To: 'Wanpeng Li' <wanpeng.li@linux.intel.com>, 'Jaegeuk Kim' <jaegeuk@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

> -----Original Message-----
> From: Wanpeng Li [mailto:wanpeng.li@linux.intel.com]
> Sent: Friday, February 27, 2015 4:53 PM
> To: Jaegeuk Kim
> Cc: linux-fsdevel@vger.kernel.org; Wanpeng Li; linux-kernel@vger.kernel.org;
> linux-f2fs-devel@lists.sourceforge.net
> Subject: [f2fs-dev] [PATCH] f2fs: don't need to collect dirty sit entries and flush journal
> when there's no dirty sit entries
> 
>  Don't need to collect dirty sit entries and flush sit journal to sit
>  entries when there's no dirty sit entries. This patch check dirty_sentries
>  earlier just like flush_nat_entries.
> 
> Signed-off-by: Wanpeng Li <wanpeng.li@linux.intel.com>

Reviewed-by: Chao Yu <chao2.yu@samsung.com>
