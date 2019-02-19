From: Eric Biggers <ebiggers@kernel.org>
Subject: Re: [RFC PATCH 05/10] fsverity: Add call back to decide
 if verity check has to be performed
Date: Tue, 19 Feb 2019 15:26:49 -0800
Message-ID: <20190219232649.GF12177@gmail.com>
References: <20190218100433.20048-1-chandan@linux.ibm.com>
 <20190218100433.20048-6-chandan@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <ebiggers@kernel.org>) id 1gwEmy-0007mv-U8
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 19 Feb 2019 23:27:00 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1gwEmx-001JmR-Hz
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 19 Feb 2019 23:27:00 +0000
Content-Disposition: inline
In-Reply-To: <20190218100433.20048-6-chandan@linux.ibm.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Chandan Rajendra <chandan@linux.ibm.com>
Cc: tytso@mit.edu, linux-f2fs-devel@lists.sourceforge.net, linux-fscrypt@vger.kernel.org, adilger.kernel@dilger.ca, jaegeuk@kernel.org, linux-ext4@vger.kernel.org

Hi Chandan,

On Mon, Feb 18, 2019 at 03:34:28PM +0530, Chandan Rajendra wrote:
> Ext4 and F2FS store verity metadata in data extents (beyond
> inode->i_size) associated with a file. But other filesystems might
> choose alternative means to store verity metadata. Hence this commit
> adds a callback function pointer to 'struct fsverity_operations' to help
> in deciding if verity operation needs to performed against a page-cache
> page holding file data.
> 
> Signed-off-by: Chandan Rajendra <chandan@linux.ibm.com>
> ---
>  fs/ext4/super.c          | 9 +++++++++
>  fs/post_read_process.c   | 5 +++--
>  include/linux/fsverity.h | 1 +
>  3 files changed, 13 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index 9314dddfbf34..2d7781ab6824 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -1428,10 +1428,19 @@ static struct page *ext4_read_verity_metadata_page(struct inode *inode,
>  	return read_mapping_page(inode->i_mapping, index, NULL);
>  }
>  
> +static bool ext4_verity_required(struct inode *inode, pgoff_t index)
> +{
> +	if (index < ((i_size_read(inode) + PAGE_SIZE - 1) >> PAGE_SHIFT))
> +		return true;
> +	else
> +		return false;
> +}

This can be simplified to:

	return index < (i_size_read(inode) + PAGE_SIZE - 1) >> PAGE_SHIFT;

> +
>  static const struct fsverity_operations ext4_verityops = {
>  	.set_verity		= ext4_set_verity,
>  	.get_metadata_end	= ext4_get_verity_metadata_end,
>  	.read_metadata_page	= ext4_read_verity_metadata_page,
> +	.verity_required	= ext4_verity_required,
>  };
>  #endif /* CONFIG_FS_VERITY */

Doesn't f2fs need this too?  This patch only changes ext4.

>  
> diff --git a/fs/post_read_process.c b/fs/post_read_process.c
> index 9720eeff0160..1f8663d70247 100644
> --- a/fs/post_read_process.c
> +++ b/fs/post_read_process.c
> @@ -79,8 +79,9 @@ struct bio_post_read_ctx *get_bio_post_read_ctx(struct inode *inode,
>  	if (IS_ENCRYPTED(inode) && S_ISREG(inode->i_mode))
>  		post_read_steps |= 1 << STEP_DECRYPT;
>  #ifdef CONFIG_FS_VERITY
> -	if (inode->i_verity_info != NULL &&
> -		(index < ((i_size_read(inode) + PAGE_SIZE - 1) >> PAGE_SHIFT)))
> +	if (inode->i_verity_info != NULL
> +		&& inode->i_sb->s_vop->verity_required
> +		&& inode->i_sb->s_vop->verity_required(inode, index))
>  		post_read_steps |= 1 << STEP_VERITY;

If ->verity_required is NULL, shouldn't that be equivalent to
->verity_required() returning true?

>  #endif
>  	if (post_read_steps) {
> diff --git a/include/linux/fsverity.h b/include/linux/fsverity.h
> index 7c33b42abf1b..b83712d6c79a 100644
> --- a/include/linux/fsverity.h
> +++ b/include/linux/fsverity.h
> @@ -18,6 +18,7 @@ struct fsverity_operations {
>  	int (*set_verity)(struct inode *inode, loff_t data_i_size);
>  	int (*get_metadata_end)(struct inode *inode, loff_t *metadata_end_ret);
>  	struct page *(*read_metadata_page)(struct inode *inode, pgoff_t index);
> +	bool (*verity_required)(struct inode *inode, pgoff_t index);
>  };
>  
>  #ifdef CONFIG_FS_VERITY
> -- 
> 2.19.1
> 

- Eric
