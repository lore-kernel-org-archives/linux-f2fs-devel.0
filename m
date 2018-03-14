From: Chao Yu <chao@kernel.org>
Subject: Re: [f2fs-dev] [PATCH] f2fs: align memory boundary for bitops
Date: Wed, 14 Mar 2018 21:08:42 +0800
Message-ID: <b370fdca-e460-7f62-3538-e43373d7274e@kernel.org>
References: <20180310020348.69129-1-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180310020348.69129-1-jaegeuk@kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

On 2018/3/10 10:03, Jaegeuk Kim wrote:
> For example, in arm64, free_nid_bitmap should be aligned to word size in order
> to use bit operations.
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,
