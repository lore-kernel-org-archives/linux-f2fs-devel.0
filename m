From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [f2fs-dev] [PATCH] f2fs: keep scanning until enough free nids are
 acquired
Date: Tue, 7 Nov 2017 13:45:52 +0800
Message-ID: <ff5a93ff-1046-182d-627c-a3a2efa3bfd6@huawei.com>
References: <CGME20171107030535epcas1p2094e05ca25eecd2140518cab7a39723d@epcas1p2.samsung.com>
 <001901d35775$47b598f0$d720cad0$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <001901d35775$47b598f0$d720cad0$@samsung.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Fan Li <fanofcode.li@samsung.com>, 'Chao Yu' <chao@kernel.org>, 'Jaegeuk Kim' <jaegeuk@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

On 2017/11/7 11:04, Fan Li wrote:
> In current version, after scan_free_nid_bits, the scan is over if nid_cnt[FREE_NID] != 0.
> In most cases, there are still free nids in the free list during the scan, and scan_free_nid_bits
> usually can't increase nid_cnt[FREE_NID].
> It causes that __build_free_nids is called many times without solving the shortage
> of the free nids. This patch fixes that.
> 
> Signed-off-by: Fan li <fanofcode.li@samsung.com>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,

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
> 
> 
> 
