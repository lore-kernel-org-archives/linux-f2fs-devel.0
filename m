From: Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH] loop: drop caches if offset or block_size are changed
Date: Wed, 9 Jan 2019 20:51:59 -0700
Message-ID: <6742173c-170b-555e-edc2-f70314eccabf@kernel.dk>
References: <20190110031714.39000-1-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190110031714.39000-1-jaegeuk@kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: linux-block@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

On 1/9/19 8:17 PM, Jaegeuk Kim wrote:
> If we don't drop caches used in old offset or block_size, we can get old data
> from new offset/block_size, which gives unexpected data to user.
> 
> For example, Martijn found a loopback bug in the below scenario.
> 1) LOOP_SET_FD loads first two pages on loop file
> 2) LOOP_SET_STATUS64 changes the offset on the loop file
> 3) mount is failed due to the cached pages having wrong superblock

Applied, thanks.


-- 
Jens Axboe
