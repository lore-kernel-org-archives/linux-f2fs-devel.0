From: heyunlei <heyunlei@huawei.com>
Subject: Re: [PATCH 4/7] resize.f2fs: get latest free segments
Date: Thu, 3 Nov 2016 14:53:20 +0800
Message-ID: <911fa82d-b2b8-5d0f-c469-09f39c9624a5@huawei.com>
References: <20161103052846.72244-1-jaegeuk@kernel.org>
	<20161103052846.72244-4-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <heyunlei@huawei.com>) id 1c2BuP-0008Oq-1J
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 03 Nov 2016 06:53:57 +0000
Received: from [119.145.14.52] (helo=szxga04-in.huawei.com)
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1c2BuN-0007jo-Lq
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 03 Nov 2016 06:53:57 +0000
In-Reply-To: <20161103052846.72244-4-jaegeuk@kernel.org>
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


Hi, Kim
On 2016/11/3 13:28, Jaegeuk Kim wrote:
> The # of free segments can be changed by defragmentation.
>
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> ---
>  fsck/resize.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fsck/resize.c b/fsck/resize.c
> index 5dc73a8..4813de7 100644
> --- a/fsck/resize.c
> +++ b/fsck/resize.c
> @@ -424,7 +424,7 @@ static void rebuild_checkpoint(struct f2fs_sb_info *sbi,
>  	set_cp(overprov_segment_count, get_cp(overprov_segment_count) +
>  						get_cp(rsvd_segment_count));
>
> -	free_segment_count = get_cp(free_segment_count);
> +	free_segment_count = get_free_segments(sbi);

f2fs_defragment will write a checkpoint and then update free_segment_count
by get_free_segments(sbi)o<
 Is it righto<

Thankso<

>  	new_segment_count = get_newsb(segment_count_main) -
>  					get_sb(segment_count_main);
>
>


------------------------------------------------------------------------------
Developer Access Program for Intel Xeon Phi Processors
Access to Intel Xeon Phi processor-based developer platforms.
With one year of Intel Parallel Studio XE.
Training and support from Colfax.
Order your platform today. http://sdm.link/xeonphi
