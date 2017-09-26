From: Chao Yu <chao@kernel.org>
Subject: Re: [PATCH v2] f2fs: allow readpages with NULL file
 pointer
Date: Tue, 26 Sep 2017 20:40:11 +0800
Message-ID: <412b2f13-0605-fa43-a334-05b7d8047d55@kernel.org>
References: <9047C53C18267742AB12E43B65C7F9F70BBE87E3@dggemi505-mbs.china.huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
 helo=mx.sourceforge.net)
 by sfs-ml-1.v29.ch3.sourceforge.com with esmtps (TLSv1:DHE-RSA-AES256-SHA:256)
 (Exim 4.89) (envelope-from <chao@kernel.org>) id 1dwpA6-00089V-RK
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 26 Sep 2017 12:40:30 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
 (Exim 4.76) id 1dwpA2-0003p0-Tj
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 26 Sep 2017 12:40:30 +0000
In-Reply-To: <9047C53C18267742AB12E43B65C7F9F70BBE87E3@dggemi505-mbs.china.huawei.com>
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
To: "gaoxiang (P)" <gaoxiang25@huawei.com>, "jaegeuk@kernel.org" <jaegeuk@kernel.org>
Cc: "linux-f2fs-devel@lists.sourceforge.net" <linux-f2fs-devel@lists.sourceforge.net>

On 2017/9/25 19:05, gaoxiang (P) wrote:
> Keep in line with the other Linux file system implementations
> since page_cache_sync_readahead supports NULL file pointer,
> and thus we can readahead data by f2fs itself without file opening
> (something like the btrfs behavior).
> 
> Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,

> ---
>  fs/f2fs/data.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> index 95f30f0..506281d 100644
> --- a/fs/f2fs/data.c
> +++ b/fs/f2fs/data.c
> @@ -1333,7 +1333,7 @@ static int f2fs_read_data_pages(struct file *file,
>  			struct address_space *mapping,
>  			struct list_head *pages, unsigned nr_pages)
>  {
> -	struct inode *inode = file->f_mapping->host;
> +	struct inode *inode = mapping->host;
>  	struct page *page = list_last_entry(pages, struct page, lru);
>  
>  	trace_f2fs_readpages(inode, page, nr_pages);
> 

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
