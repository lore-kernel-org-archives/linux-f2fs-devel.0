From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH v2] f2fs: no need to initialize zero value for
 GFP_F2FS_ZERO
Date: Thu, 22 Mar 2018 10:23:52 +0800
Message-ID: <927273dc-ed76-5127-6175-02364952c36f@huawei.com>
References: <1521635131-137071-1-git-send-email-yunlong.song@huawei.com>
 <1521684520-142131-1-git-send-email-yunlong.song@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1521684520-142131-1-git-send-email-yunlong.song@huawei.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Yunlong Song <yunlong.song@huawei.com>, jaegeuk@kernel.org, chao@kernel.org, yunlong.song@icloud.com
Cc: miaoxie@huawei.com, bintian.wang@huawei.com, shengyong1@huawei.com, heyunlei@huawei.com, linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

On 2018/3/22 10:08, Yunlong Song wrote:
> Since f2fs_inode_info is allocated with flag GFP_F2FS_ZERO, so we do not
> need to initialize zero value for its member any more.
> 
> Signed-off-by: Yunlong Song <yunlong.song@huawei.com>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,
