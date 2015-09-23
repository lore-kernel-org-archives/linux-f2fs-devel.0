From: Chao Yu <chao2.yu@samsung.com>
Subject: RE: [PATCH] f2fs: fix to correct freed section number during gc
Date: Wed, 23 Sep 2015 18:11:36 +0800
Message-ID: <012601d0f5e8$5315a690$f940f3b0$@samsung.com>
References: <00d601d0f539$3d893e90$b89bbbb0$@samsung.com>
 <20150922225352.GA31427@jaegeuk-mac02.mot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <20150922225352.GA31427@jaegeuk-mac02.mot.com>
Content-language: zh-cn
Sender: linux-kernel-owner@vger.kernel.org
To: 'Jaegeuk Kim' <jaegeuk@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

Hi Jaegeuk,

> -----Original Message-----
> From: Jaegeuk Kim [mailto:jaegeuk@kernel.org]
> Sent: Wednesday, September 23, 2015 6:54 AM
> To: Chao Yu
> Cc: linux-f2fs-devel@lists.sourceforge.net; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH] f2fs: fix to correct freed section number during gc
> 
> Hi Chao,
> 
> On Tue, Sep 22, 2015 at 09:18:18PM +0800, Chao Yu wrote:
> > We pass 'nfree' to has_not_enough_free_secs to check whether there is
> > enough free section, but 'nfree' indicates the number of segment gced,
> > should alter the value to section number.
> 
> Yeah, but I think we need to increase nfree only when an entire section is gced
> completely, since sometimes nfree can be increased across sections.

Agree, I will fix that.

Still have one question, for foreground gc, why would we give up retry writing
out pages of last victim, but trying to select another victim for cleanup?
Will new introduced method cause long latency for caller than before?

Thanks,
