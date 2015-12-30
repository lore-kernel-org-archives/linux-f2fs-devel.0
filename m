From: Chao Yu <chao@kernel.org>
Subject: Re: [PATCH 2/3] f2fs: support finding extents after isize
Date: Wed, 30 Dec 2015 21:27:49 +0800
Message-ID: <5683DBD5.1050509@kernel.org>
References: <000d01d142e2$fab05fc0$f0111f40$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chao@kernel.org>) id 1aEGnN-00070H-Ip
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 30 Dec 2015 13:28:05 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1aEGnM-0005lY-Kf for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 30 Dec 2015 13:28:05 +0000
In-Reply-To: <000d01d142e2$fab05fc0$f0111f40$@samsung.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Fan Li <fanofcode.li@samsung.com>, 'Jaegeuk Kim' <jaegeuk@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net

Hi,

On 12/30/15 5:17 PM, Fan Li wrote:
> f2fs allows preallocation beyond isize, but f2fs_fiemap only look up
> extents within isize. Therefore add this support.
> 
> Note: It's possible that there are holes after isize, for example,
> fallocate  multiple discontinuous extents after isize with 
> FALLOC_FL_KEEP_SIZE set. Since I can tell no differences between
> EOF and holes from return of get_data_block, I'm afaid this patch
> can't support such scenarios. 

As you mentioned, preallocated block beyond isize can be allocated in f2fs, and
we are trying to support mapping extents across whole data space of inode, so
why we treat theses extents inside i_size and outside i_size separately? IMO,
instead using i_size, we should use max blocks as boundary.

Most important, this interface still can't support finding all extents after
i_size, which looks buggy for our user.

Thanks,

> 
> 
> Signed-off-by: Fan li <fanofcode.li@samsung.com>
> ---
>  fs/f2fs/data.c |    7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
> 
> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> index a9a4d89..f89cf07 100644
> --- a/fs/f2fs/data.c
> +++ b/fs/f2fs/data.c
> @@ -798,12 +798,6 @@ int f2fs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
>  	isize = i_size_read(inode);
>  
>  	mutex_lock(&inode->i_mutex);
> -	if (start >= isize)
> -		goto out;
> -
> -	if (start + len > isize)
> -		len = isize - start;
> -
>  	if (logical_to_blk(inode, len) == 0)
>  		len = blk_to_logical(inode, 1);
>  
> @@ -829,6 +823,7 @@ next:
>  		 * punch holes beyond isize and keep size unchanged.
>  		 */
>  		flags |= FIEMAP_EXTENT_LAST;
> +		last_blk = start_blk - 1;
>  	}
>  
>  	if (size)
> 

------------------------------------------------------------------------------
