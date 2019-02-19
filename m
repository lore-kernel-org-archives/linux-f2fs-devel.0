From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH] f2fs: silence VM_WARN_ON_ONCE in mempool_alloc
Date: Tue, 19 Feb 2019 11:37:09 +0800
Message-ID: <d4f8e2e1-bb1e-1913-80b2-2b60ab09f3e8@huawei.com>
References: <20190219023152.37863-1-gaoxiang25@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190219023152.37863-1-gaoxiang25@huawei.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Gao Xiang <gaoxiang25@huawei.com>, Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, miaoxie@huawei.com
List-Id: linux-f2fs-devel.lists.sourceforge.net

On 2019/2/19 10:31, Gao Xiang wrote:
> Note that __GFP_ZERO is not supported for mempool_alloc,
> which also documented in the mempool_alloc comments.
> 
> Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,
