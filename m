From: Chao Yu <chao2.yu@samsung.com>
Subject: RE: [f2fs-dev] [PATCH 1/2] f2fs: trigger correct checkpoint during
	umount
Date: Fri, 23 Jan 2015 18:37:04 +0800
Message-ID: <000401d036f8$a3530260$e9f90720$@samsung.com>
References: <1421971730-17024-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1421971730-17024-1-git-send-email-jaegeuk@kernel.org>
Content-language: zh-cn
Sender: linux-kernel-owner@vger.kernel.org
To: 'Jaegeuk Kim' <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

> -----Original Message-----
> From: Jaegeuk Kim [mailto:jaegeuk@kernel.org]
> Sent: Friday, January 23, 2015 8:09 AM
> To: linux-kernel@vger.kernel.org; linux-fsdevel@vger.kernel.org;
> linux-f2fs-devel@lists.sourceforge.net
> Cc: Jaegeuk Kim
> Subject: [f2fs-dev] [PATCH 1/2] f2fs: trigger correct checkpoint during umount
> 
> This patch fixes to trigger checkpoint with umount flag when kill_sb was called.
> In kill_sb, f2fs_sync_fs was finally called, but at this time, f2fs can't do
> checkpoint with CP_UMOUNT.
> After then, f2fs_put_super is not doing checkpoint, since it is not dirty.
> 
> So, this patch adds a flag to indicate f2fs_sync_fs is called during umount.

Nice catch!

> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

Reviewed-by: Chao Yu <chao2.yu@samsung.com>
