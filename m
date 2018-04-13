From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH] f2fs: set deadline to drop expired inmem pages
Date: Thu, 12 Apr 2018 21:05:25 -0700
Message-ID: <20180413040525.GB59368@jaegeuk-macbookpro.roam.corp.google.com>
References: <20180408081312.6190-1-yuchao0@huawei.com>
 <09fd3144-d1c5-ca02-178d-b467d6fbe0e1@huawei.com>
 <20180413010433.GB51348@jaegeuk-macbookpro.roam.corp.google.com>
 <bb7d3b60-0629-ea80-c4ae-976a76abb034@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <bb7d3b60-0629-ea80-c4ae-976a76abb034@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Chao Yu <yuchao0@huawei.com>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, chao@kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

On 04/13, Chao Yu wrote:
> On 2018/4/13 9:04, Jaegeuk Kim wrote:
> > On 04/10, Chao Yu wrote:
> >> Hi Jaegeuk,
> >>
> >> On 2018/4/8 16:13, Chao Yu wrote:
> >>> f2fs doesn't allow abuse on atomic write class interface, so except
> >>> limiting in-mem pages' total memory usage capacity, we need to limit
> >>> start-commit time as well, otherwise we may run into infinite loop
> >>> during foreground GC because target blocks in victim segment are
> >>> belong to atomic opened file for long time.
> >>>
> >>> Now, we will check the condition with f2fs_balance_fs_bg in
> >>> background threads, once if user doesn't commit data exceeding 30
> >>> seconds, we will drop all cached data, so I expect it can keep our
> >>> system running safely to prevent Dos attack.
> >>
> >> Is it worth to add this patch to avoid abuse on atomic write interface by user?
> > 
> > Hmm, hope to see a real problem first in this case.
> 
> I think this can be a more critical security leak instead of a potential issue
> which we can wait for someone reporting that can be too late.
> 
> For example, user can simply write a huge file whose data spread in all f2fs
> segments, once user open that file as atomic, foreground GC will suffer
> deadloop, causing denying any further service of f2fs.

How can you guarantee it won't happen within 30sec? If you want to avoid that,
you have to take a look at foreground gc.

> 
> Thanks,
> 
> > 
> >> Thanks,
> > 
> > .
> > 
