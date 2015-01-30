From: Chao Yu <chao2.yu@samsung.com>
Subject: RE: [PATCH 1/5 v2] f2fs: fix not to drop mount options when retrying
 fill_super
Date: Fri, 30 Jan 2015 13:02:43 +0800
Message-ID: <006301d03c4a$2883ff10$798bfd30$@samsung.com>
References: <1422401503-4769-1-git-send-email-jaegeuk@kernel.org>
 <002a01d03bb6$530c8340$f92589c0$@samsung.com>
 <20150129181944.GA15313@jaegeuk-mac02.mot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <20150129181944.GA15313@jaegeuk-mac02.mot.com>
Content-language: zh-cn
Sender: linux-kernel-owner@vger.kernel.org
To: 'Jaegeuk Kim' <jaegeuk@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

> -----Original Message-----
> From: Jaegeuk Kim [mailto:jaegeuk@kernel.org]
> Sent: Friday, January 30, 2015 2:21 AM
> To: Chao Yu
> Cc: linux-kernel@vger.kernel.org; linux-fsdevel@vger.kernel.org;
> linux-f2fs-devel@lists.sourceforge.net
> Subject: Re: [PATCH 1/5 v2] f2fs: fix not to drop mount options when retrying fill_super
> 
> Chang log from v1:
>  o fix memory leak pointed by Chao
> 
> From 82760814db6a01539ad15026b0469686110d92bc Mon Sep 17 00:00:00 2001
> From: Jaegeuk Kim <jaegeuk@kernel.org>
> Date: Fri, 23 Jan 2015 17:41:39 -0800
> Subject: [PATCH] f2fs: fix not to drop mount options when retrying fill_super
> 
> If wrong mount option was requested, f2fs tries to fill_super again.
> But, during the next trial, f2fs has no valid mount options, since
> parse_options deleted all the separators in the original string.
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

Reviewed-by: Chao Yu <chao2.yu@samsung.com>
