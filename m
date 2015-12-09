From: Chao Yu <chao2.yu@samsung.com>
Subject: RE: [f2fs-dev] [PATCH 2/3] f2fs: refactor f2fs_commit_super
Date: Wed, 09 Dec 2015 14:08:41 +0800
Message-ID: <015001d13248$27f1fee0$77d5fca0$@samsung.com>
References: <1449528805-89661-1-git-send-email-jaegeuk@kernel.org>
 <1449528805-89661-2-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1449528805-89661-2-git-send-email-jaegeuk@kernel.org>
Content-language: zh-cn
Sender: linux-kernel-owner@vger.kernel.org
To: 'Jaegeuk Kim' <jaegeuk@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

> -----Original Message-----
> From: Jaegeuk Kim [mailto:jaegeuk@kernel.org]
> Sent: Tuesday, December 08, 2015 6:53 AM
> To: linux-kernel@vger.kernel.org; linux-fsdevel@vger.kernel.org;
> linux-f2fs-devel@lists.sourceforge.net
> Cc: Jaegeuk Kim
> Subject: [f2fs-dev] [PATCH 2/3] f2fs: refactor f2fs_commit_super
> 
> Previously, f2fs_commit_super hacks the bh->blocknr to write the broken
> alternate superblock.
> Instead of it, we should use the correct logic to retrieve its buffer head
> with locking it appropriately.
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

Reviewed-by: Chao Yu <chao2.yu@samsung.com>
