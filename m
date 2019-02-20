From: Eric Biggers <ebiggers@kernel.org>
Subject: Re: [RFC PATCH 08/10] fsverity: Add call back to verify
 file holes
Date: Tue, 19 Feb 2019 16:35:07 -0800
Message-ID: <20190220003507.GH12177@gmail.com>
References: <20190218100433.20048-1-chandan@linux.ibm.com>
 <20190218100433.20048-9-chandan@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <ebiggers@kernel.org>) id 1gwFr4-0003UL-AD
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 20 Feb 2019 00:35:18 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1gwFr2-00APBY-Tg
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 20 Feb 2019 00:35:18 +0000
Content-Disposition: inline
In-Reply-To: <20190218100433.20048-9-chandan@linux.ibm.com>
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

On Mon, Feb 18, 2019 at 03:34:31PM +0530, Chandan Rajendra wrote:
> readpage() implmentations zero out part of the page-cache page mapping a
> file hole. This commit adds a call back to "struct fsverity_operations"
> which readpage() can invoke to verify the file hole.

I don't see why this is needed.  Since now CONFIG_FS_VERITY will be a bool,
can't you just call fsverity_verify_hole() directly?

> 
> Signed-off-by: Chandan Rajendra <chandan@linux.ibm.com>
> ---
>  fs/ext4/super.c          | 1 +
>  include/linux/fsverity.h | 1 +
>  2 files changed, 2 insertions(+)
> 
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index 4493ddc357c6..94e0d4b56653 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -1459,6 +1459,7 @@ static const struct fsverity_operations ext4_verityops = {
>  	.read_metadata_page	= ext4_read_verity_metadata_page,
>  	.verity_required	= ext4_verity_required,
>  	.readpage_limit		= ext4_readpage_limit,
> +	.check_hole		= fsverity_check_hole,
>  };
>  #endif /* CONFIG_FS_VERITY */
>  
> diff --git a/include/linux/fsverity.h b/include/linux/fsverity.h
> index fc8113acbbfe..8bc28b07d550 100644
> --- a/include/linux/fsverity.h
> +++ b/include/linux/fsverity.h
> @@ -20,6 +20,7 @@ struct fsverity_operations {
>  	struct page *(*read_metadata_page)(struct inode *inode, pgoff_t index);
>  	bool (*verity_required)(struct inode *inode, pgoff_t index);
>  	loff_t (*readpage_limit)(struct inode *inode);
> +	bool (*check_hole)(struct inode *inode, struct page *page);
>  };
>  
>  #ifdef CONFIG_FS_VERITY
> -- 
> 2.19.1
> 
