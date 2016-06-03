From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH] f2fs: fix to redirty page if fail to gc data page
Date: Fri, 3 Jun 2016 10:36:54 -0700
Message-ID: <20160603173654.GA29066@jaegeuk>
References: <1463807951-10472-1-git-send-email-chao@kernel.org>
 <20160530023702.GB78763@jaegeuk.hsd1.ca.comcast.net>
 <a09543b8-349e-d2cc-0e15-f2bf82d4dcfa@huawei.com>
 <20160603050858.GA24882@jaegeuk>
 <d0222ec2-986a-9d73-d3f5-c98335c0f37a@huawei.com>
 <20160603051734.GA25068@jaegeuk>
 <e0ec235d-67ac-751f-a343-f227525fd19b@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <e0ec235d-67ac-751f-a343-f227525fd19b@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Chao Yu <yuchao0@huawei.com>
Cc: Chao Yu <chao@kernel.org>, linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

On Fri, Jun 03, 2016 at 01:59:15PM +0800, Chao Yu wrote:
...

> >>> Do we have another expectation?
> >>
> >> ENOMEM or EIO?
> > 
> > EIO will stop everything.
> > ENOMEM would be better to wait for a while from page reclaim?
> 
> Agree, but for ioctl path, IMO, we don't need to let user waiting for ENOMEM
> case looping.

Well, if user wanted to do a synchronous gc, we need that, IMO.
