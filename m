From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH] f2fs: introduce f2fs_reserve_blocks to speedup fallocate
Date: Mon, 9 May 2016 20:03:18 +0800
Message-ID: <f877ae36-1293-ddc6-aa36-da129d5df836@huawei.com>
References: <20160507081634.96677-1-yuchao0@huawei.com>
 <20160507174401.GA92790@jaegeuk.gateway>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160507174401.GA92790@jaegeuk.gateway>
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

Hi Jaegeuk,

On 2016/5/8 1:44, Jaegeuk Kim wrote:
> Hi Chao,
> 
> Good catch, but I've been already testing a patch which uses f2fs_map_blocks().
> We don't need to add whole things redundantly. :)

Good, your patch looks quite clean especially the size updating part! :)

However, I think there are still room of performance improvement, I wrote a
patch for that based on your patch, could you check that?

Thanks,
