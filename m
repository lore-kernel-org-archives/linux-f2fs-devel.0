From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: SMR drive test 2; 128GB partition;
 no obvious corruption, much more sane behaviour, weird
 overprovisioning
Date: Wed, 23 Sep 2015 14:30:08 -0700
Message-ID: <20150923213007.GD36564@jaegeuk-mac02.mot.com>
References: <20150808205003.GA6546@schmorp.de>
	<20150810203106.GA4575@jaegeuk-mac02>
	<20150920235901.GA7017@schmorp.de>
	<20150921081748.GA5637@schmorp.de>
	<20150921081937.GA5718@schmorp.de>
	<20150921095806.GA6809@schmorp.de>
	<20150923011239.GA32520@jaegeuk-mac02.mot.com>
	<20150923041523.GB4946@schmorp.de>
	<20150923060636.GA6807@schmorp.de>
	<011d01d0f5df$c54267c0$4fc73740$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1ZercJ-0004U6-Mt
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 23 Sep 2015 21:30:19 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1ZercI-0000ck-Oc for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 23 Sep 2015 21:30:19 +0000
Content-Disposition: inline
In-Reply-To: <011d01d0f5df$c54267c0$4fc73740$@samsung.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Chao Yu <chao2.yu@samsung.com>
Cc: 'Marc Lehmann' <schmorp@schmorp.de>, linux-f2fs-devel@lists.sourceforge.net

Thanks Chao.

That's right.

On Wed, Sep 23, 2015 at 05:10:21PM +0800, Chao Yu wrote:
> Hi Marc,
> 
> The max hardlink number was increased to 0xffffffff by Jaegeuk in 4.3 rc1
> Kernel, we can use it directly through backport.
> 
> >From a6db67f06fd9f6b1ddb11bcf4d7e8e8a86908d01 Mon Sep 17 00:00:00 2001
> From: Jaegeuk Kim <jaegeuk@kernel.org>
> Date: Mon, 10 Aug 2015 15:01:12 -0700
> Subject: [PATCH] f2fs: increase the number of max hard links
> 
> This patch increases the number of maximum hard links for one file.
> 
> Reviewed-by: Chao Yu <chao2.yu@samsung.com>
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> ---
>  fs/f2fs/f2fs.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index 23bfc0c..8308488 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -321,7 +321,7 @@ enum {
>  					 */
>  };
>  
> -#define F2FS_LINK_MAX		32000	/* maximum link count per file */
> +#define F2FS_LINK_MAX	0xffffffff	/* maximum link count per file */
>  
>  #define MAX_DIR_RA_PAGES	4	/* maximum ra pages of dir */
>  
> -- 
> 2.5.2

------------------------------------------------------------------------------
Monitor Your Dynamic Infrastructure at Any Scale With Datadog!
Get real-time metrics from all of your servers, apps and tools
in one place.
SourceForge users - Click here to start your Free Trial of Datadog now!
http://pubads.g.doubleclick.net/gampad/clk?id=241902991&iu=/4140
