From: Chao Yu <chao2.yu@samsung.com>
Subject: RE: [f2fs-dev] [PATCH 5/5 v4] f2fs: introduce a batched trim
Date: Fri, 06 Feb 2015 16:20:37 +0800
Message-ID: <005001d041e5$e87089b0$b9519d10$@samsung.com>
References: <1422401503-4769-1-git-send-email-jaegeuk@kernel.org>
 <1422401503-4769-5-git-send-email-jaegeuk@kernel.org>
 <003b01d03bc0$a5f23d20$f1d6b760$@samsung.com>
 <20150129214117.GB17521@jaegeuk-mac02>
 <006701d03c4b$a62ec0c0$f28c4240$@samsung.com>
 <20150202232803.GB34575@jaegeuk-mac02.mot.com> <20150203024822.GA8798@lcm>
 <20150203200904.GA43329@jaegeuk-mac02.mot.com>
 <006001d04126$895e3680$9c1aa380$@samsung.com>
 <20150206061837.GA66378@jaegeuk-mac02.hsd1.ca.comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <20150206061837.GA66378@jaegeuk-mac02.hsd1.ca.comcast.net>
Content-language: zh-cn
Sender: linux-kernel-owner@vger.kernel.org
To: 'Jaegeuk Kim' <jaegeuk@kernel.org>
Cc: 'Changman Lee' <cm224.lee@samsung.com>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

Hi Jaegeuk,

> -----Original Message-----
> From: Jaegeuk Kim [mailto:jaegeuk@kernel.org]
> Sent: Friday, February 06, 2015 2:19 PM
> To: Chao Yu
> Cc: 'Changman Lee'; linux-fsdevel@vger.kernel.org; linux-kernel@vger.kernel.org;
> linux-f2fs-devel@lists.sourceforge.net
> Subject: Re: [f2fs-dev] [PATCH 5/5 v4] f2fs: introduce a batched trim
> 
> Hi Chao,
> 
> Something like this?
> 
> Change log from v3:
>  o align to section size
> 
> This patch introduces a batched trimming feature, which submits split discard
> commands.
> 
> This is to avoid long latency due to huge trim commands.
> If fstrim was triggered ranging from 0 to the end of device, we should lock
> all the checkpoint-related mutexes, resulting in very long latency.
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

Looks good to me.

Reviewed-by: Chao Yu <chao2.yu@samsung.com>
