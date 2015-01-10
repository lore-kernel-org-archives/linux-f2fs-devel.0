From: Chao Yu <chao2.yu@samsung.com>
Subject: RE: [f2fs-dev][PATCH 1/2] f2fs: get rid of kzalloc in
 __recover_inline_status
Date: Sat, 10 Jan 2015 20:06:30 +0800
Message-ID: <000001d02ccd$fa6d4f90$ef47eeb0$@samsung.com>
References: <009301d0297a$1fc55780$5f500680$@samsung.com>
 <20150106193222.GA54001@jaegeuk-mac02>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <20150106193222.GA54001@jaegeuk-mac02>
Content-language: zh-cn
Sender: linux-kernel-owner@vger.kernel.org
To: 'Jaegeuk Kim' <jaegeuk@kernel.org>
Cc: 'Changman Lee' <cm224.lee@samsung.com>, linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

Hi,

> -----Original Message-----
> From: Jaegeuk Kim [mailto:jaegeuk@kernel.org]
> Sent: Wednesday, January 07, 2015 3:32 AM
> To: Chao Yu
> Cc: Changman Lee; linux-f2fs-devel@lists.sourceforge.net; linux-kernel@vger.kernel.org
> Subject: Re: [f2fs-dev][PATCH 1/2] f2fs: get rid of kzalloc in __recover_inline_status
> 
> Hi Chao,
> 
> On Tue, Jan 06, 2015 at 02:28:43PM +0800, Chao Yu wrote:
> > We use kzalloc to allocate memory in __recover_inline_status, and use this
> > all-zero memory to check the inline date content of inode page by comparing
> > them. This is low effective and not needed, let's check inline date content
> > directly.
> >

[snip]

> 
> I think *goto recovery* is not a good way.
> 
> How's like this?
> If you don't mind, I'll merge the patch with this.

It's OK, thank you!

Regards,
Yu
