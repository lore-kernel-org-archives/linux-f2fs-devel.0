From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH RESEND v2] f2fs: validate before set/clear
 free nat bitmap
Date: Mon, 20 Nov 2017 10:58:35 +0800
Message-ID: <04b03e04-240e-f5fd-b2ac-1eb6091175ab@huawei.com>
References: <CGME20171114072142epcas5p1e7543c4f118db48ff8ad417894f964d2@epcas5p1.samsung.com>
 <002201d35d19$3837e870$a8a7b950$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.191]
 helo=mx.sourceforge.net)
 by sfs-ml-4.v29.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 (envelope-from <yuchao0@huawei.com>) id 1eGcIV-0002pf-El
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 20 Nov 2017 02:58:59 +0000
Received: from szxga04-in.huawei.com ([45.249.212.190])
 by sfi-mx-1.v28.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
 (Exim 4.89) id 1eGcIT-0006jO-FM
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 20 Nov 2017 02:58:59 +0000
In-Reply-To: <002201d35d19$3837e870$a8a7b950$@samsung.com>
Content-Language: en-US
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: LiFan <fanofcode.li@samsung.com>, 'Chao Yu' <chao@kernel.org>, 'Jaegeuk
 Kim' <jaegeuk@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

On 2017/11/14 15:20, LiFan wrote:
> In flush_nat_entries, all dirty nats will be flushed and if their new address
> isn't NULL_ADDR, their bitmaps will be updated, the free_nid_count of the
> bitmaps will be increased regardless of whether the nats have already been
> occupied before. This could lead to wrong free_nid_count.
> So this patch checks the status of the bits before actually set/clear them.
> 
> Fixes: 586d1492f301 ("f2fs: skip scanning free nid bitmap of full NAT blocks")
> 
> Signed-off-by: Fan li <fanofcode.li@samsung.com>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,

> ---
>  fs/f2fs/node.c | 17 ++++++++++-------
>  1 file changed, 10 insertions(+), 7 deletions(-)
> 
> diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c index d234c6e..b965a53 100644
> --- a/fs/f2fs/node.c
> +++ b/fs/f2fs/node.c
> @@ -1906,15 +1906,18 @@ static void update_free_nid_bitmap(struct f2fs_sb_info *sbi, nid_t nid,
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
> --
> 2.7.4
> 
> 
> 
> 


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
