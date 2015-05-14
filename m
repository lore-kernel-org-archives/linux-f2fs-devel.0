From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH] f2fs: fix building on 32-bit architectures
Date: Wed, 13 May 2015 17:23:09 -0700
Message-ID: <20150514002309.GB68412@jaegeuk-mac02>
References: <2179770.3R5P5nr1c7@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1Ysgvp-0004Tc-65
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 14 May 2015 00:23:21 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1Ysgvn-0004bn-T2 for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 14 May 2015 00:23:21 +0000
Content-Disposition: inline
In-Reply-To: <2179770.3R5P5nr1c7@wuerfel>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Yossi Goldfill <ygoldfill@radianmemory.com>

Hi Arnd,

Thank you for the patch.
Merged and pushed to -next. :)

Thanks,

On Wed, May 13, 2015 at 10:49:58PM +0200, Arnd Bergmann wrote:
> A bug fix to the debug output extended the type of some local
> variables to 64-bit, which now causes the kernel to fail building
> because of missing 64-bit division functions:
> 
> ERROR: "__aeabi_uldivmod" [fs/f2fs/f2fs.ko] undefined!
> 
> In the kernel, we have to use div_u64 or do_div to do this,
> in order to annotate that this is an expensive operation.
> 
> As the function is only called for debug out, we know this
> is not performance critical, so it is safe to use div_u64.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Fixes: d1f85bd38db19 ("f2fs: avoid value overflow in showing current status")
> ---
> This patch is required for ARM allmodconfig builds.
> 
> diff --git a/fs/f2fs/debug.c b/fs/f2fs/debug.c
> index efbc83f07305..75176e0dd6c8 100644
> --- a/fs/f2fs/debug.c
> +++ b/fs/f2fs/debug.c
> @@ -113,10 +113,10 @@ static void update_sit_info(struct f2fs_sb_info *sbi)
>  			ndirty++;
>  		}
>  	}
> -	dist = MAIN_SECS(sbi) * hblks_per_sec * hblks_per_sec / 100;
> -	si->bimodal = bimodal / dist;
> +	dist = div_u64(MAIN_SECS(sbi) * hblks_per_sec * hblks_per_sec, 100);
> +	si->bimodal = div_u64(bimodal, dist);
>  	if (si->dirty_count)
> -		si->avg_vblocks = total_vblocks / ndirty;
> +		si->avg_vblocks = div_u64(total_vblocks, ndirty);
>  	else
>  		si->avg_vblocks = 0;
>  }

------------------------------------------------------------------------------
One dashboard for servers and applications across Physical-Virtual-Cloud 
Widest out-of-the-box monitoring support with 50+ applications
Performance metrics, stats and reports that give you Actionable Insights
Deep dive visibility with transaction tracing using APM Insight.
http://ad.doubleclick.net/ddm/clk/290420510;117567292;y
