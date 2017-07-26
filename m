From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH v8 1/1] f2fs: dax: implement direct access
Date: Tue, 25 Jul 2017 19:16:20 -0700
Message-ID: <20170726021620.GB36902@jaegeuk-macbookpro.roam.corp.google.com>
References: <1500552639-18523-1-git-send-email-sunqiuyang@huawei.com>
 <CAA9_cmeyVXgu1-ozb7b346ANq+P3e3ATWYfoVGkAKrn5cmo=Hw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAA9_cmeyVXgu1-ozb7b346ANq+P3e3ATWYfoVGkAKrn5cmo=Hw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dan Williams <dan.j.williams@gmail.com>
Cc: sunqiuyang <sunqiuyang@huawei.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, linux-f2fs-devel@lists.sourceforge.net, "linux-nvdimm@lists.01.org" <linux-nvdimm@ml01.01.org>
List-Id: linux-f2fs-devel.lists.sourceforge.net

Hi Dan,

On 07/25, Dan Williams wrote:
> [ adding linux-nvdimm ]
> 
> On Thu, Jul 20, 2017 at 5:10 AM, sunqiuyang <sunqiuyang@huawei.com> wrote:
> > From: Qiuyang Sun <sunqiuyang@huawei.com>
> >
> > This patch implements Direct Access (DAX) in F2FS, including:
> >  - a mount option to choose whether to enable DAX or not
> 
> We're in the process of walking back and potentially deprecating the
> use of the dax mount option for xfs and ext4 since dax can have
> negative performance implications if page cache memory happens to be
> faster than pmem. It should be limited to applications that
> specifically want the semantic, not globally enabled for the entire
> mount. xfs has went ahead and added the XFS_DIFLAG2_DAX indoe flag for
> per-inode enabling of dax.

Thank you so much for pointing this out. So, is there a plan to define a
generic inode flag to enable dax via inode_set_flag? Or, does each filesystem
need to handle it individually likewise xfs?

> 
> I'm wondering if any new filesystem that adds dax support at this
> point should do so with inode flags and not a mount option?

Anyway, in such the case, I have to postpone merging this patch for a while.

Thanks,
