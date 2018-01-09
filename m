From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH] f2fs: move set_cold_files after adding new
 node page in f2fs_create
Date: Tue, 9 Jan 2018 17:35:50 +0800
Message-ID: <affff153-1dc7-32f8-0285-2db5c11cf050@huawei.com>
References: <CGME20180109002317epcas2p1ecf6e4fbe5f80519cb4cede32a057e6e@epcas2p1.samsung.com>
 <1515457415-20645-1-git-send-email-daeho.jeong@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.191]
 helo=mx.sourceforge.net)
 by sfs-ml-1.v29.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 (envelope-from <yuchao0@huawei.com>) id 1eYqKK-0002SD-QE
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 09 Jan 2018 09:36:12 +0000
Received: from szxga05-in.huawei.com ([45.249.212.191] helo=huawei.com)
 by sfi-mx-1.v28.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 id 1eYqKI-0004cs-F1
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 09 Jan 2018 09:36:12 +0000
In-Reply-To: <1515457415-20645-1-git-send-email-daeho.jeong@samsung.com>
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
To: Daeho Jeong <daeho.jeong@samsung.com>, linux-f2fs-devel@lists.sourceforge.net
Cc: Youngjin Gil <youngjin.gil@samsung.com>

Hi Daeho,

On 2018/1/9 8:23, Daeho Jeong wrote:
> Now, we set flags of a newly created inode using set_cold_files() in
> advance of creating a new node page. By this, some inodes whose node
> page is not created yet can be linked into the global dirty list.
> 
> If the checkpoint is executed at this moment, the inode will be written
> back by writeback_single_inode() and finally update_inode_page() will
> fail to detach the inode from the global dirty list because the inode
> doesn't have a node page.
> 
> The problem is that the inode's state in VFS layer will become clean
> after execution of writeback_single_inode() and it's still linked in
> the global dirty list of f2fs and this will cause a kernel panic.

Before set_cold_files, In f2fs_new_inode, we will also dirty inode, so if
we only relocate code file initialization, would we suffer the same issue
due to below reason? If so, instead, how about check FI_NEW_INODE flag
during global dirty list flushing to decide whether we should flush that
inode? How do you think?

Thanks,

> 
> Signed-off-by: Daeho Jeong <daeho.jeong@samsung.com>
> Signed-off-by: Youngjin Gil <youngjin.gil@samsung.com>
> Tested-by: Hobin Woo <hobin.woo@samsung.com>
> ---
>  fs/f2fs/namei.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
> index 28bdf88..249dbef 100644
> --- a/fs/f2fs/namei.c
> +++ b/fs/f2fs/namei.c
> @@ -201,9 +201,6 @@ static int f2fs_create(struct inode *dir, struct dentry *dentry, umode_t mode,
>  	if (IS_ERR(inode))
>  		return PTR_ERR(inode);
>  
> -	if (!test_opt(sbi, DISABLE_EXT_IDENTIFY))
> -		set_cold_files(sbi, inode, dentry->d_name.name);
> -
>  	inode->i_op = &f2fs_file_inode_operations;
>  	inode->i_fop = &f2fs_file_operations;
>  	inode->i_mapping->a_ops = &f2fs_dblock_aops;
> @@ -213,6 +210,8 @@ static int f2fs_create(struct inode *dir, struct dentry *dentry, umode_t mode,
>  	err = f2fs_add_link(dentry, inode);
>  	if (err)
>  		goto out;
> +	if (!test_opt(sbi, DISABLE_EXT_IDENTIFY))
> +		set_cold_files(sbi, inode, dentry->d_name.name);
>  	f2fs_unlock_op(sbi);
>  
>  	alloc_nid_done(sbi, ino);
> 


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
