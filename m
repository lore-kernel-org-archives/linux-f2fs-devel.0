From: Chao Yu <chao2.yu@samsung.com>
Subject: RE: [PATCH 1/2] f2fs: don't trigger recovery for normal umount image
Date: Thu, 05 Feb 2015 16:18:04 +0800
Message-ID: <005f01d0411c$5dbb7380$19325a80$@samsung.com>
References: <008b01d03d34$6926d250$3b7476f0$@samsung.com>
 <20150202233138.GC34575@jaegeuk-mac02.mot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <20150202233138.GC34575@jaegeuk-mac02.mot.com>
Content-language: zh-cn
Sender: linux-kernel-owner@vger.kernel.org
To: 'Jaegeuk Kim' <jaegeuk@kernel.org>
Cc: 'Changman Lee' <cm224.lee@samsung.com>, linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

Hi Jaegeuk,

> -----Original Message-----
> From: Jaegeuk Kim [mailto:jaegeuk@kernel.org]
> Sent: Tuesday, February 03, 2015 7:32 AM
> To: Chao Yu
> Cc: Changman Lee; linux-f2fs-devel@lists.sourceforge.net; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH 1/2] f2fs: don't trigger recovery for normal umount image
> 
> Hi Chao,
> 
> On Sat, Jan 31, 2015 at 04:59:49PM +0800, Chao Yu wrote:
> > Our recovery option is on by default, so we will try to recover data for
> > a normally umounted image when mounting it, but no data will be recovered.
> >
> > So it'd be better to skip the recovery for above condition.
> 
> No.
> We should consider the existing UMOUNT flag written by old f2fs.

You're right, compatibility should be considered, my mistaken.

Please ignore this patch.

Thanks,
