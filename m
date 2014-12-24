From: Chao Yu <chao2.yu@samsung.com>
Subject: RE: [f2fs-dev][PATCH] f2fs: cleanup trace event of
 f2fs_submit_page_{m,}bio with DECLARE_EVENT_CLASS
Date: Wed, 24 Dec 2014 16:04:38 +0800
Message-ID: <006f01d01f50$5e509b10$1af1d130$@samsung.com>
References: <003701d01e8b$883e0e00$98ba2a00$@samsung.com>
 <20141223185033.GA12880@jaegeuk-mac02>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <20141223185033.GA12880@jaegeuk-mac02>
Content-language: zh-cn
Sender: linux-kernel-owner@vger.kernel.org
To: 'Jaegeuk Kim' <jaegeuk@kernel.org>
Cc: 'Changman Lee' <cm224.lee@samsung.com>, linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

Hi Jaegeuk,

> -----Original Message-----
> From: Jaegeuk Kim [mailto:jaegeuk@kernel.org]
> Sent: Wednesday, December 24, 2014 2:51 AM
> To: Chao Yu
> Cc: Changman Lee; linux-f2fs-devel@lists.sourceforge.net; linux-kernel@vger.kernel.org
> Subject: Re: [f2fs-dev][PATCH] f2fs: cleanup trace event of f2fs_submit_page_{m,}bio with
> DECLARE_EVENT_CLASS
> 
> Hi Chao,
> 
> Is there a chance to use *fio* as one parameter?

Good idea!

How about the following patch which cleanup parameters for
trace_f2fs_submit_{read_,write_,page_,page_m}bio with fio?

Thanks,

> 
> Thanks,
> 
