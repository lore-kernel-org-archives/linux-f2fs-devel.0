From: Chao Yu <chao2.yu@samsung.com>
Subject: RE: [f2fs-dev] [PATCH 03/12] f2fs: convert inline_data for various
	fallocate
Date: Tue, 30 Jun 2015 10:58:39 +0800
Message-ID: <00e401d0b2e0$c55980a0$500c81e0$@samsung.com>
References: <1435603176-63219-1-git-send-email-jaegeuk@kernel.org>
 <1435603176-63219-3-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-reply-to: <1435603176-63219-3-git-send-email-jaegeuk@kernel.org>
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
> Subject: [f2fs-dev] [PATCH 03/12] f2fs: convert inline_data for various fallocate
> 
> For newly added fallocate types, it should convert inline_data before handling
> block swapping.
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

Reviewed-by: Chao Yu <chao2.yu@samsung.com>

