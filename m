From: Chao Yu <chao2.yu@samsung.com>
Subject: RE: [f2fs-dev]  [PATCH] f2fs: optimize the flow of f2fs_map_blocks
Date: Thu, 17 Dec 2015 17:18:21 +0800
Message-ID: <006f01d138ac$007d3130$01779390$@samsung.com>
References: <004c01d1388a$cfa319b0$6ee94d10$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <004c01d1388a$cfa319b0$6ee94d10$@samsung.com>
Content-language: zh-cn
Sender: linux-kernel-owner@vger.kernel.org
To: 'Fan Li' <fanofcode.li@samsung.com>, 'Jaegeuk Kim' <jaegeuk@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

> -----Original Message-----
> From: Fan Li [mailto:fanofcode.li@samsung.com]
> Sent: Thursday, December 17, 2015 1:21 PM
> To: 'Jaegeuk Kim'
> Cc: linux-kernel@vger.kernel.org; linux-f2fs-devel@lists.sourceforge.net
> Subject: [f2fs-dev] [PATCH] f2fs: optimize the flow of f2fs_map_blocks
> 
> check map->m_len right after it changes to avoid excess call
> to update dnode_of_data.
> 
> Signed-off-by: Fan li <fanofcode.li@samsung.com>

Reviewed-by: Chao Yu <chao2.yu@samsung.com>
