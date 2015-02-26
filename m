From: Chao Yu <chao2.yu@samsung.com>
Subject: RE: [f2fs-dev] [PATCH 2/2] f2fs: avoid wrong error during recovery
Date: Thu, 26 Feb 2015 09:15:13 +0800
Message-ID: <013001d05161$ca5fd4e0$5f1f7ea0$@samsung.com>
References: <1424900845-54141-1-git-send-email-jaegeuk@kernel.org>
 <1424900845-54141-2-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-reply-to: <1424900845-54141-2-git-send-email-jaegeuk@kernel.org>
Content-language: zh-cn
Sender: linux-fsdevel-owner@vger.kernel.org
To: 'Jaegeuk Kim' <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: 'Jaegeuk Kim' <jaegeuk@motorola.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

> -----Original Message-----
> From: Jaegeuk Kim [mailto:jaegeuk@kernel.org]
> Sent: Thursday, February 26, 2015 5:47 AM
> To: linux-kernel@vger.kernel.org; linux-fsdevel@vger.kernel.org;
> linux-f2fs-devel@lists.sourceforge.net
> Cc: Jaegeuk Kim
> Subject: [f2fs-dev] [PATCH 2/2] f2fs: avoid wrong error during recovery
> 
> From: Jaegeuk Kim <jaegeuk@motorola.com>
> 
> During the roll-forward recovery, -ENOENT for f2fs_iget can be skipped.
> So, this error value should not be propagated.
> 
> Change-Id: I230ad2371e3fb4b9df42059c4a61f92c1f9838de
> Signed-off-by: Jaegeuk Kim <jaegeuk@motorola.com>

Reviewed-by: Chao Yu <chao2.yu@samsung.com>

