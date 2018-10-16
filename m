From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH] f2fs: remove request_list check in is_idle()
Date: Tue, 16 Oct 2018 12:31:45 -0700
Message-ID: <20181016193145.GA46067@jaegeuk-macbookpro.roam.corp.google.com>
References: <d89936bb-398e-08c1-573f-b1bd54f3ca35@kernel.dk>
 <003df7ce-626c-e32b-909b-909b87e0c8f3@kernel.org>
 <5bbe6ae7-704e-dcaa-f798-959d8a1a00b3@kernel.dk>
 <20181016192314.GB29774@jaegeuk-macbookpro.roam.corp.google.com>
 <263ca9fa-7865-41a5-2109-af851cbb2c64@kernel.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <jaegeuk@kernel.org>) id 1gCV4N-0004SP-5M
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 16 Oct 2018 19:31:55 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1gCV4L-00AUSi-Rf
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 16 Oct 2018 19:31:55 +0000
Content-Disposition: inline
In-Reply-To: <263ca9fa-7865-41a5-2109-af851cbb2c64@kernel.dk>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-f2fs-devel@lists.sourceforge.net

On 10/16, Jens Axboe wrote:
> On 10/16/18 1:23 PM, Jaegeuk Kim wrote:
> > Thanks Jens,
> > 
> > On top of the patch killing the dead code, I wrote another one to detect
> > the idle time by the internal account logic like below. IMHO, it'd be
> > better to decouple f2fs with other layers, if possible.
> 
> I agree, that's what got us into trouble in the first place. Can I add
> your acked-by or review-by to the other patch, then?

I queued the patch in f2fs for -next with SOB, so I guess block for -next should
be fine to assume this patch is in. Can I?

> 
> -- 
> Jens Axboe
