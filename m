From: heyunlei <heyunlei@huawei.com>
Subject: =?gb2312?b?tPC4tDogW1BBVENIXSBmMmZzOiBmaXggYSBpbmZp?=
 =?gb2312?b?bml0ZSBsb29wIGluIHdyaXR0aW5nIGNoZWNrcG9pbnQ=?=
Date: Fri, 1 Sep 2017 04:19:27 +0000
Message-ID: <42B685BFA705F94C860C6DD0752F05654802B6F4@DGGEMA503-MBX.china.huawei.com>
References: <1503720935-23349-1-git-send-email-heyunlei@huawei.com>
 <2786ac13-0e33-82ad-6362-51944c2f8aa4@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
 helo=mx.sourceforge.net)
 by sfs-ml-1.v29.ch3.sourceforge.com with esmtps (TLSv1:DHE-RSA-AES256-SHA:256)
 (Exim 4.89) (envelope-from <heyunlei@huawei.com>) id 1dndQs-0003jr-5s
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 01 Sep 2017 04:19:50 +0000
Received: from szxga01-in.huawei.com ([45.249.212.187])
 by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
 (Exim 4.76) id 1dndQq-0006Eq-5d
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 01 Sep 2017 04:19:50 +0000
In-Reply-To: <2786ac13-0e33-82ad-6362-51944c2f8aa4@huawei.com>
Content-Language: zh-CN
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: "Yuchao (T)" <yuchao0@huawei.com>, "jaegeuk@kernel.org" <jaegeuk@kernel.org>, "linux-f2fs-devel@lists.sourceforge.net" <linux-f2fs-devel@lists.sourceforge.net>
Cc: "Wangkai (Morgan, Euler)" <morgan.wang@huawei.com>


Hi Yunlei,

On 2017/8/26 12:15, Yunlei He wrote:
> The loop reason is DIRTY IMETA always equal to 1:
> 
> Thread A:
> -write_checkpoint
>    -block_operations
>        -f2fs_sync_inode_meta
>            -igrab       <--- here igrab return NULL
> 
> Thread B:
> -f2fs_evict_inode
>    -remove_inode_page
>        -truncate_xattr_node
>           -__get_node_page
>              -read_node_page   <---- here return -ENOENT
> 
> This patch walk around this cause.

It needs to figure out root cause that why xattr node entry is invalid.

How about this modification:

diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
index b4c401d..62de5f7 100644
--- a/fs/f2fs/inode.c
+++ b/fs/f2fs/inode.c
@@ -497,7 +497,7 @@ void f2fs_evict_inode(struct inode *inode)
                f2fs_lock_op(sbi);
                err = remove_inode_page(inode);
                f2fs_unlock_op(sbi);
-               if (err == -ENOENT)
+               if (err == -ENOENT && is_bad_inode(inode))
                        err = 0;
        }

Thanks

> 
> Signed-off-by: Yunlei He <heyunlei@huawei.com>
> ---
>  fs/f2fs/node.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c index 2654c91..ec7a0e0 
> 100644
> --- a/fs/f2fs/node.c
> +++ b/fs/f2fs/node.c
> @@ -973,8 +973,9 @@ int truncate_xattr_node(struct inode *inode, struct page *page)
>  		return 0;
>  
>  	npage = get_node_page(sbi, nid);
> -	if (IS_ERR(npage))
> +	if (IS_ERR(npage) && PTR_ERR(npage) != -ENOENT) {
>  		return PTR_ERR(npage);
> +	}
>  
>  	f2fs_i_xnid_write(inode, 0);
>  
> 

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
