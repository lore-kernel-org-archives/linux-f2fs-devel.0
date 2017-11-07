From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [f2fs-dev] [PATCH] f2fs: keep scanning until enough free nids
 are acquired
Date: Mon, 6 Nov 2017 19:40:34 -0800
Message-ID: <20171107034034.GC92599@jaegeuk-macbookpro.roam.corp.google.com>
References: <CGME20171107030535epcas1p2094e05ca25eecd2140518cab7a39723d@epcas1p2.samsung.com>
 <001901d35775$47b598f0$d720cad0$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <001901d35775$47b598f0$d720cad0$@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Fan Li <fanofcode.li@samsung.com>
Cc: 'Chao Yu' <chao@kernel.org>, 'Chao Yu' <yuchao0@huawei.com>, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

Hi,

I merged this patch after fixing some broken format. Could you please check
your email configuration?

Thanks,

On 11/07, Fan Li wrote:
> In current version, after scan_free_nid_bits, the scan is over if nid_cnt[FREE_NID] != 0.
> In most cases, there are still free nids in the free list during the scan, and scan_free_nid_bits
> usually can't increase nid_cnt[FREE_NID].
> It causes that __build_free_nids is called many times without solving the shortage
> of the free nids. This patch fixes that.
> 
> Signed-off-by: Fan li <fanofcode.li@samsung.com>
> ---
>  fs/f2fs/node.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
> index 3d0d1be..5cef118 100644
> --- a/fs/f2fs/node.c
> +++ b/fs/f2fs/node.c
> @@ -2010,7 +2010,7 @@ static void __build_free_nids(struct f2fs_sb_info *sbi, bool sync, bool mount)
>                 /* try to find free nids in free_nid_bitmap */
>                 scan_free_nid_bits(sbi);
> 
> -               if (nm_i->nid_cnt[FREE_NID])
> +               if (nm_i->nid_cnt[FREE_NID] >= NAT_ENTRY_PER_BLOCK)
>                         return;
>         }
> 
> --
> 2.7.4
