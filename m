From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [RFC PATCH 0/2] apply write hints to select the type
 of segments
Date: Fri, 17 Nov 2017 10:36:54 -0800
Message-ID: <20171117183654.GA77642@jaegeuk-macbookpro.roam.corp.google.com>
References: <1510206688-12767-1-git-send-email-hyc.lee@gmail.com>
 <20171117172349.GA22843@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.193]
 helo=mx.sourceforge.net)
 by sfs-ml-3.v29.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 (envelope-from <jaegeuk@kernel.org>) id 1eFlVe-0004nK-AC
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 17 Nov 2017 18:37:02 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-3.v28.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 id 1eFlVd-0002pW-Ir
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 17 Nov 2017 18:37:02 +0000
Content-Disposition: inline
In-Reply-To: <20171117172349.GA22843@infradead.org>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Christoph Hellwig <hch@infradead.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org, Hyunchul Lee <hyc.lee@gmail.com>, linux-f2fs-devel@lists.sourceforge.net, linux-block@vger.kernel.org, kernel-team@lge.com, linux-fsdevel@vger.kernel.org, Hyunchul Lee <cheol.lee@lge.com>

On 11/17, Christoph Hellwig wrote:
> 
> Next time please coordinate this with the block list and Jens, who
> actually wrote the patch.

Got it.

> 
> >   hints                     segment type
> >   -----                     ------------
> >   WRITE_LIFE_SHORT          CURSEG_COLD_DATA
> >   WRITE_LIFE_EXTREME        CURSEG_HOT_DATA
> >   others                    CURSEG_WARM_DATA
> 
> Normally cold data is data with a long lifetime, and extreme is colder
> than cold, so there seems to be some mismatch here.

It was wrong description and I fixed it which matches to implementation.

The below description was merged:

WRITE_LIFE_SHORT          CURSEG_HOT_DATA
WRITE_LIFE_EXTREME        CURSEG_COLD_DATA
others                    CURSEG_WARM_DATA

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
