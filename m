From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [f2fs-dev] [PATCH] f2fs: return error number for quota_write
Date: Thu, 19 Oct 2017 12:08:51 -0700
Message-ID: <20171019190851.GB82186@jaegeuk-macbookpro.roam.corp.google.com>
References: <20171012231500.19489-1-jaegeuk@kernel.org>
 <f84b3522-f53d-d91a-464d-71c194dd5864@huawei.com>
 <20171016230444.GA94030@jaegeuk-macbookpro.roam.corp.google.com>
 <79d07284-167a-3b12-bed3-cea138ab4eb7@kernel.org>
 <20171017181749.GB10794@jaegeuk-macbookpro.roam.corp.google.com>
 <f7c99fe2-5920-1274-a6c2-0cc831b8aca3@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <f7c99fe2-5920-1274-a6c2-0cc831b8aca3@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Chao Yu <yuchao0@huawei.com>
Cc: Chao Yu <chao@kernel.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

On 10/18, Chao Yu wrote:
> On 2017/10/18 2:17, Jaegeuk Kim wrote:
> > On 10/17, Chao Yu wrote:
> >>
> >>
> >> On 2017/10/17 7:04, Jaegeuk Kim wrote:
> >>> On 10/16, Chao Yu wrote:
> >>>> Hi Jaegeuk,
> >>>>
> >>>> On 2017/10/13 7:15, Jaegeuk Kim wrote:
> >>>>> This patch returns an error number to quota_write in order for quota to handle
> >>>>> it correctly.
> >>>>
> >>>> We should return error number like __generic_file_write_iter, right? it
> >>>> needs to return written bytes if we have written one page or more, otherwise
> >>>> return error number feedbacked from write_begin.
> >>>>
> >>>> So how about reverting 4f31d26b0c17 ("f2fs: return wrong error number on
> >>>> f2fs_quota_write")?
> >>>
> >>> I thought like that, but realized the code change is somewhat different between
> >>> them.
> >>
> >> Hmm... main structure of codes here is copied from other file systems, is there
> >> the same problem in *_quota_write of other file systems?
> >>
> >> BTW, it looks making below judgment condition being useless.
> >>
> >> 	if (len == towrite)
> >> 		return 0;
> > 
> > We need this to avoid needless inode updates. :P
> 
> For err = 0 and len == towrite case, it more likes a bug of quota that passing
> 0 in @len.
> 
> :(, Oh, still didn't get that why there is difference in between reverting and
> this fixing. Can you please explain more about this?

Ah, right. Let me just revert the original patch. :)

Thanks,
