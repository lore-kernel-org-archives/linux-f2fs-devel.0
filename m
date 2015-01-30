From: Chao Yu <chao2.yu@samsung.com>
Subject: RE: [f2fs-dev] [PATCH 2/5 v2] f2fs: support norecovery mount option
Date: Fri, 30 Jan 2015 13:11:09 +0800
Message-ID: <006501d03c4b$43aa1c60$cafe5520$@samsung.com>
References: <1422401503-4769-1-git-send-email-jaegeuk@kernel.org>
 <1422401503-4769-2-git-send-email-jaegeuk@kernel.org>
 <002b01d03bba$37f763a0$a7e62ae0$@samsung.com>
 <20150129182745.GB15313@jaegeuk-mac02.mot.com>
 <20150129183102.GC15313@jaegeuk-mac02.mot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <20150129183102.GC15313@jaegeuk-mac02.mot.com>
Content-language: zh-cn
Sender: linux-kernel-owner@vger.kernel.org
To: 'Jaegeuk Kim' <jaegeuk@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

> -----Original Message-----
> From: Jaegeuk Kim [mailto:jaegeuk@kernel.org]
> Sent: Friday, January 30, 2015 2:31 AM
> To: Chao Yu
> Cc: linux-fsdevel@vger.kernel.org; linux-kernel@vger.kernel.org;
> linux-f2fs-devel@lists.sourceforge.net
> Subject: Re: [f2fs-dev] [PATCH 2/5 v2] f2fs: support norecovery mount option
> 
> Change log from v1:
>  o add description for the new mount option in Documentation/filesystems/f2fs.txt
> 
> From 079dbb14c7d91d90863c9be4d9337b8ec086db7e Mon Sep 17 00:00:00 2001
> From: Jaegeuk Kim <jaegeuk@kernel.org>
> Date: Fri, 23 Jan 2015 18:33:46 -0800
> Subject: [PATCH] f2fs: support norecovery mount option
> 
> This patch adds a mount option, norecovery, which is mostly same as
> disable_roll_forward. The only difference is that norecovery should be activated
> with read-only mount option.
> 
> This can be used when user wants to check whether f2fs is mountable or not
> without any recovery process. (e.g., xfstests/200)
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

Reviewed-by: Chao Yu <chao2.yu@samsung.com>
