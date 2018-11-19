From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH 2/2] f2fs: Set CP_ERROR_FLAG in case of
 inconsistent node page entries
Date: Mon, 19 Nov 2018 15:15:14 +0800
Message-ID: <b3414466-789f-7b2e-8ef0-60288210a33b@huawei.com>
References: <1542607377-25446-1-git-send-email-riteshh@codeaurora.org>
 <1542607377-25446-2-git-send-email-riteshh@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <yuchao0@huawei.com>) id 1gOdmM-0000Zq-Ao
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 19 Nov 2018 07:15:30 +0000
Received: from szxga06-in.huawei.com ([45.249.212.32] helo=huawei.com)
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1gOdmK-00DjRN-CB
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 19 Nov 2018 07:15:30 +0000
In-Reply-To: <1542607377-25446-2-git-send-email-riteshh@codeaurora.org>
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
To: Ritesh Harjani <riteshh@codeaurora.org>, linux-f2fs-devel@lists.sourceforge.net, jaegeuk@kernel.org

Hi Ritesh,

On 2018/11/19 14:02, Ritesh Harjani wrote:
> In case of any inconsistent node page entries found,
> call f2fs_stop_checkpoint to further avoid any corruption.
> 
> Signed-off-by: Ritesh Harjani <riteshh@codeaurora.org>
> ---
>  fs/f2fs/node.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
> index d338740..29b56ef 100644
> --- a/fs/f2fs/node.c
> +++ b/fs/f2fs/node.c
> @@ -1369,6 +1369,7 @@ static struct page *__get_node_page(struct f2fs_sb_info *sbi, pgoff_t nid,
>  			ofs_of_node(page), cpver_of_node(page),
>  			next_blkaddr_of_node(page));
>  		err = -EINVAL;
> +		f2fs_stop_checkpoint(sbi, false);

I think it needs more information to proof filesystem-level metadata is
corrupted, otherwise it only indicate that current node is corrupted...

I guess that we can verify ni.blk_addr validity in SIT to check consistent
between NAT and SIT, then we can decide to stop checkpoint?

BTW, I suspect there is still app/system program bypass filesystem and use
block layer interface to operate data partition directly, e.g. fiemap/bmap
+ write blkaddr, since block migration during f2fs GC, such operation
should be avoided. :)

Thanks,

>  out_err:
>  		ClearPageUptodate(page);
>  		f2fs_put_page(page, 1);
> 
