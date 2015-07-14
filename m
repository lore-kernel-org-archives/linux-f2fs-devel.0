From: Chao Yu <chao2.yu@samsung.com>
Subject: RE: [f2fs-dev] [PATCH] f2fs: fix to release inode page in
 get_new_data_page
Date: Tue, 14 Jul 2015 18:13:05 +0800
Message-ID: <00f401d0be1d$cbb489c0$631d9d40$@samsung.com>
References: <00f301d0ba30$ebe95b80$c3bc1280$@samsung.com>
 <20150711001715.GA61190@jaegeuk-mac02>
 <COL402-EAS409F2B0F7AE6CCD5F95F8D1AB9E0@phx.gbl>
 <20150713232437.GA64479@jaegeuk-mac02.mot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <20150713232437.GA64479@jaegeuk-mac02.mot.com>
Content-language: zh-cn
Sender: linux-kernel-owner@vger.kernel.org
To: 'Jaegeuk Kim' <jaegeuk@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

> -----Original Message-----
> From: Jaegeuk Kim [mailto:jaegeuk@kernel.org]
> Sent: Tuesday, July 14, 2015 7:26 AM
> To: Chao Yu
> Cc: linux-kernel@vger.kernel.org; linux-f2fs-devel@lists.sourceforge.net
> Subject: Re: [f2fs-dev] [PATCH] f2fs: fix to release inode page in get_new_data_page

[snip]

> > And I don't think we should change error handling method of f2fs_put_dnode
> > for just fixing this issue.
> >
> > How do you think?
> 
> Indeed. I cannot think about other clean way for now.
> Instead, how about adding this description in the patch and some comments in
> the codes?

OK, Please help to review the following patch. :)

Thanks,
