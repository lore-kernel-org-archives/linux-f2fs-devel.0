From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH 2/2] f2fs: don't skip recovering inode depend on i_times
Date: Fri, 4 Nov 2016 15:53:52 -0700
Message-ID: <20161104225352.GA3339@jaegeuk>
References: <20161103162656.2982-1-chao@kernel.org>
 <20161103162656.2982-2-chao@kernel.org>
 <20161103180233.GC76264@jaegeuk>
 <b58aaf87-8ce4-12b1-c535-ea48d8eeee59@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <b58aaf87-8ce4-12b1-c535-ea48d8eeee59@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Chao Yu <yuchao0@huawei.com>
Cc: Chao Yu <chao@kernel.org>, linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, liushuoran@huawei.com
List-Id: linux-f2fs-devel.lists.sourceforge.net

On Fri, Nov 04, 2016 at 04:30:09PM +0800, Chao Yu wrote:
> On 2016/11/4 2:02, Jaegeuk Kim wrote:
> > On Fri, Nov 04, 2016 at 12:26:56AM +0800, Chao Yu wrote:
> >> From: Chao Yu <yuchao0@huawei.com>
> >>
> >> i_times of inode will be set with current system time which can be
> >> configured through 'date', so it's not safe to judge dnode block as
> >> garbage data depend on i_times.
> > 
> > This is not to detect garbage data, but to skip redundant unchanged inode.
> 
> Oops, seems 807b1e1c8e08 ("f2fs: do not recover from previous remained wrong
> dnodes") did't describe like that. But after reading the codes, it looks like
> the purpose of this change is to skip unchanged inode. So, commit log in
> original is incorrect, right?

Oh, right. This indicats both of purposes: stale data and detecting same inodes.
Let me just revert the original patch.

Thanks,

> 
> Thanks,
