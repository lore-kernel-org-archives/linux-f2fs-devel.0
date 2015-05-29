From: Chao Yu <chao2.yu@samsung.com>
Subject: RE: [f2fs-dev] [PATCH 2/3] f2fs crypto: use bounce pages from mempool
 first
Date: Fri, 29 May 2015 10:45:46 +0800
Message-ID: <002601d099b9$abafd090$030f71b0$@samsung.com>
References: <1432255225-76792-1-git-send-email-jaegeuk@kernel.org>
 <1432255225-76792-2-git-send-email-jaegeuk@kernel.org>
 <00d101d096d1$c7300a50$55901ef0$@samsung.com>
 <20150527190815.GA91133@jaegeuk-mac02.mot-mobility.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <20150527190815.GA91133@jaegeuk-mac02.mot-mobility.com>
Content-language: zh-cn
Sender: linux-kernel-owner@vger.kernel.org
To: 'Jaegeuk Kim' <jaegeuk@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

Hi Jaegeuk,

> -----Original Message-----
> From: Jaegeuk Kim [mailto:jaegeuk@kernel.org]
> Sent: Thursday, May 28, 2015 3:10 AM
> To: Chao Yu
> Cc: linux-kernel@vger.kernel.org; linux-fsdevel@vger.kernel.org;
> linux-f2fs-devel@lists.sourceforge.net
> Subject: Re: [f2fs-dev] [PATCH 2/3] f2fs crypto: use bounce pages from mempool first
> 
> Hi Chao,
> 
> On Mon, May 25, 2015 at 06:00:47PM +0800, Chao Yu wrote:
> > Hi Jaegeuk,
> >

[snip]

> >
> > Using alloc_page(GFP_NOFS | __GFP_WAIT) to avoid failure?
> 
> #define GFP_NOFS	(__GFP_WAIT | __GFP_IO)

That's right, my miss.

Thanks,
