From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH] f2fs: fix out-of-free problem caused by atomic write
Date: Thu, 26 Oct 2017 23:38:54 -0700
Message-ID: <20171027063854.GA25279@infradead.org>
References: <1509027715-80477-1-git-send-email-yunlong.song@huawei.com>
 <20171026143019.GB67431@jaegeuk-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20171026143019.GB67431@jaegeuk-macbookpro.roam.corp.google.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: Yunlong Song <yunlong.song@huawei.com>, chao@kernel.org, yuchao0@huawei.com, yunlong.song@icloud.com, miaoxie@huawei.com, bintian.wang@huawei.com, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

On Thu, Oct 26, 2017 at 04:30:19PM +0200, Jaegeuk Kim wrote:
> On 10/26, Yunlong Song wrote:
> > f2fs_balance_fs only actives once in the commit_inmem_pages, but there
> > are more than one page to commit, so all the other pages will miss the
> > check. This will lead to out-of-free problem when commit a very large
> > file. To fix it, we should do f2fs_balance_fs for each inmem page.
> 
> NAK, this breaks atomicity.

Can someone please explain (and write down in e.g. manpages) these
atomicy rules?
