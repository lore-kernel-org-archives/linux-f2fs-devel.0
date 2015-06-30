From: Chao Yu <chao2.yu@samsung.com>
Subject: RE: [f2fs-dev] [PATCH 06/12] f2fs: update on-disk extents even under
	extent_cache
Date: Tue, 30 Jun 2015 11:10:25 +0800
Message-ID: <00e701d0b2e2$6b561120$42023360$@samsung.com>
References: <1435603176-63219-1-git-send-email-jaegeuk@kernel.org>
 <1435603176-63219-6-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1435603176-63219-6-git-send-email-jaegeuk@kernel.org>
Content-language: zh-cn
Sender: linux-kernel-owner@vger.kernel.org
To: 'Jaegeuk Kim' <jaegeuk@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

> -----Original Message-----
> From: Jaegeuk Kim [mailto:jaegeuk@kernel.org]
> Sent: Tuesday, June 30, 2015 2:40 AM
> To: linux-kernel@vger.kernel.org; linux-fsdevel@vger.kernel.org;
> linux-f2fs-devel@lists.sourceforge.net
> Cc: Jaegeuk Kim
> Subject: [f2fs-dev] [PATCH 06/12] f2fs: update on-disk extents even under extent_cache
> 
> Previously, f2fs_update_extent_cache() updates in-memory extent_cache all the
> time, and then finally preserves its up-to-date extent into on-disk one during
> f2fs_evict_inode.
> 
> But, in the following scenario:
> 
> 1. mount
> 2. open & write an extent X
> 3. f2fs_evict_inode; on-disk extent is X
> 4. open & update the extent X with Y
> 5. sync; trigger checkpoint
> 6. power-cut
> 
> after power-on, f2fs should serve extent Y, but we have an on-disk extent X.
> 
> This causes a failure on xfstests/311.
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

Reviewed-by: Chao Yu <chao2.yu@samsung.com>
