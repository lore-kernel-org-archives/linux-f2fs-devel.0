From: Chao Yu <chao@kernel.org>
Subject: Re: [PATCH 2/2] f2fs: recover some i_inline flags
Date: Sat, 20 Jan 2018 17:33:15 +0800
Message-ID: <d12c6d69-7141-d667-279e-323e4fce39af@kernel.org>
References: <20180120042643.20717-1-jaegeuk@kernel.org>
 <20180120042643.20717-2-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.194]
 helo=mx.sourceforge.net)
 by sfs-ml-2.v29.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 (envelope-from <chao@kernel.org>) id 1ecpWf-0003dE-C0
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 20 Jan 2018 09:33:25 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-4.v28.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 id 1ecpWe-0001o1-IS
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 20 Jan 2018 09:33:25 +0000
In-Reply-To: <20180120042643.20717-2-jaegeuk@kernel.org>
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
To: Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

On 2018/1/20 12:26, Jaegeuk Kim wrote:
> This fixes lost i_inline flags during roll-forward.
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> ---
>  fs/f2fs/recovery.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/fs/f2fs/recovery.c b/fs/f2fs/recovery.c
> index cbeef73bc4dd..2354f1e05e19 100644
> --- a/fs/f2fs/recovery.c
> +++ b/fs/f2fs/recovery.c
> @@ -211,6 +211,15 @@ static void recover_inode(struct inode *inode, struct page *page)
>  
>  	F2FS_I(inode)->i_advise = raw->i_advise;

How about adding recover_inline_flags() including below changes?

>  
> +	if (raw->i_inline & F2FS_PIN_FILE)
> +		set_inode_flag(inode, FI_PIN_FILE);

else
	clear_inode_flag(inode, FI_PIN_FILE); ?

Thanks,

> +	if (raw->i_inline & F2FS_DATA_EXIST)
> +		set_inode_flag(inode, FI_DATA_EXIST);
> +	else
> +		clear_inode_flag(inode, FI_DATA_EXIST);
> +	if (!(raw->i_inline & F2FS_INLINE_DOTS))
> +		clear_inode_flag(inode, FI_INLINE_DOTS);
> +
>  	if (file_enc_name(inode))
>  		name = "<encrypted>";
>  	else
> 

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
