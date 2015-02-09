From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [f2fs-dev] [PATCH 5/5 v4] f2fs: introduce a batched trim
Date: Sun, 8 Feb 2015 23:04:12 -0800
Message-ID: <20150209070412.GA72988@jaegeuk-mac02.hsd1.ca.comcast.net>
References: <1422401503-4769-5-git-send-email-jaegeuk@kernel.org>
 <003b01d03bc0$a5f23d20$f1d6b760$@samsung.com>
 <20150129214117.GB17521@jaegeuk-mac02>
 <006701d03c4b$a62ec0c0$f28c4240$@samsung.com>
 <20150202232803.GB34575@jaegeuk-mac02.mot.com>
 <20150203024822.GA8798@lcm>
 <20150203200904.GA43329@jaegeuk-mac02.mot.com>
 <006001d04126$895e3680$9c1aa380$@samsung.com>
 <20150206061837.GA66378@jaegeuk-mac02.hsd1.ca.comcast.net>
 <CALq1K=JHCyzF6CL7FOngfFAJX_S-jJZ38umNB43fPCURR=F=dg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CALq1K=JHCyzF6CL7FOngfFAJX_S-jJZ38umNB43fPCURR=F=dg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Leon Romanovsky <leon@leon.nu>
Cc: Chao Yu <chao2.yu@samsung.com>, Linux-FSDevel <linux-fsdevel@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

On Sat, Feb 07, 2015 at 05:57:46PM +0200, Leon Romanovsky wrote:
> Hi Jaegeuk,
> 
> > +       /* for batched trimming */
> > +       int trim_sections;                      /* # of sections to trim */
> I would like to suggest to declare trim_sections variable as an
> unsigned int and not int, since it can't be negative by definition.
> What do you think about it?

Hi Leon,

No problem. :)

I'll change that and merge the patch.

Thanks,
