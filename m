From: sunqiuyang <sunqiuyang@huawei.com>
Subject: RE: [PATCH v8 1/1] f2fs: dax: implement direct access
Date: Wed, 26 Jul 2017 06:47:58 +0000
Message-ID: <157FC541501A9C4C862B2F16FFE316DCFC7BF2@DGGEMM506-MBS.china.huawei.com>
References: <1500552639-18523-1-git-send-email-sunqiuyang@huawei.com>
 <CAA9_cmeyVXgu1-ozb7b346ANq+P3e3ATWYfoVGkAKrn5cmo=Hw@mail.gmail.com>,<20170726021620.GB36902@jaegeuk-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170726021620.GB36902@jaegeuk-macbookpro.roam.corp.google.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>, Dan Williams <dan.j.williams@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, "linux-f2fs-devel@lists.sourceforge.net" <linux-f2fs-devel@lists.sourceforge.net>, "linux-nvdimm@lists.01.org" <linux-nvdimm@ml01.01.org>
List-Id: linux-f2fs-devel.lists.sourceforge.net

Hi, 

Considering the current interfaces of F2FS and EXT4, my thought is that we can define a generic user-modifiable flag FS_DAX_FL, which can be included in the i_flags field of [f2fs | ext4]_inode_info. Thus, DAX can be enabled in either of the two ways below: 

1) mount the FS with a "dax" option, so that all files created will have the flag S_DAX set in the VFS inode, and the flag FS_DAX_FL set in [f2fs | ext4]_inode_info, by default.

2) mount the FS without "dax", and enable DAX per-inode from 
f2fs_ioctl_setflags() => f2fs_set_inode_flags()
 
Thanks,

________________________________________
From: Jaegeuk Kim [jaegeuk@kernel.org]
Sent: Wednesday, July 26, 2017 10:16
To: Dan Williams
Cc: sunqiuyang; Linux Kernel Mailing List; linux-fsdevel; linux-f2fs-devel@lists.sourceforge.net; linux-nvdimm@lists.01.org
Subject: Re: [PATCH v8 1/1] f2fs: dax: implement direct access

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
