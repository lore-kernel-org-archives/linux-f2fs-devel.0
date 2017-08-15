From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH] f2fs: remove unused function overprovision_sections
Date: Tue, 15 Aug 2017 20:36:45 +0800
Message-ID: <2983d28f-abfd-1b76-82c7-0c39a2d14e87@huawei.com>
References: <1502700763-73036-1-git-send-email-yunlong.song@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1502700763-73036-1-git-send-email-yunlong.song@huawei.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Yunlong Song <yunlong.song@huawei.com>, jaegeuk@kernel.org, chao@kernel.org, yunlong.song@icloud.com
Cc: miaoxie@huawei.com, bintian.wang@huawei.com, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

On 2017/8/14 16:52, Yunlong Song wrote:
> Signed-off-by: Yunlong Song <yunlong.song@huawei.com>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

> ---
>  fs/f2fs/segment.h | 5 -----
>  1 file changed, 5 deletions(-)
> 
> diff --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h
> index 7f700e5..b9b4f85 100644
> --- a/fs/f2fs/segment.h
> +++ b/fs/f2fs/segment.h
> @@ -492,11 +492,6 @@ static inline int overprovision_segments(struct f2fs_sb_info *sbi)
>  	return SM_I(sbi)->ovp_segments;
>  }
>  
> -static inline int overprovision_sections(struct f2fs_sb_info *sbi)
> -{
> -	return GET_SEC_FROM_SEG(sbi, (unsigned int)overprovision_segments(sbi));
> -}
> -
>  static inline int reserved_sections(struct f2fs_sb_info *sbi)
>  {
>  	return GET_SEC_FROM_SEG(sbi, (unsigned int)reserved_segments(sbi));
> 
