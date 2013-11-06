From: Gu Zheng <guz.fnst@cn.fujitsu.com>
Subject: Re: [PATCH] f2fs: avoid to use a NULL point in
	destroy_segment_manager
Date: Wed, 06 Nov 2013 11:41:27 +0800
Message-ID: <5279BA67.4040906@cn.fujitsu.com>
References: <000001ceda8d$5b185bd0$11491370$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <guz.fnst@cn.fujitsu.com>) id 1Vdu5q-0005um-Dc
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 06 Nov 2013 03:47:46 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1Vdu5m-0003hF-Lf for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 06 Nov 2013 03:47:46 +0000
In-Reply-To: <000001ceda8d$5b185bd0$11491370$@samsung.com>
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
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

On 11/06/2013 09:12 AM, Chao Yu wrote:

> A NULL point should avoid to be used in destroy_segment_manager after allocating memory fail for f2fs_sm_info.

Though without this patch it still can work well, because if it failed
to allocate f2fs_sm_info, the sit_info, free_info... all were NULL, and
the destory path(e.g. destroy_dirty_segmap) can deal with them well.
IMO, this patch is still a good catch. 

Regards,
Gu

> 
> Signed-off-by: Chao Yu <chao2.yu@samsung.com>
> ---
>  fs/f2fs/segment.c |    2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> index 3d4d5fc..ff363e6
> --- a/fs/f2fs/segment.c
> +++ b/fs/f2fs/segment.c
> @@ -1744,6 +1744,8 @@ static void destroy_sit_info(struct f2fs_sb_info *sbi)
>  void destroy_segment_manager(struct f2fs_sb_info *sbi)
>  {
>  	struct f2fs_sm_info *sm_info = SM_I(sbi);
> +	if (!sm_info)
> +		return;
>  	destroy_dirty_segmap(sbi);
>  	destroy_curseg(sbi);
>  	destroy_free_segmap(sbi);



------------------------------------------------------------------------------
November Webinars for C, C++, Fortran Developers
Accelerate application performance with scalable programming models. Explore
techniques for threading, error checking, porting, and tuning. Get the most 
from the latest Intel processors and coprocessors. See abstracts and register
http://pubads.g.doubleclick.net/gampad/clk?id=60136231&iu=/4140/ostg.clktrk
