From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH 2/2] f2fs: add a case of no need to read a
 page in write begin
Date: Mon, 19 Dec 2016 15:52:54 -0800
Message-ID: <20161219235254.GB2901@jaegeuk.local>
References: <20161216120719.3565-1-heyunlei@huawei.com>
	<20161216120719.3565-2-heyunlei@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1cJ7jt-0005t0-30
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 19 Dec 2016 23:53:05 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1cJ7jr-0002yE-V8
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 19 Dec 2016 23:53:05 +0000
Content-Disposition: inline
In-Reply-To: <20161216120719.3565-2-heyunlei@huawei.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Yunlei He <heyunlei@huawei.com>
Cc: heyunlei@huwei.com, linux-f2fs-devel@lists.sourceforge.net

Hi,

On 12/16, Yunlei He wrote:
> If the range we write cover the whole valid data
> in the last page, we do not need to read it.
> 
> Signed-off-by: Yunlei He <heyunlei@huawei.com>
> ---
>  fs/f2fs/data.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> index b90fb01..d9f7339 100644
> --- a/fs/f2fs/data.c
> +++ b/fs/f2fs/data.c
> @@ -1715,6 +1715,9 @@ static int f2fs_write_begin(struct file *file, struct address_space *mapping,
>  	if (len == PAGE_SIZE || PageUptodate(page))
>  		return 0;
>  
> +	if (!(pos % PAGE_SHIFT) && (pos + len) > i_size_read(inode))

PAGE_SHIFT?

Do you mean like this?

	if (!(pos % PAGE_MASK) && (pos + len) >= i_size_read(inode))

And, it needs to change f2fs_write_end() together.

	/* Need to change comments */
	if (!PageUptodate(page)) {
		if (unlikely(copied != len))  <== like this?
			copied = 0;
		else
			...

Thanks,

> +		return 0;
> +
>  	if (blkaddr == NEW_ADDR) {
>  		zero_user_segment(page, 0, PAGE_SIZE);
>  		SetPageUptodate(page);
> -- 
> 2.10.1
> 
> 
> ------------------------------------------------------------------------------
> Check out the vibrant tech community on one of the world's most 
> engaging tech sites, SlashDot.org! http://sdm.link/slashdot
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

------------------------------------------------------------------------------
Developer Access Program for Intel Xeon Phi Processors
Access to Intel Xeon Phi processor-based developer platforms.
With one year of Intel Parallel Studio XE.
Training and support from Colfax.
Order your platform today.http://sdm.link/intel
