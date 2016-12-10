From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH] mkfs.f2fs: give random checkpoint version
Date: Sat, 10 Dec 2016 15:42:55 +0800
Message-ID: <e4549e48-142d-13ee-b224-2b59d8bef2a6@huawei.com>
References: <20161125023256.80540-1-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <yuchao0@huawei.com>) id 1cFcJR-0006xH-6P
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 10 Dec 2016 07:43:17 +0000
Received: from szxga03-in.huawei.com ([119.145.14.66])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1cFcJP-0003VG-5x
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 10 Dec 2016 07:43:17 +0000
In-Reply-To: <20161125023256.80540-1-jaegeuk@kernel.org>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Jaegeuk Kim <jaegeuk@kernel.org>, linux-f2fs-devel@lists.sourceforge.net

Hi Jaegeuk,

On 2016/11/25 10:32, Jaegeuk Kim wrote:
> This is to avoid wrong recovery during xfstests.
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> ---
>  mkfs/f2fs_format.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mkfs/f2fs_format.c b/mkfs/f2fs_format.c
> index 9a536f0..d2254e7 100644
> --- a/mkfs/f2fs_format.c
> +++ b/mkfs/f2fs_format.c
> @@ -507,7 +507,7 @@ static int f2fs_write_check_point_pack(void)
>  	}
>  
>  	/* 1. cp page 1 of checkpoint pack 1 */
> -	set_cp(checkpoint_ver, 1);
> +	cp->checkpoint_ver = rand();

I can see the last patch merged in upstream is:

+	cp->checkpoint_ver = rand() | 0x1;

Any difference and why don't we use set_cp?

Thanks,

>  	set_cp(cur_node_segno[0], c.cur_seg[CURSEG_HOT_NODE]);
>  	set_cp(cur_node_segno[1], c.cur_seg[CURSEG_WARM_NODE]);
>  	set_cp(cur_node_segno[2], c.cur_seg[CURSEG_COLD_NODE]);
> 


------------------------------------------------------------------------------
Developer Access Program for Intel Xeon Phi Processors
Access to Intel Xeon Phi processor-based developer platforms.
With one year of Intel Parallel Studio XE.
Training and support from Colfax.
Order your platform today.http://sdm.link/xeonphi
