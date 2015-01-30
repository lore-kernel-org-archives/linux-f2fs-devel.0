From: Chao Yu <chao2.yu@samsung.com>
Subject: RE: [PATCH 4/5] f2fs: should fail mount when trying to recover data on
 read-only dev
Date: Fri, 30 Jan 2015 13:12:10 +0800
Message-ID: <006601d03c4b$68190bb0$384b2310$@samsung.com>
References: <1422401503-4769-1-git-send-email-jaegeuk@kernel.org>
 <1422401503-4769-4-git-send-email-jaegeuk@kernel.org>
 <002d01d03bbd$8b533c10$a1f9b430$@samsung.com>
 <20150129213931.GA17521@jaegeuk-mac02>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <20150129213931.GA17521@jaegeuk-mac02>
Content-language: zh-cn
Sender: linux-kernel-owner@vger.kernel.org
To: 'Jaegeuk Kim' <jaegeuk@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

Hi Jaegeuk,

> -----Original Message-----
> From: Jaegeuk Kim [mailto:jaegeuk@kernel.org]
> Sent: Friday, January 30, 2015 5:40 AM
> To: Chao Yu
> Cc: linux-kernel@vger.kernel.org; linux-fsdevel@vger.kernel.org;
> linux-f2fs-devel@lists.sourceforge.net
> Subject: Re: [PATCH 4/5] f2fs: should fail mount when trying to recover data on read-only dev
> 
> Hi Chao,
> 
> This is another patch to fix that.
> 
> From d241924043778d0fe01e9020d5771cc42cf246e6 Mon Sep 17 00:00:00 2001
> From: Jaegeuk Kim <jaegeuk@kernel.org>
> Date: Thu, 29 Jan 2015 11:45:33 -0800
> Subject: [PATCH] f2fs: split UMOUNT and FASTBOOT flags
> 
> This patch adds FASTBOOT flag into checkpoint as follows.
> 
>  - CP_UMOUNT_FLAG is set when system is umounted.
>  - CP_FASTBOOT_FLAG is set when intermediate checkpoint having node summaries
>    was done.
> 
> So, if you get CP_UMOUNT_FLAG from checkpoint, the system was umounted cleanly.
> Instead, if there was sudden-power-off, you can get CP_FASTBOOT_FLAG or nothing.

Nice work, it looks good to me, and this can fix that issue. :)

> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

Reviewed-by: Chao Yu <chao2.yu@samsung.com>
