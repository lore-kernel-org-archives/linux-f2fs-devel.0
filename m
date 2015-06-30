From: Chao Yu <chao2.yu@samsung.com>
Subject: RE: [f2fs-dev] [PATCH 02/12] f2fs: avoid to use failed inode
 immediately
Date: Tue, 30 Jun 2015 10:54:21 +0800
Message-ID: <00e301d0b2e0$34a7b950$9df72bf0$@samsung.com>
References: <1435603176-63219-1-git-send-email-jaegeuk@kernel.org>
 <1435603176-63219-2-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-reply-to: <1435603176-63219-2-git-send-email-jaegeuk@kernel.org>
Content-language: zh-cn
Sender: linux-fsdevel-owner@vger.kernel.org
To: 'Jaegeuk Kim' <jaegeuk@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

> -----Original Message-----
> From: Jaegeuk Kim [mailto:jaegeuk@kernel.org]
> Sent: Tuesday, June 30, 2015 2:39 AM
> To: linux-kernel@vger.kernel.org; linux-fsdevel@vger.kernel.org;
> linux-f2fs-devel@lists.sourceforge.net
> Cc: Jaegeuk Kim
> Subject: [f2fs-dev] [PATCH 02/12] f2fs: avoid to use failed inode immediately
> 
> Before iput is called, the inode number used by a bad inode can be reassigned
> to other new inode, resulting in any abnormal behaviors on the new inode.
> This should not happen for the new inode.

Nice catch!

Reviewed-by: Chao Yu <chao2.yu@samsung.com>

