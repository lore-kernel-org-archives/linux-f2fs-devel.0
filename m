From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH] fs: f2fs: Adding new return type vm_fault_t
Date: Mon, 16 Apr 2018 09:47:58 +0800
Message-ID: <86005c7f-136e-998d-e756-327b5df4d776@huawei.com>
References: <20180414201001.GA20256@jordon-HP-15-Notebook-PC>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <yuchao0@huawei.com>) id 1f7tFq-0001wS-Q6
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 16 Apr 2018 01:48:26 +0000
Received: from szxga05-in.huawei.com ([45.249.212.191] helo=huawei.com)
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1f7tFo-006YOK-2F
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 16 Apr 2018 01:48:26 +0000
In-Reply-To: <20180414201001.GA20256@jordon-HP-15-Notebook-PC>
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
To: Souptick Joarder <jrdr.linux@gmail.com>, jaegeuk@kernel.org
Cc: willy@infradead.org, linux-f2fs-devel@lists.sourceforge.net

On 2018/4/15 4:10, Souptick Joarder wrote:
> Use new return type vm_fault_t for page_mkwrite
> and fault handler.
> 
> Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
> Reviewed-by: Matthew Wilcox <mawilcox@microsoft.com>

Acked-by: Chao Yu <yuchao0@huawei.com>

Thanks,

> ---
>  fs/f2fs/file.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> index 672a542..045337a 100644
> --- a/fs/f2fs/file.c
> +++ b/fs/f2fs/file.c
> @@ -33,19 +33,19 @@
>  #include "trace.h"
>  #include <trace/events/f2fs.h>
>  
> -static int f2fs_filemap_fault(struct vm_fault *vmf)
> +static vm_fault_t f2fs_filemap_fault(struct vm_fault *vmf)
>  {
>  	struct inode *inode = file_inode(vmf->vma->vm_file);
> -	int err;
> +	vm_fault_t ret;
>  
>  	down_read(&F2FS_I(inode)->i_mmap_sem);
> -	err = filemap_fault(vmf);
> +	ret = filemap_fault(vmf);
>  	up_read(&F2FS_I(inode)->i_mmap_sem);
>  
> -	return err;
> +	return ret;
>  }
>  
> -static int f2fs_vm_page_mkwrite(struct vm_fault *vmf)
> +static vm_fault_t f2fs_vm_page_mkwrite(struct vm_fault *vmf)
>  {
>  	struct page *page = vmf->page;
>  	struct inode *inode = file_inode(vmf->vma->vm_file);
> 


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
