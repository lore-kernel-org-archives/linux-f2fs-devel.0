From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH] f2fs: fix fdatasync
Date: Wed, 16 Nov 2016 18:30:04 -0800
Message-ID: <20161117023004.GA66710@jaegeuk>
References: <20161116121211.11790-1-yuchao0@huawei.com>
 <20161116121538.GA22373@infradead.org>
 <0148c188-5e03-432d-b03b-3e968364b5e4@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <0148c188-5e03-432d-b03b-3e968364b5e4@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Chao Yu <yuchao0@huawei.com>
Cc: Christoph Hellwig <hch@infradead.org>, linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, chao@kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

Hi Chao,

On Thu, Nov 17, 2016 at 09:13:03AM +0800, Chao Yu wrote:
> On 2016/11/16 20:15, Christoph Hellwig wrote:
> > On Wed, Nov 16, 2016 at 08:12:11PM +0800, Chao Yu wrote:
> >> For below two cases, we can't guarantee data consistence:
> >>
> >> a)
> >> 1. xfs_io "pwrite 0 4195328" "fsync"
> >> 2. xfs_io "pwrite 4195328 1024" "fdatasync"
> >> 3. godown
> >> 4. umount & mount
> >> --> isize we updated before fdatasync won't be recovered
> >>
> >> b)
> >> 1. xfs_io "pwrite -S 0xcc 0 4202496" "fsync"
> >> 2. xfs_io "fpunch 4194304 4096" "fdatasync"
> >> 3. godown
> >> 4. umount & mount
> >> --> dnode we punched before fdatasync won't be recovered
> > 
> > Can you please add testcases for these to xfstests?
> 
> It's OK, will do.

Let me take a look at this for a while.
It seems there are another test cases as well in terms of this issue.

Thanks,

> 
> > 
> > .
> > 
