From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH v2] f2fs: check segment type in __f2fs_replace_block
Date: Thu, 4 Jan 2018 13:56:33 +0800
Message-ID: <8f04c997-cfed-1ee2-9b10-37955ce15f9e@huawei.com>
References: <1514619768-134531-1-git-send-email-yunlong.song@huawei.com>
 <1515037705-23984-1-git-send-email-yunlong.song@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1515037705-23984-1-git-send-email-yunlong.song@huawei.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Yunlong Song <yunlong.song@huawei.com>, jaegeuk@kernel.org, chao@kernel.org, yunlong.song@icloud.com
Cc: miaoxie@huawei.com, bintian.wang@huawei.com, shengyong1@huawei.com, heyunlei@huawei.com, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

Please add simple description here to explain why we need to add this, even
though this change is very simple.

On 2018/1/4 11:48, Yunlong Song wrote:
> Signed-off-by: Yunlong Song <yunlong.song@huawei.com>
> ---
>  fs/f2fs/segment.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> index 890d483..e3bbabf 100644
> --- a/fs/f2fs/segment.c
> +++ b/fs/f2fs/segment.c
> @@ -2719,6 +2719,8 @@ void __f2fs_replace_block(struct f2fs_sb_info *sbi, struct f2fs_summary *sum,
>  	se = get_seg_entry(sbi, segno);
>  	type = se->type;
>  
> +	f2fs_bug_on(sbi, se->valid_blocks && IS_NODESEG(type));
> +
>  	down_write(&SM_I(sbi)->curseg_lock);
>  
>  	if (!recover_curseg) {
> 
