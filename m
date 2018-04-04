From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH] f2fs: remove unmatched zero_user_segment when convert
 inline dentry
Date: Wed, 4 Apr 2018 09:16:39 +0800
Message-ID: <8c280631-71a6-4432-898e-1662b2c6c8a7@huawei.com>
References: <1522755761-131554-1-git-send-email-yunlong.song@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1522755761-131554-1-git-send-email-yunlong.song@huawei.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Yunlong Song <yunlong.song@huawei.com>, jaegeuk@kernel.org, chao@kernel.org, yunlong.song@icloud.com
Cc: miaoxie@huawei.com, bintian.wang@huawei.com, shengyong1@huawei.com, heyunlei@huawei.com, linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

On 2018/4/3 19:42, Yunlong Song wrote:
> Since the layout of regular dentry block is different from inline dentry
> block, zero_user_segment starting from MAX_INLINE_DATA(dir) is not
> correct for regular dentry block, besides, bitmap is already copied and
> used, so there is no necessary to zero page at all, so just remove the
> zero_user_segment is OK.
> 
> Signed-off-by: Yunlong Song <yunlong.song@huawei.com>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,
