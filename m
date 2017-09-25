From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH v2] f2fs: allow readpages with NULL file
 pointer
Date: Mon, 25 Sep 2017 09:35:57 +0800
Message-ID: <db00dc18-6c6b-8205-4994-cc13e0a43fa1@huawei.com>
References: <bb773ebc-6372-dae7-4642-10594d6e3c94@aol.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
 helo=mx.sourceforge.net)
 by sfs-ml-4.v29.ch3.sourceforge.com with esmtps (TLSv1:DHE-RSA-AES256-SHA:256)
 (Exim 4.89) (envelope-from <yuchao0@huawei.com>) id 1dwIJq-00034H-SH
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 25 Sep 2017 01:36:22 +0000
Received: from szxga05-in.huawei.com ([45.249.212.191])
 by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
 (Exim 4.76) id 1dwIJo-00026l-L5
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 25 Sep 2017 01:36:22 +0000
In-Reply-To: <bb773ebc-6372-dae7-4642-10594d6e3c94@aol.com>
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
To: Hsiang Kao <hsiangkao@aol.com>, jaegeuk@kernel.org, chao@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net

On 2017/9/24 2:45, Hsiang Kao via Linux-f2fs-devel wrote:
> Keep in line with the other Linux file system implementations
> since page_cache_sync_readahead supports NULL file pointer,
> and thus we can readahead data by f2fs itself without file opening
> (something like the btrfs behavior).
> 
> Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>

Just encounter applying failure with this patch:

Applying: f2fs: allow readpages with NULL file pointer
error: corrupt patch at line 18
Patch failed at 0001 f2fs: allow readpages with NULL file pointer

Could you check and adjust the email client configuration to avoid its
additional modification?

Thanks,

> ---
>   fs/f2fs/data.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> index 95f30f0..506281d 100644
> --- a/fs/f2fs/data.c
> +++ b/fs/f2fs/data.c
> @@ -1333,7 +1333,7 @@ static int f2fs_read_data_pages(struct file *file,
>   			struct address_space *mapping,
>   			struct list_head *pages, unsigned nr_pages)
>   {
> -	struct inode *inode = file->f_mapping->host;
> +	struct inode *inode = mapping->host;
>   	struct page *page = list_last_entry(pages, struct page, lru);
>    	trace_f2fs_readpages(inode, page, nr_pages);
> 


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
