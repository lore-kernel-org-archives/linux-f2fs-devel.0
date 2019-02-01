From: Chao Yu <chao@kernel.org>
Subject: Re: [f2fs-dev] [PATCH 1/7] f2fs: run discard jobs when put_super
Date: Fri, 1 Feb 2019 22:12:14 +0800
Message-ID: <9a530df6-38f2-160f-bb6f-8302ab8513bc@kernel.org>
References: <20190128234717.77225-1-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190128234717.77225-1-jaegeuk@kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

On 2019-1-29 7:47, Jaegeuk Kim wrote:
> When we umount f2fs, we need to avoid long delay due to discard commands, which
> is actually taking tens of seconds, if storage is very slow on UNMAP. So, this
> patch introduces timeout-based work on it.
> 
> By default, let me give 5 seconds for discard.
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,
