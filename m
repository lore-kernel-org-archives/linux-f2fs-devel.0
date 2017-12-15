From: Sheng Yong <shengyong1@huawei.com>
Subject: Re: [PATCH] fsck.f2fs: check nid range before use to avoid
 segmentation fault
Date: Fri, 15 Dec 2017 18:06:58 +0800
Message-ID: <50f9c7a6-1438-e136-271d-2b9427b9da00@huawei.com>
References: <1513319174-114303-1-git-send-email-yunlong.song@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-Reply-To: <1513319174-114303-1-git-send-email-yunlong.song@huawei.com>
Content-Language: en-US
Sender: linux-fsdevel-owner@vger.kernel.org
To: Yunlong Song <yunlong.song@huawei.com>, jaegeuk@kernel.org, chao@kernel.org, yuchao0@huawei.com, yunlong.song@icloud.com
Cc: miaoxie@huawei.com, bintian.wang@huawei.com, heyunlei@huawei.com, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net



On 2017/12/15 14:26, Yunlong Song wrote:
> Signed-off-by: Yunlong Song <yunlong.song@huawei.com>
> ---
>   fsck/fsck.c | 11 ++++++++++-
>   1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/fsck/fsck.c b/fsck/fsck.c
> index 11b8b0b..2212aa3 100644
> --- a/fsck/fsck.c
> +++ b/fsck/fsck.c
> @@ -14,6 +14,15 @@
>   char *tree_mark;
>   uint32_t tree_mark_size = 256;
>   
> +static inline int check_nid_range(struct f2fs_sb_info *sbi, nid_t nid)
> +{
> +    if (nid < F2FS_ROOT_INO(sbi))
> +        return -EINVAL;
> +    if (nid >= NM_I(sbi)->max_nid)
> +        return -EINVAL;
> +    return 0;
> +}
> +
Hi Yunlong,
I think you could use IS_VALID_NID() instead of check_nid_range. Maybe we could
add the check 'if (nid < F2FS_ROOT_INO(sbi))' to IS_VALID_NID().

thanks,
Sheng
>   int f2fs_set_main_bitmap(struct f2fs_sb_info *sbi, u32 blk, int type)
>   {
>   	struct f2fs_fsck *fsck = F2FS_FSCK(sbi);
> @@ -740,7 +749,7 @@ void fsck_chk_inode_blk(struct f2fs_sb_info *sbi, u32 nid,
>   	for (idx = 0; idx < 5; idx++) {
>   		u32 nid = le32_to_cpu(node_blk->i.i_nid[idx]);
>   
> -		if (nid != 0) {
> +		if (nid != 0 && !check_nid_range(sbi, nid)) {
>   			struct node_info ni;
>   
>   			get_node_info(sbi, nid, &ni);
> 
