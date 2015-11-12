From: Chao Yu <chao2.yu@samsung.com>
Subject: RE: [f2fs-dev]  [PATCH] f2fs: optimize __find_rev_next_bit
Date: Thu, 12 Nov 2015 18:36:29 +0800
Message-ID: <022201d11d36$17f24d50$47d6e7f0$@samsung.com>
References: <000001d11ce3$2f947f30$8ebd7d90$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <000001d11ce3$2f947f30$8ebd7d90$@samsung.com>
Content-language: zh-cn
Sender: linux-kernel-owner@vger.kernel.org
To: 'Fan Li' <fanofcode.li@samsung.com>, 'Jaegeuk Kim' <jaegeuk@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

Hi Fan,

> -----Original Message-----
> From: Fan Li [mailto:fanofcode.li@samsung.com]
> Sent: Thursday, November 12, 2015 8:43 AM
> To: 'Jaegeuk Kim'
> Cc: linux-kernel@vger.kernel.org; linux-f2fs-devel@lists.sourceforge.net
> Subject: [f2fs-dev] [PATCH] f2fs: optimize __find_rev_next_bit
> 
> 1. Skip __reverse_ulong if the bitmap is empty.
> 2. Reduce branches and codes.
> According to my test, the performance of this new version is 5% higher on
> an empty bitmap of 64bytes, and remains about the same in the worst scenario.

Good catch!

IMO, it's better to optimize __find_rev_next_{,zero}bit together. :)

Thanks,
