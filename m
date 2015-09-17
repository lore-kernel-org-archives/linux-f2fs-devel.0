From: Chao Yu <chao2.yu@samsung.com>
Subject: RE: [PATCH 2/7] f2fs: do in batches truncation in truncate_hole
Date: Thu, 17 Sep 2015 20:20:47 +0800
Message-ID: <009a01d0f143$5f5bf7f0$1e13e7d0$@samsung.com>
References: <00f201d0ec5c$8274e670$875eb350$@samsung.com>
 <20150916180112.GB99097@jaegeuk-mac02.mot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <20150916180112.GB99097@jaegeuk-mac02.mot.com>
Content-language: zh-cn
Sender: linux-kernel-owner@vger.kernel.org
To: 'Jaegeuk Kim' <jaegeuk@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

> -----Original Message-----
> From: Jaegeuk Kim [mailto:jaegeuk@kernel.org]
> Sent: Thursday, September 17, 2015 2:01 AM
> To: Chao Yu
> Cc: linux-f2fs-devel@lists.sourceforge.net; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH 2/7] f2fs: do in batches truncation in truncate_hole
> 
> Hi Chao,
> 
> How about changing the original patch slightly like below?
> 
>  o don't have to use index variable
>  o should not skip the entire dnode indices, when one of them is -ENOENT

Agree, thanks for your review! :)

Thanks,
