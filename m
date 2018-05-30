From: Chao Yu <chao@kernel.org>
Subject: Re: [PATCH] f2fs-tools: do not ignore *.rej in git
Date: Wed, 30 May 2018 22:34:08 +0800
Message-ID: <1ace47d8-14ac-152a-fbcc-83a8cbe793f1@kernel.org>
References: <1527664249-147982-1-git-send-email-yunlong.song@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1527664249-147982-1-git-send-email-yunlong.song@huawei.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Yunlong Song <yunlong.song@huawei.com>, jaegeuk@kernel.org, yuchao0@huawei.com, yunlong.song@icloud.com
Cc: miaoxie@huawei.com, bintian.wang@huawei.com, shengyong1@huawei.com, heyunlei@huawei.com, linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

On 2018/5/30 15:10, Yunlong Song wrote:
> When using git apply --reject to resolve the conflicts, we should better
> see all the *.rej clear, or we will miss merging some *.rej patches.
> 
> Signed-off-by: Yunlong Song <yunlong.song@huawei.com>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,
