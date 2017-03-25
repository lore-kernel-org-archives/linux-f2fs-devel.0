From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH 1/5] f2fs: relax node version check for
 victim data in gc
Date: Sat, 25 Mar 2017 17:05:28 +0800
Message-ID: <2b848126-cf2c-2145-083a-ae5ca77356b6@huawei.com>
References: <20170325075933.21072-1-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <yuchao0@huawei.com>) id 1crheD-00031n-7U
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 25 Mar 2017 09:06:09 +0000
Received: from [45.249.212.188] (helo=dggrg02-dlp.huawei.com)
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1crheB-0001Wo-9J
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 25 Mar 2017 09:06:09 +0000
In-Reply-To: <20170325075933.21072-1-jaegeuk@kernel.org>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

Hi Jaegeuk,

On 2017/3/25 15:59, Jaegeuk Kim wrote:
> - has_not_enough_free_secs
> node_secs: 0  dent_secs: 0  freed:0  free_segments:103  reserved:104
> 
>           - f2fs_gc
>              - get_victim_by_default
> alloc_mode 0, gc_mode 1, max_search 2672, offset 4654, ofs_unit 1
> 
>                 - do_garbage_collect
> start_segno 3976, end_segno 3977   type 0
> 
>                   - is_alive
> nid 22797, blkaddr 2131882, ofs_in_node 0, version 0x8/0x0
> 
>                    - gc_data_segment 766, segno 3976, block 512/426 not alive
> 
> So, this patch fixes subtle corrupted case where node version does not match
> to summary version which results in infinite loop by gc.
> 
> Reported-by: Yunlei He <heyunlei@huawei.com>
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> ---
>  fs/f2fs/gc.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
> index 939be88a8833..bbeee41aaf73 100644
> --- a/fs/f2fs/gc.c
> +++ b/fs/f2fs/gc.c
> @@ -551,8 +551,10 @@ static bool is_alive(struct f2fs_sb_info *sbi, struct f2fs_summary *sum,
>  	get_node_info(sbi, nid, dni);
>  
>  	if (sum->version != dni->version) {

If the node was been truncated, we will increase its version number, since it
was been truncated, so it will never be writebacked to storage, so the version
in summary will not be updated.

So this case can happen, shouldn't we just set SBI_NEED_FSCK for the case:
sum->version != dni->version - 1

Thanks,

> -		f2fs_put_page(node_page, 1);
> -		return false;
> +		f2fs_msg(sbi->sb, KERN_WARNING,
> +				"%s: valid data with mismatched node version.",
> +				__func__);
> +		set_sbi_flag(sbi, SBI_NEED_FSCK);
>  	}
>  
>  	*nofs = ofs_of_node(node_page);
> 


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
