From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH 2/3] f2fs: support checkpoint error injection
Date: Sat, 24 Sep 2016 11:10:34 -0700
Message-ID: <20160924181034.GB25123@jaegeuk>
References: <20160923052458.83849-1-yuchao0@huawei.com>
 <20160923052458.83849-2-yuchao0@huawei.com>
 <20160923235345.GA23989@jaegeuk>
 <3cf62ebc-3bfa-b64c-5e63-cb3170560ac0@huawei.com>
 <20160924005216.GA24515@jaegeuk>
 <53ec17da-e6b3-cab4-d107-20ead1381ebd@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <53ec17da-e6b3-cab4-d107-20ead1381ebd@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Chao Yu <yuchao0@huawei.com>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, chao@kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

On Sat, Sep 24, 2016 at 11:32:08AM +0800, Chao Yu wrote:
> On 2016/9/24 8:52, Jaegeuk Kim wrote:
> > On Sat, Sep 24, 2016 at 08:46:54AM +0800, Chao Yu wrote:
> >> Hi Jaegeuk,
> >>
> >> On 2016/9/24 7:53, Jaegeuk Kim wrote:
> >>> Hi Chao,
> >>>
> >>> The basic rule is to stop every operations once CP_ERROR_FLAG is set.
> >>> But, this patch simply breaks the rule.
> >>> For example, f2fs_write_data_page() currently exits with mapping_set_error().
> >>> So this patch incurs missing dentry blocks in a valid checkpoint.
> >>
> >> Yes, that's right.
> >>
> >> How about triggering checkpoint error in f2fs_stop_checkpoint?
> > 
> > Let's just use src/godown in xfstests, since we don't need to trigger this
> > multiple times in runtime.
> 
> After we inject checkpoint error into f2fs at first time, all write IOs will be
> refused to be writebacked to storage, meanwhile read IOs can continuously go
> through f2fs, so with checkpoint error injection being supported, we can support
> to trigger random analogously power off by f2fs itself, instead of using tools.
> It means it doesn't needs specified test cases where we must use godown ioctl,
> but with normal testcases in xfstest/fsstress/lkp, in CP error injection enabled
> f2fs, we can test power off cases.

But, in this approach, the test coverage would be quite limited.
In my testcase, I'm randomly injecting godown while fsstress is running, which
mimics really random power failures, as I believe. I'm running this infinitely
with fscking at every run.

Anyway, in order to do this without godown, how about background_gc thread to
trigger f2fs_stop_checkpoint?

> 
> Thanks,
