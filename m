From: Chao Yu <chao@kernel.org>
Subject: Re: [f2fs-dev] [PATCH] f2fs: validate before set/clear free nat
 bitmap
Date: Sat, 11 Nov 2017 08:51:12 +0800
Message-ID: <8fc91640-b15a-452b-2bfc-d6603a80c58d@kernel.org>
References: <CGME20171110074232epcas5p3c1468e254cb24d7fefdea4175f53469e@epcas5p3.samsung.com>
 <000101d359f7$77d1aae0$677500a0$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <000101d359f7$77d1aae0$677500a0$@samsung.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: LiFan <fanofcode.li@samsung.com>, 'Chao Yu' <yuchao0@huawei.com>, 'Jaegeuk Kim' <jaegeuk@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, chao@kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

On 2017/11/10 15:41, LiFan wrote:
> In flush_nat_entries, all dirty nats will be flushed and if
> their new address isn't NULL_ADDR, their bitmaps will be updated,
> the free_nid_count of the bitmaps will be increaced regardless
> of whether the nats have already been occupied before.
> This could lead to wrong free_nid_count.
> So this patch checks the status of the bits beforeactually
> set/clear them.

Thanks for fixing this. :)

Please add:

Fixes: 586d1492f301 ("f2fs: skip scanning free nid bitmap of full NAT blocks")

> 
> Signed-off-by: Fan li <fanofcode.li@samsung.com>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,

> ---
>  fs/f2fs/node.c | 17 ++++++++++-------
>  1 file changed, 10 insertions(+), 7 deletions(-)
> 
> diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
> index d234c6e..b965a53 100644
> --- a/fs/f2fs/node.c
> +++ b/fs/f2fs/node.c
> @@ -1906,15 +1906,18 @@ static void update_free_nid_bitmap(struct
> f2fs_sb_info *sbi, nid_t nid,
>  	if (!test_bit_le(nat_ofs, nm_i->nat_block_bitmap))
>  		return;
>  
> -	if (set)
> +	if (set) {
> +		if (test_bit_le(nid_ofs, nm_i->free_nid_bitmap[nat_ofs]))
> +			return;
>  		__set_bit_le(nid_ofs, nm_i->free_nid_bitmap[nat_ofs]);
> -	else
> -		__clear_bit_le(nid_ofs, nm_i->free_nid_bitmap[nat_ofs]);
> -
> -	if (set)
>  		nm_i->free_nid_count[nat_ofs]++;
> -	else if (!build)
> -		nm_i->free_nid_count[nat_ofs]--;
> +	} else {
> +		if (!test_bit_le(nid_ofs, nm_i->free_nid_bitmap[nat_ofs]))
> +			return;
> +		__clear_bit_le(nid_ofs, nm_i->free_nid_bitmap[nat_ofs]);
> +		if (!build)
> +			nm_i->free_nid_count[nat_ofs]--;
> +	}
>  }
>  
>  static void scan_nat_page(struct f2fs_sb_info *sbi,
> 
