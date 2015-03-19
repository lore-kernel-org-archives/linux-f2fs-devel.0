From: Chao Yu <chao2.yu@samsung.com>
Subject: RE: [f2fs-dev] [PATCH 2/4 v2] f2fs: set buffer_new when new blocks are
 allocated
Date: Thu, 19 Mar 2015 19:18:44 +0800
Message-ID: <009d01d06236$91bd9060$b538b120$@samsung.com>
References: <1426611461-690-1-git-send-email-jaegeuk@kernel.org>
 <1426611461-690-2-git-send-email-jaegeuk@kernel.org>
 <006e01d06122$bce68270$36b38750$@samsung.com>
 <20150318175700.GA7461@jaegeuk-mac02>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-reply-to: <20150318175700.GA7461@jaegeuk-mac02>
Content-language: zh-cn
Sender: linux-fsdevel-owner@vger.kernel.org
To: 'Jaegeuk Kim' <jaegeuk@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

> -----Original Message-----
> From: Jaegeuk Kim [mailto:jaegeuk@kernel.org]
> Sent: Thursday, March 19, 2015 1:57 AM
> To: Chao Yu
> Cc: linux-kernel@vger.kernel.org; linux-fsdevel@vger.kernel.org;
> linux-f2fs-devel@lists.sourceforge.net
> Subject: Re: [f2fs-dev] [PATCH 2/4 v2] f2fs: set buffer_new when new blocks are allocated
> 
> Hi Chao,
> 
> Thanks for the review.
> 
> Change log from v1:
>  o add clear_buffer_new() in f2fs_map_bh
> 
> This patch modifies to call set_buffer_new, if new blocks are allocated.
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

Reviewed-by: Chao Yu <chao2.yu@samsung.com>

