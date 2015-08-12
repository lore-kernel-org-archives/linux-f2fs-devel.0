From: Chao Yu <chao2.yu@samsung.com>
Subject: RE: [f2fs-dev] [PATCH 2/2 v2] f2fs: skip checkpoint if there is no
 dirty segments
Date: Wed, 12 Aug 2015 17:43:29 +0800
Message-ID: <00b701d0d4e3$718ee800$54acb800$@samsung.com>
References: <1439256205-8906-1-git-send-email-jaegeuk@kernel.org>
 <1439256205-8906-2-git-send-email-jaegeuk@kernel.org>
 <20150812050916.GA22780@jaegeuk-mac02.hsd1.ca.comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <20150812050916.GA22780@jaegeuk-mac02.hsd1.ca.comcast.net>
Content-language: zh-cn
Sender: linux-kernel-owner@vger.kernel.org
To: 'Jaegeuk Kim' <jaegeuk@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

> -----Original Message-----
> From: Jaegeuk Kim [mailto:jaegeuk@kernel.org]
> Sent: Wednesday, August 12, 2015 1:09 PM
> To: linux-kernel@vger.kernel.org; linux-fsdevel@vger.kernel.org;
> linux-f2fs-devel@lists.sourceforge.net
> Subject: Re: [f2fs-dev] [PATCH 2/2 v2] f2fs: skip checkpoint if there is no dirty segments
> 
> Change log from v1:
>  - fix skipping gc incorrectly
> 
> >From 06f90d3757a6b7ff524cc112168488f31bbf830f Mon Sep 17 00:00:00 2001
> From: Jaegeuk Kim <jaegeuk@kernel.org>
> Date: Tue, 11 Aug 2015 21:59:49 -0700
> Subject: [PATCH] f2fs: skip checkpoint if there is no dirty and prefree
>  segments
> 
> We should avoid needless checkpoints when there is no dirty and prefree segment.
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

Reviewed-by: Chao Yu <chao2.yu@samsung.com>
