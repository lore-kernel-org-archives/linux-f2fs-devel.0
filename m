From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH 1/1] f2fs: release locks before return in
 f2fs_ioc_gc_range()
Date: Fri, 16 Mar 2018 16:21:23 +0800
Message-ID: <63c81dbc-e561-aa5a-a375-ae14bca5f4ac@huawei.com>
References: <20180313114250.29211-1-sunqiuyang@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180313114250.29211-1-sunqiuyang@huawei.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: sunqiuyang <sunqiuyang@huawei.com>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

On 2018/3/13 19:42, sunqiuyang wrote:
> From: Qiuyang Sun <sunqiuyang@huawei.com>
> 
> Currently, we will leave the kernel with locks still held when the gc_range
> is invalid. This patch fixes the bug.
> 
> Signed-off-by: Qiuyang Sun <sunqiuyang@huawei.com>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,
