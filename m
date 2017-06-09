From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH] f2fs: use proper variable name
Date: Fri, 9 Jun 2017 14:00:16 +0800
Message-ID: <4cfa5ab3-ef4b-3089-5513-b7cc35f89805@huawei.com>
References: <2114b573.218.15c89d6ccd8.Coremail.kernelpatch@126.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <yuchao0@huawei.com>) id 1dJCwG-0003OJ-Uh
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 09 Jun 2017 05:58:28 +0000
Received: from szxga03-in.huawei.com ([45.249.212.189])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1dJCwF-0002q8-DN
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 09 Jun 2017 05:58:28 +0000
In-Reply-To: <2114b573.218.15c89d6ccd8.Coremail.kernelpatch@126.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Tiezhu Yang <kernelpatch@126.com>, jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net

On 2017/6/9 6:32, Tiezhu Yang wrote:
> It is better to use variable name "inline_dentry" instead of "dentry_blk"
> when data type is "struct f2fs_inline_dentry". This patch has no functional
> changes, just to make code more readable especially when call the function
> make_dentry_ptr_inline() and f2fs_convert_inline_dir().
> 
> Signed-off-by: Tiezhu Yang <kernelpatch@126.com>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,

> ---
>  fs/f2fs/inline.c | 22 +++++++++++-----------
>  1 file changed, 11 insertions(+), 11 deletions(-)
> 
> diff --git a/fs/f2fs/inline.c b/fs/f2fs/inline.c
> index e4c527c..e0fd437 100644
> --- a/fs/f2fs/inline.c
> +++ b/fs/f2fs/inline.c
> @@ -316,12 +316,12 @@ struct f2fs_dir_entry *find_in_inline_dir(struct inode *dir,
>  int make_empty_inline_dir(struct inode *inode, struct inode *parent,
>  							struct page *ipage)
>  {
> -	struct f2fs_inline_dentry *dentry_blk;
> +	struct f2fs_inline_dentry *inline_dentry;
>  	struct f2fs_dentry_ptr d;
>  
> -	dentry_blk = inline_data_addr(ipage);
> +	inline_dentry = inline_data_addr(ipage);
>  
> -	make_dentry_ptr_inline(NULL, &d, dentry_blk);
> +	make_dentry_ptr_inline(NULL, &d, inline_dentry);
>  	do_make_empty_dir(inode, parent, &d);
>  
>  	set_page_dirty(ipage);
> @@ -500,7 +500,7 @@ int f2fs_add_inline_entry(struct inode *dir, const struct qstr *new_name,
>  	struct page *ipage;
>  	unsigned int bit_pos;
>  	f2fs_hash_t name_hash;
> -	struct f2fs_inline_dentry *dentry_blk = NULL;
> +	struct f2fs_inline_dentry *inline_dentry = NULL;
>  	struct f2fs_dentry_ptr d;
>  	int slots = GET_DENTRY_SLOTS(new_name->len);
>  	struct page *page = NULL;
> @@ -510,11 +510,11 @@ int f2fs_add_inline_entry(struct inode *dir, const struct qstr *new_name,
>  	if (IS_ERR(ipage))
>  		return PTR_ERR(ipage);
>  
> -	dentry_blk = inline_data_addr(ipage);
> -	bit_pos = room_for_filename(&dentry_blk->dentry_bitmap,
> +	inline_dentry = inline_data_addr(ipage);
> +	bit_pos = room_for_filename(&inline_dentry->dentry_bitmap,
>  						slots, NR_INLINE_DENTRY);
>  	if (bit_pos >= NR_INLINE_DENTRY) {
> -		err = f2fs_convert_inline_dir(dir, ipage, dentry_blk);
> +		err = f2fs_convert_inline_dir(dir, ipage, inline_dentry);
>  		if (err)
>  			return err;
>  		err = -EAGAIN;
> @@ -534,7 +534,7 @@ int f2fs_add_inline_entry(struct inode *dir, const struct qstr *new_name,
>  	f2fs_wait_on_page_writeback(ipage, NODE, true);
>  
>  	name_hash = f2fs_dentry_hash(new_name, NULL);
> -	make_dentry_ptr_inline(NULL, &d, dentry_blk);
> +	make_dentry_ptr_inline(NULL, &d, inline_dentry);
>  	f2fs_update_dentry(ino, mode, &d, new_name, name_hash, bit_pos);
>  
>  	set_page_dirty(ipage);
> @@ -586,14 +586,14 @@ bool f2fs_empty_inline_dir(struct inode *dir)
>  	struct f2fs_sb_info *sbi = F2FS_I_SB(dir);
>  	struct page *ipage;
>  	unsigned int bit_pos = 2;
> -	struct f2fs_inline_dentry *dentry_blk;
> +	struct f2fs_inline_dentry *inline_dentry;
>  
>  	ipage = get_node_page(sbi, dir->i_ino);
>  	if (IS_ERR(ipage))
>  		return false;
>  
> -	dentry_blk = inline_data_addr(ipage);
> -	bit_pos = find_next_bit_le(&dentry_blk->dentry_bitmap,
> +	inline_dentry = inline_data_addr(ipage);
> +	bit_pos = find_next_bit_le(&inline_dentry->dentry_bitmap,
>  					NR_INLINE_DENTRY,
>  					bit_pos);
>  
> 


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
