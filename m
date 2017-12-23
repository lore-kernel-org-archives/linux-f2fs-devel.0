From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH v4] fsck.f2fs: check and fix i_namelen to avoid double
 free
Date: Sat, 23 Dec 2017 11:05:50 +0800
Message-ID: <cbf1ef8f-9347-3a4c-bac7-62173544068f@huawei.com>
References: <1513319130-114230-1-git-send-email-yunlong.song@huawei.com>
 <1513603527-163036-1-git-send-email-yunlong.song@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1513603527-163036-1-git-send-email-yunlong.song@huawei.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Yunlong Song <yunlong.song@huawei.com>, jaegeuk@kernel.org, chao@kernel.org, yunlong.song@icloud.com
Cc: miaoxie@huawei.com, bintian.wang@huawei.com, shengyong1@huawei.com, heyunlei@huawei.com, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

On 2017/12/18 21:25, Yunlong Song wrote:
> v1 -> v2: use child_info to pass dentry namelen
> v2 -> v3: check child != NULL to include the F2FS_FT_ORPHAN file type
> v3 -> v4: fix the i_namelen problem of dump.f2fs、

There is no commit log, so what do you mean about "avoid double free"?

Other than that, looks good to me.

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,
