From: Chao Yu <chao@kernel.org>
Subject: Re: [f2fs-dev] [PATCH] f2fs: avoid the global name 'fault_name'
Date: Sun, 1 Jul 2018 10:23:12 +0800
Message-ID: <5c3189ac-8dcf-391c-df0a-01f3a7bb4363@kernel.org>
References: <1530374223-130895-1-git-send-email-gaoxiang25@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1530374223-130895-1-git-send-email-gaoxiang25@huawei.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Gao Xiang <gaoxiang25@huawei.com>, Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

On 2018/6/30 23:57, Gao Xiang wrote:
> Non-prefix global name 'fault_name' will pollute global
> namespace, fix it.
> 
> Refer to:
> https://lists.01.org/pipermail/kbuild-all/2018-June/049660.html
> 
> To: Jaegeuk Kim <jaegeuk@kernel.org>
> To: Chao Yu <yuchao0@huawei.com>
> Cc: linux-f2fs-devel@lists.sourceforge.net
> Cc: linux-kernel@vger.kernel.org
> Reported-by: kbuild test robot <lkp@intel.com>
> Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,
