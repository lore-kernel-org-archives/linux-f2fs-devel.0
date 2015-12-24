From: Chao Yu <chao2.yu@samsung.com>
Subject: RE: [f2fs-dev] [PATCH 3/4 v2] f2fs: record node block allocation in
 dnode_of_data
Date: Thu, 24 Dec 2015 09:35:02 +0800
Message-ID: <013901d13deb$68740d60$395c2820$@samsung.com>
References: <1450832388-29118-1-git-send-email-jaegeuk@kernel.org>
 <1450832388-29118-3-git-send-email-jaegeuk@kernel.org>
 <20151223190017.GC30505@jaegeuk.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <20151223190017.GC30505@jaegeuk.local>
Content-language: zh-cn
Sender: linux-kernel-owner@vger.kernel.org
To: 'Jaegeuk Kim' <jaegeuk@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

> -----Original Message-----
> From: Jaegeuk Kim [mailto:jaegeuk@kernel.org]
> Sent: Thursday, December 24, 2015 3:00 AM
> To: linux-kernel@vger.kernel.org; linux-fsdevel@vger.kernel.org;
> linux-f2fs-devel@lists.sourceforge.net
> Subject: Re: [f2fs-dev] [PATCH 3/4 v2] f2fs: record node block allocation in dnode_of_data
> 
> Change log from v1:
>  - remove redundant set
>  - adjust memory alignment
> 
> >From 60c6a898094535e850268dd77701255a37cce3d3 Mon Sep 17 00:00:00 2001
> From: Jaegeuk Kim <jaegeuk@kernel.org>
> Date: Tue, 22 Dec 2015 12:59:54 -0800
> Subject: [PATCH] f2fs: record node block allocation in dnode_of_data
> 
> This patch introduces recording node block allocation in dnode_of_data.
> This information helps to figure out whether any node block is allocated during
> specific file operations.
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

Reviewed-by: Chao Yu <chao2.yu@samsung.com>
