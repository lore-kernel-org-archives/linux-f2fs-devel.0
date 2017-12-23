From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH v2] fsck.f2fs: check nid range before use to
 avoid segmentation fault
Date: Sat, 23 Dec 2017 11:14:07 +0800
Message-ID: <e912dbdb-3614-cee0-c7f7-2b5f6344466f@huawei.com>
References: <1513319174-114303-1-git-send-email-yunlong.song@huawei.com>
 <1513598025-160615-1-git-send-email-yunlong.song@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.194]
 helo=mx.sourceforge.net)
 by sfs-ml-2.v29.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 (envelope-from <yuchao0@huawei.com>) id 1eSaGV-0003Yn-Rg
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 23 Dec 2017 03:14:23 +0000
Received: from [45.249.212.35] (helo=huawei.com)
 by sfi-mx-4.v28.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 id 1eSaGU-0000nA-Bi
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 23 Dec 2017 03:14:23 +0000
In-Reply-To: <1513598025-160615-1-git-send-email-yunlong.song@huawei.com>
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
To: Yunlong Song <yunlong.song@huawei.com>, jaegeuk@kernel.org, chao@kernel.org, yunlong.song@icloud.com
Cc: shengyong1@huawei.com, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, heyunlei@huawei.com, linux-fsdevel@vger.kernel.org, miaoxie@huawei.com

On 2017/12/18 19:53, Yunlong Song wrote:
> Signed-off-by: Yunlong Song <yunlong.song@huawei.com>

How about introducing IS_AVAILABLE_NID as below, and use it instead?

#define IS_AVAILABLE_NID(sbi, nid)	(IS_VALID_NID(sbi, nid) && (nid >= root_ino))

Thanks,

> ---
>  fsck/fsck.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fsck/fsck.c b/fsck/fsck.c
> index 11b8b0b..faf0663 100644
> --- a/fsck/fsck.c
> +++ b/fsck/fsck.c
> @@ -740,7 +740,7 @@ void fsck_chk_inode_blk(struct f2fs_sb_info *sbi, u32 nid,
>  	for (idx = 0; idx < 5; idx++) {
>  		u32 nid = le32_to_cpu(node_blk->i.i_nid[idx]);
>  
> -		if (nid != 0) {
> +		if (nid != 0 && IS_VALID_NID(sbi, nid)) {
>  			struct node_info ni;
>  
>  			get_node_info(sbi, nid, &ni);
> 


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
