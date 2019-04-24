From: Chao Yu <chao@kernel.org>
Subject: Re: [f2fs-dev] [PATCH] f2fs-tools:fix memory leak in write dquot
Date: Wed, 24 Apr 2019 23:06:52 +0800
Message-ID: <7a25bd27-345d-57e3-3252-7c9e2f218d8f@kernel.org>
References: <1556088462-21693-1-git-send-email-wangxiaojun11@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1556088462-21693-1-git-send-email-wangxiaojun11@huawei.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Xiaojun Wang <wangxiaojun11@huawei.com>, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

On 2019-4-24 14:47, Xiaojun Wang wrote:
> this patch free ddquot in qtree_write_dquot to avoid memory leak
> 
> Signed-off-by: Xiaojun Wang <wangxiaojun11@huawei.com>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,
