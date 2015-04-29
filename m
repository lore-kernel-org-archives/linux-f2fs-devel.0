From: Chao Yu <chao2.yu@samsung.com>
Subject: RE: [f2fs-dev] [PATCH 1/2] f2fs: support FALLOC_FL_COLLAPSE_RANGE
Date: Wed, 29 Apr 2015 13:19:21 +0800
Message-ID: <01f101d0823c$280bb950$78232bf0$@samsung.com>
References: <007901d079be$9cfb81e0$d6f285a0$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <007901d079be$9cfb81e0$d6f285a0$@samsung.com>
Content-language: zh-cn
Sender: linux-kernel-owner@vger.kernel.org
To: 'Jaegeuk Kim' <jaegeuk@kernel.org>, 'Changman Lee' <cm224.lee@samsung.com>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

Ping, any comments?

> -----Original Message-----
> From: Chao Yu [mailto:chao2.yu@samsung.com]
> Sent: Saturday, April 18, 2015 6:01 PM
> To: Jaegeuk Kim; Changman Lee
> Cc: linux-kernel@vger.kernel.org; linux-f2fs-devel@lists.sourceforge.net
> Subject: [f2fs-dev] [PATCH 1/2] f2fs: support FALLOC_FL_COLLAPSE_RANGE
> 
> Now, FALLOC_FL_COLLAPSE_RANGE flag in ->fallocate is supported in ext4/xfs.
> 
> In commit, the semantics of this flag is descripted as following:
> "1) It collapses the range lying between offset and length by removing any data
>    blocks which are present in this range and than updates all the logical
>    offsets of extents beyond "offset + len" to nullify the hole created by
>    removing blocks. In short, it does not leave a hole.
> 2) It should be used exclusively. No other fallocate flag in combination.
> 3) Offset and length supplied to fallocate should be fs block size aligned
>    in case of xfs and ext4.
> 4) Collaspe range does not work beyond i_size."
> 
> This patch implements fallocate's FALLOC_FL_COLLAPSE_RANGE for f2fs.
