From: Kinglong Mee <kinglongmee@gmail.com>
Subject: Re: [PATCH 1/3] f2fs: fix a memleak issue
Date: Mon, 27 Feb 2017 21:52:47 +0800
Message-ID: <072cd19e-773a-af22-01bd-84d219b670c3@gmail.com>
References: <20170227130259.19987-1-houpengyang@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <kinglongmee@gmail.com>) id 1ciLje-0003Ji-5Z
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 27 Feb 2017 13:53:06 +0000
Received: from mail-it0-f68.google.com ([209.85.214.68])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1ciLjc-0003Gc-0j
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 27 Feb 2017 13:53:06 +0000
Received: by mail-it0-f68.google.com with SMTP id 68so2333747itg.0
	for <linux-f2fs-devel@lists.sourceforge.net>;
	Mon, 27 Feb 2017 05:53:04 -0800 (PST)
In-Reply-To: <20170227130259.19987-1-houpengyang@huawei.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Hou Pengyang <houpengyang@huawei.com>
Cc: jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net

On 2/27/2017 21:02, Hou Pengyang wrote:
> [fix: ae75f0ca76 f2fs: introduce free nid bitmap]
> Signed-off-by: Hou Pengyang <houpengyang@huawei.com>
> ---
>  fs/f2fs/node.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
> index 6d43095..353c01d 100644
> --- a/fs/f2fs/node.c
> +++ b/fs/f2fs/node.c
> @@ -2650,8 +2650,11 @@ int init_free_nid_cache(struct f2fs_sb_info *sbi)
>  
>  	nm_i->nat_block_bitmap = f2fs_kvzalloc(nm_i->nat_blocks / 8,
>  								GFP_KERNEL);
> -	if (!nm_i->nat_block_bitmap)
> +	if (!nm_i->nat_block_bitmap) {
> +		kvfree(nm_i->free_nid_bitmap);
>  		return -ENOMEM;
> +	}
> +
>  	return 0;
>  }

If building node manager fail, destroy_node_manager will be called,
I think there isn't any memory leak exist, right?

        err = build_node_manager(sbi);
        if (err) {
                f2fs_msg(sb, KERN_ERR,
                        "Failed to initialize F2FS node manager");
                goto free_nm;
        }


thanks,
Kinglong Mee

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, SlashDot.org! http://sdm.link/slashdot
