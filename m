From: Chao Yu <chao@kernel.org>
Subject: Re: [PATCH] f2fs: check free_sections for defragmentation
Date: Wed, 7 Sep 2016 21:35:30 +0800
Message-ID: <33559c8d-fa39-219c-fff5-18e5586957e7@kernel.org>
References: <20160901204605.21448-1-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chao@kernel.org>) id 1bhd13-0000jl-2o
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 07 Sep 2016 13:35:49 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1bhd12-0000j4-5y
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 07 Sep 2016 13:35:49 +0000
In-Reply-To: <20160901204605.21448-1-jaegeuk@kernel.org>
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

On 2016/9/2 4:46, Jaegeuk Kim wrote:
> Fix wrong condition check for defragmentation of a file.
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> ---
>  fs/f2fs/file.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> index 37c24be..a8aa6fd 100644
> --- a/fs/f2fs/file.c
> +++ b/fs/f2fs/file.c
> @@ -2037,7 +2037,7 @@ static int f2fs_defragment_range(struct f2fs_sb_info *sbi,
>  	 * avoid defragment running in SSR mode when free section are allocated
>  	 * intensively
>  	 */
> -	if (has_not_enough_free_secs(sbi, sec_num)) {
> +	if (free_sections(sbi) <= sec_num) {

Why don't we check dirty dentry/node/imeta blocks here? they will be generated
at any time after f2fs_balance_fs. So, isn't original condition more strict than
new one?

Thanks,

>  		err = -EAGAIN;
>  		goto out;
>  	}
> 

------------------------------------------------------------------------------
