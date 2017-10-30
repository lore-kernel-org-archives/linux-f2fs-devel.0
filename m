From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH] f2fs: optimize __update_nat_bits
Date: Mon, 30 Oct 2017 17:39:20 +0800
Message-ID: <cc4f3491-c3ff-a55a-84ca-ca540c51aa14@huawei.com>
References: <CGME20171030072058epcas2p153d0b5c921ea4d3f3da6c6fd9baa5124@epcas2p1.samsung.com>
 <000e01d3514f$a93addf0$fbb099d0$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
 helo=mx.sourceforge.net)
 by sfs-ml-3.v29.ch3.sourceforge.com with esmtps (TLSv1:DHE-RSA-AES256-SHA:256)
 (Exim 4.89) (envelope-from <yuchao0@huawei.com>) id 1e96Yg-0001DU-9C
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 30 Oct 2017 09:40:38 +0000
Received: from szxga04-in.huawei.com ([45.249.212.190])
 by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
 (Exim 4.76) id 1e96Ye-0005Ap-Th
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 30 Oct 2017 09:40:38 +0000
In-Reply-To: <000e01d3514f$a93addf0$fbb099d0$@samsung.com>
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
To: Fan Li <fanofcode.li@samsung.com>, jaegeuk@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

On 2017/10/30 15:19, Fan Li wrote:
> Make three modification for __update_nat_bits:
> 1. Take the codes of dealing the nat with nid 0 out of the loop
>     Such nat only needs to be dealt with once at beginning.
> 2. Use " nat_index == 0" instead of " start_nid == 0" to decide if it's the first nat block
>     It's better that we don't assume @start_nid is the first nid of the nat block it's in.
> 3. Use " if (nat_blk->entries[i].block_addr != NULL_ADDR)" to explicitly comfirm the value of block_addr
>     use constant to make sure the codes is right, even if the value of NULL_ADDR changes.
> 
> Signed-off-by: Fan li <fanofcode.li@samsung.com>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,

> ---
>  fs/f2fs/node.c | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
> index ac629d6..b97a031 100644
> --- a/fs/f2fs/node.c
> +++ b/fs/f2fs/node.c
> @@ -2407,15 +2407,17 @@ static void __update_nat_bits(struct f2fs_sb_info *sbi, nid_t start_nid,
>         unsigned int nat_index = start_nid / NAT_ENTRY_PER_BLOCK;
>         struct f2fs_nat_block *nat_blk = page_address(page);
>         int valid = 0;
> -       int i;
> +       int i = 0;
> 
>         if (!enabled_nat_bits(sbi, NULL))
>                 return;
> 
> -       for (i = 0; i < NAT_ENTRY_PER_BLOCK; i++) {
> -               if (start_nid == 0 && i == 0)
> -                       valid++;
> -               if (nat_blk->entries[i].block_addr)
> +       if (nat_index == 0) {
> +               valid = 1;
> +               i = 1;
> +       }
> +       for (; i < NAT_ENTRY_PER_BLOCK; i++) {
> +               if (nat_blk->entries[i].block_addr != NULL_ADDR)
>                         valid++;
>         }
>         if (valid == 0) {
> --
> 2.7.4
> 
> 
> 


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
