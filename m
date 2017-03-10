From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH] f2fs: restrict write IO alignment condition
Date: Fri, 10 Mar 2017 10:50:05 -0800
Message-ID: <20170310185005.GC22979@jaegeuk.local>
References: <20170310093804.35928-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1cmPcD-0007Bf-LD
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 10 Mar 2017 18:50:13 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1cmPcC-0005A5-P6
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 10 Mar 2017 18:50:13 +0000
Content-Disposition: inline
In-Reply-To: <20170310093804.35928-1-yuchao0@huawei.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Chao Yu <yuchao0@huawei.com>
Cc: chao@kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

On 03/10, Chao Yu wrote:
> We should only align start offset of bio with defined IO_SIZE for below
> conditions:
> a. write IOs
> b. Out-place-update
> c. non-meta page
> 
> Signed-off-by: Chao Yu <yuchao0@huawei.com>
> ---
>  fs/f2fs/data.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> index 1375fef11146..3e6b0cc5e36a 100644
> --- a/fs/f2fs/data.c
> +++ b/fs/f2fs/data.c
> @@ -395,7 +395,9 @@ int f2fs_submit_page_mbio(struct f2fs_io_info *fio)
>  		__submit_merged_bio(io);
>  alloc_new:
>  	if (io->bio == NULL) {
> -		if ((fio->type == DATA || fio->type == NODE) &&
> +		if (!is_read && (fio->type == DATA || fio->type == NODE) &&
> +				bio_page->mapping != META_MAPPING(sbi) &&

BUG_ON(), since it's covered by fio->type == DATA || fio->type == NODE.

> +				fio->new_blkaddr != fio->old_blkaddr &&

BUG_ON(), since LFS mount option doesn't allow any in-place updates.

>  				fio->new_blkaddr & F2FS_IO_SIZE_MASK(sbi)) {

So, is_read is worth to check?

Thanks,

>  			err = -EAGAIN;
>  			if (!is_read)
> -- 
> 2.8.2.295.g3f1c1d0

------------------------------------------------------------------------------
Announcing the Oxford Dictionaries API! The API offers world-renowned
dictionary content that is easy and intuitive to access. Sign up for an
account today to start using our lexical data to power your apps and
projects. Get started today and enter our developer competition.
http://sdm.link/oxford
