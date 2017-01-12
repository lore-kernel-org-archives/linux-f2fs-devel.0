From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH 06/10 v2] f2fs: show the max number of atomic operations
Date: Thu, 12 Jan 2017 19:15:56 +0800
Message-ID: <d318e3ff-24cd-4793-620b-004b62e81099@huawei.com>
References: <20161230185117.3832-1-jaegeuk@kernel.org>
 <20161230185117.3832-6-jaegeuk@kernel.org>
 <20170104235053.GE1011@jaegeuk.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170104235053.GE1011@jaegeuk.local>
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

On 2017/1/5 7:50, Jaegeuk Kim wrote:
> Chang log from v1:
>  - move stat_dec_atomic_write(inode); into drop_inmem_pages()
> 
>>From 5464f744fe28187b3d71ba6c3cf983659a569e9a Mon Sep 17 00:00:00 2001
> From: Jaegeuk Kim <jaegeuk@kernel.org>
> Date: Wed, 28 Dec 2016 13:55:09 -0800
> Subject: [PATCH] f2fs: show the max number of atomic operations
> 
> This patch adds to show the max number of atomic operations which are
> conducting concurrently.
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,
