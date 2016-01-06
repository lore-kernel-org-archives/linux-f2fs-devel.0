From: Chao Yu <chao2.yu@samsung.com>
Subject: RE: [f2fs-dev] [PATCH 1/3 v2] f2fs: check the page status filled	from
 disk
Date: Wed, 06 Jan 2016 13:20:29 +0800
Message-ID: <010b01d14842$0f7aea10$2e70be30$@samsung.com>
References: <1451784366-14261-1-git-send-email-jaegeuk@kernel.org>
 <20160106040727.GA8472@jaegeuk.gateway>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-reply-to: <20160106040727.GA8472@jaegeuk.gateway>
Content-language: zh-cn
Sender: linux-fsdevel-owner@vger.kernel.org
To: 'Jaegeuk Kim' <jaegeuk@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

Hi Jaegeuk,

> -----Original Message-----
> From: Jaegeuk Kim [mailto:jaegeuk@kernel.org]
> Sent: Wednesday, January 06, 2016 12:11 PM
> To: linux-kernel@vger.kernel.org; linux-fsdevel@vger.kernel.org;
> linux-f2fs-devel@lists.sourceforge.net
> Subject: Re: [f2fs-dev] [PATCH 1/3 v2] f2fs: check the page status filled from disk
> 
> Change log from v1:
>  - use get_lock_data_page and return error, suggested by Chao
> 
> >From 4882f227e71b482c53e55a5c3ad559d33f620a20 Mon Sep 17 00:00:00 2001
> From: Jaegeuk Kim <jaegeuk@kernel.org>
> Date: Fri, 1 Jan 2016 22:03:47 -0800
> Subject: [PATCH] f2fs: check the page status filled from disk
> 
> After reading a page, we need to check whether there is any error.
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

Looks good to me! :)

Reviewed-by: Chao Yu <chao2.yu@samsung.com>

