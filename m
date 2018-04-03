From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH] f2fs: make assignment of t->dentry_bitmap more readable
Date: Tue, 3 Apr 2018 10:42:11 +0800
Message-ID: <b68f7f6c-0a3b-f1f2-41a0-2b03c7681944@huawei.com>
References: <1522671740-92824-1-git-send-email-yunlong.song@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1522671740-92824-1-git-send-email-yunlong.song@huawei.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Yunlong Song <yunlong.song@huawei.com>, jaegeuk@kernel.org, chao@kernel.org, yunlong.song@icloud.com
Cc: miaoxie@huawei.com, bintian.wang@huawei.com, shengyong1@huawei.com, heyunlei@huawei.com, linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

On 2018/4/2 20:22, Yunlong Song wrote:
> In make_dentry_ptr_block, it is confused with "&" for t->dentry_bitmap
> but without "&" for t->dentry, so delete "&" to make code more readable.
> 
> Signed-off-by: Yunlong Song <yunlong.song@huawei.com>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,
