From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH] f2fs: set deadline to drop expired inmem pages
Date: Thu, 12 Apr 2018 18:04:33 -0700
Message-ID: <20180413010433.GB51348@jaegeuk-macbookpro.roam.corp.google.com>
References: <20180408081312.6190-1-yuchao0@huawei.com>
 <09fd3144-d1c5-ca02-178d-b467d6fbe0e1@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <09fd3144-d1c5-ca02-178d-b467d6fbe0e1@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Chao Yu <yuchao0@huawei.com>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, chao@kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

On 04/10, Chao Yu wrote:
> Hi Jaegeuk,
> 
> On 2018/4/8 16:13, Chao Yu wrote:
> > f2fs doesn't allow abuse on atomic write class interface, so except
> > limiting in-mem pages' total memory usage capacity, we need to limit
> > start-commit time as well, otherwise we may run into infinite loop
> > during foreground GC because target blocks in victim segment are
> > belong to atomic opened file for long time.
> > 
> > Now, we will check the condition with f2fs_balance_fs_bg in
> > background threads, once if user doesn't commit data exceeding 30
> > seconds, we will drop all cached data, so I expect it can keep our
> > system running safely to prevent Dos attack.
> 
> Is it worth to add this patch to avoid abuse on atomic write interface by user?

Hmm, hope to see a real problem first in this case.

> Thanks,
