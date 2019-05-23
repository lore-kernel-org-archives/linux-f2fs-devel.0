From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH] fsck.f2fs: show elapsed time of full scan
Date: Thu, 23 May 2019 07:08:11 -0700
Message-ID: <20190523140811.GB10954@jaegeuk-macbookpro.roam.corp.google.com>
References: <20190522194141.91216-1-jaegeuk@kernel.org>
 <86b041c4-301b-40b3-d293-ca5365c87600@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <jaegeuk@kernel.org>) id 1hToOJ-00087E-AE
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 23 May 2019 14:08:19 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1hToOI-002QAr-5f
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 23 May 2019 14:08:19 +0000
Content-Disposition: inline
In-Reply-To: <86b041c4-301b-40b3-d293-ca5365c87600@kernel.org>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Chao Yu <chao@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net

On 05/23, Chao Yu wrote:
> On 2019-5-23 3:41, Jaegeuk Kim wrote:
> > This patch introduces the elapsed time of fsck.
> > 
> > Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> > ---
> >  fsck/main.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> > 
> > diff --git a/fsck/main.c b/fsck/main.c
> > index d844820..9aca024 100644
> > --- a/fsck/main.c
> > +++ b/fsck/main.c
> > @@ -18,6 +18,7 @@
> >  #include "fsck.h"
> >  #include <libgen.h>
> >  #include <ctype.h>
> > +#include <time.h>
> >  #include <getopt.h>
> >  #include "quotaio.h"
> >  
> > @@ -745,6 +746,7 @@ int main(int argc, char **argv)
> >  {
> >  	struct f2fs_sb_info *sbi;
> >  	int ret = 0;
> > +	clock_t start = clock();
> >  
> >  	f2fs_init_configuration();
> >  
> > @@ -853,7 +855,7 @@ retry:
> >  	if (ret < 0)
> >  		return ret;
> >  
> > -	printf("\nDone.\n");
> > +	printf("\nDone: %lf secs\n", (clock() - start) / (double)CLOCKS_PER_SEC);
> 
> Minor, as comment log says it's only for fsck.

I think it doesn't matter for other use cases, even though main reason was for
fsck.

> 
> if (c.func == FSCK)
> 	printf();
> 
> Reviewed-by: Chao Yu <yuchao0@huawei.com>
> 
> Thanks,
> 
> >  	return 0;
> >  
> >  out_err:
> > 
